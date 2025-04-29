Return-Path: <stable+bounces-137490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6170AA13C8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30708925ECD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A902522A2;
	Tue, 29 Apr 2025 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k33N2YDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1324C067;
	Tue, 29 Apr 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946222; cv=none; b=G4nZ1AoIXTyG2DSYIBERuJy3usZQ33TxmxYunqeFeOyS5ngyLdFC3SoejAxJvxpN/Q/SKsZ/ocbfZoxVPl93y5sGbxBVIdK0YljV2V1LsDERJdukgzZDHHbBe2tHE12u005p6ZJTfQlcPupQCxNy8StKZNTWBZiDZ79EERf8rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946222; c=relaxed/simple;
	bh=/PLYxehcMZ4ABGwRuBDPWSWEFzQNOcyLxc1BHFOirMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEg5n8DK81PWbiTQZ4KRlVtO4vb+MvO8coRWsvgyPXCUXzyGRfrHlAkRa2Yf2VBA21FzsaCs9rGmo0XKrkRVSxkDqQcl6beU2QjBURy++WDVXarL4zuohWu+MMTCJlqxsI02fuZo4NPXxhK2aSGBQ3ATYl4lhLtPN4XxFo25g4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k33N2YDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CFFC4CEE3;
	Tue, 29 Apr 2025 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946221;
	bh=/PLYxehcMZ4ABGwRuBDPWSWEFzQNOcyLxc1BHFOirMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k33N2YDepugAA1aXd1SVy9iNFf/JtOvaOwr6hrUU0gjsSchP73mz4PtmqI6BSFByX
	 JKJXCd/LOy1AfMxs60a0NyfdFfStmZN2e2oYXUtAAFFsIgDKHxPdn1FAHFhGINiaMI
	 puklcsb6IaT18sxBTWAQVAPd7OPj8kx3XJRpuLuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Huisong Li <lihuisong@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 196/311] mailbox: pcc: Fix the possible race in updation of chan_in_use flag
Date: Tue, 29 Apr 2025 18:40:33 +0200
Message-ID: <20250429161129.042193504@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huisong Li <lihuisong@huawei.com>

[ Upstream commit 9779d45c749340ab461d595c1a4a664cb28f3007 ]

The function mbox_chan_received_data() calls the Rx callback of the
mailbox client driver. The callback might set chan_in_use flag from
pcc_send_data(). This flag's status determines whether the PCC channel
is in use.

However, there is a potential race condition where chan_in_use is
updated incorrectly due to concurrency between the interrupt handler
(pcc_mbox_irq()) and the command sender(pcc_send_data()).

The 'chan_in_use' flag of a channel is set to true after sending a
command. And the flag of the new command may be cleared erroneous by
the interrupt handler afer mbox_chan_received_data() returns,

As a result, the interrupt being level triggered can't be cleared in
pcc_mbox_irq() and it will be disabled after the number of handled times
exceeds the specified value. The error log is as follows:

  |  kunpeng_hccs HISI04B2:00: PCC command executed timeout!
  |  kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110
  |  irq 13: nobody cared (try booting with the "irqpoll" option)
  |  Call trace:
  |   dump_backtrace+0x0/0x210
  |   show_stack+0x1c/0x2c
  |   dump_stack+0xec/0x130
  |   __report_bad_irq+0x50/0x190
  |   note_interrupt+0x1e4/0x260
  |   handle_irq_event+0x144/0x17c
  |   handle_fasteoi_irq+0xd0/0x240
  |   __handle_domain_irq+0x80/0xf0
  |   gic_handle_irq+0x74/0x2d0
  |   el1_irq+0xbc/0x140
  |   mnt_clone_write+0x0/0x70
  |   file_update_time+0xcc/0x160
  |   fault_dirty_shared_page+0xe8/0x150
  |   do_shared_fault+0x80/0x1d0
  |   do_fault+0x118/0x1a4
  |   handle_pte_fault+0x154/0x230
  |   __handle_mm_fault+0x1ac/0x390
  |   handle_mm_fault+0xf0/0x250
  |   do_page_fault+0x184/0x454
  |   do_translation_fault+0xac/0xd4
  |   do_mem_abort+0x44/0xb4
  |   el0_da+0x40/0x74
  |   el0_sync_handler+0x60/0xb4
  |   el0_sync+0x168/0x180
  |  handlers:
  |   pcc_mbox_irq
  |  Disabling IRQ #13

To solve this issue, pcc_mbox_irq() must clear 'chan_in_use' flag before
the call to mbox_chan_received_data().

Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Tested-by: Robbie King <robbiek@xsightlabs.com>
Signed-off-by: Huisong Li <lihuisong@huawei.com>
(sudeep.holla: Minor updates to the subject, commit message and comment)
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 82102a4c5d688..8fd4d0f79b090 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -333,10 +333,16 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	/*
+	 * Clear this flag after updating interrupt ack register and just
+	 * before mbox_chan_received_data() which might call pcc_send_data()
+	 * where the flag is set again to start new transfer. This is
+	 * required to avoid any possible race in updatation of this flag.
+	 */
+	pchan->chan_in_use = false;
 	mbox_chan_received_data(chan, NULL);
 
 	check_and_ack(pchan, chan);
-	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }
-- 
2.39.5




