Return-Path: <stable+bounces-176883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B433B3EB44
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD7F3BC3C5
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A44B2D5936;
	Mon,  1 Sep 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RzHtRXfB"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E332F748
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740981; cv=none; b=JOciMo6d9zJYZ5mA9fothXBcJdBpFLfstmZTXcgqwJQdjoxfp31mke24L3g9YvjFxzLCC0fL7A8ArZ+kNn5LSbr8QYhbdSrR2p3fpKqv4pEiJR1x+nWDDzmP1n0NgunyHMfsscNdxVpfnspfaMo7LnngNyxjnwDpv5Lgo4038yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740981; c=relaxed/simple;
	bh=9JwtvSG2NelMsNKd3xmz5TOExyyTYOB82C2jYI47TG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnjuYTXR0+0JXSYp/EH3oioykVVM/eXtbIfnUan7viMVJIzG8XPmf2myZ9r618s0TLmYXk3YVjLuxZSHr9HRPLc7M6Vq11eG/lUiMy0D+YypNXgAqe72UaW9js8OPfXLTLSuglh38gtoBzVBAWSmyn/UrXII2jzVkuoj7lqKh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RzHtRXfB; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756740979; x=1788276979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9JwtvSG2NelMsNKd3xmz5TOExyyTYOB82C2jYI47TG4=;
  b=RzHtRXfB9p6oQAvUC1u6CSvcNYCWuSV3g+m5Rcb0aHlMsEEvLW4HoMTj
   UVwZKJADf3aJbDZPSHOt+FaSSUwLCl88CzSTHP91fOj/eH3dx5LqTJAsq
   nVRu4e6NC4AJs2+nLtglhRGa5bdFWpBIKq7QEqQAzEvoEywl6XehPUbh9
   HC8iFLt8sHiXRQ6g738JDpco8Z5+gbUBIIS0wgZcMBl1vfqKndvp5WFAZ
   7Rh7hJTqqZk/hSKMbxxqcXEAyGFpGH2Gj0/K/QidTENsAYQHAgl4Yiq3/
   VVuB4ThRnmcxmoLmIw8NyXhGqTUxQaEJ6mGdPjTQA2MIK4GDReaMujrDb
   w==;
X-CSE-ConnectionGUID: YIjBGaYOQ2qSYJLPWnIcGw==
X-CSE-MsgGUID: rHYS6hpsSwmM3vRFuPSAGQ==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1472442"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 15:36:08 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:21416]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.36.37:2525] with esmtp (Farcaster)
 id 6e917357-1e1d-4ab2-a9f1-168f45e2cf5e; Mon, 1 Sep 2025 15:36:08 +0000 (UTC)
X-Farcaster-Flow-ID: 6e917357-1e1d-4ab2-a9f1-168f45e2cf5e
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 1 Sep 2025 15:36:06 +0000
Received: from dev-dsk-nmanthey-1a-b3c7e931.eu-west-1.amazon.com
 (172.19.120.2) by EX19D002EUC004.ant.amazon.com (10.252.51.230) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 1 Sep 2025
 15:36:05 +0000
From: Norbert Manthey <nmanthey@amazon.de>
To: <stable@vger.kernel.org>
CC: Norbert Manthey <nmanthey@amazon.de>
Subject: [PATCH 6.1.y 0/1] Backporting patches with git-llm-pick
Date: Mon, 1 Sep 2025 15:35:58 +0000
Message-ID: <20250901153559.14799-1-nmanthey@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2025011112-racing-handbrake-a317@gregkh>
References: <2025011112-racing-handbrake-a317@gregkh>
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

RGVhciBhbGwsCgp3ZSBsb29rZWQgaW50byBpbXByb3ZpbmcgY29tbWl0IGJhY2twb3J0aW5nIHdv
cmtmbG93cy4gVGhpcyBzcGVjaWZpYyBjb21taXQgaW4KdGhpcyBzZXJpZXMgY2F1Z2h0IG91ciBh
dHRlbnRpb24sIGFzIGl0IHN0YXRlcyB0aGF0IGJhY2twb3J0aW5nIHdpbGwgbm90IGJlCnRyaXZp
YWwuIFRoZSBjb21taXQgbWVzc2FnZSBoYXMgdGhpcyBwYXJ0OiAKCkJhY2twb3J0IGhpbnQ6IHRo
aXMgcGF0Y2ggd2lsbCBoYXZlIGEgdHJpdmlhbCBjb25mbGljdCBhcHBseWluZyB0bwp2Ni42Lnks
IGFuZCBvdGhlciB0cml2aWFsIGNvbmZsaWN0cyBhcHBseWluZyB0byBzdGFibGUga2VybmVscyA8
IHY2LjYuCgpXZSB3YW50IHRvIGF1dG9tYXRlIGJhY2twb3J0aW5nIGNvbW1pdHMgd2l0aCBhIHNp
bWlsYXIgcHJvcGVydHkuIFRoZXJlZm9yZSwgd2UKYnVpbGQgYSB0b29sIGdpdC1sbG0tcGljayB0
aGF0IHNpbXBsaWZpZXMgdGhlIGJhY2twb3J0aW5nIGNvbW1pdC4gQWZ0ZXIKY2hlcnJ5LXBpY2tp
bmcsIHdlIHRyeSB0byBhdXRvbWF0aWNhbGx5IGRldGVjdCBkZXBlbmRlbmN5LWNvbW1pdHMuIElu
IGNhc2Ugb2YKZmFpbHVyZSwgd2UgdGhlbiB0cnkgdG8gdXNlIHRoZSBwYXRjaCB0b29sLiBJZiB0
aGlzIHByb2Nlc3MgZmFpbHMsIHdlIHRoZW4gdGFrZQp0aGUgcmVqZWN0ZWQgcGF0Y2ggZmlsZXMs
IGFuZCBmZWVkIHRoZWlyIGNvbnRlbnQgd2l0aCBvdGhlciBjb250ZXh0IGFuZCBhIHRhc2sKZGVz
Y3JpcHRpb24gdG8gYmFja3BvcnQgdG8gYW4gTExNLiBUaGUgcmVzdWx0aW5nIGNvZGUgbW9kaWZp
Y2F0aW9uIGlzIHRoZW4KYXBwbGllZC4gSW4gY2FzZSB2YWxpZGF0aW9uIGlzIHBhc3NlZCwgYSBj
b21taXQgaXMgY3JlYXRlZC4gVGhlIGNvbW1pdCBtZXNzYWdlCmlzIGFsd2F5cyBleHRlbmRlZCBi
eSBhIGRlc2NyaXB0aW9uIG9mIHRoZSBhZGFwdGVkIGNvZGUgY2hhbmdlLCBhbmQgd2l0aCB3aGlj
aAp0ZWNobmlxdWUgYSBjb21taXQgd2FzIGFwcGxpZWQuCgpXZSBtYWRlIHRoZSB0b29sIGF2YWls
YWJsZSBvbiBnaXRodWI6IGh0dHBzOi8vZ2l0aHViLmNvbS9hd3NsYWJzL0dpdF9sbG1fcGljay8K
V2UgY3VycmVudGx5IHVzZSBMTE1zIHZpYSB0aGUgQVdTIEJlZHJvY2sgc2VydmljZSwgYW5kIGRl
ZmF1bHQgdG8gdGhlIE5vdmEgUHJvCm1vZGVsLiBUaGUgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgdXNl
cyB0aGUgdmFuaWxsYSB2ZXJzaW9uIG9mIHRoZSB0b29sJ3MgY3VycmVudApvdXRwdXQgd2hlbiBy
dW5uaW5nIGdpdC1sbG0tcGljayBpbiBpdHMgdmlydHVhbCB0ZXN0IGVudmlyb25tZW50OgoKU0tJ
UF9WRU5WX0dMUF9URVNUSU5HPTEgJEdMUF9QQVRIL3Rlc3QvdGVzdC1pbi12ZW52LnNoIFwKICAg
IGdpdC1sbG0tcGljayBcCiAgICAtLXZhbGlkYXRpb24tY29tbWFuZCAkR0xQX1BBVEgvYmluL2ds
cC1jb21waWxlLXRlc3QtY2hhbmdlZC1rZXJuZWwtZmlsZS5zaCBcCiAgICAteCBmNDdjODM0YTkx
MzFhZTY0YmVlM2M0NjJmNGU2MTBjNjdiMGEwMDBmCgpCZXN0LApOb3JiZXJ0CgpBbWlyIEdvbGRz
dGVpbiAoMSk6CiAgZnM6IHJlbGF4IGFzc2VydGlvbnMgb24gZmFpbHVyZSB0byBlbmNvZGUgZmls
ZSBoYW5kbGVzCgogZnMvbm90aWZ5L2ZkaW5mby5jICAgICB8IDQgKy0tLQogZnMvb3ZlcmxheWZz
L2NvcHlfdXAuYyB8IDUgKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQoKLS0gCjIuMzQuMQoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9w
bWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGlu
Ckdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MK
RWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2
NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


