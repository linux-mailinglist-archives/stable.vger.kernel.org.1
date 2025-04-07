Return-Path: <stable+bounces-128690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F5A7EA97
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB43F7A5C52
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063A267394;
	Mon,  7 Apr 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZ7ZjyI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93026738A;
	Mon,  7 Apr 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049677; cv=none; b=gh2dy0M6UAcOs2PBT/X005V0308eS/iP+AkbkAFIWP1C9lXrhwYBwi2B2YPT0uPCuRz0bvy99bJHaDPcP8XyeM3Z8d7vRC2hvd55mrsbd0gB2/s5geDAdsGZ34tAxEYJVsQCH7KxjL9+fswUUazBnKZAfVOIsNorciNeq+ba3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049677; c=relaxed/simple;
	bh=JGMkSn6XJNklsKgrDLAMkst2bX5kx4YPq5O4LV0Hbhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJUbnl2mXVXUwqYYiz13PfcdpGD/L4k1MTY6kYN6+8V+Uf9GcWbYzff5P+uyKlQqfRQgNPPbqgiojSJKP56OVmlCtJCYdYnEGvILceVsQyNt9yOcB+nPUYgb3AFBKFSBCh3LWjXpANu1Y/1gHSO6ez+Un/L3KV0Dd9imAxQ24pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZ7ZjyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7C7C4CEDD;
	Mon,  7 Apr 2025 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049677;
	bh=JGMkSn6XJNklsKgrDLAMkst2bX5kx4YPq5O4LV0Hbhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXZ7ZjyIYUBoOZaQXUiRSTvuXp1scUOTtMhMIgxRFcW0vkU5pjE5oj4dgyoC2bs5v
	 +Ru8r3z3tyn8YWuOJsUfsmvmg2XoAdLsbPwbZ/DXw+E6Md/lGWv+kWIMJPSUIfYujz
	 1AB9ioJXf89zZ1myuxcZvOz8ao4FUtD1pHLtoOMCiyiqnuHFwyODxMercK5T8at/xb
	 Bvd2TtVqm+2UM2PpqUyjedo1yzE7+WMgV5CDNB8of9hokTiZ3Vu+DgCAs9KxfXCzsz
	 L2/QZCuiYxdZZPSXd7U7W38CIb/62PC3smu5wrUIEWQdm4BO13T41q2lav8zK5sx3m
	 gNVNYkvRG1FBA==
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
Subject: [PATCH AUTOSEL 6.6 10/15] thunderbolt: Scan retimers after device router has been enumerated
Date: Mon,  7 Apr 2025 14:14:10 -0400
Message-Id: <20250407181417.3183475-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
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
index 7c3310a2b28a4..b92a8a5b2e8c9 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1370,11 +1370,15 @@ static void tb_scan_port(struct tb_port *port)
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
@@ -1424,6 +1428,14 @@ static void tb_scan_port(struct tb_port *port)
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


