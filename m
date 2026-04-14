Return-Path: <stable+bounces-237917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML9uOGZn3mmxDgAAu9opvQ
	(envelope-from <stable+bounces-237917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:12:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB03FC669
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4778A30B8DD1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0A3EC2FD;
	Tue, 14 Apr 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnYlTJQy"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE03E5EF8;
	Tue, 14 Apr 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182800; cv=fail; b=AXQYZVLhmopVdL7r6LqI2lIZHyY4CvfpHNH8Hr2Aq380JYmk1y/qexCCuOe5XFFNIOfDewMrj0nbplhs+QNw6y394ZqulNBnRzJ/y6oI+Ac6oBMz3Kgo50ssE63t8vOjcXM5TLuWhBunPevUWZ1SbTboktOsaIZSP3L71B7QT94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182800; c=relaxed/simple;
	bh=bWlMjiyGJ+1DEeQkIwc8CEMLgLpsM+v1YfyjigVuyoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nF6gZVx2YL2qhpQ/mpJI6K+BOrz5I0+iUJ5i4Zi4V7/m6Bf2/Evk1yT2Cj0qDOdeMAOSg7T9hS948SQrryXOTwUEpkNZPqD7ZqS4V+N6QIVzUUfSQ5A9nqzRhflK/oukRAPtROYprxG6G1CokWcQ5P47yCTBURKez3DtRjd7dqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnYlTJQy; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG/WcDZYw/hWymd//1CptO5UbVcrfpfLD3/TjzAvw3XnMNEUBwA91/y0+yWr8k4WgCLSWTI0cUzst5KH55rDdvt3Ildn1krcgNNwPgNRuqKinbDMjnjyjpXNoHk74IFY18GBPBRxRDWviomlOvIV3+BWUd3ehDdAA/7en6Dboy/Irs6fkzIfJhaiv5IMFkFSuODWfETxueCQHySa0S8LqDysamIjO4aqc8MoMAMTlD7TqOcIyPX4VOEkl3Z51d3OX+3HFkxHguHwbK4NqgvJ5yj/grrMPGZkNHDooMvoOaJOKnNwiEan5zPqjmdiwaa4Jx1wRYVx/vQ7I5ykBcW9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/pSACup/E0uBP29P7d5OCo1T9iPVsWqYlnpAsNUk2E=;
 b=MIhsjYrM6yXRNnc9PJ6EqDhwHQ0cD4IHQ4+czX2KAaG5JSDazDJcFOU3YvR/M/CUvs5ANwLJbNgzY08oxuqZRERowOHXa7A4vejkrHR8hXT7tGfY4+4grl3hpx11158+RR6Vw0mNE4BQZGUY1U3/7J8DMGBnBrCpm6Pe1dgfE5bDCHyFKPvjqOrnZ67QxI/PgiRPgbcUarQb9lxiDkgbQ25qRPVPVBPUHZalx860DB3OZ2asMBc5yvawaAOvDNHn/J/SQwnKtexPrMqC6T3/pRq/n3aBkFbBfL/xfybsoroHUVvf9htB9T7uDrQfHohuaEoxM35mYG4+gM4JNyOu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/pSACup/E0uBP29P7d5OCo1T9iPVsWqYlnpAsNUk2E=;
 b=rnYlTJQyisofcCs3A0Gg/Q9bDwwEUeWsr50JOlXI4OPc0ar19grJUaCyQ2AVhx/3cxcuPlAIb5DQ7yzzil2TzoGlQdlx60cuSBLdHT6bP12OOpG8m3Kwv6I2BRge1stLvUceJCv6DKeGgnCm2rc+XlvbA2UjmAj7pARgMlmyHuM=
Received: from BYAPR07CA0038.namprd07.prod.outlook.com (2603:10b6:a03:60::15)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 16:06:27 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::76) by BYAPR07CA0038.outlook.office365.com
 (2603:10b6:a03:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Tue,
 14 Apr 2026 16:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 16:06:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 11:06:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 11:06:27 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 11:06:26 -0500
Message-ID: <4b7a0492-6ebb-e0a9-ca48-f2da6002d3e9@amd.com>
Date: Tue, 14 Apr 2026 09:06:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: fix IRQ vector leak in aie2_init()
Content-Language: en-US
To: Guangshuo Li <lgs201920130244@gmail.com>, Min Ma <mamin506@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	George Yang <George.Yang@amd.com>, Narendra Gutta
	<VenkataNarendraKumar.Gutta@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20260414121024.3142118-1-lgs201920130244@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260414121024.3142118-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bfa495-2faa-4ef3-d86f-08de9a3fc8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/DkzKZcSSi2Xez1QsxwlCxwsDGOPkSyCneq6LBV/Md99rV1ZQcytk6wuNSUUbWBX+1xDrn20gk/d7CgW65ZsKWFWMXxkzo7+73q2DrxNCVCrJwWHLWk6zT75Q7/YPY2akEzOqZPa/K+3rl34yufMRiG68qG5tJMC/6KVuW+Jl1C6UBlOgh4SjRgdjzN5SDVOpPZIkHRezZ2Usq6oERI1tWUuUGziA6FsUWhqX3RsejUG3bvaJXRBySiYyx0/+9S3nE2NHHHN+UbXn/5UIby6c/cRLKK/JZiX//Mts5SRcxppRdnAikY7Vds5saOx1iNWW4WXqEIusBCxKwTdHnZqXX4wjI8KJMlwiJzLfgzSpjd+eo4ncFQOoXzdSpGZZOxq4PWu6ODOT0Xmr0h4JTzPjPXsJ9bH9mBUOYcHUwGvyjGj7TJjJGSltK2NSX/55zUh54/1eOHNVXCcXOEXgQ/3Q5FKqqyPR70GZqdU2TzHkapn0mo4mxf5jsmp3JncSB+FXOMhYIZud63auLOBOGdIPU0tlRsvRxGu2XLlaYgAJbqJ8REVqYIjasA8uNfEV6QBx0mg7MCOv9x2rBDROaUM/zCNgj+ZXyldXvcDG8BVp9529U4WG6H843eggHlkecZ8uGlItLmNTM+ilF/pvFjZY3WdXhLvCGAGxHqpnitOTScm2IXhBXL/Aek4cVEg6USIVsfAdwi97eRfbgbDGI2NWjkGpAFqXBm670w+r3UM8uEw18IsGUMy3wCkGsDC9+hLBukDapvtoJRrG4HJj5UIxA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g29Em9y6Tz5q5kNyYoo/HWAopg2hUmCgESf/m+8lb6Se9PeEWSsG2QyEtbkBNCbbw/cmyPZOG1ZPJyg3KuXpb4F2udLMUmQk9xYjirIi1EvYO1k8Uhdm1Ia/XErOJx/Ve7PRv+l4Sug7roOg8XCjianbt9un8v0+NCMdjdOZER7brI0lxa21AHXEdN9NBo7kEOumUuDUr7U5+IqhTpbJ/G5iWrPgpN3LJWRMQEu0fxXDwlUC6fj64gRi8v3gk3jXhFiv3Erc7FYyVaxxBV/565z1GN7gRbJND7DIEFoMhcJUxK91xPHXVLccBRsOmGmLqGj7jdwox2ublGQBTXy1St0hqBLZQ/yK3K0RBvIr2I0zSQkVmfenqiJCZ2msoIUuARVEeX/2Z/DLPgErtFuSHpCszTeKEnM8eHg7bjFs5zAT2HzWgXux5DpjzXN4+GLf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 16:06:27.5170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bfa495-2faa-4ef3-d86f-08de9a3fc8d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237917-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oss.qualcomm.com,amd.com,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi.hou@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 42EB03FC669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/14/26 05:10, Guangshuo Li wrote:
> [You don't often get email from lgs201920130244@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> aie2_init() allocates MSI-X vectors with pci_alloc_irq_vectors() before
> creating the PSP handle, starting the hardware and initializing the
> resolver.
>
> When aie2m_psp_create(), aie2_hw_start() or xrsm_init() fails after IRQ
> vectors have been allocated successfully, the function releases the
> firmware and unwinds hardware state, but fails to free the allocated
> IRQ vectors.

aie2_init enables device via pcim_enable_device(), which sets managed 
device. Thus the vectors are automatically cleanup. So NAK.


Lizhi

>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review. Add a dedicated error path to free the IRQ
> vectors after pci_alloc_irq_vectors() succeeds.
>
> Fixes: 8c9ff1b181ba ("accel/amdxdna: Add a new driver for AMD AI Engine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/accel/amdxdna/aie2_pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index 4924a9da55b6..f05f49f691b5 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -591,14 +591,14 @@ static int aie2_init(struct amdxdna_dev *xdna)
>          if (!ndev->psp_hdl) {
>                  XDNA_ERR(xdna, "failed to create psp");
>                  ret = -ENOMEM;
> -               goto release_fw;
> +               goto free_irq_vectors;
>          }
>          xdna->dev_handle = ndev;
>
>          ret = aie2_hw_start(xdna);
>          if (ret) {
>                  XDNA_ERR(xdna, "start npu failed, ret %d", ret);
> -               goto release_fw;
> +               goto free_irq_vectors;
>          }
>
>          xrs_cfg.clk_list.num_levels = ndev->max_dpm_level + 1;
> @@ -623,6 +623,8 @@ static int aie2_init(struct amdxdna_dev *xdna)
>
>   stop_hw:
>          aie2_hw_stop(xdna);
> +free_irq_vectors:
> +       pci_free_irq_vectors(pdev);
>   release_fw:
>          release_firmware(fw);
>
> --
> 2.43.0
>

