Return-Path: <stable+bounces-179483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C7B56123
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 15:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E313B24FB
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3572F28EE;
	Sat, 13 Sep 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="pqo+BTil"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3F2F0C4D
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757770221; cv=none; b=kWnqDX+NbXwQ7VXC5CZOmnFQD6M6GekBEsNrbsPzhqygtiCLkJuG86nI1/4l07FlrnhqN3owY2h/z+ePQZC7LyGwouLaZSlHMP6QAulsv066wb4OOr8zuQd8OJRD+o7gqJn7REnojJeDR/wXMGS4OiwpUBSD93Un1HQ9V+AphBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757770221; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=aqWJ9PCgCxtZBEyaCek1g7joINvQ+8KDxxa9OH3/elEc0mbuhoZhaGPms4TuWZmptppkEfgmGuYj93g2DBF6Da79UXUFaCxBzqmvXM9eR1QILHXS04q6mH4VwNnbvPHJdT8yb1O7Z4dllOGqgt6qbilmmfLFwpxKVo90a3Wu2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=pqo+BTil; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 58DDU74g087959
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 21:30:10 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757770210; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=pqo+BTilebMtEjZ3UyMnmx/1lYEUKixQdtGWe27/HYSM40L1I1zAXxttVUwdqn26U
	 wMy+576HbvsRiP46nI+awiJdiEkGfuXEY/JejOuuwqxSKltJRWooGr9z2f+gLzcY/9
	 rLFCXzYF7A9tWOkCQoPm1eDVOjOQ3gMWeiCwr9Nw=
Received: from [127.0.0.1] (122-118-38-94.dynamic-ip.hinet.net [122.118.38.94])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 58DDP7aj164563
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 21:25:28 +0800
From: "Info - Albinayah 102" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gOTA3ODUgU2F0dXJkYXksIFNlcHRlbWJlciAxMywgMjAyNSBhdCAwMzoyNToyNyBQTQ==?=
Message-ID: <5bcf7b7f-0358-12e3-1369-610bb8785aa7@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sat, 13 Sep 2025 13:25:27 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=G5G/EMk5 c=0 sm=1 tr=0 ts=68c570c9
	p=OrFXhexWvejrBOeqCD4A:9 a=SuhHfwZ5qzqcMNOjqX1vSA==:117 a=IkcTkHD0fZMA:10
	a=5KLPUuaC_9wA:10

Hi Stable,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

