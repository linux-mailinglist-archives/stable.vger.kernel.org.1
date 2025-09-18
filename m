Return-Path: <stable+bounces-179986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA5B7E34E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A0C1B25958
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AD21F09B6;
	Wed, 17 Sep 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lkwplzpr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BA1C07C4;
	Wed, 17 Sep 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113021; cv=none; b=lgrpRftN/MpPGy4PXW5og8Djvr1fKyhfu1u8lrKn5K8OqyiI5cO+lyWL4cPs6s5m3fJVKKOzs9LsETFwk8n4wvXlHlNAdiC4yOLS067IWPcRGe6g8nHFJfOIzBpIyH0IXwNZZFjEOTUn/n059yJHdAZzhAZPX1tUhmqWDKNu268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113021; c=relaxed/simple;
	bh=qayx0X55qicu9vsZpZscDqcregRaCEsCQvRC//96V9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDGZxgnRmdA3kHjCIvS1Y2j3odT9MA4XV1J+7gBDG+bP5FkgLlGlrrG1jiKTDtXeuQnwINnRup3zdRENuugoy9vCpdZJ9yRa8lQFmyEbs50mC65xNqd7P+/gPUx1tJknTNAwUJt94UgaGw0l3GzPsj43cw8sEHMCmDmAM7PqSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lkwplzpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15AC4CEF0;
	Wed, 17 Sep 2025 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113021;
	bh=qayx0X55qicu9vsZpZscDqcregRaCEsCQvRC//96V9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkwplzprW4bZdpptdz7pWdcUvAwUpuG1RLHkqwGbpTdmj9feq9ouc8WHCsmkoTQZf
	 nkMzjF5y+WPgSuJt6+tCApCPDgbaSxZn8e7PYTkCXrs94I4kxZqzMOqpdDKFj7+YVF
	 oSwx1cg//FIcRiCzQuD2/Q4SzQyt6Kjb6yz9n5Us=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 145/189] net: dev_ioctl: take ops lock in hwtstamp lower paths
Date: Wed, 17 Sep 2025 14:34:15 +0200
Message-ID: <20250917123355.411141542@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit 686cab5a18e443e1d5f2abb17bed45837836425f ]

ndo hwtstamp callbacks are expected to run under the per-device ops
lock. Make the lower get/set paths consistent with the rest of ndo
invocations.

Kernel log:
WARNING: CPU: 13 PID: 51364 at ./include/net/netdev_lock.h:70 __netdev_update_features+0x4bd/0xe60
...
RIP: 0010:__netdev_update_features+0x4bd/0xe60
...
Call Trace:
<TASK>
netdev_update_features+0x1f/0x60
mlx5_hwtstamp_set+0x181/0x290 [mlx5_core]
mlx5e_hwtstamp_set+0x19/0x30 [mlx5_core]
dev_set_hwtstamp_phylib+0x9f/0x220
dev_set_hwtstamp_phylib+0x9f/0x220
dev_set_hwtstamp+0x13d/0x240
dev_ioctl+0x12f/0x4b0
sock_ioctl+0x171/0x370
__x64_sys_ioctl+0x3f7/0x900
? __sys_setsockopt+0x69/0xb0
do_syscall_64+0x6f/0x2e0
entry_SYSCALL_64_after_hwframe+0x4b/0x53
...
</TASK>
....
---[ end trace 0000000000000000 ]---

Note that the mlx5_hwtstamp_set and mlx5e_hwtstamp_set functions shown
in the trace come from an in progress patch converting the legacy ioctl
to ndo_hwtstamp_get/set and are not present in mainline.

Fixes: ffb7ed19ac0a ("net: hold netdev instance lock during ioctl operations")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Link: https://patch.msgid.link/20250907080821.2353388-1-cjubran@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev_ioctl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 616479e714663..9447065d01afb 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -464,8 +464,15 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_get)
-		return dev_get_hwtstamp_phylib(dev, kernel_cfg);
+	if (ops->ndo_hwtstamp_get) {
+		int err;
+
+		netdev_lock_ops(dev);
+		err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
+		netdev_unlock_ops(dev);
+
+		return err;
+	}
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
@@ -481,8 +488,15 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_set)
-		return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+	if (ops->ndo_hwtstamp_set) {
+		int err;
+
+		netdev_lock_ops(dev);
+		err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+		netdev_unlock_ops(dev);
+
+		return err;
+	}
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
-- 
2.51.0




