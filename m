Return-Path: <stable+bounces-235496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHMzAcL912kiVwgAu9opvQ
	(envelope-from <stable+bounces-235496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:28:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE33CF0B9
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C45AD30166DC
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE6336894;
	Thu,  9 Apr 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b="iZ5C/vUb"
X-Original-To: stable@vger.kernel.org
Received: from mail.yaina.de (yaina.de [95.216.117.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579A2FF65B;
	Thu,  9 Apr 2026 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.117.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762871; cv=none; b=bcTHa4WvDtt2mocXs6gnjj1FkJdA4kbuj4RKe1JttPuth3f+279/GXq26Iyqi06hASnS2FS9dMdLteGRBwlA+YBqM/klOFXBKpxPkhBGt9oLXXUhnVGnifsk9fMsiwX2sBGJY7B+4dkqjgClt3chhs5Ih/4cBeOFNsEeGNx7EKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762871; c=relaxed/simple;
	bh=hvKCkSYJdC+EscCNzKCE2wd2ammkeMHFsTH8yAUOmbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubBqbAI5L1Q0fAC/r+ndt5oBKM/w9VI4IromcCw8rui0cDvpQoKZUT/fDZi+zFI5+36BtcvmMG55YLOs6GMNyb/2felAU4yb7CQB57Qi/AVkzGqKpSbZALR9KdlnVj8G2zUeB51qzfWwYxtPLQ5Xx8VNqDMsjNtuSIx3OizrVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de; spf=pass smtp.mailfrom=yaina.de; dkim=pass (1024-bit key) header.d=yaina.de header.i=@yaina.de header.b=iZ5C/vUb; arc=none smtp.client-ip=95.216.117.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yaina.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yaina.de
Received: from lycaon.yaina.de (ip1f118239.dynamic.kabel-deutschland.de [31.17.130.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "lykos.yaina.de", Issuer "CAcert Class 3 Root" (not verified))
	by mail.yaina.de (Postfix) with ESMTPSA id EA9117CDFF3D;
	Thu, 09 Apr 2026 21:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yaina.de; s=mail;
	t=1775762865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKNHuScRsfaaXjpydSx91/XUUBC1BofoXY1N4elcjjE=;
	b=iZ5C/vUbOXT3Ludr9yIIMF+lJvYoD+XNfpNCw/9De9kzs449qRvkmGf05g0CLmD4dPV8Yz
	3IoeWjJxbVIyu75g4OLa7lodm64e5sj85kPvrZvEb0VpWpY5aTR8Wdu87zFYLkIyDHaX1v
	CTt607Uc7DD55IhmPU9zQral5yy4xsQ=
Received: by lycaon.yaina.de (Postfix, from userid 500)
	id 1093B300FBD; Thu, 09 Apr 2026 21:27:44 +0200 (CEST)
Date: Thu, 9 Apr 2026 21:27:44 +0200
From: Joerg Reuter <jreuter@yaina.de>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net 2/2] net: hamradio: scc: validate bufsize in
 SIOCSCCSMEM ioctl
Message-ID: <adf9sHv5OHxqUPNk@yaina.de>
References: <20260409024927.24397-1-mashiro.chen@mailbox.org>
 <20260409024927.24397-3-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409024927.24397-3-mashiro.chen@mailbox.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yaina.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yaina.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235496-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[yaina.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jreuter@yaina.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0EE33CF0B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks great, thanks!

    73, Joerg

> The SIOCSCCSMEM ioctl copies a scc_mem_config from user space and
> assigns its bufsize field directly to scc->stat.bufsize without any
> range validation:
> 
>   scc->stat.bufsize = memcfg.bufsize;
> 
> If a privileged user (CAP_SYS_RAWIO) sets bufsize to 0, the receive
> interrupt handler later calls dev_alloc_skb(0) and immediately writes
> a KISS type byte via skb_put_u8() into a zero-capacity socket buffer,
> corrupting the adjacent skb_shared_info region.
> 
> Reject bufsize values smaller than 16; this is large enough to hold
> at least one KISS header byte plus useful data.
> 
> Cc: stable@vger.kernel.org
> Cc: linux-hams@vger.kernel.org
Acked-by: Joerg Reuter <jreuter@yaina.de>
> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
> ---
>  drivers/net/hamradio/scc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
> index ae5048efde686a..8569db4a71401c 100644
> --- a/drivers/net/hamradio/scc.c
> +++ b/drivers/net/hamradio/scc.c
> @@ -1909,6 +1909,8 @@ static int scc_net_siocdevprivate(struct net_device *dev,
>  			if (!capable(CAP_SYS_RAWIO)) return -EPERM;
>  			if (!arg || copy_from_user(&memcfg, arg, sizeof(memcfg)))
>  				return -EINVAL;
> +			if (memcfg.bufsize < 16)
> +				return -EINVAL;
>  			scc->stat.bufsize   = memcfg.bufsize;
>  			return 0;
>  		
> -- 
> 2.53.0
> 

-- 
Joerg Reuter                                    http://yaina.de/jreuter
And I make my way to where the warm scent of soil fills the evening air. 
Everything is waiting quietly out there....                 (Anne Clark)

