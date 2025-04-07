Return-Path: <stable+bounces-128619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68210A7E9F0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A542A1891988
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D967257AE8;
	Mon,  7 Apr 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEeMg8tx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AF257ACF;
	Mon,  7 Apr 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049506; cv=none; b=T0mBBWx8TmmBW6w+qLXy1kyJ69oJ9I3kAmoBYm3hAX5bwQwEuG6yeq+LDlEOQ/7sQ3zItGjaZxtHdEJZTkL4NKPE0tGupXlQDghdNe5AkRNSJPMBz61l0O/dMfbF3CNBDoB4nQObm8AWopkMn+g+xWnqITBWH4JQAbEyZSvYzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049506; c=relaxed/simple;
	bh=LuNWxjWkBC7Yri3h83ygQs28FdxNmO2jbFGl+Oqz1vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2L0hHqRXRSv/8fmjFVNhpNj1nng+lxXOv7yP/O7MvlBq9IgPpILPeuN2nZTVwjEycQ5XBM2geWDCEK8UJ75Q3ooTL1GPdicjoPvHt828/+NY5sjOyVcyWGNqk/Y7SsUOfYHH2n9A86M13AcK1uCufpQZNqcTRzGSwsm0MUz6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEeMg8tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E91C4CEE7;
	Mon,  7 Apr 2025 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049505;
	bh=LuNWxjWkBC7Yri3h83ygQs28FdxNmO2jbFGl+Oqz1vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEeMg8txAaWP26L1wY0M2HAxrld6lvpdOi0rJx5nBg7keqcbRFWGtDaYgq+0F3o3d
	 RQutUTS5/ovGI8e8z3Vkl5646HbIC9svkn7+eXLMDP6o7HyKg3XBDbmq4qGUSNqUPe
	 VnHRogUPXdxI1PExNc2E/PSX02vQOGKCSKXarubqJ6ruuocthilERf0JBqOynIZPSt
	 BPNThHvz/Eau7phxkuaxfa7vzqc30iZ90/sJMDw4w5TO8COg0qbjKyjzDRWaXUad4k
	 Y2wt+lFdvQRVpeHJTPdyM/rzV8CzwZnrzkXWpDiaMaAAIVLskBwyOccYJX/Uydr/5b
	 bKMv9XJbudZJA==
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
Subject: [PATCH AUTOSEL 6.14 22/31] thunderbolt: Scan retimers after device router has been enumerated
Date: Mon,  7 Apr 2025 14:10:38 -0400
Message-Id: <20250407181054.3177479-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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
index 390abcfe71882..8c527af989271 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1305,11 +1305,15 @@ static void tb_scan_port(struct tb_port *port)
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
@@ -1359,6 +1363,14 @@ static void tb_scan_port(struct tb_port *port)
 	upstream_port = tb_upstream_port(sw);
 	tb_configure_link(port, upstream_port, sw);
 
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


