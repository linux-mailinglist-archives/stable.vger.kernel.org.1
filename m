Return-Path: <stable+bounces-180744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4EB8D94C
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A817BFC3
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B6221FDD;
	Sun, 21 Sep 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vmo-authrelay.edge.unified.services header.i=@vmo-authrelay.edge.unified.services header.b="lECghJWS";
	dkim=pass (2048-bit key) header.d=virginmedia.com header.i=@virginmedia.com header.b="C+71gsJD"
X-Original-To: stable@vger.kernel.org
Received: from dsmtpq4-prd-nl1-vmo.edge.unified.services (dsmtpq4-prd-nl1-vmo.edge.unified.services [84.116.6.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F61CFBA
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.6.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758449968; cv=none; b=MykFereW/eves+OTqMZZ4iBSHFRlAMsBFwy7giZYmIe/SZlI9bc6krPcv+CCoN7ZucHVTjeEHynzuXiYd5AMeIJOkRbN4pJCYdJiq58j7QwKtHgfol3D0xaClFXSomdrhVUPk+Gofwb844SCNaToIkrPtQ87t5xxaW8KE2fx/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758449968; c=relaxed/simple;
	bh=4DRYrgfiLRsXSd49E9xXNhrgWt5T9JBwWp5f1+RiT3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:References:Content-Type:
	 MIME-Version; b=WiGhjmkiCHh3CXNQBb4tgnoNvdj9J6DTvOvfgKfMG/8/WyFkOYgHa4o/vn1IGqY6KIH9cbHkDJI3FJde5+fOr8iIaLOvmyL2P0BlMCQOmY1xyGM3C/B5RJEbSCgmqB7lXjM3+kSAF47cZWEJVFTrjebYBsgWxyELzTBC8RCsN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=virginmedia.com; spf=pass smtp.mailfrom=virginmedia.com; dkim=pass (2048-bit key) header.d=vmo-authrelay.edge.unified.services header.i=@vmo-authrelay.edge.unified.services header.b=lECghJWS; dkim=pass (2048-bit key) header.d=virginmedia.com header.i=@virginmedia.com header.b=C+71gsJD; arc=none smtp.client-ip=84.116.6.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=virginmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virginmedia.com
Received: from csmtpq3-prd-nl1-vmo.edge.unified.services ([84.116.50.34])
	by dsmtpq4-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <smf-linux@virginmedia.com>)
	id 1v0H8d-00250K-W0
	for stable@vger.kernel.org;
	Sun, 21 Sep 2025 12:17:47 +0200
Received: from csmtp3-prd-nl1-vmo.nl1.unified.services ([100.107.82.24] helo=csmtp3-prd-nl1-vmo.edge.unified.services)
	by csmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <smf-linux@virginmedia.com>)
	id 1v0H8W-003vGb-6J
	for stable@vger.kernel.org;
	Sun, 21 Sep 2025 12:17:40 +0200
Received: from Moira ([82.0.204.144])
	by csmtp3-prd-nl1-vmo.edge.unified.services with SMTPA
	id 0H8VvLZAnU31l0H8VvBZq4; Sun, 21 Sep 2025 12:17:40 +0200
X-SourceIP: 82.0.204.144
X-Authenticated-Sender: smf-linux@virginmedia.com
X-Spam: 0
X-Authority: v=2.4 cv=GKLyEvNK c=1 sm=1 tr=0 ts=68cfd0c4 cx=a_exe
 a=7KlAsy3RGnwpW11VTsQBiw==:117 a=7KlAsy3RGnwpW11VTsQBiw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Hs1lhvdwazv7KdD26xQA:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vmo-authrelay.edge.unified.services; s=dkim1; t=1758449860;
	bh=4DRYrgfiLRsXSd49E9xXNhrgWt5T9JBwWp5f1+RiT3Y=;
	h=Subject:From:To:Cc:Date:References;
	b=lECghJWSr4HePn0aMp5rCXSpKrfM9rp3Aoc0lcfl4j+7eYCGYGReeCUUr9szmapN9
	 r5I8ADV5ExCZMMaRQtWgr4OM/yXvOX2IrWWlBViz6kmijDD2dQkvSk3G8jHfTSdTXZ
	 1YHWiWcO+Z9R9LrjALsMzIoLS7JnYs8Q1yQ+Z3NMdcHrI2SNf3bGET3OQmS05B3HB4
	 JUZwp/W8SPDHEK15YDf7eu2OLqcc4zsjYP7Bsrj3cP3H/91nF6rMOOYW+tUD1Ryi+C
	 H2bFyO6eVzTmih0EAjYJC3u+6cjAr8metMfgTcP8DIjlCk2VaJCOHNAkBwSDjN4gdl
	 7h+jPBGfv/lAQ==
Feedback-ID: 20250921-??:csmtp-prd-nl-vmo:Authrelay:??
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virginmedia.com;
	s=meg.feb2017; t=1758449860;
	bh=9PCt+Jb+3veFMFJEokYU9xJSa1J/KOLs/OT9Vx6VMSY=;
	h=Subject:From:To:Cc:Date:References;
	b=C+71gsJD2LmYyl2rqf9SoJQrU5fKXhkVdEt0318mvx92YF43t+iBVUK0utrPUf43s
	 J5FbITLa7BGnS3M1isLIZu2wc00YIi4bLMnbjMJLjDhEnTWsww7wivcPrpsqMgnON0
	 hKnYWH3N4kRCHe4KSEs3rUpAydveXDoQSntf3k8REJ+XwcOiRe2FhOWJPkR8qRHr6V
	 K/MMwNL1nCH8ItEl2HfiE7JHKFp1Qo3vm30JTQWG4g/+RovNRkAkeiiGMIwkaZxN/9
	 8sMOkE0D76PKcCb401QQlvwZ5LK7sytdExscwRrkS38kt7/8mmeEyjCi/vC+OBW74l
	 MDo7hkt4fzSIA==
Message-ID: <65e91f8100a2879467a84448dad745a3d5cf4a61.camel@virginmedia.com>
Subject: Fwd: [Bug 220457] Using -march=native on linux 6.16.1 causes: can't
 find jump dest instruction error.
From: SMF Linux <smf-linux@virginmedia.com>
To: stable@vger.kernel.org
Cc: aros@gmx.com
Date: Sun, 21 Sep 2025 11:17:15 +0100
References: <bug-220457-19080-Tat6iJZuvD@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CMAE-Envelope: MS4xfHyWf7UvIFNqPRM+FG63AgpFdkOARoadDDtrL6WgnCsyhMejRRQGlPGwrOkBTSeNPK7bbh0yInGUOJfQ/IDrMq4FH8L5nMtT9TrtteHb7NuPHP+e34dH
 UbhlW5OKL2QMvh8nobT4nJIVdD0aInBFx+G7WegC5vsCFf+2scQyrHE5WUoA8/3v7/L+ggqRy0xC8Me/4OXGiwTvAhc8tckTTco=

https://bugzilla.kernel.org/show_bug.cgi?id=3D220457

Refined my work around to:


        KBUILD_CFLAGS +=3D -march=3Dnative -mno-tbm=20
        KBUILD_RUSTFLAGS +=3D -Ctarget-cpu=3Dnative Ctarget-feature=3D-tbm



