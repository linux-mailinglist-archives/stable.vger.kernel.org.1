Return-Path: <stable+bounces-22569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E7285DCA7
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1961C2337F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBE67BAFB;
	Wed, 21 Feb 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pXA68nZQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893455E5E;
	Wed, 21 Feb 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523756; cv=none; b=eTQmQ5ayVnW5+l0IAiEIfRYvqwQdIPek1b6RTvwBi9ERUCaZXCBGpbDSzfZqk1uAytSNqcphUGVvfKrG52TWXA0r9orWCOnmKUufXjia7oJZbYK1J92IMKvFdoY8eDXh99S/9ccb8J+widEvGa8P39BF4zTfnq63FiBRHXwH2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523756; c=relaxed/simple;
	bh=oasJ3C2JmRgTiXVUcA1viEWsn3vIHzWv7CmpYp1h/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNFb2stUBVvpBLxeJfj97NOjmS9oEebxtG0yyILPJwTa0HvatCITd8wZpxgD8yTUGF3cRYRcyyxB0yMtpI99P/JBvzy1oWlfsxzTqjUwQHspQsJUOQ/aDkliwtL4oxNX94nrQzURnyBfGYZ4YHuLmuRgHpKMcOJvK/Jp2O6K7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pXA68nZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A87C433F1;
	Wed, 21 Feb 2024 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523756;
	bh=oasJ3C2JmRgTiXVUcA1viEWsn3vIHzWv7CmpYp1h/MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXA68nZQjOGD/PDzJBaGwKZm28keetNGJ2jBM6CeFQczkGOYrVrYz0fI8a0XFAZTu
	 sXvN3nYU3ofpYd+aiNgtWb1DE/Z86usuoIXe3FYWobZzWC9NZ4zdhh7e3IP+AaJZcK
	 6R5fHkIBcPShjn7jRLyfsBW0j7X9XuBtAYEv7fbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 031/379] mmc: core: Use mrq.sbc in close-ended ffu
Date: Wed, 21 Feb 2024 14:03:30 +0100
Message-ID: <20240221125955.838702011@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avri Altman <avri.altman@wdc.com>

commit 4d0c8d0aef6355660b6775d57ccd5d4ea2e15802 upstream.

Field Firmware Update (ffu) may use close-ended or open ended sequence.
Each such sequence is comprised of a write commands enclosed between 2
switch commands - to and from ffu mode. So for the close-ended case, it
will be: cmd6->cmd23-cmd25-cmd6.

Some host controllers however, get confused when multi-block rw is sent
without sbc, and may generate auto-cmd12 which breaks the ffu sequence.
I encountered  this issue while testing fwupd (github.com/fwupd/fwupd)
on HP Chromebook x2, a qualcomm based QC-7c, code name - strongbad.

Instead of a quirk, or hooking the request function of the msm ops,
it would be better to fix the ioctl handling and make it use mrq.sbc
instead of issuing SET_BLOCK_COUNT separately.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231129092535.3278-1-avri.altman@wdc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |   46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -346,6 +346,10 @@ struct mmc_blk_ioc_data {
 	struct mmc_ioc_cmd ic;
 	unsigned char *buf;
 	u64 buf_bytes;
+	unsigned int flags;
+#define MMC_BLK_IOC_DROP	BIT(0)	/* drop this mrq */
+#define MMC_BLK_IOC_SBC	BIT(1)	/* use mrq.sbc */
+
 	struct mmc_rpmb_data *rpmb;
 };
 
@@ -447,7 +451,7 @@ static int card_busy_detect(struct mmc_c
 }
 
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
-			       struct mmc_blk_ioc_data *idata)
+			       struct mmc_blk_ioc_data **idatas, int i)
 {
 	struct mmc_command cmd = {}, sbc = {};
 	struct mmc_data data = {};
@@ -455,10 +459,18 @@ static int __mmc_blk_ioctl_cmd(struct mm
 	struct scatterlist sg;
 	int err;
 	unsigned int target_part;
+	struct mmc_blk_ioc_data *idata = idatas[i];
+	struct mmc_blk_ioc_data *prev_idata = NULL;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
 
+	if (idata->flags & MMC_BLK_IOC_DROP)
+		return 0;
+
+	if (idata->flags & MMC_BLK_IOC_SBC)
+		prev_idata = idatas[i - 1];
+
 	/*
 	 * The RPMB accesses comes in from the character device, so we
 	 * need to target these explicitly. Else we just target the
@@ -525,7 +537,7 @@ static int __mmc_blk_ioctl_cmd(struct mm
 			return err;
 	}
 
-	if (idata->rpmb) {
+	if (idata->rpmb || prev_idata) {
 		sbc.opcode = MMC_SET_BLOCK_COUNT;
 		/*
 		 * We don't do any blockcount validation because the max size
@@ -533,6 +545,8 @@ static int __mmc_blk_ioctl_cmd(struct mm
 		 * 'Reliable Write' bit here.
 		 */
 		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+		if (prev_idata)
+			sbc.arg = prev_idata->ic.arg;
 		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		mrq.sbc = &sbc;
 	}
@@ -544,6 +558,15 @@ static int __mmc_blk_ioctl_cmd(struct mm
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
+	if (prev_idata) {
+		memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
+		if (sbc.error) {
+			dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
+							__func__, sbc.error);
+			return sbc.error;
+		}
+	}
+
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
 						__func__, cmd.error);
@@ -985,6 +1008,20 @@ static inline void mmc_blk_reset_success
 	md->reset_done &= ~type;
 }
 
+static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)
+{
+	struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
+	int i;
+
+	for (i = 1; i < mq_rq->ioc_count; i++) {
+		if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
+		    mmc_op_multi(idata[i]->ic.opcode)) {
+			idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
+			idata[i]->flags |= MMC_BLK_IOC_SBC;
+		}
+	}
+}
+
 /*
  * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
@@ -1012,11 +1049,14 @@ static void mmc_blk_issue_drv_op(struct
 			if (ret)
 				break;
 		}
+
+		mmc_blk_check_sbc(mq_rq);
+
 		fallthrough;
 	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
 		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
-			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
+			ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
 			if (ret)
 				break;
 		}



