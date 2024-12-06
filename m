Return-Path: <stable+bounces-98939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D29E6832
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 08:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A8B168E51
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 07:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B21D63C4;
	Fri,  6 Dec 2024 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MLFNV0Oz"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AB197548;
	Fri,  6 Dec 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471310; cv=fail; b=ApZC6PoGA3uHtQ3pu7s7NDOM8ho8ws6CRAr+/y4rkOfzJvPC6uWJ+/8g1QeYu1vdx7jSwsYC/7EpdYN5AEviYp3M2J4F5hWF3NZTn4Tmss7brnr8GcPCXBo5+p2VDEovcULk+CzfC/1d573NlIm1miJwsxzEg8KoGhe+xkvTkao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471310; c=relaxed/simple;
	bh=gWvp08Y9778s1h3INGSYHKaJkE9ciK8/79pA6Qs3w0I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CQlLeveSCOdBiEWKtsp9k1WPDVHA0WZr20wB7cXkwjP8NBad0Q9P4kQQ6+aelBLPIBPabvp/DPK1/c29+rD5BdaLJ76v6DBWNoh9ILnijJ0HZ2+3dJrMtTw0nk/HLl8cJZN3xuNNl5Lc804vFxKgPbw+6YdBjSsFJkgsOiDy2AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MLFNV0Oz; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIjVKDa7KVn3Ty6b5TpTOuAwIKgptZmjM2lDMiygLw4djbY0SltORCUL+DtfA0V0iiGWsy5vz4xFQ7IRdCpyZbNz+MdEYBeuXnhtvKTAVUh4Jhvi2xHQEB45szYKXNfgMUHcKSg0Zkxc9jT2ov6ptfsEo9Ea5itzY9/2LMzG5kWJfkrkHJP/DPZ7qW4d7Y7M6ZQ9t45jkTF2ti+9mOIMXzBkqC3Z/6FITilcELHmyCG0YsUnGUTTVanzf/nuxQDl+Icl8I5s9dc7IYvHewYCaLzpyd3XNZaC0L1Dh3u3ERDPTEL7DOEXiuy+1lioq/1cDVDtH1t0ttys/PL8Ptwf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiStLYrfzUClt5UzCYLKUQxARFAQcX7Seai28oU6NjY=;
 b=Bz3q4fo7ghQU7Xy8+36YdpcToZKWH+tIKvvVloBF9oFK0DpG1rCN25XDFXQIlfDP/7OMUN+80g7LEYVGWA13WJLQ/3fsmVu9uo9H7YPhedbDO3lYfeP9JWzbU1Znf9KzSo1ml7NhMyp4/P3tqH2p3ZORh51xIrkg8HOaag4oZbg23hv+cSR9gPAxnL8dYEctgsrzncIfIFl+tJ7S4IiM0gcXqk6UkADxI2hkLjOLqbEklXGrysYblGqeYJeD+cklEbnq/YtFg9Tg5PvxjIDUjFCeiu6fpcMldlGf1UgbfrDfIZxr0VsukzgjDoIPeh+rNdJ8BAUnH4HjV1BLnePH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiStLYrfzUClt5UzCYLKUQxARFAQcX7Seai28oU6NjY=;
 b=MLFNV0OzfeQItTcRfzGeDpgsIRG0A3oRkwBVJVzZILKVjUEd7dkqyaPwdd3S7YYb6gRgEty7QKBJQAXc9pDXn1iiLaA/W51LEbwYxaZ0i3NSZMC2k2S7/CmTgaQUWqLof29g84TAhhuwbNMTqF0Dx+Q5gbDJOEyfPEIRz4ITAqahQZ9HVdt3fWaIYcc+/ktpmQOp0pSU0LvkIpZ83HT7cYqU01ocX/8PFvMzFqoCnkqNrdVSCftcjB+PV95MRk7JV5EecOQ0ghi+nQoEcLq5uAU8iLRzhEMoDBmpBB/k54IA3KMEuM08dQ4aDDKkq3RDygyxUVm38Ngi3/lBmdEC0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 07:48:24 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 07:48:24 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] USB: core: Disable LPM only for non-suspended ports
Date: Fri,  6 Dec 2024 15:48:17 +0800
Message-Id: <20241206074817.89189-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 26db9f51-f642-45a5-b3fa-08dd15ca5d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ggiARTe2d7c+wrN/vxXyq/gP6vyXNrq7afiusa/6/dvjrEKCLout3sStcGyO?=
 =?us-ascii?Q?rEZwP03mQK6vKiPZADEMC7EWAHBSPQmthClTJ3uxgjFQCLn5zkyq6TvzP7GI?=
 =?us-ascii?Q?FR34gbd95obb9qffiIKDwelaTxuxZOU7w6bjBlkUDutGHrjK4lNva6GZ7Oyd?=
 =?us-ascii?Q?RRTCv8XSNruUMVSDt/DQ6itnHr+SDACe2FBPmR4GXn2wKuVjkhcTL3bqg7Mn?=
 =?us-ascii?Q?WiA45DKEdJOottMIPadnNAUmWkyP5XuUbTPCzDiu06tqecTegfDaASu1glu0?=
 =?us-ascii?Q?p4qmiY1gdP6ijF70v2wfjZG4/GA89cKhSKKPmCVrXhabMer6+LMPUTE5Ab/b?=
 =?us-ascii?Q?Y+wURus6g8kH7nL3slqrRguQhtfIVqiVFcE++e1/Y4GvxjTBRnNdnt9pALmy?=
 =?us-ascii?Q?5/OFxqAveYlWLp7bnW4/BeszQJ6SfFGYNk09lu1EvdKdutQDLQY2Cq5bqSX8?=
 =?us-ascii?Q?p7Gw5K+ZsfaorLScLmt0/8gusWgzIDaWVXNHH9rq103KnakXFhi+U+OvQ17B?=
 =?us-ascii?Q?yxQCSsnNo+Mg3c12g/DpL1LxoJdff2QVThNGAiHPU5ZaNGlCNk5T/sj1fNBO?=
 =?us-ascii?Q?BI0YTJI5z+CWvv+KvUmafZAVNtz1g2Y5Ev26ujAA1TxiL/0ZtpWkV3fXuNo4?=
 =?us-ascii?Q?TcmSwveeDR2qLP0xw7zDbAjOBUsu4xr28lY8EoLILCSMvc+BQhaa0rmIzdav?=
 =?us-ascii?Q?k7C7psqrFMrFfbjLGwCAajtAN4pGZw12ZGaiAnE3PVBi3xP7vmv0zUC0hpIM?=
 =?us-ascii?Q?swWxe/zKV55yzmmlFjQyS3CxLS9M1JfPXzVAip84cYuGiRLI6wmo6sEpaNNX?=
 =?us-ascii?Q?xjnm3zLZa8SAYEVdh/zfGkVhqC+O/Rz+HK1ge27BohR+Kaf2PoMv9MIOTKjH?=
 =?us-ascii?Q?Pefj1txs6g7sHjia11odHfCV7zKtY/19s8ETnO47xL/4XpkYwjN9Yynxtt8P?=
 =?us-ascii?Q?fjkQ35NdfLqNqGAsringJAssXYXCYVmTBnFb2XdIBChNCEKydc9ytcGFAOtC?=
 =?us-ascii?Q?aMqQEjDR44oIUYbAYAryU2O5qwqVCcY1fkb8hV4GSETsMmBUEVe557bIaKct?=
 =?us-ascii?Q?08Tzq5uOcv1QVc5eg/U/5fCugtiWiulUtIRTXz6WQaTVpf8SBGzb/xjPQhTr?=
 =?us-ascii?Q?3UBNvCyGnKLrcMe1ovcCtdXQFpx500otcr4fTSZH4bn4qY99DA/tUVg2/xAf?=
 =?us-ascii?Q?TfM/aZ2TacRsJr3p1VffRlxTnOjA3sH0+AZc3kt6TdHJVYNpuxvcbHWKxG/l?=
 =?us-ascii?Q?1IERph5s5CnHtCUFj70pfbNxVI5a7arFcbRPgq9AqpWqfX2A56H6htPIiy2y?=
 =?us-ascii?Q?P3sSmEWEd4byydNFOqIxJ156ykmtbz/SzPQeGxMoKulBMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vr1O8K4G3EWPyJ2WggnbWnJ/hQQtlgQeYDFj6qzP4BScae0fWRV8NOO4fiSq?=
 =?us-ascii?Q?odg0+WcUTkHK6VInOXeThC8FgzYOwUOVgLBbdeq4mU2wKRlD2A0dzZV/cmyH?=
 =?us-ascii?Q?ZeTTV1dcXRLzCMe07Y2lcwup3y+kWJmzYVyE4q3BEsHr87m4WTZL9H/WGfG7?=
 =?us-ascii?Q?/WY+GrLl4XvpdhrRteR5paKsRw+T/WXlLrYyozIPKyGcIIDMAsoAjFOZzRRf?=
 =?us-ascii?Q?pz8iPqW4/2eFCxT8hex67ayMbeUjebtJav0Hg7U0ZA/Ghwo2reBO0ZdnR3ot?=
 =?us-ascii?Q?PLOzbQpe/HoRpvSbFO1kwd7ZHsNrIXTCr7jSKP9IZr3e5Ak4WIR/sGEdbGcN?=
 =?us-ascii?Q?fZw8vFODXo3rMUB47YynCyjAZYT/r8FbklkfWRBMUh5Vr1DEtsQvmUwC6Ihc?=
 =?us-ascii?Q?CxLlka59KkmAB5HHKTQth3S3Do6qHgWNYrf38iNTxsHAdQ5kEFVXiJh/dtjS?=
 =?us-ascii?Q?9c2NW1gcD053WdznobLY8SkU4VTRHPWckBWIXdjnJDmkzOo4Wq4bwltbG5O6?=
 =?us-ascii?Q?7/x8aJWSs+2TdsCeGPREZT77bppxvUXc/WL5lmQI03TAcPtGm+eRTkv7VoNE?=
 =?us-ascii?Q?Sv7hfvE05GPjHyvG+PRgbiiY9Z/iGEjGSb60v2jwZzC+D70dO+MOmGKRVlX0?=
 =?us-ascii?Q?8D9nHBR6KFWLgJKAUWDAfIseYNAcCgHX5i3IGzGJQqTBzeZw8UG7Mlhy2isX?=
 =?us-ascii?Q?u5e9BUzRKIgP2eHYLUSnw/oHklWznti5H12QuhT/dKYpwodcaAUCWH4CO7/I?=
 =?us-ascii?Q?ps7K5KBH30Q/Dflf8nuwMWwd/WoZxaXIUwsZDrLQI9qKU1LRYk139tWZH6Ni?=
 =?us-ascii?Q?ctHjYEacRPbG1E0x1kT1wmAaGRRdvzV56BJjeW2yJ4417moAi8P4Y1Ajksxh?=
 =?us-ascii?Q?YuWqPtpab7upCGQe/7tmdMAdv0Wu3i3wiesljjln9Fu+yfb6CIppBM581SQN?=
 =?us-ascii?Q?z2Xo7WPYs2u9GCVbg/IyTCcLjCB9q3FqVhcfP/vqUIDbI42S/teUjHcvpjgm?=
 =?us-ascii?Q?a8iHY0gPntuQdnXs6u0ARmQ7BIIeHC9//oS2mFQKza9NbV4timxQpJGqJ3Ss?=
 =?us-ascii?Q?zsFwrbgu63KVcNhA800KeDHJbC2t9/sZpfu6oPJxnTDWSg6FBWStmiBQEy25?=
 =?us-ascii?Q?qmjahqS5H6TX/gn2XnjJk0tRvT3kWdnx3IxeNFRbrwuI7kH8P9kj+ktCfC0F?=
 =?us-ascii?Q?8Tj/7i04EjAQGMgxbfOYPu0AOdcPF/V9E8Hiiap140ByLLX17KWO5Qgl4CoS?=
 =?us-ascii?Q?O68YZjytdzEJ0cmy1XvW/0OLcu/p9llZobWRxCDuO2i/eZpbKtdxHl8onU+n?=
 =?us-ascii?Q?2uhI9+9KG1oagjccYAOeY+5m1Y4i7dwfnwsICD856LB6+afihTP7vrRdxEbG?=
 =?us-ascii?Q?h4y3AYlmzE5zoQi5oBuB3OC/cZ2g/nuvDNIMyDkdKRjC9e+2T41ese9xNyG+?=
 =?us-ascii?Q?qL5vk9tx/tZ1TmQl5xW1fVwKC/6SNXFDLCulWSm41LDLptot/BAwtWM4P40I?=
 =?us-ascii?Q?nZ2K9PbsJIOjVxw7tKL8It/DFp+rJBlnO/3KK6xQclcACMtYDvZFM+SAQ/V3?=
 =?us-ascii?Q?Yi5TAQRK81lxxSEaufmc9Ghu6D8k7lp8EXLKryyp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db9f51-f642-45a5-b3fa-08dd15ca5d01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 07:48:24.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLVUC3JuIrSQwlQhzFy/JFnQRWC16JH06bCEMpo2EWw62+Ru0LpFFjKTfSEcLdlUCPxKZPl9mptEEjZ9vYYScA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

There's USB error when tegra board is shutting down:
[  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
[  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
[  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
[  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
[  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
[  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command

The issue is caused by disabling LPM on already suspended ports.

For USB2 LPM, the LPM is already disabled during port suspend. For USB3
LPM, port won't transit to U1/U2 when it's already suspended in U3,
hence disabling LPM is only needed for ports that are not suspended.

Cc: Wayne Chang <waynec@nvidia.com>
Cc: stable@vger.kernel.org
Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v3:
 Use udev->port_is_suspended which reflects upstream port status

v2:
 Add "Cc: stable@vger.kernel.org"

 drivers/usb/core/port.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index e7da2fca11a4..c92fb648a1c4 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
 static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
+	struct usb_device *udev = port_dev->child;
 
-	if (port_dev->child) {
-		usb_disable_usb2_hardware_lpm(port_dev->child);
-		usb_unlocked_disable_lpm(port_dev->child);
+	if (udev && !udev->port_is_suspended) {
+		usb_disable_usb2_hardware_lpm(udev);
+		usb_unlocked_disable_lpm(udev);
 	}
 }
 
-- 
2.47.0


