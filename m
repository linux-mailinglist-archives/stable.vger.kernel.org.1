Return-Path: <stable+bounces-185875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE64BE1637
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 05:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D059B540637
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 03:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2582156F20;
	Thu, 16 Oct 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="T7Ri6Nzb"
X-Original-To: stable@vger.kernel.org
Received: from cmsr-t-5.hinet.net (cmsr-t-5.hinet.net [203.69.209.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97E79EA
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760586564; cv=none; b=qqgC+JN2fp8v7tLTG1Z2YswL23Z/R0dKQ/+bUFzzw4SkEvzMR3GY7OCqigGGbBUxM9tR/2337emFaAJ3DQ1T5aODtmwm0RcaiKx0kED1as49zZu2ohHvnVV4AHGOcDhRehQTIhu87xAB53a32v5LzY3gf1Wk7yQIdx5STwe6cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760586564; c=relaxed/simple;
	bh=y+IX4V7HeNVL6fvhtsPtFPoQGQJrmRnXwH1Tj/P+LMw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=tMY1FYXkJaJ3Y00rPIyePVebeIFCYTgXUusrIHTm585nE9R+U1MUdDelza7n2g9LuvcUNhXKcOapLwlvhrspMsuF+5zqDk9SaYL27FACVLZnjcV6PQEBLBeA0QZqEv+IQs79jLoTWIWAka/k6ebX09ZAVAUSNNFWpZwCVg4O3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=T7Ri6Nzb; arc=none smtp.client-ip=203.69.209.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr2.hinet.net ([10.199.216.81])
	by cmsr-t-5.hinet.net (8.15.2/8.15.2) with ESMTPS id 59G3JwNg711465
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:19:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1760584798; bh=y+IX4V7HeNVL6fvhtsPtFPoQGQJrmRnXwH1Tj/P+LMw=;
	h=From:To:Subject:Date;
	b=T7Ri6NzbPDRr2j5cIEGvyukxsFcJ09kofEOgr+jc5AbwnrFB0k+kQYhIkYLjubfGh
	 SqsOhqCpdz/pCcdIyoSy1IixjA880eiSZ5gT+xxqyeV7Ik6q4qbi2UHC1SaZHokhD4
	 NnPDTUjbxlIAJI49miR+hnFHNkY5okB6YOu2Y0kggXwn3gVicnBTvcu8b1RFxC7M5e
	 oDzg2P3R+R7iZclnCC9YrbJabZETYrB1RneBg9rgPMl03Qi5GtQ2A/63kcz7RinsL2
	 hrf987CB/pFnYQyz6s7Yv8yDaJnZai67Y+tbIvBxMw0vKS/rHwibvf7+b6JveuABIB
	 Mj85/6WSXOTKg==
Received: from [127.0.0.1] (1-168-183-63.dynamic-ip.hinet.net [1.168.183.63])
	by cmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 59G3GOF8777633
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:19:57 +0800
From: "Purchase - PathnSitu 686" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Purchase - PathnSitu." <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TmV3IE9jdG9iZXIgT3JkZXIuIDQxMzgwIFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1IGF0IDA1OjE5OjU2IEFN?=
Message-ID: <ebfd81eb-ee0a-4dd2-a57f-49a17b83bbfb@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Oct 2025 03:19:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=UMR+Hzfy c=1 sm=1 tr=0 ts=68f0645e
	a=vllK5Wlj5exZm3hG/sMsvw==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=751GVyYgdrAhH6-ziKsA:9 a=QEXdDO2ut3YA:10

Hi Stable,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

PathnSitu Trading

