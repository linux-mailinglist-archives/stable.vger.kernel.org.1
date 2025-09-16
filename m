Return-Path: <stable+bounces-179712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51EEB592B5
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428D71B27AC8
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D129B778;
	Tue, 16 Sep 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="49cZ8JUC"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132429AB1D
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016214; cv=none; b=MWLQL9o9K5MExyBOzYp3oxmuWQ3wDmpeTnxdqI2mpvodzrh+606ip+w+9MhKAtk/SHbtfspRJJYynuGVaGdjnsl+4hR3FxrE+mCqW1IoTutjGQ2+kVQkxjCzuMsHByQBzOhot/sKI5IjVqL2YgUoy68qt7GzRvMA26NYlJSSUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016214; c=relaxed/simple;
	bh=/OMbF9owtaHhE9k8kJ20eu1/oMpRys03hx98tByb++U=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=X41UAWPBvPO5XiSJucSzT6hMxG8CdMbC6DVutiKSgVJltNZT7WfFoDnUhtP9wELdoHj9Q9lTB+VgC61CN7FDX8GaHIXGrU20Gwrzc3jyk/tbLdbixy623+Wl6wS7kN05SZdj3UDkY6XekFgLa7RHGWl6qaUy9yvU6x0h9AkezOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (1024-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=49cZ8JUC; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr6.hinet.net ([10.199.216.85])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G9o894726183
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 17:50:10 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=ms29.hinet.net;
	s=default; t=1758016210; bh=G8ZRgE8IGNZe3GIsPWp3hDJnuTo=;
	h=From:To:Subject:Date;
	b=49cZ8JUCiihdXp8LwRSfqRpXaUpduL/UfkshDXROcb7H+BuBDeEUctyOzvRMeg8S+
	 j1LU/BuNoBhCJUuCo1lnhsVZ5c4MgIup5/5SDnpxOBMYLdT9TSxrvbdx7CryjUfMbu
	 iO/e7quYcogVB8DTiNvKEi/DbpTG37y3WwUzObas=
Received: from [127.0.0.1] (111-249-37-177.dynamic-ip.hinet.net [111.249.37.177])
	by cmsr6.hinet.net (8.15.2/8.15.2) with ESMTPS id 58G9lKS6114920
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 17:47:57 +0800
From: "Info - Albinayah 370" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Info - Albinayah." <sales@albinayah-group.com>
Subject: =?UTF-8?B?TmV3IFNlcHRlbWJlciBPcmRlci4gNDA2MDggVHVlc2RheSwgU2VwdGVtYmVyIDE2LCAyMDI1IGF0IDExOjQ3OjU1IEFN?=
Message-ID: <c3179cd8-e103-7716-3936-2a9d3e3d6eb6@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2025 09:47:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-HiNet-Brightmail: Spam
X-CMAE-Score: 100
X-CMAE-Analysis: v=2.4 cv=UojANPwB c=0 sm=1 tr=0 ts=68c9324e
	p=OrFXhexWvejrBOeqCD4A:9 a=k2O5UOonHBZlV6WETQWJMg==:117 a=IkcTkHD0fZMA:10
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

