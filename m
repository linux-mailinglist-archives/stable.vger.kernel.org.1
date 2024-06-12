Return-Path: <stable+bounces-50290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F5905709
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79D31F27C98
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7016918622;
	Wed, 12 Jun 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ghtsqZA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664541802CC
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206553; cv=none; b=RODUScxZ6ujz6de+zNCxabu+IT90jDYGoL7356tqYyBnLvrkpsqLTHTdRJJxMErhXxSdjR89AASy2D6PWH754RwvPltlSBGfZQ74sY34hGh6WHCmpzTCgpM5aiv/WfGaSUz5r9vXsJQV438EnTihZKR2QfaK1eSsA7G/5Nj7SCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206553; c=relaxed/simple;
	bh=kP8B1EtDEHRLPl6cQ3qo9H978F1NbZQTNK607akF0LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVbpOykbYbxpI7PpsNazupBYMhTKW6V1JTUdwXpxR3KKtkSB/hTeary2p1sgb8vHf5n0iVemMn+E7nGAXR3R0EzaW5D5+E/1qa2I6bCz25U3mBvbeZUy1Qz4Wc/xfKqAhu/p2xScObgBESmc+Z/PgmyYStBoqorSIAPhjjSbcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ghtsqZA0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A9AD3F699
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718206548;
	bh=8SWJ+twjICu3VPSrAXlWQPBg+OAHJguvfQRajwDcVbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ghtsqZA0IqdwtRhawVVhF885KJGiNnODCHBbCGbsovZ5phYy8B3wxMHsBwIeKHdZQ
	 EIXjCKT8mGQY25E3o2uZ701okDtIudE2YteNKvMs3K1dX3YPjKFyEHdt4BBIK5VgP1
	 rGw/gRBl1S+l+VqGO2RXHBsGF82m+GnSxse07u48+gyUX0y+uTqSGCcqNSD7Rw1cuz
	 GSBN2l709umySvNyxcSuIGwOr+6gm+RVJrdREMNrsnKTBmgEduM3o+/CQeyOxfU2wE
	 tKunaZsATnddD9D4qn8DWTt4DQnPZJaWY3OwjqUz422cdO0bOaoTSIJJLw/RS4W40e
	 adP/DmaosPs+g==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4217a6a00d8so186085e9.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 08:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718206547; x=1718811347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SWJ+twjICu3VPSrAXlWQPBg+OAHJguvfQRajwDcVbU=;
        b=e8rhhClx5vMePYyYmsXWJE4vz4eejAzMLOghLKVaG0mHSD2LBK1WXGddfAtzN4J+7q
         ljHTIfrTQ+g1ufFXwzzJb/21a4Mkp3O4a3jjTswP6ADoHgSzPZL0cU/mt4qWbBGM2dkG
         OvDhXeZauW6xp9Uq7S3eD0/x7MwTrxlwG19qwGBZn3vEazvjW34JXS9LxdA9KsfPopS5
         luyPNHfZJL1KHFPewwLGCo+8kBDVi1i51U7e3kgvLaAE6c29FoimzF/EXcN5czPQumQ5
         xOQxrpKVbPez1JvBVXj4n4eZSEgc0htjB1PNoi7O2DJBXAbN+SNdrRw1FMec/2pxcaES
         vBQg==
X-Forwarded-Encrypted: i=1; AJvYcCUCFmP9SEoX9aOJJq7WP+Dh4+PrlvvGt7GwPluRprUYd/w71fhv0trSaHEU8sckmd6KUxPjOKLmKl+w+gLEbEgo47QcRjf7
X-Gm-Message-State: AOJu0Yxvpome4488ZOYrWVUoSkvXE4C7kbDLwl+tUuK9ebhztLJwuvc3
	KXhy7NScx0g+QsqZELfHW9nNdErsPCWLPyaqai/5rR0vwb/LSjLQZ2t7/G8E+E4wDNakZrfEWy2
	Rbva+2/nqju12BoSNQNQuj0LjA3xsOCUnv4hwsJLMxFId7eksbwN1VT1+mcseuoHmOZL3LF4nci
	FyI6lf
X-Received: by 2002:a05:600c:4907:b0:422:62db:5a09 with SMTP id 5b1f17b1804b1-422863b4b85mr16487855e9.12.1718206547346;
        Wed, 12 Jun 2024 08:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdrzx6EO9z1mA4TbJTIFjSgvBB/a3S09FubalFRZ6se5jfdOcxg2QrK+/4HmntKKV8d8sGjg==
X-Received: by 2002:a05:600c:4907:b0:422:62db:5a09 with SMTP id 5b1f17b1804b1-422863b4b85mr16487685e9.12.1718206546973;
        Wed, 12 Jun 2024 08:35:46 -0700 (PDT)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f23fe7a64sm8661759f8f.89.2024.06.12.08.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 08:35:46 -0700 (PDT)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: ghadi.rahme@hotmail.com
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
Date: Wed, 12 Jun 2024 18:35:04 +0300
Message-ID: <20240612153504.170241-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612132451.148350-1-ghadi.rahme@canonical.com>
References: <20240612132451.148350-1-ghadi.rahme@canonical.com>
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


