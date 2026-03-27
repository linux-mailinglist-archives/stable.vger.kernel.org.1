Return-Path: <stable+bounces-230607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHSIK/NIxmmgIAUAu9opvQ
	(envelope-from <stable+bounces-230607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:08:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E466F3417AE
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31947300B454
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B13CCFDE;
	Fri, 27 Mar 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LMVwCJwP"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8843932DD
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602479; cv=none; b=pYdYyH016c+nX7Am83T9hfTtTZ6zCmWJISzjYxBRS4ejNyx/GsV1mwJuN/waDqYri9pi+lZn/2yjqjsZqBlgQweFBACPaUBsr6a3X2MgOoRdWa4Vru1cm2V00ThV+9OWZbUatrv9/ihVJtP/cbcEZFgCTyBcOomRB33d44aN4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602479; c=relaxed/simple;
	bh=QQDI3JeLqthwFW0tkRsfMFCRWlvrD8GRaF66K3mm308=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=IExPCCIcsfF2SKaoXuD1MkeNpvvlmG5EW1qQ/RAUTdJMjYHa1k7MDeiLrkzWGFFVtPKtK1sfXYuKJsZlC5hlyNjer/oEL2J4PhWE3DEl/b8vdSO/CctDbmDfeAvXFqK8mSrr2Da754zv9xC64R6YuK/a5ElwhnfQJ3ibx9dkCwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LMVwCJwP; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774602471; bh=vrFm+xC55CDc4HYxfDYnytX1lTbJWF5ePRQy5GrlG+Y=;
	h=From:To:Cc:Subject:Date;
	b=LMVwCJwPb9L59tPNdEvuk2WkXT6SivcaHXkdNNupMHp31hVd/PpdGiqEFAMY4J8W5
	 RY5xpKUFXr46egVggoyLRviyj+NBH8Pcdk/wYBW2GbqBzfL6IQk36GhzsYmsAWCJBk
	 Q910Uz4Aqsr5QLjaLfrazaDgzcLTtQF/ihcTo7i8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: Nyxko0BhXiLd/XKTqjWAEjpo9xANschXIDJghA6QvqD69bvFU0r6n2zJdvbEop
	 wLexfOIfyqkiSWOmKxlzKSdz25vv1tR2a0QS/LSQxBr061ju8OgkviRablnqqIxqaUsw1MJSI4lBg
	 CvmhxpDUpjGz9yysBfYxj0WFWxMCUDVLW64FW/2ggH9633EAj8RFkRB7ft9CmfAO6xM7r1491lBKv
	 xHykZvYSoLzMQI+5rVdorulp5BXQb8DAgjNxsQLQwoDbMCukafCk6eUTydVvd8DI/j+9FBC1rIqx5
	 IudzeX3qZArfpBTyBlVR/p9/xyyHSdf+Ezhg00EpGHyxPI7dVmXS447hDa9JSW1aK3k6ubnBL55FE
	 FMcd0Pkb/m2AvYeHIip/3Tail3YoXVQMcs5VOwFjAzafSW3exYBPd56Kz4ockLh4afevokYBY+ecr
	 FelRRu3eGo3di4eDGM9gDcgioJO3FPbv07IqewSq0qGLrRtO6T4X2tgs0UAfGEMrCW7xcQWJi/4s/
	 yZNunRut2dN/CnPEMHbV/7aryt/SwYnJCq/q18aQhHknYpW8SVpB53nosIjoFlCrStvlhu5MfJ5Ij
	 du4Vspg4VnQWdL5i4kh/HVjOecrc2j/6w2ezVzyHd2Z7/3vmUeZ2phk9rDh7vAqzKvYJJ1ycVGARN
	 mvDEspBWCDSzGUf/LBfFQ1OzHZL3nqbbfeR9y+8hmSU5jD3VogC8ioYGixxCfMGjpQn5I/6Cye9J7
	 Y4SEg75jo1vVKMChMMSCEDP4fUNUMHdt2A7yIGq0HOxe6TXw5BoWkbewSf034SEwy+5TdyBG/5wyb
	 aiHskEVyRw8hdFVPQVJA36waFBOO+Pdtnw7nqsF4ApQ+awqw7SS5X9gtS1JIg1n669WddifoGWFFH
	 2Ns8SC/RlguNFdTxUTwkWkqQOWRB62KZGol3PbKyOtbKFj42Rk0Pt2ZQJQSprEJfIYk04bLIiq9Fu
	 EVmryrC8R3CobhcjpGvwlaQDEiZCVdEeNI+pcQ88m+nW/wSFRqwfdG7LLB6kQypPVbMuyWMS88bu7
	 0YO2qzpWqq6ngHbje/Df8zZ5XNK5/4FzcQcwx
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774602470t9638383
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3l6Ym90KzFkZDUzMzk2ZTcxMjQ1ODZkY2E5?=" <syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com>
Cc: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.6.y] ocfs2: add extra consistency checks for chain allocator dinodes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_69C648E6_156E21F0_129E4403"
Content-Transfer-Encoding: 8Bit
Date: Fri, 27 Mar 2026 17:07:50 +0800
X-Priority: 3
Message-ID: <tencent_2AE721E935EA3B467CAF450ADACDAB5A3B0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spamd-Result: default: False [2.94 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230607-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,1dd53396e7124586dca9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: E466F3417AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.

------=_NextPart_69C648E6_156E21F0_129E4403
Content-Type: multipart/alternative;
	boundary="----=_NextPart_69C648E6_156E21F0_147D7DCA";

------=_NextPart_69C648E6_156E21F0_147D7DCA
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24gc3RhYmxlIDYuNi55Lg0KDQoNCiNz
eXogdGVzdDogZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9saW51eC5naXQgYzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1
YzEzYg0KDQoNClRoYW5rcywNCkNoYW5namlhbiBMaXU=

------=_NextPart_69C648E6_156E21F0_147D7DCA
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgdGVzdCB0aGlzIHBhdGNoIG9uIHN0YWJs
ZSA2LjYueS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiNzeXogdGVzdDogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQg
YzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1YzEzYjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hhbmdqaWFuIExpdTxicj48L2Rpdj4=

------=_NextPart_69C648E6_156E21F0_147D7DCA--

------=_NextPart_69C648E6_156E21F0_129E4403
Content-Type: application/octet-stream;
	charset="ISO-8859-1";
	name="1dd53396e7124586dca9.patch"
Content-Disposition: attachment; filename="1dd53396e7124586dca9.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IGUxYzcwNTA1ZWU4MTU4YzExMDgzNDBkOWNkNjcxODJhZGU5M2FmNGEKQXV0aG9y
OiBEbWl0cnkgQW50aXBvdiA8ZG1hbnRpcG92QHlhbmRleC5ydT4KRGF0ZTogICBUaHUgT2N0
IDMwIDE4OjMwOjAyIDIwMjUgKzAzMDAKCiAgICBvY2ZzMjogYWRkIGV4dHJhIGNvbnNpc3Rl
bmN5IGNoZWNrcyBmb3IgY2hhaW4gYWxsb2NhdG9yIGRpbm9kZXMKICAgIAogICAgV2hlbiB2
YWxpZGF0aW5nIGNoYWluIGFsbG9jYXRvciBkaW5vZGUgaW4gJ29jZnMyX3ZhbGlkYXRlX2lu
b2RlX2Jsb2NrKCknLAogICAgYWRkIGFuIGV4dHJhIGNoZWNrcyB3aGV0aGVyIGEpIHRoZSBt
YXhpbXVtIGFtb3VudCBvZiBjaGFpbiByZWNvcmRzIGluCiAgICAnc3RydWN0IG9jZnMyX2No
YWluX2xpc3QnIG1hdGNoZXMgdGhlIHZhbHVlIGNhbGN1bGF0ZWQgYmFzZWQgb24gdGhlCiAg
ICBmaWxlc3lzdGVtIGJsb2NrIHNpemUsIGFuZCBiKSB0aGUgbmV4dCBmcmVlIHNsb3QgaW5k
ZXggaXMgd2l0aGluIHRoZSB2YWxpZAogICAgcmFuZ2UuCiAgICAKICAgIExpbms6IGh0dHBz
Oi8vbGttbC5rZXJuZWwub3JnL3IvMjAyNTEwMzAxNTMwMDMuMTkzNDU4NS0xLWRtYW50aXBv
dkB5YW5kZXgucnUKICAgIFNpZ25lZC1vZmYtYnk6IERtaXRyeSBBbnRpcG92IDxkbWFudGlw
b3ZAeWFuZGV4LnJ1PgogICAgUmVwb3J0ZWQtYnk6IHN5emJvdCs3NzAyNjU2NDUzMGRiYzI5
Yjg1NEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCiAgICBDbG9zZXM6IGh0dHBzOi8vc3l6
a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD03NzAyNjU2NDUzMGRiYzI5Yjg1NAogICAg
UmVwb3J0ZWQtYnk6IHN5emJvdCs1MDU0NDczYTMxZjc4ZjczNTQxNkBzeXprYWxsZXIuYXBw
c3BvdG1haWwuY29tCiAgICBDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29t
L2J1Zz9leHRpZD01MDU0NDczYTMxZjc4ZjczNTQxNgogICAgU3VnZ2VzdGVkLWJ5OiBKb3Nl
cGggUWkgPGpvc2VwaC5xaUBsaW51eC5hbGliYWJhLmNvbT4KICAgIFJldmlld2VkLWJ5OiBK
b3NlcGggUWkgPGpvc2VwaC5xaUBsaW51eC5hbGliYWJhLmNvbT4KICAgIENjOiBKdW54aWFv
IEJpIDxqdW54aWFvLmJpQG9yYWNsZS5jb20+CiAgICBDYzogSnVuIFBpYW8gPHBpYW9qdW5A
aHVhd2VpLmNvbT4KICAgIENjOiBEZWVwYW5zaHUgS2FydGlrZXkgPGthcnRpa2V5NDA2QGdt
YWlsLmNvbT4KICAgIENjOiBIZW1pbmcgWmhhbyA8aGVtaW5nLnpoYW9Ac3VzZS5jb20+CiAg
ICBDYzogSm9lbCBCZWNrZXIgPGpsYmVjQGV2aWxwbGFuLm9yZz4KICAgIENjOiBNYXJrIEZh
c2hlaCA8bWFya0BmYXNoZWguY29tPgogICAgU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1vcnRv
biA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tIGEvZnMvb2NmczIvaW5vZGUuYwor
KysgYi9mcy9vY2ZzMi9pbm9kZS5jCkBAIC0xNTEzLDYgKzE1MTMsMjMgQEAgaW50IG9jZnMy
X3ZhbGlkYXRlX2lub2RlX2Jsb2NrKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJCWdvdG8g
YmFpbDsKIAl9CiAKKwlpZiAobGUzMl90b19jcHUoZGktPmlfZmxhZ3MpICYgT0NGUzJfQ0hB
SU5fRkwpIHsKKwkJc3RydWN0IG9jZnMyX2NoYWluX2xpc3QgKmNsID0gJmRpLT5pZDIuaV9j
aGFpbjsKKworCQlpZiAobGUxNl90b19jcHUoY2wtPmNsX2NvdW50KSAhPSBvY2ZzMl9jaGFp
bl9yZWNzX3Blcl9pbm9kZShzYikpIHsKKwkJCXJjID0gb2NmczJfZXJyb3Ioc2IsICJJbnZh
bGlkIGRpbm9kZSAlbGx1OiBjaGFpbiBsaXN0IGNvdW50ICV1XG4iLAorCQkJCQkgKHVuc2ln
bmVkIGxvbmcgbG9uZyliaC0+Yl9ibG9ja25yLAorCQkJCQkgbGUxNl90b19jcHUoY2wtPmNs
X2NvdW50KSk7CisJCQlnb3RvIGJhaWw7CisJCX0KKwkJaWYgKGxlMTZfdG9fY3B1KGNsLT5j
bF9uZXh0X2ZyZWVfcmVjKSA+IGxlMTZfdG9fY3B1KGNsLT5jbF9jb3VudCkpIHsKKwkJCXJj
ID0gb2NmczJfZXJyb3Ioc2IsICJJbnZhbGlkIGRpbm9kZSAlbGx1OiBjaGFpbiBsaXN0IGlu
ZGV4ICV1XG4iLAorCQkJCQkgKHVuc2lnbmVkIGxvbmcgbG9uZyliaC0+Yl9ibG9ja25yLAor
CQkJCQkgbGUxNl90b19jcHUoY2wtPmNsX25leHRfZnJlZV9yZWMpKTsKKwkJCWdvdG8gYmFp
bDsKKwkJfQorCX0KKwogCXJjID0gMDsKIAogYmFpbDoK

------=_NextPart_69C648E6_156E21F0_129E4403--


