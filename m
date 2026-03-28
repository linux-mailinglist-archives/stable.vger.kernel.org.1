Return-Path: <stable+bounces-230766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBL4J1BZx2lbVwUAu9opvQ
	(envelope-from <stable+bounces-230766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 05:30:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC834D45C
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 05:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AE4A3036B3B
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 04:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E7321F5E;
	Sat, 28 Mar 2026 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="V8nD7YZM"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F233A711
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774672205; cv=none; b=B9TtbZxs/oWYg28jiKg2BZkstss4PjCYxNvWTjG4vpHDVIy9Ns084uiVzgb7xme8RtOw/oGJW5eLFSaZqmBjt+VLpFxMNUju2PRmsM9CccrjzaP9vBtYK7EA+GkUzMc0DFMYN5wpFscoKwO+1B5w4yLQPOkGDwjfIQkkWwuURpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774672205; c=relaxed/simple;
	bh=iRZ7F0mxaoaLyqHlkygn97v1Tp1p0ijpYMSDkjz/EcM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=D6rKL6HID/95hrGQrqXWU7jFlaiBe4PUvcPNKEkERTY1z0J+fzK2gnBlvoE6jf+r6PHNRx6biaT33akRruLg6dO2VLKhLErUNW32NEVLmGOK+dhhr7VcmSB3TU8YuEBUOapDyxtIWWRfraX7xK9bnmDFr+2/Q7nSfvymLv5+VcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=V8nD7YZM; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774672198; bh=EKbNCkYN5xUruitiephTa3f+ngTvYfQ/pZrVzA0vAxM=;
	h=From:To:Cc:Subject:Date;
	b=V8nD7YZMDxbCPefECGFkL/VK49a5Nu9qyoJNugsLC9hgnGGIobuxVSDDddpcl1p4x
	 z1b6CjrTaVz+n8X8dJj8SeHjUNysPTpoNOkPnUzQad6Oo+85ael4aZwLxU/uJCh8Fl
	 sjKcPVQBZTArx9u1f/FX91btGi6Xh6vuF7ecjyEM=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: NtksVjXir1SbCHaQ/RiIezdRpgrFwyuBUziVwZAre/zP9Ip3wtepFXLV4077bu
	 UKKGhKqqCCn+M6ztX+SXYONM7U7ynlHb4qEzuff/Sq89J/2I4lX9mPr7Y7fHMzk4Lxt8UvQBpOPru
	 0vJ2AKvGdi+rHCPYrXztz7BIIAaNPvM8xcqGmXbr3UkSyTuqmLvE5O1l3g5UiyunTL/2jxX/0vVvg
	 OomM+6OabK3GfT0XmacYqOwRYtYGrDj2yPWlg8tPmRXGuwe9LLNUczLZmwELtiSRDfJGq/RNZKya7
	 t172u6ffVejtC+kmls4ZeVvsh50pRn8cvUo2g4/CpLR49BRxUGhtLfknK9f6LH3XRi9ShZVdPEr7K
	 297ovK2ZbIFG1w0KlPyT4ke4oUGANUN83SbUanrCGeS9aqovykeHzTx1jmdyGON2im+pHLtxoMlvM
	 U0iuid4JK8JSwelDQeZdX49zDYS3HNtwEGknqcA+gkmqEkonJFRs7FdfG1gbf4+NLcpQMQsdbQg2p
	 sWIja1r8Kj2LB72faFOTxiQ804u+9ZtaR0IK6f7aBurSp8UrM0JOXRHgsu7hj0bFWuxGa37Ac9AJo
	 z2S6osyhjkEBMLqD3zC0zws0RfduEGTqYV65gyfBdN4qdFuY3r66eojYMClCUdilyDC+6BX1YHPVX
	 P6EXfuw2vQxw2QwyHcolBlK99Q8J6cKOJ0mTRnBVtDlssW/q7I6hIOXG/9QdwXYND6WyPSDqAwTN8
	 Pyx2SHX4RQ3/SmmyI6Tl/3bV47vrY0HjVF6ylpb+BRsjBiUb/7FFIfP374aKM2vLsnRP1xIKnaHYn
	 FoJYF64UXjMVmqrqJkBAjEeRY2FAttIX0lukwmruLE8VFaUDSK+idB7b47SoWZogdwNsRpA97gOYF
	 jqEAxnJP9Plys3tQe9tC/v9gXnbzrQP8lVYmivLNh/WW8U/npWbWcj61Z6HOM0VfDvpD6lSb1dZvn
	 IdJ/dgIpTrQUOBFDoWwcVDa9BOzAY1Pe20Xn1UVMV41NZLC9iS9VGvaGyUdcZ43Skp7DSXgH+BN+C
	 IU6sZfU2zwwtg+BD5cvhBID7scUVDZnJduzhq
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774672197t6005799
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3l6Ym90K2Y4Zjk1OTFhMGRlMzczNzAxM2Fi?=" <syzbot+f8f9591a0de3737013ab@syzkaller.appspotmail.com>
Cc: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.6.y] WARNING in v9fs_fid_get_acl
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_69C75945_11E03BA8_3D2597A6"
Content-Transfer-Encoding: 8Bit
Date: Sat, 28 Mar 2026 12:29:56 +0800
X-Priority: 3
Message-ID: <tencent_06F5ABA639DB23E136CE383A7D834772DB0A@qq.com>
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
	TAGGED_FROM(0.00)[bounces-230766-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,f8f9591a0de3737013ab];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65EC834D45C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.

------=_NextPart_69C75945_11E03BA8_3D2597A6
Content-Type: multipart/alternative;
	boundary="----=_NextPart_69C75945_11E03BA8_787544E9";

------=_NextPart_69C75945_11E03BA8_787544E9
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24gc3RhYmxlIDYuNi55Lg0KDQoNCiNz
eXogdGVzdDogZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9saW51eC5naXQgYzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1
YzEzYg0KDQoNClRoYW5rcywNCkNoYW5namlhbiBMaXU=

------=_NextPart_69C75945_11E03BA8_787544E9
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgdGVzdCB0aGlzIHBhdGNoIG9uIHN0YWJs
ZSA2LjYueS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiNzeXogdGVzdDogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQg
YzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1YzEzYjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hhbmdqaWFuIExpdTxicj48L2Rpdj4=

------=_NextPart_69C75945_11E03BA8_787544E9--

------=_NextPart_69C75945_11E03BA8_3D2597A6
Content-Type: application/octet-stream;
	charset="ISO-8859-1";
	name="f8f9591a0de3737013ab.patch"
Content-Disposition: attachment; filename="f8f9591a0de3737013ab.patch"
Content-Transfer-Encoding: base64

RnJvbSBlNTkxMTVmNDQxNmI3NDEyMWNlMTU5MWY2NTI4NTJhOTM0MTFlNjM3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaGFuZ2ppYW4gTGl1IDxkcml6MnRAcXEuY29tPgpE
YXRlOiBTYXQsIDI4IE1hciAyMDI2IDExOjUxOjUyICswODAwClN1YmplY3Q6IFtQQVRDSF0g
dGVzdAoKU2lnbmVkLW9mZi1ieTogQ2hhbmdqaWFuIExpdSA8ZHJpejJ0QHFxLmNvbT4KLS0t
CiBuZXQvOXAvdHJhbnNfZmQuYyB8IDEwICsrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0LzlwL3Ry
YW5zX2ZkLmMgYi9uZXQvOXAvdHJhbnNfZmQuYwppbmRleCBhMWUzY2I0ODYyMWEuLjQ0MzY3
NWFjNTZlMiAxMDA2NDQKLS0tIGEvbmV0LzlwL3RyYW5zX2ZkLmMKKysrIGIvbmV0LzlwL3Ry
YW5zX2ZkLmMKQEAgLTY2NSw3ICs2NjUsNyBAQCBzdGF0aWMgdm9pZCBwOV9wb2xsX211eChz
dHJ1Y3QgcDlfY29ubiAqbSkKIAogc3RhdGljIGludCBwOV9mZF9yZXF1ZXN0KHN0cnVjdCBw
OV9jbGllbnQgKmNsaWVudCwgc3RydWN0IHA5X3JlcV90ICpyZXEpCiB7Ci0JX19wb2xsX3Qg
bjsKKyAgICAvLyBSZW1vdmVkIHVudXNlZCB2YXJpYWJsZSBkZWNsYXJhdGlvbgogCXN0cnVj
dCBwOV90cmFuc19mZCAqdHMgPSBjbGllbnQtPnRyYW5zOwogCXN0cnVjdCBwOV9jb25uICpt
ID0gJnRzLT5jb25uOwogCkBAIC02NzksMTMgKzY3OSw3IEBAIHN0YXRpYyBpbnQgcDlfZmRf
cmVxdWVzdChzdHJ1Y3QgcDlfY2xpZW50ICpjbGllbnQsIHN0cnVjdCBwOV9yZXFfdCAqcmVx
KQogCWxpc3RfYWRkX3RhaWwoJnJlcS0+cmVxX2xpc3QsICZtLT51bnNlbnRfcmVxX2xpc3Qp
OwogCXNwaW5fdW5sb2NrKCZtLT5yZXFfbG9jayk7CiAKLQlpZiAodGVzdF9hbmRfY2xlYXJf
Yml0KFdwZW5kaW5nLCAmbS0+d3NjaGVkKSkKLQkJbiA9IEVQT0xMT1VUOwotCWVsc2UKLQkJ
biA9IHA5X2ZkX3BvbGwobS0+Y2xpZW50LCBOVUxMLCBOVUxMKTsKLQotCWlmIChuICYgRVBP
TExPVVQgJiYgIXRlc3RfYW5kX3NldF9iaXQoV3dvcmtzY2hlZCwgJm0tPndzY2hlZCkpCi0J
CXNjaGVkdWxlX3dvcmsoJm0tPndxKTsKKyAgICBwOV9wb2xsX211eChtKTsgLy8gVGhpcyBp
cyB0aGUgb25seSBhY3Rpb24gbm93CiAKIAlyZXR1cm4gMDsKIH0KLS0gCjIuNDMuMAoK

------=_NextPart_69C75945_11E03BA8_3D2597A6--


