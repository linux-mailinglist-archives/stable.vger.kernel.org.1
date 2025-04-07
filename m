Return-Path: <stable+bounces-128706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0DA7EAFC
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E6817EE70
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F94268FE3;
	Mon,  7 Apr 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTo2BbCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695CD268FD7;
	Mon,  7 Apr 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049709; cv=none; b=PEANvEqzjj4zMk89hExpoFjLIDQt8wMDm+yCx2PWCuRefKpjAksJiR4rQiwkN9FDCUHwzfSQRVAFT1BWfGGQooWYzwMQsmwhwDFwZLaygGiDO1TpJZXFlg7FT0BhNtZ7LnNYgFqiQSFwe5Xso9WE420M7uVZblnzAW+0fKXOZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049709; c=relaxed/simple;
	bh=Hpj0HI/EL4zLHw6U8AP86d/sHXKseWAfDHOW99FcWh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmtzRHvo3P3crdjqsTxPqN3SOb+QZu0weI9ON6NRmhlPLSmm+R96hxh7j+IGE8gamXULmY8PPq8brtBZKFf154WJdvO3bBeVUEbjp7w8fVmxdI0wk3HQD5nwgK8T3XlppIECbrroDiryVLKmcV7DztyutrcxZudqeiVP93dBwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTo2BbCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F908C4CEDD;
	Mon,  7 Apr 2025 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049709;
	bh=Hpj0HI/EL4zLHw6U8AP86d/sHXKseWAfDHOW99FcWh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTo2BbCT2o4bxIVQS4RK/L4i0puz9v9cDxo87jAEFBUa1dPMdPRdJvafohUHmrmaf
	 0U1qpc0ugG49fEI0Cjvo9JX6MmFzeJgtLTT2k10DHnzJe+eh+RfOIJh/Oh/tF8Pehk
	 0JplYvwWAgqlZA+UucsRCyW1d7wDcxnTS7Bfttpr+3yDmf+nsElFV1E54sreJWhAFk
	 jz4l2ISbnEeSUicqRyv6uHKkc3DA0q8qKTXdY6SJ6fCB36UFjRY/5XpNiCiRlKVch+
	 bZA52+WgEW3gY89LpEmS6hnLXZ/KFpLRhgns+Gg+pF2ajfVyoButw7UOzaQFmFcMmi
	 dNNgQrH8T0ISQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Thomas Lynema <lyz27@yahoo.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/13] thunderbolt: Scan retimers after device router has been enumerated
Date: Mon,  7 Apr 2025 14:14:44 -0400
Message-Id: <20250407181449.3183687-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 75749d2c1d8cef439f8b69fa1f4f36d0fc3193e6 ]

Thomas reported connection issues on AMD system with Pluggable UD-4VPD
dock. After some experiments it looks like the device has some sort of
internal timeout that triggers reconnect. This is completely against the
USB4 spec, as there is no requirement for the host to enumerate the
device right away or even at all.

In Linux case the delay is caused by scanning of retimers on the link so
we can work this around by doing the scanning after the device router
has been enumerated.

Reported-by: Thomas Lynema <lyz27@yahoo.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219748
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/tb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c592032657a1e..0668e1645bc50 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -640,11 +640,15 @@ static void tb_scan_port(struct tb_port *port)
 		goto out_rpm_put;
 	}
 
-	tb_retimer_scan(port, true);
-
 	sw = tb_switch_alloc(port->sw->tb, &port->sw->dev,
 			     tb_downstream_route(port));
 	if (IS_ERR(sw)) {
+		/*
+		 * Make the downstream retimers available even if there
+		 * is no router connected.
+		 */
+		tb_retimer_scan(port, true);
+
 		/*
 		 * If there is an error accessing the connected switch
 		 * it may be connected to another domain. Also we allow
@@ -704,6 +708,14 @@ static void tb_scan_port(struct tb_port *port)
 	tb_switch_lane_bonding_enable(sw);
 	/* Set the link configured */
 	tb_switch_configure_link(sw);
+	/*
+	 * Scan for downstream retimers. We only scan them after the
+	 * router has been enumerated to avoid issues with certain
+	 * Pluggable devices that expect the host to enumerate them
+	 * within certain timeout.
+	 */
+	tb_retimer_scan(port, true);
+
 	/*
 	 * CL0s and CL1 are enabled and supported together.
 	 * Silently ignore CLx enabling in case CLx is not supported.
-- 
2.39.5


