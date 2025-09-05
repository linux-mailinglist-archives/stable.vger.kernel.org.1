Return-Path: <stable+bounces-177868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FAB4611C
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1C85C7B00
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A436CE1A;
	Fri,  5 Sep 2025 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="izXnHi8M"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44130B534
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094777; cv=none; b=jHaSrUvlbGdoIu7k3BapfGhRHrIMRIWjM4JgEDMO2DgJBSGWYtFmoqUmwEnwOMuXg59HkP8bsy7y04QWcae33cluLuLg+yqNIY0DoBcdWh8asrtycBG//BddBZO+Aj6vZqHNXmGGYUOYIX8cMUGPrML/WE/RtTyScqEBwmun70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094777; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=hOMf+ISeHzVq3oRztzORZNNTVLAJl4GHugaSZXTYbBQTOmYlK/fbrrhg8xuIVAPAH2O4IgYhJ/Sa6mgbgwRqymOO3PtloS/GaLAgWKrqjAwReex4IplMAKEKYsVTXW0GnNs80q8BreGAnc3MD9rYSFvr1Mo52lbC2Ysc3ns31Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=izXnHi8M; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 585HAHtZ544454
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sat, 6 Sep 2025 01:10:17 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1757092218; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=izXnHi8MbH2frqRL1QxY7kEkyDCdYChiGQkPh5q3oc2X5o9uDpy+j9D/JT6Oz0Pff
	 oPmjrUHVsJS3iYlwPIISWrG4ncOIMq5czzLJNsFY6zfmk3NQ8EzDjw0yjF/lclTBjE
	 Exc0Zw9tX6wqWoZXsa9TR3wXCXHqxlW7lOppXed0=
Received: from [127.0.0.1] (1-34-243-55.hinet-ip.hinet.net [1.34.243.55])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 585H6MUG381368
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sat, 6 Sep 2025 01:08:41 +0800
From: "Info - Albinayah 684" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gODk4NzkgRnJpZGF5LCBTZXB0ZW1iZXIgNSwgMjAyNSBhdCAwNzowODo0MCBQTQ==?=
Message-ID: <bfa52cdd-e4fa-7db6-76f6-4b66d6a3157c@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Sep 2025 17:08:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=Xbkqz555 c=0 sm=1 tr=0 ts=68bb191a
	p=OrFXhexWvejrBOeqCD4A:9 a=zRdXdCHvnK3BYvDO02d85w==:117 a=IkcTkHD0fZMA:10
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

