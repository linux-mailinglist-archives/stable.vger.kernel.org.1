Return-Path: <stable+bounces-180955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE6B91620
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AB33B3AFB
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B6309EE0;
	Mon, 22 Sep 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="Kc9dWOao";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="PgbFgRuL"
X-Original-To: stable@vger.kernel.org
Received: from mailhub9-fb.kaspersky-labs.com (mailhub9-fb.kaspersky-labs.com [195.122.169.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F7277CAE;
	Mon, 22 Sep 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.122.169.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547415; cv=none; b=UFWdOIESh14KOhNIn+qHaWrQfWHUqNtq5AIExb1WBVo7sFIvYmZMkk7VMjHdpIdqdpQjKi+ZdEZJllAacIfUbF4qDtIB9ViRRTATbjsBfPLV819e1tGx24EpIcp2R91e/gTGEsLowlNcO3qYrLmjOBG3jOsfZNmlFiqsiNWKWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547415; c=relaxed/simple;
	bh=ce3dC1v8UJ10Q6KR1l8jHBI3v4fDQEyx/Ibs0fOjVJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYrURAl0POSH7ZcPjnh4zyoC4GAXUuuxFkfqWIxgo0vemZNLLdhyJVt/XqbQy6vrXEpHDw7OsTDs5HsDpT8kTNRqY5ARtZxqLAU/iF3P72VIiIYPd99AMiy5TKolc18SdXlk7N7RRCtzgSLr/TPbmSHKPxxHe1ue6Q8jCWb1SFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=Kc9dWOao; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=PgbFgRuL; arc=none smtp.client-ip=195.122.169.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1758546848;
	bh=SLhCN3olWp1p9m1EvHm7Hswfqw6IJfg8mReYcW8JC1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Kc9dWOaoodlR2eISVYlaVnsXK21J8Ort40i84Lv2fmU+XfvuEVD7leqvtW64F38gC
	 7IxodsZHr/C2OHWvondBPp7x31Gb3IM5QZ29Bz45iER4eDIIyGY2OSL1ZcjDYjOTGh
	 tRbItkhC8ocnLNRcFr1fAFL0skNpgGLayJ93OqR7cJcA7sdpiw3HmdNr3PYpiZUflb
	 h5EMMertjQqRFhfaMcjnvIxdUs8JNuMmnzSmxuQ73/+ZZuTRIiQoAmcAimn4UikQ5i
	 es0ve1jgE4LXZ0HzSYbG3zviWx5m3ZUSAcJLXhbQNWZDeVc1RX8MJmxLXWhCImPssW
	 4Ki7Yb1g+NNOQ==
Received: from mailhub9-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTP id 4542C904EB8;
	Mon, 22 Sep 2025 16:14:08 +0300 (MSK)
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx12.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTPS id 09D2A90363A;
	Mon, 22 Sep 2025 16:14:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1758546840;
	bh=SLhCN3olWp1p9m1EvHm7Hswfqw6IJfg8mReYcW8JC1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PgbFgRuLMhrDSMfBd/31FxZNRhuwJgQ4qK2BQ9V9n08zVLzD8MthrbrytmZ7q8Qt/
	 l4jxQjqnIUMwWNqUR8gaukqwpeEeDHnhu+0Lq0jtd3SiCtqdnOxgMnJrktfTDicsEY
	 PaxQ2mGNeDDQyIqvZldAZwjN92g0d2jkTJGjmiM6xUibl1KYzRfxUgHETs1F+xHWU2
	 g7YFaodFi1sR2BQyS++gT4dyKN6JAyAzH+2L6Z/1tGKA/ZYKzsz95jGq9P99j4l8bL
	 BMofAX68Ey/o1Amz1+L+rrJYp5fFkDm/5Ett9TVUOK945nK6Af1u+xOnghV3XR8w+E
	 Vm2QDG42ADJpQ==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 585215A4CB7;
	Mon, 22 Sep 2025 16:14:00 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id AA8085A1580;
	Mon, 22 Sep 2025 16:13:59 +0300 (MSK)
Received: from larshin.avp.ru (10.16.104.188) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Mon, 22 Sep
 2025 16:13:58 +0300
From: Larshin Sergey <Sergey.Larshin@kaspersky.com>
To: Jan Kara <jack@suse.com>
CC: Larshin Sergey <Sergey.Larshin@kaspersky.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<Oleg.Kazakov@kaspersky.com>,
	<syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] fs: udf: fix OOB read in lengthAllocDescs handling
Date: Mon, 22 Sep 2025 16:13:58 +0300
Message-ID: <20250922131358.745579-1-Sergey.Larshin@kaspersky.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/22/2025 12:55:24
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196480 [Sep 22 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Sergey.Larshin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 67 0.3.67
 f6b3a124585516de4e61e2bf9df040d8947a2fd5
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_one_url}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;kaspersky.com:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;larshin.avp.ru:7.1.1,5.0.1;syzkaller.appspot.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/22/2025 12:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/22/2025 11:10:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/09/22 12:51:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/09/22 11:32:00 #27843153
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/09/22 12:52:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

When parsing Allocation Extent Descriptor, lengthAllocDescs comes from
on-disk data and must be validated against the block size. Crafted or
corrupted images may set lengthAllocDescs so that the total descriptor
length (sizeof(allocExtDesc) + lengthAllocDescs) exceeds the buffer,
leading udf_update_tag() to call crc_itu_t() on out-of-bounds memory and
trigger a KASAN use-after-free read.

BUG: KASAN: use-after-free in crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
Read of size 1 at addr ffff888041e7d000 by task syz-executor317/5309

CPU: 0 UID: 0 PID: 5309 Comm: syz-executor317 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 crc_itu_t+0x1d5/0x2b0 lib/crc-itu-t.c:60
 udf_update_tag+0x70/0x6a0 fs/udf/misc.c:261
 udf_write_aext+0x4d8/0x7b0 fs/udf/inode.c:2179
 extent_trunc+0x2f7/0x4a0 fs/udf/truncate.c:46
 udf_truncate_tail_extent+0x527/0x7e0 fs/udf/truncate.c:106
 udf_release_file+0xc1/0x120 fs/udf/file.c:185
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

Validate the computed total length against epos->bh->b_size.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Reported-by: syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org

Signed-off-by: Larshin Sergey <Sergey.Larshin@kaspersky.com>
---
 fs/udf/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index f24aa98e6869..a79d73f28aa7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2272,6 +2272,9 @@ int udf_current_aext(struct inode *inode, struct extent_position *epos,
 		if (check_add_overflow(sizeof(struct allocExtDesc),
 				le32_to_cpu(header->lengthAllocDescs), &alen))
 			return -1;
+
+		if (alen > epos->bh->b_size)
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
-- 
2.39.5


