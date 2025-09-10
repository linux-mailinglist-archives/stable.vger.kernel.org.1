Return-Path: <stable+bounces-179160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82518B50D46
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 07:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4FA16BBC4
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42669BE49;
	Wed, 10 Sep 2025 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="OPAbCgEx"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144282866
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482231; cv=none; b=GKHeV1R7gySRstdq28RK5JEarxLdLWCumnOFWxrrmGfs+3du5DG/fHQTfmmhl/xcA43wac2MFjMOaqHHu9Ji5YJsXoFIJPE0+SvgRcHibVcN6HWcK32hO7yTNszjktpZgj9nJMdtq9aJUfZCsJqWUlLYBii58QeyNOm04sf7lSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482231; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=FG1Uq/0tv2wEjO/lgLMgIz2sk+dNj66NFpBIMq+ySj5nNmzu3iKDsdI1jZfCxTF6qwnnxZFnLnA1jjwVjQ3mNBxkHBWHoLObZ+nRSZazj0232h0XK0IATN+Ppeoo66SvsSR97jmvW7AZ/o8BH2mnN7zAKdvItFndK2dFBI+JKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=OPAbCgEx; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58A5UHwG692726
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 13:30:19 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757482219; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=OPAbCgExM0E8HNt8ZLJkrMI5QH0pxk9DEDp6Ja4g4Yar8dnYVT9xZ8bFdCMGUd8tY
	 d3H7PO0fyLsq5UG6658dL5w3iOiPCMO501Cf8uwj7mCGv7qana0E/RtBgIXqKlDItb
	 79fpy+lddl820bG+aklzJ7N94gRuK7JHTWqqRAf4=
Received: from [127.0.0.1] (111-242-162-245.dynamic-ip.hinet.net [111.242.162.245])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 58A5Ns8e824324
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 13:26:23 +0800
From: "Info - Albinayah 397" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNzMzNDIgV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjUgYXQgMDc6MjY6MjEgQU0=?=
Message-ID: <47dca456-062e-011b-dc7b-52fd72978698@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Sep 2025 05:26:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=BPEQr0QG c=0 sm=1 tr=0 ts=68c10c00
	p=OrFXhexWvejrBOeqCD4A:9 a=I5B5Aj/LlPR7BQ5eKQnnyg==:117 a=IkcTkHD0fZMA:10
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

