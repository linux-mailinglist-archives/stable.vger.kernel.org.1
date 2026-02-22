Return-Path: <stable+bounces-217676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNLiDrBLm2k5xwMAu9opvQ
	(envelope-from <stable+bounces-217676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 19:32:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C5170122
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 19:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B06F3012E95
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 18:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3065C353EE3;
	Sun, 22 Feb 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RuRNP42j"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6013957E
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771785123; cv=none; b=Vh6aXDsKkdaq7bkmOc0PXS2DI1jTtw43V4XmgfPKdXcaGrAxt3oy/xcieu+OuncIfjd74/47xXP9RlSYm6YqFVGSZ6/FsC+56sNtH3BESKvhAMCJF4YJZL5keV7bddW9jZCxAoufAZc+io+iGuQV7Am2JEshC0UQ73uhoA5Nzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771785123; c=relaxed/simple;
	bh=e/CSVdBwzzKkwCtFcbxbYi/B3jHjcunPSplQZJEY+7c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Rjv9NbU5NYLblcO6FMmLddFNp8Y79j+nplTyscvQNCAfDN+nub5wkjL+D8XeRoA5uUDQAyhDTaTPP+ues81x8FQ5DGh2wplNsZjEncWj5IomVZGxHi7aOajZbbw/cBg+sO7MtVBAi4PFa8q3Fyizb01WXQhhzKPLV8H98iP0aU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RuRNP42j; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771785109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/CSVdBwzzKkwCtFcbxbYi/B3jHjcunPSplQZJEY+7c=;
	b=RuRNP42jd1C0YDEmmq30bCd6GeZXG/FKTRDKC8OohuoG7uROUeE7ScV6/VvKeIqhMsRbeB
	VvpQfG5O4jpCCATD5dUoxRHqT0YA0dBFX3/qi5yi2NANz6ScQAhZMj2QpeIxR4yODSA0RF
	Gt4MUx+AvFZmDWZMyIuCL7s6OIpCyLM=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix uninitialized data access on
 OTP read error
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAFXKEHY40ybHVbWLWPjOR_wuv5sV9YYXyum6nTT7LHG+irBpUw@mail.gmail.com>
Date: Sun, 22 Feb 2026 19:23:02 +0100
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 stable@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCD7E828-7951-49E0-81B9-523C1A4DC2B6@linux.dev>
References: <20260220133135.1122081-2-thorsten.blum@linux.dev>
 <CAFXKEHY40ybHVbWLWPjOR_wuv5sV9YYXyum6nTT7LHG+irBpUw@mail.gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[linux.dev:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-217676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B7C5170122
X-Rspamd-Action: no action

On 22. Feb 2026, at 18:29, Lothar Rubusch wrote:
> Hi Thorsten! So this one was tested on your hardware?
>=20
> Wouldn't it make more sense to squash this with the patch before: 'Fix
> error codes in OTP reads' (which IMHO actually fixes mainly the bounds
> check)? This on it's own I'd consider rather a refac than "Fixes".

Sorry, I forgot to add that I only compile-tested it (like the others),
as I don't have access to the hardware right now. If you could test it
on your setup, that would be very much appreciated.

And yes, happy to squash them, I just found it after submitting [1].

Thanks,
Thorsten

[1] =
https://lore.kernel.org/lkml/20260215205152.518472-3-thorsten.blum@linux.d=
ev/


