Return-Path: <stable+bounces-180738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3124BB8D4C7
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 06:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AB64427DB
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 04:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8521F4180;
	Sun, 21 Sep 2025 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="kQe00M9y"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB5168BD
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 04:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758429111; cv=none; b=WZnp8AFzGe/yg/VPLkSubNMZfZEymttNY34WmW3soogQ8t8Y5+14mlIqIaAKMuYoU8hjCppsP4SyK2d0t6kbWpPo19x1j7CNCOUqYkx4eoLjzL7pLI25b3kM156hNaqqJVVEraIVEWqv9FpJDCbZ0okV2hODeB8Yasyux+GbQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758429111; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=iDdWRcncSVIJDJF4GbgzGUtrs90PT2XS3ZARoSkg6q13WZdvnFjRNWj6TsdNS23ZkPDu+KUg5JDUXTlFHcp2GmQ7e3VoqYcHOPicch/PXG5FWQ0lRFc02gjJ0RCeYr9L8T5IoWcSSEWAt2MwZl1vwfeUSMgNPms+M+tQdW7PSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=kQe00M9y; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58L4VkFm196540
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:31:47 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758429107; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=kQe00M9yVKDJPF3DobhhlQDw8wpjoTXhg2qSjM3RS5bAoNebYO4Ggb+7MY2PxVzWv
	 T+/2j5BsNV6x3u5icTkTPyQeMNVn1hMXjBlvNSb9jYT4X3y3gFoX1fNjZsqf+MWqsq
	 luwBnBZD3I+hM7rNQDZq1tAeDfyaPcopWWBFwmYo=
Received: from [127.0.0.1] (36-239-124-102.dynamic-ip.hinet.net [36.239.124.102])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 58L4Nd24703088
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:25:11 +0800
From: "Info - Albinayah 086" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMDIzMTggU3VuZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjUgYXQgMDY6MjU6MDkgQU0=?=
Message-ID: <935f68c3-ecaf-f81c-afb7-d97f21b1d4ed@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sun, 21 Sep 2025 04:25:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=X8PxK3Te c=0 sm=1 tr=0 ts=68cf7e28
	p=OrFXhexWvejrBOeqCD4A:9 a=uOCXUd7ZQqfqfYBohqtHNA==:117 a=IkcTkHD0fZMA:10
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

