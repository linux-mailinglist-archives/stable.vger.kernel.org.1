Return-Path: <stable+bounces-39045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEEC8A119D
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452D91F225E0
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29EF145B13;
	Thu, 11 Apr 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="STgs9O0I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99E6BB29;
	Thu, 11 Apr 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832354; cv=none; b=KkmFyKnvUDzG74NpyeE8nl+6bWlZd2rMjt1XdPqbfiUpcXTzXwsg4Ps9fm8i+GwQ4jSC6rEaLg3J1CKsogyC+ae8RjYedZ9qxC7VpzJSa7EgVbCTb6P6xqcmy3sTQCUY0wZTYDkvsdvyeq81R58JTUFDIJmc3CC5J+Z4l3oSBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832354; c=relaxed/simple;
	bh=bpcAABT1rSwOi31/Cg9GA8brHPSTlEfQ3b9Z9lVq7yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL7k9B+vOzrcxjhBGdCB5VIGcwWvAftMLaAbrB4EGdrdOLrAS1bU13Xv4SHMj0SomrZGACnz2tFGqveCe4IYiV3K+tkgA7rFABVzlvyJWBAGb549VcDwXmcJtV5mYS4VR5UZk3NuFx7TMXs3A/083ngXokRVZ22LuNWHQUobc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=STgs9O0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45AFC433F1;
	Thu, 11 Apr 2024 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832354;
	bh=bpcAABT1rSwOi31/Cg9GA8brHPSTlEfQ3b9Z9lVq7yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STgs9O0IO1BgBNPLqT9pSDB5dLX9pk1JjPja2PNG96DyyqGrdNYcq0GqpCL+Y/Asy
	 QiNalOFWx1mz1C80VmLI3RwrCSS/TJk6KqEq2wd06u4+Jyz5Xmtpq2ecZtTQneOW60
	 X0f0hsU93VV2eqTW76XCU26tFITwJalCIbI4MoGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 20/83] wifi: ath11k: decrease MHI channel buffer length to 8KB
Date: Thu, 11 Apr 2024 11:56:52 +0200
Message-ID: <20240411095413.287609193@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 1cca1bddf9ef080503c15378cecf4877f7510015 ]

Currently buf_len field of ath11k_mhi_config_qca6390 is assigned
with 0, making MHI use a default size, 64KB, to allocate channel
buffers. This is likely to fail in some scenarios where system
memory is highly fragmented and memory compaction or reclaim is
not allowed.

There is a fail report which is caused by it:
kworker/u32:45: page allocation failure: order:4, mode:0x40c00(GFP_NOIO|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
CPU: 0 PID: 19318 Comm: kworker/u32:45 Not tainted 6.8.0-rc3-1.gae4495f-default #1 openSUSE Tumbleweed (unreleased) 493b6d5b382c603654d7a81fc3c144d59a1dfceb
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x47/0x60
 warn_alloc+0x13a/0x1b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __alloc_pages_direct_compact+0xab/0x210
 __alloc_pages_slowpath.constprop.0+0xd3e/0xda0
 __alloc_pages+0x32d/0x350
 ? mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 __kmalloc_large_node+0x72/0x110
 __kmalloc+0x37c/0x480
 ? mhi_map_single_no_bb+0x77/0xf0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 ? mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 mhi_prepare_channel+0x127/0x2d0 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 __mhi_prepare_for_transfer+0x44/0x80 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 ? __pfx_____mhi_prepare_for_transfer+0x10/0x10 [mhi 40df44e07c05479f7a6e7b90fba9f0e0031a7814]
 device_for_each_child+0x5c/0xa0
 ? __pfx_pci_pm_resume+0x10/0x10
 ath11k_core_resume+0x65/0x100 [ath11k a5094e22d7223135c40d93c8f5321cf09fd85e4e]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ath11k_pci_pm_resume+0x32/0x60 [ath11k_pci 830b7bfc3ea80ebef32e563cafe2cb55e9cc73ec]
 ? srso_alias_return_thunk+0x5/0xfbef5
 dpm_run_callback+0x8c/0x1e0
 device_resume+0x104/0x340
 ? __pfx_dpm_watchdog_handler+0x10/0x10
 async_resume+0x1d/0x30
 async_run_entry_fn+0x32/0x120
 process_one_work+0x168/0x330
 worker_thread+0x2f5/0x410
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe8/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Actually those buffers are used only by QMI target -> host communication.
And for WCN6855 and QCA6390, the largest packet size for that is less
than 6KB. So change buf_len field to 8KB, which results in order 1
allocation if page size is 4KB. In this way, we can at least save some
memory, and as well as decrease the possibility of allocation failure
in those scenarios.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Closes: https://lore.kernel.org/ath11k/96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240223053111.29170-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index a62ee05c54097..4bea36cc71085 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -105,7 +105,7 @@ static struct mhi_controller_config ath11k_mhi_config_qca6390 = {
 	.max_channels = 128,
 	.timeout_ms = 2000,
 	.use_bounce_buf = false,
-	.buf_len = 0,
+	.buf_len = 8192,
 	.num_channels = ARRAY_SIZE(ath11k_mhi_channels_qca6390),
 	.ch_cfg = ath11k_mhi_channels_qca6390,
 	.num_events = ARRAY_SIZE(ath11k_mhi_events_qca6390),
-- 
2.43.0




