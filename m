Return-Path: <stable+bounces-176715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24662B3BDD5
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D90682563
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559F31DD83;
	Fri, 29 Aug 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="DhnczZyH"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B282135C5
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477861; cv=none; b=sw9wMK7qtBmQ3iFn7aWQ8GCvvR63r/mDi3DpJ7ZdG1u0NGdi2HZyznzfIdVDORNX8H591EhUAtt0ykxiP/SbXHphG4iFDLV4wKIoFp8NOlY8RBtb9v+FU5/8/zXn3csU5IZ6kzUd8+tQ+oYw6jHaIQuynd/f0wMdMv1ThQ10otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477861; c=relaxed/simple;
	bh=xbY4RHTEVj+znLNZefTeOlKmdX2iYI7Yd3FVTEuylUI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=egpp8O32oWwMc0cSnY9eEPak1nF5/LOjja4/64bBp/YvvQoyop1I9ReCWfNuTARYUHKLbtH+54VgMjS9BuHv/16RPucACApmq/p1bc+ksyKJXYMgHqaLdJX1ickXdJ8c8HK4CDc/mjuH0qU/jLJvTwgEX0P26ynRZFPsIUZyhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=DhnczZyH; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756477859; x=1788013859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xbY4RHTEVj+znLNZefTeOlKmdX2iYI7Yd3FVTEuylUI=;
  b=DhnczZyHdMXi1QvJ7QQ8NtAOGc9yWlf0r5CuYg0kb1A9h+4jy/4yhLLO
   LEQ3YFof1hr/DbPjujMjU+yLvlsks2iiokLvKz446/FQijY3USpRXAd8g
   Cy7bUd0u55HRyPzyCXAzyKTPNmJGANv84++1PWGZmnEI13moIkde5Kq4U
   w4aEoqCH/TG6qEGjLVkz4zHvsfZfrTtmNaZzq17AX8/9jmrHKj/wjhwhr
   D7LKeIM1HCjt+qn/xVYHCJJ3AuK65H2e+3pAU/sPhCjLpYaSoCTI1lCDp
   eFU/ccD8W8jlnTfPlu7hlOJTq7x23YfqpPxWhOdPgCtQ9+GGdcRVHagr/
   w==;
X-CSE-ConnectionGUID: 1UrY0Qi8SRKK5NHZD0uK/g==
X-CSE-MsgGUID: GXER2AUmTuqZF9lAja7TSQ==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="1265293"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:30:49 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:13169]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.1:2525] with esmtp (Farcaster)
 id ad16dc39-b7aa-49c3-93f0-4bc10b1a8a66; Fri, 29 Aug 2025 14:30:49 +0000 (UTC)
X-Farcaster-Flow-ID: ad16dc39-b7aa-49c3-93f0-4bc10b1a8a66
Received: from EX19D024EUA004.ant.amazon.com (10.252.50.30) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:30:47 +0000
Received: from EX19D024EUA004.ant.amazon.com (10.252.50.30) by
 EX19D024EUA004.ant.amazon.com (10.252.50.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:30:46 +0000
Received: from EX19D024EUA004.ant.amazon.com ([fe80::4608:828c:c80b:ca72]) by
 EX19D024EUA004.ant.amazon.com ([fe80::4608:828c:c80b:ca72%3]) with mapi id
 15.02.2562.017; Fri, 29 Aug 2025 14:30:46 +0000
From: "Uschakow, Stanislav" <suschako@amazon.de>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "trix@redhat.com" <trix@redhat.com>, "ndesaulniers@google.com"
	<ndesaulniers@google.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "mike.kravetz@oracle.com"
	<mike.kravetz@oracle.com>, "jannh@google.com" <jannh@google.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"liam.howlett@oracle.com" <liam.howlett@oracle.com>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "osalvador@suse.de" <osalvador@suse.de>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "jannh@google.com" <jannh@google.com>
Subject: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Thread-Topic: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Thread-Index: AQHcGOKArPRLx5Gss0qhHb9N9ZVPlw==
Date: Fri, 29 Aug 2025 14:30:46 +0000
Message-ID: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-7"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGVsbG8uCgpXZSBoYXZlIG9ic2VydmVkIGEgaHVnZSBsYXRlbmN5IGluY3JlYXNloHVzaW5nIGBm
b3JrKClgIGFmdGVyoGluZ2VzdGluZyB0aGUgQ1ZFLTIwMjUtMzgwODUgZml4oHdoaWNoIGxlYWRz
IHRvIHRoZaBjb21taXSgYDEwMTNhZjRmNTg1ZjogbW0vaHVnZXRsYjogZml4IGh1Z2VfcG1kX3Vu
c2hhcmUoKSB2cyBHVVAtZmFzdCByYWNlYC4gT24gbGFyZ2UgbWFjaGluZXMgd2l0aCAxLjVUQiBv
ZiBtZW1vcnkgd2l0aCAxOTYgY29yZXMsIHdlIGlkZW50aWZpZWQgbW1hcHBpbmegb2agMS4yVEIg
b2Ygc2hhcmVkIG1lbW9yeSBhbmQgZm9ya2luZyBpdHNlbGYgZG96ZW5zIG9yoGh1bmRyZWRzIG9m
IHRpbWVzIHdlIHNlZSBhIGluY3JlYXNlIG9mIGV4ZWN1dGlvbiB0aW1lcyBvZiBhIGZhY3RvciBv
ZiA0LiBUaGUgcmVwcm9kdWNlciBpcyBhdCB0aGUgZW5kIG9mIHRoZSBlbWFpbC4KCkNvbXBhcmlu
ZyB0aGUgYSBrZXJuZWwgd2l0aG91dCB0aGlzIHBhdGNoIHdpdGggYSBrZXJuZWwgd2l0aCB0aGlz
IHBhdGNoIGFwcGxpZWQgd2hlbiBzcGF3bmluZyAxMDAwIGNoaWxkcmVuIHdlIHNlZSB0aG9zZSBl
eGVjdXRpb24gdGltZXM6CgoKUGF0Y2hlZCBrZXJuZWw6oAokoHRpbWUgbWFrZSBzdHJlc3MKLi4u
CnJlYWygIKAgMG0xMS4yNzVzCnVzZXKgIKAgMG0wLjE3N3MKc3lzoCCgIKAwbTIzLjkwNXMKCk9y
aWdpbmFsIGtlcm5lbCA6oAoKJKB0aW1lIG1ha2Ugc3RyZXNzCi4uLnJlYWygIKAgMG0yLjQ3NXMK
dXNlcqAgoCAwbTEuMzk4cwpzeXOgIKAgoDBtMi41MDFzCgoKVGhlIHBhdGNoIGluIHF1ZXN0aW9u
OqBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUv
bGludXguZ2l0L2NvbW1pdC8/aWQ9MTAxM2FmNGY1ODVmY2NjNGQzZTVjNTgyNGQxNzRkZTIyNTdm
N2Q2ZAoKCk15IG9ic2VydmF0aW9uL2Fzc3VtcHRpb24gaXM6CgplYWNoIGNoaWxkIHRvdWNoZXMg
MTAwoHJhbmRvbSBwYWdlcyBhbmQgZGVzcGF3bnMKb24gZWFjaCBkZXNwYXduIGBodWdlX3BtZF91
bnNoYXJlKClgIGlzIGNhbGxlZAplYWNoIGNhbGwgdG8gYGh1Z2VfcG1kX3Vuc2hhcmUoKWAgc3lu
Y3Job25pemVzIGFsbCB0aHJlYWRzIHVzaW5nIGB0bGJfcmVtb3ZlX3RhYmxlX3N5bmNfb25lKClg
IGxlYWRpbmcgdG8gdGhlIHJlZ3Jlc3Npb24KCgoKSSdtIGhhcHB5IHRvIHByb3ZpZGUgbW9yZSBp
bmZvcm1hdGlvbi4KCgoKClRoYW5rIHlvdQpTdGFuaXNsYXYgVXNjaGFrb3cKCgoKCgoKCgo9PT0g
UmVwcm9kdWNlciA9PT0KClNldHVwOgoKCiMhL2Jpbi9iYXNoCmVjaG8gIlNldHRpbmcgdXAgaHVn
ZXBhZ2VzIGZvciByZXByb2R1Y3Rpb24uLi4iCgojIGh1Z2VwYWdlcyAoMS4yVEIgLyAyTUIgPSA2
MTQ0MDAgcGFnZXMpClJFUVVJUkVEX1BBR0VTPTYxNDQwMAoKIyBDaGVjayBjdXJyZW50IGh1Z2Vw
YWdlIGFsbG9jYXRpb24KQ1VSUkVOVF9QQUdFUz0kKGNhdCAvcHJvYy9zeXMvdm0vbnJfaHVnZXBh
Z2VzKQplY2hvICJDdXJyZW50IGh1Z2VwYWdlczogJENVUlJFTlRfUEFHRVMiCgppZiBbICIkQ1VS
UkVOVF9QQUdFUyIgLWx0ICIkUkVRVUlSRURfUEFHRVMiIF07IHRoZW4KoCCgIGVjaG8gIkFsbG9j
YXRpbmcgJFJFUVVJUkVEX1BBR0VTIGh1Z2VwYWdlcy4uLiIKoCCgIGVjaG8gJFJFUVVJUkVEX1BB
R0VTIHwgc3VkbyB0ZWUgL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcwoKoCCgIEFMTE9DQVRFRD0k
KGNhdCAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzKQqgIKAgZWNobyAiQWxsb2NhdGVkIGh1Z2Vw
YWdlczogJEFMTE9DQVRFRCIKoCCgoAqgIKAgaWYgWyAiJEFMTE9DQVRFRCIgLWx0ICIkUkVRVUlS
RURfUEFHRVMiIF07IHRoZW4KoCCgIKAgoCBlY2hvICJXYXJuaW5nOiBDb3VsZCBub3QgYWxsb2Nh
dGUgYWxsIHJlcXVpcmVkIGh1Z2VwYWdlcyIKoCCgIKAgoCBlY2hvICJBdmFpbGFibGU6ICRBTExP
Q0FURUQsIFJlcXVpcmVkOiAkUkVRVUlSRURfUEFHRVMiCqAgoCBmaQpmaQoKZWNobyBuZXZlciB8
IHN1ZG8gdGVlIC9zeXMva2VybmVsL21tL3RyYW5zcGFyZW50X2h1Z2VwYWdlL2VuYWJsZWQKCmVj
aG8gLWUgIlxuSHVnZXBhZ2UgaW5mb3JtYXRpb246IgpjYXQgL3Byb2MvbWVtaW5mbyB8IGdyZXAg
LWkgaHVnZQoKZWNobyAtZSAiXG5TZXR1cCBjb21wbGV0ZS4gWW91IGNhbiBub3cgcnVuIHRoZSBy
ZXByb2R1Y3Rpb24gdGVzdC4iCgoKCk1ha2VmaWxlOgoKCkNYWCA9IGdjYwpDWFhGTEFHUyA9IC1P
MiAtV2FsbApUQVJHRVQgPSBodWdlcGFnZV9yZXBybwpTT1VSQ0UgPSBodWdlcGFnZV9yZXByby5j
CgokKFRBUkdFVCk6ICQoU09VUkNFKQqgIKAgJChDWFgpICQoQ1hYRkxBR1MpIC1vICQoVEFSR0VU
KSAkKFNPVVJDRSkKCmNsZWFuOgqgIKAgcm0gLWYgJChUQVJHRVQpCgpzZXR1cDoKoCCgIGNobW9k
ICt4IHNldHVwX2h1Z2VwYWdlcy5zaAqgIKAgLi9zZXR1cF9odWdlcGFnZXMuc2gKCnRlc3Q6ICQo
VEFSR0VUKQqgIKAgLi8kKFRBUkdFVCkgMjAgMwoKc3RyZXNzOiAkKFRBUkdFVCkKoCCgIC4vJChU
QVJHRVQpIDEwMDAgMQoKLlBIT05ZOiBjbGVhbiBzZXR1cCB0ZXN0IHN0cmVzcwoKCgpodWdlcGFn
ZV9yZXByby5jOgoKCiNpbmNsdWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8c3lzL3dhaXQuaD4K
I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcu
aD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CgojZGVmaW5lIEhVR0VQQUdF
X1NJWkUgKDIgKiAxMDI0ICogMTAyNCkgLy8gMk1CCiNkZWZpbmUgVE9UQUxfU0laRSAoMTIwMFVM
TCAqIDEwMjQgKiAxMDI0ICogMTAyNCkgLy8gMS4yVEIKI2RlZmluZSBOVU1fSFVHRVBBR0VTIChU
T1RBTF9TSVpFIC8gSFVHRVBBR0VfU0laRSkKCnZvaWQqIGNyZWF0ZV9odWdlcGFnZV9tYXBwaW5n
KCkgewqgIKAgdm9pZCogYWRkciA9IG1tYXAoTlVMTCwgVE9UQUxfU0laRSwgUFJPVF9SRUFEIHwg
UFJPVF9XUklURSwKoCCgIKAgoCCgIKAgoCCgIKAgoCCgIE1BUF9TSEFSRUQgfCBNQVBfQU5PTllN
T1VTIHwgTUFQX0hVR0VUTEIsIC0xLCAwKTsKoCCgIGlmIChhZGRyID09IE1BUF9GQUlMRUQpIHsK
oCCgIKAgoCBwZXJyb3IoIm1tYXAgaHVnZXBhZ2VzIGZhaWxlZCIpOwqgIKAgoCCgIGV4aXQoMSk7
CqAgoCB9CqAgoCByZXR1cm4gYWRkcjsKfQoKdm9pZCB0b3VjaF9yYW5kb21fcGFnZXModm9pZCog
YWRkciwgaW50IG51bV90b3VjaGVzKSB7CqAgoCBjaGFyKiBiYXNlID0gKGNoYXIqKWFkZHI7CqAg
oCBmb3IgKGludCBpID0gMDsgaSA8IG51bV90b3VjaGVzOyArK2kpIHsKoCCgIKAgoCBzaXplX3Qg
b2Zmc2V0ID0gKHJhbmQoKSAlIE5VTV9IVUdFUEFHRVMpICogSFVHRVBBR0VfU0laRTsKoCCgIKAg
oCB2b2xhdGlsZSBjaGFyIHZhbCA9IGJhc2Vbb2Zmc2V0XTsKoCCgIKAgoCAodm9pZCl2YWw7CqAg
oCB9Cn0KCnZvaWQgY2hpbGRfcHJvY2Vzcyh2b2lkKiBzaGFyZWRfbWVtLCBpbnQgY2hpbGRfaWQp
IHsKoCCgIHN0cnVjdCB0aW1lc3BlYyBzdGFydCwgZW5kOwqgIKAgY2xvY2tfZ2V0dGltZShDTE9D
S19NT05PVE9OSUMsICZzdGFydCk7CqAgoKAKoCCgIHRvdWNoX3JhbmRvbV9wYWdlcyhzaGFyZWRf
bWVtLCAxMDApOwqgIKCgCqAgoCBjbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJmVuZCk7
CqAgoCBsb25nIGR1cmF0aW9uID0gKGVuZC50dl9zZWMgLSBzdGFydC50dl9zZWMpICogMTAwMDAw
MCAroAqgIKAgoCCgIKAgoCCgIKAgoCCgKGVuZC50dl9uc2VjIC0gc3RhcnQudHZfbnNlYykgLyAx
MDAwOwqgIKCgCqAgoCBwcmludGYoIkNoaWxkICVkIGNvbXBsZXRlZCBpbiAlbGQg7HNcbiIsIGNo
aWxkX2lkLCBkdXJhdGlvbik7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyKiBhcmd2W10pIHsK
oCCgIGludCBudW1fcHJvY2Vzc2VzID0gYXJnYyA+IDEgPyBhdG9pKGFyZ3ZbMV0pIDogNTA7CqAg
oCBpbnQgaXRlcmF0aW9ucyA9IGFyZ2MgPiAyID8gYXRvaShhcmd2WzJdKSA6IDU7CqAgoKAKoCCg
IHByaW50ZigiQ3JlYXRpbmcgJWxsdUdCIGh1Z2VwYWdlIG1hcHBpbmcuLi5cbiIsIFRPVEFMX1NJ
WkUgLyAoMTAyNCoxMDI0KjEwMjQpKTsKoCCgIHZvaWQqIHNoYXJlZF9tZW0gPSBjcmVhdGVfaHVn
ZXBhZ2VfbWFwcGluZygpOwqgIKCgCqAgoCBmb3IgKGludCBpdGVyID0gMDsgaXRlciA8IGl0ZXJh
dGlvbnM7ICsraXRlcikgewqgIKAgoCCgIHByaW50ZigiXG5JdGVyYXRpb24gJWQ6IEZvcmtpbmcg
JWQgcHJvY2Vzc2VzXG4iLCBpdGVyICsgMSwgbnVtX3Byb2Nlc3Nlcyk7CqAgoCCgIKCgCqAgoCCg
IKAgcGlkX3QgY2hpbGRyZW5bbnVtX3Byb2Nlc3Nlc107CqAgoCCgIKAgc3RydWN0IHRpbWVzcGVj
IGl0ZXJfc3RhcnQsIGl0ZXJfZW5kOwqgIKAgoCCgIGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RP
TklDLCAmaXRlcl9zdGFydCk7CqAgoCCgIKCgCqAgoCCgIKAgZm9yIChpbnQgaSA9IDA7IGkgPCBu
dW1fcHJvY2Vzc2VzOyArK2kpIHsKoCCgIKAgoCCgIKAgcGlkX3QgcGlkID0gZm9yaygpOwqgIKAg
oCCgIKAgoCBpZiAocGlkID09IDApIHsKoCCgIKAgoCCgIKAgoCCgIGNoaWxkX3Byb2Nlc3Moc2hh
cmVkX21lbSwgaSk7CqAgoCCgIKAgoCCgIKAgoCBleGl0KDApOwqgIKAgoCCgIKAgoCB9IGVsc2Ug
aWYgKHBpZCA+IDApIHsKoCCgIKAgoCCgIKAgoCCgIGNoaWxkcmVuW2ldID0gcGlkOwqgIKAgoCCg
IKAgoCB9CqAgoCCgIKAgfQqgIKAgoCCgoAqgIKAgoCCgIGZvciAoaW50IGkgPSAwOyBpIDwgbnVt
X3Byb2Nlc3NlczsgKytpKSB7CqAgoCCgIKAgoCCgIHdhaXRwaWQoY2hpbGRyZW5baV0sIE5VTEws
IDApOwqgIKAgoCCgIH0KoCCgIKAgoKAKoCCgIKAgoCBjbG9ja19nZXR0aW1lKENMT0NLX01PTk9U
T05JQywgJml0ZXJfZW5kKTsKoCCgIKAgoCBsb25nIGl0ZXJfZHVyYXRpb24gPSAoaXRlcl9lbmQu
dHZfc2VjIC0gaXRlcl9zdGFydC50dl9zZWMpICogMTAwMCAroAqgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgKGl0ZXJfZW5kLnR2X25zZWMgLSBpdGVyX3N0YXJ0LnR2X25zZWMpIC8gMTAwMDAw
MDsKoCCgIKAgoCBwcmludGYoIkl0ZXJhdGlvbiBjb21wbGV0ZWQgaW4gJWxkIG1zXG4iLCBpdGVy
X2R1cmF0aW9uKTsKoCCgIH0KoCCgoAqgIKAgbXVubWFwKHNoYXJlZF9tZW0sIFRPVEFMX1NJWkUp
OwqgIKAgcmV0dXJuIDA7Cn0KCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFl
ZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJh
Z2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6
OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


