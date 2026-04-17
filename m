Return-Path: <stable+bounces-238475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCjICzAQ4mkg1AAAu9opvQ
	(envelope-from <stable+bounces-238475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:49:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C141A6AF
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0885130F8230
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEEB3346A8;
	Fri, 17 Apr 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D98juoyW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953F2DF6E9
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422805; cv=none; b=KLnYxd9sPfQ8WSuiFI9K30TwqWkdFkAHxgFnvDL5ng3ZRoxqoX+COKz8Br83FbJXhadbpjVMzlZ3xLiYa4kUk87ha6HY2sZB3/K2FQRYVYB5QPKoDcUS78eqRHkJ3xs1HFvI3F8cEkrkbuFY9N1ThjTfZR+TH3W7PAPG5UuA9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422805; c=relaxed/simple;
	bh=xxPE7p8J+Km72Fu9cE2Qxt25fuNU7Me/NosNShaHNjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRnYVlXJhKx4YgwgItQCuokwYv9a9bjznemsbgNLY164e8d+aVsOGZeEgFgfff0Ont6PWbr7jNGrdQH6v/F2FpSMfpRdImvPuq+JnUZoX3T4JDNacgsN09acbAnw7dLjmLdbpdKEIuwGWZGAGJ3wYkyJpHFON5gY6DF3f6LH3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D98juoyW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d74086e5bso480257f8f.0
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776422801; x=1777027601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNXTybxJ7WUCuHtax9bzQlVrZGGr1HrE+ejN+oTzKns=;
        b=D98juoyWwpuagggfgPldpCLQTma6O2DSeNa0amhIguhyD4ZAon7rSMtBELy2OEPrJ5
         WUmg1o3t6nnm9+0IotJoLynClIGT3CAWVNaJEMwAIcG84cG1s7qExFqR3aBMPyMlx97s
         ptVceuYlyMBagQN6WuSD3t+RPyBj3Jg/fw/zGdouRpBD02kdSjJlorTWHmqXYAVPJmc/
         GnxtfkCcNyewVwgEtIGIBjdYeeA/KgvqYjUPLfPkKRL7oy9t9nn7Zm8cJjrWUJJG1e45
         nPsCLH8UX9I5sgu5/ftK93rIvyn8s82vphtkq1+usJuNn4uAE9W7o/ftKnarLdmnDz/q
         OjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776422801; x=1777027601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNXTybxJ7WUCuHtax9bzQlVrZGGr1HrE+ejN+oTzKns=;
        b=o41bIG0osp8umkZ6WRG1kSgf3B/nPgV6wQiWvxkfLYsdykiUeGJXC9q9Frw13idFSF
         F7jLSeTHO9WaNHepbR16/0uWbcLzxj6BVHnu4U6F+4zyctodJOuaeomeF9SMyruqR8aH
         Em6TNX1TMwyldS2tLxUoarLZ18fwhQDe5RxS/0Vl77RjV+upLGBHAgc/yvTXHNFnWt47
         5+0nwnAQHRYxxe6oFswAjn5z2nQ5mmmnYofJimo6yslTBDPU+qoYyNsiphOj+cdvHtjx
         Bj3fdWLvgV14FrjEOK6N38qnXoKfY9tckB5HT0DO56RDXOKE0d114ky1a+cPlzInnq7T
         0+gw==
X-Forwarded-Encrypted: i=1; AFNElJ/Td7VeHtiNU09A1MxfIlAPdMc+2z/1Y/fCAkO8mT5D6WVFqaodMIbyNISlzxK8UEnF1lRiXzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqY4GHNX1KCIzLR+Hr29u1LaQGx8TIblcNcGhFtHs/vveZENuq
	qC8XcrK/jfO8qsITf4+sXRX7inyUwwzFNMrMCPEcJNN1f+JmgFpF/dk=
X-Gm-Gg: AeBDiesornrFvQR4Yy/rjE/JclxoxkGD1Hmzyg3KdTA318LKh/mgHTzL9V9Qln9qcnP
	wSGcSy4GPkNCaQITaXvnZ1Ejg5e8/977jpcEGenTCn+t+3H4vCCT99NupfGj30bqaSETpvcwe0U
	PoDa84XMJqc1XXpBTzfDPUeuKvaoTPwMExttNxWivb8cwpIituHPl13WdR02a7vDe3TaHc72QmQ
	pY/vP/nIuwu5XAITBmKHM4nZv80CjMJcSKUdkiubkX7eJyxZ+1pNQasxQB6CSe5LJS2VsahP9+n
	48xeS5wMP7eWSbOk2NgBlFmRwK1mKFS/nVvcRt5+vcvMRkzQ+auI55ZenJsuqtkg5ayUGpkNlMw
	J0OgS5Y57nI3ZcjRX+y5xZK42i/12x0t3qw+/+vOFARK2ny17jyUAxd/j7I38yk1+V7wJQ2//dk
	Uat3U=
X-Received: by 2002:a05:6000:2387:b0:43d:7c91:49c with SMTP id ffacd0b85a97d-43fe3e255ccmr3448516f8f.44.1776422800911;
        Fri, 17 Apr 2026 03:46:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm3699809f8f.8.2026.04.17.03.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:46:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	sven@svenpeter.dev,
	marcan@marcan.st,
	asahi@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event length in completion ring
Date: Fri, 17 Apr 2026 10:46:39 +0000
Message-ID: <20260417104639.2608008-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238475-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,svenpeter.dev,marcan.st,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A35C141A6AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled entry->len is used as the memcpy size for inline
payload data without bounds checking when the PAYLOAD_MAPPED flag is not
set. This causes out-of-bounds reads from the completion ring DMA memory
for the HCI_D2H and SCO_D2H transfer rings.

Add a length validation against the completion ring payload_size.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/hci_bcm4377.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 925d0a635..5d2f594c2 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377_data *bcm4377,
 	msg_id = le16_to_cpu(entry->msg_id);
 	transfer_ring = le16_to_cpu(entry->ring_id);
 
+	if (data_len > ring->payload_size) {
+		dev_warn(&bcm4377->pdev->dev,
+			 "event data len %zu exceeds payload size %zu for ring %d\n",
+			 data_len, ring->payload_size, ring->ring_id);
+		return;
+	}
+
 	if ((ring->transfer_rings & BIT(transfer_ring)) == 0) {
 		dev_warn(
 			&bcm4377->pdev->dev,
-- 
2.47.3


