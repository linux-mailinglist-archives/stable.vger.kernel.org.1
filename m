Return-Path: <stable+bounces-180474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E388B82E3E
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 06:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED57A3B1A9F
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 04:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6AF24502C;
	Thu, 18 Sep 2025 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="0tSa4jQ3"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6D24469B
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170115; cv=none; b=TxDUqE+UJI1yiiECi1Cdh/0vC8hiMDEPUjAEifpFnEhPOX0Ph1Vq3xhqeJMy5y3G/0NQ2wAIS0QLhd4VOdPg1x7a5Dij+lBaL+IJGkWGuVUSl0aLBj71cOCHKDnspjTc8JNKylmev39QCaRMqxj2GZD5rUdWUtJ9xQFoFYuy1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170115; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Bpx1VAl0/6IvZV08WW8yD9szzfncX5mOUe7Lt3d1cHtEORDNuspg6IjKYnF9S+whHfOndlWsyeePGGaZNm54wTCWNMEvV61xGOUltWKa9DqdKq4nTV3jUk1/HGeyqBEaBsKAi9mOp1C5gSkLJgULWjXb3WVDOv4FABd1XngPCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=0tSa4jQ3; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I4Z8eI178148
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 12:35:11 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758170112; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=0tSa4jQ3R4mtpZbvKw+zVZZUta4cU85aoUuQfaHjBLEgJQt7/86Mz2gHRpqUjWj+8
	 SNEwHbJ/+oHZPQvX7o/8jbsUwglZclD+5KsWJl4ESDGyWQKPKlHc5hxvKT6NBO64ad
	 o8J2YmhzjCArwCfsaxIWw3TuwMn38v0DiRROIJis=
Received: from [127.0.0.1] (36-230-36-145.dynamic-ip.hinet.net [36.230.36.145])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 58I4WZOv803198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 12:33:49 +0800
From: "Info - Albinayah 368" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMDE2NDYgVGh1cnNkYXksIFNlcHRlbWJlciAxOCwgMjAyNSBhdCAwNjozMzo0OCBBTQ==?=
Message-ID: <7e8860f1-b5d3-29a8-90db-d9eefcecd0f0@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2025 04:33:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=LvQxyWdc c=0 sm=1 tr=0 ts=68cb8baf
	p=OrFXhexWvejrBOeqCD4A:9 a=LesP0XISgDggMnRgYmeDtg==:117 a=IkcTkHD0fZMA:10
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

