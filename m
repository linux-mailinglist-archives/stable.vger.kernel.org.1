Return-Path: <stable+bounces-269783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hgAFI1iJQmp19QkAu9opvQ
	(envelope-from <stable+bounces-269783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:03:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 863816DC6B6
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:03:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=B85W5nc4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269783-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269783-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA8EC3015625
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B359425CD2;
	Mon, 29 Jun 2026 14:48:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5DD423160
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:48:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744530; cv=none; b=BNui8KCpOZ6fHDyhaa1pBUwJOC4Gm5ra8UG/ivi/LB5NwbILTzb8yrdBDzRAoF0Xlefxzxvs76MnTxSLoMvIRnd5Lbv9R68Ylf1YOJr3c3/u5Q0HFoKEE4gAveSE7GXmQSix4Y3MCD52fqQQK7CAvBT4YOPsGSDmSyeoQlJuKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744530; c=relaxed/simple;
	bh=Pktu8IUFaoWPXqsRCXhZdqmIMTa4nXkzwmgiIgu2fFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IZ3Ym297/gQCKKAmpTKASVNKJG0h8ploND0+7hxI9AzUho9az6rVez6WIlnAbVqk3jQqYsaP66ZZr9qsrz9Au64e6+00O88l0qrVPS4NK4CjC2n6PdDUq0xeXKaNCycQz6An9M4s57ICntfPTOPUOwKxwSA/LUJYbKHEyeYQI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B85W5nc4; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B18EF1A0CF1;
	Mon, 29 Jun 2026 14:48:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 847D55FF96;
	Mon, 29 Jun 2026 14:48:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55906106F18C0;
	Mon, 29 Jun 2026 16:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782744526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4Y2dGtCX571obC1bHJuffzAj/LpJ/YCV6B+7lEKdOS4=;
	b=B85W5nc4ALTzeXLEqY9xRChScRByfCgI22raxm5gdRyi9GFihKGYlhi7zeog25kse2VEuv
	6zyKiEM1Hoqroc/CLUH+p9iX/LMyA/Km1mK3M21dgaYE1TSrt8XR1mW5FUfR5z89Uk6fQd
	KO0KqSElqLJ0QT+EzYlq/NvWPmGh/osf5SFixvv8qPYiC9ACG/J3fXbwYQvG92gCxov6MD
	x+4L9Ti6A3u0uGbhfMo+G/nPWiT2xfH+LVfT7+WHtK4h59yyIdLxeo7l1BLYMWGQn9tkqs
	DuOKTZq6KCfGMvQ81OogPbYMvSg4EskxfagQ0nb8bn0lQuQnLA6CCrxLv1Q+WA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michal Simek <michal.simek@amd.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Andrea Scian <andrea.scian@dave.eu>, 
 "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Olivier Sobrie <olivier@sobrie.be>, stable@vger.kernel.org
In-Reply-To: <20260529-dave-upstream-nand-fixes-v1-0-8c72aa23aee2@bootlin.com>
References: <20260529-dave-upstream-nand-fixes-v1-0-8c72aa23aee2@bootlin.com>
Subject: Re: [PATCH 0/3] mtd: rawnand: pl353: Fixes and software ECC
 support
Message-Id: <178274452512.266238.15298515792441156646.b4-ty@bootlin.com>
Date: Mon, 29 Jun 2026 16:48:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269783-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michal.simek@amd.com,m:richard@nod.at,m:vigneshr@ti.com,m:andrea.scian@dave.eu,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:linux-mtd@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:olivier@sobrie.be,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 863816DC6B6

On Fri, 29 May 2026 18:29:55 +0200, Miquel Raynal (DAVE) wrote:
> Following the previous reports from Andrea, here are a couple of fixes,
> making sure the software ECC support works flawlessly and is compatible
> with U-Boot.
> 
> Link: https://lore.kernel.org/linux-mtd/MI2P293MB02644DC5515E56A2539C65739765A@MI2P293MB0264.ITAP293.PROD.OUTLOOK.COM/
> 
> 
> [...]

Applied to nand/next, thanks!

[1/3] mtd: rawnand: pl353: Update timings at the right moment
      commit: ee60be8929c7badf1194e3149a8aef930cfd77b8
[2/3] mtd: rawnand: pl353: Make sure we use the monolithic helpers for raw accesses
      commit: 80ecacd054ffeb60cd28e46ed5cd6bd0d2de318b
[3/3] mtd: rawnand: pl353: Fix debug prints
      commit: 2b7baaddf1bc3e39206a0354449fdc349945b86b

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


