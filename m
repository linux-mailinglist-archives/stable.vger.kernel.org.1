Return-Path: <stable+bounces-5418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3D80CBF1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F65F1F21607
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B247A68;
	Mon, 11 Dec 2023 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUx8E6+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1785E47A5A;
	Mon, 11 Dec 2023 13:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6792AC433CB;
	Mon, 11 Dec 2023 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302961;
	bh=uP1VjsneWpfR4iUeZhrkYgu+kGytmeEBdGkWjX6Y7VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUx8E6+DBl0QQUUoMlctYC+3uQV9vWTVjohKuJKpIc4ga6Y4VO8ltwWnBkk8b3MF1
	 A8Zibl12oxWT6BPORI5QNyGQxRdOpoZyQDHVKJjw/h+Sy2xb4yA8LhSnNbnT3ZPh/N
	 3VJ3Iw9Q7fGatZEKVirtAxcFzLVRf5SblbiqH5ZP8AxaS9jhSVfp3kTd8FNNYheVbk
	 TrsZ6KeGUnNGzN/WanWkQbQqu0XO3w8Je/SZ9o04dDj+9ipz7StE2lysSBZio6fEI/
	 7NniJOwoJ+xv3IGW4qHLei4JjLWnjKa8H14+qpkLJbNqF8M1AGiCAYrOwD75d+ZcDC
	 eiWRPVqnphFPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thinh Tran <thinhtr@linux.vnet.ibm.com>,
	Venkata Sai Duggi <venkata.sai.duggi@ibm.com>,
	David Christensen <drc@linux.vnet.ibm.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pavan.chebbi@broadcom.com,
	mchan@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/29] net/tg3: fix race condition in tg3_reset_task()
Date: Mon, 11 Dec 2023 08:54:00 -0500
Message-ID: <20231211135457.381397-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit

From: Thinh Tran <thinhtr@linux.vnet.ibm.com>

[ Upstream commit 16b55b1f2269962fb6b5154b8bf43f37c9a96637 ]

When an EEH error is encountered by a PCI adapter, the EEH driver
modifies the PCI channel's state as shown below:

   enum {
      /* I/O channel is in normal state */
      pci_channel_io_normal = (__force pci_channel_state_t) 1,

      /* I/O to channel is blocked */
      pci_channel_io_frozen = (__force pci_channel_state_t) 2,

      /* PCI card is dead */
      pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
   };

If the same EEH error then causes the tg3 driver's transmit timeout
logic to execute, the tg3_tx_timeout() function schedules a reset
task via tg3_reset_task_schedule(), which may cause a race condition
between the tg3 and EEH driver as both attempt to recover the HW via
a reset action.

EEH driver gets error event
--> eeh_set_channel_state()
    and set device to one of
    error state above           scheduler: tg3_reset_task() get
                                returned error from tg3_init_hw()
                             --> dev_close() shuts down the interface
tg3_io_slot_reset() and
tg3_io_resume() fail to
reset/resume the device

To resolve this issue, we avoid the race condition by checking the PCI
channel state in the tg3_reset_task() function and skip the tg3 driver
initiated reset when the PCI channel is not in the normal state.  (The
driver has no access to tg3 device registers at this point and cannot
even complete the reset task successfully without external assistance.)
We'll leave the reset procedure to be managed by the EEH driver which
calls the tg3_io_error_detected(), tg3_io_slot_reset() and
tg3_io_resume() functions as appropriate.

Adding the same checking in tg3_dump_state() to avoid dumping all
device registers when the PCI channel is not in the normal state.

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Tested-by: Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
Reviewed-by: David Christensen <drc@linux.vnet.ibm.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20231201001911.656-1-thinhtr@linux.vnet.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 85570e40c8e9b..95e478882ec13 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6447,6 +6447,14 @@ static void tg3_dump_state(struct tg3 *tp)
 	int i;
 	u32 *regs;
 
+	/* If it is a PCI error, all registers will be 0xffff,
+	 * we don't dump them out, just report the error and return
+	 */
+	if (tp->pdev->error_state != pci_channel_io_normal) {
+		netdev_err(tp->dev, "PCI channel ERROR!\n");
+		return;
+	}
+
 	regs = kzalloc(TG3_REG_BLK_SIZE, GFP_ATOMIC);
 	if (!regs)
 		return;
@@ -11175,7 +11183,8 @@ static void tg3_reset_task(struct work_struct *work)
 	rtnl_lock();
 	tg3_full_lock(tp, 0);
 
-	if (tp->pcierr_recovery || !netif_running(tp->dev)) {
+	if (tp->pcierr_recovery || !netif_running(tp->dev) ||
+	    tp->pdev->error_state != pci_channel_io_normal) {
 		tg3_flag_clear(tp, RESET_TASK_PENDING);
 		tg3_full_unlock(tp);
 		rtnl_unlock();
-- 
2.42.0


