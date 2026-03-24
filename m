Return-Path: <stable+bounces-230156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBIOJI6KwmkLewQAu9opvQ
	(envelope-from <stable+bounces-230156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:58:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D24308C93
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B299E3008CB2
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E48345CD0;
	Tue, 24 Mar 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xqYKUP20"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D9342CB6
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356531; cv=none; b=SVmuXGZYgAsFhpSSlfW39Rzoy+Fn6RLoKWz1IcqEtTqeZZ2rZf0cOPnAyX6fGcYrvpod2Jk6T4IKv+G3Xx6XkuLifdWm4HPOVOgZFJ4gYNxoehrCbMr1CVLGES1kKiy4qc6NAcs7UNOkiAwUY8yy6phuRgZzSdjIW/ScDCcJ0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356531; c=relaxed/simple;
	bh=Wugp2nEXqQsPM6+3HwVk2fyTTP6TipmuqBCO7dQ3UuE=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=Mfo3xDzs3j4jkL0dnZe7Cta0q4Vwv3kOkWkRXP5ROzaRtv4tqUe6aXQdZ3WGMcGzYHQReJChPG2VC6wzqFaKz1CtZG2AI7F/6aKRGpAmyj6PzZi0VG7ojbfnPVasQChpZO+8VjGFuvb7J9Er9ZJyphND9iL77+h446dz2BklaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xqYKUP20; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774356517; bh=XL8KgKxnWgOqGH+5okcyAVvJC1h2if7kCeBiygtpi8g=;
	h=From:To:CC:Subject:Date;
	b=xqYKUP20X9L/+xkGEuvs9bf12nFUvSOM+u4wPBednAsfLClMFcQxmCuukUy/G6/B/
	 DMUUN21TyiyxIugkmCalmMQiB6FT1UY32yZVo5bzEqipMRUwLF4JKZM3h4qgD1UWYU
	 5GW6NdNnTvjVbwD6ARQT+uoaKb38ELQ6jqirDfG0=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: OfxHHOU34G6pPjEyotWTU7of5vGrVXTiy1qCyfN0HMsIP5IKVfk8xzN5juBfg9
	 OOfZMxspzuA57WCgTIQf1UVUxKO5gqFMxD636EG3T6rku8DecsTGrACwBOu9BAK0zdLINzB8yEanD
	 isf4sKpFg3QgVpwFcO6OHteYJ9qJ7DlLABZx2pxxZqqhRWoWCuDqPLmiREXvR4SQLmp0Xaaugbtyt
	 YCSdMi2JxkwL85bhyI0SqeXtT6l35nJo0NknJx53pTPQPd+NNPYuJXOjtfK1EA3GTRrCrbZy3xxnf
	 aO/+IlwZt+AlxjIjk+nOVLOUbsS2K5LmllelnGxemmAyyWd67+YLT+gMFAu+mp0QpblDdZkq7/Wdc
	 +Ewv/Bd8a/n47DL0jPp0DEZSC1I5oIdsnCdp/dgFKG05OMGBpiCtjYAi4Lr/yysSVVT6nWNdO5rC8
	 SEz1ObSM8ihzMXnBRJo76hzX4pCGm9Y0QQlh39mq50ipXO35MM+PEWGQXYQqW4SUqojNMhtUnz9lU
	 OTS0wgvd2EkceqpqZ049N5iGz2tP/BkJO/b7ovOXs707mwg+b8KeEnh8o5NvPFyff6C+FxWeOIM8h
	 QfqmzLLT/W3s4wEUkHb8fbPn1dWP5wtiv9is2+yNZAPmKyoEQd0RVSfQCTxELw8+AAGB1bXnPAlSV
	 rEayDKgESTbTB9rG1VMO5BhGSUFLigywT62nN7xcUhRLWeZFvPlGard6qBmLEe+/rJvVMaci0rLrd
	 w4ikC2CCkX9iT6XiBycLqym/1G+kybZMh4I//dCqdF3MxlJAQzSXVjDcqh2xefyBSJ3O8cc6fXboj
	 mStoJWvOAtl1N1qEDj/FHqmKm7Xf0CqfxIeF3oKbJ3Cy89b1ObLwiObL4eNw2qA5gRjtrTY4UvHPQ
	 RDsvo0VsINCSCkUQix/N4c9z8Iv04aU2oVxsRGpwhy5b3BFKwkL6LubkHpaCEQ+jcHx20IItLm7Yp
	 tVEp2zgnHly8EanfB3DF+Isju1I/a0yvNBq73qvSKzmr4Sw6sSUbvWqsVEyW7tep5iW7MMBey/vZ/
	 nQIzbDBVbG512S50aeoWdHhGfMONsjWMzg4d1iLERPM7YxBiulgbqpNiekhxRLVbqykJGTiO50V3f
	 ifSyAv+gfqAub/sIy+a0Jus35gtx0VK7C/I=
Received: from SG2PR02MB5841.apcprd02.prod.outlook.com ([2603:1046:c01:910::5])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id C2332CD0; Tue, 24 Mar 2026 20:48:35 +0800
X-QQ-mid: xmsmtpt1774356515t89wdlfsw
Message-ID: <tencent_44CDECE854579C9391141AA91D89BF4D2309@qq.com>
From: "driz2t@qq.com" <driz2t@qq.com>
To: "syzbot+016d861797fd718491a8@syzkaller.appspotmail.com"
	<syzbot+016d861797fd718491a8@syzkaller.appspotmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] erofs: get rid of z_erofs_fill_inode()
Thread-Topic: [PATCH 6.1.y] erofs: get rid of z_erofs_fill_inode()
Thread-Index: AQHcu4VbWbycrBzpu0+1yK+A0G7MPQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 24 Mar 2026 12:48:34 +0000
X-OQ-MSGID:
	<SG2PR02MB58414D56B9B8999F33FCC28EF248A@SG2PR02MB5841.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: multipart/mixed;
	boundary="_002_SG2PR02MB58414D56B9B8999F33FCC28EF248ASG2PR02MB5841apcp_"
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-230156-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[stable,016d861797fd718491a8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 92D24308C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--_002_SG2PR02MB58414D56B9B8999F33FCC28EF248ASG2PR02MB5841apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=0A=
=0A=
Please test this patch on stable 6.1.y.=0A=
=0A=
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git f=
2ddafa93a259310ca47507153b7811ec54ab7fd=0A=
=0A=
=0A=
Thanks,=0A=
Changjian Liu=0A=

--_002_SG2PR02MB58414D56B9B8999F33FCC28EF248ASG2PR02MB5841apcp_
Content-Type: application/octet-stream; name="016d861797fd718491a8.patch"
Content-Description: 016d861797fd718491a8.patch
Content-Disposition: attachment; filename="016d861797fd718491a8.patch";
	size=3385; creation-date="Tue, 24 Mar 2026 12:46:52 GMT";
	modification-date="Tue, 24 Mar 2026 12:46:52 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMjdlM2NlM2NlMzQyNmFkMDIwNTJiZDI5N2I3ZWI1Y2JmMzI4ZTg4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGFuZ2ppYW4gTGl1IDxkcml6MnRAcXEuY29tPgpEYXRlOiBU
dWUsIDI0IE1hciAyMDI2IDE5OjUyOjM2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gZXJvZnM6IGdl
dCByaWQgb2Ygel9lcm9mc19maWxsX2lub2RlKCkKClRoaXMgaXMgYSBiYWNrcG9ydCBvZiB1cHN0
cmVhbSBjb21taXQgNGZkYWRkNWIwZjBjNzIzYzgxMjg0MjQ1NGY4Y2NhMTYxOWYyZTczMS4KClBy
aW9yIHRvIGJpZyBwY2x1c3RlcnMsIG5vbi1jb21wYWN0IGNvbXByZXNzaW9uIGluZGV4ZXMgY291
bGQgaGF2ZQplbXB0eSBoZWFkZXJzLgoKTGV0J3MganVzdCBhdm9pZCB0aGUgbGVnYWN5IHBhdGgg
c2luY2UgaXQgY2FuIGJlIGhhbmRsZWQgcHJvcGVybHkKYXMgYSBzcGVjaWZpYyBjb21wcmVzc2lv
biBoZWFkZXIgd2l0aCB6X2Vyb2ZzX2ZpbGxfaW5vZGVfbGF6eSgpIHRvby4KClRlc3RlZCB3aXRo
IGVyb2ZzLXV0aWxzIGV4aXN0IHZlcnNpb25zLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcK
KGNoZXJyeSBwaWNrZWQgZnJvbSBjb21taXQgNGZkYWRkNWIwZjBjNzIzYzgxMjg0MjQ1NGY4Y2Nh
MTYxOWYyZTczMSkKU2lnbmVkLW9mZi1ieTogQ2hhbmdqaWFuIExpdSA8ZHJpejJ0QHFxLmNvbT4K
LS0tCiBmcy9lcm9mcy9pbm9kZS5jICAgICB8ICAxMiArKysrKysrKy0tLS0KIGZzL2Vyb2ZzL2lu
dGVybmFsLmggIHwgICAyIC0tCiBmcy9lcm9mcy96bWFwLmMgICAgICB8ICAxOCAtLS0tLS0tLS0t
LS0tLS0tLS0KIHNjcmlwdHMvZXh0cmFjdC1jZXJ0IHwgQmluIDAgLT4gMTQ2MDggYnl0ZXMKIDQg
ZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBt
b2RlIDEwMDc1NSBzY3JpcHRzL2V4dHJhY3QtY2VydAoKZGlmZiAtLWdpdCBhL2ZzL2Vyb2ZzL2lu
b2RlLmMgYi9mcy9lcm9mcy9pbm9kZS5jCmluZGV4IDNjYmVmNjMxOGI3Yi4uNDg0NTcyNTA0YjRk
IDEwMDY0NAotLS0gYS9mcy9lcm9mcy9pbm9kZS5jCisrKyBiL2ZzL2Vyb2ZzL2lub2RlLmMKQEAg
LTI4MCwxMSArMjgwLDE1IEBAIHN0YXRpYyBpbnQgZXJvZnNfZmlsbF9pbm9kZShzdHJ1Y3QgaW5v
ZGUgKmlub2RlKQogCX0KIAogCWlmIChlcm9mc19pbm9kZV9pc19kYXRhX2NvbXByZXNzZWQodmkt
PmRhdGFsYXlvdXQpKSB7CisjaWZkZWYgQ09ORklHX0VST0ZTX0ZTX1pJUAogCQlpZiAoIWVyb2Zz
X2lzX2ZzY2FjaGVfbW9kZShpbm9kZS0+aV9zYikgJiYKLQkJICAgIGlub2RlLT5pX3NiLT5zX2Js
b2Nrc2l6ZV9iaXRzID09IFBBR0VfU0hJRlQpCi0JCQllcnIgPSB6X2Vyb2ZzX2ZpbGxfaW5vZGUo
aW5vZGUpOwotCQllbHNlCi0JCQllcnIgPSAtRU9QTk9UU1VQUDsKKwkJICAgIGlub2RlLT5pX3Ni
LT5zX2Jsb2Nrc2l6ZV9iaXRzID09IFBBR0VfU0hJRlQpIHsKKwkJCWlub2RlLT5pX21hcHBpbmct
PmFfb3BzID0gJnpfZXJvZnNfYW9wczsKKwkJCWVyciA9IDA7CisJCQlnb3RvIG91dF91bmxvY2s7
CisJCX0KKyNlbmRpZgorCQllcnIgPSAtRU9QTk9UU1VQUDsKIAkJZ290byBvdXRfdW5sb2NrOwog
CX0KIAlpbm9kZS0+aV9tYXBwaW5nLT5hX29wcyA9ICZlcm9mc19yYXdfYWNjZXNzX2FvcHM7CmRp
ZmYgLS1naXQgYS9mcy9lcm9mcy9pbnRlcm5hbC5oIGIvZnMvZXJvZnMvaW50ZXJuYWwuaAppbmRl
eCAxMjY5NzA5MzI4MDUuLjFhNGQwOGE5MzMzOSAxMDA2NDQKLS0tIGEvZnMvZXJvZnMvaW50ZXJu
YWwuaAorKysgYi9mcy9lcm9mcy9pbnRlcm5hbC5oCkBAIC00MjMsMTIgKzQyMywxMCBAQCBlbnVt
IHsKIGV4dGVybiBjb25zdCBzdHJ1Y3QgaW9tYXBfb3BzIHpfZXJvZnNfaW9tYXBfcmVwb3J0X29w
czsKIAogI2lmZGVmIENPTkZJR19FUk9GU19GU19aSVAKLWludCB6X2Vyb2ZzX2ZpbGxfaW5vZGUo
c3RydWN0IGlub2RlICppbm9kZSk7CiBpbnQgel9lcm9mc19tYXBfYmxvY2tzX2l0ZXIoc3RydWN0
IGlub2RlICppbm9kZSwKIAkJCSAgICBzdHJ1Y3QgZXJvZnNfbWFwX2Jsb2NrcyAqbWFwLAogCQkJ
ICAgIGludCBmbGFncyk7CiAjZWxzZQotc3RhdGljIGlubGluZSBpbnQgel9lcm9mc19maWxsX2lu
b2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUpIHsgcmV0dXJuIC1FT1BOT1RTVVBQOyB9CiBzdGF0aWMg
aW5saW5lIGludCB6X2Vyb2ZzX21hcF9ibG9ja3NfaXRlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLAog
CQkJCQkgIHN0cnVjdCBlcm9mc19tYXBfYmxvY2tzICptYXAsCiAJCQkJCSAgaW50IGZsYWdzKQpk
aWZmIC0tZ2l0IGEvZnMvZXJvZnMvem1hcC5jIGIvZnMvZXJvZnMvem1hcC5jCmluZGV4IGQyZDdm
ZTgyNjA5MS4uZmY4NDUzM2RhMGM0IDEwMDY0NAotLS0gYS9mcy9lcm9mcy96bWFwLmMKKysrIGIv
ZnMvZXJvZnMvem1hcC5jCkBAIC03LDI0ICs3LDYgQEAKICNpbmNsdWRlIDxhc20vdW5hbGlnbmVk
Lmg+CiAjaW5jbHVkZSA8dHJhY2UvZXZlbnRzL2Vyb2ZzLmg+CiAKLWludCB6X2Vyb2ZzX2ZpbGxf
aW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkKLXsKLQlzdHJ1Y3QgZXJvZnNfaW5vZGUgKmNvbnN0
IHZpID0gRVJPRlNfSShpbm9kZSk7Ci0Jc3RydWN0IGVyb2ZzX3NiX2luZm8gKnNiaSA9IEVST0ZT
X1NCKGlub2RlLT5pX3NiKTsKLQotCWlmICghZXJvZnNfc2JfaGFzX2JpZ19wY2x1c3RlcihzYmkp
ICYmCi0JICAgICFlcm9mc19zYl9oYXNfenRhaWxwYWNraW5nKHNiaSkgJiYgIWVyb2ZzX3NiX2hh
c19mcmFnbWVudHMoc2JpKSAmJgotCSAgICB2aS0+ZGF0YWxheW91dCA9PSBFUk9GU19JTk9ERV9D
T01QUkVTU0VEX0ZVTEwpIHsKLQkJdmktPnpfYWR2aXNlID0gMDsKLQkJdmktPnpfYWxnb3JpdGht
dHlwZVswXSA9IDA7Ci0JCXZpLT56X2FsZ29yaXRobXR5cGVbMV0gPSAwOwotCQl2aS0+el9sb2dp
Y2FsX2NsdXN0ZXJiaXRzID0gaW5vZGUtPmlfc2ItPnNfYmxvY2tzaXplX2JpdHM7Ci0JCXNldF9i
aXQoRVJPRlNfSV9aX0lOSVRFRF9CSVQsICZ2aS0+ZmxhZ3MpOwotCX0KLQlpbm9kZS0+aV9tYXBw
aW5nLT5hX29wcyA9ICZ6X2Vyb2ZzX2FvcHM7Ci0JcmV0dXJuIDA7Ci19Ci0KIHN0cnVjdCB6X2Vy
b2ZzX21hcHJlY29yZGVyIHsKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlOwogCXN0cnVjdCBlcm9mc19t
YXBfYmxvY2tzICptYXA7Ci0tIAoyLjQzLjAKCg==

--_002_SG2PR02MB58414D56B9B8999F33FCC28EF248ASG2PR02MB5841apcp_--


