Return-Path: <stable+bounces-58077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65955927A67
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB801F22F7E
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA81B14FB;
	Thu,  4 Jul 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zp1Q88pS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DCA1BC23;
	Thu,  4 Jul 2024 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107945; cv=none; b=lw7o8OpdfcUrvxMJl2jKSa9prFycYfxp313vPCdJi+2p2DBcmQykNdC361D4kRMeUzRm17zt/dmoJFMNeV9HOyFGABm/7dUBWZimfisQzWmrXgqgwiVRz1SLzeBKl1EkcdbqDrUmiX3jw4oubbC88hnQxV9IuzPo/1/0zAHdAxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107945; c=relaxed/simple;
	bh=oJBlWbPqZo8nujkVn1QJfVZCnw4HNFGE9kS3+dueDfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfCnA1tYBpkQVBJ+Qta68JUBZUCkTAsIy/XVwkd3DOOFLGlpocefEcg+xvMLWFefzvDVzGHlWBC8dH9E9GAZEf45vJ6Kwk1Cq6NyK+jMge0AwI/QbLyojCdCpc5SJYUr6kT5z6hC6ye/CqBF0LSfLWJQ3HkUC0gsRHVNRrKR1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Zp1Q88pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B19C3277B;
	Thu,  4 Jul 2024 15:45:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zp1Q88pS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720107943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7byKffxEApbn+yt6bUXHpSYmYpStI6tw/7/MBTMtZ28=;
	b=Zp1Q88pSBmynJxy+NV2xE97GYwRUQReEwdTL15lyZzxSqTX7en+vRaWNOgHzsn0REDEdmk
	ocV8xYOAZt7smSlaMiXhQqSmoULI/mrwET0lCJ771bu/a+zbm3p2Zt7N5qJtk4rhjNarcp
	xKD4ZxuYO/VZWtbPbQWg1tu5BHtcpk4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5cb51d87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 15:45:43 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/4] wireguard: queueing: annotate intentional data race in cpu round robin
Date: Thu,  4 Jul 2024 17:45:16 +0200
Message-ID: <20240704154517.1572127-4-Jason@zx2c4.com>
In-Reply-To: <20240704154517.1572127-1-Jason@zx2c4.com>
References: <20240704154517.1572127-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN reports a race in the CPU round robin function, which, as the
comment points out, is intentional:

    BUG: KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets

    read to 0xffff88811254eb28 of 4 bytes by task 3160 on cpu 1:
     wg_cpumask_next_online drivers/net/wireguard/queueing.h:127 [inline]
     wg_queue_enqueue_per_device_and_peer drivers/net/wireguard/queueing.h:173 [inline]
     wg_packet_create_data drivers/net/wireguard/send.c:320 [inline]
     wg_packet_send_staged_packets+0x60e/0xac0 drivers/net/wireguard/send.c:388
     wg_packet_send_keepalive+0xe2/0x100 drivers/net/wireguard/send.c:239
     wg_receive_handshake_packet drivers/net/wireguard/receive.c:186 [inline]
     wg_packet_handshake_receive_worker+0x449/0x5f0 drivers/net/wireguard/receive.c:213
     process_one_work kernel/workqueue.c:3248 [inline]
     process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3329
     worker_thread+0x526/0x720 kernel/workqueue.c:3409
     kthread+0x1d1/0x210 kernel/kthread.c:389
     ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

    write to 0xffff88811254eb28 of 4 bytes by task 3158 on cpu 0:
     wg_cpumask_next_online drivers/net/wireguard/queueing.h:130 [inline]
     wg_queue_enqueue_per_device_and_peer drivers/net/wireguard/queueing.h:173 [inline]
     wg_packet_create_data drivers/net/wireguard/send.c:320 [inline]
     wg_packet_send_staged_packets+0x6e5/0xac0 drivers/net/wireguard/send.c:388
     wg_packet_send_keepalive+0xe2/0x100 drivers/net/wireguard/send.c:239
     wg_receive_handshake_packet drivers/net/wireguard/receive.c:186 [inline]
     wg_packet_handshake_receive_worker+0x449/0x5f0 drivers/net/wireguard/receive.c:213
     process_one_work kernel/workqueue.c:3248 [inline]
     process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3329
     worker_thread+0x526/0x720 kernel/workqueue.c:3409
     kthread+0x1d1/0x210 kernel/kthread.c:389
     ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

    value changed: 0xffffffff -> 0x00000000

Mark this race as intentional by using READ/WRITE_ONCE().

Cc: stable@vger.kernel.org
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/queueing.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 1ea4f874e367..7eb76724b3ed 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -124,10 +124,10 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
  */
 static inline int wg_cpumask_next_online(int *last_cpu)
 {
-	int cpu = cpumask_next(*last_cpu, cpu_online_mask);
+	int cpu = cpumask_next(READ_ONCE(*last_cpu), cpu_online_mask);
 	if (cpu >= nr_cpu_ids)
 		cpu = cpumask_first(cpu_online_mask);
-	*last_cpu = cpu;
+	WRITE_ONCE(*last_cpu, cpu);
 	return cpu;
 }
 
-- 
2.45.2


