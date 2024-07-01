Return-Path: <stable+bounces-56232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B97A91DFC5
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFB41C2205B
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B0158D77;
	Mon,  1 Jul 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rouG+90E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98A158D88
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837961; cv=none; b=Av6WxyNmjzalWvnF5h1nF3Aw2yTGvUFtFUUHuG2KLGkEJIOQYpLR5u8i2HSMD1k2XfNGOs/Jj/UxaxrsYWOZML6Vt0Xokxq75Z/8xYC8XRqtwc0T5zez7XiTPP07nBEqTyGSiFytXrPEHwdVFzfIAb/IEZGwufwftNbFXul1gwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837961; c=relaxed/simple;
	bh=FK9BU1qUmSA9vqVEZ/t+8qEvbmjUnQx6jmScVQOlvdA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GPi6X4jPmmfPQXXZU1qHpIFLvCSRZDQ7925crHvRjdcPF8XPzmQjm4hKYRGEO/v74aaD6/VUh/dCroN8t5uHJtKvnUub/gxS0boozZ+1uVnZnRapBL31biAsUqlI6WlKjm+F5bvQKTJFmfnNLb0KbeSfyyMSSqZdew1no9tR9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rouG+90E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5492C116B1;
	Mon,  1 Jul 2024 12:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837961;
	bh=FK9BU1qUmSA9vqVEZ/t+8qEvbmjUnQx6jmScVQOlvdA=;
	h=Subject:To:Cc:From:Date:From;
	b=rouG+90E0Mlyc76Vc+lLMSwUVa000OUHe7JpJ0hHkTg+Q2n/h062TjHyCuK1N3Up2
	 fbFv/2gJ1nMBOB3WyKLs85Zqd7k/9tbbguIRxsS64RHbw4UK0QutuqCwK9t4WQ96DZ
	 lZ3JQIfPgVYKIpxd7YpgexRdiuqqEICpQSwBRfkE=
Subject: FAILED: patch "[PATCH] mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard" failed to apply to 5.10-stable tree
To: kamal.dasu@broadcom.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 14:30:25 +0200
Message-ID: <2024070124-giggle-polio-448c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d77dc388cd61dfdafe30b98025fa827498378199
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070124-giggle-polio-448c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

d77dc388cd61 ("mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard")
97904a59855c ("mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0")
6bcc55fe648b ("mmc: sdhci-brcmstb: Enable Clock Gating to save power")
f3a70f991dd0 ("mmc: sdhci-brcmstb: Re-organize flags")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d77dc388cd61dfdafe30b98025fa827498378199 Mon Sep 17 00:00:00 2001
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Mon, 3 Jun 2024 18:08:34 -0400
Subject: [PATCH] mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard

When erase/trim/discard completion was converted to mmc_poll_for_busy(),
optional support to poll with the host_ops->card_busy() callback was also
added.

The common sdhci's ->card_busy() turns out not to be working as expected
for the sdhci-brcmstb variant, as it keeps returning busy beyond the card's
busy period. In particular, this leads to the below splat for
mmc_do_erase() when running a discard (BLKSECDISCARD) operation during
mkfs.f2fs:

    Info: [/dev/mmcblk1p9] Discarding device
    [   39.597258] sysrq: Show Blocked State
    [   39.601183] task:mkfs.f2fs       state:D stack:0     pid:1561  tgid:1561  ppid:1542   flags:0x0000000d
    [   39.610609] Call trace:
    [   39.613098]  __switch_to+0xd8/0xf4
    [   39.616582]  __schedule+0x440/0x4f4
    [   39.620137]  schedule+0x2c/0x48
    [   39.623341]  schedule_hrtimeout_range_clock+0xe0/0x114
    [   39.628562]  schedule_hrtimeout_range+0x10/0x18
    [   39.633169]  usleep_range_state+0x5c/0x90
    [   39.637253]  __mmc_poll_for_busy+0xec/0x128
    [   39.641514]  mmc_poll_for_busy+0x48/0x70
    [   39.645511]  mmc_do_erase+0x1ec/0x210
    [   39.649237]  mmc_erase+0x1b4/0x1d4
    [   39.652701]  mmc_blk_mq_issue_rq+0x35c/0x6ac
    [   39.657037]  mmc_mq_queue_rq+0x18c/0x214
    [   39.661022]  blk_mq_dispatch_rq_list+0x3a8/0x528
    [   39.665722]  __blk_mq_sched_dispatch_requests+0x3a0/0x4ac
    [   39.671198]  blk_mq_sched_dispatch_requests+0x28/0x5c
    [   39.676322]  blk_mq_run_hw_queue+0x11c/0x12c
    [   39.680668]  blk_mq_flush_plug_list+0x200/0x33c
    [   39.685278]  blk_add_rq_to_plug+0x68/0xd8
    [   39.689365]  blk_mq_submit_bio+0x3a4/0x458
    [   39.693539]  __submit_bio+0x1c/0x80
    [   39.697096]  submit_bio_noacct_nocheck+0x94/0x174
    [   39.701875]  submit_bio_noacct+0x1b0/0x22c
    [   39.706042]  submit_bio+0xac/0xe8
    [   39.709424]  blk_next_bio+0x4c/0x5c
    [   39.712973]  blkdev_issue_secure_erase+0x118/0x170
    [   39.717835]  blkdev_common_ioctl+0x374/0x728
    [   39.722175]  blkdev_ioctl+0x8c/0x2b0
    [   39.725816]  vfs_ioctl+0x24/0x40
    [   39.729117]  __arm64_sys_ioctl+0x5c/0x8c
    [   39.733114]  invoke_syscall+0x68/0xec
    [   39.736839]  el0_svc_common.constprop.0+0x70/0xd8
    [   39.741609]  do_el0_svc+0x18/0x20
    [   39.744981]  el0_svc+0x68/0x94
    [   39.748107]  el0t_64_sync_handler+0x88/0x124
    [   39.752455]  el0t_64_sync+0x168/0x16c

To fix the problem let's override the host_ops->card_busy() callback by
setting it to NULL, which forces the mmc core to poll with a CMD13 and
checking the R1_STATUS in the mmc_busy_cb() function.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Fixes: 0d84c3e6a5b2 ("mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240603220834.21989-2-kamal.dasu@broadcom.com
[Ulf: Clarified the commit message]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 9053526fa212..150fb477b7cc 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -24,6 +24,7 @@
 #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
 #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
 #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
+#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(4)
 
 #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
 #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
@@ -384,6 +385,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	if (!(match_priv->flags & BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY))
+		host->mmc_host_ops.card_busy = NULL;
+
 	/* Change the base clock frequency if the DT property exists */
 	if (device_property_read_u32(&pdev->dev, "clock-frequency",
 				     &priv->base_freq_hz) != 0)


