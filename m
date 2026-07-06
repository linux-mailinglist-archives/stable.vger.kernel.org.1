Return-Path: <stable+bounces-272138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eeZoIkdVS2onPgEAu9opvQ
	(envelope-from <stable+bounces-272138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:12:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B1770D568
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:12:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="R/6JwtiE";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272138-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272138-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3211312DB33
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF954C8FED;
	Mon,  6 Jul 2026 06:24:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCE3D6CD9;
	Mon,  6 Jul 2026 06:24:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319076; cv=none; b=dTUnEZzODKNfvKUZkhtiAoU3ZdcCfQ1B88y9IaWB7hYSuoSpEkEkmYuMpjk6wZQusJPKDuBOSYN55dEU8yzP71c3xRnQyPhUZWPHshWBuH7BAhBOf9JfBF5HQAjFKbYQQNaDAnRf9sHMb4x8lBuV9KqFZHuZgPkrSwMkdeclwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319076; c=relaxed/simple;
	bh=atxWDtVQzFIpho9Y+zDTHO7Vl+ideWOyNCr0THvvzHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aRY2qX2xD8wCoW/bAKt+Ms/K0G4r0zpU3x09+I/f+I9XCm5SGYsCWRQDRGJ7Y9A/IXHQ/Cv7VbJHfWkV3z+u9ft+HMORJm4VcFylopB6zHtba7okSOmimBaXWiFcz35XapdIdkOeHHwR0AlDqz4jHqPWQ9yXIYjLQnZuD07Lvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R/6JwtiE; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F30B04E40CA2;
	Mon,  6 Jul 2026 06:24:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6C7E601A2;
	Mon,  6 Jul 2026 06:24:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F06411BB98B6;
	Mon,  6 Jul 2026 08:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783319064; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HQei6Rt5rAEMgiyIOtihLA9S2prQeFUyFlrKQtRHLZg=;
	b=R/6JwtiE4Jj7hU39SNi7mGJGuIuBacFdPrO2BUFGV8homnrNckLDsYwNZZVT8QhKa9yMlf
	2XnrMc8Swt3bbv8aqp7NUXNhDVO2GApBVyrxwXCXD5E+oR3NufMihm86LjY7Je+1Gw8bJy
	ZeaL322QaedI+2S7SgMx5KALqGn3StOxCbw8syjye8AE468jTHUOm9h7YSVzpw8Kj07YIA
	qPeWXCu+m6mv7l4mKd41rEaWN5wKrXrZUEqhidDdIFzaG/Fw0F3EWS4MU5ChEUcJwnpgEe
	xk5cRyjba/JdFtea8rKid2RBTE7C3oVu/jTeRHdc2osmE3fWFWwgp6BWgNKtOw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Vladimir Zapolskiy <vz@kernel.org>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260703073759.31388-1-pengpeng@iscas.ac.cn>
References: <20260703073759.31388-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH v2] mtd: rawnand: lpc32xx_mlc: fail DMA transfers on
 timeout
Message-Id: <178331906145.868671.2640165529145419553.b4-ty@bootlin.com>
Date: Mon, 06 Jul 2026 08:24:21 +0200
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
	TAGGED_FROM(0.00)[bounces-272138-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:richard@nod.at,m:vigneshr@ti.com,m:vz@kernel.org,m:piotr.wojtaszczyk@timesys.com,m:linux-mtd@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12B1770D568

On Fri, 03 Jul 2026 15:37:59 +0800, Pengpeng Hou wrote:
> lpc32xx_xmit_dma() starts a DMA transfer and waits up to one second
> for its completion, but it ignores the wait result and returns success
> after unmapping the buffer.
> 
> A timed out read can therefore return success with incomplete data, and
> a timed out write can continue the NAND operation without proof that the
> DMA payload reached the controller.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: rawnand: lpc32xx_mlc: fail DMA transfers on timeout
      commit: dbf590b662695b16fbf5917ef129697be4410ea9

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


