Return-Path: <stable+bounces-230671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGzSGrWWxmnrMQUAu9opvQ
	(envelope-from <stable+bounces-230671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:39:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7FC346382
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 431AD3060A80
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52E22173D;
	Fri, 27 Mar 2026 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VWpeNFUD"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CB3F7AA2
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622350; cv=none; b=psUc0u3wYsLTERWJEH0uMHiSqipbO2yz4D625XAZ6ksqJuOD0UzMBAitux+A55esCXKcl+I8Vb+hOOPPl3rlWFWW14ccHXdL84EygupEcRpoaEqGn5qKp/fRIp5OO4SNFpJRG58mTH3UZYNg7eX4umV7g0F7jS5reb6uUJ9nt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622350; c=relaxed/simple;
	bh=ivqfIqsPHjsbNqGTrsfhY7ry0sTkKC76dDXgJ70bhk0=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=HeMbTbF4wHyfOoubQ8KgdyC3kzoKmLADxg9xMh4zpjEKvLJnfpIogG/AOD6ciBUhwSSe46X206io+vmvpcL4VT3T2gVgc/R30DjZrMty+OVR9CZa9qhpUe5N6iVrC5Ezxwr/73bJlsymRQXX3PpE2nEvihf7qOKYXLfdJpbuZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VWpeNFUD; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774622343; bh=44k7foZklptCmE4v/K8cnSHo+zV38+zAOd+Nkim+sE0=;
	h=From:To:Cc:Subject:Date;
	b=VWpeNFUD10Y5GlXc6K0246OllkuLvGKXaAnW1GMGZ4AWmSm6yqPNqb5PJWQ82duKH
	 XfIXBc+wr57jyuTpmIQ39FnW3n/i2QLH+o5TyCYNBmfoZOuN4Tn+UsORXjPynYdL/n
	 2Yem7KKWnWloBeaJDgYRavWBIIurs5GVxU4emh9M=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: NDhVf3b/OhrxwGNDeR6rDAAhRg/J+NShiZknThntU6eDege5y6tm4JRFfLwVSB
	 ci8c1Eerdp3iOLfMCQ6bAsyPracGzLaGG81jE64AVb6KAnnP/awwAFm/58ug3wvJ90nBH+yne5x6H
	 Wto9Ghydy4vWdC6UhwHnuT+9gYnC1jI0W85TjfVMoak/l4BNlNxGs80GANY798z0UvkdMPWEmIr2p
	 JcHhvWHldzDgyBdTKOG07MuZTzVFdgDrj422QlH51jX5Epl4h+PeaaZmsJw45YX2FpX5vqJHF9fOs
	 U/zC/rjWNVbx+/CorO2I6HiRksf0Zrv8zXVkf4Zc/SZ4ceSEuY7bkrl/966prn40F7JLsuE/URtdy
	 U8chZqIL6U0YLwY+L5xsolTa5DKjVRDCO2nmDaLMwFsvn++vznTscbtdbgcVq2a9Ad3XtwHIloewm
	 ymOMW1wGq4hVAS4dmWnJKhsC0EzmQuC+n7Qei/tKczIFEBi+hT8la97T5xavWXB2eHRNOEaAcjgBH
	 F4bxXWs/Ktf2UwUAh8NhJt3ynx+6ukBVz2uuwla1cRj1oXQZPzj1yTlEqaRS1pHup3iTa/jN5kOij
	 AAp8J6GbyzWeCLSgtSPq/xH4RjoY6sDmRHaafVXRcv/2jlmStMsRxsM7zXYOSM8hfiPiBSyY5wO+d
	 SxBOES1OagtquvA5VoBKUI2/KN2aeL7hHW15hzy4N4dTkuwM0WoaiYbpVQfpAATxfY5uW1XdItt2s
	 b0IWzNoTIoDjmXuW+6AkS1wA1k1yoy5KtvX+l0nmgb3otWrvV2NsIw0saNNDDjCsZHiEmCzaCeej8
	 tRFUfInAHebIfduvBt3BLGU5yl2CvwalCr58gWxNZBWUSQyfeqUw8vUcWJMRn9c+rDqNqBXixDiLj
	 NCguukoo/R5KllSg5tJnHvoVsD9MRumauQVMQ9FJwjAHVxg8T2LKi4NPdpiwprn0vUFJ41w294QHS
	 YlI27e2C4ACI87cTUPUGl5xdvoXrkWp7lWa21deggMKn0mt7eIJgjMEVsI5cl9DEiqj0fEdLd14IQ
	 E1B+1iIOwr/1m8VPXf6/sXTb5mxfKXy5hLNGkgcMlIG3RVds=
X-QQ-FEAT: oHWrrGTW1dC5tAPeTNEktQWzsGuk/wXs
X-QQ-SSF: 00000000000000F0000000000000
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail746t1774622342t6868857
From: "=?ISO-8859-1?B?ZHJpejJ0?=" <driz2t@qq.com>
To: "=?ISO-8859-1?B?c3l6Ym90KzczOWMxMjhiNTU1N2FiYjlmODE2?=" <syzbot+739c128b5557abb9f816@syzkaller.appspotmail.com>
Cc: "=?ISO-8859-1?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: [PATCH 6.6.y]  9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_69C69686_11EA5508_7CD21DB8"
Content-Transfer-Encoding: 8Bit
Date: Fri, 27 Mar 2026 22:39:01 +0800
X-Priority: 3
Message-ID: <tencent_3A22B535EA39B67E9B4402D84DAA4E3B8B0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spamd-Result: default: False [2.94 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	MV_CASE(0.50)[];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-230671-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable,739c128b5557abb9f816];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC7FC346382
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.

------=_NextPart_69C69686_11EA5508_7CD21DB8
Content-Type: multipart/alternative;
	boundary="----=_NextPart_69C69686_11EA5508_5C5F493C";

------=_NextPart_69C69686_11EA5508_5C5F493C
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNClBsZWFzZSB0ZXN0IHRoaXMgcGF0Y2ggb24gc3RhYmxlIDYuNi55Lg0KDQoNCiNz
eXogdGVzdDogZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9saW51eC5naXQgYzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1
YzEzYg0KDQoNClRoYW5rcywNCkNoYW5namlhbiBMaXU=

------=_NextPart_69C69686_11EA5508_5C5F493C
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5QbGVhc2UgdGVzdCB0aGlzIHBhdGNoIG9uIHN0YWJs
ZSA2LjYueS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiNzeXogdGVzdDogZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQg
YzA5ZmJjZDMxYWU2ZDcxZTdjNjk1NDU4MzliZWM5MmQ4ZTE1YzEzYjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hhbmdqaWFuIExpdTxicj48L2Rpdj4=

------=_NextPart_69C69686_11EA5508_5C5F493C--

------=_NextPart_69C69686_11EA5508_7CD21DB8
Content-Type: application/octet-stream;
	charset="ISO-8859-1";
	name="739c128b5557abb9f816.patch"
Content-Disposition: attachment; filename="739c128b5557abb9f816.patch"
Content-Transfer-Encoding: base64

LS0tIGEvbmV0LzlwL3RyYW5zX2ZkLmMKKysrIGIvbmV0LzlwL3RyYW5zX2ZkLmMKQEAgLTY1
NCwzNCArNjU0LDMxIEBACiAvKioKICAqIHA5X2ZkX3JlcXVlc3QgLSBzZW5kIDlQIHJlcXVl
c3QKICAqIFRoZSBmdW5jdGlvbiBjYW4gc2xlZXAgdW50aWwgdGhlIHJlcXVlc3QgaXMgc2No
ZWR1bGVkIGZvciBzZW5kaW5nLgogICogVGhlIGZ1bmN0aW9uIGNhbiBiZSBpbnRlcnJ1cHRl
ZC4gUmV0dXJuIGZyb20gdGhlIGZ1bmN0aW9uIGlzIG5vdAogICogYSBndWFyYW50ZWUgdGhh
dCB0aGUgcmVxdWVzdCBpcyBzZW50IHN1Y2Nlc3NmdWxseS4KICAqCiAgKiBAY2xpZW50OiBj
bGllbnQgaW5zdGFuY2UKICAqIEByZXE6IHJlcXVlc3QgdG8gYmUgc2VudAogICoKICAqLwog
CiBzdGF0aWMgaW50IHA5X2ZkX3JlcXVlc3Qoc3RydWN0IHA5X2NsaWVudCAqY2xpZW50LCBz
dHJ1Y3QgcDlfcmVxX3QgKnJlcSkKIHsKIAlfX3BvbGxfdCBuOwogCXN0cnVjdCBwOV90cmFu
c19mZCAqdHMgPSBjbGllbnQtPnRyYW5zOwogCXN0cnVjdCBwOV9jb25uICptID0gJnRzLT5j
b25uOwogCiAJcDlfZGVidWcoUDlfREVCVUdfVFJBTlMsICJtdXggJXAgdGFzayAlcCB0Y2Fs
bCAlcCBpZCAlZFxuIiwKIAkJIG0sIGN1cnJlbnQsICZyZXEtPnRjLCByZXEtPnRjLmlkKTsK
IAlpZiAobS0+ZXJyIDwgMCkKIAkJcmV0dXJuIG0tPmVycjsKIAogCXNwaW5fbG9jaygmbS0+
cmVxX2xvY2spOwogCVdSSVRFX09OQ0UocmVxLT5zdGF0dXMsIFJFUV9TVEFUVVNfVU5TRU5U
KTsKIAlsaXN0X2FkZF90YWlsKCZyZXEtPnJlcV9saXN0LCAmbS0+dW5zZW50X3JlcV9saXN0
KTsKIAlzcGluX3VubG9jaygmbS0+cmVxX2xvY2spOwogCi0JaWYgKHRlc3RfYW5kX2NsZWFy
X2JpdChXcGVuZGluZywgJm0tPndzY2hlZCkpCi0JCW4gPSBFUE9MTE9VVDsKLQllbHNlCi0J
CW4gPSBwOV9mZF9wb2xsKG0tPmNsaWVudCwgTlVMTCwgTlVMTCk7CisgcDlfcG9sbF9tdXgo
bSk7CiAKIAlpZiAobiAmIEVQT0xMT1VUICYmICF0ZXN0X2FuZF9zZXRfYml0KFd3b3Jrc2No
ZWQsICZtLT53c2NoZWQpKQogCQlzY2hlZHVsZV93b3JrKCZtLT53cSk7Cg==

------=_NextPart_69C69686_11EA5508_7CD21DB8--


