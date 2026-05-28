Return-Path: <stable+bounces-254968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPiVDOYyGGpwfggAu9opvQ
	(envelope-from <stable+bounces-254968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:19:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1198C5F1FB3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C134130DAFD3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67543E6DFF;
	Thu, 28 May 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="kcQEsBYx"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2273E63B0;
	Thu, 28 May 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970498; cv=none; b=mHfxZLFagdnLKHrMylWSWSDLPrmtQG+9gwIMEemtzPefpumzLuZqXnReI2JFCvvO0zYJvaVnkMLWcYlc3uus1QYHOSNYIfIq43BC1WeKKyVHhxFFE/QncwRNE7ivo1bqg4s6yP3xPad6EzzYlOQQi+Vwh0alAzI1XRm7PbKqALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970498; c=relaxed/simple;
	bh=6yB1rbQ4UA0J6bF6ZQjxAsIMRYJAIlzNKhnmHJVD3oU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZMHJehI1/BfIjT5BO9GD+JlkFvx2rcSXJNuZiDje3R0CD0RsyD464wnJwMhryue4JqZoFf8IDRhHE6BdbMp5TPYj6zoWzsaYbmXGY9wUIlVQDxb5St+h1CvZhSg2woVRtkU99EjG3N9B8dQibFYO4AVpig00mSOMnqiCzrRJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=kcQEsBYx; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779970496; x=1811506496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6yB1rbQ4UA0J6bF6ZQjxAsIMRYJAIlzNKhnmHJVD3oU=;
  b=kcQEsBYxQUEury/FpI9wZBkIkNwfJxh2KfXhaykhofqErXY7JHPc0G+0
   gfayd99FruIkrpGdc0h88dDdiYgDe9AvF3BtNwLRKV8r6wuoIcFxTVLEK
   YE0XXwymolMqgi5y0QnSp57rrE2yCJb3V8s87a0vKCiRmOI7KvQ0Nh6fv
   Pi51ogYt2AgHxsN5Zsp+HGL0aVFzGbKfK8YEKdJtrS6vIWc5NDIE+lqP5
   XFoApWsPkk5UA1KuvMrkcXO1dsSyqSDl5xdYC7brX1XY9Ee//BWQshtlT
   4khkIltCEnHmVI+P9WSfpXcNuXn6p+hiQvw1oJqVYi73QDXa8pgbJQdEq
   g==;
X-CSE-ConnectionGUID: Zxt4rgX8Siq40/4xh09aqQ==
X-CSE-MsgGUID: mvToXaZnT1ivvaI4CeS3pQ==
X-IronPort-AV: E=Sophos;i="6.24,173,1774310400"; 
   d="scan'208";a="20141489"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 12:14:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:8267]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.91:2525] with esmtp (Farcaster)
 id dee1f4c1-d981-4fe6-b308-096a6ba05a14; Thu, 28 May 2026 12:14:53 +0000 (UTC)
X-Farcaster-Flow-ID: dee1f4c1-d981-4fe6-b308-096a6ba05a14
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 28 May 2026 12:14:53 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 28 May 2026 12:14:51 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Matthieu Buffet <matthieu@buffet.re>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	<serge@hallyn.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.12.y] landlock: Fix TCP handling of short AF_UNSPEC addresses
Date: Thu, 28 May 2026 12:14:26 +0000
Message-ID: <20260528-spice-spiral-4cde3d3b@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254968-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,amazon.de:dkim,digikod.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,key.data:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1198C5F1FB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogTWF0dGhpZXUgQnVmZmV0IDxtYXR0aGlldUBidWZmZXQucmU+CgpbIFVwc3RyZWFtIGNv
bW1pdCBlNGQ4MmNiY2UyMjU4ZjQ1NDYzNDMwN2ZkYWJmMzNhYTQ2YjYxYWIwIF0KCmN1cnJlbnRf
Y2hlY2tfYWNjZXNzX3NvY2tldCgpIHRyZWF0cyBBRl9VTlNQRUMgYWRkcmVzc2VzIGFzCkFGX0lO
RVQgb25lcywgYW5kIG9ubHkgbGF0ZXIgYWRkcyBzcGVjaWFsIGNhc2UgaGFuZGxpbmcgdG8KYWxs
b3cgY29ubmVjdChBRl9VTlNQRUMpLCBhbmQgb24gSVB2NCBzb2NrZXRzCmJpbmQoQUZfVU5TUEVD
K0lOQUREUl9BTlkpLgpUaGlzIHdvdWxkIGJlIGZpbmUgZXhjZXB0IEFGX1VOU1BFQyBhZGRyZXNz
ZXMgY2FuIGJlIGFzCnNob3J0IGFzIGEgYmFyZSBBRl9VTlNQRUMgc2FfZmFtaWx5X3QgZmllbGQs
IGFuZCBub3RoaW5nCm1vcmUuIFRoZSBBRl9JTkVUIGNvZGUgcGF0aCBpbmNvcnJlY3RseSBlbmZv
cmNlcyBhIGxlbmd0aCBvZgpzaXplb2Yoc3RydWN0IHNvY2thZGRyX2luKSBpbnN0ZWFkLgoKTW92
ZSBBRl9VTlNQRUMgZWRnZSBjYXNlIGhhbmRsaW5nIHVwIGluc2lkZSB0aGUgc3dpdGNoLWNhc2Us
CmJlZm9yZSB0aGUgYWRkcmVzcyBpcyAocG90ZW50aWFsbHkgaW5jb3JyZWN0bHkpIHRyZWF0ZWQg
YXMKQUZfSU5FVC4KCkZpeGVzOiBmZmY2OWZiMDNkZGUgKCJsYW5kbG9jazogU3VwcG9ydCBuZXR3
b3JrIHJ1bGVzIHdpdGggVENQIGJpbmQgYW5kIGNvbm5lY3QiKQpTaWduZWQtb2ZmLWJ5OiBNYXR0
aGlldSBCdWZmZXQgPG1hdHRoaWV1QGJ1ZmZldC5yZT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MTAyNzE5MDcyNi42MjYyNDQtNC1tYXR0aGlldUBidWZmZXQucmUKU2lnbmVk
LW9mZi1ieTogTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lrb2QubmV0PgpbIFRoZXJlIHdhcyBh
IGNvbmZsaWN0IGR1ZSB0byBtaXNzaW5nIGNvbW1pdCA5Zjc0NDExYTQwY2UgKCJsYW5kbG9jazoK
ICBMb2cgVENQIGJpbmQgYW5kIGNvbm5lY3QgZGVuaWFscyIpIF0KU2lnbmVkLW9mZi1ieTogTWF4
aW1pbGlhbiBIZXluZSA8bWhleW5lQGFtYXpvbi5kZT4KLS0tCgpCYWNrcG9ydGluZyB0aGlzIGJl
Y2F1c2UgbGFuZGxvY2svbmV0X3Rlc3QgZGV0ZXJtaW5pc3RpY2FsbHkgZmFpbHMgYXMKdGhlIHNl
bGZ0ZXN0IGZyb20gdGhlIHBhdGNoIHNlcmllcyAiRml4IFRDUCBzaG9ydCBBRl9VTlNQRUMgaGFu
ZGxpbmciCihodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTEwMjcxOTA3MjYuNjI2MjQ0
LTEtbWF0dGhpZXVAYnVmZmV0LnJlLykKaGFzIGJlZW4gYmFja3BvcnRlZCB0byA2LjEyIGJ1dCBu
b3QgdGhpcyBwYXRjaCBkdWUgdG8gY29uZmxpY3RzLgoKLS0tCgogc2VjdXJpdHkvbGFuZGxvY2sv
bmV0LmMgfCAxMTggKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NlY3VyaXR5L2xhbmRsb2NrL25ldC5jIGIvc2VjdXJpdHkvbGFuZGxvY2svbmV0LmMKaW5k
ZXggMTA0YjZjMDFmZTUwMy4uNTNkNDc5ODkzNDc1ZiAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvbGFu
ZGxvY2svbmV0LmMKKysrIGIvc2VjdXJpdHkvbGFuZGxvY2svbmV0LmMKQEAgLTcyLDYgKzcyLDYx
IEBAIHN0YXRpYyBpbnQgY3VycmVudF9jaGVja19hY2Nlc3Nfc29ja2V0KHN0cnVjdCBzb2NrZXQg
KmNvbnN0IHNvY2ssCiAKIAlzd2l0Y2ggKGFkZHJlc3MtPnNhX2ZhbWlseSkgewogCWNhc2UgQUZf
VU5TUEVDOgorCQlpZiAoYWNjZXNzX3JlcXVlc3QgPT0gTEFORExPQ0tfQUNDRVNTX05FVF9DT05O
RUNUX1RDUCkgeworCQkJLyoKKwkJCSAqIENvbm5lY3RpbmcgdG8gYW4gYWRkcmVzcyB3aXRoIEFG
X1VOU1BFQyBkaXNzb2x2ZXMKKwkJCSAqIHRoZSBUQ1AgYXNzb2NpYXRpb24sIHdoaWNoIGhhdmUg
dGhlIHNhbWUgZWZmZWN0IGFzCisJCQkgKiBjbG9zaW5nIHRoZSBjb25uZWN0aW9uIHdoaWxlIHJl
dGFpbmluZyB0aGUgc29ja2V0CisJCQkgKiBvYmplY3QgKGkuZS4sIHRoZSBmaWxlIGRlc2NyaXB0
b3IpLiAgQXMgZm9yIGRyb3BwaW5nCisJCQkgKiBwcml2aWxlZ2VzLCBjbG9zaW5nIGNvbm5lY3Rp
b25zIGlzIGFsd2F5cyBhbGxvd2VkLgorCQkJICoKKwkJCSAqIEZvciBhIFRDUCBhY2Nlc3MgY29u
dHJvbCBzeXN0ZW0sIHRoaXMgcmVxdWVzdCBpcworCQkJICogbGVnaXRpbWF0ZS4gTGV0IHRoZSBu
ZXR3b3JrIHN0YWNrIGhhbmRsZSBwb3RlbnRpYWwKKwkJCSAqIGluY29uc2lzdGVuY2llcyBhbmQg
cmV0dXJuIC1FSU5WQUwgaWYgbmVlZGVkLgorCQkJICovCisJCQlyZXR1cm4gMDsKKwkJfSBlbHNl
IGlmIChhY2Nlc3NfcmVxdWVzdCA9PSBMQU5ETE9DS19BQ0NFU1NfTkVUX0JJTkRfVENQKSB7CisJ
CQkvKgorCQkJICogQmluZGluZyB0byBhbiBBRl9VTlNQRUMgYWRkcmVzcyBpcyB0cmVhdGVkCisJ
CQkgKiBkaWZmZXJlbnRseSBieSBJUHY0IGFuZCBJUHY2IHNvY2tldHMuIFRoZSBzb2NrZXQncwor
CQkJICogZmFtaWx5IG1heSBjaGFuZ2UgdW5kZXIgb3VyIGZlZXQgZHVlIHRvCisJCQkgKiBzZXRz
b2Nrb3B0KElQVjZfQUREUkZPUk0pLCBidXQgdGhhdCdzIG9rOiB3ZSBlaXRoZXIKKwkJCSAqIHJl
amVjdCBlbnRpcmVseSBvciByZXF1aXJlCisJCQkgKiAlTEFORExPQ0tfQUNDRVNTX05FVF9CSU5E
X1RDUCBmb3IgdGhlIGdpdmVuIHBvcnQsIHNvCisJCQkgKiBpdCBjYW5ub3QgYmUgdXNlZCB0byBi
eXBhc3MgdGhlIHBvbGljeS4KKwkJCSAqCisJCQkgKiBJUHY0IHNvY2tldHMgbWFwIEFGX1VOU1BF
QyB0byBBRl9JTkVUIGZvcgorCQkJICogcmV0cm9jb21wYXRpYmlsaXR5IGZvciBiaW5kIGFjY2Vz
c2VzLCBvbmx5IGlmIHRoZQorCQkJICogYWRkcmVzcyBpcyBJTkFERFJfQU5ZIChjZi4gX19pbmV0
X2JpbmQpLiBJUHY2CisJCQkgKiBzb2NrZXRzIGFsd2F5cyByZWplY3QgaXQuCisJCQkgKgorCQkJ
ICogQ2hlY2tpbmcgdGhlIGFkZHJlc3MgaXMgcmVxdWlyZWQgdG8gbm90IHdyb25nZnVsbHkKKwkJ
CSAqIHJldHVybiAtRUFDQ0VTIGluc3RlYWQgb2YgLUVBRk5PU1VQUE9SVCBvciAtRUlOVkFMLgor
CQkJICogV2UgY291bGQgcmV0dXJuIDAgYW5kIGxldCB0aGUgbmV0d29yayBzdGFjayBoYW5kbGUK
KwkJCSAqIHRoZXNlIGNoZWNrcywgYnV0IGl0IGlzIHNhZmVyIHRvIHJldHVybiBhIHByb3Blcgor
CQkJICogZXJyb3IgYW5kIHRlc3QgY29uc2lzdGVuY3kgdGhhbmtzIHRvIGtzZWxmdGVzdC4KKwkJ
CSAqLworCQkJaWYgKHNvY2stPnNrLT5fX3NrX2NvbW1vbi5za2NfZmFtaWx5ID09IEFGX0lORVQp
IHsKKwkJCQljb25zdCBzdHJ1Y3Qgc29ja2FkZHJfaW4gKmNvbnN0IHNvY2thZGRyID0KKwkJCQkJ
KHN0cnVjdCBzb2NrYWRkcl9pbiAqKWFkZHJlc3M7CisKKwkJCQlpZiAoYWRkcmxlbiA8IHNpemVv
ZihzdHJ1Y3Qgc29ja2FkZHJfaW4pKQorCQkJCQlyZXR1cm4gLUVJTlZBTDsKKworCQkJCWlmIChz
b2NrYWRkci0+c2luX2FkZHIuc19hZGRyICE9CisJCQkJICAgIGh0b25sKElOQUREUl9BTlkpKQor
CQkJCQlyZXR1cm4gLUVBRk5PU1VQUE9SVDsKKwkJCX0gZWxzZSB7CisJCQkJaWYgKGFkZHJsZW4g
PCBTSU42X0xFTl9SRkMyMTMzKQorCQkJCQlyZXR1cm4gLUVJTlZBTDsKKwkJCQllbHNlCisJCQkJ
CXJldHVybiAtRUFGTk9TVVBQT1JUOworCQkJfQorCQl9IGVsc2UgeworCQkJV0FSTl9PTl9PTkNF
KDEpOworCQl9CisJCS8qIE9ubHkgZm9yIGJpbmQoQUZfVU5TUEVDK0lOQUREUl9BTlkpIG9uIElQ
djQgc29ja2V0LiAqLworCQlmYWxsdGhyb3VnaDsKIAljYXNlIEFGX0lORVQ6CiAJCWlmIChhZGRy
bGVuIDwgc2l6ZW9mKHN0cnVjdCBzb2NrYWRkcl9pbikpCiAJCQlyZXR1cm4gLUVJTlZBTDsKQEAg
LTkwLDU3ICsxNDUsMTggQEAgc3RhdGljIGludCBjdXJyZW50X2NoZWNrX2FjY2Vzc19zb2NrZXQo
c3RydWN0IHNvY2tldCAqY29uc3Qgc29jaywKIAkJcmV0dXJuIDA7CiAJfQogCi0JLyogU3BlY2lm
aWMgQUZfVU5TUEVDIGhhbmRsaW5nLiAqLwotCWlmIChhZGRyZXNzLT5zYV9mYW1pbHkgPT0gQUZf
VU5TUEVDKSB7Ci0JCS8qCi0JCSAqIENvbm5lY3RpbmcgdG8gYW4gYWRkcmVzcyB3aXRoIEFGX1VO
U1BFQyBkaXNzb2x2ZXMgdGhlIFRDUAotCQkgKiBhc3NvY2lhdGlvbiwgd2hpY2ggaGF2ZSB0aGUg
c2FtZSBlZmZlY3QgYXMgY2xvc2luZyB0aGUKLQkJICogY29ubmVjdGlvbiB3aGlsZSByZXRhaW5p
bmcgdGhlIHNvY2tldCBvYmplY3QgKGkuZS4sIHRoZSBmaWxlCi0JCSAqIGRlc2NyaXB0b3IpLiAg
QXMgZm9yIGRyb3BwaW5nIHByaXZpbGVnZXMsIGNsb3NpbmcKLQkJICogY29ubmVjdGlvbnMgaXMg
YWx3YXlzIGFsbG93ZWQuCi0JCSAqCi0JCSAqIEZvciBhIFRDUCBhY2Nlc3MgY29udHJvbCBzeXN0
ZW0sIHRoaXMgcmVxdWVzdCBpcyBsZWdpdGltYXRlLgotCQkgKiBMZXQgdGhlIG5ldHdvcmsgc3Rh
Y2sgaGFuZGxlIHBvdGVudGlhbCBpbmNvbnNpc3RlbmNpZXMgYW5kCi0JCSAqIHJldHVybiAtRUlO
VkFMIGlmIG5lZWRlZC4KLQkJICovCi0JCWlmIChhY2Nlc3NfcmVxdWVzdCA9PSBMQU5ETE9DS19B
Q0NFU1NfTkVUX0NPTk5FQ1RfVENQKQotCQkJcmV0dXJuIDA7Ci0KLQkJLyoKLQkJICogRm9yIGNv
bXBhdGliaWxpdHkgcmVhc29uLCBhY2NlcHQgQUZfVU5TUEVDIGZvciBiaW5kCi0JCSAqIGFjY2Vz
c2VzIChtYXBwZWQgdG8gQUZfSU5FVCkgb25seSBpZiB0aGUgYWRkcmVzcyBpcwotCQkgKiBJTkFE
RFJfQU5ZIChjZi4gX19pbmV0X2JpbmQpLiAgQ2hlY2tpbmcgdGhlIGFkZHJlc3MgaXMKLQkJICog
cmVxdWlyZWQgdG8gbm90IHdyb25nZnVsbHkgcmV0dXJuIC1FQUNDRVMgaW5zdGVhZCBvZgotCQkg
KiAtRUFGTk9TVVBQT1JULgotCQkgKgotCQkgKiBXZSBjb3VsZCByZXR1cm4gMCBhbmQgbGV0IHRo
ZSBuZXR3b3JrIHN0YWNrIGhhbmRsZSB0aGVzZQotCQkgKiBjaGVja3MsIGJ1dCBpdCBpcyBzYWZl
ciB0byByZXR1cm4gYSBwcm9wZXIgZXJyb3IgYW5kIHRlc3QKLQkJICogY29uc2lzdGVuY3kgdGhh
bmtzIHRvIGtzZWxmdGVzdC4KLQkJICovCi0JCWlmIChhY2Nlc3NfcmVxdWVzdCA9PSBMQU5ETE9D
S19BQ0NFU1NfTkVUX0JJTkRfVENQKSB7Ci0JCQkvKiBhZGRybGVuIGhhcyBhbHJlYWR5IGJlZW4g
Y2hlY2tlZCBmb3IgQUZfVU5TUEVDLiAqLwotCQkJY29uc3Qgc3RydWN0IHNvY2thZGRyX2luICpj
b25zdCBzb2NrYWRkciA9Ci0JCQkJKHN0cnVjdCBzb2NrYWRkcl9pbiAqKWFkZHJlc3M7Ci0KLQkJ
CWlmIChzb2NrLT5zay0+X19za19jb21tb24uc2tjX2ZhbWlseSAhPSBBRl9JTkVUKQotCQkJCXJl
dHVybiAtRUlOVkFMOwotCi0JCQlpZiAoc29ja2FkZHItPnNpbl9hZGRyLnNfYWRkciAhPSBodG9u
bChJTkFERFJfQU5ZKSkKLQkJCQlyZXR1cm4gLUVBRk5PU1VQUE9SVDsKLQkJfQotCX0gZWxzZSB7
Ci0JCS8qCi0JCSAqIENoZWNrcyBzYV9mYW1pbHkgY29uc2lzdGVuY3kgdG8gbm90IHdyb25nZnVs
bHkgcmV0dXJuCi0JCSAqIC1FQUNDRVMgaW5zdGVhZCBvZiAtRUlOVkFMLiAgVmFsaWQgc2FfZmFt
aWx5IGNoYW5nZXMgYXJlCi0JCSAqIG9ubHkgKGZyb20gQUZfSU5FVCBvciBBRl9JTkVUNikgdG8g
QUZfVU5TUEVDLgotCQkgKgotCQkgKiBXZSBjb3VsZCByZXR1cm4gMCBhbmQgbGV0IHRoZSBuZXR3
b3JrIHN0YWNrIGhhbmRsZSB0aGlzCi0JCSAqIGNoZWNrLCBidXQgaXQgaXMgc2FmZXIgdG8gcmV0
dXJuIGEgcHJvcGVyIGVycm9yIGFuZCB0ZXN0Ci0JCSAqIGNvbnNpc3RlbmN5IHRoYW5rcyB0byBr
c2VsZnRlc3QuCi0JCSAqLwotCQlpZiAoYWRkcmVzcy0+c2FfZmFtaWx5ICE9IHNvY2stPnNrLT5f
X3NrX2NvbW1vbi5za2NfZmFtaWx5KQotCQkJcmV0dXJuIC1FSU5WQUw7Ci0JfQorCS8qCisJICog
Q2hlY2tzIHNhX2ZhbWlseSBjb25zaXN0ZW5jeSB0byBub3Qgd3JvbmdmdWxseSByZXR1cm4KKwkg
KiAtRUFDQ0VTIGluc3RlYWQgb2YgLUVJTlZBTC4gIFZhbGlkIHNhX2ZhbWlseSBjaGFuZ2VzIGFy
ZQorCSAqIG9ubHkgKGZyb20gQUZfSU5FVCBvciBBRl9JTkVUNikgdG8gQUZfVU5TUEVDLgorCSAq
CisJICogV2UgY291bGQgcmV0dXJuIDAgYW5kIGxldCB0aGUgbmV0d29yayBzdGFjayBoYW5kbGUg
dGhpcworCSAqIGNoZWNrLCBidXQgaXQgaXMgc2FmZXIgdG8gcmV0dXJuIGEgcHJvcGVyIGVycm9y
IGFuZCB0ZXN0CisJICogY29uc2lzdGVuY3kgdGhhbmtzIHRvIGtzZWxmdGVzdC4KKwkgKi8KKwlp
ZiAoYWRkcmVzcy0+c2FfZmFtaWx5ICE9IHNvY2stPnNrLT5fX3NrX2NvbW1vbi5za2NfZmFtaWx5
ICYmCisJICAgIGFkZHJlc3MtPnNhX2ZhbWlseSAhPSBBRl9VTlNQRUMpCisJCXJldHVybiAtRUlO
VkFMOwogCiAJaWQua2V5LmRhdGEgPSAoX19mb3JjZSB1aW50cHRyX3QpcG9ydDsKIAlCVUlMRF9C
VUdfT04oc2l6ZW9mKHBvcnQpID4gc2l6ZW9mKGlkLmtleS5kYXRhKSk7Ci0tIAoyLjUwLjEKCgoK
CkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1h
cmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9m
IEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFy
bG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1
IDUzOCA1OTcK


