Return-Path: <stable+bounces-180596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6BB87D02
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 05:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9021C257CA
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979322A1D5;
	Fri, 19 Sep 2025 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="jvX+b6x2"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E126C3B0
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252625; cv=none; b=sCiEAfFL1zSaf7VkevJKX9ri320eEX4yFubAM8qEO1Gs6pSHTTxdq8HP+U2+KdpYUvcnX1oXiZaSoN1FcgFsyUzbZ+G4kQu66EC4qFitZPfxBgnufLvuurS8K4BFpwJ14keRMroXJCY1gqgNM9OBjQHR1HJbq9UsGcdtZWsQfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252625; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=TUYYYJXseTmKvbuo0tarUeWs5R3Gs2rUwlGFSTPhdoz72QrJ1Mfbht8JuX13u4GS+wkk8TDQo5mSrTmLfd0b3e88pKPe26YTHukvT1NtKVcN1boH3azdxcABNEE6w8SI6XQ7Yh7gg2TfVz1Fb1myjnULBkCDl7REbJiO4OsL19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=jvX+b6x2; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58J3UJHI706260
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 11:30:21 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758252621; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=jvX+b6x2OzeLES3JKXctL1JmyiLnH0um7sHXkV9ZRK6iMJH5XK913vu05svn84MTz
	 LDtJMOZk/DTiQ+PI1lhiLj/8HAM3tZiYwjfNalom144ww3fMvu4dQD2hGwhvn/8AVR
	 LlshP0pau7FjqHoLtQ/0Sfptm8gRhDiyK0Wlo8gg=
Received: from [127.0.0.1] (1-170-232-114.dynamic-ip.hinet.net [1.170.232.114])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 58J3OCbL305454
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 11:26:38 +0800
From: "Info - Albinayah 004" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNDkwMzggRnJpZGF5LCBTZXB0ZW1iZXIgMTksIDIwMjUgYXQgMDU6MjY6MzcgQU0=?=
Message-ID: <56a29e1e-07af-5b33-4e58-1bd464bf852f@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Sep 2025 03:26:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=D/nkKeRj c=0 sm=1 tr=0 ts=68cccd6f
	p=OrFXhexWvejrBOeqCD4A:9 a=OcF2XEuT595Av/M9BZXSEg==:117 a=IkcTkHD0fZMA:10
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

