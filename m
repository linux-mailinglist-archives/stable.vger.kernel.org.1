Return-Path: <stable+bounces-211974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELvZMoocemkY2wEAu9opvQ
	(envelope-from <stable+bounces-211974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:26:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA7A2BED
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F11C4306F3DB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1B25CC40;
	Wed, 28 Jan 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl3JFNBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C618027;
	Wed, 28 Jan 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609974; cv=none; b=YPufa+tjOBolhVfa5suJa5bFfTslhvFhmEKM5gWhwHkHMA5H1y2mzNjsap9jh/TEAC8ex8Hw33gTvEFSQjRvjgG8JTsNgvU7Uyi22sLkbl9X2lAtDqJ978TkmHqpagNvLY8oG3F00q9rRvXka8+L0t1s5r6PpTXa0R6rCB3a5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609974; c=relaxed/simple;
	bh=puOqCe2WUieCczjraaPMAlsv+0nDcLD9SLGlgfsBrqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvx+pvTkByX+8FDh8cJITQJ7u2PPZwyc6Zgmm07e3APhZ/hQZ5JEFcrpAQpz4BgImelgDG99KGE0VO6jlRhW65zUb4dHD07wrRVCwCxMh0VvxkyfZ2tqDkFgm3gPCEK6/z10vjsebb3ARrbG/hTDhUapO/gaLyfzTcx9EKEn8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yl3JFNBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633D9C2BC86;
	Wed, 28 Jan 2026 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769609973;
	bh=puOqCe2WUieCczjraaPMAlsv+0nDcLD9SLGlgfsBrqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yl3JFNBiL3Ev7//2JGqs1r/TSa5y/0mgW/ehu/EGAyy1D1mtADF3y5ZKJEUddqHT4
	 MW6VjDN+VX7/MIJLYHudz57Ny+5ObrRHiUqGG8Yph099IXqQJA/6XFW/WxQNSC1W2H
	 a8L3tMvRLkroIMRGop3p86iXGh0w6Z/mkzDHQ7/Q=
Date: Wed, 28 Jan 2026 15:18:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: stable@vger.kernel.org, tj@kernel.org, arighi@nvidia.com,
	void@manifault.com, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/2] sched_ext: Don't kick CPUs running higher classes
Message-ID: <2026012842-bubbling-busily-65bd@gregkh>
References: <20260124092043.349976-1-christian.loehle@arm.com>
 <20260124092043.349976-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124092043.349976-2-christian.loehle@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211974-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BAA7A2BED
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 09:20:42AM +0000, Christian Loehle wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> commit a9c1fbbd6dadbaa38c157a07d5d11005460b86b9 upstream.
> 
> When a sched_ext scheduler tries to kick a CPU, the CPU may be running a
> higher class task. sched_ext has no control over such CPUs. A sched_ext
> scheduler couldn't have expected to get access to the CPU after kicking it
> anyway. Skip kicking when the target CPU is running a higher class.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

You did not sign off on these patches that you are forwarding on for us
to apply :(



