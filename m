Return-Path: <stable+bounces-272141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tfr9Fh9SS2pZPQEAu9opvQ
	(envelope-from <stable+bounces-272141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 08:58:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501B70D3E6
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 08:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=aljpZuCZ;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272141-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272141-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C7DA30CA885
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E634C6F09;
	Mon,  6 Jul 2026 06:24:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C3D8107;
	Mon,  6 Jul 2026 06:24:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319078; cv=none; b=Vy69AD1j12VKTJFzYRlV/T9uLnFOBQslI3FV2itM94pAAkZjGzNffljHn1sVGKi6BzXQ8MeKNtUAyNjiMd+TJJQ4jnWqXPTchTbY2Mb+MkZYY1u0SsKli8cbjthPugiSlHz8+1Y8bm1E7DLGSmqB/E35TM8o/GvwryC2DQnGHgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319078; c=relaxed/simple;
	bh=U112A6fp2fgh6C2mtY+UkJGb6VsIWxDu9MX14j5pzSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nTTnFcCo7e+SC+eukAspUV9W5TYAX9jsoUW/CqD6tn/UVeiZJ1quxYKt7/XCsiZyvbFKQpRBAKbtd5yLwYpqybS71WKkaqz0DAdde4F2icbpHGRz1JNPx0LokeQtE9uZLjIOLOtZGLPflpRAjHcI5zna5Go/axnqjIV2yPWPVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aljpZuCZ; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D6CB64E40CA4;
	Mon,  6 Jul 2026 06:24:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A4459601A2;
	Mon,  6 Jul 2026 06:24:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D767911BB98B6;
	Mon,  6 Jul 2026 08:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Oq5IY+f0PZd96xg7+KB/yGuleN1P4zmQ4qPvPNwL57w=;
	b=aljpZuCZmDVT+Sq5fmb3jnoC/djpA37MygeS4Q0OV/oaV84WvfTgTcONdlU7Npl0D4lLWe
	YK51e6Zh5CtYD22AyXlNJynQC4W7Xx4uy0sKOjdvvwUlTnom3felAktY6Doto+0xHNBWFT
	VJZ4u3BO4QEpyCnpCdsTr5dJZk/bIusxr+kjX0s/m8umk8QbR0RROGqd/emodYyOe5giZJ
	3ZvvBzl7u7cFoavhNzpHExJ/qOv2vfieY5dngoVdoweR1UAUKTDdvMXEyQCgJ1zxmwXhmy
	rifIamNrKNfIIFrKfjYBh/gWtoovtUTR8RzxAlOCWr5hL/jdwe5JLuNUnOIaQg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260703074052.49260-1-pengpeng@iscas.ac.cn>
References: <20260703074052.49260-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: mchp23k256: use SPI match data for chip caps
Message-Id: <178331906575.868671.5495065528182166347.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:25 +0200
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272141-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:richard@nod.at,m:vigneshr@ti.com,m:andrew@lunn.ch,m:linux-mtd@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0501B70D3E6

On Fri, 03 Jul 2026 15:40:52 +0800, Pengpeng Hou wrote:
> The driver stores chip capacity information in both the OF match table
> and the SPI id table. Probe currently uses of_device_get_match_data(),
> so a non-OF SPI modalias match falls back to mchp23k256_caps even when
> the SPI id table selected a different part.
> 
> Use spi_get_device_match_data() so SPI id-table driver_data is consumed
> when OF match data is absent. This keeps the existing default fallback
> while avoiding the wrong MTD geometry for id-table-only matches.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: mchp23k256: use SPI match data for chip caps
      commit: d322e40f4edf92bf0ca329e5aa4ae1c0316feb38

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


