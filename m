Return-Path: <stable+bounces-253722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPI4M/geEGqjTwYAu9opvQ
	(envelope-from <stable+bounces-253722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:16:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5813C5B0FC4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F040E3006148
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B813AFAE3;
	Fri, 22 May 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hgwEI0us"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4663B6352;
	Fri, 22 May 2026 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441391; cv=none; b=hL8REvsqgKPE5jmT8i3NAVti5UHhkx7hVvRz2s+WgMp02MeZY6GX0c9bg0RoDdyU7E/oHT+WulCpYjcgaMAp2U5+9BpPh8Y3WgqljjXlnU3Xd5rAP9FftYRbUhXs4XScYE4IDY6jPrMEMgpwbi7vOBkfzVUmqjbQbsygmggUi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441391; c=relaxed/simple;
	bh=7OfjFs4Bg5vviqn455+7WnkjH86P0c2h8wLYzLcl8Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JExM2vrBpK3kIh2ZEooQvQ1IqkO229P0EPbu9nZsJ180ghW/IiXEbvrCRJgaUL8IZP0rr4VoReM7531N3aZB5ewhsYwcGuXBV1pd6LIMO10Sa/baEK2dveAwWib+NEeXfyVyNUV8PzJvdcB3U1/yEHlUuYSPCTLI+HwXzN4Ilt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hgwEI0us; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779441351;
	bh=08CAO5lKzWde9l32XGequrPCSRtypNLqVRXwu/sK97Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hgwEI0us+ywpGKXz5+Sw0hk9ICqiqhlt8dwtKl+ojen5+fsBgdBPyilhXJQlG8X4S
	 bND3KmyV9r83lkWP3KijWtrmADLwvwfV2Hd0bnHSC+bYxxfDtJVlauJrJxMwPSS6fK
	 ogKrXlBG7yT/0sAbmmpCDUgoJeLH3Zki94eD/bLo=
X-QQ-mid: esmtpgz14t1779441329tcbca6c91
X-QQ-Originating-IP: nOvGuVInMdku8IJEn3AcjYyrv6JtS0hpPfqrXbYa0hI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 May 2026 17:15:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10072213887480833044
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org,
	oneukum@suse.com
Cc: carvsdriver@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] USB: cdc-acm: Fix bit overlap and move quirk definitions to header
Date: Fri, 22 May 2026 17:13:58 +0800
Message-Id: <20260522091357.1301196-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NchHDkd43sBtypd/+GxbJW4NTrVJeZ7H3vo7d7PLFCmOSoclDolK/shZ
	VbabDmrTy8GLtrFj9k/q17xThLOSbmi0Mj2wT9PRewU6t2QGFWB09FnTcrn28X9K3RQvCpz
	joaJOpN5B8KiQB1wdeLxG8+12H/9da1RYPgmZM2EXv96YZwZCIAu2jtAEBx1976P5Gw/IXb
	UxT9bKEDb2r5mCN7ofGIyqHCCqfEB1Za3qBFUtNPyEGSVzMzeUKA/5/hPHQpoLWhGHiQEKO
	zPhWdANIariHWPoaKe7KcaDzNBmxdOowlxYV1jNXWNhCjsHT+vK5sHry57iW8/E+tlIG7mh
	QIdrLMEOQz4W5ItepQ9f3rmKYgqU38/qp2YHn0Tcakv+WDqZxqVkR/3d2mHRPTN0je4Knzt
	ix5b502UmcvGd2iE+M6zM76xpnB+dcmy56s2n18BUesLTp7+wsifzCmncyw39JwTHJqU8IA
	nDEEWeAc6qj+EpJR/UJto6+pamenNTYXYkV/I1p9ypgolD6PP9YEclcjl5WMhjWB+SQvhiJ
	+pAkW8G+KS2lQD6VPjdYy6mKxdnX+BJoqUqHIhmWD3hvmjSmQ/EhAQNvmuPRGLWRNs9Csuk
	rV1Zad5D9kxS2H6hpvCYPbK7+6EO9J0iTQuDGuld03VgGwBF0InZwdwJjw0UCYy7zfX7Mtk
	8WfDJqZlbtNQ6eeD19WhlCQB03bfQRK3HsPVPYum3B3K3MNF+jVHlYTQIgig326VMyzrSSw
	+olHhfEY99zR7cCv/zwS8xHCI5S2SnixoBM1RwmdU9nzKVn51FMFbI+WlyLNDiTbIreE0pS
	8LMsSZ1BtWQEu+Sx0OJ++XhGUYeOkaXcnA3xcQfHKkkuWpnrckLJIPPgaijlEj/eYzqmvdC
	oxR6RM7vnwoYuscz5fu3aj2sX0kiwLVg4paHY0gFZ56wXJetojkCMUXpaFlwEhOjW1YmoEn
	KD56XNYW6rCQGFZIULRptfTgof08nZHivwa2LQHz9Wb5AncYzV85K7ik7YlfjjlVhl5owET
	pvyMIXky32NaNCVR5sl8UAgCZeCKmSnbNeSUJc1GywUVnCgVVDfwURRS5RLEWuR0eHmyUCQ
	w==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,uniontech.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253722-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5813C5B0FC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The VENDOR_CLASS_DATA_IFACE and ALWAYS_POLL_CTRL quirk flags added in
commit f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10
INGENIC touchscreen") were placed inside the acm_ctrl_msg() function
rather than in the header with the other quirk flags.  Then, their
values (BIT(9) and BIT(10)) collided with NO_UNION_12 which is already
BIT(9).

Move the definitions to drivers/usb/class/cdc-acm.h where they belong
and shift them to BIT(10) and BIT(11) to avoid the overlap.

Fixes: f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog:
1. from RFC to ready.
---
---
 drivers/usb/class/cdc-acm.c | 2 --
 drivers/usb/class/cdc-acm.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 54059e4fc6ed7..ddf0b59638595 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -114,8 +114,6 @@ static int acm_ctrl_msg(struct acm *acm, int request, int value,
 	int retval;
 
 	retval = usb_autopm_get_interface(acm->control);
-#define VENDOR_CLASS_DATA_IFACE		BIT(9)  /* data interface uses vendor-specific class */
-#define ALWAYS_POLL_CTRL		BIT(10) /* keep ctrl URB active even without an open TTY */
 	if (retval)
 		return retval;
 
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 25fd5329a8781..01f448a783c03 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -115,3 +115,5 @@ struct acm {
 #define DISABLE_ECHO			BIT(7)
 #define MISSING_CAP_BRK			BIT(8)
 #define NO_UNION_12			BIT(9)
+#define VENDOR_CLASS_DATA_IFACE		BIT(10)  /* data interface uses vendor-specific class */
+#define ALWAYS_POLL_CTRL		BIT(11) /* keep ctrl URB active even without an open TTY */
-- 
2.30.2


