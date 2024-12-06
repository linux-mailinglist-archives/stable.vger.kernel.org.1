Return-Path: <stable+bounces-99989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C329E7A25
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 21:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BACA18860C2
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FC91FFC62;
	Fri,  6 Dec 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iNBybMzj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kaurbOR6"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E661C54AF
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517900; cv=none; b=QJP8x4kH1mIgDuhTxSuhRGVbDW8ragR4GbO3gjkzTXJrKO9+h0oev/IC2PWIRfIOU8kkB+ns1JhH+czZX12pumL68b7RjJZtBK8QCaEBJAXISNKbgvviWv36rnV7vmG6Ra/CMUxAbT2UKf0Un8t09PwjgvzDl/nG7XP60Dz7QhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517900; c=relaxed/simple;
	bh=Bnx3+s8Q9N3IT0PKX2FKHOvhnen5eqBUnh/hCLPb6DE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSqxODPwdLIPjGMJAwL54IkPaKDYx5FJsYdyzUk9Cpx3cZ+7/yLydYQNtOhDapJk8YJdFv+L9028RSHfEXS7rs+ZTAoWvuBuh1VlNadAsRyX6vDWhB3D8WvgT3Vma4WvekHpgNol7XzxblcFmphK0VOZz9jhfdpTfNySMmJ6ots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iNBybMzj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kaurbOR6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733517896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkxbGbsGFbeNJeDgGEu8frXGzMC9FUaRBk6L9W+QwI8=;
	b=iNBybMzj4W6O0C2soDFDFbAwWa5oLIg54QtWZmfF+/86YoXmWllTFVS++yHsbcSddPGyAU
	BxKC29786fsNGAcpO2UeBnHCXi094rjJTpp8QNuHY+mvK8ybVDiI5lDf4k0UcgOhPxg/y6
	zxBgmWZ5aZSAUFzFXHALwmObOb1f+ccRbBSxHBzjMsChLfDL7kw6yf09kl8PcQ5EpKXKKx
	fFDDnjtSqNzD16HV/GMVvU8idPHWre51Me1ShydhdLxR3dBiir4lVIXOtfU61mpGDdEhsw
	6/8/t4A4763nv/OJJeUae2OkX1sfiCxjQdJVOahb2HOQJkqG/H09KaisbRqFpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733517896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FkxbGbsGFbeNJeDgGEu8frXGzMC9FUaRBk6L9W+QwI8=;
	b=kaurbOR6mpaFmCzjEellFMlwISGlZ5E2Ec0B+kUROgNfdJO4BrmAZ621LTTW6EKgWrp0io
	xJuG+v0A1S59Z5DA==
To: gregkh@linuxfoundation.org, marcelo.dalmas@ge.com
Cc: stable@vger.kernel.org
Subject: [PATCH backport] ntp: Remove invalid cast in time offset math
In-Reply-To: <2024120622-enamel-avenge-5621@gregkh>
References: <2024120622-enamel-avenge-5621@gregkh>
Date: Fri, 06 Dec 2024 21:44:56 +0100
Message-ID: <878qssr16f.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Marcelo Dalmas <marcelo.dalmas@ge.com>

commit f5807b0606da7ac7c1b74a386b22134ec7702d05 upstream.

Due to an unsigned cast, adjtimex() returns the wrong offest when using
ADJ_MICRO and the offset is negative. In this case a small negative offset
returns approximately 4.29 seconds (~ 2^32/1000 milliseconds) due to the
unsigned cast of the negative offset.

This cast was added when the kernel internal struct timex was changed to
use type long long for the time offset value to address the problem of a
64bit/32bit division on 32bit systems.

The correct cast would have been (s32), which is correct as time_offset can
only be in the range of [INT_MIN..INT_MAX] because the shift constant used
for calculating it is 32. But that's non-obvious.

Remove the cast and use div_s64() to cure the issue.

[ tglx: Fix white space damage, use div_s64() and amend the change log ]
[ tglx: Backport for 6.12.y and older ]

Fixes: ead25417f82e ("timex: use __kernel_timex internally")
Signed-off-by: Marcelo Dalmas <marcelo.dalmas@ge.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/SJ0P101MB03687BF7D5A10FD3C49C51E5F42E2@SJ0P101MB0368.NAMP101.PROD.OUTLOOK.COM
---
 kernel/time/ntp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -804,7 +804,7 @@ int __do_adjtimex(struct __kernel_timex
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
 				  NTP_SCALE_SHIFT);
 		if (!(time_status & STA_NANO))
-			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
+			txc->offset = div_s64(txc->offset, NSEC_PER_USEC);
 	}
 
 	result = time_state;	/* mostly `TIME_OK' */

