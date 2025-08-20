Return-Path: <stable+bounces-171891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFEB2DA78
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5689417D182
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B62836AF;
	Wed, 20 Aug 2025 11:02:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705C4414
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687759; cv=none; b=J9tLYteDWaswymWy+Os6xEgP+uQSwoinp1rsjtTgD4NiO9YvjccWMfekFMQeR7zMF6JJRSKtnB/YGkwMjvlZxLMcj7vkk+oi71e3APc+uo/AaMhygpl8zlipoeVNZ8CfhWhOHCXI+k7A3/c2/5PQE7iNkOfgOF5lyV6CjmSJK+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687759; c=relaxed/simple;
	bh=KZsw8NtZjU7pHNgOGH1/IKvm67LHoyWfuTfGDXmPqeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofroCGE/nFNO9a6M1rQC5RUwSCE6p+cr8v3bKj8/Q/Vo8Gf+B+hSRcwyXVGsytBP2WRMpGM5WPSFEwlxQTmZ9z7wx6p3A1CCuI+gmzNLS3ultUYaW84VlXvcDmW/AxNwQYLOPQsiv4jMAN+ct6l7DYo6Mkfyv2sIJ6NeBxohD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAFFC4CEEB;
	Wed, 20 Aug 2025 11:02:35 +0000 (UTC)
Date: Wed, 20 Aug 2025 12:02:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <llong@redhat.com>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, linux-mm@kvack.org,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
Message-ID: <aKWrSfLD5f1r5rg_@arm.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
 <113a8332-b35c-4d00-b8b1-21c07d133f1f@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113a8332-b35c-4d00-b8b1-21c07d133f1f@redhat.com>

On Tue, Aug 19, 2025 at 11:27:23PM -0400, Waiman Long wrote:
> On 8/18/25 5:09 AM, Gu Bowen wrote:
> > @@ -858,8 +870,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
> >   	object = __find_and_remove_object(ptr, 1, objflags);
> >   	if (!object) {
> >   #ifdef DEBUG
> > +		/*
> > +		 * Printk deferring due to the kmemleak_lock held.
> > +		 * This is done to avoid deadlock.
> > +		 */
> > +		printk_deferred_enter();
> >   		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
> >   			      ptr, size);
> > +		printk_deferred_exit();
> >   #endif
> 
> This particular warning message can be moved after unlock by adding a
> warning flag. Locking is done outside of the other two helper functions
> above, so it is easier to use printk_deferred_enter/exit() for those.

I thought about this as well but the above is under an #ifdef DEBUG so
we end up adding more lines on the unlock path (not sure which one looks
better; I'd say the above, marginally).

Another option would be to remove the #ifdef and try to identify the
call sites that trigger the warning. Last time I checked (many years
ago) they were fairly benign and decided to hide them before an #ifdef.

-- 
Catalin

