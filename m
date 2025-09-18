Return-Path: <stable+bounces-170920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A5DB2A6D6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301C858396C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA45322DA7;
	Mon, 18 Aug 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O70VMw53"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C5322776;
	Mon, 18 Aug 2025 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524229; cv=none; b=ClQKREnWi3AUW1Y3ytyxYdIb1I2mjnkn+4GfI8kYWPreY3ENtBxOzOdHvsHhakE/9p+cv9l7YwHkrKZ53QKFJgAJ7nWWpFKEOUvvJd7+u8uaQFhNYm4z+u7G4zwfOdLCeSmboPueL0i34lMcVuuQIlnKXf514ihDvXbMV7E5AV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524229; c=relaxed/simple;
	bh=cNKTASlWc1g1MYoOp7/ofXy0STBCNcvlXenzeZjy60I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkfS8S9gnyFZBgMljD8bCai1O3+QGzhtBqpfpqiwnFfE00U/2kRNFqepkteAz1XPs0OnZM8O7hC1Vg5gsQkID+1kawZsSrkc0I0yhY2DnsfbaeGLXF3b/2XtOJWloR7EShly5mBBWKOgiUPqCtpyHUYTcyqZoo3BgvHZksdlahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O70VMw53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE5FC4CEEB;
	Mon, 18 Aug 2025 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524229;
	bh=cNKTASlWc1g1MYoOp7/ofXy0STBCNcvlXenzeZjy60I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O70VMw538Yo4skEgVTtGRDjj0A08qVUws3WFufQs+DHQP6ZmFi/wNUG4PNZqWnH8V
	 N0epSNsAi010LzebGSlfdNQyRQisd4RI2Zv9DjZ5naFQBlhDxMPjqognOJaR73N8ea
	 DW5xxAJTaCJhlrE3QIPr5vHPl2xxveQBlO0SFqTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 408/515] scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans
Date: Mon, 18 Aug 2025 14:46:34 +0200
Message-ID: <20250818124514.120633624@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit 37c4e72b0651e7697eb338cd1fb09feef472cc1a ]

sas_user_scan() did not fully process wildcard channel scans
(SCAN_WILD_CARD) when a transport-specific user_scan() callback was
present. Only channel 0 would be scanned via user_scan(), while the
remaining channels were skipped, potentially missing devices.

user_scan() invokes updated sas_user_scan() for channel 0, and if
successful, iteratively scans remaining channels (1 to
shost->max_channel) via scsi_scan_host_selected().  This ensures complete
wildcard scanning without affecting transport-specific scanning behavior.

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Link: https://lore.kernel.org/r/20250624061649.17990-1-ranjan.kumar@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_scan.c          |  2 +-
 drivers/scsi/scsi_transport_sas.c | 60 ++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 4833b8fe251b..396fcf194b6b 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1899,7 +1899,7 @@ int scsi_scan_host_selected(struct Scsi_Host *shost, unsigned int channel,
 
 	return 0;
 }
-
+EXPORT_SYMBOL(scsi_scan_host_selected);
 static void scsi_sysfs_add_devices(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 351b028ef893..d69c7c444a31 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -40,6 +40,8 @@
 #include <scsi/scsi_transport_sas.h>
 
 #include "scsi_sas_internal.h"
+#include "scsi_priv.h"
+
 struct sas_host_attrs {
 	struct list_head rphy_list;
 	struct mutex lock;
@@ -1683,32 +1685,66 @@ int scsi_is_sas_rphy(const struct device *dev)
 }
 EXPORT_SYMBOL(scsi_is_sas_rphy);
 
-
-/*
- * SCSI scan helper
- */
-
-static int sas_user_scan(struct Scsi_Host *shost, uint channel,
-		uint id, u64 lun)
+static void scan_channel_zero(struct Scsi_Host *shost, uint id, u64 lun)
 {
 	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
 	struct sas_rphy *rphy;
 
-	mutex_lock(&sas_host->lock);
 	list_for_each_entry(rphy, &sas_host->rphy_list, list) {
 		if (rphy->identify.device_type != SAS_END_DEVICE ||
 		    rphy->scsi_target_id == -1)
 			continue;
 
-		if ((channel == SCAN_WILD_CARD || channel == 0) &&
-		    (id == SCAN_WILD_CARD || id == rphy->scsi_target_id)) {
+		if (id == SCAN_WILD_CARD || id == rphy->scsi_target_id) {
 			scsi_scan_target(&rphy->dev, 0, rphy->scsi_target_id,
 					 lun, SCSI_SCAN_MANUAL);
 		}
 	}
-	mutex_unlock(&sas_host->lock);
+}
 
-	return 0;
+/*
+ * SCSI scan helper
+ */
+
+static int sas_user_scan(struct Scsi_Host *shost, uint channel,
+		uint id, u64 lun)
+{
+	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
+	int res = 0;
+	int i;
+
+	switch (channel) {
+	case 0:
+		mutex_lock(&sas_host->lock);
+		scan_channel_zero(shost, id, lun);
+		mutex_unlock(&sas_host->lock);
+		break;
+
+	case SCAN_WILD_CARD:
+		mutex_lock(&sas_host->lock);
+		scan_channel_zero(shost, id, lun);
+		mutex_unlock(&sas_host->lock);
+
+		for (i = 1; i <= shost->max_channel; i++) {
+			res = scsi_scan_host_selected(shost, i, id, lun,
+						      SCSI_SCAN_MANUAL);
+			if (res)
+				goto exit_scan;
+		}
+		break;
+
+	default:
+		if (channel < shost->max_channel) {
+			res = scsi_scan_host_selected(shost, channel, id, lun,
+						      SCSI_SCAN_MANUAL);
+		} else {
+			res = -EINVAL;
+		}
+		break;
+	}
+
+exit_scan:
+	return res;
 }
 
 
-- 
2.39.5




