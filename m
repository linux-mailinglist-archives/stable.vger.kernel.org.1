Return-Path: <stable+bounces-230679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFwzCXGixmnrMQUAu9opvQ
	(envelope-from <stable+bounces-230679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:29:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A2346C17
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1F3F3041BFC
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D97B3016E0;
	Fri, 27 Mar 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Eyu64sUS"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A602C027B
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625024; cv=none; b=KOMMKErNk35n6LZ8Q+SHdnl4k0hkAEJcbyqQTypZjJkBwEke/0sfQz0FKvDC9t89JjmX8eg/x/mtrDCb4myvFuAp/8h0A0v5iMBZLvtdjTlzyDlT0DEzr/SxrZWY3iUxept3JAWA9pjEOIwLyF9ULzJuZtDMjAjNkI2vKqhRAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625024; c=relaxed/simple;
	bh=UqoKYbZbcVVpBMXRYx6tCAQwVv/M7Yv+pltGt1g1dCM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=HS2GKRzVIamyVaaCLsZfiMzN8OWI3nuJSPfwUp2mcK5ziE1Yvs7fMWCEeT0HXrPCsR2YOqX9e1dZNimXb8LCf0p0MfuEPOHkmgP/hiQygKIZ5wL+oOa6/UN6lJ7Bg0YulGh9DqkwjIRdVz1m57xujv0rQ2yIwI2U55jayqDZfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Eyu64sUS; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774625017; bh=NP/FqPtwAwxBUsjqppqyfHKoRZEDTAHaJRxFnA3eWwY=;
	h=From:To:Cc:Subject:Date;
	b=Eyu64sUS+j+Z517efaekp/hol8E12szh0a7lm/34fLyIxhJYf+4RVgPNixAQZIuAP
	 VCTSATZY2RjQYNVIXf3ymDubh9R07Hmy2a9T0CLHlSlDUXsMeKVKv8wa4JrO0HuwyB
	 bmMbIFmfhDc7+WrqwnLtwsKeA6e5jIcWYK3HXpIk=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: NOCVdBo066pNuH2Wy9T7AOblmOtk44YZDultW9ev0EFhUVFnl1pIFzMJ9LyU5Y
	 ovquUkWuEgjOAS5cPz8HgbuE2QmSyEPdn47BcKNuA3i3wXj4+Y+gXJMNE76v4pYf6tEboW3OZKeQr
	 rr4NXChS2Kn2YJmnWvMgmeP18qmzwN8m+8YRvTlndQhQvv3ESteAnlo8j8Rl46AI3793lVCD/hTGK
	 gqnBOBEL93THgQcEM7KXAAIRPbpVpYseVvKgcA0n/Ncy6GtAW/mZERPXoHeIzh8WDK3yni9xYF0lv
	 mN1E9Liz5kCwwjKLAjaCCthfJ+7wxO4ZfqjgSewLsNd9McAfsBhxALDxmAdG+gluvCRkbodG6OXru
	 7AJ8PC98pyzAr6fwXSJsQGaoG3+HrEPpf7ym93F8XFgZesqVEF6qlemr55gLCNC4amcmKKBLs5C9p
	 TTx19xQWFxrigXO6dAyURDCvyBe5VFiV8Mgy4+Xr7LloPFtAGQCqT58mZrrA2QCqoKJl+0EDLBofR
	 nq9AkmNTBCiDgRPDtnFGer8A9V03BUnqNSbr9A2yWKmlRoPUwTnikcoUdNiAGkNXOtfOK9xCWvvAd
	 20b2njoBBeulrqRaK8k6uqHe8P2nWMl8CSRCjUSqr1uVphLAZmNhXi962VIonw2sKKeIGoBNE3gvB
	 0QEgpw3mwydkoorVyNGhzMHdtVSSQg7D8isHdVbQGUSHCK5Rz2GRFAK/TxBmFBLwdqIgJ7DxmBcZC
	 rN5ZxSSbYtS6twI6qPR36Pdfhv1cev4QUnE9OQjW93bVOS5taqTX8z8r5jbRTRS87LaaILIprfoWE
	 zCt7j8HTrdKDjlTO4ps3neC/lXeHE7wPS4iJq0G8ERyXL5XfRm/0ZZ05UVashVoiNy7GQiUk0l+8J
	 wwsKWwKBtKbcbab+8L4U1Vt08AcOoDbjqffjlMiawkwd8heomN+hqdV2ROggfXapkIngEson3kHQk
	 BRA6WLHShJ42jehPtQjHBd50NQy0qX1H5sbblYF5s6HKKqUinLVxcfl91OXnefEvif7KQwzFz+wzF
	 aeN8FhunRxlkVUqsSNFNnzdotki1msi6Dy9WNjTbCojTJ73FGojhHYWUULBRfM/yzmjTqN9viCbcv
	 mK8=
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774625016t6331364
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3l6Ym90K2FhNGViN2M2NzkxM2RiZDg4ZjU2?=" <syzbot+aa4eb7c67913dbd88f56@syzkaller.appspotmail.com>
Cc: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.6.y]  net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_69C6A0F8_13AC0400_127BED1B"
Content-Transfer-Encoding: 8Bit
Date: Fri, 27 Mar 2026 23:23:36 +0800
X-Priority: 3
Message-ID: <tencent_3E39327F0345F6D90DAB823B4B23D1357A0A@qq.com>
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
	TAGGED_FROM(0.00)[bounces-230679-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,aa4eb7c67913dbd88f56];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B0A2346C17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.

------=_NextPart_69C6A0F8_13AC0400_127BED1B
Content-Type: multipart/alternative;
	boundary="----=_NextPart_69C6A0F8_13AC0400_7B008694";

------=_NextPart_69C6A0F8_13AC0400_7B008694
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24gc3RhYmxlIDYuNi55Lg0KDQoNCiNz
eXogdGVzdDogZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9saW51eC5naXQgYzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1
YzEzYg0KDQoNClRoYW5rcywNCkNoYW5namlhbiBMaXU=

------=_NextPart_69C6A0F8_13AC0400_7B008694
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgdGVzdCB0aGlzIHBhdGNoIG9uIHN0YWJs
ZSA2LjYueS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiNzeXogdGVzdDogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQg
YzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1YzEzYjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hhbmdqaWFuIExpdTxicj48L2Rpdj4=

------=_NextPart_69C6A0F8_13AC0400_7B008694--

------=_NextPart_69C6A0F8_13AC0400_127BED1B
Content-Type: application/octet-stream;
	charset="ISO-8859-1";
	name="aa4eb7c67913dbd88f56.patch"
Content-Disposition: attachment; filename="aa4eb7c67913dbd88f56.patch"
Content-Transfer-Encoding: base64

Y29tbWl0IDRmZTVhMDBlYzcwNzE3YTdmMTAwMmQ4OTEzZWM2MTQzNTgyYjNjOGUKQXV0aG9y
OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+CkRhdGU6ICAgRnJpIE5vdiAy
MSAxNTo0MTowMCAyMDI1ICswMDAwCgogICAgbmV0OiBzY2hlZDogZml4IFRDRl9MQVlFUl9U
UkFOU1BPUlQgaGFuZGxpbmcgaW4gdGNmX2dldF9iYXNlX3B0cigpCiAgICAKICAgIHN5emJv
dCByZXBvcnRlZCB0aGF0IHRjZl9nZXRfYmFzZV9wdHIoKSBjYW4gYmUgY2FsbGVkIHdoaWxl
IHRyYW5zcG9ydAogICAgaGVhZGVyIGlzIG5vdCBzZXQgWzFdLgogICAgCiAgICBJbnN0ZWFk
IG9mIHJldHVybmluZyBhIGRhbmdsaW5nIHBvaW50ZXIsIHJldHVybiBOVUxMLgogICAgCiAg
ICBGaXggdGNmX2dldF9iYXNlX3B0cigpIGNhbGxlcnMgdG8gaGFuZGxlIHRoaXMgTlVMTCB2
YWx1ZS4KICAgIAogICAgWzFdCiAgICAgV0FSTklORzogQ1BVOiAxIFBJRDogNjAxOSBhdCAu
L2luY2x1ZGUvbGludXgvc2tidWZmLmg6MzA3MSBza2JfdHJhbnNwb3J0X2hlYWRlciBpbmNs
dWRlL2xpbnV4L3NrYnVmZi5oOjMwNzEgW2lubGluZV0KICAgICBXQVJOSU5HOiBDUFU6IDEg
UElEOiA2MDE5IGF0IC4vaW5jbHVkZS9saW51eC9za2J1ZmYuaDozMDcxIHRjZl9nZXRfYmFz
ZV9wdHIgaW5jbHVkZS9uZXQvcGt0X2Nscy5oOjUzOSBbaW5saW5lXQogICAgIFdBUk5JTkc6
IENQVTogMSBQSUQ6IDYwMTkgYXQgLi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oOjMwNzEgZW1f
bmJ5dGVfbWF0Y2grMHgyZDgvMHgzZjAgbmV0L3NjaGVkL2VtX25ieXRlLmM6NDMKICAgIE1v
ZHVsZXMgbGlua2VkIGluOgogICAgQ1BVOiAxIFVJRDogMCBQSUQ6IDYwMTkgQ29tbTogc3l6
LjAuMTcgTm90IHRhaW50ZWQgc3l6a2FsbGVyICMwIFBSRUVNUFQoZnVsbCkKICAgIENhbGwg
VHJhY2U6CiAgICAgPFRBU0s+CiAgICAgIHRjZl9lbV9tYXRjaCBuZXQvc2NoZWQvZW1hdGNo
LmM6NDk0IFtpbmxpbmVdCiAgICAgIF9fdGNmX2VtX3RyZWVfbWF0Y2grMHgxYWMvMHg3NzAg
bmV0L3NjaGVkL2VtYXRjaC5jOjUyMAogICAgICB0Y2ZfZW1fdHJlZV9tYXRjaCBpbmNsdWRl
L25ldC9wa3RfY2xzLmg6NTEyIFtpbmxpbmVdCiAgICAgIGJhc2ljX2NsYXNzaWZ5KzB4MTE1
LzB4MmQwIG5ldC9zY2hlZC9jbHNfYmFzaWMuYzo1MAogICAgICB0Y19jbGFzc2lmeSBpbmNs
dWRlL25ldC90Y193cmFwcGVyLmg6MTk3IFtpbmxpbmVdCiAgICAgIF9fdGNmX2NsYXNzaWZ5
IG5ldC9zY2hlZC9jbHNfYXBpLmM6MTc2NCBbaW5saW5lXQogICAgICB0Y2ZfY2xhc3NpZnkr
MHg0Y2YvMHgxMTQwIG5ldC9zY2hlZC9jbHNfYXBpLmM6MTg2MAogICAgICBtdWx0aXFfY2xh
c3NpZnkgbmV0L3NjaGVkL3NjaF9tdWx0aXEuYzozOSBbaW5saW5lXQogICAgICBtdWx0aXFf
ZW5xdWV1ZSsweGZkLzB4NGMwIG5ldC9zY2hlZC9zY2hfbXVsdGlxLmM6NjYKICAgICAgZGV2
X3FkaXNjX2VucXVldWUrMHg0ZS8weDI2MCBuZXQvY29yZS9kZXYuYzo0MTE4CiAgICAgIF9f
ZGV2X3htaXRfc2tiIG5ldC9jb3JlL2Rldi5jOjQyMTQgW2lubGluZV0KICAgICAgX19kZXZf
cXVldWVfeG1pdCsweGU4My8weDNiNTAgbmV0L2NvcmUvZGV2LmM6NDcyOQogICAgICBwYWNr
ZXRfc25kIG5ldC9wYWNrZXQvYWZfcGFja2V0LmM6MzA3NiBbaW5saW5lXQogICAgICBwYWNr
ZXRfc2VuZG1zZysweDNlMzMvMHg1MDgwIG5ldC9wYWNrZXQvYWZfcGFja2V0LmM6MzEwOAog
ICAgICBzb2NrX3NlbmRtc2dfbm9zZWMgbmV0L3NvY2tldC5jOjcyNyBbaW5saW5lXQogICAg
ICBfX3NvY2tfc2VuZG1zZysweDIxYy8weDI3MCBuZXQvc29ja2V0LmM6NzQyCiAgICAgIF9f
X19zeXNfc2VuZG1zZysweDUwNS8weDgzMCBuZXQvc29ja2V0LmM6MjYzMAogICAgCiAgICBG
aXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpCiAgICBSZXBvcnRlZC1i
eTogc3l6Ym90K2YzYTQ5N2YwMmMzODlkODZlZjE2QHN5emthbGxlci5hcHBzcG90bWFpbC5j
b20KICAgIENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzY5MjA4NTVh
LmE3MGEwMjIwLjJlYTUwMy4wMDU4LkdBRUBnb29nbGUuY29tL1QvI3UKICAgIFNpZ25lZC1v
ZmYtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4KICAgIFJldmlld2Vk
LWJ5OiBKYW1hbCBIYWRpIFNhbGltIDxqaHNAbW9qYXRhdHUuY29tPgogICAgTGluazogaHR0
cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjUxMTIxMTU0MTAwLjE2MTYyMjgtMS1lZHVtYXpl
dEBnb29nbGUuY29tCiAgICBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPgotLS0gYS9pbmNsdWRlL25ldC9wa3RfY2xzLmgKKysrIGIvaW5jbHVkZS9u
ZXQvcGt0X2Nscy5oCkBAIC01MzYsNiArNTM2LDggQEAgc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBjaGFyICogdGNmX2dldF9iYXNlX3B0cihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBpbnQgbGF5
ZXIpCiAJCWNhc2UgVENGX0xBWUVSX05FVFdPUks6CiAJCQlyZXR1cm4gc2tiX25ldHdvcmtf
aGVhZGVyKHNrYik7CiAJCWNhc2UgVENGX0xBWUVSX1RSQU5TUE9SVDoKKwkJCWlmICghc2ti
X3RyYW5zcG9ydF9oZWFkZXJfd2FzX3NldChza2IpKQorCQkJCWJyZWFrOwogCQkJcmV0dXJu
IHNrYl90cmFuc3BvcnRfaGVhZGVyKHNrYik7CiAJfQogCi0tLSBhL25ldC9zY2hlZC9lbV9j
bXAuYworKysgYi9uZXQvc2NoZWQvZW1fY21wLmMKQEAgLTIyLDkgKzIyLDEyIEBAIHN0YXRp
YyBpbnQgZW1fY21wX21hdGNoKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCB0Y2ZfZW1h
dGNoICplbSwKIAkJCXN0cnVjdCB0Y2ZfcGt0X2luZm8gKmluZm8pCiB7CiAJc3RydWN0IHRj
Zl9lbV9jbXAgKmNtcCA9IChzdHJ1Y3QgdGNmX2VtX2NtcCAqKSBlbS0+ZGF0YTsKLQl1bnNp
Z25lZCBjaGFyICpwdHIgPSB0Y2ZfZ2V0X2Jhc2VfcHRyKHNrYiwgY21wLT5sYXllcikgKyBj
bXAtPm9mZjsKKwl1bnNpZ25lZCBjaGFyICpwdHIgPSB0Y2ZfZ2V0X2Jhc2VfcHRyKHNrYiwg
Y21wLT5sYXllcik7CiAJdTMyIHZhbCA9IDA7CiAKKwlpZiAoIXB0cikKKwkJcmV0dXJuIDA7
CisJcHRyICs9IGNtcC0+b2ZmOwogCWlmICghdGNmX3ZhbGlkX29mZnNldChza2IsIHB0ciwg
Y21wLT5hbGlnbikpCiAJCXJldHVybiAwOwogCi0tLSBhL25ldC9zY2hlZC9lbV9uYnl0ZS5j
CisrKyBiL25ldC9zY2hlZC9lbV9uYnl0ZS5jCkBAIC00Miw2ICs0Miw4IEBAIHN0YXRpYyBp
bnQgZW1fbmJ5dGVfbWF0Y2goc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IHRjZl9lbWF0
Y2ggKmVtLAogCXN0cnVjdCBuYnl0ZV9kYXRhICpuYnl0ZSA9IChzdHJ1Y3QgbmJ5dGVfZGF0
YSAqKSBlbS0+ZGF0YTsKIAl1bnNpZ25lZCBjaGFyICpwdHIgPSB0Y2ZfZ2V0X2Jhc2VfcHRy
KHNrYiwgbmJ5dGUtPmhkci5sYXllcik7CiAKKwlpZiAoIXB0cikKKwkJcmV0dXJuIDA7CiAJ
cHRyICs9IG5ieXRlLT5oZHIub2ZmOwogCiAJaWYgKCF0Y2ZfdmFsaWRfb2Zmc2V0KHNrYiwg
cHRyLCBuYnl0ZS0+aGRyLmxlbikpCi0tLSBhL25ldC9zY2hlZC9lbV90ZXh0LmMKKysrIGIv
bmV0L3NjaGVkL2VtX3RleHQuYwpAQCAtMjksMTIgKzI5LDE5IEBAIHN0YXRpYyBpbnQgZW1f
dGV4dF9tYXRjaChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgdGNmX2VtYXRjaCAqbSwK
IAkJCSBzdHJ1Y3QgdGNmX3BrdF9pbmZvICppbmZvKQogewogCXN0cnVjdCB0ZXh0X21hdGNo
ICp0bSA9IEVNX1RFWFRfUFJJVihtKTsKKwl1bnNpZ25lZCBjaGFyICpwdHI7CiAJaW50IGZy
b20sIHRvOwogCi0JZnJvbSA9IHRjZl9nZXRfYmFzZV9wdHIoc2tiLCB0bS0+ZnJvbV9sYXll
cikgLSBza2ItPmRhdGE7CisJcHRyID0gdGNmX2dldF9iYXNlX3B0cihza2IsIHRtLT5mcm9t
X2xheWVyKTsKKwlpZiAoIXB0cikKKwkJcmV0dXJuIDA7CisJZnJvbSA9IHB0ciAtIHNrYi0+
ZGF0YTsKIAlmcm9tICs9IHRtLT5mcm9tX29mZnNldDsKIAotCXRvID0gdGNmX2dldF9iYXNl
X3B0cihza2IsIHRtLT50b19sYXllcikgLSBza2ItPmRhdGE7CisJcHRyID0gdGNmX2dldF9i
YXNlX3B0cihza2IsIHRtLT50b19sYXllcik7CisJaWYgKCFwdHIpCisJCXJldHVybiAwOwor
CXRvID0gcHRyIC0gc2tiLT5kYXRhOwogCXRvICs9IHRtLT50b19vZmZzZXQ7CiAKIAlyZXR1
cm4gc2tiX2ZpbmRfdGV4dChza2IsIGZyb20sIHRvLCB0bS0+Y29uZmlnKSAhPSBVSU5UX01B
WDsK

------=_NextPart_69C6A0F8_13AC0400_127BED1B--


