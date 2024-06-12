Return-Path: <stable+bounces-50265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD5090549D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E3287FC6
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E317E90C;
	Wed, 12 Jun 2024 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dQbVcoP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2E17E458
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200662; cv=none; b=ATGDZWVAhJ1LWNJq7gQFC64wEusYHkHrWVmngH7yW/2cgTsfcoeYRRDQ/840uiJcmENKn+PNPMYDbcI1Bc9f2JVfxfpNU85f7dLcPJOsH2Cd7EupHg6t5smCjbgrfzuZdda11x53SiBR6elPossFaEkXvS0vVQbI2dkXyMtBQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200662; c=relaxed/simple;
	bh=B/tz6F/uDM43AEh9FiNHITpH2lzDrglyTdjEEE9P03A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8iF4sUnuQFC7skmOKfxELI88fsWYDyLdsdOKHZDDgND1s/v+labwp0mJUJxeEi1sA9DSMrIvwTDSceh8W5oRLK3LP6ANUC5GybitX1p+6TqoPIt5WrIrmiehmc3fvzKGY1RXa5s+Ts5xY2qHcFnqAFDfPTRg8S7McZPwfpjkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dQbVcoP5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9F83A3F2A1
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718200657;
	bh=450QJdaFOD/ZEOKdhYp3ewa6MAAZ+MnyJ5yZ14liXb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=dQbVcoP53ECpuy59NM/tL8TIsKe0Rc4mqtSouJn2MlloOIdhfa+6V84hdKhRHDdPB
	 54cljCTG0TgYCnsn65WGhhywHdjV1lOQv1sMCzZc7ZOHIbHLgjwxsE7qMdScKAwkOw
	 3QlY8Q99EwhyMme7dnGAd6zsMvVRva8SWeRKU+yRpD9hrp955226hYgf9KOF1/zEKj
	 SwwMMGSyIndJMlLcopPJFeaYnfJsec1I27pJYEZfTW4sUHcifkObD48ELrGxTImx51
	 Z9dDBe5nvKya1pTqAmSSZhsK5ORKCMHxZjqTbR5rcXfqKg5TPESTt+vsMvokLDRPI8
	 qWk/VBn8F3V9A==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421739476b3so43690005e9.2
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 06:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200657; x=1718805457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=450QJdaFOD/ZEOKdhYp3ewa6MAAZ+MnyJ5yZ14liXb8=;
        b=VFy7opOIYyj5s4C7WGZSeyVLtiShAus6N6r4hPArtoVNNknOgzC0oP2z8J2NwmmlTQ
         7gMSed4YptYmnSxACvqvolto0di1T399Hb3JpPvnCrAajOcI1nck0nUyCp3Gwl4HjEk+
         GJxO6WsyNd2DUtX5S46XJjZP3zJ8tGt75IbV3eqEB3vy/P6ZHKgWyVBCY+PErOy/IiBr
         SlSj90gS8fvYKlgN7bgU/AMAA3Mutfjrx/q719ZLkgVIxul2i5mjnCD4iMN0145hnrDD
         HspmcAKu5WmfqTE3Q87NgQoPO9ou9k3g6USjs1GJircafwBZDjTUH8AD5mwl8VKLJO+z
         xaOQ==
X-Gm-Message-State: AOJu0YzeEWxYIxmKAenIWRc46RezhcyLcUpD/sI0PslE9Uw7gjoUkAaK
	JEklOECluS29qOfYLSmg0ACEcSlhVpZ+TChhb9odjayt3uvV+lEV+wjPHuaMRC2EC07BkzkRzBk
	+CIlYVtHisAF2aWFHvjaWGVvuZ9b02SY+wXM4r+tVKeFPJEM97AcUbplWoeKTdm/oWhCYe8iL0q
	IPwhbM
X-Received: by 2002:a05:600c:35cd:b0:422:683b:df31 with SMTP id 5b1f17b1804b1-422862b3c90mr21262005e9.7.1718200656764;
        Wed, 12 Jun 2024 06:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdpfOWSfB1/u6rk/gPaDhbIg4bOKTjwkTGoxK3fdoQ1JSH8FcOfwqkcf8jTDGOFJ8flsx6HQ==
X-Received: by 2002:a05:600c:35cd:b0:422:683b:df31 with SMTP id 5b1f17b1804b1-422862b3c90mr21261785e9.7.1718200656350;
        Wed, 12 Jun 2024 06:57:36 -0700 (PDT)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef970sm26985235e9.10.2024.06.12.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:57:35 -0700 (PDT)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Subject: [PATCH net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
Date: Wed, 12 Jun 2024 16:56:57 +0300
Message-ID: <20240612135657.153658-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix UBSAN warnings that occur when using a system with 32 physical
cpu cores or more, or when the user defines a number of ethernet
queues greater than or equal to FP_SB_MAX_E1x.

The value of the maximum number of Ethernet queues should be limited
to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
enabled to avoid out of bounds reads and writes.

Stack trace:

UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1529:11
index 20 is out of range for type 'stats_query_entry [19]'
CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
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
 __dev_change_flags+0x1bb/0x240
 ? sock_def_readable+0x52/0xf0
 dev_change_flags+0x27/0x80
 do_setlink+0xab7/0xe50
 ? rtnl_getlink+0x3c7/0x470
 ? __nla_validate_parse+0x49/0x1d0
 rtnl_setlink+0x12f/0x1f0
 ? security_capable+0x47/0x80
 rtnetlink_rcv_msg+0x170/0x440
 ? ep_done_scan+0xe4/0x100
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x5d/0x110
 rtnetlink_rcv+0x15/0x30
 netlink_unicast+0x243/0x380
 netlink_sendmsg+0x213/0x460
 __sys_sendto+0x21e/0x230
 __x64_sys_sendto+0x24/0x40
 x64_sys_call+0x1c33/0x25c0
 do_syscall_64+0x7e/0x180
 ? __task_pid_nr_ns+0x6c/0xc0
 ? syscall_exit_to_user_mode+0x81/0x270
 ? do_syscall_64+0x8b/0x180
 ? do_syscall_64+0x8b/0x180
 ? __task_pid_nr_ns+0x6c/0xc0
 ? syscall_exit_to_user_mode+0x81/0x270
 ? do_syscall_64+0x8b/0x180
 ? do_syscall_64+0x8b/0x180
 ? exc_page_fault+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x736223927a0a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
</TASK>
---[ end trace ]---
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1546:11
index 28 is out of range for type 'stats_query_entry [19]'
CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
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
__dev_change_flags+0x1bb/0x240
? sock_def_readable+0x52/0xf0
dev_change_flags+0x27/0x80
do_setlink+0xab7/0xe50
? rtnl_getlink+0x3c7/0x470
? __nla_validate_parse+0x49/0x1d0
rtnl_setlink+0x12f/0x1f0
? security_capable+0x47/0x80
rtnetlink_rcv_msg+0x170/0x440
? ep_done_scan+0xe4/0x100
? __pfx_rtnetlink_rcv_msg+0x10/0x10
netlink_rcv_skb+0x5d/0x110
rtnetlink_rcv+0x15/0x30
netlink_unicast+0x243/0x380
netlink_sendmsg+0x213/0x460
__sys_sendto+0x21e/0x230
__x64_sys_sendto+0x24/0x40
x64_sys_call+0x1c33/0x25c0
do_syscall_64+0x7e/0x180
? __task_pid_nr_ns+0x6c/0xc0
? syscall_exit_to_user_mode+0x81/0x270
? do_syscall_64+0x8b/0x180
? do_syscall_64+0x8b/0x180
? __task_pid_nr_ns+0x6c/0xc0
? syscall_exit_to_user_mode+0x81/0x270
? do_syscall_64+0x8b/0x180
? do_syscall_64+0x8b/0x180
? exc_page_fault+0x93/0x1b0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x736223927a0a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
 </TASK>
---[ end trace ]---
bnx2x 0000:04:00.1: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
bnx2x 0000:04:00.1 eno50: renamed from eth0
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in /home/kernel/COD/linux/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c:1895:8
index 29 is out of range for type 'stats_query_entry [19]'
CPU: 13 PID: 163 Comm: kworker/u96:1 Not tainted 6.9.0-060900rc7-generic #202405052133
Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
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
 worker_thread+0x304/0x440
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe4/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x47/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
---[ end trace ]---

Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")
Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index a8e07e51418f..837617b99089 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
 	if (is_kdump_kernel())
 		nq = 1;
 
-	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
+	int max_nq = FP_SB_MAX_E1x - 1;
+
+	if(NO_FCOE(bp))
+		max_nq = FP_SB_MAX_E1x;
+
+	nq = clamp(nq, 1, max_nq);
 	return nq;
 }
 
-- 
2.43.0


