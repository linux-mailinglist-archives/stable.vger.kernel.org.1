Return-Path: <stable+bounces-59491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A709D93294A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526AB1F233A6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15D1AE0B9;
	Tue, 16 Jul 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APLrOBIo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB11A2C37;
	Tue, 16 Jul 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140233; cv=none; b=XPNu8j9cmz2woPlmWwCwmhS3sb5C/qfdzKUxunFK5yBCx8+pk2g/fJwhEjIadGYhPGIoPXMSEva8VsSmhh8ThK8q6Ohm84FeS/jW4tOEwWZ7ERfBECcF36IYwSWJlIHXV4MzmdUEis8PDC869t9/QZ4Ts9THieU1rUmQdDEjPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140233; c=relaxed/simple;
	bh=keUASYIy/pdzv4Mlgj5syXZIelt5GwXfj2iMNIRJybs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Von52lbYQK2zw+IhMWtTtbcSkovZezkp5Bd1svhSPRpgxbgBC0jjt72iISdEu+tE7umu53gkuiORALT5LLHXlpG+VnSxqvYgiiWiSXsGwiQKWNUEpY9Laqo/MehqQubXjcJGca3vFjOX0qBW4vSVgjXjJb+1/3j5GglrIhu1fHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APLrOBIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC63FC4AF09;
	Tue, 16 Jul 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140233;
	bh=keUASYIy/pdzv4Mlgj5syXZIelt5GwXfj2iMNIRJybs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APLrOBIob0nHtx/wQrLIrMsGfBlL187ZsYcM3Uisk9/FCZRB8q13f8mc4z/pjPwXj
	 Zu0Anl8tnIVUcpmQsY7bPO/k5bUpBV3e6/vEbY3k9SmJU4o3nqYwENABmGB0ta5hkP
	 2iOwW1yZNVZg23XDy2sklX3KIda+qR6bR4fJKdGm3i9tnyVLrbj1egwG7cvrktnaGM
	 G9DjmdoIpCcGMjXSYA2tmBIBCgTSUE1KoMTA+xHki5kRiNtf5WnJRJ+H9HCJMLN6G8
	 Nt5PqFIElfIvaYp7tyL88x0aqdjFWct/s16TYV5w+I/WveTf/RTs1Tlg26DfD9pyNH
	 f4fR0ZhZXu+cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	dlemoal@kernel.org,
	yanaijie@huawei.com,
	yuehaibing@huawei.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/7] scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed
Date: Tue, 16 Jul 2024 10:30:12 -0400
Message-ID: <20240716143021.2714348-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716143021.2714348-1-sashal@kernel.org>
References: <20240716143021.2714348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
Content-Transfer-Encoding: 8bit

From: Xingui Yang <yangxingui@huawei.com>

[ Upstream commit ab2068a6fb84751836a84c26ca72b3beb349619d ]

The expander phy will be treated as broadcast flutter in the next
revalidation after the exp-attached end device probe failed, as follows:

[78779.654026] sas: broadcast received: 0
[78779.654037] sas: REVALIDATING DOMAIN on port 0, pid:10
[78779.654680] sas: ex 500e004aaaaaaa1f phy05 change count has changed
[78779.662977] sas: ex 500e004aaaaaaa1f phy05 originated BROADCAST(CHANGE)
[78779.662986] sas: ex 500e004aaaaaaa1f phy05 new device attached
[78779.663079] sas: ex 500e004aaaaaaa1f phy05:U:8 attached: 500e004aaaaaaa05 (stp)
[78779.693542] hisi_sas_v3_hw 0000:b4:02.0: dev[16:5] found
[78779.701155] sas: done REVALIDATING DOMAIN on port 0, pid:10, res 0x0
[78779.707864] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
...
[78835.161307] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[78835.171344] sas: sas_probe_sata: for exp-attached device 500e004aaaaaaa05 returned -19
[78835.180879] hisi_sas_v3_hw 0000:b4:02.0: dev[16:5] is gone
[78835.187487] sas: broadcast received: 0
[78835.187504] sas: REVALIDATING DOMAIN on port 0, pid:10
[78835.188263] sas: ex 500e004aaaaaaa1f phy05 change count has changed
[78835.195870] sas: ex 500e004aaaaaaa1f phy05 originated BROADCAST(CHANGE)
[78835.195875] sas: ex 500e004aaaaaaa1f rediscovering phy05
[78835.196022] sas: ex 500e004aaaaaaa1f phy05:U:A attached: 500e004aaaaaaa05 (stp)
[78835.196026] sas: ex 500e004aaaaaaa1f phy05 broadcast flutter
[78835.197615] sas: done REVALIDATING DOMAIN on port 0, pid:10, res 0x0

The cause of the problem is that the related ex_phy's attached_sas_addr was
not cleared after the end device probe failed, so reset it.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Link: https://lore.kernel.org/r/20240619091742.25465-1-yangxingui@huawei.com
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libsas/sas_internal.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 01f1738ce6dff..3fb8a64f571d5 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -111,6 +111,20 @@ static inline void sas_fail_probe(struct domain_device *dev, const char *func, i
 		func, dev->parent ? "exp-attached" :
 		"direct-attached",
 		SAS_ADDR(dev->sas_addr), err);
+
+	/*
+	 * If the device probe failed, the expander phy attached address
+	 * needs to be reset so that the phy will not be treated as flutter
+	 * in the next revalidation
+	 */
+	if (dev->parent && !dev_is_expander(dev->dev_type)) {
+		struct sas_phy *phy = dev->phy;
+		struct domain_device *parent = dev->parent;
+		struct ex_phy *ex_phy = &parent->ex_dev.ex_phy[phy->number];
+
+		memset(ex_phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
+	}
+
 	sas_unregister_dev(dev->port, dev);
 }
 
-- 
2.43.0


