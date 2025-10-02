Return-Path: <stable+bounces-183006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BFCBB2722
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 05:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8E13C60B5
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 03:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3523D287;
	Thu,  2 Oct 2025 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="EU4cM75L"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091B19F40B
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759376194; cv=none; b=cdzSkvWs2zPkueH1Av90bMfqub98V3yA1F92ZsLU5MYgR9f3QQPkaDcFsYDsHrFVR74SMGwaZrWLLZBxRXBwfN3hDPhnCFMpbJNd7TTzxztnqpJkz+qGXVGZu13sQsbsyXc5J5hi0QAA4ErgXAfSwCdHtKoQbnN1VekhRSuxtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759376194; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=GYiGuQdK7FD47BV4tlCGHCQofilVEf7jxSkxVcbvj+h+Eoi3KSfX/7fIc6CVEme8PcEMmeiKlhnI/wDRcapy2ahJq1AwzF6mcD9iNSHlh8J7ODlsI4f85nh2EK8xqlz8SGenPgLtC9H4MqV2TSKUFIQzDRRYwDlIOSb8/29O0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=EU4cM75L; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr1.hinet.net ([10.199.216.80])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 5923aRrk636293
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Thu, 2 Oct 2025 11:36:28 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1759376188; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=EU4cM75LLLwIPyk7zhaJLEK58MJMsOeWHlYC1tjnF4cbSbdlCKeZxwAlRu/1u8K+z
	 HJps4n0Gk7eO20FpgkWZ15KsvHerGtDU5oYmdzoZ8pGHCdWhL2hfooe8FqsV208wYU
	 kahyFBGcT/c77luDCIhntVHonetcRXU+rNyVQ/bY=
Received: from [127.0.0.1] (111-246-3-175.dynamic-ip.hinet.net [111.246.3.175])
	by cmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 5923VoPG150584
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Thu, 2 Oct 2025 11:34:31 +0800
From: "Info - Albinayah 204" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMjcxMTUgVGh1cnNkYXksIE9jdG9iZXIgMiwgMjAyNSBhdCAwNTozNDoyOSBBTQ==?=
Message-ID: <354da6c2-6f44-fae9-e047-3bdf9f537464@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Oct 2025 03:34:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=IM+hCRvG c=0 sm=1 tr=0 ts=68ddf2c8
	p=OrFXhexWvejrBOeqCD4A:9 a=32lS2+mBH1dpaGJZ2QcXOA==:117 a=IkcTkHD0fZMA:10
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

