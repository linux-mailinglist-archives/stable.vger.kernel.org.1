Return-Path: <stable+bounces-176746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34EB3D1B5
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DCC3AD3BF
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9B205E25;
	Sun, 31 Aug 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="e8FzE+p6"
X-Original-To: stable@vger.kernel.org
Received: from cmsr-t-1.hinet.net (cmsr-t-1.hinet.net [203.69.209.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5F35957
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633631; cv=none; b=kVnAuHBrB17smauqDvBTtTBj7Nlv/AW9cXhWrQxq9l+wuyDvW4+08DdS0vaYscY+lr21rISRbWXYS9geAldMxWa8Zqua8vruSov5UMZA7wcYrVtqfz5iQaOIG0F69/xD0H0taYGcDVxRQ3dy8PwKbcUXww9/j6fVlI5oVcGQIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633631; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=EX9IYLNi7dX2cfj51h0p8XD1nJWfXTD2pSfUgGkGi9voEBfrHrWvqJ8SHFkP1zeHuDdURpCwTcJ/uE9gbtG8F4YhBtotKN52S9PgqYVLF1vCoN1pu3Vvr596Yu80OTEhSzlPho6Odo7OCJE7QsdjZIYI1XGQMydce9LaQggZSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=e8FzE+p6; arc=none smtp.client-ip=203.69.209.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr5.hinet.net ([10.199.216.84])
	by cmsr-t-1.hinet.net (8.15.2/8.15.2) with ESMTPS id 57V97sbi933221
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 17:07:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1756631274; bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Date;
	b=e8FzE+p6R9psTE2ssfcH0lGyiCTrD8NMLyNzivzPKHlgksPzks4/0IKeHn474bI8y
	 NZdRtKpPeOI+qi4D85vMKN5KLXs0dhk8Pd38hqlwWK24mIIe7nZ+oM3W/1BJpMgm/6
	 HNH+BmTvYzrHey+zFJZl2sI7E9oOeSXi31Syh3jxwwYk7lrT7Y6j+w4zmzsAjYsMd1
	 K/CBC4u3iLtA+ad2/5HDcXj6zwIeCOcvhi7VgLmRIgcSKsYQd03IfD+XBmunAc5WzH
	 Wm28bwQ8kpaLOmuX8wYvCKCUdAE/Md+zCGEprGZOWjvsbs+cBCmjLHNFzM+9qeYK2h
	 3OTPUYLV+2Bhw==
Received: from [127.0.0.1] (218-173-224-25.dynamic-ip.hinet.net [218.173.224.25])
	by cmsr5.hinet.net (8.15.2/8.15.2) with ESMTPS id 57V94sOh942768
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 17:07:53 +0800
From: "Info - Albinayah 957" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <europe-sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gMTU1MDggU3VuZGF5LCBBdWd1c3QgMzEsIDIwMjUgYXQgMTE6MDc6NTIgQU0=?=
Message-ID: <1b9ad53a-34e1-0750-d9a5-952fe594a765@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Sun, 31 Aug 2025 09:07:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=ZJd0mm7b c=1 sm=1 tr=0 ts=68b410ea
	a=JfKTcXGCP3chUBhEG7o28Q==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=OrFXhexWvejrBOeqCD4A:9 a=QEXdDO2ut3YA:10

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

