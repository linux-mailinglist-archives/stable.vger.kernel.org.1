Return-Path: <stable+bounces-225649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDCtLllFuGmLbAEAu9opvQ
	(envelope-from <stable+bounces-225649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:00:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C56FF29EB4B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 845263010906
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9DC33B95A;
	Mon, 16 Mar 2026 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UGvnVuwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DBE33468C
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683984; cv=none; b=EonAt4Pm79Q31iKmVUSHOSNQBtD4Nx7uz5eBkMe4K39oBMGjBPvBsD9DnjlECCy/+F5uIRA7Btu17xp2ViDk81YehFGXx11vozeUIWcyhsODsjpJxsxn8xHbGFzSeBk3Qp9yK8E3wPo1ncY985xa739Y9F2LQerffesdgUNr++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683984; c=relaxed/simple;
	bh=Oikn5ffl/VaX2OsLfSocd5RjODglLKe8Gz/chAsnkOc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LZ6FYwbR/Qk9dXs0hmhnVrFskx8gv04oCuX2Zhqs1MULOYEQxnjQt6LFa8kRPIjvEhRRun5+tslp4Ny1m/z9zXK/1WPDM9r3Bkgx+FSu4SK352i9ouRMaPvl68v3Q+Wu3/dZN4zevAxEpTqAXJS+dhJ+SB8pulsW0R21A4sJIp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UGvnVuwQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 69E451A2D93;
	Mon, 16 Mar 2026 17:59:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A8535FC4A;
	Mon, 16 Mar 2026 17:59:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14FE91045036A;
	Mon, 16 Mar 2026 18:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773683979; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=clL/OrjmO10dATzmOm9nSfKm5FhAN41WJ/3xWKMS08I=;
	b=UGvnVuwQdC0pUjK0rP5dpOakdyji5GEIQpgotWR4HPf5E2r25rHPcYDZUAK91YVXSVfXjH
	XsQOm+qYTKBgVbvrlj9Zeyc/tmJ8G/wBWrXPkuiuYjuJu1wihXBjOmg3MZHHKyGNbqOmfN
	rCWFrB61KSm1XHrSAOBwUE0OYsWRw6VG6mNnxLH8KQsUAqYRTFmu/Ev6LQusZvbVCSi9D/
	fMPGz93vquPUMw0wxoINLjupb8NMzbA0dotYkApSw79u1ngJiuaFQuOK0kFd+nKjzByDwu
	95BhJv02UqglpMJFwg3A3D7TxCc+FN/PxBx+CtiCocy5bZ2mVwLI5tJKXsyvrg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 18:59:35 +0100
Message-Id: <DH4EHTJNY6GL.3EXTP61HNUNDD@bootlin.com>
Subject: Re: [PATCH net 2/2] net: macb: Protect access to net_device::in_ptr
 with RCU lock
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Vineeth Karumanchi" <vineeth.karumanchi@amd.com>, "Harini Katakam"
 <harini.katakam@amd.com>, <stable@vger.kernel.org>
To: "Kevin Hao" <haokexin@gmail.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
 <20260315-macb-irq-v1-2-0154104cbf61@gmail.com>
In-Reply-To: <20260315-macb-irq-v1-2-0154104cbf61@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225649-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,bootlin.com:url]
X-Rspamd-Queue-Id: C56FF29EB4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Kevin,

On Sun Mar 15, 2026 at 12:44 PM CET, Kevin Hao wrote:
> @@ -5915,13 +5915,16 @@ static int __maybe_unused macb_suspend(struct dev=
ice *dev)
> =20
>  	if (bp->wol & MACB_WOL_ENABLED) {
>  		/* Check for IP address in WOL ARP mode */
> +		rcu_read_lock();
>  		idev =3D __in_dev_get_rcu(bp->dev);
>  		if (idev)
>  			ifa =3D rcu_dereference(idev->ifa_list);
>  		if ((bp->wolopts & WAKE_ARP) && !ifa) {
>  			netdev_err(netdev, "IP address not assigned as required by WoL walk A=
RP\n");
> +			rcu_read_unlock();
>  			return -EOPNOTSUPP;
>  		}
> +
>  		spin_lock_irqsave(&bp->lock, flags);
> =20
>  		/* Disable Tx and Rx engines before  disabling the queues,
> @@ -5963,6 +5966,7 @@ static int __maybe_unused macb_suspend(struct devic=
e *dev)
>  			tmp |=3D MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
>  		}
>  		spin_unlock_irqrestore(&bp->lock, flags);
> +		rcu_read_unlock();
> =20
>  		/* Change interrupt handler and
>  		 * Enable WoL IRQ on queue 0

Instead of making the RCU critical section extend so much, you could
dereference ifa->ifa_local into a stack variable. In particular, it
would avoid the RCU critical section covering a spinlock critical
section.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


