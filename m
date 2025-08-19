Return-Path: <stable+bounces-171775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668CEB2C2A3
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56CB3BDBF6
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE473314DB;
	Tue, 19 Aug 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="fhTZ1hDQ";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b="hz/iib1k"
X-Original-To: stable@vger.kernel.org
Received: from mail180-9.suw31.mandrillapp.com (mail180-9.suw31.mandrillapp.com [198.2.180.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288832C32C
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604987; cv=none; b=BAyHRhvPhdxNpcoIcY6zbV/OcxZEJJFfUOoSvpJq6Bw/RhH1x6cSRwjbwpXeI9vvMZUFAq3jgisideRAaASu1Ymx9yYnPcWOM1RWH/vOzBCSPh3q6UzvUaSBgVE2B4CHE+HpkM/aW0q+4B+Vc2+Qo2LoZC//42Ssa6bzBhrKPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604987; c=relaxed/simple;
	bh=JSOko7q7IYrHE5QtxvuPBfgOHBTZZh9102WYxuGKcoY=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=s0HUJpppFk0FhRFy/X87nuwkjTycSzMLfGTfV2+MNP+1dbT6uC52sxOTxnOCRFuUEktfaKu1fROqBJcev3m7yIeODkGETODx65AWFpMQ9Ac85gpmNSQib/2bo2Kq2oHNaDf9MhL1Dh/aShFqtNis29d8VlhmGrW6Dt1i+5MZQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=fhTZ1hDQ; dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b=hz/iib1k; arc=none smtp.client-ip=198.2.180.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1755604985; x=1755874985;
	bh=lrYqIkcsta9jivf7dLS5/NMYx58zstFgGq30HE0QRQ4=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=fhTZ1hDQ1tFvLG9TiuaoSYroOIGYdPclrCw7W/ByBcQVwINtP3wJX1Avc9G8CEUYD
	 f5et/MxeaXeCC5offrWTsd7o0Qp68b5iRWrQisDm2OyFTqjirArk5Kw/8Zj/V0ty4/
	 fdJs5h4jg9yqSJslriP6mnQUxUQImBXEgo5hM152wesCGieznsU1xSz03BaChpax4h
	 P6hkE+JnU9Fq9j0VlA7Gz+xbJhvvqGaOhoTtGyRUFYXeEz4C4BiUABCmAASFNx2Fud
	 JZn+3jtaJu5uo6YxDjmn3uBgI524hGk1gxncMPxFDHm+sVi8uimmP/OI/vNVwr5EyE
	 xhVPnMUiRCOlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1755604985; x=1755865485; i=yann.sionneau@vates.tech;
	bh=lrYqIkcsta9jivf7dLS5/NMYx58zstFgGq30HE0QRQ4=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=hz/iib1kQJ5gNu77FMkiA0Xh4mXgTqU2OlQLphc6cGh3LVZ3m0ltJCrnw/0a971f/
	 T7lu4oKkPj1vupZX8HhumsmhsLVlVwgqKsnPUWkgtBMUJwiZgXMOQGLeoUXS9QF85r
	 ahbtPODsj9N7yJzK51pCfNjazo25FtypGO21NktIe9ejcAACKTb9pe3UnHw3PSNX+Q
	 mXU3mbwIVG3wThjlkTEFme3sldLGe7AKzwXdbZN26NWM9pzYiMrd1pqY1Z81BOjZhU
	 qwzB6sR37XAt/M0/Lw04H7hfC1sRV1O4wIUFG8CR1ZOtQxnyqejUe4HFArXKW4fK0B
	 5Gng4mivWaiKw==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-9.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4c5pBK1r6HzK5vlNt
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:03:05 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH]=20ACPI:=20processor:=20idle:=20Check=20acpi=5Fbus=5Fget=5Fdevice=20return=20value?=
Received: from [37.26.189.201] by mandrillapp.com id 44d75d05d4084f3590cd14ccfb96b2bf; Tue, 19 Aug 2025 12:03:05 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1755604983109
Message-Id: <032a8ac9-0554-49b6-a8e4-fdeb467f8327@vates.tech>
To: stable@vger.kernel.org
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Li Zhong" <floridsleeves@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Teddy Astie" <teddy.astie@vates.tech>, "Dillon C" <dchan@dchan.tech>
References: <20250819115301.83377-1-yann.sionneau@vates.tech>
In-Reply-To: <20250819115301.83377-1-yann.sionneau@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.44d75d05d4084f3590cd14ccfb96b2bf?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250819:md
Date: Tue, 19 Aug 2025 12:03:05 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 8/19/25 14:00, Yann Sionneau wrote:
> From: Teddy Astie <teddy.astie@vates.tech>
> 
> Fix a potential NULL pointer dereferences if acpi_bus_get_device happens to fail.
> This is backported from commit 2437513a814b3 ("ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value")
> This has been tested successfully by the reporter,
> see https://xcp-ng.org/forum/topic/10972/xcp-ng-8.3-lts-install-on-minisforum-ms-a2-7945hx
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> Signed-off-by: Teddy Astie <teddy.astie@vates.tech>
> Signed-off-by: Yann Sionneau <yann.sionneau@vates.tech>
> Reported-by: Dillon C <dchan@dchan.tech>
> Tested-by: Dillon C <dchan@dchan.tech>
> ---

Hello Greg, all,

This should be picked for v5.4, v5.10 and v5.15 branches as it's already 
been backported in v6.0 and v6.1.

I already reached out about this a few weeks ago, I just waited for the 
patch the be tested before sending it.

Regards,

-- 


Yann Sionneau | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



