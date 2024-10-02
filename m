Return-Path: <stable+bounces-80590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 768DD98E1EC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 19:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAF02815B9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148111D1E6A;
	Wed,  2 Oct 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="G5Uys33+";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="iTVqYW5I"
X-Original-To: stable@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA91D0F76;
	Wed,  2 Oct 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891611; cv=none; b=nRQIIJIf8osZSszg1//kwug6zGdbTJWBKYATJnycPZzRVgrZeKShgqp2EK55WL9LbLvpNmy5CsvfhfoKd3aMdFYBE73aVFEPhqmHxAJOHdi2DTVsDptOb5vk41PAGTtz1LguK0yM07LLgD3p7FxFQbBM0WHhYwyVVYHsZsD4njs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891611; c=relaxed/simple;
	bh=xzDmyWASWXLCgJa3ZOSFfKSVU6qunaAVacy1G9LIgho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ko1ddPoZuVkEold4r3rihp3cLAZnmu/5dVsvwc0w4G9KMd6TCByv1PBwB8VWO6NYvzofce/WObXgv+h3GMF2y36u9YLLhdVWVnSoB/g9wcHC1V1M4Pcup69AlfONzCqvvMj9edAQorR0IUMTLvqS0aOu1DN/PfbmU4f642j8vn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=G5Uys33+; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=iTVqYW5I; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 6DDC4E0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727891599; bh=xzDmyWASWXLCgJa3ZOSFfKSVU6qunaAVacy1G9LIgho=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=G5Uys33+uAze9JucKfRUTdBTNN0oVwtrXzFvNfeUcf4m8d4o3VmmES0YoIKamUJVC
	 THHZhs/qLl5w5smDjdoZzbggqVygfivHslRZowijZKr50vx8qvHp7gYUVXh0kW10wD
	 wxGHFkH5uhro6YxXpSViJ9u2akmY97hXFP6RA0j3NQlP9zEvhFlwwH8c3HWG4Dp2LY
	 Zn+yT4mG+/5NquxzM0Dc+caIuyI2gdUcPrD+jiGE1xfy1ZcdnVtOQK8lClethh1zfO
	 mFP+z6ShfcvTejqCjTXihzFUuBC96ZUxMaahhWD8qvwM6DxpG4nPqTZd9AlOc0qACC
	 uS4y7Mw3WY4PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727891599; bh=xzDmyWASWXLCgJa3ZOSFfKSVU6qunaAVacy1G9LIgho=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=iTVqYW5IZRBUQguV7/PAZv0WsjCYdehzsft+VkJGEzrVEmFb1yvH+C4eTj5EXR5jX
	 4ZJ2bak5dwLb42XsIaAdkEx48T7ojYAPWMQMoSlWJqcfXJaQp5ceZoP/PrXFJomUcd
	 b4FHQyV29XhvBOM8ev+p+KolRkafJ1B3uECTxCWIFrUyLe981ez+qZdJA1TdH8MeYo
	 VOLiM7N2MO2wb2hVMhyyTIOsGJ89MV+VTOHsj6EyqNQEZmBzMvyQklGS5EUFhrOmAz
	 ifyOFUnhwM6Pgb8SW1jd7CIFYV0oVV316WZ4HzLTpMGSahN8ES/TjC1CRdmd1qHxvC
	 tk+p/6Vi54qDA==
From: Anastasia Kovaleva <a.kovaleva@yadro.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "linux@yadro.com"
	<linux@yadro.com>
Subject: Re: [PATCH v2 net] net: Fix an unsafe loop on the list
Thread-Topic: [PATCH v2 net] net: Fix an unsafe loop on the list
Thread-Index: AQHbE/lAux7cwDSr4UKHWPOrBxoHvLJzPHsAgACDfYA=
Date: Wed, 2 Oct 2024 17:53:18 +0000
Message-ID: <F4920F6D-1BE9-4268-8301-B69368DD2E1D@yadro.com>
References: <20241001115828.25362-1-a.kovaleva@yadro.com>
 <20241002060240.3aca47cc@kernel.org>
In-Reply-To: <20241002060240.3aca47cc@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32803DBE7F35746A48E353341CFC3E4@yadro.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyIE9jdCAyMDI0IDA2OjAyOjQwIC0wNzAwIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
PiBDb3VsZCB5b3UgYWRkIGEgc2VsZnRlc3Q/IFNob3VsZCBiZSBmYWlybHkgZWFzeSB1c2luZyBZ
TkwsIG5jZGV2bWVtIGlzDQo+IHRoZSBvbmx5IHVzZXIgc28gZmFyLg0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgcmV2aWV3Lg0KDQpPcmlnaW5hbGx5IEkndmUgc3R1bWJsZWQgdXBvbiB0aGlzIGJ1ZyB3
aGlsZSBkZXZlbG9waW5nIGEgZnVuY3Rpb25hbGl0eSBpbiB0aGUNCmlzY3NpdCBkcml2ZXIgdG8g
aW5mb3JtIHRoZSB1c2Vyc3BhY2UgYWJvdXQgYSBmYWlsZWQgaXNjc2kgc2Vzc2lvbg0KYXV0aGVu
dGljYXRpb24uIEkgYW0gbm90IGZhbWlsaWFyIHdpdGggdGhlIG5ldGRldiB0ZXN0IHRvb2xzOyB3
aXRoIFlOTCBhbmQNCm5jZGV2bWVtIHBhcnRpY3VsYXJseS4gVGhlIGNoYW5nZSBzZWVtcyB0cml2
aWFsIGVub3VnaC4gSXQgZml4ZXMgYW4gb2J2aW91cyBidWcNCndpdGggdGhlIGRlbGV0aW9uIG9m
IGFuIGVsZW1lbnQgb2YgYSBsaXN0IHRoYXQgeW91IGFyZSBjdXJyZW50bHkgaXRlcmF0aW5nDQpv
dmVyLiBJIGFzc3VtZSB0aGF0IGl0IHdhc27igJl0IHJlcHJvZHVjZWQgb2Z0ZW4gYmVjYXVzZSB0
aGVyZSBhcmUgZmV3IHVzZXJzIG9mDQp0aGUgZ2VuZXRsaW5rIGFuZCB1c3VhbGx5IHRoZXJlIGlz
IG5vIGxpc3RlbmVycyBvZiBhIGZhbWlseSB3aGlsZSByZW1vdmluZyBhDQpkcml2ZXIgdGhhdCB1
c2VzIGl0Lg0KDQpJZiBpdCBpcyByZWFsbHkgbmVjZXNzYXJ5LCBpdCB3b3VsZCB0YWtlIG1lIGEg
Y291cGxlIG9mIGRheXMgdG8gbWFrZSBhIHRlc3QuIElmDQpub3QsIEkgY2FuIHNlbmQgYSB2MyBw
YXRjaCB0aGF0IGp1c3QgcmVtb3ZlcyBhIHRyYWlsaW5nIFwuDQoNCg==

