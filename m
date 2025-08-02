Return-Path: <stable+bounces-165791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27146B18A9A
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 05:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3147E7AFEB1
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 03:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA481607A4;
	Sat,  2 Aug 2025 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yPITqYAp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6D2E371E
	for <stable@vger.kernel.org>; Sat,  2 Aug 2025 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754106805; cv=none; b=BZH8zh/v6p+E7zWtwNvTjcuJEHr8XZ/G6w5EZ0LgTR2euY96PvTveg0t1g2setGUzx5t0Mfck366B3ipGgaxMg2dUXeaA+5LOGOSTVHrfpKrNqI5PTY+jfV0MT7NHyIW+0HS/SbcUGAvMSxtJwSsXfLnLf/2BKCJq8lXch0rKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754106805; c=relaxed/simple;
	bh=xNpaAbYMIRCCf6qEC+M9c6KCuXluSMu/QNeteQuQbcA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ji92I4bIqjRaWF8X24Nstv+KEoM6GABgnpap1uWjgSEY/FR4tddHrfYH2dbxlxgAEf3PxaXf3uEIGX80TvggsmPzxqedn5ZMTGFnueNv54UVxs+58QcEvVVyZpw7ZyPaVUxIGDmfAj1Cyi3WJhGtZb3r1UVERxsIS5Vdho3jPSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yPITqYAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91322C4CEEF;
	Sat,  2 Aug 2025 03:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754106804;
	bh=xNpaAbYMIRCCf6qEC+M9c6KCuXluSMu/QNeteQuQbcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yPITqYApklWsg7GXdNRWSYrT42/vqoyceqxpRWdnMClXlwluh0UGWLrcLU+kR3sB7
	 rIlPtIibUq0cN4oBa30v+x2sfpyNUz4Dfy4c6m8LvXLq7O9M4cySB14QVonTSqiofo
	 S1K/PMv7uS3ObPup2jZFrYazE+QhrFAs5AIBnReE=
Date: Fri, 1 Aug 2025 20:53:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <llong@redhat.com>
Cc: Gu Bowen <gubowen5@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, stable@vger.kernel.org, linux-mm@kvack.org, Lu
 Jialin <lujialin4@huawei.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Message-Id: <20250801205323.70c2fabe5f64d2fb7c64fd94@linux-foundation.org>
In-Reply-To: <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
References: <20250730094914.566582-1-gubowen5@huawei.com>
	<20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
	<5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Aug 2025 23:09:31 -0400 Waiman Long <llong@redhat.com> wrote:

> > Thanks.
> >
> > There have been a few kmemleak locking fixes lately.
> >
> > I believe this fix is independent from the previous ones:
> >
> > https://lkml.kernel.org/r/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org
> > https://lkml.kernel.org/r/20250728190248.605750-1-longman@redhat.com
> >
> > But can people please check?
> 
> I believe that __printk_safe_enter()/_printk_safe_exit() are for printk 
> internal use only. The proper API to use should be 
> printk_deferred_enter()/printk_deferred_exit() if we want to deferred 
> the printing. Since kmemleak_lock will have been acquired with irq 
> disabled, it meets the condition that printk_deferred_*() APIs can be used.

Gotcha, thanks.

kmemleak;c:__lookup_object() has a lot of callers.  I hope you're
correct that all have local irqs enabled, but I'll ask Gu to verify
that then please send along a new patch which uses
printk_deferred_enter()?


