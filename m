Return-Path: <stable+bounces-230624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIDyB9pfxmm+JAUAu9opvQ
	(envelope-from <stable+bounces-230624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:45:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC1F342CD0
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CE12308DCA9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F193B5832;
	Fri, 27 Mar 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DnmXdFBE"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FD3242B5
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607419; cv=none; b=Csvo6okGU4dZzQR6xmYvoRDRDQ433VGFfsqaRhSag/I+HEglVhVKFcMTl+pI6GLu7UV6EOfimlvfyBXKnXMX2vX8BFB9/3Fxo6h8oxQ14UKUXv5eklJAsKRj64vU8mnZZI17fsuBx7TY1hsWAXTpGIRyhXkBp3xW0aqt9K7sx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607419; c=relaxed/simple;
	bh=64M60AwjcV6uatdDjTxxzYVUns9b8w6LcXMyI46ym4o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=u82um6Jip9HsBjr34NI8HYRTEn3wnDDgw+TaTH+Dai4D9TqCcGTpDCrUiuOjwRclos82ZHe/3cr9PGQdnjPtXhgJGjaPN0yvWprTxLV4pHB3Jw5JFYQfcB4/VsIStVWfRBK6QTy+VWEQD96y8aJsrfShwyQmNEE07z2nFXZq2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DnmXdFBE; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774607411; bh=yJXSTfD4c5228LiZLBo2CcwvClvIlhe1NPGicQ5r4ik=;
	h=From:To:Cc:Subject:Date;
	b=DnmXdFBEjgxBfO0G43y6woHwS9Or5tVHQvK4jCrs0wj1/f5uoxB82E/F3SR0hmpoW
	 es3gtPVjOXKa3HmhyVOr0R17xdo5QMTxVxRba3UMBDcZr9gmMuIKHLoqRPnZt94A27
	 TqBIjn3fIUPMjexyCKeqyFAlwPZgp+Nd483cPZOw=
Received: from LAPTOP-KQCD4QBN.localdomain ([123.121.145.48])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7880A40E; Fri, 27 Mar 2026 18:30:08 +0800
X-QQ-mid: xmsmtpt1774607408t4h1uq9xm
Message-ID: <tencent_F0B755C48BEB67380BA88ADF22C96E1FC407@qq.com>
X-QQ-XMAILINFO: MehRKK+d4CIgSwYBsVbxIqKkpCCo/cv1J2GiSMS+9I7JY6bC5921+JTn+FcaTh
	 svSyAQp6zbLfAHfVtoqkhq+epMXZPk9GuFoWrsiafsSJhk2hJ+K+Al9/mWpp5visqwD4zpTFYe8/
	 STy3iU77PmdrcxebvNf9BkLBROviHp35kk7vAhFxvwzsnQ7tk/BUZ/pZQVWg2lRLDXnBuEPffay7
	 zCrMwXQzOg/XPS3dpTkqT65O9RpAKfEeqHqDY56IghKoFESzSOI2QCJVLFw5E4fyb78ZubxImLU+
	 5HjvNk6cTD/Xf2cq7iXJwWtGBlqtAgv/rmCjHvrGkbSgruALicyD/6yCGoClVYKvHc+SiBICG6LP
	 0cYpGoIxnxRy62VpFQ3uHv+KTTOrKdsoqZi1X2ZhozyiqssLgfWpvy52c7gke+xtx0LVOt+Ml2ac
	 dD+bZZA1Mb4rdi3BekvfwtGjIonK/2kimzEDOwtWARZ1lIBLG2HqxM8UTtWTmARaTuoRdgshIXqz
	 grTuR+g+cuZyG3SPDpSbtDkwJZz96g46JKhHhYPjWENV5sLD76upLQ6rg57S06l7w8wIyUTvnEMH
	 NQcfxrCjMKDRkOwTB+stVghCfXzqzkIzu5wabN5kE5OT37rfmvlfXm8nDmaeLPX+Updh8kt0gRm2
	 DDzAt7ov0gCBa2V0HiglVLPURbo2yS7ITSQnEVR095pv2kh1KB0hf0z+H/gCMH9xmER0wrGZqTzC
	 yeJJq4rXLeYBGICQ+4dya54bJPyng7VZkJfwmM0Z8ECzK3HJXo+kiAo3fq789yhzITbisQnqDIgM
	 uHUd2tCfllSS257yjapK1d5CP/APG52yayCaiblirSscpIdLAyZGbqdL9Ko5DrkHhfk3oMCOxUTu
	 5cGmtYJS8jQsLmbI4Hfz2x0prhEjxX5LqjeX6OVcg89Qo3znSA6G/1iQ76SVaszQIdyhLc3NAIhy
	 DL+3H+YaOgI9l9VRoJZ9o7gjci+bn8gur0i5i8pP+/SKLC7Xw7UU3Sb668vaub6piaqFI6yXVMz9
	 edD67bMhqgoiuMxR2gDEENkESE+BGf+fWfO34dVClX7YtTWec6cNvwycNZiAof4c1o1TeXpHl+3S
	 BvhiEGmyTM1pLlXbylpG1JTbX/6YixVFq/4Sni5nWKyDBCo/yZD6DkyVyU02dbFOewBuqS+s6L2j
	 GIqzE=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Wenyuan Li <2063309626@qq.com>
To: Andy Walls <awalls@md.metrocast.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sean Young <sean@mess.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	Wenyuan Li <2063309626@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] media: ir-i2c: add error handling for I2C send in get_key_adaptec()
Date: Fri, 27 Mar 2026 18:30:06 +0800
X-OQ-MSGID: <20260327103006.25736-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230624-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mess.org,vger.kernel.org,web.de,bjtu.edu.cn,qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2063309626@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: 8FC1F342CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In get_key_adaptec(), a command byte (0x00) is sent to the IR chip via
i2c_master_send() to initiate a key read. However, the return value of
i2c_master_send() is not checked.

If this I2C transfer fails, the IR chip may not receive the read
command, causing the subsequent i2c_master_recv() to read stale or
invalid data. The driver would then return 0 (no key) without logging
the error, making debugging difficult.

Fix this by:
- Checking the return value of i2c_master_send()
- Converting partial sends to -EIO while preserving kernel error codes
- Adding dev_err_ratelimited() logging with %pe format
- Adding similar error logging for the i2c_master_recv() path

If the send fails, return 0 to maintain the existing behavior (no key
detected), but log the error for debugging purposes.

Fixes: e1e2c5756563 ("[media] ivtv: Add Adaptec Remote Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Wenyuan Li <2063309626@qq.com>

---
v2:
- Add error handling for i2c_master_send() as suggested
- Extend checking to i2c_master_recv()
- Use dev_err_ratelimited() instead of dev_err()
- Clarify error handling behavior
- Drop incorrect Fixes tag

---
v3:
-Add correct Fixes tag
---
 drivers/media/pci/ivtv/ivtv-i2c.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtv-i2c.c b/drivers/media/pci/ivtv/ivtv-i2c.c
index 28cb22d6a892..c011f2246add 100644
--- a/drivers/media/pci/ivtv/ivtv-i2c.c
+++ b/drivers/media/pci/ivtv/ivtv-i2c.c
@@ -138,11 +138,28 @@ static int get_key_adaptec(struct IR_i2c *ir, enum rc_proto *protocol,
 			   u32 *scancode, u8 *toggle)
 {
 	unsigned char keybuf[4];
+	int ret;
 
 	keybuf[0] = 0x00;
-	i2c_master_send(ir->c, keybuf, 1);
+
+	ret = i2c_master_send(ir->c, keybuf, 1);
+	if (ret != 1) {
+		int err = ret < 0 ? ret : -EIO;
+
+		dev_err_ratelimited(&ir->c->dev, "i2c_master_send failed: %pe\n", ERR_PTR(err));
+
+		/* Preserve existing behavior: treat error as no key */
+		return 0;
+	}
+
 	/* poll IR chip */
-	if (i2c_master_recv(ir->c, keybuf, sizeof(keybuf)) != sizeof(keybuf)) {
+	ret = i2c_master_recv(ir->c, keybuf, sizeof(keybuf));
+	if (ret != sizeof(keybuf)) {
+		int err = ret < 0 ? ret : -EIO;
+
+		dev_err_ratelimited(&ir->c->dev, "i2c_master_recv failed: %pe\n", ERR_PTR(err));
+
+		/* Preserve existing behavior */
 		return 0;
 	}
 
-- 
2.43.0



