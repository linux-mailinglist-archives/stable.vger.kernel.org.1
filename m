Return-Path: <stable+bounces-210616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI3+EREKcGlyUwAAu9opvQ
	(envelope-from <stable+bounces-210616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 00:04:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C13A04D786
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 00:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3849C6CF875
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796333A900D;
	Tue, 20 Jan 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MGSrG490"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C803ECBE6
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949423; cv=fail; b=rz/1ER7x/YEiBUcXLPlY61EWEfMrbb98QvZJm+4oCnALxICBs9B5BgfgM2bSmCl22bjyemhmMvKZyI7sDLAB86vL16KmsBWh32TREAkFRqt/Ym3xJfxMAhLLarz6F7cOy7VyU1JtJAY6XUrA3FLC4WuPcJFUNAsV9QuJoSsrB9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949423; c=relaxed/simple;
	bh=iI59vG4CAasROd/hLpFhC3M8oNsuokJvWwGnr/wtScQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7lS4xbJytZGSnSUiVIHlV3AlQLM+T6qcfwsb+nsG2mSv1RSsZWE0vcT+6/WIZUwSayRy9Mu4g44DcdLP08PiMjyONFD7u1NDbj+fMUalpnOt9BGzFutdTjpynJR1SFmnf9g3Gn+UmTwtByl3iRbwRaeFxltTG3xpjNm4sbVLJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MGSrG490; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZQ0XvsI2V4uS00c8q806OZVPnT8LxEa4JJ/a/vL8zosZMbAcBa4+tHODjQmaA1/yEfjHKgWLuSyK6wzEQ9hj/qTVR9krwg3+vfJHyxfWeUppbPG4uVxjhcVMxCVRFvljplW6c+fK5ZArPeJUtcYtckUtx0Rlz4FSF0hcszgi4vH+V5ni6h2cSkzM763Rj4h9esGra99XXJcx5xm1iKOO2r9Jz6IcTFxhVzdjH4PCQv+Iv9okOHRr/RQuoio6vDPEa9RuCGde3iWPMtdVwqtbV99OPHkLtaykJ5EA5/+25KiLPlhN9lDbITORK5Tzn0OZdLjP5geWhAcKGcawiTLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsVin7BQzrgqB7efTqUIkltokZxH6r5GwT8sbMWfb/I=;
 b=x6RVNwSE+3AeYI+jFhSX7SwbaoI8MnBWv+jW0Zga7gE4Q3xa2KFAo4lqzZ2OeZnH34y+85LYEL/SaJ0kkoQOGcFN7pCJ3r3DivsTqeifl4zAAjFJaXFGa3aZwOzq4dO4kadm3AfwT2SsfiDW6tAVvGJF5Qw5kUnx7tEMEtFfLFOS5xJog0iZLrKJoaT5JDxzXD4XjorVSYi63WMbGB8gS0TfV2utOr+mgWCSoboEqMkBj0Cb1B7aPhlTxezaa5oxsyeR5s43hlSb8srnzCBrbB9EJzxNZvvVnzQXDbExn9Hu1hAQRzPbSifQylx0CABYKHfabGFJwDlfDp60nB2GHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsVin7BQzrgqB7efTqUIkltokZxH6r5GwT8sbMWfb/I=;
 b=MGSrG490MI5xc2Ok4MYI3NwYw2Vj7OjNRYpyxeeD5Mvzb+bd55SWdCnDmKUmb8hbyXNumH6JsTlwsmgB8tz+XOANbn3vY8yXsl4kkIYTtshqZq/ujR3jDC0XAUaBVjqyMAVq0xnnwbbYllliW2OWzX+ilUMSvtDXEMaexnIL8pc=
Received: from CH5PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:1ed::15)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:50:15 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::51) by CH5PR02CA0008.outlook.office365.com
 (2603:10b6:610:1ed::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:50:14 +0000
Received: from Harpoon.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 16:50:13 -0600
From: Felix Kuehling <felix.kuehling@amd.com>
To: <stable@vger.kernel.org>
CC: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, Oak Zeng <Oak.Zeng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10.y] drm/amdkfd: fix a memory leak in device_queue_manager_init()
Date: Tue, 20 Jan 2026 17:49:50 -0500
Message-ID: <20260120224950.3403785-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026012022-crouton-kilogram-6b06@gregkh>
References: <2026012022-crouton-kilogram-6b06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbd585c-8295-40cd-6f59-08de587646bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDicfpHPT3rJ9x3XorJmUcUizgdzXL5AgvegAlDSxtL8rw57FeudgyZDcoaf?=
 =?us-ascii?Q?1FzL0QHkswLruuwQHbN5V3+ItEVI8Ns2NcMS2KfbSHgVkC9vRCUEVxasuWg8?=
 =?us-ascii?Q?cZ/hhTe5hDykxFhclx4s+Y9P4nl9wfVtmGMtGN5Naz+8nn2xRjYFW5dXOIds?=
 =?us-ascii?Q?HyRRaOL5Kye/Kqs/6Vlqx3DP+Lwrkby3OH3ZwoiPuuNj7L1WbmpQxMNBAB6V?=
 =?us-ascii?Q?bn6DEPkWQnbP87ND591tqyFxRM97xeZuJDtU4ovO5imTqYwrGBfv/oaye/WG?=
 =?us-ascii?Q?Fpjp9mObM9foaV/hK8VhUeZwNNoOHmP27hjEEkLQnkxCVgD7YJH5oXZT15HB?=
 =?us-ascii?Q?dNZOkwaISnIkrIHeE0KN39UWZegQjuHaVyYhP5ppT3OfEWV+hb5gr6FRnr7x?=
 =?us-ascii?Q?Yvkwi4AS0/XChJz4Wbpqgp4Ix/ePjn9LN9uWh+OGJGfwSmXnoI85zE+R6SlU?=
 =?us-ascii?Q?SmDey0gNLkMS2W3suRNEt8M/dzyx7ecmOMF7+pj9cxJH8usUdPXvgqzw1blf?=
 =?us-ascii?Q?VRVsIkvxTNphYyEsrQLsFdJL0ZR5p97gnpyY68xoh43SOAVhFpSSdy0hrR/i?=
 =?us-ascii?Q?JBZ7BOqHngox7mDJiuksxKUG0Ah9toxNhmBfifAwGBycwlT23IjxNSJGpoCc?=
 =?us-ascii?Q?DoaLmi9S2bxUCy44mUvgFXm6nTLyqd/pwi1ceKkLqSBhMKP/ZQTgiRy//JVj?=
 =?us-ascii?Q?pVzNVB5gkFWVdbj/1SRjSolQqX0OelyyxujhsVyz5uzQHDZUMiMbg8YpGK5H?=
 =?us-ascii?Q?GaZmsUV0Xe0N3fe0DUg5kD+iXOZxSFHjEgEWNRR6EBO4LILWvms8vMYw4s9o?=
 =?us-ascii?Q?i8A9wlDK0fRayM6Qq4T0+ZsOmHIrsCjkJZx9KLhKPXNOJoAUIn9bEWL3gRfv?=
 =?us-ascii?Q?GEchYZIev7FdnjIVUU0S2E41Ttrla+Hboe10eHKGEkqQgNbF9qKW0BoqHAK7?=
 =?us-ascii?Q?eF/FaH1Ruc1x5CeN/vNNKK3wugGe3Spj5nF3UGJL1MXFy+dOXnRclDrroFdc?=
 =?us-ascii?Q?cy0VvApcq9AISKPHdOWDpziQtiBXV+F4OLb1NEgjHFfToknolB74kLSg+lZ1?=
 =?us-ascii?Q?yu4E5mcpEEQLyA9jgzh5YETv7FX61bAsJ+OZsK44QfHFtugkqufbKqLkIQTv?=
 =?us-ascii?Q?nZFvUyp5C6SSmmTBgKdoN+GEvkQcPVB312KD+3bpTNy4cKW6ODYURWr+IvCx?=
 =?us-ascii?Q?9EPsCXAdMUga3VpCr8FqFp/eMaAv/vj1Q/2fdEU01fcPdfYg33ziXTf/T2FK?=
 =?us-ascii?Q?ZDI/WfCoyEqdpBkGHnNqnifmGvrgjSFYLMEB6KA6d59AI3UlpwmEzens+0+u?=
 =?us-ascii?Q?dGgt6odSl20nG6yevE7/TDIcY+wcnr5DJCMGh+aFlU4VhtKqaL16lwgRR29C?=
 =?us-ascii?Q?v39vc3cGxFtghtFVCEf0+brA9Nn6w9za5DTvHkrCkh/2/tNMMTJ0cK2ZeN6a?=
 =?us-ascii?Q?xDfhAif6y//bGkHgtRdR/3OdanGmiGnyO62POwwZX7mkGb5WPGgs7KyQLzwK?=
 =?us-ascii?Q?hvjEr58mm8LAiSRrbWNSvua0UstCOzSQxXLxTx/6d0arpLKM7QpWXL32DLO9?=
 =?us-ascii?Q?Ah+ToZLrhgNzY6XTxicrP4x/PegzyFpEKXCn2fFe9D+/D9a9eu9h9m+CDOe8?=
 =?us-ascii?Q?oscKtnkcdYQG45nz3WaazzRVUF0Z70Vgvi6w/xjB/V9kW3fmjt2QfPKXUNBx?=
 =?us-ascii?Q?jA+Unw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:50:14.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd585c-8295-40cd-6f59-08de587646bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210616-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C13A04D786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

If dqm->ops.initialize() fails, add deallocate_hiq_sdma_mqd()
to release the memory allocated by allocate_hiq_sdma_mqd().
Move deallocate_hiq_sdma_mqd() up to ensure proper function
visibility at the point of use.

Fixes: 11614c36bc8f ("drm/amdkfd: Allocate MQD trunk for HIQ and SDMA")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b7cccc8286bb9919a0952c812872da1dcfe9d390)
Cc: stable@vger.kernel.org
(cherry picked from commit 80614c509810fc051312d1a7ccac8d0012d6b8d0)
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 195b7e02dc4b0..85b43d48f2dcf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1832,6 +1832,14 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
+				    struct kfd_mem_obj *mqd)
+{
+	WARN(!mqd, "No hiq sdma mqd trunk to free");
+
+	amdgpu_amdkfd_free_gtt_mem(dev->kgd, mqd->gtt_mem);
+}
+
 struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 {
 	struct device_queue_manager *dqm;
@@ -1961,19 +1969,13 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	if (!dqm->ops.initialize(dqm))
 		return dqm;
 
+	deallocate_hiq_sdma_mqd(dev, &dqm->hiq_sdma_mqd);
+
 out_free:
 	kfree(dqm);
 	return NULL;
 }
 
-static void deallocate_hiq_sdma_mqd(struct kfd_dev *dev,
-				    struct kfd_mem_obj *mqd)
-{
-	WARN(!mqd, "No hiq sdma mqd trunk to free");
-
-	amdgpu_amdkfd_free_gtt_mem(dev->kgd, mqd->gtt_mem);
-}
-
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
 {
 	dqm->ops.uninitialize(dqm);
-- 
2.34.1


