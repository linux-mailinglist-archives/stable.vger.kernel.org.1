Return-Path: <stable+bounces-66264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617794D0C9
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C5128597D
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBF19307A;
	Fri,  9 Aug 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="aCYOPoHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DE17BBF
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208686; cv=none; b=V/FdZQMzhs5BH0Mk9sA/smeOVbGTdC5jzUimaVEmuY0MSnHtB6EEWjMJOnp+zN777MoE5uIe+maLDjkbQcmQPcRRAOV5kQ2EWctFI93xFpRkwd497+4vy+juIZysQMaDyk0lSA5gfFvcAlrF5AhOzT7qNv6/pfMr5uYby9//GRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208686; c=relaxed/simple;
	bh=f0gBj9VvvxgRiogliY+bZcdLVKyZwvmrO/fiz64B/FA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=fzYxSZSarV6/IHV5V7i0YzqEgWkBtX0qY/rAae8YCUtMgESvaG/xqIdqFxAeAYV9io6rdmA5ZLfqg31DYz86SM5vzhUeZJV/+AiCMAcQRzM+Hc1NIBfE4Q+fvra2aCzwIF0mNhFSrS7vk856bV3iSS+nZE1DeDBXfwOFCFXbB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=aCYOPoHz; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1723208685; x=1754744685;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=f0gBj9VvvxgRiogliY+bZcdLVKyZwvmrO/fiz64B/FA=;
  b=aCYOPoHz3i6zqk1pvNQSguM8V78Ug3MX0JXPtWawYqf973xmeDd/MPxU
   2cRxDXmE/Vd2EI5eKqog8wErbp8mXxMW81kDCy9mK1v1pGlyOaS1dmtIZ
   W0TQtisi5IlUittXfpuRs7M+hpjeBnyddtNrYxYftlUvX7Zml0Wqsa+yf
   k=;
X-IronPort-AV: E=Sophos;i="6.09,276,1716249600"; 
   d="scan'208";a="416270659"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:04:42 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:7272]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.192:2525] with esmtp (Farcaster)
 id 953ad167-b9c8-440a-a4cf-966d126a9685; Fri, 9 Aug 2024 13:04:40 +0000 (UTC)
X-Farcaster-Flow-ID: 953ad167-b9c8-440a-a4cf-966d126a9685
Received: from EX19D003EUA004.ant.amazon.com (10.252.50.128) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 13:04:35 +0000
Received: from [192.168.20.138] (10.106.82.18) by
 EX19D003EUA004.ant.amazon.com (10.252.50.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 13:04:37 +0000
Message-ID: <8301f75b-fc63-4757-8ae7-ce6b71da4ff6@amazon.de>
Date: Fri, 9 Aug 2024 15:04:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Doebel, Bjoern" <doebel@amazon.de>
Subject: Please backport commit 99c515e3a860 "ext4: fix wrong unit use in
 ext4_mb_find_by_goal" to stable 6.1
To: <stable@vger.kernel.org>
CC: <shikemeng@huaweicloud.com>, <ojaswin@linux.ibm.com>, <tytso@mit.edu>
Content-Language: en-US
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D003EUA004.ant.amazon.com (10.252.50.128)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGksCgpwbGVhc2UgYmFja3BvcnQgY29tbWl0IDk5YzUxNWUzYTg2MCAiZXh0NDogZml4IHdyb25n
IHVuaXQgdXNlIGluIGV4dDRfbWJfZmluZF9ieV9nb2FsIiB0byB0aGUgNi4xIHN0YWJsZSBicmFu
Y2guCgpDb21taXQgbWVzc2FnZQoKIiIiCiDCoMKgwqAgZXh0NDogZml4IHdyb25nIHVuaXQgdXNl
IGluIGV4dDRfbWJfZmluZF9ieV9nb2FsCgogwqDCoMKgIFdlIG5lZWQgc3RhcnQgaW4gYmxvY2sg
dW5pdCB3aGlsZSBmZV9zdGFydCBpcyBpbiBjbHVzdGVyIHVuaXQuIFVzZQogwqDCoMKgIGV4dDRf
Z3JwX29mZnNfdG9fYmxvY2sgaGVscGVyIHRvIGNvbnZlcnQgZmVfc3RhcnQgdG8gZ2V0IHN0YXJ0
IGluCiDCoMKgwqAgYmxvY2sgdW5pdC4KIiIiCgpXZSBoYXZlIHNlZW4gU3l6a2FsbGVyIHJlcG9y
dHMgZm9yIHRoZSA2LjEgc3RhYmxlIGJ1aWxkIGFuZCB0aGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1
ZS4KCkJlc3QgcmVnYXJkcywKQmpvZXJuCgpSZXBvcnQ6Cj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CkJUUkZTOiBkZXZpY2UgZnNpZCBhOWRj
YmFiNC02ZjEwLTQwMzItOGVmYy01ZWM4MzE2MGNhMjAgZGV2aWQgMSB0cmFuc2lkIDExIC9kZXYv
bG9vcDMgc2Nhbm5lZCBieSAodWRldi13b3JrZXIpICg0MzY1KQpFWFQ0LWZzIChsb29wMik6IG1v
dW50ZWQgZmlsZXN5c3RlbSB3aXRob3V0IGpvdXJuYWwuIFF1b3RhIG1vZGU6IHdyaXRlYmFjay4K
RVhUNC1mcyAobG9vcDYpOiB1bm1vdW50aW5nIGZpbGVzeXN0ZW0uCi0tLS0tLS0tLS0tLVsgY3V0
IGhlcmUgXS0tLS0tLS0tLS0tLQprZXJuZWwgQlVHIGF0IGZzL2V4dDQvZXh0ZW50cy5jOjMxODEh
CmludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgS0FTQU4gTk9QVEkKQ1BVOiAx
IFBJRDogMTEyNTkgQ29tbTogc3l6LjQuMjgxIE5vdCB0YWludGVkIDYuMS4xMDAgIzYKSGFyZHdh
cmUgbmFtZTogUUVNVSBVYnVudHUgMjQuMDQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9T
IDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQvMDEvMjAxNApSSVA6IDAwMTA6ZXh0NF9zcGxpdF9l
eHRlbnRfYXQrMHg4NTQvMHhlYzAgZnMvZXh0NC9leHRlbnRzLmM6MzE4MQpDb2RlOiBiZSBkMyAw
YyAwMCAwMCA0OCBjNyBjNyA4MCA2OCAxYyA4NyAwZiBiNyA0MyAwOCA0YyA4ZCAwNCA0MCA0OSBj
MSBlMCAwNCA0OSAwMSBkOCBlOCBlNiBmNSBmZSBmZiBlOSAyZiBmZSBmZiBmZiBlOCBhYyA5MSA3
NyBmZiA8MGY+IDBiIGU4IGE1IDkxIDc3IGZmIDQ4IDhiIDc0IDI0IDMwIDQ0IDhiIDZjIDI0IDI0
IDQ4IGI4IDAwIDAwIDAwClJTUDogMDAxODpmZmZmYzkwMDA0NzRmYjI4IEVGTEFHUzogMDAwMTAy
ODMKUkFYOiAwMDAwMDAwMDAwMDA2ZTFhIFJCWDogZmZmZjg4ODA0MzExMzdhYyBSQ1g6IGZmZmZj
OTAwMDhhMjIwMDAKUkRYOiAwMDAwMDAwMDAwMDQwMDAwIFJTSTogZmZmZmZmZmY4MjA1ZGMxNCBS
REk6IDAwMDAwMDAwMDAwMDAwMDQKUkJQOiBmZmZmODg4MDQ0MGU2ZjAwIFIwODogMDAwMDAwMDAw
MDAwMDAwNCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAwMDAwMDAwMDQwIFIxMTog
MDAwMDAwMDAwN2M3Yjg3MiBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKUjEzOiAwMDAwMDAwMDAwMDAw
MDAwIFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwNDAKRlM6wqAgMDAw
MDdmODkzM2NjMzZjMCgwMDAwKSBHUzpmZmZmODg4MDVhYjAwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAKQ1M6wqAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMKQ1IyOiAwMDAwN2YyZWFkYTMxMDAwIENSMzogMDAwMDAwMDAzMDU0NDAwMSBDUjQ6IDAw
MDAwMDAwMDA3NzBlZTAKRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAw
MCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAw
MDBmZmZlMDdmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAKUEtSVTogNTU1NTU1NTQKQ2FsbCBUcmFj
ZToKIMKgPFRBU0s+CiDCoGV4dDRfZm9yY2Vfc3BsaXRfZXh0ZW50X2F0IGZzL2V4dDQvZXh0ZW50
cy5jOjMzOCBbaW5saW5lXQogwqBleHQ0X2V4dF9yZW1vdmVfc3BhY2UrMHgxNDVkLzB4MjMyMCBm
cy9leHQ0L2V4dGVudHMuYzoyODc2CiDCoGV4dDRfcHVuY2hfaG9sZSsweDliMS8weDEwMjAgZnMv
ZXh0NC9pbm9kZS5jOjQxMjcKIMKgZXh0NF9mYWxsb2NhdGUrMHg2ZGYvMHg4MDAgZnMvZXh0NC9l
eHRlbnRzLmM6NDczNwogwqB2ZnNfZmFsbG9jYXRlKzB4NDZmLzB4Y2EwIGZzL29wZW4uYzozMjMK
IMKga3N5c19mYWxsb2NhdGUgZnMvb3Blbi5jOjM0NiBbaW5saW5lXQogwqBfX2RvX3N5c19mYWxs
b2NhdGUgZnMvb3Blbi5jOjM1NCBbaW5saW5lXQogwqBfX3NlX3N5c19mYWxsb2NhdGUgZnMvb3Bl
bi5jOjM1MiBbaW5saW5lXQogwqBfX3g2NF9zeXNfZmFsbG9jYXRlKzB4ZDYvMHgxNDAgZnMvb3Bl
bi5jOjM1MgogwqBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo1MSBbaW5s
aW5lXQogwqBkb19zeXNjYWxsXzY0KzB4MzUvMHg4MCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo4
MQogwqBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg2ZS8weGQ4ClJJUDogMDAzMzow
eDdmODkzMmY3NWQzOQpDb2RlOiBmZiBmZiBjMyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAw
MCAwZiAxZiA0MCAwMCA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBkNiA0OCA4OSBjYSA0ZCA4OSBj
MiA0ZCA4OSBjOCA0YyA4YiA0YyAyNCAwOCAwZiAwNSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAx
IGMzIDQ4IGM3IGMxIGE4IGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAxIDQ4ClJTUDogMDAyYjowMDAw
N2Y4OTMzY2MzMDQ4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAxMWQK
UkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDdmODkzMzEwM2ZhMCBSQ1g6IDAwMDA3Zjg5
MzJmNzVkMzkKUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMyBSREk6
IDAwMDAwMDAwMDAwMDAwMDkKUkJQOiAwMDAwN2Y4OTMyZmY2NzY2IFIwODogMDAwMDAwMDAwMDAw
MDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAwMDAwMDEwMDAxIFIxMTogMDAw
MDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKUjEzOiAwMDAwMDAwMDAwMDAwMDBi
IFIxNDogMDAwMDdmODkzMzEwM2ZhMCBSMTU6IDAwMDA3ZmZmN2I4OGNkNDgKIMKgPC9UQVNLPgpN
b2R1bGVzIGxpbmtlZCBpbjoKLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tClJJ
UDogMDAxMDpleHQ0X3NwbGl0X2V4dGVudF9hdCsweDg1NC8weGVjMCBmcy9leHQ0L2V4dGVudHMu
YzozMTgxCkNvZGU6IGJlIGQzIDBjIDAwIDAwIDQ4IGM3IGM3IDgwIDY4IDFjIDg3IDBmIGI3IDQz
IDA4IDRjIDhkIDA0IDQwIDQ5IGMxIGUwIDA0IDQ5IDAxIGQ4IGU4IGU2IGY1IGZlIGZmIGU5IDJm
IGZlIGZmIGZmIGU4IGFjIDkxIDc3IGZmIDwwZj4gMGIgZTggYTUgOTEgNzcgZmYgNDggOGIgNzQg
MjQgMzAgNDQgOGIgNmMgMjQgMjQgNDggYjggMDAgMDAgMDAKUlNQOiAwMDE4OmZmZmZjOTAwMDQ3
NGZiMjggRUZMQUdTOiAwMDAxMDI4MwpSQVg6IDAwMDAwMDAwMDAwMDZlMWEgUkJYOiBmZmZmODg4
MDQzMTEzN2FjIFJDWDogZmZmZmM5MDAwOGEyMjAwMApSRFg6IDAwMDAwMDAwMDAwNDAwMDAgUlNJ
OiBmZmZmZmZmZjgyMDVkYzE0IFJESTogMDAwMDAwMDAwMDAwMDAwNApSQlA6IGZmZmY4ODgwNDQw
ZTZmMDAgUjA4OiAwMDAwMDAwMDAwMDAwMDA0IFIwOTogMDAwMDAwMDAwMDAwMDAwMApSMTA6IDAw
MDAwMDAwMDAwMDAwNDAgUjExOiAwMDAwMDAwMDA3YzdiODcyIFIxMjogMDAwMDAwMDAwMDAwMDAw
MApSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAw
MDAwMDAwMDA0MApGUzrCoCAwMDAwN2Y4OTMzY2MzNmMwKDAwMDApIEdTOmZmZmY4ODgwNWFiMDAw
MDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAw
MDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpDUjI6IDAwMDA3ZjJlYWRhMzEwMDAgQ1IzOiAwMDAw
MDAwMDMwNTQ0MDAxIENSNDogMDAwMDAwMDAwMDc3MGVlMApEUjA6IDAwMDAwMDAwMDAwMDAwMDAg
RFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMApEUjM6IDAwMDAwMDAw
MDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwN2YwIERSNzogMDAwMDAwMDAwMDAwMDQwMApQS1JV
OiA1NTU1NTU1NAoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDM2NSA1MzggNTk3Cg==


