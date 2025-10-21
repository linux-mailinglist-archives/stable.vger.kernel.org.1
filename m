Return-Path: <stable+bounces-188283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB804BF45A8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 04:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A344035FE
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0780C2741CD;
	Tue, 21 Oct 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtX9FdGO"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48326635
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012507; cv=none; b=P91KuqbGrLMXZw8SAlDwtvSvUO9tF0j48ecqa4aQsB3nmBNjhXRnR+5gBZIVUZgHyYRWRl0iULrO3tFVXhsxvIUY3A70l4YE5ORyTcsrlamr/gSZ6aauxC8vgzCvxFf95Cjy2t+bIMpUSrbzGDCgc/MVfnPn+7PzHGtfTWj+tPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012507; c=relaxed/simple;
	bh=lMDSCfXDFAAsG+lJ4/PlhyxArZIcaelWaaU9/c3MB38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gJ9mDiDBS9dgHv0AvnXs7tAWpu44buYgwc1B1peZVqQIC13PDSd/pNrykwNw6C1zTcfjhG/mefAcS8/84QrM3qNhu6A4Q/Kt4v6/VlgqjyWU/tPARYXI3shzkjMuFYTzTpHXhxMd312+oy4A7LqyP1jkkFX3RP0c5dbzwfmWbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtX9FdGO; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93e817d3ee3so331853039f.0
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761012505; x=1761617305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOPZINqJ1ZYn4I38TToVeVJycFqUKIHAHcONMbNzpkE=;
        b=gtX9FdGOS19dGYoNZoNHibe9hbAxWl9rAFyhotY/7l1eKeWZyyIc42LUzOmtNwef2J
         jGeQVmiHKjaboCdJGfmv12VM8sodRZvKLwWpMSTQiUpwHp7ICWK7+2Up06ummDt2+ppB
         rsjhhUYIgrLpeFxnV3bBGzYXnS+ZDUghFRsPhuhu9YewrwMuiwtN7v4DNuuAu0SJqkgw
         JYsigoxmJl5BumP+QiSwu4DPIPrZFk2T5OgL/2MvPPZCBp4O0elnQgXvSmMhAhPx1HSk
         kRsXEcyfq9rc44xdKjmgdBPFEMkyVlD3E9oNU/mBMg1adOmScNaGWzXlbnm8BHXhT2Cj
         4QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761012505; x=1761617305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOPZINqJ1ZYn4I38TToVeVJycFqUKIHAHcONMbNzpkE=;
        b=Qx+sn57gTITsBhWXeKXzhmKetIA+l3Wwj5cwtCE/petl/gHc8OtSj15DuXBx1hofLo
         VDdH4HPP3NERKTtbGEVmKo+/Ugm2ZRG93axTwg/ato02vKxPJQ6eNj+yPq2p8O3WWyJ1
         l/+ipA0W3zq35AKSUXARRYEbyIVpPtJQu/t4o75sCfZXpn5YU3kpylimxg/4w5LiCKtZ
         hZ0k1LjpkJitDuXxmOwSZd8c4AVlNUyTElu+RyKUrpkp49V1y4b+QRner/AoySbdCCnl
         slB3mqKOOJ6Fu5bboraOXTP8TC2h85b26tXowCPVumx5lzxqQmmEV5t6OZJNnxH+nSpd
         xUZw==
X-Forwarded-Encrypted: i=1; AJvYcCWa5sZ3jj9GT49vLoA7dIl/MRay0F8mgQXFq8lN4o8lV4fzA032keb7URSdhuFY7eQurGVhJVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmaQPxC1cmmDy6FXoFsiyVC58Fpg2tJXdjst0rfJf/epfLR5sj
	F50qlYU6fj/S2MSZHl/LpCZHuyWuoAyehc8LhZkdmyj+04jJ6zo85ztW
X-Gm-Gg: ASbGncsskkRd515yLHa1k4Sujylkt/GCzZBfAzlZcHMCPfdr5f85YyIWYyz6KMnMDjv
	jxvRF/mB6285GDIdUfFRno/No9IqRk/cQB0Z7BDGssa5emXkbR1BeaNRrzS1c9nsFptLis3Gmx0
	ZHxGvMH4hdGQLsXBPp33VqB8trq8lAkhBe99WnK3617XEHlYitxztaWyWTvgzMKIv0l0TW1CBYL
	W29LXGrMiSTmc3p+P7a/DI73UbXUj8bfT0xOV/hOziqp1Ga9ovSXmBQ0F9Nqr8B2N79bSfJxX5P
	P/KdMjXCZ3RWKb3AJZgysdPc7T3mKZ1mYjvvf8HFuALV4mO9atCVlOYASObO6otNhSzfLTKwqLx
	8cZHgwB0Z9maj4r9ndtkou5hNJ79hlQacz/O/oc0paS13kLEcZNul+PFAyCn84jD+U9INP1v6ct
	tPgcMagDP5i5Qx11TTIBUtmqtygHrI2cYzfI4h9vK9Vz1lKZ1mwALZzEEsExwOYmuYvFDmyoEW4
	s4E
X-Google-Smtp-Source: AGHT+IHxMaRrHMYn6K2NMgEXSDVxYWRsu+Ax0RcX2EKq6KdEsQ4xITeLkd7KXFChEkdLb65yRzCBzw==
X-Received: by 2002:a05:6e02:148a:b0:430:a013:b523 with SMTP id e9e14a558f8ab-430c52aa249mr247916055ab.25.1761012505291;
        Mon, 20 Oct 2025 19:08:25 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97699f4sm3556852173.51.2025.10.20.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 19:08:24 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: wd33c93: fix buffer overflow in SCSI message-in handling
Date: Mon, 20 Oct 2025 21:08:04 -0500
Message-Id: <20251021020804.3248930-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A buffer overflow vulnerability exists in the wd33c93 SCSI driver's
message handling where missing bounds checking allows a malicious
SCSI device to overflow the incoming_msg[] buffer and corrupt kernel
memory.

The issue occurs because:
- incoming_msg[] is a fixed 8-byte buffer (line 235 in wd33c93.h)
- wd33c93_intr() writes to incoming_msg[incoming_ptr] without
  validating incoming_ptr is within bounds (line 935)
- For EXTENDED_MESSAGE, incoming_ptr increments based on the device-
  supplied length field (line 1085) with no maximum check
- The validation at line 1001 only checks if the message is complete,
  not if it exceeds buffer size

This allows an attacker controlling a SCSI device to craft an extended
message with length field 0xFF, causing the driver to write 256 bytes
into an 8-byte buffer. This can corrupt adjacent fields in the
WD33C93_hostdata structure including function pointers, potentially
leading to arbitrary code execution.

Add bounds checking in the MESSAGE_IN handler to ensure incoming_ptr
does not exceed buffer capacity before writing. Reject oversized
messages per SCSI protocol by sending MESSAGE_REJECT.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/scsi/wd33c93.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index dd1fef9226f2..2d50a0a01726 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -932,6 +932,19 @@ wd33c93_intr(struct Scsi_Host *instance)
 		sr = read_wd33c93(regs, WD_SCSI_STATUS);	/* clear interrupt */
 		udelay(7);
 
+		/* Prevent buffer overflow from malicious extended messages */
+		if (hostdata->incoming_ptr >= sizeof(hostdata->incoming_msg)) {
+			printk("wd33c93: Incoming message too long, rejecting\n");
+			hostdata->incoming_ptr = 0;
+			write_wd33c93_cmd(regs, WD_CMD_ASSERT_ATN);
+			hostdata->outgoing_msg[0] = MESSAGE_REJECT;
+			hostdata->outgoing_len = 1;
+			write_wd33c93_cmd(regs, WD_CMD_NEGATE_ACK);
+			hostdata->state = S_CONNECTED;
+			spin_unlock_irqrestore(&hostdata->lock, flags);
+			break;
+		}
+
 		hostdata->incoming_msg[hostdata->incoming_ptr] = msg;
 		if (hostdata->incoming_msg[0] == EXTENDED_MESSAGE)
 			msg = EXTENDED_MESSAGE;
-- 
2.34.1


