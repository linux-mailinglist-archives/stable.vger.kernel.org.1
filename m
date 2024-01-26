Return-Path: <stable+bounces-15952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FA83E509
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0CC1F235A9
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7145C0E;
	Fri, 26 Jan 2024 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cnYYsHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A742557F
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307396; cv=none; b=kcFPXR+HGBOoeFUJaUmfHxNtMOXVjU7/ojw8jrxmYQym9mVycz50q5BnoTxgJmU2/3OmsTerFAlIbrQBgLN0Y8cYwHvMA+jTNXk1U3sl+6k4/HzsitWVhT06CLhJg6hh16s/h8KzDQE2lv32UWhcu0t/9WjwYmWlBNPCzpG4bU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307396; c=relaxed/simple;
	bh=CYqU9rULUjnZhiG7RFaYFtQXPHlpGc+tVTyJF7OlSh4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ljeCthTxTC2wKwUnDJXG74/SMujdgO85m2GE9Cy7kmdw3dxpzSTUQ+hX/RQGHBeqNy3gZWf6KUJjATKacwrznPvknJyn7zrdPnXtkKcpSYvDQuuUCdnJ8u6ExdNqMnoctXcIRV7QXcdkroukbSzgwymJJZYAWXIKXWfIfyefGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1cnYYsHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C713C433C7;
	Fri, 26 Jan 2024 22:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706307395;
	bh=CYqU9rULUjnZhiG7RFaYFtQXPHlpGc+tVTyJF7OlSh4=;
	h=Subject:To:Cc:From:Date:From;
	b=1cnYYsHK1JiOOcixsl2YIeX+wVJ0kCuBV0IRuWYZYyyou2fg5GSKeYbBlElRyGN69
	 3D5kFXGZeDBkcqIkHx7mKG5RlhI32J1cqksx3gN4OeWF+h+NeeB1CcLLPsC0rhayZK
	 YvOJ/WkYhwvDnDfdZUOXrtKScxtoxHqsL8cVi+NE=
Subject: FAILED: patch "[PATCH] bus: mhi: ep: Do not allocate event ring element on stack" failed to apply to 6.1-stable tree
To: manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:16:34 -0800
Message-ID: <2024012634-shone-cork-03d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 987fdb5a43a66764808371b54e6047834170d565
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012634-shone-cork-03d7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

987fdb5a43a6 ("bus: mhi: ep: Do not allocate event ring element on stack")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 987fdb5a43a66764808371b54e6047834170d565 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Fri, 1 Sep 2023 13:05:02 +0530
Subject: [PATCH] bus: mhi: ep: Do not allocate event ring element on stack

It is possible that the host controller driver would use DMA framework to
write the event ring element. So avoid allocating event ring element on the
stack as DMA cannot work on vmalloc memory.

Cc: stable@vger.kernel.org
Fixes: 961aeb689224 ("bus: mhi: ep: Add support for sending events to the host")
Link: https://lore.kernel.org/r/20230901073502.69385-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 600881808982..e2513f5f47a6 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -71,45 +71,77 @@ static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
 static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
 					struct mhi_ring_element *tre, u32 len, enum mhi_ev_ccs code)
 {
-	struct mhi_ring_element event = {};
+	struct mhi_ring_element *event;
+	int ret;
+
+	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
 
-	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
-	event.dword[0] = MHI_TRE_EV_DWORD0(code, len);
-	event.dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
+	event->ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
+	event->dword[0] = MHI_TRE_EV_DWORD0(code, len);
+	event->dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
 
-	return mhi_ep_send_event(mhi_cntrl, ring->er_index, &event, MHI_TRE_DATA_GET_BEI(tre));
+	ret = mhi_ep_send_event(mhi_cntrl, ring->er_index, event, MHI_TRE_DATA_GET_BEI(tre));
+	kfree(event);
+
+	return ret;
 }
 
 int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
 {
-	struct mhi_ring_element event = {};
+	struct mhi_ring_element *event;
+	int ret;
+
+	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
 
-	event.dword[0] = MHI_SC_EV_DWORD0(state);
-	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
+	event->dword[0] = MHI_SC_EV_DWORD0(state);
+	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
 
-	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
+	kfree(event);
+
+	return ret;
 }
 
 int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env)
 {
-	struct mhi_ring_element event = {};
+	struct mhi_ring_element *event;
+	int ret;
+
+	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
 
-	event.dword[0] = MHI_EE_EV_DWORD0(exec_env);
-	event.dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
+	event->dword[0] = MHI_EE_EV_DWORD0(exec_env);
+	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
 
-	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
+	kfree(event);
+
+	return ret;
 }
 
 static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
 {
 	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_cmd->ring;
-	struct mhi_ring_element event = {};
+	struct mhi_ring_element *event;
+	int ret;
+
+	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
 
-	event.ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(struct mhi_ring_element));
-	event.dword[0] = MHI_CC_EV_DWORD0(code);
-	event.dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
+	event->ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(struct mhi_ring_element));
+	event->dword[0] = MHI_CC_EV_DWORD0(code);
+	event->dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
 
-	return mhi_ep_send_event(mhi_cntrl, 0, &event, 0);
+	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
+	kfree(event);
+
+	return ret;
 }
 
 static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)


