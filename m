Return-Path: <stable+bounces-237967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ORjIqSe3mlrGQAAu9opvQ
	(envelope-from <stable+bounces-237967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:08:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE33FE443
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B64BE303135E
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC17A31F9BC;
	Tue, 14 Apr 2026 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="liH+kxrb"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE330F95C;
	Tue, 14 Apr 2026 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197238; cv=fail; b=K747FNOTGhGmhLzwRbscjro63yfugOYCrkV/3ecKZvgHdIuJT9oLVN/6paxirungGtZBs4l2YN27GFYW6ujyjIXTvq734JbaVKFvGGhLdhSrM1MFT70gGE8Bil6HSKKK6a1elYTTuLhiFF6DX6zGg6T+D/ElSiMrBwHtt4WmRcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197238; c=relaxed/simple;
	bh=ljpZU/CK9sboKlMlKGHF9AomEaRKft/mIS5wqbelFGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZvs8h56QlQ03iPSzMqSyCViQZ+0Ay+LRRqfDxOgwCAwV2h0/HX+RyaqELOqSeo07YziFJcAot3tfvDpZHZPFRTGjeHnjBPPTEEWiRqVLl/IZ3L44PJDlEEj/LvRqlHj1YMvr+ITvSyeHO1q8xwBu3POxjsrgJBKahyyASdHQBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=liH+kxrb; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkgDla0HIW8zhcZKBFmWxXgkcivL1EG1BjLERMHvnxH+uBTVSChNmHk9KvsrFJHBxjduhoHU+uPielBYvnNyruqqvLWgE50HF7TWCO5BAy4MITrhIJ1rOEG2K6w7iNbtVN6kvbZLebHrValbwVsdkIrPPlgPGudHcXQ+pDUNkUAJUENnfNO64UipeAmlYYRx9g2w2AbBL0lD+sEQy5Vy3ZakqU8aY3K3jltMfaaX6/d8Z7eq+oKIftGU3ZdiRuG9HHNX24I0Uyq3l+I8nQIq8cX14b9WhTzc4YdR/GO12rISo5f4IQ5ttbRy8RAtqYihkRbovcD73GABoUK3iym2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyTJZIsKPO12rF4bk5+bPbV2jQwsUCZje4ri+d7wr8k=;
 b=QFVSzUjeHujq59fpRX5iWFrCZEobSEph+UO5pbLQXUTiCh9yLK+8xMFxeKhetROwQQtcqq19p/1hMdGeZIPLam55OfuJkjTob3xSlS9/YUKrFpP4jc/i+QvaP2XyCSSL+kkvdx6rlls9XE3uF4FH6cqrB4EybXmLJwu0SDphxu9gl/xOIwvsldq2pmfVkcXzTng5qeZGIjSec6lp9TUS4TU6HyUcN9c6nV5rfm3HrGA2Bi7Up2O3wYmBKeVT4ZIrSJBN7Y/exloozonLLFYKX8B5l1O/Jd7XKvRUBTwpKr53pRbZ1aNb5fSrwA8vWRgwt0jaZUX6oXBU6Fmn7Y05QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyTJZIsKPO12rF4bk5+bPbV2jQwsUCZje4ri+d7wr8k=;
 b=liH+kxrbeb0DKFOYDvkSzY/IQ1v0wWAOUhk+IpDjgftVQ1Nz+0vkpaLxcYpBOSeWaP7qmgO44uzp0fxn2beh0U9rdS1HYxFvdTdV3lvN7EwkdwfiqFf73GfB1e1/3rVWuYQma2Kepjv4cTZXp2fIXohVv+m8SLTtxvgKns09TBR4AvoE2lWOaIJ5dyWt+aL+a5UdF8goXnZmcpBZjpGCTLOdZ+e7swhLj+ZTIVbhpfer2j7sjVfpGOSIU7XhCtLDUrg6NUZGE8GlhMyCrV3NJ/ln//xf6HexhgsKu11y72bOCG/lQZYO+wu7xQc3LHz8klswVD1LRfCDti6CY3tnaw==
Received: from BLAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:32b::8)
 by CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 20:07:12 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::8c) by BLAPR03CA0003.outlook.office365.com
 (2603:10b6:208:32b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 20:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 20:07:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Apr
 2026 13:06:49 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Apr 2026 13:06:48 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <yishaih@nvidia.com>,
	<kvm@vger.kernel.org>, <guojinhui.liam@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/4] vfio/virtio: Convert list_lock from spinlock to mutex
Date: Tue, 14 Apr 2026 14:06:19 -0600
Message-ID: <20260414200625.3601509-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260414200625.3601509-1-alex.williamson@nvidia.com>
References: <20260414200625.3601509-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 3408f2ba-227d-45e3-a803-08de9a616a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zKZD6t+Ktt+L3SpW4//t+A/aBKlCpqQcZmGS7VDNF42pC5f7Gn7bkqoRz9cEn/onRwZbDScT61ri7o5GG9IqrtfXFHjEwJM13qJN55mLInPQe+hg5CAffPGbrmV0kot2+wx/O69UBiojY1Bkf2fzshzh9DfLi4PswKXXRZDo4AE7f+In63DirqkaccASR0bxChyJwS0datg4zf6C/6dZepZlFifqzaOtqrSEjqpeZkW7H2go4D/wsusBn7Vvm2jg2be96IuJQWG/LwA4sYTNUoH3671+8246rQlJsxSZT2AoDP4c1LHDNrOT15w65ziKABm0bxVYkTNY4zOvjohUa2gUYjWwGiP1m+Ku+lsx/MtCldARaLcz9QsvFKtSdquHqu3QU4nVhsUixzozL4TLomFa1aB/5O0d2xM82QNo8xJb+MUUUKE92yHHCXDd9Uu5DFQSYuPmKKT32vWavZCgpjat0X6W175J9mop+En1z4bgBvGabMzbW1MN3FnidcFu7Crm72OXJr+NYmGbdDKI+7dxHK4fI0hbFTa30kiSZxm1nbHyI1QbmK/WZW+Rt+ZdpxaNWug066xFEPKjjaD/2VZz0p9+7yIury2NXxaP/nrzJc8heGUyC2jtkhwETTPkGdR/oQTiwIJhQQ+581aH9ExIhAQDI+8URqEF8YVNMPlv/tlL8pcrd/yfm4k6m7nfW3JsTfWXU2VldmUUDxdyocoJKlmMScZIUWlhTwHeXRs22UBGGWRcbhBB4IOsnLm39/Sn89vuNw5FF14DGuCTiA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PqJcILTR8/1kScY+W0fze3YGh1eac96EER0sNa/QfKdfGAU2fEW48uMI9gHdFcYrXzy3U0DGb8/Qp79C9kV53bAsI5ibBjXFKytf9sW9soPXLLL5WpBssqHxmPoYSMHkPrfpTVuNOl5voJDWSjrEjNfaorqa33QjxmkIYjiWpYWCG56HvN615a1nosbpAg9TM6XFAxRu3ISpGyden0LAGtXvPtV4zTQUG3u5E1IG3MrUBqryzH4y7lE48H0H/zR85v51Lf28y6gXzB0Ojh8wZmqhLzKIIvuSqMje/92m7MWwu6VMRjsQ3pJuvoBgAImNoCfV+S80kK1oVWOYbPNZXvIUslbGsVIMYqJC+jieQKxd7KXJhj8M5+2IUhxURiGdZsk9PammwP6nqMqwmdcR3kJ4WoFaztpatuJcxdT94UsG25bA8SCTyaX4wYVJz53Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 20:07:11.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3408f2ba-227d-45e3-a803-08de9a616a64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237967-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,bytedance.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A4AE33FE443
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The list_lock spinlock with IRQ disabling was copied from the mlx5
vfio-pci variant driver, where it is justified by a hardirq async
command completion callback that accesses the protected lists.  The
virtio driver has no such interrupt context usage; all list_lock
acquisitions occur in process context via file read/write operations
or state transitions under state_mutex.

Convert list_lock to a mutex to be consistent with peer vfio-pci
variant drivers (hisilicon, pds, qat, xe) which all use mutexes for
equivalent migration data protection.  This also fixes a mismatched
spin_lock()/spin_unlock_irq() pair in virtiovf_read_device_context_chunk()
that could incorrectly enable interrupts.

Reported-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Closes: https://lore.kernel.org/all/20260413073603.30538-1-guojinhui.liam@bytedance.com
Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/virtio/common.h  |  2 +-
 drivers/vfio/pci/virtio/migrate.c | 33 ++++++++++++++++---------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/virtio/common.h b/drivers/vfio/pci/virtio/common.h
index cb3d5e57d3a3..3ccbd49e6abe 100644
--- a/drivers/vfio/pci/virtio/common.h
+++ b/drivers/vfio/pci/virtio/common.h
@@ -68,7 +68,7 @@ struct virtiovf_migration_file {
 	enum virtiovf_migf_state state;
 	enum virtiovf_load_state load_state;
 	/* synchronize access to the lists */
-	spinlock_t list_lock;
+	struct mutex list_lock;
 	struct list_head buf_list;
 	struct list_head avail_list;
 	struct virtiovf_data_buffer *buf;
diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 35fa2d6ed611..15fcd936528b 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -142,9 +142,9 @@ virtiovf_alloc_data_buffer(struct virtiovf_migration_file *migf, size_t length)
 
 static void virtiovf_put_data_buffer(struct virtiovf_data_buffer *buf)
 {
-	spin_lock_irq(&buf->migf->list_lock);
+	mutex_lock(&buf->migf->list_lock);
 	list_add_tail(&buf->buf_elm, &buf->migf->avail_list);
-	spin_unlock_irq(&buf->migf->list_lock);
+	mutex_unlock(&buf->migf->list_lock);
 }
 
 static int
@@ -170,21 +170,21 @@ virtiovf_get_data_buffer(struct virtiovf_migration_file *migf, size_t length)
 
 	INIT_LIST_HEAD(&free_list);
 
-	spin_lock_irq(&migf->list_lock);
+	mutex_lock(&migf->list_lock);
 	list_for_each_entry_safe(buf, temp_buf, &migf->avail_list, buf_elm) {
 		list_del_init(&buf->buf_elm);
 		if (buf->allocated_length >= length) {
-			spin_unlock_irq(&migf->list_lock);
+			mutex_unlock(&migf->list_lock);
 			goto found;
 		}
 		/*
 		 * Prevent holding redundant buffers. Put in a free
-		 * list and call at the end not under the spin lock
+		 * list and call at the end not under the mutex
 		 * (&migf->list_lock) to minimize its scope usage.
 		 */
 		list_add(&buf->buf_elm, &free_list);
 	}
-	spin_unlock_irq(&migf->list_lock);
+	mutex_unlock(&migf->list_lock);
 	buf = virtiovf_alloc_data_buffer(migf, length);
 
 found:
@@ -295,6 +295,7 @@ static int virtiovf_release_file(struct inode *inode, struct file *filp)
 	struct virtiovf_migration_file *migf = filp->private_data;
 
 	virtiovf_disable_fd(migf);
+	mutex_destroy(&migf->list_lock);
 	mutex_destroy(&migf->lock);
 	kfree(migf);
 	return 0;
@@ -308,7 +309,7 @@ virtiovf_get_data_buff_from_pos(struct virtiovf_migration_file *migf,
 	bool found = false;
 
 	*end_of_data = false;
-	spin_lock_irq(&migf->list_lock);
+	mutex_lock(&migf->list_lock);
 	if (list_empty(&migf->buf_list)) {
 		*end_of_data = true;
 		goto end;
@@ -329,7 +330,7 @@ virtiovf_get_data_buff_from_pos(struct virtiovf_migration_file *migf,
 	migf->state = VIRTIOVF_MIGF_STATE_ERROR;
 
 end:
-	spin_unlock_irq(&migf->list_lock);
+	mutex_unlock(&migf->list_lock);
 	return found ? buf : NULL;
 }
 
@@ -369,10 +370,10 @@ static ssize_t virtiovf_buf_read(struct virtiovf_data_buffer *vhca_buf,
 	}
 
 	if (*pos >= vhca_buf->start_pos + vhca_buf->length) {
-		spin_lock_irq(&vhca_buf->migf->list_lock);
+		mutex_lock(&vhca_buf->migf->list_lock);
 		list_del_init(&vhca_buf->buf_elm);
 		list_add_tail(&vhca_buf->buf_elm, &vhca_buf->migf->avail_list);
-		spin_unlock_irq(&vhca_buf->migf->list_lock);
+		mutex_unlock(&vhca_buf->migf->list_lock);
 	}
 
 	return done;
@@ -554,9 +555,9 @@ virtiovf_add_buf_header(struct virtiovf_data_buffer *header_buf,
 	header_buf->length = sizeof(header);
 	header_buf->start_pos = header_buf->migf->max_pos;
 	migf->max_pos += header_buf->length;
-	spin_lock_irq(&migf->list_lock);
+	mutex_lock(&migf->list_lock);
 	list_add_tail(&header_buf->buf_elm, &migf->buf_list);
-	spin_unlock_irq(&migf->list_lock);
+	mutex_unlock(&migf->list_lock);
 	return 0;
 }
 
@@ -621,9 +622,9 @@ virtiovf_read_device_context_chunk(struct virtiovf_migration_file *migf,
 
 	buf->start_pos = buf->migf->max_pos;
 	migf->max_pos += buf->length;
-	spin_lock(&migf->list_lock);
+	mutex_lock(&migf->list_lock);
 	list_add_tail(&buf->buf_elm, &migf->buf_list);
-	spin_unlock_irq(&migf->list_lock);
+	mutex_unlock(&migf->list_lock);
 	return 0;
 
 out_header:
@@ -692,7 +693,7 @@ virtiovf_pci_save_device_data(struct virtiovf_pci_core_device *virtvdev,
 	mutex_init(&migf->lock);
 	INIT_LIST_HEAD(&migf->buf_list);
 	INIT_LIST_HEAD(&migf->avail_list);
-	spin_lock_init(&migf->list_lock);
+	mutex_init(&migf->list_lock);
 	migf->virtvdev = virtvdev;
 
 	lockdep_assert_held(&virtvdev->state_mutex);
@@ -1082,7 +1083,7 @@ virtiovf_pci_resume_device_data(struct virtiovf_pci_core_device *virtvdev)
 	mutex_init(&migf->lock);
 	INIT_LIST_HEAD(&migf->buf_list);
 	INIT_LIST_HEAD(&migf->avail_list);
-	spin_lock_init(&migf->list_lock);
+	mutex_init(&migf->list_lock);
 
 	buf = virtiovf_alloc_data_buffer(migf, VIRTIOVF_TARGET_INITIAL_BUF_SIZE);
 	if (IS_ERR(buf)) {
-- 
2.51.0


