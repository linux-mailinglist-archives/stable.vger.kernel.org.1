Return-Path: <stable+bounces-92501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB59C5487
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECF32877F9
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213721B45C;
	Tue, 12 Nov 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEgtbRK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499D21B44B;
	Tue, 12 Nov 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407807; cv=none; b=K1pFnYtoAhBDfcIlBl89+/5iRLgdiHgwx7P4/N+SyyynGO3c8TwUQGuv5CPo7CuIlrKPteGHLmFIdLXBkXq/OdWk0LLHdul2Lv4hGgfpZuW+OFGZTOgGFRc3HdCDwj8M7VcMhWcemAZEmw5g6pnCxPvGmqCfAscccKAav03ss1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407807; c=relaxed/simple;
	bh=hUbS/ZJ6YPF2GQ/J2PZx9O/TNmMSuETAVHSQTSDP0Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLdzv99ZIu0VLWZIsyDrT4Ow4MU/zkft7fd9iT99kkWsZS8TPgkoyHLziXxN125tqKWthR7LBqxFJpsnaXXtesuyQclFyeGGAJs/KXuTt430EAbJsMrSVGMUK9d9d1ZbYvj6OE0HNBF9szx6WTBjvROZwWALKYw8TDfc0dHLHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEgtbRK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54EC4CED4;
	Tue, 12 Nov 2024 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407807;
	bh=hUbS/ZJ6YPF2GQ/J2PZx9O/TNmMSuETAVHSQTSDP0Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEgtbRK+PdcO7US83LifW/8L57tLy1LeXxuKxhxvcMpNgRg5yKldqdons/4FNh3Nu
	 afgzj5slCXwleXKnYl+4EzYyNbvOk0e2zp5In/XuaqdoGi7YsxTGGqWKKyPzQ1Q5tO
	 JUgj5tcZwA10j8PlSvc5KKH1QVzAkwer6UVV0fIp2K829bROUCHaBI1f83ZcJcEN7e
	 0tvi8bq//+0D0t5qdoSlkN76WZaO9tb33bvHfKt+cZjoSO6yuskUN0g+7my4fwIZM5
	 43yaFmzzif/opmw7RBBd5WNoKthNLNqhM1PqhNOZT0EiJH4m8nFxGU9nW+xk2PF+ww
	 EU6K/fxjF9KgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 02/15] firmware: arm_scmi: Reject clear channel request on A2P
Date: Tue, 12 Nov 2024 05:36:23 -0500
Message-ID: <20241112103643.1653381-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
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
index 00b165d1f502d..039f686f4580d 100644
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
index 3962683e2af9d..efa9698c876a0 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -855,6 +855,11 @@ static inline void scmi_xfer_command_release(struct scmi_info *info,
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
@@ -2319,6 +2324,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	if (!cinfo)
 		return -ENOMEM;
 
+	cinfo->is_p2a = !tx;
 	cinfo->rx_timeout_ms = info->desc->max_rx_timeout_ms;
 
 	/* Create a unique name for this transport device */
-- 
2.43.0


