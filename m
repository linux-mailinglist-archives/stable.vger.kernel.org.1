Return-Path: <stable+bounces-180622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FBB88D36
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C40568588
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7E304967;
	Fri, 19 Sep 2025 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="4k4WZAOJ"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF2303A31
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277224; cv=none; b=X5QmvHzf28hlrX2du13czwph1/vd+cOVO7vqgE+b96toi2JVfAbwuNpMCEbK/dg8eCbsyi6620ZjyZwojkfMwXObiZqs8FH9bpOkW+1MRsd91P7b5xuCzGZz5/LSwTewD6+KiwnKK8DzSZXKRqmOsHZAmCPVoNbiOX8yiWN4j8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277224; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=OC4IPn1fZU4dP/ddkT7iV/i9uN30ICB+Wbpc88XWxhoZT45aAe/P8asZii0hxCjAF1d/B/zPm86RUzRwaD15Ec1mDB3L9udvdruTgvD0JiwDP0FXVE3zV6mSTWiDod+h/+vjd/ovA66g21Dzd+8n0F4RIFlEKxDpyP9siFl9018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=4k4WZAOJ; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 58JAK8WU798905
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 18:20:14 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758277214; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=4k4WZAOJR3RbYUZ8Xvf4NWX1MpbOY/Az2RUDYxJvWISJaypdnk7eBsUgcCfoHFpxS
	 yZF3pQqX2qiAN4lo2QKA/Z+ZCHHY/liunwZ4hFsABF/HEbsvIHGBxkRIo7Bd7MjMr9
	 Pj3fzULlpGku2uwtJEX98cdxmWrzhgn3+mRLfXao=
Received: from [127.0.0.1] (114-26-192-195.dynamic-ip.hinet.net [114.26.192.195])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 58JAFaB1005645
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 18:16:34 +0800
From: "Info - Albinayah 293" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNzMyNzUgRnJpZGF5LCBTZXB0ZW1iZXIgMTksIDIwMjUgYXQgMTI6MTY6MzIgUE0=?=
Message-ID: <4824fce3-a271-ff87-8a92-4b7da9498bcd@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Sep 2025 10:16:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=D/nkKeRj c=0 sm=1 tr=0 ts=68cd2d84
	p=OrFXhexWvejrBOeqCD4A:9 a=b8RB/zUUWYz0H4HqEF/G2Q==:117 a=IkcTkHD0fZMA:10
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

