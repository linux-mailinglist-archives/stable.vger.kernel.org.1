Return-Path: <stable+bounces-55946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB591A4D6
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 13:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216A228337C
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0413A40D;
	Thu, 27 Jun 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AiOKvyTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5DA13E05F
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486929; cv=none; b=jPXbEQYM6NXZ9Mjm+CXRlUHdTX8ZjK5R7kzgpUmPFaRNujwJDgCdLq9M/q8mrWps9SiXMGy1xc4dsevCQAJAI/J88p+/z6q4fp4RoRq/Ym5X0Uy1It/cKe1EEqV0MBhdoBOxxMaS+xLVgP4LP1ZVPTepLWb91TdN8kqWSKed9Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486929; c=relaxed/simple;
	bh=IuBacV5X+fbodylYX5iaFeHHTDI6O5S1jgN0f2LCWNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DObRLZ9GKrT/zF84k8k15PZuI2xZZHZX55i/CA6j2cuR5Oqsewe1ucKOdWQAsJwd+fleoc8byqOQFp/WqZ+Kf6nqa+/XVuc4WVtmC9H7r3Q9BGxA4F7YfwmWPClo3r5iH4fFRgaffWSjGdlwbZ1ut9RFgjNXKVyfk/K9kx2JcDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AiOKvyTQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1FCA43F5EF
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719486925;
	bh=J+yPw8z58QxETfEvEDc5Ds99wVZU+Ow1RMLrRPKuiyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=AiOKvyTQKhX1bWcm4+09y64vgt6PaMcRYtK94whBfKJQH5jWNdn1NMa0B8YMQfg+f
	 NpQt0SNP0NMcHifXLsdrGm90zsmuIIwK+pcqT4kZFVu0cG8WwNCHUgnB4+5wcjjPZf
	 Nsi5CHExvT5cBJiOGOsvH/l2GjIMor3GtmM8OYeVYrxuIEjhQaQl2TsI2upTkhEkoK
	 OomgK7ZF7ArItZ3bgGaevooeo5iv8FYQZiRZBZU5bHN4HDGiOPzGD3JBjNJDAhqvwD
	 8BiqEOZhT3BK+oaAHj5NTanWDXxH0XjNWivmvzBcnlOpZgQjHX/DExHdkVAtL6SdM/
	 7GiERfoVDOQ0Q==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ce007cdd4so3999457e87.3
        for <stable@vger.kernel.org>; Thu, 27 Jun 2024 04:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719486924; x=1720091724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+yPw8z58QxETfEvEDc5Ds99wVZU+Ow1RMLrRPKuiyY=;
        b=tZUdzwIxDsBm3s5PuB1Mew7taxmR4OkJwwvnmXAl0kBj1A4vUkn1FaGF4quaxXV9eJ
         Zc9uslL78Dc0rw6TZiFKWfZSuom2/J8cy4HZbGoXDGDOvN0n2INBZChlI30jj28RaorP
         nDfib+273MYbE26qwy8n1+aENzzFZI7yHD9ALCPHy0v0hMmGJMxmu2cO+smgd3gwXMwX
         UyNHU1xekRQHmGpCbaVBXLb7xrWEbxuelrBe3LyHZr86bU6Mbx4h/TDarPHMDhI1FaVg
         7dNyUirCtZx92SiZix16Q3cfwucADHd4Pu31OFXk/Y3zDncGxaviXsVLhzVsyoBAMiMR
         M8fw==
X-Forwarded-Encrypted: i=1; AJvYcCW3dKoW1K3WVVbtnez3jkJy1UHNxOK6OB0YFiBOa943YaU55f6Uu2JEwYqJHN+1oWYGSt5gzRsNGpZf2b80bt2B1KgOLSZ2
X-Gm-Message-State: AOJu0YzbdH1qNYFSMwaQjiy+uyRfPu2ZM6GcGW75yprYOlRGTM2Urrmz
	bLNmMel79jU65fLwFKO6PBpQoVDg66EgFwq9lOcVdu+3MGBcJdBeP890GhlATCSBYqaSVrWkW+h
	dTQ0e37IO+Ukxj/qevwDN2RpXDasFJFgaVolh4AC7sLLqnz1OgfbVUeIa6FTpVdkuEwxs4g==
X-Received: by 2002:a05:6512:3b25:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ce1835195mr10665575e87.17.1719486924443;
        Thu, 27 Jun 2024 04:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVFnW1xAN6raSN2NzhOnYNCG8OB9oq/JMCEu+8SvdJt3gDQ+duXZQLKwqo/ZRfLCK7QSO82Q==
X-Received: by 2002:a05:6512:3b25:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52ce1835195mr10665561e87.17.1719486923928;
        Thu, 27 Jun 2024 04:15:23 -0700 (PDT)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b633fcsm20873705e9.11.2024.06.27.04.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:15:23 -0700 (PDT)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: netdev@vger.kernel.org
Cc: jay.vosburgh@canonical.com,
	Ghadi Elie Rahme <ghadi.rahme@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
Date: Thu, 27 Jun 2024 14:14:05 +0300
Message-ID: <20240627111405.1037812-1-ghadi.rahme@canonical.com>
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

Currently there is a read/write out of bounds that occurs on the array
"struct stats_query_entry query" present inside the "bnx2x_fw_stats_req"
struct in "drivers/net/ethernet/broadcom/bnx2x/bnx2x.h".
Looking at the definition of the "struct stats_query_entry query" array:

struct stats_query_entry query[FP_SB_MAX_E1x+
         BNX2X_FIRST_QUEUE_QUERY_IDX];

FP_SB_MAX_E1x is defined as the maximum number of fast path interrupts and
has a value of 16, while BNX2X_FIRST_QUEUE_QUERY_IDX has a value of 3
meaning the array has a total size of 19.
Since accesses to "struct stats_query_entry query" are offset-ted by
BNX2X_FIRST_QUEUE_QUERY_IDX, that means that the total number of Ethernet
queues should not exceed FP_SB_MAX_E1x (16). However one of these queues
is reserved for FCOE and thus the number of Ethernet queues should be set
to [FP_SB_MAX_E1x -1] (15) if FCOE is enabled or [FP_SB_MAX_E1x] (16) if
it is not.

This is also described in a comment in the source code in
drivers/net/ethernet/broadcom/bnx2x/bnx2x.h just above the Macro definition
of FP_SB_MAX_E1x. Below is the part of this explanation that it important
for this patch

/*
  * The total number of L2 queues, MSIX vectors and HW contexts (CIDs) is
  * control by the number of fast-path status blocks supported by the
  * device (HW/FW). Each fast-path status block (FP-SB) aka non-default
  * status block represents an independent interrupts context that can
  * serve a regular L2 networking queue. However special L2 queues such
  * as the FCoE queue do not require a FP-SB and other components like
  * the CNIC may consume FP-SB reducing the number of possible L2 queues
  *
  * If the maximum number of FP-SB available is X then:
  * a. If CNIC is supported it consumes 1 FP-SB thus the max number of
  *    regular L2 queues is Y=X-1
  * b. In MF mode the actual number of L2 queues is Y= (X-1/MF_factor)
  * c. If the FCoE L2 queue is supported the actual number of L2 queues
  *    is Y+1
  * d. The number of irqs (MSIX vectors) is either Y+1 (one extra for
  *    slow-path interrupts) or Y+2 if CNIC is supported (one additional
  *    FP interrupt context for the CNIC).
  * e. The number of HW context (CID count) is always X or X+1 if FCoE
  *    L2 queue is supported. The cid for the FCoE L2 queue is always X.
  */

However this driver also supports NICs that use the E2 controller which can
handle more queues due to having more FP-SB represented by FP_SB_MAX_E2.
Looking at the commits when the E2 support was added, it was originally
using the E1x parameters: commit f2e0899f0f27 ("bnx2x: Add 57712 support").
Back then FP_SB_MAX_E2 was set to 16 the same as E1x. However the driver
was later updated to take full advantage of the E2 instead of having it be
limited to the capabilities of the E1x. But as far as we can tell, the
array "stats_query_entry query" was still limited to using the FP-SB
available to the E1x cards as part of an oversignt when the driver was
updated to take full advantage of the E2, and now with the driver being
aware of the greater queue size supported by E2 NICs, it causes the UBSAN
warnings seen in the stack traces below.

This patch increases the size of the "stats_query_entry query" array by
replacing FP_SB_MAX_E1x with FP_SB_MAX_E2 to be large enough to handle
both types of NICs.

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

Fixes: 50f0a562f8cc ("bnx2x: add fcoe statistics")
Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: stable@vger.kernel.org
---
changes since v2:
 * Undid all changes
   - moved away from changing queue limit to comply with E1x and increased
   statistics array queue to fit E2 devices instead.
 * Updated Fixes section
 * More explanatory commit message

Changes since v1:
 * Fix checkpatch complaints:
   - Wrapped commit message to comply with 75 character limit
   - Added space before ( in if condition

 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index e2a4e1088b7f..13c6a5eb9c15 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -1262,7 +1262,7 @@ enum {
 
 struct bnx2x_fw_stats_req {
 	struct stats_query_header hdr;
-	struct stats_query_entry query[FP_SB_MAX_E1x+
+	struct stats_query_entry query[FP_SB_MAX_E2 +
 		BNX2X_FIRST_QUEUE_QUERY_IDX];
 };
 
-- 
2.43.0


