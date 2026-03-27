Return-Path: <stable+bounces-230633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /X8GABxkxmnnJgUAu9opvQ
	(envelope-from <stable+bounces-230633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:03:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5128E3430C9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E24D73061162
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0D23DA5B3;
	Fri, 27 Mar 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tDacTYcQ"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707A34EEF4
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774609018; cv=none; b=DIGlmlb5vP1UfFTkeeHb4Md6XXPyi8ZsoEDNd1wZQG+aOwy2D8m0Egv5xHYLcFn88vnhQZFSUQA7T1KRHf2HZJewc7VKUSxNU+ucQfu6A8uiJjPfVibxkv6bubgDliPnoF2P9SCNtBC/KRPxYFjG+diPWs8X6/LN2zXMnN851aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774609018; c=relaxed/simple;
	bh=1JVpeOn8VW5Dj4RzUQK9heH/MH3uN2qHM/5Cg2nQm+c=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=ZIPkLU15jR2nn7Vx/rC56vm061DMgVscizL80wZLXxOEFOzpKqexcyGwTnodpt44e+3aCQA0pJCaYiQoa8w2EAssl0xawoq3FnFSrkw/FFwp0gGvWD97dYIpudkzkbcpgB+LD76BMTyNc/Wc6U1MbQf6v4uHYbzHYWKV0hiBJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tDacTYcQ; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774609012; bh=aAOFCAc+oNWBAmCP2Hi3pfb9/HgSMXYxknPoqPEr+SI=;
	h=From:To:Cc:Subject:Date;
	b=tDacTYcQgh6msFh+fqOXiUrdYtXnL1cLP7xbASYtSg70lMBT6cfez+L8qlQcEASve
	 EHwGaYHe5hdaa2rGWFtvQLN0VVmdRaZnbQe/tNPtmg4itxlh/80HHAxMqJhkHfGMer
	 VMtrypVIS4HdRSu1iAW0ausSMaSV7O6gr7LmgcBQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: OImhmUSEbAWc3yeStTU98prRwN2l2W+iL93sc0er1d1DDVrEiRtQvv1IAoQgPg
	 kPmQKGMCvaPAvWMM7DyZRXEtCuvqZewaH1CDyZlt7nr+mxSsO/7UxU7i4/kwwtol7vcNtQXXQBjrr
	 PPaBO1Nfr8ZbdGTaz1cAiAjbyU5MAhIzE+RgdGHfQGLgs7O8kpJT9eRZYO+BE91O7Sa0UFT+y0zE0
	 gPAVwBUhuG+epyashN18+4rF9bGFQKB9shEFp4QFIfT+P48ma8WT0ip57MxgkohRYG1DP7qsDnv7c
	 8L54lQf3KlDeokrW0x91E6z4YzFgCQWmHb1Bh2sPs1uKx82Av7KTdVtUBaXhVAoYsmFmDufYH+6T5
	 gfuNxjG/SbIX2XzrG5YKs0shicCYI1us9iHaZiJDMFH8/ADGIfrokoQKO/n/d8ahK/om1ADyrV6oc
	 kuwiSds9gAs6R/x6aiU+A48zQ1ENq+TTIaHIgfgLrBSwnvFOYplvnGS6PqPay9uG5hK+go2VwEFKT
	 eHyU9P8rJjUkrtRT1z/12TMm0oGJtPXd9FIFm1t9PGaZjQWpWqXx439zuUTw0Rky1ReAzCpoSGcDo
	 SvEMNb1fSXHhLTiLtITVyUQJYraFDKOLTmFppxN5fPC0FC2ddnPgEgmEH2DYgE87NmNtFnqCPi94G
	 4yTJS0uDCgsD/wibm2h/qDZRDGOM7LddzvyBNnQADjpfBS1vZZvls+tzki2WE3t4QKKGFLo/MEb48
	 irxMvtMFErP3zUuCrrVWvEyte4dnpIaX4tNBrNnlvwDg7v/KmD7Mr4bc6aYkS5FXIK78nDiwNQB33
	 x21ac1Fx1PfQMwuQc1ZXLZIcZGNIxJosxRH/oLS8Zs0QoBu8BWa4QO4dnDR+Sk/lzYLFrEVY41Xwh
	 uy5aXU9YF7NHheZTALjuJUoxYptOh0PQDXIIM+umvDgUoACpxMy/GCVf/6LWXd19GeTIktt+Hi3ex
	 GqQwnHiCt7GWg/D5xoJMieV5Zng2m/ohT2qvDJZnwED7fwyTexpRe/uQ+hjMva8HV+ja/FjRFTMD8
	 3kvt/hBHonmUQLCOhRGGz3bkLWSpNtarkAekJ8eE2m+b7pQY=
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774609010t2772652
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3l6Ym90KzQ2OWI1ODQwNzZiODhjYmIwMzdk?=" <syzbot+469b584076b88cbb037d@syzkaller.appspotmail.com>
Cc: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.6.y] gfs2: Validate i_depth for exhash directories
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_69C66272_1650B430_469E61D9"
Content-Transfer-Encoding: 8Bit
Date: Fri, 27 Mar 2026 18:56:50 +0800
X-Priority: 3
Message-ID: <tencent_1D818E8FDF0991A176CDAAC6CE0B481D8D08@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-230633-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,469b584076b88cbb037d];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5128E3430C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.

------=_NextPart_69C66272_1650B430_469E61D9
Content-Type: multipart/alternative;
	boundary="----=_NextPart_69C66272_1650B430_6D661A34";

------=_NextPart_69C66272_1650B430_6D661A34
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24gc3RhYmxlIDYuNi55Lg0KDQoNCiNz
eXogdGVzdDogZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9saW51eC5naXQgYzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1
YzEzYg0KDQoNClRoYW5rcywNCkNoYW5namlhbiBMaXU=

------=_NextPart_69C66272_1650B430_6D661A34
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgdGVzdCB0aGlzIHBhdGNoIG9uIHN0YWJs
ZSA2LjYueS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiNzeXogdGVzdDogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQg
YzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1YzEzYjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hhbmdqaWFuIExpdTxicj48L2Rpdj4=

------=_NextPart_69C66272_1650B430_6D661A34--

------=_NextPart_69C66272_1650B430_469E61D9
Content-Type: application/octet-stream;
	charset="ISO-8859-1";
	name="469b584076b88cbb037d.patch"
Content-Disposition: attachment; filename="469b584076b88cbb037d.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IDU1N2MwMjRjYTcyNTBiYjY1YWU2MGYxNmMwMjA3NDEwNmMyZjE5N2IKQXV0aG9y
OiBBbmRyZXcgUHJpY2UgPGFucHJpY2VAcmVkaGF0LmNvbT4KRGF0ZTogICBXZWQgSnVsIDE2
IDE0OjEyOjA3IDIwMjUgKzAxMDAKCiAgICBnZnMyOiBWYWxpZGF0ZSBpX2RlcHRoIGZvciBl
eGhhc2ggZGlyZWN0b3JpZXMKICAgIAogICAgQSBmdXp6ZXIgdGVzdCBpbnRyb2R1Y2VkIGNv
cnJ1cHRpb24gdGhhdCBlbmRzIHVwIHdpdGggYSBkZXB0aCBvZiAwIGluCiAgICBkaXJfZV9y
ZWFkKCksIGNhdXNpbmcgYW4gdW5kZWZpbmVkIHNoaWZ0IGJ5IDMyIGF0OgogICAgCiAgICAg
IGluZGV4ID0gaGFzaCA+PiAoMzIgLSBkaXAtPmlfZGVwdGgpOwogICAgCiAgICBBcyBjYWxj
dWxhdGVkIGluIGFuIG9wZW4tY29kZWQgd2F5IGluIGRpcl9tYWtlX2V4aGFzaCgpLCB0aGUg
bWluaW11bQogICAgZGVwdGggZm9yIGFuIGV4aGFzaCBkaXJlY3RvcnkgaXMgaWxvZzIoc2Rw
LT5zZF9oYXNoX3B0cnMpIGFuZCAwIGlzCiAgICBpbnZhbGlkIGFzIHNkcC0+c2RfaGFzaF9w
dHJzIGlzIGZpeGVkIGFzIHNkcC0+YnNpemUgLyAxNiBhdCBtb3VudCB0aW1lLgogICAgCiAg
ICBTbyB3ZSBjYW4gYXZvaWQgdGhlIHVuZGVmaW5lZCBiZWhhdmlvdXIgYnkgY2hlY2tpbmcg
Zm9yIGRlcHRoIHZhbHVlcwogICAgbG93ZXIgdGhhbiB0aGUgbWluaW11bSBpbiBnZnMyX2Rp
bm9kZV9pbigpLiBWYWx1ZXMgZ3JlYXRlciB0aGFuIHRoZQogICAgbWF4aW11bSBhcmUgYWxy
ZWFkeSBiZWluZyBjaGVja2VkIGZvciB0aGVyZS4KICAgIAogICAgQWxzbyBzd2l0Y2ggdGhl
IGNhbGN1bGF0aW9uIGluIGRpcl9tYWtlX2V4aGFzaCgpIHRvIHVzZSBpbG9nMigpIHRvCiAg
ICBjbGFyaWZ5IGhvdyB0aGUgZGVwdGggaXMgY2FsY3VsYXRlZC4KICAgIAogICAgVGVzdGVk
IHdpdGggdGhlIHN5emthbGxlciByZXByby5jIGFuZCB4ZnN0ZXN0cyAnLWcgcXVpY2snLgog
ICAgCiAgICBSZXBvcnRlZC1ieTogc3l6Ym90KzQ3MDg1NzliYjIzMGEwNTgyYTU3QHN5emth
bGxlci5hcHBzcG90bWFpbC5jb20KICAgIFNpZ25lZC1vZmYtYnk6IEFuZHJldyBQcmljZSA8
YW5wcmljZUByZWRoYXQuY29tPgogICAgU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBHcnVlbmJh
Y2hlciA8YWdydWVuYmFAcmVkaGF0LmNvbT4KLS0tIGEvZnMvZ2ZzMi9kaXIuYworKysgYi9m
cy9nZnMyL2Rpci5jCkBAIC02MCw2ICs2MCw3IEBACiAjaW5jbHVkZSA8bGludXgvY3JjMzIu
aD4KICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+CiAjaW5jbHVkZSA8bGludXgvYmlvLmg+
CisjaW5jbHVkZSA8bGludXgvbG9nMi5oPgogCiAjaW5jbHVkZSAiZ2ZzMi5oIgogI2luY2x1
ZGUgImluY29yZS5oIgotLS0gYS9mcy9nZnMyL2Rpci5jCisrKyBiL2ZzL2dmczIvZGlyLmMK
QEAgLTkxMiw3ICs5MTMsNiBAQCBzdGF0aWMgaW50IGRpcl9tYWtlX2V4aGFzaChzdHJ1Y3Qg
aW5vZGUgKmlub2RlKQogCXN0cnVjdCBxc3RyIGFyZ3M7CiAJc3RydWN0IGJ1ZmZlcl9oZWFk
ICpiaCwgKmRpYmg7CiAJc3RydWN0IGdmczJfbGVhZiAqbGVhZjsKLQlpbnQgeTsKIAl1MzIg
eDsKIAlfX2JlNjQgKmxwOwogCXU2NCBibjsKLS0tIGEvZnMvZ2ZzMi9kaXIuYworKysgYi9m
cy9nZnMyL2Rpci5jCkBAIC05NzksOSArOTc5LDcgQEAgc3RhdGljIGludCBkaXJfbWFrZV9l
eGhhc2goc3RydWN0IGlub2RlICppbm9kZSkKIAlpX3NpemVfd3JpdGUoaW5vZGUsIHNkcC0+
c2Rfc2Iuc2JfYnNpemUgLyAyKTsKIAlnZnMyX2FkZF9pbm9kZV9ibG9ja3MoJmRpcC0+aV9p
bm9kZSwgMSk7CiAJZGlwLT5pX2Rpc2tmbGFncyB8PSBHRlMyX0RJRl9FWEhBU0g7Ci0KLQlm
b3IgKHggPSBzZHAtPnNkX2hhc2hfcHRycywgeSA9IC0xOyB4OyB4ID4+PSAxLCB5KyspIDsK
LQlkaXAtPmlfZGVwdGggPSB5OworCWRpcC0+aV9kZXB0aCA9IGlsb2cyKHNkcC0+c2RfaGFz
aF9wdHJzKTsKIAogCWdmczJfZGlub2RlX291dChkaXAsIGRpYmgtPmJfZGF0YSk7CiAKLS0t
IGEvZnMvZ2ZzMi9nbG9wcy5jCisrKyBiL2ZzL2dmczIvZ2xvcHMuYwpAQCAtMTEsNiArMTEs
NyBAQAogI2luY2x1ZGUgPGxpbnV4L2Jpby5oPgogI2luY2x1ZGUgPGxpbnV4L3Bvc2l4X2Fj
bC5oPgogI2luY2x1ZGUgPGxpbnV4L3NlY3VyaXR5Lmg+CisjaW5jbHVkZSA8bGludXgvbG9n
Mi5oPgogCiAjaW5jbHVkZSAiZ2ZzMi5oIgogI2luY2x1ZGUgImluY29yZS5oIgotLS0gYS9m
cy9nZnMyL2dsb3BzLmMKKysrIGIvZnMvZ2ZzMi9nbG9wcy5jCkBAIC00NjAsOCArNDYwLDEz
IEBACiAJaWYgKHVubGlrZWx5KGRlcHRoID4gR0ZTMl9ESVJfTUFYX0RFUFRIKSkKIAkJZ290
byBjb3JydXB0OwogCWlwLT5pX2RlcHRoID0gKHU4KWRlcHRoOworICAgIGlmICgoaXAtPmlf
ZGlza2ZsYWdzICYgR0ZTMl9ESUZfRVhIQVNIKSAmJgorICAgICAgICBkZXB0aCA8IGlsb2cy
KHNkcC0+c2RfaGFzaF9wdHJzKSkgeworICAgICAgICBnZnMyX2NvbnNpc3RfaW5vZGUoaXAp
OworICAgICAgICByZXR1cm4gLUVJTzsKKyAgICB9CiAJaXAtPmlfZW50cmllcyA9IGJlMzJf
dG9fY3B1KHN0ci0+ZGlfZW50cmllcyk7CiAKIAlpZiAoZ2ZzMl9pc19zdHVmZmVkKGlwKSAm
JiBpbm9kZS0+aV9zaXplID4gZ2ZzMl9tYXhfc3R1ZmZlZF9zaXplKGlwKSkKIAkJZ290byBj
b3JydXB0OwogCg==

------=_NextPart_69C66272_1650B430_469E61D9--


