Return-Path: <stable+bounces-50293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C386905746
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C04B21499
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A05180A9B;
	Wed, 12 Jun 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Hw1CexEz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81841802AA
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207205; cv=none; b=CXr+P03Ektth1qjQnwXAZHzX4ce5pw5Ih7pZ8mYJK4S3b0sSmyyOHYm0EShq5FAie1D/td5zYBqSa7fn+8YQXZgXWpvZlbeaSgWkdt3T9RJoRG38eAU6wtYgBOldPLpsOeAI6t3YCjqwPB56yMtisjIah6y/Zhbdthpkw68tJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207205; c=relaxed/simple;
	bh=kP8B1EtDEHRLPl6cQ3qo9H978F1NbZQTNK607akF0LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEDHLTcXnpFxoZudFHd2Bby+/CZ4EpXoMKb5aKWXuuWun7buig3GGI8gbUAvv3d/Y3fL7szHdQ3aVk9ObmHNHOfdhRv6YJN6EAfWdIudnObwOBUhh+IEzJSwIMrHwru3YjILd75XS+JFRPAN+FakBTDh6jJAslIAoiKvo/cGqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Hw1CexEz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D20E53F2A1
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718207200;
	bh=8SWJ+twjICu3VPSrAXlWQPBg+OAHJguvfQRajwDcVbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Hw1CexEz5ilO2Ce3EvcO0Com1xXZpFmZYpbO0HHVDpJZENr1Y+xx1KWztWneb89hx
	 UelE+y8XrdLCU/SxWbakO+jW2OUsAl6/tjPX90lhBli21HNd4M/34Q6y/GNI+xDwP+
	 5qZd5mPNZSDGA9TXmRGzrhN2o+7HSkL5fOFZkC6PAOJRvOK1wsZdu/Bi37ApeZl+5K
	 PVMQ8XInrM6ou9GYaGNGp9yUUnGqPjSV8u0PYSuKynloM4eSjRqqUgcnIWMVy0HbmC
	 v5pCh6S+foFEv5o8nEjICD+btO/Yr0yp7/NI6NggE/vkrwEJdxJEYPSJODdQHBbdvM
	 ylmbl9bQ/2ztw==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421eed70e30so177525e9.1
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 08:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718207200; x=1718812000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SWJ+twjICu3VPSrAXlWQPBg+OAHJguvfQRajwDcVbU=;
        b=ZDxjdZ5lxMQGF734Vn/giUVsnTrCOVM5Z5inJ1PDa6+d/cG2V5mwvI+GsZwR3nwDxc
         dfvQ/zsLVZSn4kPijEqEi+gAjTCrhUN6wtJzm6lLYiSq5Jc/REizxyJ/rlg665QkNN8Y
         YWErkcKixTxIysqhK+Oju+UTwPbEpDcqmyEdv4510+S7lw0VHvT+AkLstN7sO0ZykF8A
         rKoh/MT0R5bl0HzUjdztjSBw6gFN8Ij22NAVQ+rjZg5YJaUipOM4Ju8kXPbuQMZe4er9
         9a8Jg6P3/Pinc3EOI0YumMRuxqGTuzdkHGX0YPJ1iTIP/BFQrG5a09+/ZGL+ugR/yZdV
         WG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBhsTDgiLxVwBcDkkINkgp+8HA/d+sBPSODHWvmppt2VzKdqR5urUL6Hqv1ZiNqPLRUBJrbeZl1ycQXo+vIn0L/AIEw2bi
X-Gm-Message-State: AOJu0YzBmetC4o0zTJf2bO9OrWPR0BuY3jjyr6Sx4b6ROXAqRWk3xIBU
	ZY5l9rwqB23qVksseY+9VlQJ2hNT8RdnUFr9Cq11BRTs/y1cRAOhyCU5e8GCvCFHkhIxuy1u7PS
	bD0tMPNA3Dwkzi4OeJeGQEIsCsceFx17KhgK2WLQN5B2mBvJeo/QdIIhmuCq+J/iBYxnhAg==
X-Received: by 2002:a05:600c:4587:b0:421:7f30:7ce3 with SMTP id 5b1f17b1804b1-422861af749mr18623055e9.1.1718207200424;
        Wed, 12 Jun 2024 08:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMSr9qdTcl5dEaxWrAt60xHJmkO5bs77bb1FUYZdUALYP8B5Pk8RKNk+PJyoKc+Ej3ou5rFA==
X-Received: by 2002:a05:600c:4587:b0:421:7f30:7ce3 with SMTP id 5b1f17b1804b1-422861af749mr18622925e9.1.1718207200014;
        Wed, 12 Jun 2024 08:46:40 -0700 (PDT)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870f75f9sm30782245e9.34.2024.06.12.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:46:39 -0700 (PDT)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: netdev@vger.kernel.org
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
Date: Wed, 12 Jun 2024 18:44:49 +0300
Message-ID: <20240612154449.173663-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix UBSAN warnings that occur when using a system with 32 physical
cpu cores or more, or when the user defines a number of Ethernet
queues greater than or equal to FP_SB_MAX_E1x using the num_queues
module parameter.

The value of the maximum number of Ethernet queues should be limited
to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
enabled to avoid out of bounds reads and writes.

Stack traces:

UBSAN: array-index-out-of-bounds in
       drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1529:11
index 20 is out of range for type 'stats_query_entry [19]'
CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic
	     #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
	       BIOS P89 10/21/2019
Call Trace:
 <TASK>
 dump_stack_lvl+0x76/0xa0
 dump_stack+0x10/0x20
 __ubsan_handle_out_of_bounds+0xcb/0x110
 bnx2x_prep_fw_stats_req+0x2e1/0x310 [bnx2x]
 bnx2x_stats_init+0x156/0x320 [bnx2x]
 bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
 bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
 bnx2x_open+0x16b/0x290 [bnx2x]
 __dev_open+0x10e/0x1d0
RIP: 0033:0x736223927a0a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca
      64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00
      f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
</TASK>
---[ end trace ]---
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in
       drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1546:11
index 28 is out of range for type 'stats_query_entry [19]'
CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic
	     #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
	       BIOS P89 10/21/2019
Call Trace:
<TASK>
dump_stack_lvl+0x76/0xa0
dump_stack+0x10/0x20
__ubsan_handle_out_of_bounds+0xcb/0x110
bnx2x_prep_fw_stats_req+0x2fd/0x310 [bnx2x]
bnx2x_stats_init+0x156/0x320 [bnx2x]
bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
bnx2x_open+0x16b/0x290 [bnx2x]
__dev_open+0x10e/0x1d0
RIP: 0033:0x736223927a0a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca
      64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00
      f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
 </TASK>
---[ end trace ]---
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in
       drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:1895:8
index 29 is out of range for type 'stats_query_entry [19]'
CPU: 13 PID: 163 Comm: kworker/u96:1 Not tainted 6.9.0-060900rc7-generic
	     #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
	       BIOS P89 10/21/2019
Workqueue: bnx2x bnx2x_sp_task [bnx2x]
Call Trace:
 <TASK>
 dump_stack_lvl+0x76/0xa0
 dump_stack+0x10/0x20
 __ubsan_handle_out_of_bounds+0xcb/0x110
 bnx2x_iov_adjust_stats_req+0x3c4/0x3d0 [bnx2x]
 bnx2x_storm_stats_post.part.0+0x4a/0x330 [bnx2x]
 ? bnx2x_hw_stats_post+0x231/0x250 [bnx2x]
 bnx2x_stats_start+0x44/0x70 [bnx2x]
 bnx2x_stats_handle+0x149/0x350 [bnx2x]
 bnx2x_attn_int_asserted+0x998/0x9b0 [bnx2x]
 bnx2x_sp_task+0x491/0x5c0 [bnx2x]
 process_one_work+0x18d/0x3f0
 </TASK>
---[ end trace ]---

Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")
Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: stable@vger.kernel.org
---
Changes since v1:
 * Fix checkpatch complaints:
   - Wrapped commit message to comply with 75 character limit
   - Added space before ( in if condition

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index a8e07e51418f..c895dd680cf8 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
 	if (is_kdump_kernel())
 		nq = 1;
 
-	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
+	int max_nq = FP_SB_MAX_E1x - 1;
+
+	if (NO_FCOE(bp))
+		max_nq = FP_SB_MAX_E1x;
+
+	nq = clamp(nq, 1, max_nq);
 	return nq;
 }
 
-- 
2.43.0


