Return-Path: <stable+bounces-223685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCH+GejlrmmsJwIAu9opvQ
	(envelope-from <stable+bounces-223685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:23:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19DC23B92F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42EE431F62E6
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A93D9044;
	Mon,  9 Mar 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="igBATUz1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6153D9040
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069329; cv=none; b=A0gZW4uzTvehdRWLiCBRoHNBwrHynTcdZHr6RPPv99FsY0tjVgaa/OM8xJrMAZWPlcObtefQXuXHJsA1f9Tir6cQg2XK1JtV0DrJTOo7eMJIFPi4pqCCaZi3WxpTkQ5zv1N8ggokWV4dtA+7zkLjQQ8nlVDAVoWXSC97rJ7JNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069329; c=relaxed/simple;
	bh=RSzDCCW5LiM+OcTL0v35NkCPW7E2tVuIs/8aUuxyKUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je8n+y7DdzZFCWuis1eZffKu757cRPDNvz1PsDGOEWXJppd7WCTCBNUVmYptzk9IZrZ+wRccRl3dnJwvvTVsKIQ8cmpPY9hUII/j8a8WBEZQECS+3WbZ+4SbQYyLayHQ6afNJNmZZNel/CnfRvkbLMyb/Z6ppL/DuTJ88iQgquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=igBATUz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181CCC2BC86;
	Mon,  9 Mar 2026 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773069329;
	bh=RSzDCCW5LiM+OcTL0v35NkCPW7E2tVuIs/8aUuxyKUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igBATUz1p4W/OURIWYY2D845KZkmIfm+EyflGycp2GLoy2u9sS/aqnTzvR6fCVOM0
	 927Dq7H3OvS7y0OHbVlCN8nSOL5Xw6ohYXyMew8aydPzZW6kvF/d2VTi3tmrVdp5zS
	 3pst4Dmj9fRYU0Uq97pmqhurY2E4p0qAx6A3KHII=
Date: Mon, 9 Mar 2026 16:15:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathaniel Filardo <nwfilardo@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: 6.12 build failure for non-SMP systems
Message-ID: <2026030904-entering-nuptials-d410@gregkh>
References: <CAKsvP2YbMv+iiVb7NWSKmK_Ugi0Wgt78m1qtdDg9OkNVdhcEcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKsvP2YbMv+iiVb7NWSKmK_Ugi0Wgt78m1qtdDg9OkNVdhcEcQ@mail.gmail.com>
X-Rspamd-Queue-Id: E19DC23B92F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223685-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.207];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 02:04:49PM -0500, Nathaniel Filardo wrote:
> Hi stable@
> 
> The commit https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e61f636cc31042b717a46f6937a2dfaf21f45c91,
> first included in 6.12.64, does not properly guard its new references
> to `stop_sched_class` under `CONFIG_SMP`, leading to build failures
> like the following, even with the significantly newer 6.12.74 release:
> 
> > linux-armv5tel-unknown-linux-gnueabi>   LD      .tmp_vmlinux1
> linux-armv5tel-unknown-linux-gnueabi>
> /nix/store/cn2gkcaa5kfgzjah31c0qlifv9y4yqg5-armv5tel-unknown-linux-gnueabi-binutils-2.44/bin/armv5tel-unknown-linux-gnueabi-ld:
> kernel/sched/build_policy.o: in function `scx_ops_disable_workfn':
> > linux-armv5tel-unknown-linux-gnueabi> /build/linux-6.12.74/build/../kernel/sched/ext.c:4746:(.text+0x704c): undefined reference to `stop_sched_class'
> > linux-armv5tel-unknown-linux-gnueabi> /nix/store/cn2gkcaa5kfgzjah31c0qlifv9y4yqg5-armv5tel-unknown-linux-gnueabi-binutils-2.44/bin/armv5tel-unknown-linux-gnueabi-ld: kernel/sched/build_policy.o: in function `atomic_set':
> > linux-armv5tel-unknown-linux-gnueabi> /build/linux-6.12.74/build/../include/linux/atomic/atomic-instrumented.h:69:(.text+0x11c6c): undefined reference to `stop_sched_class'
> 
> A possible fix is simply to add the requisite guard, thus:
> diff --git a/kernel/sched/ext.c.orig b/kernel/sched/ext.c
> index 9f03255..9a3e5b2 100644
> --- a/kernel/sched/ext.c.orig
> +++ b/kernel/sched/ext.c
> @@ -1059,8 +1059,10 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
> 
>  static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
>  {
> +#ifdef CONFIG_SMP
>   if (p->sched_class == &stop_sched_class)
>   return &stop_sched_class;
> +#endif
> 
>   return __setscheduler_class(p->policy, p->prio);
>  }
> 
> But it may also be desirable to backport
> https://github.com/torvalds/linux/commit/cac5cefbade90ff0bb0b393d301fa3b5234cf056
> from mainline, which removes much of the distinction between UP and
> SMP schedulers.

That patch doesn't backport cleanly, so can you just submit this as a
fixup for now in a format that we can apply it in?

thanks,

greg k-h

