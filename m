Return-Path: <stable+bounces-171819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85617B2C87F
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F33563230
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E11DA4E;
	Tue, 19 Aug 2025 15:30:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C3215191
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617455; cv=none; b=BO4dnxrENlR2QJiXdCElRZM67LQJPKlr7bsvoPOx6/REwPHFeXwuPbTs8k1mXPc9lCiSjm5m3Jv9M14o154PIYObGZn4EITIGuCacBXJSnED+vwOXESn4CyHNmuCJljjwIOTRWDbI81qacGFi3oeUzmOB7CRcmrvx+mb4koOfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617455; c=relaxed/simple;
	bh=+6zpocbi5ZcXtbM/6v6OOxkpSgWLILFh9cwA4mp6aV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTWT1q0BhPc9R6rWo95dTa3tlUYR9auwVYYCW88mTke08bd4w/ZhUC9UWdPq57ujy4ZmMLPWC5fbRRnodAtUT30aoemCefSwwKbJDuWwIhZJEFOHtDBj4leHMLJO8jTjyHijldQ6pxk/Dl8OzX4CNHZLNaRfhc1joTVGQNdJoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F6C4CEF1;
	Tue, 19 Aug 2025 15:30:52 +0000 (UTC)
Date: Tue, 19 Aug 2025 16:30:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, linux-mm@kvack.org,
	Waiman Long <llong@redhat.com>, Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
Message-ID: <aKSYq17EUrXRGFPO@arm.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818090945.1003644-1-gubowen5@huawei.com>

On Mon, Aug 18, 2025 at 05:09:44PM +0800, Gu Bowen wrote:
> Our syztester report the lockdep WARNING [1], which was identified in
> stable kernel version 5.10. However, this deadlock path no longer exists
> due to the refactoring of console_lock in v6.2-rc1 [2]. Coincidentally,
> there are two types of deadlocks that we have found here. One is the ABBA
> deadlock, as mentioned above [1], and the other is the AA deadlock was
> reported by Breno [3]. The latter's deadlock issue persists.

It's better to include the lockdep warning here rather than linking to
other threads. Also since we are targeting upstream with this patch,
I don't think we should mention lockdep warnings for 5.10.

> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided. The proper API to use should be
> printk_deferred_enter()/printk_deferred_exit() [4].
> 
> [1]
> https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/
> [2]
> https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/
> [3]
> https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
> [4]
> https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
> ====================
> 
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>
> ---

I suggest you add the 5.10 mention here if you want, text after "---" is
normally stripped (well, not sure with Andrew's scripts).

Otherwise the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

