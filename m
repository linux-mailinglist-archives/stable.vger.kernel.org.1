Return-Path: <stable+bounces-272156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6mnRGCZpS2roQwEAu9opvQ
	(envelope-from <stable+bounces-272156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 10:36:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A126C70E2DF
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 10:36:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=sfPKwHmg;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272156-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272156-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2299C32AA98D
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A73F58C6;
	Mon,  6 Jul 2026 08:30:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE13F5BE4
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 08:30:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326610; cv=none; b=NhXLDolZG8DU1ZwUcIgIB1crmXxNKtaS03NSWSiNwsdHgcyO+dHDFfowbvV+JWXiUShndylO+xH/+lbhLmgQVex1wmeVHvL/0TT0gwPEq6xQRZPkt/xy5WsYlmpliqYjFWg9YsHAbwLcf7RoBExUf6aJS8hxdbE8GS3mMVTlalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326610; c=relaxed/simple;
	bh=wZEYRdauGNyo+aR+aUOLLJQO4IJ+EyWBrO2qwu0+6jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF4iIoKKrjuwO8OlNrYsX+byARjdxzzrXxfXlhLXAo2DUSnFaJNoai03+lUNcwyc7FnDkW18+ttXlrmL7ySe3jKyzO0DvzWSaCUDDdJcXsbOqAu2o81VaoI92COXQtzGOaiei5nyQY6eN1nuqVlNCBCNfpptN4atBlmz+US8FJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sfPKwHmg; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B00501A0E86;
	Mon,  6 Jul 2026 08:29:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83628601A2;
	Mon,  6 Jul 2026 08:29:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D00C111BB9CCB;
	Mon,  6 Jul 2026 10:29:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783326595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PY9i1Sab1PSIG/yNf88fVZTp+uxV9ipVlzY648ikCP8=;
	b=sfPKwHmg9IiZRmz4+LMlXqCSWYCt+zkzHpATUeuvy2InsXjF2sm7LWgIEm8PqU0prYabbh
	V6vIt0HhLRNnjgcfa3PoswpRYzav0P4RzZEm+wOK1Ni2+Hgsl8NAmwQmgmItM7xsgp03y6
	VIPFBQVTiAadRUvtrsVlASHObc4/DtAzbB2JJEiZJckVplwk9m/HsQVz4arSbKiF2+MlOQ
	UDnn0eI7/C5dInjNXZQaX5ssP9amojJBNmsa69yOH+kfrcZupFf+IO+QCuFoq7jLoPzA76
	v8Ak6uh6z61lFUWKikP+QDbX/7dR14P9Nxducgv+oKCWDXPdASxtgeTxme/rnA==
Message-ID: <565c18f3-8b1b-4832-b060-617b7d683eb6@bootlin.com>
Date: Mon, 6 Jul 2026 10:29:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on
 unchanged mode
To: Markus Breitenberger <bre@breiti.cc>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 stable@vger.kernel.org, Markus Breitenberger <bre@keba.com>
References: <20260706061954.94842-1-bre@breiti.cc>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260706061954.94842-1-bre@breiti.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272156-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bre@breiti.cc,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:yong.liang.choong@linux.intel.com,m:stable@vger.kernel.org,m:bre@keba.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,keba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A126C70E2DF

Hi Markus,

On 7/6/26 08:19, Markus Breitenberger wrote:
> From: Markus Breitenberger <bre@keba.com>
> 
> intel_mac_finish() is registered as the phylink mac_finish() callback
> for the Elkhart Lake SGMII ports. phylink calls mac_finish() at the end
> of every major link reconfiguration, including the initial one during
> probe, before any interface mode has actually changed.
> 
> The callback reprograms the shared ModPHY LCPLL through the PMC IPC and
> then power-cycles the SerDes. On Elkhart Lake that ModPHY is also used
> by the on-die AHCI SATA PHY. Running the reconfiguration during the
> initial boot-time link-up disturbs the shared analog block while it is
> still driving SATA, so the SATA link fails to train:
> 
>   ata1: SATA link down (SStatus 1 SControl 300)
> 
> The disk carrying the root filesystem is never detected and the system
> hangs at rootwait. Ethernet itself comes up normally, which makes the
> failure look unrelated to the network driver.
> 
> Firmware already programs the ModPHY for the configured interface, so
> the reconfiguration is redundant unless the interface mode really
> changes. Return early when the requested mode equals the current one.
> This avoids touching the shared ModPHY (and the SATA PHY) during boot
> while preserving runtime SGMII to 2500BASE-X switching, which still
> sees a genuine mode change and reconfigures as before.

One thing is that now we 'blindly' rely on the bootloader / fw having
correctly configured the initial interface.

From what I see the only configuration that's done is regarding the serdes
rate. Maybe instead the serdes interaction logic can be reworked so that you
query the serdes rate, see if you need to adjust it based on the selected
interface, and if so you re-configure it ?

Maxime

