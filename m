Return-Path: <stable+bounces-274176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p9bLIxruVWr9wAAAu9opvQ
	(envelope-from <stable+bounces-274176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 10:06:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 407BA7522CA
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 10:06:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=UUhvAR3D;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274176-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274176-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E423047F04
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B13F4854;
	Tue, 14 Jul 2026 08:06:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BED3F39EA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:06:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016369; cv=none; b=FMDxLD+BaaNR/8IPTKtFH2uq4TKp7GRkBBiGmYYk2a8aECtm4iKlXoSpfazVKN+M9wEMaQ7OQKayw1r4VrQkkEZFprIhGyZjbJ8sqQg82879Q5ghLguCTeNw4al/jxXTgR+lydSBCZ2rCK7AUrdTBH9TH7n/Onuscov+98dMKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016369; c=relaxed/simple;
	bh=iEdFzK7xpXCvHtMu35ZXOvPgRl4ORJgloYuTHHBTGNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSylVkxZeklcTyA0kPhu7P7d4NXPIqghfwY31Fzmi2jtyF1z86GlgBHUClYky0UFwtvVv0Hb9pvu4xTUND12p7XX3Yr48DxBvOzOQsBmLVIRLadhz35GfgfC2tIwlwYLdHuzJXj3ZjVDJ5yO0n0FSkLcamtZmH4BUxpm14wWEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UUhvAR3D; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 64F78C2BB23;
	Tue, 14 Jul 2026 08:06:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E510B60346;
	Tue, 14 Jul 2026 08:06:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B570111BD3B23;
	Tue, 14 Jul 2026 10:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784016361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0Tr5FyN1yFpthV3VK225kkpXsZ1+Q0ewXRFUsrX48A0=;
	b=UUhvAR3DyUsKeZ48khLzz/RdRv84xOY22/Qhm3XoX9CbNw1gs0svpqNBm/qEokdnu5EIv6
	v2O/ILj+ugqfNoSd/d+H1e62p6axvHGjlaSXuvAcTKF4VTXhJzWNhGSnE/SVr6yPSn+k0r
	ZPD5zjXlnrjRtF45RE5zTLOb7ltACN5ehJNzBp5GKmphkdqLx9VWvnWm9gmaIAI3Dgvox4
	D50HMojooGQIcwQyNqnlsi3y9KknvFb5Np3S4K71bQH0De5Hva7q0n9O8bT7W7gE16xm5E
	49uaXhN7Pj7/ukVgFASP2sPi635Tf+Cv0ce3x0zd9vLu2iscHZYFFubD1syBGw==
Message-ID: <edc373ca-fef8-46e4-8b4f-8afc257c2349@bootlin.com>
Date: Tue, 14 Jul 2026 10:05:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: intel: skip SerDes reconfig when rate
 is unchanged
To: Markus Breitenberger <bre@breiti.cc>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 yong.liang.choong@linux.intel.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 Markus Breitenberger <bre@keba.com>
References: <20260713171619.192452-1-bre@breiti.cc>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260713171619.192452-1-bre@breiti.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274176-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bre@breiti.cc,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:yong.liang.choong@linux.intel.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:bre@keba.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,linux.intel.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org,keba.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[keba.com:query timed out,bootlin.com:query timed out,vger.kernel.org:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[keba.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 407BA7522CA

Hi Markus,

On 7/13/26 19:16, Markus Breitenberger wrote:
> From: Markus Breitenberger <bre@keba.com>
> 
> intel_mac_finish() is registered as the phylink mac_finish()
> callback for the Elkhart Lake SGMII ports. phylink calls it at
> the end of every major link reconfiguration, including the
> initial one during probe.
> 
> The callback selects the PMC ModPHY LCPLL programming for the
> requested MAC-side interface and then power-cycles the SerDes.
> On Elkhart Lake that ModPHY is also used by the on-die AHCI
> SATA PHY. Reapplying the programming during the initial
> boot-time link-up disturbs the shared analog block while it is
> still driving SATA, so the SATA link fails to train:
> 
>   ata1: SATA link down (SStatus 1 SControl 300)
> 
> The disk carrying the root filesystem is never detected and the
> system hangs at rootwait. Ethernet itself comes up normally,
> which makes the failure look unrelated to the network driver.
> 
> Before mac_finish() runs, the legacy SerDes power-up path has
> already programmed SERDES_GCR0 for the current interface. The
> 1G and 2.5G ModPHY tables selected by mac_finish() correspond
> to the SerDes lane rate, so read that rate back from SERDES_GCR0
> and skip the PMC reprogramming and SerDes power-cycle when it
> already matches the selected interface.
> 
> This keeps the disruptive reprogramming out of the boot path
> when the SerDes is configured correctly, while preserving the
> previous behavior when a real SGMII/1000BASE-X to 2500BASE-X
> rate change is needed. If the register read fails, reconfigure
> as before.
> 
> Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.8
> Signed-off-by: Markus Breitenberger <bre@keba.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


