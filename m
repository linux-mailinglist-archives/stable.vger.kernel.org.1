Return-Path: <stable+bounces-230273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NleG9SHw2lRrQQAu9opvQ
	(envelope-from <stable+bounces-230273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 07:59:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA53205EF
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 07:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F27133033A8E
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4835FF6E;
	Wed, 25 Mar 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FtjGTJMQ"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBD35F612;
	Wed, 25 Mar 2026 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774421870; cv=none; b=QSG1ijSlQvsp99iHS2YFN692U+H+xz14fnETyfEdek0uX9aNkC7Bqc4uitkKpoa0WkYMsV/m2Biq8xnbKfbNrh00PA9NxQvhWO3edbFBS/eX39ZdUd6o0hNsqa3sH2rZ2bEFTX2cQAr8wdC8MnoicIuCRW5LghrWUjVfFe4PZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774421870; c=relaxed/simple;
	bh=zEAaCM2+WAMzDDYuxx2LvNJNTQ5sPeYLTTt+tmxNfgA=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=EbhDA12m10GH1V0/45z2Le+TUFiqRY2w6Z0Z3dmQliwGTLTyJM6xVJM8wHXyo1Q/nSieVhJSpASUaN5ClWC4BDgcWyzMc+M5hX+bk3T7fU7Ef7kCimRwwqrqQtThrjHIK2fgDC1SllvBdGnSzSK20cgtd0pVlzEjCh9vOebXcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FtjGTJMQ; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774421864; bh=zEAaCM2+WAMzDDYuxx2LvNJNTQ5sPeYLTTt+tmxNfgA=;
	h=From:To:CC:Subject:Date;
	b=FtjGTJMQj9WfNHRHuyYcYwZ96psXNiDcTHReobW9vC7e53cg3OEzA6UJCwZdPMl1W
	 GjXTNsBTPTBmCzVmKdjFKqQaZMbJEEadENce4CmLz58WpDqTA3jpU+2A/QWwwAsFD/
	 YZRq41iXZzmJLzjYgeyi+ovymqjhRBjuoCE5sVYA=
Received: from SG2PR02MB5841.apcprd02.prod.outlook.com ([2603:1046:c01:910::5])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E6A13C2C; Wed, 25 Mar 2026 14:57:42 +0800
X-QQ-mid: xmsmtpt1774421862txevasxrw
Message-ID: <tencent_9245CADBF1A8EA39C72025351E3BAE7F130A@qq.com>
X-QQ-XMAILINFO: MBHEkxMsYPCYLh7NeLHG+ARilau1Cp4rrwRkF00JlM61TuClkPFWQb+H7c8jh8
	 MCFe+OUlXNyPVsDGll2rSn5T2G70bR9Jd4ABOlScoLPQsWj0SPvMdKKBVXaWuVaOMSk2vzecCgEF
	 J+eIam9wK1S2d3Iy+ytMeQkv7mWxHk+xBCTUlSduHWBMz+a3f7XR8Ph1cSOV/8e7iSn2z3QoXL/3
	 AuI6s7fjeP93aT5hoEWmX0slTGAR5ry1heTKKsf9DolPeQrhnuhJGxoNo+IaQbrRgixSF1Ko2uAD
	 vFltM1YIkbS4VeswpiK5xNxLp+tpJeAarmUqB6EKXTXc3zXaL4ZYj+IIbkn/38ZbjuUPO02KMcOI
	 vWxEUzLNhSj07cSi00qu0AAapf0fSLOxT+m8NMbgqV71L5vhphmSdPwCTraFhs/uW0+b7Fk27GgI
	 xV9Xwhs5VpDs4muSpvA8+FTxkItFhnG7OpArskkDQzmo7N51sKXUJF2jl3A1Ge9xYW7dy3ecGWEa
	 nDIJJV1VE9kXoy46WE1zUtcOBlYtInum528wDnnf8mO53uwcByn/mSQJhie729nAZLrEGyQpseAg
	 1+hQUbkn3pDcgdpcGyEadvFCh6aCcfAtkt6c7w5Dl5Ttd9f5Mdb1umn43rLIiyHhsjQZwGEkktrv
	 bTgf3LC9gNkklP0ni/SDjJV1ZDIVihS5HUskRoJWAvrH/nUpzKZjcqLrl8jYDjZbSklrdz3vD1f/
	 nwnlPlEQAoanPeXLqmAMx0nYsctnmbTaiWKA40dLFvwp/1+vtCwJtNZYBjVN2+NkivpfwpfAJBe1
	 wBNI9DD+7kccfni9tiGSbKlrNHd3DrDQ8MgdZiBN6ap8IE52AmIXrd1Vt3I51QduFsZMTCMfqL/T
	 ED9AwTVY1rnqHRxq8Q8dYoVW9Hc4HinkB2XzjY55POLn4biLoX0DeEnUHYmQq73hUtxEQpyJBWZX
	 V4NrRvYgkjteBUhUfm/urdBLHRrdXi/fBY+donrSIyh3GAhwGQfQIpuA1y315COYyKbiR2RC995W
	 akazMPvw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: "driz2t@qq.com" <driz2t@qq.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+016d861797fd718491a8@syzkaller.appspotmail.com"
	<syzbot+016d861797fd718491a8@syzkaller.appspotmail.com>
Subject: [PATCH 6.1.y] erofs: get rid of z_erofs_fill_inode()
Thread-Topic: [PATCH 6.1.y] erofs: get rid of z_erofs_fill_inode()
Thread-Index: AQHcvCNiSREDcZX1vEeAargH5QRdfw==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Wed, 25 Mar 2026 06:57:41 +0000
X-OQ-MSGID:
	<SG2PR02MB5841E5C5DAD616E7678BBCFDF249A@SG2PR02MB5841.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230273-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,016d861797fd718491a8];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: DBEA53205EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhpcyBpcyBhIGJhY2twb3J0IG9mIHVwc3RyZWFtIGNvbW1pdCA0ZmRhZGQ1YjBmMGM3MjNjODEy
ODQyNDU0ZjhjY2ExNjE5ZjJlNzMxLgooZXJvZnM6IGdldCByaWQgb2Ygel9lcm9mc19maWxsX2lu
b2RlKCkpCgpSZXBvcnRlZC1ieTogc3l6Ym90KzAxNmQ4NjE3OTdmZDcxODQ5MWE4QHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20KVGVzdGVkLWJ5OiBzeXpib3QrMDE2ZDg2MTc5N2ZkNzE4NDkxYThA
c3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBDaGFuZ2ppYW4gTGl1IDxk
cml6MnRAcXEuY29tPgotLS0KwqBmcy9lcm9mcy9pbm9kZS5jIMKgIMKgIHwgwqAxMiArKysrKysr
Ky0tLS0KwqBmcy9lcm9mcy9pbnRlcm5hbC5oIMKgfCDCoCAyIC0tCsKgZnMvZXJvZnMvem1hcC5j
IMKgIMKgIMKgfCDCoDE4IC0tLS0tLS0tLS0tLS0tLS0tLQrCoHNjcmlwdHMvZXh0cmFjdC1jZXJ0
IHwgQmluIDAgLT4gMTQ2MDggYnl0ZXMKwqA0IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMjQgZGVsZXRpb25zKC0pCsKgY3JlYXRlIG1vZGUgMTAwNzU1IHNjcmlwdHMvZXh0cmFjdC1j
ZXJ0CgpkaWZmIC0tZ2l0IGEvZnMvZXJvZnMvaW5vZGUuYyBiL2ZzL2Vyb2ZzL2lub2RlLmMKaW5k
ZXggM2NiZWY2MzE4YjdiLi40ODQ1NzI1MDRiNGQgMTAwNjQ0Ci0tLSBhL2ZzL2Vyb2ZzL2lub2Rl
LmMKKysrIGIvZnMvZXJvZnMvaW5vZGUuYwpAQCAtMjgwLDExICsyODAsMTUgQEAgc3RhdGljIGlu
dCBlcm9mc19maWxsX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpCsKg4oCC4oCC4oCC4oCC4oCC
fQrCoArCoOKAguKAguKAguKAguKAgmlmIChlcm9mc19pbm9kZV9pc19kYXRhX2NvbXByZXNzZWQo
dmktPmRhdGFsYXlvdXQpKSB7CisjaWZkZWYgQ09ORklHX0VST0ZTX0ZTX1pJUArCoOKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAgmlmICghZXJvZnNfaXNfZnNjYWNoZV9tb2RlKGlub2Rl
LT5pX3NiKSAmJgot4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCIMKgIMKgaW5vZGUt
Pmlfc2ItPnNfYmxvY2tzaXplX2JpdHMgPT0gUEFHRV9TSElGVCkKLeKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmVyciA9IHpfZXJvZnNfZmlsbF9pbm9k
ZShpbm9kZSk7Ci3igILigILigILigILigILigILigILigILigILigILigIJlbHNlCi3igILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigIJlcnIgPSAtRU9QTk9U
U1VQUDsKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgiDCoCDCoGlub2RlLT5pX3Ni
LT5zX2Jsb2Nrc2l6ZV9iaXRzID09IFBBR0VfU0hJRlQpIHsKK+KAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmlub2RlLT5pX21hcHBpbmctPmFfb3BzID0g
JnpfZXJvZnNfYW9wczsKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAgmVyciA9IDA7CivigILigILigILigILigILigILigILigILigILigILigILigILi
gILigILigILigILigIJnb3RvIG91dF91bmxvY2s7CivigILigILigILigILigILigILigILigILi
gILigILigIJ9CisjZW5kaWYKK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmVyciA9
IC1FT1BOT1RTVVBQOwrCoOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmdvdG8gb3V0
X3VubG9jazsKwqDigILigILigILigILigIJ9CsKg4oCC4oCC4oCC4oCC4oCCaW5vZGUtPmlfbWFw
cGluZy0+YV9vcHMgPSAmZXJvZnNfcmF3X2FjY2Vzc19hb3BzOwpkaWZmIC0tZ2l0IGEvZnMvZXJv
ZnMvaW50ZXJuYWwuaCBiL2ZzL2Vyb2ZzL2ludGVybmFsLmgKaW5kZXggMTI2OTcwOTMyODA1Li4x
YTRkMDhhOTMzMzkgMTAwNjQ0Ci0tLSBhL2ZzL2Vyb2ZzL2ludGVybmFsLmgKKysrIGIvZnMvZXJv
ZnMvaW50ZXJuYWwuaApAQCAtNDIzLDEyICs0MjMsMTAgQEAgZW51bSB7CsKgZXh0ZXJuIGNvbnN0
IHN0cnVjdCBpb21hcF9vcHMgel9lcm9mc19pb21hcF9yZXBvcnRfb3BzOwrCoArCoCNpZmRlZiBD
T05GSUdfRVJPRlNfRlNfWklQCi1pbnQgel9lcm9mc19maWxsX2lub2RlKHN0cnVjdCBpbm9kZSAq
aW5vZGUpOwrCoGludCB6X2Vyb2ZzX21hcF9ibG9ja3NfaXRlcihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LArCoOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgiDC
oCDCoHN0cnVjdCBlcm9mc19tYXBfYmxvY2tzICptYXAsCsKg4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCIMKgIMKgaW50IGZsYWdzKTsKwqAjZWxzZQot
c3RhdGljIGlubGluZSBpbnQgel9lcm9mc19maWxsX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUp
IHsgcmV0dXJuIC1FT1BOT1RTVVBQOyB9CsKgc3RhdGljIGlubGluZSBpbnQgel9lcm9mc19tYXBf
YmxvY2tzX2l0ZXIoc3RydWN0IGlub2RlICppbm9kZSwKwqDigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gILigILigIIgwqBzdHJ1Y3QgZXJvZnNfbWFwX2Jsb2NrcyAqbWFwLArCoOKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAgiDCoGludCBmbGFncykKZGlmZiAtLWdpdCBhL2ZzL2Vyb2ZzL3ptYXAu
YyBiL2ZzL2Vyb2ZzL3ptYXAuYwppbmRleCBkMmQ3ZmU4MjYwOTEuLmZmODQ1MzNkYTBjNCAxMDA2
NDQKLS0tIGEvZnMvZXJvZnMvem1hcC5jCisrKyBiL2ZzL2Vyb2ZzL3ptYXAuYwpAQCAtNywyNCAr
Nyw2IEBACsKgI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4KwqAjaW5jbHVkZSA8dHJhY2UvZXZl
bnRzL2Vyb2ZzLmg+CsKgCi1pbnQgel9lcm9mc19maWxsX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUpCi17Ci3igILigILigILigILigIJzdHJ1Y3QgZXJvZnNfaW5vZGUgKmNvbnN0IHZpID0gRVJP
RlNfSShpbm9kZSk7Ci3igILigILigILigILigIJzdHJ1Y3QgZXJvZnNfc2JfaW5mbyAqc2JpID0g
RVJPRlNfU0IoaW5vZGUtPmlfc2IpOwotCi3igILigILigILigILigIJpZiAoIWVyb2ZzX3NiX2hh
c19iaWdfcGNsdXN0ZXIoc2JpKSAmJgot4oCC4oCC4oCC4oCC4oCCIMKgIMKgIWVyb2ZzX3NiX2hh
c196dGFpbHBhY2tpbmcoc2JpKSAmJiAhZXJvZnNfc2JfaGFzX2ZyYWdtZW50cyhzYmkpICYmCi3i
gILigILigILigILigIIgwqAgwqB2aS0+ZGF0YWxheW91dCA9PSBFUk9GU19JTk9ERV9DT01QUkVT
U0VEX0ZVTEwpIHsKLeKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnZpLT56X2Fkdmlz
ZSA9IDA7Ci3igILigILigILigILigILigILigILigILigILigILigIJ2aS0+el9hbGdvcml0aG10
eXBlWzBdID0gMDsKLeKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnZpLT56X2FsZ29y
aXRobXR5cGVbMV0gPSAwOwot4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCdmktPnpf
bG9naWNhbF9jbHVzdGVyYml0cyA9IGlub2RlLT5pX3NiLT5zX2Jsb2Nrc2l6ZV9iaXRzOwot4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCc2V0X2JpdChFUk9GU19JX1pfSU5JVEVEX0JJ
VCwgJnZpLT5mbGFncyk7Ci3igILigILigILigILigIJ9Ci3igILigILigILigILigIJpbm9kZS0+
aV9tYXBwaW5nLT5hX29wcyA9ICZ6X2Vyb2ZzX2FvcHM7Ci3igILigILigILigILigIJyZXR1cm4g
MDsKLX0KLQrCoHN0cnVjdCB6X2Vyb2ZzX21hcHJlY29yZGVyIHsKwqDigILigILigILigILigIJz
dHJ1Y3QgaW5vZGUgKmlub2RlOwrCoOKAguKAguKAguKAguKAgnN0cnVjdCBlcm9mc19tYXBfYmxv
Y2tzICptYXA7Ci0twqAKMi40My4w


