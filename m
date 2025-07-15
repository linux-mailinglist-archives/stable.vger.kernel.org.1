Return-Path: <stable+bounces-162412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A92B05D73
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1233F17C871
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755232EACE9;
	Tue, 15 Jul 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKfZvWsD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DA2EAB9F;
	Tue, 15 Jul 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586489; cv=none; b=jaKaahXD7DuxQ8J2Rfi+xrc4ZXvpku3J19BhzQeKlwb6AKmykAPjLCc2mRbnz3sOo6T+mLJCR8PABWd4VUXENVZrho2rNa4mCozaapgymO+lklxvhZx7VBBLdzQMLz/l7IK3TZxWlzge0AyaANjm5p3YQOO6g76SqN57959fykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586489; c=relaxed/simple;
	bh=eXVvVSpZewzf4GdezGn46S6HO+sCTapUsXKUK1OdafY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfeO45nHvAolloY2Pg9qUEEF6cV++fGkTdrv4CKIaeOmeKkfZ8iBlsuZ+Ebq94+5+runn7V5JUx0wwvKx6Y/KWgBOKpm236UYRMCuv/OD/+47IFlwdkRBncKkw+tfDHDMuJI1HgYcqZEfVkWxEmcHnj17VD5DJo6DPHL+fAgX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKfZvWsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AA8C4CEE3;
	Tue, 15 Jul 2025 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586489;
	bh=eXVvVSpZewzf4GdezGn46S6HO+sCTapUsXKUK1OdafY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKfZvWsD70yX4T6H6nns7xU2VPToSvKeFI/Wcp42x+kwZBtD4/aoBCfyM2DuxoSO3
	 a1BbiCdlwkRbdGZf5MO9hC0+Q3QGplmRDd+Cx4ytOTX7yyolLEV19O2xHbGIvq7Ntt
	 TfYAF/QiGKi/E0OH2HJgSAUNODSNnDesQisXyvqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@sandisk.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 085/148] scsi: ufs: core: Fix spelling of a sysfs attribute name
Date: Tue, 15 Jul 2025 15:13:27 +0200
Message-ID: <20250715130803.723336434@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 021f243627ead17eb6500170256d3d9be787dad8 ]

Change "resourse" into "resource" in the name of a sysfs attribute.

Fixes: d829fc8a1058 ("scsi: ufs: sysfs: unit descriptor")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20250624181658.336035-1-bvanassche@acm.org
Reviewed-by: Avri Altman <avri.altman@sandisk.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 2 +-
 drivers/scsi/ufs/ufs-sysfs.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 016724ec26d5a..7318565d68f58 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -589,7 +589,7 @@ Description:	This file shows the thin provisioning type. This is one of
 		about the descriptor could be found at UFS specifications 2.1.
 		The file is read only.
 
-What:		/sys/class/scsi_device/*/device/unit_descriptor/physical_memory_resourse_count
+What:		/sys/class/scsi_device/*/device/unit_descriptor/physical_memory_resource_count
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the total physical memory resources. This is
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index ad2abc96c0f19..97e3857bda32a 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -753,7 +753,7 @@ UFS_UNIT_DESC_PARAM(logical_block_size, _LOGICAL_BLK_SIZE, 1);
 UFS_UNIT_DESC_PARAM(logical_block_count, _LOGICAL_BLK_COUNT, 8);
 UFS_UNIT_DESC_PARAM(erase_block_size, _ERASE_BLK_SIZE, 4);
 UFS_UNIT_DESC_PARAM(provisioning_type, _PROVISIONING_TYPE, 1);
-UFS_UNIT_DESC_PARAM(physical_memory_resourse_count, _PHY_MEM_RSRC_CNT, 8);
+UFS_UNIT_DESC_PARAM(physical_memory_resource_count, _PHY_MEM_RSRC_CNT, 8);
 UFS_UNIT_DESC_PARAM(context_capabilities, _CTX_CAPABILITIES, 2);
 UFS_UNIT_DESC_PARAM(large_unit_granularity, _LARGE_UNIT_SIZE_M1, 1);
 
@@ -768,7 +768,7 @@ static struct attribute *ufs_sysfs_unit_descriptor[] = {
 	&dev_attr_logical_block_count.attr,
 	&dev_attr_erase_block_size.attr,
 	&dev_attr_provisioning_type.attr,
-	&dev_attr_physical_memory_resourse_count.attr,
+	&dev_attr_physical_memory_resource_count.attr,
 	&dev_attr_context_capabilities.attr,
 	&dev_attr_large_unit_granularity.attr,
 	NULL,
-- 
2.39.5




