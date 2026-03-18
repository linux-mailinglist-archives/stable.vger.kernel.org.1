Return-Path: <stable+bounces-227159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD45B/QQu2nGegIAu9opvQ
	(envelope-from <stable+bounces-227159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:54:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DA72C2B79
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 012F33049952
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A136EAB8;
	Wed, 18 Mar 2026 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Utd4+jrA"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423322264C7;
	Wed, 18 Mar 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867238; cv=fail; b=qolh1F4nuI+l3HetdSAJ0R2G2OKW1kLMR5Q5cI62rsw6WQ4lV6vfxP00ZweJx9vKRM2Ictcs+Vy1L8eR9f6hti4uCWmhetK5VAz2U/kzsf6mUh6aW/FUBCm9U5aMAnzefHI0YHwyGvtOotaxUb47aUJwnkKUQd4cIS+kYOL08oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867238; c=relaxed/simple;
	bh=IC9K2wLg66nK3Y/nCn3irqXl9O9Qz/SxPLrPQEVpxmM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eg5AHtIL7tHhEyaoGCXNvZWdRxFAGRp61uVjJ+F7zltV9kkzYkWP5tZac/hU3SW7JW6HbpRkWnoyabLkS67FBEv0TLgJA5vSUuX78L57WDxSgBU6Zgvh0E6Y9eldN6UAVMOa7dHpSJEklmRloZ1/nZXwa3vJUGnbG12WVPt8j/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Utd4+jrA; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJFjhl3rbrZQP4SLzapavwd7DPNK1rWFb2bTCLDlohHG9kXmuPEDVN85Kb48pT3SjtXbt4t63fCtsaEGKTDg+tZER6S9uOic4NVwgocjW19zHVxRv97wlb/qyybWJr9OFvfoWb9GuXouyjJmwf9FpGITbsuUuU6DqMCnohwZrcmMTcI5CQeVN5qFnC6Z25a9xG9v22j1giMEGQ6dpDrqKbmf0zzOz97gqftbStpV9psGnU6ag1ELyThA+ew/Dznf5ipdLKqHHyFRcPY9/634XixoYI3Hi5hIFyFLGy2LCgU7voIAiC5g5B0Sxhh0VXvgtBG2OA4mJP4CV72a2tTb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWhbPilCbw/x98sZo2BQiu2Pdfd2YzGwB0xgla6e0zE=;
 b=srnByaV5kiSLokLjqRNB0NT5Ha1Qt1Q0xMZOLz4JuQQgI2/km4iY6QTgVbGthqOBeLvWMiEtzcf1uwe5i69tTj/zMFwvbj7R8Arhzxm8aVEaAJvq0QRKClTWc3EkPNK+YHcP4dd5Lb5VULqM5n9IrfbYTYsT2QATs+57x+1sVg4UlJeoPtU0wYEhf9gAnj1Xkt4+UAA52LHZFrnUg4nx/E+Grp4PBnM0XjABx7q9lJ/yfjj1lzugSiyHrS8xIhL7foC9NrQgfVgI+gJF3rpE9zUfbFs7s+8B5dmnjHXBDx+48BrkDeZlN2e5w/thqfw8Y2oThO/CBh422OnPkWbU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWhbPilCbw/x98sZo2BQiu2Pdfd2YzGwB0xgla6e0zE=;
 b=Utd4+jrAN9Ojlu5WNgeV4JNvcnL3aCQWRrYdvh9yn3V4fSnGQzNiPaFMYr1/XAa5ZKTA+GDmZjWW+TYJKcgOsZ/AaSVdAmjZ0G/aMVzRjaIKItJfbVvq2OL0OUsICn1o4rwmvXTunIDDswoUPcQKpIsZ5HVbrAsYO10S4q6DFQshdmEx96xS8/aqnv6mc45yQVru7bs7mL8ee7yOLtPsuovE9RqmJZ86lPETdozA1/Czb1TWyzNS/5/N0MCJFlkRgESMGJEse3/R8sjemnJ1ABtBWrlI4teHfVZQRINQukB9Shfb2RA4Yrt6y7+8/oF6RUz60rmArnLnKfcspEHs+A==
Received: from MN2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:208:239::34)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 20:53:52 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::6c) by MN2PR08CA0029.outlook.office365.com
 (2603:10b6:208:239::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 20:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 20:53:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:53:31 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 13:53:30 -0700
Date: Wed, 18 Mar 2026 14:53:23 -0600
From: Alex Williamson <alwilliamson@nvidia.com>
To: <mhonap@nvidia.com>
CC: <dmatlack@google.com>, <dave.jiang@intel.com>, <ankita@nvidia.com>,
	<kjaju@nvidia.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] vfio: selftests: Fix VLA initialisation in
 vfio_pci_irq_set()
Message-ID: <20260318145323.7e9831a4@nvidia.com>
In-Reply-To: <20260317051402.3725670-1-mhonap@nvidia.com>
References: <20260317051402.3725670-1-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f56686-20de-4e88-3868-08de85307619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|13003099007|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info:
	wcyYODMQbXpRZXxw8su8Bu/xxvry0K3DvvfNO9Y7yVdsc/De+sar7xT7qX9RDtRimqvlA7WSVIRvL7jWh0hB/iZfVpUbWEKd4QzjiUy+Hf2zoqDeZGQHB0JNxYz74gEmhxCv3o2L8eUS7Dxbe/XUIuMIKC1hp3A2T6K/CYVEAUdhgidP2gnNhNFX/OT4fh9RtMNFhoYRJriK7uJSuR4/gQ8JQibaX+jFCA9oe0geIPMEXj4hXgmnE4a6N4HMJndZf3hJqBviY4TK02V65mm3ob65UjkF7fi7w2loJ1t8y/XR/MTImcwEc2OOwX+dxByzmpFxO4GpawRfrTpWMiIrFq3TKLMjSRNt5h9XI340nXrIaIRwsQ3pEh/B1jsTJKxjQKDOIzFiVLA18ixYlcQE/3KWlcutHPl5BYHx00FAOYwWlsdo9/Re5iNxbKUM7M0i27n0JFgKAHgq4nIuQAUZv7GwGmAmUFUofdzglV1Da7othKjLNqyKe/B16XD6+h2OEyMMeK431dq+7FvOSd8HU7oeaUCenWhmYMtXIZxJHuptbhb/hRHK/rLAAjtmUyszAVFu1MY9dXA0ewVs7Iip4al6Ry2PtKCfb133cufsRp05YK+S9/Y2d62JzVUHwqvkDhsKrWcHw6SWvQTJ58Zag6EPWXcSe7BVaikBXIhXIzY+Lcw6ta8btKUXhoftDJBuJqK5IU1CEsu0iPXQsPoZnXjjnnXzTXGtBAmGzCZH3/PoW5P40Wc7TVVnrcDpptj5f8dUpyCKq1Eu7wldhrVakg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(18002099003)(22082099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n2LWieUu5AUG6LNyAcwJJHUYf7x2xo+2eFnIg1/FgQUO+mlIzYjPZyRBI1Vmkkr4c4L84YySz45nxDaPQsPRhLLXQnpNGOUgBtyMaNxEk68pr+rbaBOJnSsM+orC7HENdGmHHGFNo9sEXUF9Gg87WRkqX8vGl/93GWOX8RM6ORbgMwdMziJBwuMhKjewj3KWxRqi4u9HW4/HEoSpV1OR1B5J0PHjRAETjPVnmkBsplB5e9M3Uu87Kt9tesNFSURs64fiwOISLtz0urMGM8cpZAIUAlXjxtzqEph05RrWEBzwSjgLIj+CWcW7jnKaCzldrtKnF/TqAezG9p3Y/MT8Snx/dhSSEQcDkDBMFu7PVjB5wFBgkVurhCqd6tzrFOOZNjLSqhKuSUnAfOLyVqs8WBxN8SzVsOxDhwy3NGW4VWgvIt0/xHN4HDE2Vtj9GLxH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 20:53:51.7542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f56686-20de-4e88-3868-08de85307619
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227159-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[alwilliamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B2DA72C2B79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 10:44:02 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> C does not permit an initialiser expression on a variable-length array
> (C99 Section 6.7.9 constraint: "The type of the entity to be initialized
> shall not be a variable length array type").
> 
> vfio_pci_irq_set() declared:
> 
>       u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> 
> where `count` is a runtime function parameter, making `buf` a VLA.
> 
> GCC rejects this with (tried with GCC-9.4.0):
> 
>       error: variable-sized object may not be initialized
> 
> Fix by removing the `= {}` initialiser and inserting an explicit
> memset() immediately after the declaration.  memset() on a VLA is
> perfectly legal and achieves the same zero-initialisation on all
> conforming C implementations.
> 
> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> Cc: stable@vger.kernel.org
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
> 
> This fix is self-contained: it touches only the existing vfio selftest
> helper library and carries no dependency on any other patch.  It was
> originally included as PATCH 20/20 in the CXL Type-2 VFIO passthrough
> RFC series [1] but belongs on the vfio list independently, as noted by
> Dave Jiang.
> 
> [1] https://lore.kernel.org/all/20260311203440.752648-1-mhonap@nvidia.com/
> 
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index fac4c0ecadef..3258e814f450 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -26,8 +26,10 @@
>  static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  			     u32 index, u32 vector, u32 count, int *fds)
>  {
> -	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> +	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
>  	struct vfio_irq_set *irq = (void *)&buf;
> +
> +	memset(buf, 0, sizeof(buf));
>  	int *irq_fds = (void *)&irq->data;
> 
>  	irq->argsz = sizeof(buf);
> --
> 2.25.1
> 

This unnecessarily split the declaration block.  Without objection,
I'll commit this with the following change:

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d306ab81123a..fc75e04ef010 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -32,9 +32,9 @@ static void vfio_pci_irq_set(struct vfio_pci_device *device,
 {
        u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
        struct vfio_irq_set *irq = (void *)&buf;
+       int *irq_fds = (void *)&irq->data;
 
        memset(buf, 0, sizeof(buf));
-       int *irq_fds = (void *)&irq->data;
 
        irq->argsz = sizeof(buf);
        irq->flags = VFIO_IRQ_SET_ACTION_TRIGGER;

Thanks,
Alex

