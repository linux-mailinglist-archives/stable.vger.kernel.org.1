Return-Path: <stable+bounces-176884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85493B3EB33
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0FF16D607
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EBA2D5932;
	Mon,  1 Sep 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="FMp77N1P"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4632F748
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740995; cv=none; b=ptqlvgAMJ+UwV//OhFCImfPf1TFAC+qJpANeOi9ToW6uHvKljCrD2H2GmMidIvRhhQXDT4bQQmRFrEOb3zcSq0BKc8c09hsnilekhNXdje8WshrcUIOCMYbFYc9do8YoTOHCZboIK5X+1gh0y88Q0HZWG5DmHmcCv9GiAHRzp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740995; c=relaxed/simple;
	bh=mPiWRlE2WCm1LF+kUCVGdStojCrDnobGXnmNWh+XHRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW+EggLsEncFJR17Nl3W7AWT+iPv5A4r3gWMSQ388eFTosm2IRJoSFm5gxQ1ykeE4Nvn7EBdkV87daxih3sQSMMypBYT3Dqj1KhCREnk+jchngAK61xlQ1UXlq65QpmBLAmI2XUikW/mEy41fboJ4QCObroSCSppqkuADxGQ+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=FMp77N1P; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756740993; x=1788276993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPiWRlE2WCm1LF+kUCVGdStojCrDnobGXnmNWh+XHRM=;
  b=FMp77N1PHKPkoVm50k/ziMljH+jiGK0xCFCRKP7bu8rctLy2jo4WcmoP
   rugTV95tCxtoq4uzpb7ykpDa7hhmh04iUXOr2bkM/6EjpOSmEdOYuHSb7
   LLoXrwiN7KSXuzEGIWIdGMNWFPdd3IBPVOxqy4ONw/bQ3DHFW6fTF62K5
   wa40JzgL3c8erTfPIxOkVsRByoZmN6InLqxvlC+oHUfOzLtubTl9suKG1
   uwiPEMzjuT4Cg5FhtIPhNwofcC5mFVuXCSZzB/VfRcbG6IA4+P53KskgJ
   rsZZe1haLIkMAnv3WF69Rje22cKZDgmfM1OtgoSVVyES3knqxp+fltBi1
   w==;
X-CSE-ConnectionGUID: lHWFCAtMQxa6TyupB1eciA==
X-CSE-MsgGUID: KkoKbk6mQR6mSeSgTUJ7Sw==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="1470638"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 15:36:22 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:13755]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.16.219:2525] with esmtp (Farcaster)
 id 7eb90e30-fee7-4a12-9e69-149fc7ebd4d7; Mon, 1 Sep 2025 15:36:22 +0000 (UTC)
X-Farcaster-Flow-ID: 7eb90e30-fee7-4a12-9e69-149fc7ebd4d7
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 1 Sep 2025 15:36:21 +0000
Received: from dev-dsk-nmanthey-1a-b3c7e931.eu-west-1.amazon.com
 (172.19.120.2) by EX19D002EUC004.ant.amazon.com (10.252.51.230) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 1 Sep 2025
 15:36:18 +0000
From: Norbert Manthey <nmanthey@amazon.de>
To: <stable@vger.kernel.org>
CC: Norbert Manthey <nmanthey@amazon.de>, Amir Goldstein <amir73il@gmail.com>,
	<syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>, Dmitry Safonov
	<dima@arista.com>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
	=?UTF-8?q?=C3=96mer=20Erdin=C3=A7=20Ya=C4=9Fmurlu?= <oeygmrl@amazon.de>
Subject: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file handles
Date: Mon, 1 Sep 2025 15:35:59 +0000
Message-ID: <20250901153559.14799-2-nmanthey@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250901153559.14799-1-nmanthey@amazon.de>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250901153559.14799-1-nmanthey@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D002EUC004.ant.amazon.com (10.252.51.230)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KCmNvbW1pdCA5NzRlM2Zl
MGFjNjFkZTg1MDE1YmJlNWE0OTkwY2Y0MTI3YjMwNGIyIHVwc3RyZWFtLgoKRW5jb2RpbmcgZmls
ZSBoYW5kbGVzIGlzIHVzdWFsbHkgcGVyZm9ybWVkIGJ5IGEgZmlsZXN5c3RlbSA+ZW5jb2RlX2Zo
KCkKbWV0aG9kIHRoYXQgbWF5IGZhaWwgZm9yIHZhcmlvdXMgcmVhc29ucy4KClRoZSBsZWdhY3kg
dXNlcnMgb2YgZXhwb3J0ZnNfZW5jb2RlX2ZoKCksIG5hbWVseSwgbmZzZCBhbmQKbmFtZV90b19o
YW5kbGVfYXQoMikgc3lzY2FsbCBhcmUgcmVhZHkgdG8gY29wZSB3aXRoIHRoZSBwb3NzaWJpbGl0
eQpvZiBmYWlsdXJlIHRvIGVuY29kZSBhIGZpbGUgaGFuZGxlLgoKVGhlcmUgYXJlIGEgZmV3IG90
aGVyIHVzZXJzIG9mIGV4cG9ydGZzX2VuY29kZV97ZmgsZmlkfSgpIHRoYXQKY3VycmVudGx5IGhh
dmUgYSBXQVJOX09OKCkgYXNzZXJ0aW9uIHdoZW4gLT5lbmNvZGVfZmgoKSBmYWlscy4KUmVsYXgg
dGhvc2UgYXNzZXJ0aW9ucyBiZWNhdXNlIHRoZXkgYXJlIHdyb25nLgoKVGhlIHNlY29uZCBsaW5r
ZWQgYnVnIHJlcG9ydCBzdGF0ZXMgY29tbWl0IDE2YWFjNWFkMWZhOSAoIm92bDogc3VwcG9ydApl
bmNvZGluZyBub24tZGVjb2RhYmxlIGZpbGUgaGFuZGxlcyIpIGluIHY2LjYgYXMgdGhlIHJlZ3Jl
c3NpbmcgY29tbWl0LApidXQgdGhpcyBpcyBub3QgYWNjdXJhdGUuCgpUaGUgYWZvcmVtZW50aW9u
ZWQgY29tbWl0IG9ubHkgaW5jcmVhc2VzIHRoZSBjaGFuY2VzIG9mIHRoZSBhc3NlcnRpb24KYW5k
IGFsbG93cyB0cmlnZ2VyaW5nIHRoZSBhc3NlcnRpb24gd2l0aCB0aGUgcmVwcm9kdWNlciB1c2lu
ZyBvdmVybGF5ZnMsCmlub3RpZnkgYW5kIGRyb3BfY2FjaGVzLgoKVHJpZ2dlcmluZyB0aGlzIGFz
c2VydGlvbiB3YXMgYWx3YXlzIHBvc3NpYmxlIHdpdGggb3RoZXIgZmlsZXN5c3RlbXMgYW5kCm90
aGVyIHJlYXNvbnMgb2YgLT5lbmNvZGVfZmgoKSBmYWlsdXJlcyBhbmQgbW9yZSBwYXJ0aWN1bGFy
bHksIGl0IHdhcwphbHNvIHBvc3NpYmxlIHdpdGggdGhlIGV4YWN0IHNhbWUgcmVwcm9kdWNlciB1
c2luZyBvdmVybGF5ZnMgdGhhdCBpcwptb3VudGVkIHdpdGggb3B0aW9ucyBpbmRleD1vbixuZnNf
ZXhwb3J0PW9uIGFsc28gb24ga2VybmVscyA8IHY2LjYuClRoZXJlZm9yZSwgSSBhbSBub3QgbGlz
dGluZyB0aGUgYWZvcmVtZW50aW9uZWQgY29tbWl0IGFzIGEgRml4ZXMgY29tbWl0LgoKQmFja3Bv
cnQgaGludDogdGhpcyBwYXRjaCB3aWxsIGhhdmUgYSB0cml2aWFsIGNvbmZsaWN0IGFwcGx5aW5n
IHRvCnY2LjYueSwgYW5kIG90aGVyIHRyaXZpYWwgY29uZmxpY3RzIGFwcGx5aW5nIHRvIHN0YWJs
ZSBrZXJuZWxzIDwgdjYuNi4KClJlcG9ydGVkLWJ5OiBzeXpib3QrZWMwN2Y2ZjVjZTYyYjg1ODU3
OWZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpUZXN0ZWQtYnk6IHN5emJvdCtlYzA3ZjZmNWNl
NjJiODU4NTc5ZkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtdW5pb25mcy82NzFmZDQwYy4wNTBhMDIyMC40NzM1YS4wMjRmLkdB
RUBnb29nbGUuY29tLwpSZXBvcnRlZC1ieTogRG1pdHJ5IFNhZm9ub3YgPGRpbWFAYXJpc3RhLmNv
bT4KQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsL0NBR3Jid0RU
THQ2ZHJCOWVhVWFnblFWZ2RQQm1oTGZxcXhBZjNGK0p1cXlfbzZvUDh1d0BtYWlsLmdtYWlsLmNv
bS8KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3Rl
aW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI0MTIxOTExNTMwMS40NjUzOTYtMS1hbWlyNzNpbEBnbWFpbC5jb20KU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogQW1p
ciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KCihmdXp6eSBwaWNrZWQgZnJv
bSBjb21taXQgZjQ3YzgzNGE5MTMxYWU2NGJlZTNjNDYyZjRlNjEwYzY3YjBhMDAwZikKQXBwbGll
ZCB3aXRoIExMTS1hZGp1c3RlZCBodW5rcyBmb3IgMSBmdW5jdGlvbnMgZnJvbSB1cy5hbWF6b24u
bm92YQotIENoYW5nZWQgdGhlIGZ1bmN0aW9uIGNhbGwgZnJvbSBgZXhwb3J0ZnNfZW5jb2RlX2Zp
ZGAgdG8gYGV4cG9ydGZzX2VuY29kZV9pbm9kZV9maGAgdG8gbWF0Y2ggdGhlIGRlc3RpbmF0aW9u
IGNvZGUuCi0gUmVtb3ZlZCB0aGUgd2FybmluZyBtZXNzYWdlIGFzIHBlciB0aGUgcGF0Y2guCgpT
aWduZWQtb2ZmLWJ5OiBOb3JiZXJ0IE1hbnRoZXkgPG5tYW50aGV5QGFtYXpvbi5kZT4KVGVzdGVk
LWJ5OiDDlm1lciBFcmRpbsOnIFlhxJ9tdXJsdSA8b2V5Z21ybEBhbWF6b24uZGU+Ci0tLQogZnMv
bm90aWZ5L2ZkaW5mby5jICAgICB8IDQgKy0tLQogZnMvb3ZlcmxheWZzL2NvcHlfdXAuYyB8IDUg
KystLS0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9mZGluZm8uYyBiL2ZzL25vdGlmeS9mZGluZm8uYwppbmRl
eCA1NTA4MWFlM2E2ZWMwLi5kZDViYzZmZmFlODU4IDEwMDY0NAotLS0gYS9mcy9ub3RpZnkvZmRp
bmZvLmMKKysrIGIvZnMvbm90aWZ5L2ZkaW5mby5jCkBAIC01MSwxMCArNTEsOCBAQCBzdGF0aWMg
dm9pZCBzaG93X21hcmtfZmhhbmRsZShzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCBpbm9kZSAq
aW5vZGUpCiAJc2l6ZSA9IGYuaGFuZGxlLmhhbmRsZV9ieXRlcyA+PiAyOwogCiAJcmV0ID0gZXhw
b3J0ZnNfZW5jb2RlX2lub2RlX2ZoKGlub2RlLCAoc3RydWN0IGZpZCAqKWYuaGFuZGxlLmZfaGFu
ZGxlLCAmc2l6ZSwgTlVMTCk7Ci0JaWYgKChyZXQgPT0gRklMRUlEX0lOVkFMSUQpIHx8IChyZXQg
PCAwKSkgewotCQlXQVJOX09OQ0UoMSwgIkNhbid0IGVuY29kZSBmaWxlIGhhbmRsZXIgZm9yIGlu
b3RpZnk6ICVkXG4iLCByZXQpOworCWlmICgocmV0ID09IEZJTEVJRF9JTlZBTElEKSB8fCAocmV0
IDwgMCkpCiAJCXJldHVybjsKLQl9CiAKIAlmLmhhbmRsZS5oYW5kbGVfdHlwZSA9IHJldDsKIAlm
LmhhbmRsZS5oYW5kbGVfYnl0ZXMgPSBzaXplICogc2l6ZW9mKHUzMik7CmRpZmYgLS1naXQgYS9m
cy9vdmVybGF5ZnMvY29weV91cC5jIGIvZnMvb3ZlcmxheWZzL2NvcHlfdXAuYwppbmRleCAyMDNi
ODgyOTNmNmJiLi5jZWQ1NjY5NmJlZWIzIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvY29weV91
cC5jCisrKyBiL2ZzL292ZXJsYXlmcy9jb3B5X3VwLmMKQEAgLTM2MSw5ICszNjEsOCBAQCBzdHJ1
Y3Qgb3ZsX2ZoICpvdmxfZW5jb2RlX3JlYWxfZmgoc3RydWN0IG92bF9mcyAqb2ZzLCBzdHJ1Y3Qg
ZGVudHJ5ICpyZWFsLAogCWJ1ZmxlbiA9IChkd29yZHMgPDwgMik7CiAKIAllcnIgPSAtRUlPOwot
CWlmIChXQVJOX09OKGZoX3R5cGUgPCAwKSB8fAotCSAgICBXQVJOX09OKGJ1ZmxlbiA+IE1BWF9I
QU5ETEVfU1opIHx8Ci0JICAgIFdBUk5fT04oZmhfdHlwZSA9PSBGSUxFSURfSU5WQUxJRCkpCisJ
aWYgKGZoX3R5cGUgPCAwIHx8IGZoX3R5cGUgPT0gRklMRUlEX0lOVkFMSUQgfHwKKwkgICAgV0FS
Tl9PTihidWZsZW4gPiBNQVhfSEFORExFX1NaKSkKIAkJZ290byBvdXRfZXJyOwogCiAJZmgtPmZi
LnZlcnNpb24gPSBPVkxfRkhfVkVSU0lPTjsKLS0gCjIuMzQuMQoKCgoKQW1hem9uIFdlYiBTZXJ2
aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMK
MTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9u
YXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50
ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


