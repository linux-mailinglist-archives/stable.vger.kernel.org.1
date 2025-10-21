Return-Path: <stable+bounces-188348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68578BF6E51
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 051D6505E1F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9433893D;
	Tue, 21 Oct 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b="UWL+wvey"
X-Original-To: stable@vger.kernel.org
Received: from cmsr-t-2.hinet.net (cmsr-t-2.hinet.net [203.69.209.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CC33859C
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.69.209.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054664; cv=none; b=ZP2UnhTw/MGSFxrP5tdveDbihJ8i79NXPFWSfn86NHKz6/cZzedg6a0NW4dx1l91OMtJ6w4ZFV6J5qZ8gcVaHjzrrlKFb9UWJ/v9/871NqEtd444wI+LJ9K44iQCROv9AEaomTnGd9YMnezxWIfixN/qHbMQ4ZMyj2983yg2+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054664; c=relaxed/simple;
	bh=y+IX4V7HeNVL6fvhtsPtFPoQGQJrmRnXwH1Tj/P+LMw=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=stsI3sbm6UwsRIL6J59wCgpQO1bLZQdURJ07rc4Hl449sUwx+jldlZRn6JqJ391eSASMPFgPowEPtcqKmI5v+PAQhBeZF35RVPMtlUfkLbyJteWA8uCpDNnJQ+BLxXLoXIyw7PW6HfJeVFu32wuVsbpLCKBhRveBYb+y+xu97i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net; spf=pass smtp.mailfrom=ms29.hinet.net; dkim=pass (2048-bit key) header.d=ms29.hinet.net header.i=@ms29.hinet.net header.b=UWL+wvey; arc=none smtp.client-ip=203.69.209.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ms29.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms29.hinet.net
Received: from cmsr1.hinet.net ([10.199.216.80])
	by cmsr-t-2.hinet.net (8.15.2/8.15.2) with ESMTPS id 59LDEPpI926770
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:14:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms29.hinet.net;
	s=s2; t=1761052465; bh=y+IX4V7HeNVL6fvhtsPtFPoQGQJrmRnXwH1Tj/P+LMw=;
	h=From:To:Subject:Date;
	b=UWL+wveyAvnnXB868Uak4Np3f6ScXo15iMF/+3gTZMyStY+6Xn9eFArxP6Rgfdj/S
	 XQujiLF5iQVuBmPSucO57y8lxf+GbO/tcG84ZlRY4uf7DPG8kpgmQiwyNj3VAycMXV
	 l6szZxD5JiFkFgaUs6vY3zTSsNuU2ss2ULUpp8k7HXHR1f+GeFKnBIYF7g3RTyg8Tx
	 KE0MjCIBGPzj4jBrxGOPIwkVwmFV4Yu6SCQ0sA5NAOEeaVbSIm++e1GYwkvs5FiLHL
	 6nT0pACtEApQ5D3pt+ffWudWEjQaLYMwOeS/M8KSSo2bvHGHMWbPuWWF2ZlQ29VTXI
	 J4DakO4ZnMb5w==
Received: from [127.0.0.1] (118-170-214-10.dynamic-ip.hinet.net [118.170.214.10])
	by cmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 59LDB18h972054
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 21:14:24 +0800
From: "Purchase - PathnSitu 737" <Stable@ms29.hinet.net>
To: stable@vger.kernel.org
Reply-To: "Purchase - PathnSitu." <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TmV3IE9jdG9iZXIgT3JkZXIuIDEwOTM4IFR1ZXNkYXksIE9jdG9iZXIgMjEsIDIwMjUgYXQgMDM6MTQ6MjMgUE0=?=
Message-ID: <02495f50-5a6b-2013-059c-71ab014294f0@ms29.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Oct 2025 13:14:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=I57GR8gg c=1 sm=1 tr=0 ts=68f78731
	a=JOw0GWazgAxnFcuvyDQgqQ==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
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

