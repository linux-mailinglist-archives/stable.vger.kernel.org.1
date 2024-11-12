Return-Path: <stable+bounces-92473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FD9C5510
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF250B37DE8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3902141A9;
	Tue, 12 Nov 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHOznfuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72640213EFE;
	Tue, 12 Nov 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407769; cv=none; b=C5XwzfLvMd/pAFysldZOLrD8fbRAIUhx7+bZutjEwJYHv57UvoX/0V4OVnZnJZnzwYEHJ4AfC7Jkp1q1Z4RmNvVdIbURwyxOlDceDBYRwX4XotUt+oO64e3M1Hy72GA5ITwDV5sv2uOIuX5d96xkdKV04JodCYrbF1mKVFRIl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407769; c=relaxed/simple;
	bh=Ja4POKk5WcUW9q+HbkxBJF753EhM3kQ/XNrIxY2J64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeEyHk02mVjzDQD5hIrvxa+ukHRTeu5afhqqILzhiHk0a/5oaNsKOBB7gbgpGvHXRnNPR7R+MZsqnWG2Jq9zpvzzEEZSuvEJ/bwf4nSXKjwiejtIEXZpGrAVOMPW/5U/zzJAvOcAkQSldg19XvCzmNIyoly9BYHfYUAnvxGSOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHOznfuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322EFC4CED6;
	Tue, 12 Nov 2024 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407769;
	bh=Ja4POKk5WcUW9q+HbkxBJF753EhM3kQ/XNrIxY2J64A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHOznfuBi3l21PMFSXcXmloVLlTXJIlUNa7mCmSy2PALvTctkEf8Ud3ivuO2LCduq
	 CxsknAhWVtdU5EmjxUOXBkLYMSEhmHA/ajCSRJ5SSrQ+bCigzqZNEo1YR94t+YYFY+
	 ujBHqBRHpoHA2x9wmj7YowcwCKFh6he7kx/02EJZS773te6BZR8nk6iW+RebiG1g3C
	 uYeAikohjDa3zEIjc457HNk4/3KWeTQs70R3xLFdvqBPJRddMpkzs6EgBJM6ab7IG8
	 APyGs2eVtQpS1JYsb3eBR0hMNifxe5vAfB2Y1Xi8M0QiANTw19R+TJax98haVGnhQL
	 4jKv92TZy2STQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 02/16] firmware: arm_scmi: Reject clear channel request on A2P
Date: Tue, 12 Nov 2024 05:35:44 -0500
Message-ID: <20241112103605.1652910-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit a0a18e91eb3a6ef75a6de69dc00f206b913e3848 ]

The clear channel transport operation is supposed to be called exclusively
on the P2A channel from the agent, since it relinquishes the ownership of
the channel to the platform, after this latter has initiated some sort of
P2A communication.

Make sure that, if it is ever called on a A2P, is logged and ignored.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Message-Id: <20241021171544.2579551-1-cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/common.h | 2 ++
 drivers/firmware/arm_scmi/driver.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4b8c5250cdb57..cd30499b2555f 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -163,6 +163,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
  *      used to initialize this channel
  * @dev: Reference to device in the SCMI hierarchy corresponding to this
  *	 channel
+ * @is_p2a: A flag to identify a channel as P2A (RX)
  * @rx_timeout_ms: The configured RX timeout in milliseconds.
  * @handle: Pointer to SCMI entity handle
  * @no_completion_irq: Flag to indicate that this channel has no completion
@@ -174,6 +175,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
 struct scmi_chan_info {
 	int id;
 	struct device *dev;
+	bool is_p2a;
 	unsigned int rx_timeout_ms;
 	struct scmi_handle *handle;
 	bool no_completion_irq;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index dc09f2d755f41..80b44bd1a3f3e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1034,6 +1034,11 @@ static inline void scmi_xfer_command_release(struct scmi_info *info,
 static inline void scmi_clear_channel(struct scmi_info *info,
 				      struct scmi_chan_info *cinfo)
 {
+	if (!cinfo->is_p2a) {
+		dev_warn(cinfo->dev, "Invalid clear on A2P channel !\n");
+		return;
+	}
+
 	if (info->desc->ops->clear_channel)
 		info->desc->ops->clear_channel(cinfo);
 }
@@ -2614,6 +2619,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	if (!cinfo)
 		return -ENOMEM;
 
+	cinfo->is_p2a = !tx;
 	cinfo->rx_timeout_ms = info->desc->max_rx_timeout_ms;
 
 	/* Create a unique name for this transport device */
-- 
2.43.0


