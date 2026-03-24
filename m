Return-Path: <stable+bounces-230147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPoPLnt8wmnqdAQAu9opvQ
	(envelope-from <stable+bounces-230147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:58:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32734307C74
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA64B3193210
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491D3EF654;
	Tue, 24 Mar 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UD9rW7rB"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEA3EE1E8
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352896; cv=none; b=asZjhGIXABN3+jBnyqV8O6adRcg3xTGazGxvmQV/8mxXnRrfkwBWTrC41/D8Uhx9+ftCKe0ZIIcywItIpiCPnlMER+g6J9HlchjI9kYpCPEqvJhw4Ssa3tOeLKw14cMj0ZCnj9Nnr1QoTu2iDA1NUyZLW5iRrcWaXBd2ycPwUnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352896; c=relaxed/simple;
	bh=70nRTQmUL9N7jpW/RSlF3u++wf1e6ItXMN8QZNNODhY=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=WbIgCBs6vCYkrBh8kXrT/Omu29DTSMkipJJ9QA2iLbFzKDjt345YlSuec3rnWfcJDDVnSDQWZ01A/XvL0PiRqydQ1ULCNh2/x4VWBnk6KiG1EjiGP3Zb0TNmpbNaFkznAWVxMH95J2d7s+N3r4qsmXFAbH2nEBoSnJJ0TwKfhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UD9rW7rB; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774352882; bh=8D09bDag8HWhoMuT8j04/T4exyvCYLSTYFAfVS9qxAQ=;
	h=From:To:CC:Subject:Date;
	b=UD9rW7rBrDc4WJqGQetaXCNflnMlGAiuurNq4mJsfIcYINgCDcpFSDqqCHzOoZJ1m
	 u4B6gAzCLYQn1iudBGCN+lE6oX7h45qbGPPtaTEEB4MYLqFen1mQUJIjrsuRqv4RX+
	 JgaOgGcL+G1vQ3MD/nFzcECYjJD13KhMSYAvEnyY=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-XMAILINFO: OATpkVjS499uZ/BQH2PzVAZpZQ01Q91ONybja8qWhHQK+E1DT+99HXYRouXh2I
	 4e9sq7epUVxbWLrdSggaxA3HV9PXpL6GCDYlVKN2n27fnf1l2//t/xW9wCcQV9Rz4Z3oUpqyUspRf
	 m3zU0V+Q7WN4hsWJpZ3DHFMD9ASU0S9/ebaj4g4Drb2LQv88k9IKO4Ym5tyT7Nfv3tsTcypNuVhKT
	 UpcN7hmyjFnEdcODAD6v2c846vcY0eV5U/dA2N3LXrIfj6duvW0JrpbmB9JetB6Gut+5YFlHGaYJx
	 pEgaOAQJ0f/eaDZBYd3Kuh1J6pwvd5AX2+x36ZBG9R9asCKkbvsFtSiEeqjnOTeUn+AGd+VbPyI7j
	 M7CzNZh/KKWIMMDYMOVPmNlhcor4caIlkKvrNwj8N7KSNu5lxpwBZ8zA2zP2KSjNOVaJrbKXjpXTl
	 qcq0zcGke65LDGjCNgneRLVW5dmHGC3UYRN9ipBagrbFsMd4kdkkwoO1t64/BxxmA3k8Kr3q4i9HC
	 OqAI5XW7hH00I7pR/JIYkI1rbhZAL8aC684XOO0dzpoRN0fRwVFQiGGjxjs91XCAtUFLE0f8btXvG
	 uxbc8iK4V3FakecIuk2iuGZEpb4rx3PYFFwUZnWuE4joxgD7mkZ+SrMBJq7e7Y5hFE1HK8Ee7IGBQ
	 ICkzXKYy44mNWGotXy4ChXOZNulOVDT6OaN4jsrTcJc3ftl4HrPKMlgQpoz0BYfMoaVVWwUesEV1S
	 JbxHL10mcPiSMttxSw3EpHl74FRbybbhrXqJhuOSB+JthTJAn0uzP6OUppYqp/GzCDp3LV0Pjgsea
	 ZiHxmIBrF2ga6lnNdqmHiCAONvn6hjFZtgSdwSoU9ccYOniAlNuunwerZ57T9PLxbQ7iOGE5b879p
	 zonHJK7Udv64ZsccL8CHQLSJ7dF1Wk71A/4qSRNydwVpGoW+UhKcEWPqMshiazTeriCkXpLzKPi1S
	 Zx0o/OcU11AGs6rgxZztkrt29TAke7/Hl1vzuNIRyS1AcPxoxwrbpNN8irkajNw/dxIfYGjJt9uvB
	 pi7xP+Y+CBenX8xca4U2+E3+x6SVhsSkOoqY1DoWiWi5VtXGJlAwBtMO/ByDIZCknpPfuZLLD6wsz
	 vH+XRfa5n2a6kg==
Received: from SG2PR02MB5841.apcprd02.prod.outlook.com ([2603:1046:c01:910::5])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id C00A16F2; Tue, 24 Mar 2026 19:48:00 +0800
X-QQ-mid: xmsmtpt1774352880t5gzag8xs
Message-ID: <tencent_98CE0848898D658EF0DF2091F876CCAAAD08@qq.com>
From: "driz2t@qq.com" <driz2t@qq.com>
To: "syzbot+c0ffed3897231d71f047@syzkaller.appspotmail.com"
	<syzbot+c0ffed3897231d71f047@syzkaller.appspotmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 5.15.y] iomap: don't invalidate folios after writeback errors
Thread-Topic: [PATCH 5.15.y] iomap: don't invalidate folios after writeback
 errors
Thread-Index: AQHcu4MibxnwRL+8h02Nl8VuwU2PAA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 24 Mar 2026 11:48:00 +0000
X-OQ-MSGID:
	<SG2PR02MB5841C7221FCBB3A6B08EBE62F248A@SG2PR02MB5841.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: multipart/mixed;
	boundary="_002_SG2PR02MB5841C7221FCBB3A6B08EBE62F248ASG2PR02MB5841apcp_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230147-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[stable,c0ffed3897231d71f047];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 32734307C74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--_002_SG2PR02MB5841C7221FCBB3A6B08EBE62F248ASG2PR02MB5841apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=0A=
=0A=
Please test this patch on stable 5.15.y.=0A=
=0A=
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git 3=
330a8d33e086f76608bb4e80a3dc569d04a8814=0A=
=0A=
Thanks,=0A=
Changjian Liu=

--_002_SG2PR02MB5841C7221FCBB3A6B08EBE62F248ASG2PR02MB5841apcp_
Content-Type: application/octet-stream; name="c0ffed3897231d71f047.patch"
Content-Description: c0ffed3897231d71f047.patch
Content-Disposition: attachment; filename="c0ffed3897231d71f047.patch";
	size=2692; creation-date="Tue, 24 Mar 2026 11:47:45 GMT";
	modification-date="Tue, 24 Mar 2026 11:47:45 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlNmU5YWIwNGQzN2Y2MDdmZTg5Y2U1MjM3YzYzNGNhNDYzYzExZDM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGFuZ2ppYW4gTGl1IDxkcml6MnRAcXEuY29tPgpEYXRlOiBU
dWUsIDI0IE1hciAyMDI2IDE5OjMyOjE0ICswODAwClN1YmplY3Q6IFtQQVRDSF0gaW9tYXA6IGRv
bid0IGludmFsaWRhdGUgZm9saW9zIGFmdGVyIHdyaXRlYmFjayBlcnJvcnMKClhGUyBoYXMgdGhl
IHVuaXF1ZSBiZWhhdmlvciB0aGF0IG9uIHdyaXRlYmFjayBlcnJvcnMgaXQgd2lsbCBjb21wbGV0
ZWx5CmludmFsaWRhdGUgdGhlIGFmZmVjdGVkIGZvbGlvIGFuZCBmb3JjZSB0aGUgcGFnZSBjYWNo
ZSB0byByZXJlYWQgdGhlCmNvbnRlbnRzIGZyb20gZGlzay4gQWxsIG90aGVyIGZpbGVzeXN0ZW1z
IGxlYXZlIHRoZSBwYWdlIG1hcHBlZCBhbmQgdXAKdG8gZGF0ZS4KClRoaXMgaXMgYSBydWRlIGF3
YWtlbmluZyBmb3IgdXNlciBwcm9ncmFtcywgc2luY2UgZmlsZSBjb250ZW50cyB3aWxsCmFwcGVh
ciB0byByZXZlcnQgdG8gb2xkIGRpc2sgY29udGVudHMgd2l0aCBubyBub3RpZmljYXRpb24gb3Ro
ZXIgdGhhbgphbiBFSU8gb24gZnN5bmMuIFdpdGggbXVsdGlwYWdlIGZvbGlvcywgd2UgY2FuIG5v
dyB0aHJvdyBhd2F5ICptZWdhYnl0ZXMqCndvcnRoIG9mIGRhdGEgZm9yIGEgc2luZ2xlIHdyaXRl
IGVycm9yLgoKQWRkaXRpb25hbGx5LCB0aGlzIGJlaGF2aW9yIGNhbiBjYXVzZSBhIFVzZS1BZnRl
ci1GcmVlIChVQUYpIHdoZW4KeGZzX2Rpc2NhcmRfZm9saW8gaW52YWxpZGF0ZXMgbXVsdGlwYWdl
IGZvbGlvcyB0aGF0IGNvdWxkIGJlIHVuZGVyZ29pbmcKd3JpdGViYWNrLiBJZiB3cml0ZWJhY2sg
ZmFpbHMgaW4gdGhlIG1pZGRsZSBvZiBhIGZvbGlvLCB3ZSBmcmVlIHRoZSBpb3AKYXR0YWNoZWQg
dG8gdGhlIGZvbGlvLCBjYXVzaW5nIHdyaXRlYmFjayBjb21wbGV0aW9uIG9uIHRoZSBlYXJsaWVy
IHBhcnQKdG8gdHJpcCBvdmVyIGFzc2VydGlvbnMuCgpHZXQgcmlkIG9mIHRoZSB3aG9sZSBiZWhh
dmlvciBlbnRpcmVseSBieSByZXR1cm5pbmcgZWFybHkgaW4KeGZzX2Rpc2NhcmRfZm9saW8oKSBp
ZiB0aGUgZmlsZXN5c3RlbSBpcyBzaHV0dGluZyBkb3duLCBhbmQgcmVtb3ZpbmcKdGhlIHVuY29u
ZGl0aW9uYWwgZm9saW9fY2xlYXJfdXB0b2RhdGUoKSBjYWxsIGluIGlvbWFwX3dyaXRlcGFnZV9t
YXAoKS4KClNpZ25lZC1vZmYtYnk6IENoYW5namlhbiBMaXUgPGRyaXoydEBxcS5jb20+Ci0tLQog
ZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyB8IDEgLQogZnMveGZzL3hmc19hb3BzLmMgICAgICB8IDQg
Ky0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9mcy9pb21hcC9idWZmZXJlZC1pby5jIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8u
YwppbmRleCA4N2E0ZjVhMmRlZDAuLjFmMGJmZTBiOGJhZSAxMDA2NDQKLS0tIGEvZnMvaW9tYXAv
YnVmZmVyZWQtaW8uYworKysgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jCkBAIC0xMzUwLDcgKzEz
NTAsNiBAQCBpb21hcF93cml0ZXBhZ2VfbWFwKHN0cnVjdCBpb21hcF93cml0ZXBhZ2VfY3R4ICp3
cGMsCiAJCWlmICh3cGMtPm9wcy0+ZGlzY2FyZF9wYWdlKQogCQkJd3BjLT5vcHMtPmRpc2NhcmRf
cGFnZShwYWdlLCBmaWxlX29mZnNldCk7CiAJCWlmICghY291bnQpIHsKLQkJCUNsZWFyUGFnZVVw
dG9kYXRlKHBhZ2UpOwogCQkJdW5sb2NrX3BhZ2UocGFnZSk7CiAJCQlnb3RvIGRvbmU7CiAJCX0K
ZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfYW9wcy5jIGIvZnMveGZzL3hmc19hb3BzLmMKaW5kZXgg
YzhjMTVjM2MzMTQ3Li41NmE1YmQ3YWQ4YzQgMTAwNjQ0Ci0tLSBhL2ZzL3hmcy94ZnNfYW9wcy5j
CisrKyBiL2ZzL3hmcy94ZnNfYW9wcy5jCkBAIC00NTAsNyArNDUwLDcgQEAgeGZzX2Rpc2NhcmRf
cGFnZSgKIAlpbnQJCQllcnJvcjsKIAogCWlmICh4ZnNfaXNfc2h1dGRvd24obXApKQotCQlnb3Rv
IG91dF9pbnZhbGlkYXRlOworCQlyZXR1cm47CiAKIAl4ZnNfYWxlcnRfcmF0ZWxpbWl0ZWQobXAs
CiAJCSJwYWdlIGRpc2NhcmQgb24gcGFnZSAiUFRSX0ZNVCIsIGlub2RlIDB4JWxseCwgb2Zmc2V0
ICVsbHUuIiwKQEAgLTQ2MCw4ICs0NjAsNiBAQCB4ZnNfZGlzY2FyZF9wYWdlKAogCQkJaV9ibG9j
a3NfcGVyX3BhZ2UoaW5vZGUsIHBhZ2UpIC0gcGFnZW9mZl9mc2IpOwogCWlmIChlcnJvciAmJiAh
eGZzX2lzX3NodXRkb3duKG1wKSkKIAkJeGZzX2FsZXJ0KG1wLCAicGFnZSBkaXNjYXJkIHVuYWJs
ZSB0byByZW1vdmUgZGVsYWxsb2MgbWFwcGluZy4iKTsKLW91dF9pbnZhbGlkYXRlOgotCWlvbWFw
X2ludmFsaWRhdGVwYWdlKHBhZ2UsIHBhZ2VvZmYsIFBBR0VfU0laRSAtIHBhZ2VvZmYpOwogfQog
CiBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbWFwX3dyaXRlYmFja19vcHMgeGZzX3dyaXRlYmFja19v
cHMgPSB7Ci0tIAoyLjQzLjAKCg==

--_002_SG2PR02MB5841C7221FCBB3A6B08EBE62F248ASG2PR02MB5841apcp_--


