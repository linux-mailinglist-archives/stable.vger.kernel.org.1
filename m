Return-Path: <stable+bounces-230015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLoQNji4wWm/UwQAu9opvQ
	(envelope-from <stable+bounces-230015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:01:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 906902FE01F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C24DB3020E8A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1823815C7;
	Mon, 23 Mar 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxiA0Dp3"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FF37D118;
	Mon, 23 Mar 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303155; cv=fail; b=cYe2ACgI2/A514ChM11Fw0myYE3XL/ZWKV9ugDkekq7Hq63E6OzTXvbEDrC/ZA4cSTZOe9qI9IDSDRllQOtwpwdpUzP4y1PG8iayvFjdra1S0tLd+WysJxhck+aqfZZDldXdkxHwfZDtywSKubsqIjO6oZGHXGgYLbCAwHH5sFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303155; c=relaxed/simple;
	bh=+VZMmUnWdicSknV0URkRky7+NWXuFL8oOe0w30eB6Ko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PbYYe4T/q9AByxfYW50x9bycfXgD704jU2HDcI5ijf0lX0t/fLgdMQFrJXIMwrARNZJ4xa7aD4Wpup7Zs8X4vxS38w4rhDabCOxsPL1atM9zF13UlxAQDj6/vJWh4ZJ6Y8ZZ3tMZzUJdPcskKSdYRp5kooBrCHwclBJIIWEHbXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxiA0Dp3; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7PWhzIkeyYktIwCU00R8V5fl7e7WgIfedVbrg37uhQtWSnjAS6XeQC5joZmfblnMh7K8b9NE6UtwimCHsy8j1Zg6MdYz2AbqBX8o0+3+xtTqck4wuwrvKzocnd/Um2gY1SRxYPvWbPHhSY0dDrl+6GdBKVAiRJwD+reccOf6TbgVVFlRPYw9jEWEbJ8zIDWDMTJ4JaXreM6LlMjlTIJDP52CRIVYky2SHtblRC0SRPR7ydZ954ZlWCp77aTHmKOxtw34SkTiJrpo1mkhEUOA/Qut72142dMsmsf7ow/UnH2PXdW7An8CDFC5c+6NTsj7hdsdn5mIy14eCB8pBtq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLAt6HSVkXwshWLqUZWVUhgVKd+0Vu75abzHA0Etn50=;
 b=mJmmghqAUi7MTNODu0mnMjZ58O9Z214XOkO9CVmBUfpUFxFn+p9yIZy5VXS+Bw1Tp89Fl96OwREgojp8BvDg0KMhkwW/F9SXjFkd5M3bcgvBP3UZO9yescLZxDNp6u7I5tKmy29FLTTXNOoJJ86SM8IAlpDMOEaiARdB7m9OffYSrlhBncoKUAxsxjpVpYQElyxkdzgWS7WkxUBaypApszzmU3P1YxAfJby7jm9LXLAWT1yGi4EP9fNHB+W0wazaIqIq/+pGtzvMJKWxqwd07r//isZn3drIKA/dLzOzc7wAy4EBFkGiVlfAI+UXfOBqQ0pusBe7DmqL4XyPZxNT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLAt6HSVkXwshWLqUZWVUhgVKd+0Vu75abzHA0Etn50=;
 b=kxiA0Dp3Wn5vYHZdJoQWcbJ4e1vIKZjBEhj+NczZzgCnpZqzm1uk5eM+z3EblnWirTJj9rDAlJYMVLGBO/E1a+zweud5Non4dxD7/ldmCnxsDOzcJUsVMrfoxrFFtPwMJFqNimw2w2AiEKfxquWYsz8KGyICDGryGyFAGoUMENvhvoxub/tsicL34M8pyngNVzfij5iKqRsJkH8ov7aqssdEOet4Jo72o8k7MEONqlhd9+d9nCoKThcw0ZXUoTUlCWRd29VZkq6sweToUwSUySY7MI2oQum9QdlYGsENh4nqNjGjFgGMjuYow5koWanEnihmNzeqxcVhhjUx5oVv8g==
Received: from DM6PR08CA0066.namprd08.prod.outlook.com (2603:10b6:5:1e0::40)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 21:59:10 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::c0) by DM6PR08CA0066.outlook.office365.com
 (2603:10b6:5:1e0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 21:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 21:59:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 14:58:56 -0700
Received: from meforce.lab.shazbot.org (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 14:58:55 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <kvm@vger.kernel.org>,
	<jgg@ziepe.ca>, Renato Marziano <renato@marziano.top>,
	<stable@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH] vfio/pci: Fix double free in dma-buf feature
Date: Mon, 23 Mar 2026 15:56:58 -0600
Message-ID: <20260323215659.2108191-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: f248bf69-b831-4b2f-9e12-08de892769d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	I0iYhRFfyFi6y2v3zBQFF07N8NOcm7qs30mwpP2aKgsOsed5mhIo3YzQyDMDmj6dZRU3Ne2p8f8pcEkibk3dxDOb/HaO7/djyNdrS0xp/d4A22M8V+jZ4b/e53SDsuTqfPIGZqYcDFgrNkN0RN15TEHM/jJvNBcvigBYkTYdBA9mHjxWKxIB3VIdTlIX5shIwcCcv9epo64PRmgLJF2aEQdwhFFuANxDoko+DHiVWDoN0NWJs/dKLEgFwgXad2IEWRAXpC4GRxjo7eN+x1nUu6NprX0gOnxlot3KMBlc5f+Gd5omgn3oWzY6qvp4n3qUB4OFBuMDcUCYcYRW8fqkq+MMZm141Sm+2UWdxsM5thTFXJg0+oCtRIuFxqyviD3mGUwu+EYZg0Tm4112OPMnXn1f6KwaRK03zXLOdf234zZnC3HEMF16bj/8LsylHy6oxFKQDycsqaTqwF90+jWtWPsCz/KhQRrgQwPz4TNJjSmfkKturHhtDbpdhvxyO2lM49V7/ITa3BgyMgY4ZvwEoomD0aH/2gaKH+HTXIgqonjPAXo0ls+a1AJ6qZI7zpSEBVu5wjvEfq9YKgoBrRPVViS2ajK1wr5KI1ptNKo7CAZ4XjK4yGbaGkQWw1SI1LEshWO++d6v5re1Q1s2kpXAkSvCYdRasWMfNb0bbmeXgYEAAVy1bk47nkgf/3QVECPMhr36KGLZojpJ03Dvu7CcTo6wUUV0UpWcrwgo2OD8FNzewNETPooC5ne7ZLtQKpdxzBxCfV5jk5HULUPUWrEHxA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xixzMuIOlkWlPrviW1ryMszCWlDQtKrXS+RuexkJ+Jz8rH/bjBUQGzDybXjPr86RQQ1bLFFiJqWwG/K2rhX5SGYH04TowSYIP1YE5CwuzQfi5AYSvHGgJEPnr9amqFJI2QBH1ksVzmWr2VUsuFgK6Sod6krqmU7WJIlsPJkbHnuf8l/ZM632gYYp5AVZpY91HH5KIq5ra1osXHVWREdZx3ys5QWVPNUS+qvKnBFU0CtRGkxPEu6wlWlGteAGI/3rgPY2bxfXSvoQc3EY+J9c4KsDJDqiqWpO3+5bTbPKq8WgM7RzfrOR4nUDZNeh390zEO+0PK5pYDacbtj9zZ1BtfvMMerUxUIAJhd1eBsXAZ0YvilDiO2rjHyBM7mzNFHan+/4FBygvKnHoqH9bwi3bDLjJ7TW6kpKxqJO3zDCP+ySD1upxZNXeX2EjvxYJ5vT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 21:59:10.4276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f248bf69-b831-4b2f-9e12-08de892769d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230015-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 906902FE01F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The error path through vfio_pci_core_feature_dma_buf() ignores its
own advice to only use dma_buf_put() after dma_buf_export(), instead
falling through the entire unwind chain.  In the unlikely event that
we encounter file descriptor exhaustion, this can result in an
unbalanced refcount on the vfio device and double free of allocated
objects.

Avoid this by moving the "put" directly into the error path and return
the errno rather than entering the unwind chain.

Reported-by: Renato Marziano <renato@marziano.top>
Fixes: 5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions")
Cc: stable@vger.kernel.org
Acked-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 478beafc6ac3..b1d658b8f7b5 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -301,11 +301,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	 */
 	ret = dma_buf_fd(priv->dmabuf, get_dma_buf.open_flags);
 	if (ret < 0)
-		goto err_dma_buf;
+		dma_buf_put(priv->dmabuf);
+
 	return ret;
 
-err_dma_buf:
-	dma_buf_put(priv->dmabuf);
 err_dev_put:
 	vfio_device_put_registration(&vdev->vdev);
 err_free_phys:
-- 
2.51.0


