Return-Path: <stable+bounces-223441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLUlJIMRrWm8xwEAu9opvQ
	(envelope-from <stable+bounces-223441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 07:04:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB422EA5C
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 07:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20FF3014133
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 06:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE8293C42;
	Sun,  8 Mar 2026 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6VPjo9B"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4E267B89
	for <stable@vger.kernel.org>; Sun,  8 Mar 2026 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949887; cv=none; b=NvCKYoKpDX8PEor7AZWNCUop+4oszah6+c9RmGCcWsAVp5QE2fFRxOq5ka0OZL+nsRRUbs87RcOpn95CjqfQwR4dgk+i7xxYQcLAGfg7eVklQEI7la0S4ycEePAOwo0G/JUUx99W+m81MRnzm96AN91MeVt4LL2Wtf8ee0Z2Dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949887; c=relaxed/simple;
	bh=Ko28LLLxZOaYbbCwlWUcoPQfzS4gJiS1IRs5ERZupuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j71c1YEq1/Pr05ArtgPr8g/7BXEFePWMBVJtzCy1KEBkpuC0ICWLBESKCU60YuqoVC0sm5xVGMBdZetFhpGyfmfs0s2BXPzUx38AxxgZI+ifMyH0GbEELqgRH6Z9LqY4uzmUo3J0mF6jD6wuHovlLBwLnoQguFB6JnCv4nHiQys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6VPjo9B; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-793fdbb8d3aso128697667b3.3
        for <stable@vger.kernel.org>; Sat, 07 Mar 2026 22:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772949885; x=1773554685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYUTFHub9G2d8jZBvG3bgA1o3lA1GsQbn2lmvR17SYk=;
        b=e6VPjo9BuH8jJXgBBoGdM9f5VmRXzAd78a4mCRsxByFoDSSBPagLqkecgOCVakKt6l
         5tEHzbJiCivoHVRrkdrDJDtEeLwS+1D5IANuaQRGXeJlAf18Qtf/ojeguwpoGI80XowQ
         xGjC7J+s7vCYKJeupXqRlYaZ5oRQ4L0Ykemx/51C40ckYtzwuQ6MGVhusudQQc15fmrr
         7RIg8Cx2JCoQ45FIf67tJyKEKSfGk02aE6UNBNkGOGjJM4vauqGYNdgLBhBt46j+sRtn
         cXi3hMzz9IsR8sQ+iZSIEOGu7hCiL68icNRajlqV4d5c+7B9y7ICCEF9ha/o++1dla7d
         ffcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772949885; x=1773554685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYUTFHub9G2d8jZBvG3bgA1o3lA1GsQbn2lmvR17SYk=;
        b=XhYcrEpZ7VuGajG9macbQZycb7o40X/zlG7gt54hUrriK3jqs9JWXXPRW9KX+fusL5
         429J7skphKlz+ZOv4egDOQhrrSn4pvI50wFFsPEsMi+0Io3W32BMYtDYT7sdkepFEyym
         QYLcrlXE74LkVo+gTCytZkEECLWi0amaTwUj78/igHxREjKrHfPV54w5ejNESv3MzN9k
         416zBlurJC/AuavZI7sUUm7fdRGE8s/YAXb+mlJxlgIHnhhn8xevnRs8KCc9oz1n0aHP
         pVMibFv681TH/+5obPWG2VpMUXA11ss0Elr/ZYL4qcJ9vxTtBF8mVeIE2L6EhfLOocpr
         yf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiJpvNGa3KH5GKErhxiMo0FhkbW/b9pGMfuQNdQN47TWT6LASFGw3otXZPaHB5p28gkGVcQ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZtFHBREw31KfTPoqpvPmNrTNsEYsNh879JpvGOBZobVyeWTu
	iqYDSYxSLW0lXRzZ6smvJd4L4GkCH2yYJHg54S2HCQKiqOfCIgiUl2kC
X-Gm-Gg: ATEYQzy67Xz4aCWvNwb8WCarVQX8lSp7ZLvrc1ODBcT1o9wBcSQpkkfkCt5ot2Etvy0
	WpdQViPJLCpWeQBiJ62rICTNtgjizKIzy8/tge5eM+S4LS6esq5Qe3S6c3ho56VhbG1OzLWppOp
	o9Gw9ADVw5vJ5E6XXANp8mZbA5eI+jXt+sS+4/swsIT+uFqKz9CfwxWnSBBYbPCA8y2/nZB22TI
	RQ9fN/oF22YqtQqNVNQg9xCNedG/MQTRFWedbywXQ9shjryznon0iGP12Jku6WG0ESXM6DtGgwG
	L70OaWRUSgH847DvxGf7DUUSLO2/UEVrXRcZdkAAkIPlSgJzRjCG2tsw5+SeizVf/qsQwcgFrv4
	F7ngJgFOjeE9BDKCcBLinarTilZKQLnVLONn4jxMyHuVQzlAIHu6DjUMRo+kJv+NWE83Ijrpv6B
	gFg4f8mzRFRYxOhqp4ZUfonpYNyXssJyhDDKZeFgDLnq3O12a5bmVUEK20NGze65N05Llq2V/Ca
	sg0
X-Received: by 2002:a05:690c:660c:b0:798:7019:fdbf with SMTP id 00721157ae682-798dd76ed98mr71325687b3.31.1772949885548;
        Sat, 07 Mar 2026 22:04:45 -0800 (PST)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dec8b31bsm29417947b3.1.2026.03.07.22.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 22:04:45 -0800 (PST)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ychen@northwestern.edu,
	danisjiang@gmail.com,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] ibmasm: validate MFA offset against BAR0 size
Date: Sun,  8 Mar 2026 00:04:10 -0600
Message-ID: <20260308060411.258298-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08EB422EA5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,northwestern.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-223441-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

ibmasm_interrupt_handler() and ibmasm_send_i2o_message() dereference an
MMIO pointer derived from a hardware-supplied MFA offset without bounds
checking, allowing out-of-bounds MMIO reads and writes.

A compromised service processor can supply a crafted MFA value whose offset
exceeds the size of the mapped BAR0 region. The driver passes this
through valid_mfa(), which only rejects the sentinel 0xFFFFFFFF, then
immediately uses it to compute an MMIO pointer in interrupt context.
A malicious message_size field can additionally drive
ibmasm_receive_message() to read further beyond the end of the BAR.

The root cause is that get_i2o_message() adds the hardware-supplied
GET_MFA_ADDR(mfa) offset to base_address with no upper bound check, and
incoming_data_size() trusts the hardware message_size field without
clamping it to the remaining mapped space.

Fix by storing the BAR0 length at probe time and rejecting any MFA whose
computed offset would place the i2o_message structure outside the mapped
region. Also clamp the data sizes passed to ibmasm_receive_message() and
the outbound memcpy_toio() to the remaining mapped space so that a
crafted message_size or oversized dot command cannot drive reads or
writes beyond the end of the BAR.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: ychen@northwestern.edu
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/misc/ibmasm/ibmasm.h   |  1 +
 drivers/misc/ibmasm/lowlevel.c | 33 +++++++++++++++++++++++++++------
 drivers/misc/ibmasm/module.c   |  1 +
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasm.h b/drivers/misc/ibmasm/ibmasm.h
index XXXXXXX..XXXXXXX 100644
--- a/drivers/misc/ibmasm/ibmasm.h
+++ b/drivers/misc/ibmasm/ibmasm.h
@@ -139,6 +139,7 @@ struct service_processor {
 	struct list_head	node;
 	spinlock_t		lock;
 	void __iomem		*base_address;
+	resource_size_t		bar0_size;
 	unsigned int		irq;
 	struct command		*current_command;
 	struct command		*heartbeat;
diff --git a/drivers/misc/ibmasm/module.c b/drivers/misc/ibmasm/module.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/misc/ibmasm/module.c
+++ b/drivers/misc/ibmasm/module.c
@@ -96,6 +96,7 @@ static int ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!sp->base_address) {
 		dev_err(sp->dev, "Failed to ioremap pci memory\n");
 		result =  -ENODEV;
 		goto error_ioremap;
 	}
+	sp->bar0_size = pci_resource_len(pdev, 0);

 	result = request_irq(sp->irq, ibmasm_interrupt_handler, IRQF_SHARED,
diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/misc/ibmasm/lowlevel.c
+++ b/drivers/misc/ibmasm/lowlevel.c
@@ -26,9 +26,17 @@ int ibmasm_send_i2o_message(struct service_processor *sp)
 	mfa = get_mfa_inbound(sp->base_address);
 	if (!mfa)
 		return 1;
+	if (GET_MFA_ADDR(mfa) + sizeof(struct i2o_message) > sp->bar0_size) {
+		dev_err(sp->dev, "ignoring out-of-range MFA 0x%08x\n", mfa);
+		return 1;
+	}

 	command_size = get_dot_command_size(command->buffer);
+	command_size = min_t(unsigned int, command_size,
+			     (unsigned int)(sp->bar0_size - GET_MFA_ADDR(mfa) -
+					    sizeof(struct i2o_header)));
 	header.message_size = outgoing_message_size(command_size);
@@ -60,12 +68,25 @@ irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id)

 	mfa = get_mfa_outbound(base_address);
 	if (valid_mfa(mfa)) {
-		struct i2o_message *msg = get_i2o_message(base_address, mfa);
-		ibmasm_receive_message(sp, &msg->data, incoming_data_size(msg));
-	} else
-		dbg("didn't get a valid MFA\n");
+		if (GET_MFA_ADDR(mfa) + sizeof(struct i2o_message) > sp->bar0_size) {
+			dev_err(sp->dev,
+				"ignoring out-of-range MFA 0x%08x\n", mfa);
+		} else {
+			struct i2o_message *msg = get_i2o_message(base_address, mfa);
+			u32 max_data = (u32)(sp->bar0_size - GET_MFA_ADDR(mfa) -
+					     sizeof(struct i2o_header));
+
+			ibmasm_receive_message(sp, &msg->data,
+					       min_t(u32, incoming_data_size(msg),
+						     max_data));
+		}
+	} else {
+		dbg("didn't get a valid MFA\n");
+	}

 	set_mfa_outbound(base_address, mfa);

