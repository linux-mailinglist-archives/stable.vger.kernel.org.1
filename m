Return-Path: <stable+bounces-15949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1483E501
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E348EB24C89
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF49249E6;
	Fri, 26 Jan 2024 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSdpPZlT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7625637
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307375; cv=none; b=An1B6qOe8WO9ZnUQg8PTRzyn+mkKTr3AR6RuSfVQtFz8WzRZSlodi8nd04cw917JMHDMVDBHzSPCpZ4th0Dvj3Fs6HmLRUKQZxtjs+VCFnK1FZGzctkKOmEn+2NTq2F9NAllxiElBi6cyvjh+Fyqk41eSSA7IJj9MmglN5E6g8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307375; c=relaxed/simple;
	bh=LD0An/veDf7q84kDGgzj4DT1DRsq1/2Lb/0W0q3QqQ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d5F0QF3R4nyLjzj4CzObJ3J/CGM9E15gpwhWoOqotphynnSVAm5BbF0wAMhz6z85MMfcPctRERKtd75cbmfVqC8NhjymKDdPflP6ONqU1zPkDm+ElA+bTg1g0qNvlUeSZn2zt/o7CilrMKGGBLVaKBxLSaGCjqMjZsQvxcvNuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSdpPZlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F7AC43390;
	Fri, 26 Jan 2024 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706307375;
	bh=LD0An/veDf7q84kDGgzj4DT1DRsq1/2Lb/0W0q3QqQ8=;
	h=Subject:To:Cc:From:Date:From;
	b=HSdpPZlTNP9dxr/RhUChkdxJM3N7E1gq7dVugkQLmRvhgmq4S8eNtpNlxeJ0UmpWe
	 pMEI2Fj05DwQ1tr4NVC4FYzbHoHF207JSGXJ2gWCXvXDdbiOZHNsl2HAhxknCMsf5c
	 g9EaYQ5qtHNGRiw3OZSBTGoUtJCoMHBRc6rnkW8I=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Add spinlock to protect WP access when" failed to apply to 5.10-stable tree
To: bbhatt@codeaurora.org,manivannan.sadhasivam@linaro.org,quic_jhugo@quicinc.com,quic_qianyu@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:16:14 -0800
Message-ID: <2024012614-satiable-cheese-4655@gregkh>
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
git cherry-pick -x b89b6a863dd53bc70d8e52d50f9cfaef8ef5e9c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012614-satiable-cheese-4655@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

b89b6a863dd5 ("bus: mhi: host: Add spinlock to protect WP access when queueing TREs")
a0f5a630668c ("bus: mhi: Move host MHI code to "host" directory")
4547a749be99 ("bus: mhi: core: Fix MHI runtime_pm behavior")
68731852f6e5 ("bus: mhi: core: Return EAGAIN if MHI ring is full")
a8f75cb348fd ("mhi: core: Factorize mhi queuing")
855a70c12021 ("bus: mhi: Add MHI PCI support for WWAN modems")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b89b6a863dd53bc70d8e52d50f9cfaef8ef5e9c9 Mon Sep 17 00:00:00 2001
From: Bhaumik Bhatt <bbhatt@codeaurora.org>
Date: Mon, 11 Dec 2023 14:42:51 +0800
Subject: [PATCH] bus: mhi: host: Add spinlock to protect WP access when
 queueing TREs

Protect WP accesses such that multiple threads queueing buffers for
incoming data do not race.

Meanwhile, if CONFIG_TRACE_IRQFLAGS is enabled, irq will be enabled once
__local_bh_enable_ip is called as part of write_unlock_bh. Hence, let's
take irqsave lock after TRE is generated to avoid running write_unlock_bh
when irqsave lock is held.

Cc: stable@vger.kernel.org
Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1702276972-41296-2-git-send-email-quic_qianyu@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index d80975f4bba8..ad7807e4b523 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1124,17 +1124,15 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (unlikely(MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)))
 		return -EIO;
 
-	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
-
 	ret = mhi_is_ring_full(mhi_cntrl, tre_ring);
-	if (unlikely(ret)) {
-		ret = -EAGAIN;
-		goto exit_unlock;
-	}
+	if (unlikely(ret))
+		return -EAGAIN;
 
 	ret = mhi_gen_tre(mhi_cntrl, mhi_chan, buf_info, mflags);
 	if (unlikely(ret))
-		goto exit_unlock;
+		return ret;
+
+	read_lock_irqsave(&mhi_cntrl->pm_lock, flags);
 
 	/* Packet is queued, take a usage ref to exit M3 if necessary
 	 * for host->device buffer, balanced put is done on buffer completion
@@ -1154,7 +1152,6 @@ static int mhi_queue(struct mhi_device *mhi_dev, struct mhi_buf_info *buf_info,
 	if (dir == DMA_FROM_DEVICE)
 		mhi_cntrl->runtime_put(mhi_cntrl);
 
-exit_unlock:
 	read_unlock_irqrestore(&mhi_cntrl->pm_lock, flags);
 
 	return ret;
@@ -1206,6 +1203,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	int eot, eob, chain, bei;
 	int ret;
 
+	/* Protect accesses for reading and incrementing WP */
+	write_lock_bh(&mhi_chan->lock);
+
 	buf_ring = &mhi_chan->buf_ring;
 	tre_ring = &mhi_chan->tre_ring;
 
@@ -1223,8 +1223,10 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 
 	if (!info->pre_mapped) {
 		ret = mhi_cntrl->map_single(mhi_cntrl, buf_info);
-		if (ret)
+		if (ret) {
+			write_unlock_bh(&mhi_chan->lock);
 			return ret;
+		}
 	}
 
 	eob = !!(flags & MHI_EOB);
@@ -1241,6 +1243,8 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	mhi_add_ring_element(mhi_cntrl, tre_ring);
 	mhi_add_ring_element(mhi_cntrl, buf_ring);
 
+	write_unlock_bh(&mhi_chan->lock);
+
 	return 0;
 }
 


