Return-Path: <stable+bounces-211331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKV0OpHxcmlrrQAAu9opvQ
	(envelope-from <stable+bounces-211331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 04:57:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 619B470363
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 04:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 566E23013B45
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 03:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58231D366;
	Fri, 23 Jan 2026 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEg3H/Jc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FB38B9B7
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769140620; cv=none; b=B8Q4g9yzlvDR8m/bmJxFLtPPFEKsRygu3bkVEyp0x80YYJclofA1y8cpFwZX//4+EkWX0yGQ9cnJd7Q0qeKizSQAt/c7iw33ltnn/V7VIlHVUQNnmW6AoPm2wVBDZ4ol+SgnBJ7wgbV2uuZ7BeIN5AcNnqVZnkDzfZpjPU6lvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769140620; c=relaxed/simple;
	bh=9IkWk7ZurIDOgZSoVU/ErgeaZNfgE62rKwgWKZ2gMQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mVWSL3h4iMrjGECc5xBGXRO2lCnM51vXPvCLW/HdCIs0T1beb7r91atsVPxbPJ+gyZTIKp4buo1atCjdLD/33plKir2qSef1WbL7zzRB7i/1AtbPqvUqBehuQ08kpzqRu5ZnhQqnH0XULAN3XDrDOj3Nj1s8Sfd/phn11a65tVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEg3H/Jc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8230c2d3128so618502b3a.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 19:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769140614; x=1769745414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/otCFW7jCkMsv16Qri9tIeY6tMlxQmHzjcpDQaISHXM=;
        b=mEg3H/JcpB2yRs/VHxZ3ql0sAoabUgJquZJuCf/z1MMO8bPHUyU9q8DX3D+cyxZ9/6
         axp1Gc8OOCROeyZonK7U5+02RcKE3yBLMUyN0wRCQJpjX2RHThagPj3qGjys5psPrCyz
         9e2qGzihv8KUvUJaMEOyMqIoNZcNrwa3k0t1JMMyfrKcoHylv89USD2V42mCyPWjHwtg
         HEzIYYjJrI3ge1b4zTKdxTqe8ZhzvlEjO1Mllcv6bvsZprz+/IhAEMXq5+drZSuydlrp
         w7FBqG/lgNbMOesAZbofEAOhPVA1sk5PwsZvbmz+NevO3w1qGwai1lu2yxjc4ElwK5e3
         I9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769140614; x=1769745414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/otCFW7jCkMsv16Qri9tIeY6tMlxQmHzjcpDQaISHXM=;
        b=R6exFWJxkqAvHkJfjUuP7+TS94wajuw3fRxLU9OuG/UHvA4MY5c4I2zFgS7qh3NSD5
         KDdk5oXInUJVpmABZH06+kVUuonoBGM6v+xyZTadT2TxHKGVxM3NvaFGQNBrqgXcEnB0
         9WHmOIY4Q9/l/PvkN/w0hiEDc5aHWPplq6BQYZO+CC6GLDILYdmk1kVzONMitAutzh8d
         S9ddhML4qQ83mhnoOAi3/MNGHw1EE7SLsfjg1ajC+tU8Pj/zBvJEKuN4GrJMEjnd3gEN
         8DA8Jx+eWTSSNnnfzHyC8pgiNrt3wvA1Lvghuk8vN8zdiFHaLBgfUBonBiL5kTQ69RGW
         h5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXExGmfekP5wxULcNYaNZwrmM86QQcgMmhbbBD1UpAzQcajyKC34S/6rB/+znwteoHiBtJ367Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjMP7PcrYC0TBTA/9OUrtBzr92BONbsSx+t/yHL8zTPJGP5ad
	HtXKtCzaexpcykQLLrY0MUH8oOLHUikHqhukIZYwabTqf52JWDyvtD+V
X-Gm-Gg: AZuq6aL8wavHnt9xYDbB4VK9drEv6ZEnvcPX175kuHiw85uki6yvUPDW2jxiAL559oT
	VXxDv8HYcDB7Lujf/uUGRg3w72Cwzf0RMLGepegI5JP0rVtapT55FYG0d9wpgORPNQ5WsvyuS6V
	r4i0fxC0WtfQraKDC2BwdIO2nSvFsBebkL0dRbkmYjZi3LIOmb69stGU9AEKJ7aCgZTfxV6LrUl
	js4IksQevgP2vN2TFSyVFQ8d/gEcRFXA4V8jDlEqEWyj2y2yMeBhQ/83bZctZY7w3JewIb0N4fP
	oPY4a0iSH3onpflkYb6rjErb/pWipffsSsoVYmjo8ub+qopIj/sdDrmxtualFgWhrdoREIgzvSl
	lO9UcEjRocFWH6m+EyY9pggQ1+DBjJKcy/q/L+6H9KUkGRQHqTiKCIADtUZRcTPl3mbU6b0hi8Z
	YochJNlpECQl91zsDxZgVwMIZNFGkTWaMWUi1uXx3VeAXgj2rPwGZ2RVn3agy/Y1PoqYluKYx5K
	6ikB3AtlAGV+xxb+2FY+S27FngOHweEPosXxRKDDhNRhTA=
X-Received: by 2002:a05:6a21:69a:b0:35e:e604:f766 with SMTP id adf61e73a8af0-38e6f6a9658mr1638303637.6.1769140614130;
        Thu, 22 Jan 2026 19:56:54 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a424485sm688045a12.27.2026.01.22.19.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 19:56:53 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: jassisinghbrar@gmail.com,
	s-anna@ti.com
Cc: tony@atomide.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>
Subject: [PATCH] mailbox: omap: fix reference count leak in omap_mbox_probe()
Date: Fri, 23 Jan 2026 03:56:48 +0000
Message-Id: <20260123035648.1441763-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211331-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[atomide.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ti.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geoffreyhe2@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 619B470363
X-Rspamd-Action: no action

of_get_next_available_child() returns a device_node pointer with
refcount incremented. The caller is responsible for calling
of_node_put() to release the reference when done.

In omap_mbox_probe(), when the loop iterates over child nodes using
of_get_next_available_child(), several error paths return directly
without releasing the child node reference. Additionally, when the
loop completes normally, the last child node reference is never
released.

Fix this by:
1. Using goto-based error handling to ensure of_node_put(child) is
   called on all error paths within the loop
2. Adding of_node_put(child) after the loop completes normally to
   release the last child node reference

Fixes: 75288cc66dc4 ("mailbox/omap: add support for parsing dt devices")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/mailbox/omap-mailbox.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 17fe6545875d0..3f6af947e29ce 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -508,14 +508,16 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		int rx_id,         rx_usr;
 
 		mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
-		if (!mbox)
-			return -ENOMEM;
+		if (!mbox) {
+			ret = -ENOMEM;
+			goto err_put_child;
+		}
 
 		child = of_get_next_available_child(node, child);
 		ret = of_property_read_u32_array(child, "ti,mbox-tx", tmp,
 						 ARRAY_SIZE(tmp));
 		if (ret)
-			return ret;
+			goto err_put_child;
 		tx_id = tmp[0];
 		tx_irq = tmp[1];
 		tx_usr = tmp[2];
@@ -523,14 +525,16 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		ret = of_property_read_u32_array(child, "ti,mbox-rx", tmp,
 						 ARRAY_SIZE(tmp));
 		if (ret)
-			return ret;
+			goto err_put_child;
 		rx_id = tmp[0];
 		/* rx_irq = tmp[1]; */
 		rx_usr = tmp[2];
 
 		if (tx_id >= num_fifos || rx_id >= num_fifos ||
-		    tx_usr >= num_users || rx_usr >= num_users)
-			return -EINVAL;
+		    tx_usr >= num_users || rx_usr >= num_users) {
+			ret = -EINVAL;
+			goto err_put_child;
+		}
 
 		fifo = &mbox->tx_fifo;
 		fifo->msg = MAILBOX_MESSAGE(tx_id);
@@ -554,11 +558,14 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		mbox->parent = mdev;
 		mbox->name = child->name;
 		mbox->irq = platform_get_irq(pdev, tx_irq);
-		if (mbox->irq < 0)
-			return mbox->irq;
+		if (mbox->irq < 0) {
+			ret = mbox->irq;
+			goto err_put_child;
+		}
 		mbox->chan = &chnls[i];
 		chnls[i].con_priv = mbox;
 	}
+	of_node_put(child);
 
 	mutex_init(&mdev->cfg_lock);
 	mdev->dev = &pdev->dev;
@@ -602,6 +609,10 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		return ret;
 
 	return 0;
+
+err_put_child:
+	of_node_put(child);
+	return ret;
 }
 
 static struct platform_driver omap_mbox_driver = {
-- 
2.34.1


