Return-Path: <stable+bounces-189207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9AC04E8D
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C141AE1D7C
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86192FCC1B;
	Fri, 24 Oct 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QbSxlets"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C412FBDF1
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292808; cv=none; b=V8gIBxZQmBqTrgsKgWdCys7kKAgqwALoeU71X2gg1rSQ3DrOv8Jq3bp/UD8OXrEs1Tb+fEQnEylQrskp0B11R8ukeAoRFW7B/ii2qZ6GSTE54Ta4f56NTTm6e8pSM93R/RPWhOIhLqm7Smmv/8gxRO7uHY1Ede5T2a4TX/UHuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292808; c=relaxed/simple;
	bh=2/OvrSThn/whOu17RzuwEzZ0hjnTVL7xcH1I+eAJTOA=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=pPPmqVeNe2tbZdwXBc6fAzAsLUNYWTb9yPgeTBWXZ+qEw5WXqFtxbcSqo7aOQR0ZoFiLj9NrQza7hAwDUhW2hVQ3ATYYyHsOQiNex2dV+0fEoBGyMZdQ6WpXyFmjyLDLpzc/d28uNndpEKu/6Do3TpEDyP+E7L8absLNCa/vjpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QbSxlets; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761292803; bh=2/OvrSThn/whOu17RzuwEzZ0hjnTVL7xcH1I+eAJTOA=;
	h=From:To:Cc:Subject:Date;
	b=QbSxletsJLJRniYTjCSw87ba8oX+w4PH1EYR0ZoZOJsLJNsbGxCIZT4IVs8vRpLpq
	 fhiu27DP/RZl3ih3fdFD/q+MaU1Q6GA73Byte+Y1o9128TpUb2++ZpbWp/bCNY8ZJX
	 3AioOP5gKx8aYyVkF7pdbuWe8t8O8VVto86Wp5js=
X-QQ-FEAT: Xqh9UYnCrXDUV1KpMGkoKkdjEbplCNXE
X-QQ-SSF: 0000000000000080000000000000
X-QQ-XMRINFO: OJlEh3abS6gXi5NWrXbD0WI=
X-QQ-XMAILINFO: MLJK4jN30nrK8edUrh3hatL9Gzti9JRpBMyw91u1EbFo3U6sJaF6tG41LouoxE
	 3Cabr8yPzVUUovX8SX6bwVyqzBP6WikLe+GBDzKji5XEt7n/4QaCjvKbaW12FR7Pi2rJpoeDYUAtO
	 QKyV7+Db9hCZdYCO6cnMmYoHxHOtrOTb4j4is/9vC2OPYzsdk+tugdicz4hcivMKbW79QFY8FQT03
	 xBUO2PZ/69I+E2DlZGkk1DyMN1S5Rmdzq63O2SxtCBiTGOKocZVpSliIYb5dWRB9nozjPhHquCz3F
	 OI4ci1ek2SH+d04OVxF7iMbzqYFDKul8SGywIh5jVIKE0zd/b4oB9p7qZNT/iUXWkj/2vLBQpC+Sl
	 8JLko8+R9u8aEY/ZCIgvQeTQ5BGCUnA3+bGaUzJbOeHjtLiRmNN0qamWX5SHbNxYYCvDwStIxTWmn
	 MMznkS7EndZ+tcgfKvbvibwsMi4YEYwy4O3BsA35Ni6lCKIFUeNyKi/cVX1SNFAfJO4opL0oAw+XF
	 2mijknzbTmA5j/QR26OjAQgmL2YRvjH1Akn3fmNagmxC3ndos5wLmBDDMKuCdJr5n7h7XHaDJPMhG
	 10yGtuVpTBdcmOR3ScY7nqDN8Vi6nXjfQJP/LXEATyIoZKmHFyXjMwHYjOz0aBbHmZY/Tfq2PsyXz
	 ol2q1ZwZI2MysL7yOviB7nfT5YZU09n25ThRZN+z31htTTp2MelVeYwGZ7uAoneir7dKOiwM92LM5
	 yevV0PGxvNNQD3Tt7CdyowH8+6vtuQcqPDSQvNy7jn4t3P21We1ZfTyHoF0utbN9cZXBTbN99O0wX
	 wQrcz3lU+j0YNzHFpMup9XtAenF6tayCshRS11MTYVLeAPB6ScSTGlKcrs2cv9UepOhZYyVSwFGQD
	 vnL9BadLnH0/HZe5FDsfPe9Gp+oBxdMXONdktUTBtDyFwhogzN1sAbdhE5Xxr05YvmRvqmqkrirpL
	 Uv0wT/Fwq458JjTKVEw6FDW+caz5+0HzowF6n6lA==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail365t1761292803t667248
From: "=?gb18030?B?1cXF9A==?=" <1805692831@qq.com>
To: "=?gb18030?B?c3RhYmxl?=" <stable@vger.kernel.org>
Cc: "=?gb18030?B?cmVncmVzc2lvbnM=?=" <regressions@lists.linux.dev>
Subject: SPI flash transfer failed
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
Date: Fri, 24 Oct 2025 16:00:02 +0800
X-Priority: 3
Message-ID: <tencent_787FB7889BCFB4E55EE5985A3DC22A1B1E08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

SGksCkR1cmluZyB0aGUgc3RhYmlsaXR5IHRlc3QsIEkgcmVwZWF0ZWRseSByZWJvb3RlZCAx
MDAgZGV2aWNlcyBhbmQgdGhlbiBvYnNlcnZlZCB0aGVpciBzdGFydHVwIGxvZ3MuIFdoZW4g
dXNpbmcga2VybmVsNC54LCB0aGV5IGFsbCB3b3JrIHZlcnkgd2VsbC4gQWZ0ZXIgMTAwMCBj
b25zZWN1dGl2ZSB0ZXN0cywgbm8gcHJvYmxlbXMgaGF2ZSBvY2N1cnJlZC4gSG93ZXZlciwg
d2hlbiBJIHVwZGF0ZWQgdGhlIGtlcm5lbCB2ZXJzaW9uIHRvIDUueC82LngsIGFmdGVyIHRl
c3RpbmcgaW4gdGhlIHNhbWUgZW52aXJvbm1lbnQgZm9yIGFib3V0IHNldmVyYWwgZG96ZW4g
dGltZXMsIHNvbWUgZGV2aWNlcyBleHBlcmllbmNlZCBhYm5vcm1hbGl0aWVzLiBJIHRlc3Rl
ZCBtYW55IGRpZmZlcmVudCB2ZXJzaW9ucyBhbmQgYWxtb3N0IGFsbCB2ZXJzaW9ucyB3aXRo
IGtlcm5lbCZndDs1LnggaGFkIHByb2JsZW1zLgoKCldoZW4gSSB3YXMgc2VhcmNoaW5nIGZv
ciByZWxhdGVkIHF1ZXN0aW9ucywgSSBmb3VuZCB0aGF0IG1hbnkgcGVvcGxlIGhhZCBlbmNv
dW50ZXJlZCB0aGlzIHNpdHVhdGlvbi4KaHR0cHM6Ly9mb3J1bS5vcGVud3J0Lm9yZy90L3Bh
dGNoLXNxdWFzaGZzLWRhdGEtcHJvYmFibHktY29ycnVwdC83MDQ4MApodHRwczovL2dpdGh1
Yi5jb20vb3BlbndydC9vcGVud3J0L3B1bGwvMTMxNDcKCgoKCmxvZzoKWyAmbmJzcDsgODku
NDMxODk3XSBzcGktbm9yIHNwaTAuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMApbICZu
YnNwOyA4OS40MzIzNjldIHNwaV9tYXN0ZXIgc3BpMDogZmFpbGVkIHRvIHRyYW5zZmVyIG9u
ZSBtZXNzYWdlIGZyb20gcXVldWUKWyAmbmJzcDsgODkuNDM2NTU5XSBibGtfdXBkYXRlX3Jl
cXVlc3Q6IEkvTyBlcnJvciwgZGV2IG10ZGJsb2NrMTAsIHNlY3RvciAzOTA0IG9wIDB4MDoo
UkVBRCkgZmxhZ3MgMHg4MDAgcGh5c19zZWcgNCBwcmlvIGNsYXNzIDAKWyAmbmJzcDsgOTAu
NDcxMjE0XSBzcGktbm9yIHNwaTAuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMApbICZu
YnNwOyA5MC40NzEzNDldIHNwaV9tYXN0ZXIgc3BpMDogZmFpbGVkIHRvIHRyYW5zZmVyIG9u
ZSBtZXNzYWdlIGZyb20gcXVldWUKWyAmbmJzcDsgOTAuNDc1NTQ0XSBibGtfdXBkYXRlX3Jl
cXVlc3Q6IEkvTyBlcnJvciwgZGV2IG10ZGJsb2NrMTAsIHNlY3RvciAzOTEyIG9wIDB4MDoo
UkVBRCkgZmxhZ3MgMHg4MDAgcGh5c19zZWcgMyBwcmlvIGNsYXNzIDAKWyAmbmJzcDsgOTEu
NTExMjYwXSBzcGktbm9yIHNwaTAuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMApbICZu
YnNwOyA5MS41MTEzOTZdIHNwaV9tYXN0ZXIgc3BpMDogZmFpbGVkIHRvIHRyYW5zZmVyIG9u
ZSBtZXNzYWdlIGZyb20gcXVldWUKWyAmbmJzcDsgOTEuNTE1Mzg5XSBibGtfdXBkYXRlX3Jl
cXVlc3Q6IEkvTyBlcnJvciwgZGV2IG10ZGJsb2NrMTAsIHNlY3RvciAzOTIwIG9wIDB4MDoo
UkVBRCkgZmxhZ3MgMHg4MDAgcGh5c19zZWcgMiBwcmlvIGNsYXNzIDAKWyAmbmJzcDsgOTIu
NTUxMjE0XSBzcGktbm9yIHNwaTAuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMApbICZu
YnNwOyA5Mi41NTEzNDldIHNwaV9tYXN0ZXIgc3BpMDogZmFpbGVkIHRvIHRyYW5zZmVyIG9u
ZSBtZXNzYWdlIGZyb20gcXVldWUKWyAmbmJzcDsgOTIuNTU1MzQzXSBibGtfdXBkYXRlX3Jl
cXVlc3Q6IEkvTyBlcnJvciwgZGV2IG10ZGJsb2NrMTAsIHNlY3RvciAzOTI4IG9wIDB4MDoo
UkVBRCkgZmxhZ3MgMHg4MDAgcGh5c19zZWcgMSBwcmlvIGNsYXNzIDAKWyAmbmJzcDsgOTIu
NTYyMTY3XSBTUVVBU0hGUyBlcnJvcjogRmFpbGVkIHRvIHJlYWQgYmxvY2sgMHgxZGUwNWU6
IC01ClsgJm5ic3A7IDkyLjU3MjgzNF0gU1FVQVNIRlMgZXJyb3I6IFVuYWJsZSB0byByZWFk
IGZyYWdtZW50IGNhY2hlIGVudHJ5IFsxZGUwNWVdClsgJm5ic3A7IDkyLjU3ODM4OF0gU1FV
QVNIRlMgZXJyb3I6IFVuYWJsZSB0byByZWFkIHBhZ2UsIGJsb2NrIDFkZTA1ZSwgc2l6ZSBk
NDUwClsgJm5ic3A7IDkyLjU4NTI3Ml0gU1FVQVNIRlMgZXJyb3I6IFVuYWJsZSB0byByZWFk
IGZyYWdtZW50IGNhY2hlIGVudHJ5IFsxZGUwNWVdClsgJm5ic3A7IDkyLjU5MTg0Nl0gU1FV
QVNIRlMgZXJyb3I6IFVuYWJsZSB0byByZWFkIHBhZ2UsIGJsb2NrIDFkZTA1ZSwgc2l6ZSBk
NDUw
i

