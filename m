Return-Path: <stable+bounces-230489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN+eJntXxWkk9gQAu9opvQ
	(envelope-from <stable+bounces-230489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:57:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D410337FA9
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33F153091D5C
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC403411627;
	Thu, 26 Mar 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rQ5KslQP"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40337F8BA
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538876; cv=none; b=oCUzh6fUE5UJT1IzdaMB0UD86oTCe/rMiYoE+ZDHPuVjflE/h2Pg9+g9Ca4RFmKHd6YXaknse3KtV6JS6wxtvvAzm1R6IUE2GqgtF7rTMtbI9RPQeE3G7RlV4KObVrYCBI+XYqD/tqxBjfJUHNVL8HDReJzr6888iSwYuFkwVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538876; c=relaxed/simple;
	bh=mGgmdF3aJj3DGu7fy8hgugCqV8W3H7PXemwNRcisZuc=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=LVpQe6gTxHNshb6qoktCNvRKOfGy2OznVZBe/OXsk6NJHRTsMeuuIlqDyvFD7dL0IWxprKnac7x/Dx6emrlKGOElQmLKo0wYEt4/JK4BRbQHld802enT9y7v37gW7qRzVtExEVtuHGPP8+GHD/rL8MwfrvMlYFDxyPBHT+W8X8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rQ5KslQP; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774538863; bh=l5ZC23wpmQP6RyS8MXmj5KQa0llDcC+2mrSFuC+X+XU=;
	h=From:To:Cc:Subject:Date;
	b=rQ5KslQPyQBmudkzpQ3N/NXf6LdqeEdcrnN11/Lm2qEE0PUey3ar2KaZnr1oNtH0C
	 dHCjQlknKl79wLkzGxCc8vxq1ea5DgVXlvxN+t4E8lYKue1ljmkRJ1R6W76n/4e1Pq
	 jCoGX25qq3lBSDU57m4qchmOyJ0Q6h7ONpO2h19Y=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-XMAILINFO: MzJb22FmC4KUD66quCoKhZbYd2R+aC3fiN1A9aw8HdRDQF0qKR0G1gF2M8hNuY
	 s+H8OKmAeLDR5SwMUM9w0tQfYyevnqkTdwJldh5VBKG9y0JfDc7x7l2inAaobQa++EfkVi1DZX/0/
	 BXt4DYWUQLklvfjD/lNf867Bbh3FCRNaQEkrEGRZvezHPlh7jTVhakFBdy7TF41EwESzHJU2qpyTF
	 lKP04D706IvMWUr5vqn/zqSDf2QukDfArMdttBeDEJYzQuYeuf0I29zLM7QVshY94bHxzLZfrM+dM
	 3fZ1OdHdoB50WgxXy7RDXk5iZoSAl6ereqIxY/ctj4gyceqDwiC1I/kDLPF7D/kqckNBTL5HFPPip
	 bGLODz2EShxKf7g+YL/+DeGGN1y8DTociFdp0tr5297W/ki8nthJOh5Yj5+C/T8tsukAKo8zj/OUr
	 gCD0I3N81+u6UbsXKkt+yJ2pYrbyqqBFIDBksoQuwBkfCrkpz9e9H6g+puMIx23xUKG2IEI+jd5MC
	 OL8ggA0JfhCSK3vRtn01FE+K9PO+CLIU75XOAPBjxmsTEw20ViN+OUxcne5WTJ2/e7fKHQeXDtzUt
	 loxOFvsjHsRM0dlvLPdYu5Yxn9PhQ8qrZf2dFlK9kzYQ2QB/y7fRWcDhJLIsKWFrdlswVzob1e+Hr
	 7V3rWMvg5ipslJyWQ3+yzJN3qzBT3F/BiaLQScS9hkemBWGFBo7VN7KwITilTXSGDRZuVQr29Iy+A
	 AbUvqSmVcYU0eOpKba8oiFp7rWG0ryAKG8q8m6nABKo3cvHVNSfsQ5J5dVLNC7O29jopUP2DRD8fG
	 fBv7K2fUomkp3RcJgJ9XlotFBcyuaZ3h4kqgQpwLHzZa+EAQB6uSe0uobtgTW/5OZ4ouawgfymyoJ
	 xcWMtqnLVAnr4Ad+VIb3c6+mkxOiXkh5KLiO9+yPK+BukUlhFwQ5TillQTqwvnRvT0SjeTnRkVmcJ
	 o5/OvxX90slseWDMrnCv9JpeKNPn/t3oiPEoYBzXzrXEa4r4T2/MQn5oX+GqMLFqpI3xwtx+RSBw0
	 E3aw/XSHqAAO02ipULsaF6i9gEARbioWbf61slPOrdxFHUhg=
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774538862t7647904
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3l6Ym90KzZkNDFkY2Y2ODliODYxODI0NGQ2?=" <syzbot+6d41dcf689b8618244d6@syzkaller.appspotmail.com>
Cc: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.1.y]  WARNING in ext4_dirty_folio
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_69C5506E_11969AD8_3C0E2C83"
Content-Transfer-Encoding: 8Bit
Date: Thu, 26 Mar 2026 23:27:42 +0800
X-Priority: 3
Message-ID: <tencent_983857212537723BA67CEF4462DAD5A9120A@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-230489-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,6d41dcf689b8618244d6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 5D410337FA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.

------=_NextPart_69C5506E_11969AD8_3C0E2C83
Content-Type: multipart/alternative;
	boundary="----=_NextPart_69C5506E_11969AD8_73DFEB1F";

------=_NextPart_69C5506E_11969AD8_73DFEB1F
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24gc3RhYmxlIDYuMS55Lg0KDQoNCiNz
eXogdGVzdDogZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9saW51eC5naXQgZjJkZGFmYTkzYTI1OTMxMGNhNDc1MDcxNTNiNzgxMWVjNTRh
YjdmZA0KDQoNClRoYW5rcywNCkNoYW5namlhbiBMaXU=

------=_NextPart_69C5506E_11969AD8_73DFEB1F
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgdGVzdCB0aGlzIHBhdGNoIG9uIHN0YWJs
ZSA2LjEueS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiNzeXogdGVzdDogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQg
ZjJkZGFmYTkzYTI1OTMxMGNhNDc1MDcxNTNiNzgxMWVjNTRhYjdmZDwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hhbmdqaWFuIExpdTxicj48L2Rpdj4=

------=_NextPart_69C5506E_11969AD8_73DFEB1F--

------=_NextPart_69C5506E_11969AD8_3C0E2C83
Content-Type: application/octet-stream;
	charset="ISO-8859-1";
	name="6d41dcf689b8618244d6.patch"
Content-Disposition: attachment; filename="6d41dcf689b8618244d6.patch"
Content-Transfer-Encoding: base64

LS0tIGEvbW0vZ3VwLmMKKysrIGIvbW0vZ3VwLmMKQEAgLTEwNjAsMTYgKzEwNjAsNTQgQEAg
c3RhdGljIGludCBmYXVsdGluX3BhZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCiAJ
cmV0dXJuIDA7CiB9CiAKKy8qCisgKiBXcml0aW5nIHRvIGZpbGUtYmFja2VkIG1hcHBpbmdz
IHdoaWNoIHJlcXVpcmUgZm9saW8gZGlydHkgdHJhY2tpbmcgdXNpbmcgR1VQCisgKiBpcyBh
IGZ1bmRhbWVudGFsbHkgYnJva2VuIG9wZXJhdGlvbiwgYXMga2VybmVsIHdyaXRlIGFjY2Vz
cyB0byBHVVAgbWFwcGluZ3MKKyAqIGRvIG5vdCBhZGhlcmUgdG8gdGhlIHNlbWFudGljcyBl
eHBlY3RlZCBieSBhIGZpbGUgc3lzdGVtLgorICoKKyAqIENvbnNpZGVyIHRoZSBmb2xsb3dp
bmcgc2NlbmFyaW86LQorICoKKyAqIDEuIEEgZm9saW8gaXMgd3JpdHRlbiB0byB2aWEgR1VQ
IHdoaWNoIHdyaXRlLWZhdWx0cyB0aGUgbWVtb3J5LCBub3RpZnlpbmcKKyAqICAgIHRoZSBm
aWxlIHN5c3RlbSBhbmQgZGlydHlpbmcgdGhlIGZvbGlvLgorICogMi4gTGF0ZXIsIHdyaXRl
YmFjayBpcyB0cmlnZ2VyZWQsIHJlc3VsdGluZyBpbiB0aGUgZm9saW8gYmVpbmcgY2xlYW5l
ZCBhbmQKKyAqICAgIHRoZSBQVEUgYmVpbmcgbWFya2VkIHJlYWQtb25seS4KKyAqIDMuIFRo
ZSBHVVAgY2FsbGVyIHdyaXRlcyB0byB0aGUgZm9saW8sIGFzIGl0IGlzIG1hcHBlZCByZWFk
L3dyaXRlIHZpYSB0aGUKKyAqICAgIGRpcmVjdCBtYXBwaW5nLgorICogNC4gVGhlIEdVUCBj
YWxsZXIsIG5vdyBkb25lIHdpdGggdGhlIHBhZ2UsIHVucGlucyBpdCBhbmQgc2V0cyBpdCBk
aXJ0eQorICogICAgKHRob3VnaCBpdCBkb2VzIG5vdCBoYXZlIHRvKS4KKyAqCisgKiBUaGlz
IHJlc3VsdHMgaW4gYm90aCBkYXRhIGJlaW5nIHdyaXR0ZW4gdG8gYSBmb2xpbyB3aXRob3V0
IHdyaXRlbm90aWZ5LCBhbmQKKyAqIHRoZSBmb2xpbyBiZWluZyBkaXJ0aWVkIHVuZXhwZWN0
ZWRseSAoaWYgdGhlIGNhbGxlciBkZWNpZGVzIHRvIGRvIHNvKS4KKyAqLworc3RhdGljIGJv
b2wgd3JpdGFibGVfZmlsZV9tYXBwaW5nX2FsbG93ZWQoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsCisgdW5zaWduZWQgbG9uZyBndXBfZmxhZ3MpCit7CisgLyoKKyAgKiBJZiB3ZSBh
cmVuJ3QgcGlubmluZyB0aGVuIG5vIHByb2JsZW1hdGljIHdyaXRlIGNhbiBvY2N1ci4gQSBs
b25nIHRlcm0KKyAgKiBwaW4gaXMgdGhlIG1vc3QgZWdyZWdpb3VzIGNhc2Ugc28gdGhpcyBp
cyB0aGUgY2FzZSB3ZSBkaXNhbGxvdy4KKyAgKi8KKyBpZiAoKGd1cF9mbGFncyAmIChGT0xM
X1BJTiB8IEZPTExfTE9OR1RFUk0pKSAhPQorIChGT0xMX1BJTiB8IEZPTExfTE9OR1RFUk0p
KQorIHJldHVybiB0cnVlOworCisgLyoKKyAgKiBJZiB0aGUgVk1BIGRvZXMgbm90IHBlcm1p
dCB3cml0ZSBhY2Nlc3MgdGhlbiBubyBwcm9ibGVtYXRpYyB3cml0ZQorICAqIGNhbiBvY2N1
ciBlaXRoZXIuCisgICovCisgcmV0dXJuICh2bWEtPnZtX2ZsYWdzICYgVk1fV1JJVEUpICE9
IDA7Cit9CisKIHN0YXRpYyBpbnQgY2hlY2tfdm1hX2ZsYWdzKHN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGd1cF9mbGFncykKIHsKIAl2bV9mbGFnc190IHZt
X2ZsYWdzID0gdm1hLT52bV9mbGFnczsKIAlpbnQgd3JpdGUgPSAoZ3VwX2ZsYWdzICYgRk9M
TF9XUklURSk7CiAJaW50IGZvcmVpZ24gPSAoZ3VwX2ZsYWdzICYgRk9MTF9SRU1PVEUpOwor
IGJvb2wgdm1hX2Fub24gPSB2bWFfaXNfYW5vbnltb3VzKHZtYSk7CiAKIAlpZiAodm1fZmxh
Z3MgJiAoVk1fSU8gfCBWTV9QRk5NQVApKQogCQlyZXR1cm4gLUVGQVVMVDsKIAotCWlmIChn
dXBfZmxhZ3MgJiBGT0xMX0FOT04gJiYgIXZtYV9pc19hbm9ueW1vdXModm1hKSkKKyBpZiAo
KGd1cF9mbGFncyAmIEZPTExfQU5PTikgJiYgIXZtYV9hbm9uKQogCQlyZXR1cm4gLUVGQVVM
VDsKIAogCWlmICgoZ3VwX2ZsYWdzICYgRk9MTF9MT05HVEVSTSkgJiYgdm1hX2lzX2ZzZGF4
KHZtYSkpCkBAIC0xMDc5LDYgKzExMTcsMTAgQEAgc3RhdGljIGludCBjaGVja192bWFfZmxh
Z3Moc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgZ3VwX2ZsYWdz
KQogCQlyZXR1cm4gLUVGQVVMVDsKIAogCWlmICh3cml0ZSkgeworIGlmICghdm1hX2Fub24g
JiYKKyAhd3JpdGFibGVfZmlsZV9tYXBwaW5nX2FsbG93ZWQodm1hLCBndXBfZmxhZ3MpKQor
IHJldHVybiAtRUZBVUxUOworCiAJCWlmICghKHZtX2ZsYWdzICYgVk1fV1JJVEUpKSB7CiAJ
CQlpZiAoIShndXBfZmxhZ3MgJiBGT0xMX0ZPUkNFKSkKIAkJCQlyZXR1cm4gLUVGQVVMVDsK

------=_NextPart_69C5506E_11969AD8_3C0E2C83--


