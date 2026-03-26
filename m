Return-Path: <stable+bounces-230490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJnfD7NSxWmD9QQAu9opvQ
	(envelope-from <stable+bounces-230490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:37:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D76F337AE9
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9998030574BC
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19876408252;
	Thu, 26 Mar 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Xf1b0/RM"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B3408236
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539078; cv=none; b=u3RUM8Yf8nlQrCfw7fc+MCnJja3CeGlW9Igz5+VPNPFY8FrJnYDRQ7QNEfkMr3QPZblZTk80GciMHexLD1C/4CLWgM+o8iJcPVajR9CwFKcpPlnGnXHojzWZwjIaLo7ckC2/HKocihz60SJSIXOtddEwO5w5huxWhrOkouDrg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539078; c=relaxed/simple;
	bh=Cbrm2+2HKmXgKkb6IWpl1kPJu9ayaFx8P6bqCnjF/CY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=TnF0+cwafEvQw/ybMbPnV/+hxAJn88eYCTDL38Wm8NIyoCEe6tzs8FK6nnOTANQdZLeMQrFhKQVCOLawYFbjEDP2ui1v0i3DlYXlglYVOq/mQBqNXnmuIG4c4yaxs2AWsetD3D5Xzsb0H1MbpvpesANfACCejO7AfLcdOx/Jd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Xf1b0/RM; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774539068; bh=jkgJoTkr4Iihvu5LzGbL8u4YNtLB8I+I9acaMhFw0yU=;
	h=From:To:Cc:Subject:Date;
	b=Xf1b0/RM4erQVMjMaTPEwLhtq1BTMZBFtEWMOr0REGnJEAn/xMBmbQGlX+2XeR62D
	 I9hdQ5gGEZkSZm+26AqXKzj7MCzOWIffIXc9Y0Er5CbW81IWcvDsKY/8JV4pTfaz1R
	 tRwRquS1LdUsyGu+xwzyV6kWtj4kwR9XHKhu9pdE=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-XMAILINFO: OOCGp0MdRD5jOAZBugnpjLZdWs8pnL653wDh0OmSL/KtlqTV3Voo+sjFunDcKx
	 FGxs54xGnZJNF2JVBWs7liHpPZ1q44EpqKAudSf6bQqkYdxAhPVGTkx9OKK1DxHUWhonKdLdDeqJo
	 ojvEzC6qOXVZ3Obc6qAwtVkx+93pfoccRTenVami8myodrA54THdzLQjN9AAPKHJFyA3B7Ylx5cnq
	 +7mHj6c1n2LX1kxMWS719bUYvxWnRJH8oy2lCG/Fes/CnLhLIfASWE/gKYzXv6cf4ZD9g9O9ZmqW1
	 IJY3xpxUmFH4WK39zIS6iAnEz2/kqJE5xdJhGDvc83Eipv1wiDBQFCQYthY4wqdXuiYf6c2xGcZz7
	 TzW4LorKK0uJ8aQHzuqpZVJwyhFYJa381P/Eh04s75H7LV221A2zteaApG3Ev95htUtxLsObVHF4d
	 8bXEbQTdhntAhPYtOS0+evg9oDTEyuc1ez5KZx70E7yuahpsyLl8pP95bnXq097MMCOxZckBAI79D
	 34aAOoV2wFllWUXBKEMvC2hj1l9tClkI66jNr45FbpYfGFEFNLHrkk8njwClckh/PZox7tv2P4GtS
	 R8oinpbq4YnjzcJSG+4jV0Zs7jXYtnpjUN8BSrMfb6jKiYyq1rEj+swe32ltHa3uzYerZReUS9XDX
	 BrVPU9jSxms8pqq2ptdk8VNM2Z4pAyCU5D7X2dkn8w65WGFsr5Q+VyDxxthqMwvqbW5boC54b43WQ
	 9mp3sLkmBCwzYvJryAYFJs17nFoobW2pddzckSuD6Y7xAL/93lANjIE/BhNt0utTX7ej0FhxqsZmG
	 mv05U2reTPfu0UfaHl5ktZZ211FRg4rmtiCtoABjfSvXJk12wA94gxliTppy5wmKVaSlPQdAvEHnt
	 cOw0juINfxnz/gy1DDfY+cZZk7VZCLNQJZhNBFrFU8jlXSsdqHBk9GZHqtkU3Rv/suzJCjk6LOAqE
	 4IcsN4q+2I8sLmlAQrpa/qMWGqVPFID6luwWbWCoSUi1YtJO4YvjAgGg+HVUHbhtWbdICP+6Ev8xY
	 cQ/WXeeLq8HHLoLos4uExLtNPYKHaCxd2jTaeaq+1zelxMv9si+YmXajeHCnevDs0rU98xO1OvCwP
	 9C4=
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774539067t487318
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3l6Ym90KzdjNjY5ZTc0OTFmZGJhY2Q2NGIy?=" <syzbot+7c669e7491fdbacd64b2@syzkaller.appspotmail.com>
Cc: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] unable to handle kernel paging request in hfs_find_init
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_69C5513A_126C5CB0_184A88C5"
Content-Transfer-Encoding: 8Bit
Date: Thu, 26 Mar 2026 23:31:06 +0800
X-Priority: 3
Message-ID: <tencent_9C8D328EA8DF5C919C7662AA3CCE17486908@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-230490-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,7c669e7491fdbacd64b2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 3D76F337AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.

------=_NextPart_69C5513A_126C5CB0_184A88C5
Content-Type: multipart/alternative;
	boundary="----=_NextPart_69C5513A_126C5CB0_0EA0B322";

------=_NextPart_69C5513A_126C5CB0_0EA0B322
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24gc3RhYmxlIDYuMS55Lg0KDQoNCiNz
eXogdGVzdDogZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9saW51eC5naXQgZjJkZGFmYTkzYTI1OTMxMGNhNDc1MDcxNTNiNzgxMWVjNTRh
YjdmZA0KDQoNClRoYW5rcywNCkNoYW5namlhbiBMaXU=

------=_NextPart_69C5513A_126C5CB0_0EA0B322
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgdGVzdCB0aGlzIHBhdGNoIG9uIHN0YWJs
ZSA2LjEueS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiNzeXogdGVzdDogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQg
ZjJkZGFmYTkzYTI1OTMxMGNhNDc1MDcxNTNiNzgxMWVjNTRhYjdmZDwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hhbmdqaWFuIExpdTxicj48L2Rpdj4=

------=_NextPart_69C5513A_126C5CB0_0EA0B322--

------=_NextPart_69C5513A_126C5CB0_184A88C5
Content-Type: application/octet-stream;
	charset="ISO-8859-1";
	name="7c669e7491fdbacd64b2.patch"
Content-Disposition: attachment; filename="7c669e7491fdbacd64b2.patch"
Content-Transfer-Encoding: base64

LS0tIGEvZnMvaGZzL2JmaW5kLmMKKysrIGIvZnMvaGZzL2JmaW5kLmMKQEAgLTE2LDYgKzE2
LDkgQEAgaW50IGhmc19maW5kX2luaXQoc3RydWN0IGhmc19idHJlZSAqdHJlZSwgc3RydWN0
IGhmc19maW5kX2RhdGEgKmZkKQogewogCXZvaWQgKnB0cjsKIAoraWYgKCF0cmVlIHx8ICFm
ZCkKKwlyZXR1cm4gLUVJTlZBTDsKKwogCWZkLT50cmVlID0gdHJlZTsKIAlmZC0+Ym5vZGUg
PSBOVUxMOwogCXB0ciA9IGt6YWxsb2ModHJlZS0+bWF4X2tleV9sZW4gKiAyICsgNCwgR0ZQ
X0tFUk5FTCk7Ci0tLSBhL2ZzL2hmcy9idHJlZS5jCisrKyBiL2ZzL2hmcy9idHJlZS5jCkBA
IC0yMSw4ICsyMSwxMCBAQCBzdHJ1Y3QgaGZzX2J0cmVlICpoZnNfYnRyZWVfb3BlbihzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1MzIgaWQsIGJ0cmVlX2tleWNtcCBrZQogCXN0cnVjdCBo
ZnNfYnRyZWUgKnRyZWU7CiAJc3RydWN0IGhmc19idHJlZV9oZWFkZXJfcmVjICpoZWFkOwog
CXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nOwotCXN0cnVjdCBwYWdlICpwYWdlOwor
c3RydWN0IHBhZ2UgKnBhZ2U7CitzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOwogCXVuc2lnbmVk
IGludCBzaXplOwordTE2IGRibG9jazsKIAogCXRyZWUgPSBremFsbG9jKHNpemVvZigqdHJl
ZSksIEdGUF9LRVJORUwpOwogCWlmICghdHJlZSkKQEAgLTc1LDEyICs3NywyMiBAQCBzdHJ1
Y3QgaGZzX2J0cmVlICpoZnNfYnRyZWVfb3BlbihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1
MzIgaWQsIGJ0cmVlX2tleWNtcCBrZQogCXVubG9ja19uZXdfaW5vZGUodHJlZS0+aW5vZGUp
OwogCiAJbWFwcGluZyA9IHRyZWUtPmlub2RlLT5pX21hcHBpbmc7Ci0JcGFnZSA9IHJlYWRf
bWFwcGluZ19wYWdlKG1hcHBpbmcsIDAsIE5VTEwpOwotCWlmIChJU19FUlIocGFnZSkpCitw
YWdlID0gcmVhZF9tYXBwaW5nX3BhZ2UobWFwcGluZywgMCwgTlVMTCk7CitpZiAoSVNfRVJS
KHBhZ2UpKQogCQlnb3RvIGZyZWVfaW5vZGU7CiAKK2RibG9jayA9IGhmc19leHRfZmluZF9i
bG9jayhIRlNfSSh0cmVlLT5pbm9kZSktPmZpcnN0X2V4dGVudHMsIDApOworYmggPSBzYl9i
cmVhZChzYiwgSEZTX1NCKHNiKS0+ZnNfc3RhcnQgKyBkYmxvY2spOworaWYgKCFiaCkgewor
cHJfZXJyKCJ1bmFibGUgdG8gcmVhZCB0cmVlIGhlYWRlclxuIik7Citnb3RvIHB1dF9wYWdl
OworfQorCittZW1jcHkoa21hcF9sb2NhbF9wYWdlKHBhZ2UpLCBiaC0+Yl9kYXRhLCBzYi0+
c19ibG9ja3NpemUpOworYnJlbHNlKGJoKTsKKwogCS8qIExvYWQgdGhlIGhlYWRlciAqLwot
CWhlYWQgPSAoc3RydWN0IGhmc19idHJlZV9oZWFkZXJfcmVjICopKGttYXBfbG9jYWxfcGFn
ZShwYWdlKSArCitoZWFkID0gKHN0cnVjdCBoZnNfYnRyZWVfaGVhZGVyX3JlYyAqKShrbWFw
X2xvY2FsX3BhZ2UocGFnZSkgKwogCQkJCQkgICAgICAgc2l6ZW9mKHN0cnVjdCBoZnNfYm5v
ZGVfZGVzYykpOwogCXRyZWUtPnJvb3QgPSBiZTMyX3RvX2NwdShoZWFkLT5yb290KTsKIAl0
cmVlLT5sZWFmX2NvdW50ID0gYmUzMl90b19jcHUoaGVhZC0+bGVhZl9jb3VudCk7CkBAIC05
NSwyMiArMTA3LDIyIEBAIHN0cnVjdCBoZnNfYnRyZWUgKmhmc19idHJlZV9vcGVuKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHUzMiBpZCwgYnRyZWVfa2V5Y21wIGtlCiAKIAlzaXplID0g
dHJlZS0+bm9kZV9zaXplOwogCWlmICghaXNfcG93ZXJfb2ZfMihzaXplKSkKLQkJZ290byBm
YWlsX3BhZ2U7Citnb3RvIGZhaWxfcGFnZTsKIAlpZiAoIXRyZWUtPm5vZGVfY291bnQpCi0J
CWdvdG8gZmFpbF9wYWdlOworZ290byBmYWlsX3BhZ2U7CiAJc3dpdGNoIChpZCkgewogCWNh
c2UgSEZTX0VYVF9DTklEOgogCQlpZiAodHJlZS0+bWF4X2tleV9sZW4gIT0gSEZTX01BWF9F
WFRfS0VZTEVOKSB7CiAJCQlwcl9lcnIoImludmFsaWQgZXh0ZW50IG1heF9rZXlfbGVuICVk
XG4iLAogCQkJICAgICAgIHRyZWUtPm1heF9rZXlfbGVuKTsKLQkJCWdvdG8gZmFpbF9wYWdl
OworZ290byBmYWlsX3BhZ2U7CiAJCX0KIAkJYnJlYWs7CiAJY2FzZSBIRlNfQ0FUX0NOSUQ6
CiAJCWlmICh0cmVlLT5tYXhfa2V5X2xlbiAhPSBIRlNfTUFYX0NBVF9LRVlMRU4pIHsKIAkJ
CXByX2VycigiaW52YWxpZCBjYXRhbG9nIG1heF9rZXlfbGVuICVkXG4iLAogCQkJICAgICAg
IHRyZWUtPm1heF9rZXlfbGVuKTsKLQkJCWdvdG8gZmFpbF9wYWdlOworZ290byBmYWlsX3Bh
Z2U7CiAJCX0KIAkJYnJlYWs7CiAJZGVmYXVsdDoKQEAgLTEyMSwxMiArMTMzLDEzIEBAIHN0
cnVjdCBoZnNfYnRyZWUgKmhmc19idHJlZV9vcGVuKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHUzMiBpZCwgYnRyZWVfa2V5Y21wIGtlCiAJdHJlZS0+cGFnZXNfcGVyX2Jub2RlID0gKHRy
ZWUtPm5vZGVfc2l6ZSArIFBBR0VfU0laRSAtIDEpID4+IFBBR0VfU0hJRlQ7CiAKIAlrdW5t
YXBfbG9jYWwoaGVhZCk7Ci0JcHV0X3BhZ2UocGFnZSk7CitwdXRfcGFnZShwYWdlKTsKIAly
ZXR1cm4gdHJlZTsKIAogZmFpbF9wYWdlOgogCWt1bm1hcF9sb2NhbChoZWFkKTsKLQlwdXRf
cGFnZShwYWdlKTsKK3B1dF9wYWdlKHBhZ2UpOworcHV0X3BhZ2U6CiBmcmVlX2lub2RlOgog
CXRyZWUtPmlub2RlLT5pX21hcHBpbmctPmFfb3BzID0gJmhmc19hb3BzOwogCWlwdXQodHJl
ZS0+aW5vZGUpOwotLS0gYS9mcy9oZnMvZXh0ZW50LmMKKysrIGIvZnMvaGZzL2V4dGVudC5j
CkBAIC03MSw3ICs3MSw3IEBAIGludCBoZnNfZXh0X2tleWNtcChjb25zdCBidHJlZV9rZXkg
KmtleTEsIGNvbnN0IGJ0cmVlX2tleSAqa2V5MikKICAqCiAgKiBGaW5kIGEgYmxvY2sgd2l0
aGluIGFuIGV4dGVudCByZWNvcmQKICAqLwotc3RhdGljIHUxNiBoZnNfZXh0X2ZpbmRfYmxv
Y2soc3RydWN0IGhmc19leHRlbnQgKmV4dCwgdTE2IG9mZikKK3UxNiBoZnNfZXh0X2ZpbmRf
YmxvY2soc3RydWN0IGhmc19leHRlbnQgKmV4dCwgdTE2IG9mZikKIHsKIAlpbnQgaTsKIAl1
MTYgY291bnQ7Ci0tLSBhL2ZzL2hmcy9oZnNfZnMuaAorKysgYi9mcy9oZnMvaGZzX2ZzLmgK
QEAgLTE5MCw2ICsxOTAsNyBAQCBleHRlcm4gY29uc3Qgc3RydWN0IGlub2RlX29wZXJhdGlv
bnMgaGZzX2Rpcl9pbm9kZV9vcGVyYXRpb25zOwogCiAvKiBleHRlbnQuYyAqLwogZXh0ZXJu
IGludCBoZnNfZXh0X2tleWNtcChjb25zdCBidHJlZV9rZXkgKiwgY29uc3QgYnRyZWVfa2V5
ICopOworZXh0ZXJuIHUxNiBoZnNfZXh0X2ZpbmRfYmxvY2soc3RydWN0IGhmc19leHRlbnQg
KmV4dCwgdTE2IG9mZik7CiBleHRlcm4gaW50IGhmc19mcmVlX2Zvcmsoc3RydWN0IHN1cGVy
X2Jsb2NrICosIHN0cnVjdCBoZnNfY2F0X2ZpbGUgKiwgaW50KTsKIGV4dGVybiBpbnQgaGZz
X2V4dF93cml0ZV9leHRlbnQoc3RydWN0IGlub2RlICopOwogZXh0ZXJuIGludCBoZnNfZXh0
ZW5kX2ZpbGUoc3RydWN0IGlub2RlICopOwo=

------=_NextPart_69C5513A_126C5CB0_184A88C5--


