Return-Path: <stable+bounces-268048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mMUrJxE1O2rVSggAu9opvQ
	(envelope-from <stable+bounces-268048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 03:38:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF16BACF8
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 03:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=PaS1UCYd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268048-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268048-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DDB7307540F
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66A233952;
	Wed, 24 Jun 2026 01:37:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB19192B75;
	Wed, 24 Jun 2026 01:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782265027; cv=none; b=V+MGPl/uNJxBm3wRYDrSiTlR28MYF6CqMxn7Sb63iOPzfATW1pGgFUPTa5QDWWAU171JbcUCjfUvZZ0jRjyB8TqANiycj4o2JvGkAJh8VFy9aB0I/dLU9fK/p5JWOCieaNiUnCkGMNrpkNugGHrg/kvP7H8t/IMNSeEZLYPdu8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782265027; c=relaxed/simple;
	bh=hkwOOki2RqLJgHnzvIKyiilqnxhTHu7gUnV6xBVS8d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H3wtH4r4Bm7zXva8FBzYy5POUW/If8686QwGsMeqphJGj6GSrzBMPnpcVKhFfM7b+PmJpGcsv2tncy9lDHfjaC+uC00e9ZNxY6ZUtK2mY0RNg8w48UO0XpWas6WCeZxOkwsRbFUmO1wUBwbyyFBwlCFCKa53EJEhQazRpdcom+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PaS1UCYd; arc=none smtp.client-ip=54.206.34.216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782264981;
	bh=sINvD0bskv+vJHonYANAwnvBnaUdmZEFu+17EC2edy8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=PaS1UCYd+mL0d1pT2UMZLA0+7sGPJ24PiLx8opW07YlR3rpnP19ZuUMb/a3S8woo1
	 Ai3zkt9pgXSklGFyD64pD4oLjksonHGdsd6zSoLFf55gRsxVYY8xzo5HHFboVN0257
	 0KPBwc/0SS2p+ZfVZDSbAHMriJEX+irv/AXzIWlE=
X-QQ-mid: esmtpgz16t1782264975tbb836680
X-QQ-Originating-IP: 98Kg+0tnLi7B4a2+y8gyh0T2Ap7++7BlJgNHfAQdQI8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 09:36:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4840196878114388730
EX-QQ-RecipientCnt: 7
From: Yang Shao <shaoyang@uniontech.com>
To: sudipm.mukherjee@gmail.com
Cc: marko.kohtala@gmail.com,
	akpm@osdl.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	Yang Shao <shaoyang@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] parport: fix inverted daisy selection result check
Date: Wed, 24 Jun 2026 09:36:03 +0800
Message-Id: <20260624013603.1184198-1-shaoyang@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NEAatei6DLTNU4P+Zkv8Q9/0aNKRHZox71ekWgTNVWHDIZjN85DG4Q2A
	L9kxXuiLRcXwQsa1vIOFOltJf2UcjTtXTb6Dh7hG7h51+H9RIlJVMks+3kgGtmkMwXuUsUU
	ZW04nafcFMcZYqYYcy/OJVVDXPTq0vhaQ9AuPFfzl4Zb2ednfW92WAehdHz9UwF0YAliBYs
	HfjyuYSLPadniGnbGtN27YQPIvX6+TVJggCFzCEGgjMqPGr3sjMd8YJ1wdC+7VA67xczQCr
	KMOu/Fl2F51vrXjctai3AYagtjbNhOOEmRrnjihITiLNLWyU1jc2zRTLRYUeysSA8Bs39QU
	g8u/f/xayADatDuMhbXGAZ0QVGo8Wo1yrvWtxZJeshpDcw5eAtUyc+lHRpX908uvYp5qcMJ
	6Pk3IzUbFRGiwkCsrhQuygKdHDLTGjvzf/gb0s1VpOEZxJIQ9Wllkz9cAB/R9AYHsF1HCqN
	izfQp90FNTPDXZwlzfIjyBZt9GystdZGsOzxd+dd5lwYEzgmKZbzKal2tPypfUO/v+LEzmN
	dVrzHwm/otqqtwtcR1Elz9QjYEECkZ4BRIHDqjj8g4YIjfT1THbebfkxaEMpLFqEyosANmw
	viVogmyEKv8tWx/hxZI7dadFDyrqNT+eC576ON3+UGxI55QTE9MRkms1RwP2alIRr39JKCw
	GPfRku3No7ZdvVSy8Ca9/9MXf0YPDQgkRdWIKP4OM2BR2fNqh4Jpb8OcCjfzoaqmbFgr3cz
	HYpt1QX8XlJhY/OK+RNY8DLmInFwRw8nYtyo+I3n9q7EZvRSs2pEYSKeFXBIg4/eBuuiGzd
	8DPfPUAR7ykZGmtz8vSd/tr8UDGiJReuNSRc5XxBvB4yqkNPWfpP0aB73NLyjxd0Jf2QNvV
	iYAQDPQn9HmJOtjzsUsC1KLIm/f33bU7k1P6l6oSOqPw7mTnJSO85fWeD7K2pj2VbNxpZSD
	cfeHVemEbifcAuFjKx/J7P6b+kDm8zmJkRoxphB2E8h8o/qLMS//ev7F6DoCnEJwEI4LG03
	U5u//CazVWKo3OpuerUild1SLstfs=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,osdl.org,vger.kernel.org,uniontech.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268048-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[shaoyang@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sudipm.mukherjee@gmail.com,m:marko.kohtala@gmail.com,m:akpm@osdl.org,m:linux-kernel@vger.kernel.org,m:kernel@uniontech.com,m:shaoyang@uniontech.com,m:stable@vger.kernel.org,m:sudipmmukherjee@gmail.com,m:markokohtala@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaoyang@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07DF16BACF8

parport_daisy_select() returns a boolean success result. It returns 1
when the requested daisy-chain device acknowledges the CPP selection
command and 0 otherwise.

Commit 7c9cc3be1094 ("[PATCH] parport: parport_daisy_select return
value fix") changed the helper from returning the raw
PARPORT_STATUS_ERROR bit to returning its logical negation. Selection
success therefore changed from a zero return value to a nonzero return
value, but parport_claim() retained the old zero-is-success test.

As a result, a successful selection does not update port->daisy, while
an unsuccessful selection can be recorded as the currently selected
daisy address. parport_open() later checks port->daisy to determine
whether the requested device was successfully selected, so this can
reject an existing device or accept a device address that was not
selected.

Test the return value directly and update port->daisy only after a
successful selection.

Fixes: 7c9cc3be1094 ("[PATCH] parport: parport_daisy_select return value fix")
Cc: stable@vger.kernel.org
Signed-off-by: Yang Shao <shaoyang@uniontech.com>
---
 drivers/parport/share.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index c4c5869..2888005 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -1025,8 +1025,8 @@ int parport_claim(struct pardevice *dev)
 	/* If it's a daisy chain device, select it. */
 	if (dev->daisy >= 0) {
 		/* This could be lazier. */
-		if (!parport_daisy_select(port, dev->daisy,
-					   IEEE1284_MODE_COMPAT))
+		if (parport_daisy_select(port, dev->daisy,
+					 IEEE1284_MODE_COMPAT))
 			port->daisy = dev->daisy;
 	}
 #endif /* IEEE1284.3 support */
--
2.47.3


