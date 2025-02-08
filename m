Return-Path: <stable+bounces-114360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF781A2D306
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 03:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA763AC29B
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3411465AB;
	Sat,  8 Feb 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="o1twXTgU"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5BC15382E
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738981213; cv=none; b=Pfdp8mf8UpWEZliooCPxsQWPb7vP9VCdryc4bCSSZXoaTZMPQoP2PrzyzjqyO8XZ2jGSfHlNdcAwVfujbRm8bJHc99sG4W5suT+/fRm8JbvlJws6K/4hOqkzZt/vg5dFrFmZytUuwe5e+SZDUT9qoU9wAOAsQOsj6q6bCX1GtEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738981213; c=relaxed/simple;
	bh=q7mZHqpvMlIZjgmWLBJV1omoZGzAmfj1TEqOGonlosg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aGPCpuI+EIb2mem+0qhLyALTCdtmGYgqbDK7MgTXsr00YxQ++Yyf6od5SzQ+2Sw7DfIQOv2gpAZCTumeo1JI92sVXA/HrCX5kWQZncpANWzdT1wuKIOUt49xzqJY/9bKNtWw6w16lTD7/XxO1Dbbj64R/UHzkqrfT+YDv4M7CVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=o1twXTgU reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=dQauojdS2R5nfLHKzFKKud3M2l0JsT5FZo4Ks2BS664=; b=o
	1twXTgUKbdTHJXol2DzmSo6nGN+gJY6A2/P3DJ2P4wiFQKVhAOAkHUUf4Enncdsm
	aXKdhyASoB+I8z1mmhmc2DhHVhxGFqSqK3w5VWK+DKr+86hssKs1eOW3HnuIg5xy
	TPdQdBoavPSjxaeCWrhzk+GmBPmybJ7Hic29mOE+ks=
Received: from jetlan9$163.com ( [120.244.194.36] ) by
 ajax-webmail-wmsvr-40-127 (Coremail) ; Sat, 8 Feb 2025 10:18:13 +0800 (CST)
Date: Sat, 8 Feb 2025 10:18:13 +0800 (CST)
From: "Wenshan Lan" <jetlan9@163.com>
To: stable@vger.kernel.org
Cc: "Vladimir Oltean" <vladimir.oltean@nxp.com>,
	syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com,
	"Florian Fainelli" <florian.fainelli@broadcom.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>
Subject: Re:[PATCH 6.1.y] net: dsa: fix netdev_priv() dereference before
 check on non-DSA netdevice events
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <20250207070643.2327-1-jetlan9@163.com>
References: <20250207070643.2327-1-jetlan9@163.com>
X-NTES-SC: AL_Qu2YCvWTvkgi5SiYYOkfmkYUj+83Ucu0s/4v3IRRP5l4jA/p+DEHekJSOlfaz860FB6ImgmGczNux8lHdJhUW5waH7Uh48/JzTahzTeiQ4QMnQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6c68da15.15c2.194e359b1b1.Coremail.jetlan9@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fygvCgD3P6vlvqZnFWBjAA--.33957W
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiWxPtyGemtdZneQADsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoIGZvciBJIGZvcmdvdCB0byBhZGQgdGhlIHVwc3RyZWFt
IGNvbW1pdCBpbiB0aGlzIGNvbW1pdCBsb2csIHNvcnJ5IGZvciBpdC4KCkF0IDIwMjUtMDItMDcg
MTU6MDY6NDMsIGpldGxhbjlAMTYzLmNvbSB3cm90ZToKPkZyb206IFZsYWRpbWlyIE9sdGVhbiA8
dmxhZGltaXIub2x0ZWFuQG54cC5jb20+Cj4KPkFmdGVyIHRoZSBibGFtZWQgY29tbWl0LCB3ZSBz
dGFydGVkIGRvaW5nIHRoaXMgZGVyZWZlcmVuY2UgZm9yIGV2ZXJ5Cj5ORVRERVZfQ0hBTkdFVVBQ
RVIgYW5kIE5FVERFVl9QUkVDSEFOR0VVUFBFUiBldmVudCBpbiB0aGUgc3lzdGVtLgo+Cj5zdGF0
aWMgaW5saW5lIHN0cnVjdCBkc2FfcG9ydCAqZHNhX3VzZXJfdG9fcG9ydChjb25zdCBzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQo+ewo+CXN0cnVjdCBkc2FfdXNlcl9wcml2ICpwID0gbmV0ZGV2X3By
aXYoZGV2KTsKPgo+CXJldHVybiBwLT5kcDsKPn0KPgo+V2hpY2ggaXMgb2J2aW91c2x5IGJvZ3Vz
LCBiZWNhdXNlIG5vdCBhbGwgbmV0X2RldmljZXMgaGF2ZSBhIG5ldGRldl9wcml2KCkKPm9mIHR5
cGUgc3RydWN0IGRzYV91c2VyX3ByaXYuIEJ1dCBzdHJ1Y3QgZHNhX3VzZXJfcHJpdiBpcyBmYWly
bHkgc21hbGwsCj5hbmQgcC0+ZHAgbWVhbnMgZGVyZWZlcmVuY2luZyA4IGJ5dGVzIHN0YXJ0aW5n
IHdpdGggb2Zmc2V0IDE2LiBNb3N0Cj5kcml2ZXJzIGFsbG9jYXRlIHRoYXQgbXVjaCBwcml2YXRl
IG1lbW9yeSBhbnl3YXksIG1ha2luZyBvdXIgYWNjZXNzIG5vdAo+ZmF1bHQsIGFuZCB3ZSBkaXNj
YXJkIHRoZSBib2d1cyBkYXRhIHF1aWNrbHkgYWZ0ZXJ3YXJkcywgc28gdGhpcyB3YXNuJ3QKPmNh
dWdodC4KPgo+QnV0IHRoZSBkdW1teSBpbnRlcmZhY2UgaXMgc29tZXdoYXQgc3BlY2lhbCBpbiB0
aGF0IGl0IGNhbGxzCj5hbGxvY19uZXRkZXYoKSB3aXRoIGEgcHJpdiBzaXplIG9mIDAuIFNvIGV2
ZXJ5IG5ldGRldl9wcml2KCkgZGVyZWZlcmVuY2UKPmlzIGludmFsaWQsIGFuZCB3ZSBnZXQgdGhp
cyB3aGVuIHdlIGVtaXQgYSBORVRERVZfUFJFQ0hBTkdFVVBQRVIgZXZlbnQKPndpdGggYSBWTEFO
IGFzIGl0cyBuZXcgdXBwZXI6Cj4KPiQgaXAgbGluayBhZGQgZHVtbXkxIHR5cGUgZHVtbXkKPiQg
aXAgbGluayBhZGQgbGluayBkdW1teTEgbmFtZSBkdW1teTEuMTAwIHR5cGUgdmxhbiBpZCAxMDAK
PlsgICA0My4zMDkxNzRdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQo+WyAgIDQzLjMxNjQ1Nl0gQlVHOiBLQVNBTjogc2xh
Yi1vdXQtb2YtYm91bmRzIGluIGRzYV91c2VyX3ByZWNoYW5nZXVwcGVyKzB4MzAvMHhlOAo+WyAg
IDQzLjMyMzgzNV0gUmVhZCBvZiBzaXplIDggYXQgYWRkciBmZmZmM2Y4NjQ4MWQyOTkwIGJ5IHRh
c2sgaXAvMzc0Cj5bICAgNDMuMzMwMDU4XQo+WyAgIDQzLjM0MjQzNl0gQ2FsbCB0cmFjZToKPlsg
ICA0My4zNjY1NDJdICBkc2FfdXNlcl9wcmVjaGFuZ2V1cHBlcisweDMwLzB4ZTgKPlsgICA0My4z
NzEwMjRdICBkc2FfdXNlcl9uZXRkZXZpY2VfZXZlbnQrMHhiMzgvMHhlZTgKPlsgICA0My4zNzU3
NjhdICBub3RpZmllcl9jYWxsX2NoYWluKzB4YTQvMHgyMTAKPlsgICA0My4zNzk5ODVdICByYXdf
bm90aWZpZXJfY2FsbF9jaGFpbisweDI0LzB4MzgKPlsgICA0My4zODQ0NjRdICBfX25ldGRldl91
cHBlcl9kZXZfbGluaysweDNlYy8weDVkOAo+WyAgIDQzLjM4OTEyMF0gIG5ldGRldl91cHBlcl9k
ZXZfbGluaysweDcwLzB4YTgKPlsgICA0My4zOTM0MjRdICByZWdpc3Rlcl92bGFuX2RldisweDFi
Yy8weDMxMAo+WyAgIDQzLjM5NzU1NF0gIHZsYW5fbmV3bGluaysweDIxMC8weDI0OAo+WyAgIDQz
LjQwMTI0N10gIHJ0bmxfbmV3bGluaysweDlmYy8weGUzMAo+WyAgIDQzLjQwNDk0Ml0gIHJ0bmV0
bGlua19yY3ZfbXNnKzB4Mzc4LzB4NTgwCj4KPkF2b2lkIHRoZSBrZXJuZWwgb29wcyBieSBkZXJl
ZmVyZW5jaW5nIGFmdGVyIHRoZSB0eXBlIGNoZWNrLCBhcyBjdXN0b21hcnkuCj4KPkZpeGVzOiA0
YzNmODBkMjJiMmUgKCJuZXQ6IGRzYTogd2FsayB0aHJvdWdoIGFsbCBjaGFuZ2V1cHBlciBub3Rp
ZmllciBmdW5jdGlvbnMiKQo+UmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogc3l6Ym90K2Q4MWJjZDg4
MzgyNDE4MDUwMGM4QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KPkNsb3NlczogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzAwMDAwMDAwMDAwMDFkNDI1NTA2MGU4NzU0NWNAZ29vZ2xl
LmNvbS8KPlNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54
cC5jb20+Cj5SZXZpZXdlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zmxvcmlhbi5mYWluZWxsaUBi
cm9hZGNvbS5jb20+Cj5SZXZpZXdlZC1ieTogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUu
Y29tPgo+TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDExMDAwMzM1NC4yNzk2
Nzc4LTEtdmxhZGltaXIub2x0ZWFuQG54cC5jb20KPlNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+Cj5TaWduZWQtb2ZmLWJ5OiBXZW5zaGFuIExhbiA8amV0bGFu
OUAxNjMuY29tPgo+LS0tCj4gbmV0L2RzYS9zbGF2ZS5jIHwgNyArKysrKy0tCj4gMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL25l
dC9kc2Evc2xhdmUuYyBiL25ldC9kc2Evc2xhdmUuYwo+aW5kZXggNWZlMDc1YmY0NzllLi5jYWVi
N2U3NWIyODcgMTAwNjQ0Cj4tLS0gYS9uZXQvZHNhL3NsYXZlLmMKPisrKyBiL25ldC9kc2Evc2xh
dmUuYwo+QEAgLTI1OTIsMTMgKzI1OTIsMTQgQEAgRVhQT1JUX1NZTUJPTF9HUEwoZHNhX3NsYXZl
X2Rldl9jaGVjayk7Cj4gc3RhdGljIGludCBkc2Ffc2xhdmVfY2hhbmdldXBwZXIoc3RydWN0IG5l
dF9kZXZpY2UgKmRldiwKPiAJCQkJIHN0cnVjdCBuZXRkZXZfbm90aWZpZXJfY2hhbmdldXBwZXJf
aW5mbyAqaW5mbykKPiB7Cj4tCXN0cnVjdCBkc2FfcG9ydCAqZHAgPSBkc2Ffc2xhdmVfdG9fcG9y
dChkZXYpOwo+IAlzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2s7Cj4gCWludCBlcnIgPSBO
T1RJRllfRE9ORTsKPisJc3RydWN0IGRzYV9wb3J0ICpkcDsKPiAKPiAJaWYgKCFkc2Ffc2xhdmVf
ZGV2X2NoZWNrKGRldikpCj4gCQlyZXR1cm4gZXJyOwo+IAo+KwlkcCA9IGRzYV9zbGF2ZV90b19w
b3J0KGRldik7Cj4gCWV4dGFjayA9IG5ldGRldl9ub3RpZmllcl9pbmZvX3RvX2V4dGFjaygmaW5m
by0+aW5mbyk7Cj4gCj4gCWlmIChuZXRpZl9pc19icmlkZ2VfbWFzdGVyKGluZm8tPnVwcGVyX2Rl
dikpIHsKPkBAIC0yNjUyLDExICsyNjUzLDEzIEBAIHN0YXRpYyBpbnQgZHNhX3NsYXZlX2NoYW5n
ZXVwcGVyKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gc3RhdGljIGludCBkc2Ffc2xhdmVfcHJl
Y2hhbmdldXBwZXIoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAJCQkJICAgIHN0cnVjdCBuZXRk
ZXZfbm90aWZpZXJfY2hhbmdldXBwZXJfaW5mbyAqaW5mbykKPiB7Cj4tCXN0cnVjdCBkc2FfcG9y
dCAqZHAgPSBkc2Ffc2xhdmVfdG9fcG9ydChkZXYpOwo+KwlzdHJ1Y3QgZHNhX3BvcnQgKmRwOwo+
IAo+IAlpZiAoIWRzYV9zbGF2ZV9kZXZfY2hlY2soZGV2KSkKPiAJCXJldHVybiBOT1RJRllfRE9O
RTsKPiAKPisJZHAgPSBkc2Ffc2xhdmVfdG9fcG9ydChkZXYpOwo+Kwo+IAlpZiAobmV0aWZfaXNf
YnJpZGdlX21hc3RlcihpbmZvLT51cHBlcl9kZXYpICYmICFpbmZvLT5saW5raW5nKQo+IAkJZHNh
X3BvcnRfcHJlX2JyaWRnZV9sZWF2ZShkcCwgaW5mby0+dXBwZXJfZGV2KTsKPiAJZWxzZSBpZiAo
bmV0aWZfaXNfbGFnX21hc3RlcihpbmZvLT51cHBlcl9kZXYpICYmICFpbmZvLT5saW5raW5nKQo+
LS0gCj4yLjQzLjAK

