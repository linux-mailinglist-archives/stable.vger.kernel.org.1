Return-Path: <stable+bounces-223641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPXyAvHIrmlwIwIAu9opvQ
	(envelope-from <stable+bounces-223641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:19:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F286239966
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24AA3080105
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ADB3BE140;
	Mon,  9 Mar 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l6hf03QC"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAF3ACF05;
	Mon,  9 Mar 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062231; cv=none; b=eAvZrdASS0Blyxfxd7Lffd9Bmm2s8n3Wv6/0u3xgEd1d+oELin+LyarRofnCD4eRf9RimJo0hGDgWshnbGfcLRSg0ddCNOoZ3KIi+H/I4e5z6K4DSDsoq1ZbRKpW9iOyS420k0ISJijn99xlJ9WX1izXWTMhN1O8/EC4Q+p9zJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062231; c=relaxed/simple;
	bh=RKoyo7RMz3/YQRwmDlXhfMArYW7/3ssEoMVev5fyzZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NCViZS71dSqPVtfrcZ4weQL1ycghrjALqciC6axNtMRmQ7ABqohQMbY4reEgdwPomb1aeZvauOi+GUMS8rfvabMUbJ2yVPgwYHhE2K/Au4zcVvb40U+xGu5/RNmrgjZtqAxVHpEnZzqX43iaSbwdHeCjAvtJ28zrIR4bJmU2uH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l6hf03QC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C4FF4E425CD;
	Mon,  9 Mar 2026 13:17:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 453DC5FFB8;
	Mon,  9 Mar 2026 13:17:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECA6610369BD0;
	Mon,  9 Mar 2026 14:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773062225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=PWeS/hOtT8h9N4UZcc3/uATtueWAS7bdyfFCG1w2gHY=;
	b=l6hf03QCoEGT5WEjmqV6l2oKV3RmK3wcRM/oJOA8dg97iYxZgriC3ZoB2+UbYsq5xGvsfw
	af0wOe8YHuNm6AgTW671qiFU4A33JpsfEPMZzu52JC6Fmgj/gJGesPUkzGkwc0XS434Qkk
	nd2nOqtJnXwnDIbv9KqNXfZ3dYuIFERY1U4ks1g+DlPY69cFkBEgPQuPMp1S/rOd/q5Lhw
	yhJPfhLhOI0/YYLsva5IaHHfGECNRUr8Vvy2sajFUhnGaVwpTk/URHjsMT5Dm62xLgZcd9
	00m/ioYk+jfZNNvhJVZf2RVRiaauhM2aAiII2wVP09VPwOJ4jZg0gamINfzCrA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 09 Mar 2026 14:15:43 +0100
Subject: [PATCH net] net: dsa: microchip: Fix error path in PTP IRQ setup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAP7HrmkC/x2MywqAIBAAfyX23IKP8NCvRAfTrZbATCWi6N+Tj
 jMw80CmxJShbx5IdHLmPVSQbQNutWEhZF8ZlFBGaGFwyzfGEpHTgTNfqL30xrmps56gVjFR1f9
 xgEAFxvf9AEkTT9pmAAAA
X-Change-ID: 20260306-ksz-ptp-irq-fix-3d1d6ccb4ade
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8F286239966
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

If request_threaded_irq() fails during the PTP message IRQ setup, the
newly created IRQ mapping is never disposed. Indeed, the
ksz_ptp_irq_setup()'s error path only frees the mappings that were
successfully set up.

Dispose the newly created mapping if the associated
request_threaded_irq() fails at setup.

Cc: stable@vger.kernel.org
Fixes: d0b8fec8ae505 ("net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 4a2cc57a628f97bd51fcb11057bc4effda9205dd..8b98039320adda7655ae2563b896b92033d2f1ad 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1108,6 +1108,7 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
 	struct ksz_irq *ptpirq = &port->ptpirq;
 	struct ksz_ptp_irq *ptpmsg_irq;
+	int ret;
 
 	ptpmsg_irq = &port->ptpmsg_irq[n];
 	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
@@ -1119,9 +1120,13 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 
 	strscpy(ptpmsg_irq->name, name[n]);
 
-	return request_threaded_irq(ptpmsg_irq->num, NULL,
-				    ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
-				    ptpmsg_irq->name, ptpmsg_irq);
+	ret = request_threaded_irq(ptpmsg_irq->num, NULL,
+				   ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
+				   ptpmsg_irq->name, ptpmsg_irq);
+	if (ret)
+		irq_dispose_mapping(ptpmsg_irq->num);
+
+	return ret;
 }
 
 int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260306-ksz-ptp-irq-fix-3d1d6ccb4ade

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


