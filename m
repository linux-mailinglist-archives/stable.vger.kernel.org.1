Return-Path: <stable+bounces-176733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D7B3C72D
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 03:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DE03B1E31
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 01:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436EC21A437;
	Sat, 30 Aug 2025 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ELQ9q3ms"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3761DFE12;
	Sat, 30 Aug 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518544; cv=none; b=LeqH9BM/eLZJ3j/CaNDeE/fke1cpjbD2D6zEj7R4Rcb4DmVmza54sJTU7jiYb05BuS/pa8+GVOf8t0SJLJRi3ENKzJSf7me99w/4jm1mxvZregokKfUAgN1Ko2WJf++svoQkH7jiZLO9PBy8oRuwtKfP6tNdvxdanv0FnX+aJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518544; c=relaxed/simple;
	bh=7Hd+IKkI7LueDUZIZaO72mgRAKubR2asw9SWh4jRMY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SgRiq5kFx1fSexaDqeUXZ1b4UUmUbRhcMSFjE+Phcwpxv6y+16lWV27RpVJEptw1FujSpjmVzyR5rzmP6e7VR+9NzQent3j1gGpq3OSKs2lREM64Cz60Vn/llNmsRxSb6btn2yAUuIoEBiW1Gtczw1NbRZumNIWXqZ0WE1qRec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=ELQ9q3ms reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=yDf6R8OVR4Mv+z5f263aPwRbugqrNKlI+W4Ql3f8lGI=; b=E
	LQ9q3msednwRY90iZzFYZRu1iM0djK52o1KsWiUXD7EPDeAJ/8c94MjKcajEUiTw
	PrdsVzuFEKr/itCRlU9m4sixRMrOjIuinh0I5VaWPwcQ5vILp8iJZ1+zoMJS/wUk
	d7ANyRrX1ZOndMmcHKTi3GW24DYx2FJcxZUgJN7500=
Received: from yangshiguang1011$163.com ( [1.202.162.48] ) by
 ajax-webmail-wmsvr-40-149 (Coremail) ; Sat, 30 Aug 2025 09:48:26 +0800
 (CST)
Date: Sat, 30 Aug 2025 09:48:26 +0800 (CST)
From: yangshiguang  <yangshiguang1011@163.com>
To: "Vlastimil Babka" <vbabka@suse.cz>
Cc: "Harry Yoo" <harry.yoo@oracle.com>,
	"Matthew Wilcox" <willy@infradead.org>, akpm@linux-foundation.org,
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
	glittao@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	yangshiguang <yangshiguang@xiaomi.com>, stable@vger.kernel.org
Subject: Re:Re: [PATCH v3] mm: slub: avoid wake up kswapd in
 set_track_prepare
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <9dbd300c-240b-477f-ba03-8a17c7c2b84b@suse.cz>
References: <20250825121737.2535732-1-yangshiguang1011@163.com>
 <aKxZp_GgYVzp8Uvt@casper.infradead.org>
 <54d9e5ac-5a51-4901-9b13-4c248aada2d7@suse.cz> <aK6U61xNpJS0qs15@hyeyoo>
 <6e1ab9d8.6595.198ea7d7a78.Coremail.yangshiguang1011@163.com>
 <fc6f7372-efb4-48e3-b217-c8bec0065b97@suse.cz>
 <4d271e7e.6bea.198f596bd15.Coremail.yangshiguang1011@163.com>
 <9dbd300c-240b-477f-ba03-8a17c7c2b84b@suse.cz>
X-NTES-SC: AL_Qu2eBPmat00r4CSYbOkfmUgRj+k6WsK3s/sn3oNfP5B+jCLr9QwKYn5CAn3N8/OKBxCuvii7ST1E+uBAfIh4eIsl8V52gcVznlkkp5TdwoVTRA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15cc44af.7a6.198f8a95fb5.Coremail.yangshiguang1011@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:lSgvCgDnf7xqWLJoc58kAA--.142W
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/1tbiEAa45Wixi0ReDAADsM
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkF0IDIwMjUtMDgtMjkgMjE6MDg6NTgsICJWbGFzdGltaWwgQmFia2EiIDx2YmFia2FAc3Vz
ZS5jej4gd3JvdGU6Cj5PbiA4LzI5LzI1IDEzOjI5LCB5YW5nc2hpZ3Vhbmcgd3JvdGU6Cj4+IEF0
IDIwMjUtMDgtMjcgMTY6NDA6MjEsICJWbGFzdGltaWwgQmFia2EiIDx2YmFia2FAc3VzZS5jej4g
d3JvdGU6Cj4+IAo+Pj4+IAo+Pj4+Pgo+Pj4+IAo+Pj4+IEhvdyBhYm91dCB0aGlzPyAKPj4+PiAK
Pj4+PiAgICAgICAgIC8qIFByZWVtcHRpb24gaXMgZGlzYWJsZWQgaW4gX19fc2xhYl9hbGxvYygp
ICovCj4+Pj4gLSAgICAgICBnZnBfZmxhZ3MgJj0gfihfX0dGUF9ESVJFQ1RfUkVDTEFJTSk7Cj4+
Pj4gKyAgICAgICBnZnBfZmxhZ3MgPSAoZ2ZwX2ZsYWdzICYgfihfX0dGUF9ESVJFQ1RfUkVDTEFJ
TSB8IF9fR0ZQX05PRkFJTCkpIHwKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgX19HRlBfTk9XQVJOOwo+Pj4KPj4+SSdkIHN1Z2dlc3QgdXNpbmcgZ2ZwX25lc3Rl
ZF9mbGFncygpIGFuZCAmIH4oX19HRlBfRElSRUNUX1JFQ0xBSU0pOwo+Pj4KPj4gCj4+IEhvd2V2
ZXIsIGdmcCBoYXMgYmVlbiBwcm9jZXNzZWQgYnkgZ2ZwX25lc3RlZF9tYXNrKCkgaW4KPj4gc3Rh
Y2tfZGVwb3Rfc2F2ZV9mbGFncygpLgo+Cj5BaGEsIGRpZG4ndCBub3RpY2UuIEdvb2QgdG8ga25v
dyEKPgo+PiBTdGlsbCBuZWVkIHRvIGNhbGwgaGVyZT8KPgo+Tm8gdGhlbiB3ZSBjYW4gaW5kZWVk
IGp1c3QgbWFzayBvdXQgX19HRlBfRElSRUNUX1JFQ0xBSU0uCj4KPk1heWJlIHRoZSBjb21tZW50
IGNvdWxkIHNheSBzb21ldGhpbmcgbGlrZToKCj4KCnN1cmUuIEV4cHJlc3MgY2xlYXJseS4KCgo+
LyoKPiAqIFByZWVtcHRpb24gaXMgZGlzYWJsZWQgaW4gX19fc2xhYl9hbGxvYygpIHNvIHdlIG5l
ZWQgdG8gZGlzYWxsb3cKPiAqIGJsb2NraW5nLiBUaGUgZmxhZ3MgYXJlIGZ1cnRoZXIgYWRqdXN0
ZWQgYnkgZ2ZwX25lc3RlZF9tYXNrKCkgaW4KPiAqIHN0YWNrX2RlcG90IGl0c2VsZi4KPiAqLwo+
PiBzZXRfdHJhY2tfcHJlcGFyZSgpCj4+IC0+c3RhY2tfZGVwb3Rfc2F2ZV9mbGFncygpCj4+IAo+
Pj4+ICA+LS0gCj4+Pj4+Q2hlZXJzLAo+Pj4+PkhhcnJ5IC8gSHllb25nZ29uCg==

