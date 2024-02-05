Return-Path: <stable+bounces-18845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571A849CE8
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 15:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE131C22D2A
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A32C197;
	Mon,  5 Feb 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="qRme/lFQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2114.outbound.protection.outlook.com [40.107.243.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4884F12B8C;
	Mon,  5 Feb 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142969; cv=fail; b=sXyE1OH7tpVoAiMDaQbsm3jRdj/NM7YGP/AePIzfl5ANC6DjgQJIwoKkD0v46vAH55n87GVBcCxEKsIItmrOD28UbUJVt1WF4jI9nSsdNiCgkvtrIaFXwla9tBN2JKor+LeFb0Gpw3OFYlT6yOB0lEzM0MaYmOdIhJJakGYNUdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142969; c=relaxed/simple;
	bh=V1fq0DBQ1XCEbGKuRui/DwqQqZiKp6CGs5vbjhWG2zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cesTydDUwcO8TdloD3YgWt8XaKXivaQiJjxY1Zjc3lWlRP4ACNr6E4sltcimlCbjnB3Sev9CdRaBrFxEnbYGVNVj1kuzPQUbqo9F/KyDaUiFtYg7DDOMzZc/dkHtawRUBEGPxakORZ2I8hS3WQXrlhcsrzVrxf0Qu5qq5W2WkyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=qRme/lFQ; arc=fail smtp.client-ip=40.107.243.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfP9hOIL3QdVpHBAY/g/Wbk63nuWAMd3dPpZYOLu1y556pfdFOqkMOVj/zOzNo4nym3F6CAIIsGhaKOxU373HkGh16KQfzUrZZqCsXy2qPGPGwKd1MD/6M0LoZDHgtZzrxIp//fBBPxmStJdHMBYqpmd3+EDIKDysT/eh8XYH72NrtiGkbcdHOo615SuhzXxlViDmb8+t5Cv2Fw4t5nYg+ROQ78S/eP0ZSBO8+14xkU54kMfTFt3GEpSMYL0bxNQ7FvfZd1M6PT/7RFg9RO5O+RdeoYmHO6KbWGTQ/NrIGiA6PHDncV7x0V+ztCjWGiA1iQ3HJlhc/qsxy9JKKmkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A56STodY7Efx5Rf7AzUoaB+c0yqMwHpVxAt4ye/2iMw=;
 b=RlPMXA+uslRM/IZkBBJRtpYPsTJZTHCNFQODjH5QoHGZjaFA6KHms+fBw+CAhV2rm0DycWE4oKauHh+110mfjwoKBJKBJA5vvDHokGukiVAL4kojLlHiRaIlzXm5OYtMGnfjXqz1f1AjG3UYds8kfkx+CHzYMwyj3JabaAtBxJSvC2H3NZXvEY05wnC/GWLoqz6MgmYZu9fokV9IbnLb3LkoLEvfKAp/YWEDtR5Nw3CLdXrEZH+HpYr1tJMrj673KShnesCXAUVe6+ISh/skNRHFCvrrbOslnGh7dj1/Em5dHVZsoH8mSdZY/NYO2eBlxo2B/1AH6Td/8t3eNUALzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A56STodY7Efx5Rf7AzUoaB+c0yqMwHpVxAt4ye/2iMw=;
 b=qRme/lFQ5YSyMH2vB+KdlhqJfmnCuXAUXUfPEr7UxKQHj8gs9SsyZR9GkY3TwZBH9ddFa8r6nC0XcH6ViAG+wkMZFQ4Ju7SUtfZtzrR508rZYdMEohVutyYRI+wPHF5/ABUvgf6Wv9eF4CoRW+6g2Jes54VeDjpY6h2po8biMuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MW5PR13MB5856.namprd13.prod.outlook.com (2603:10b6:303:1c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 14:22:42 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::2e1b:fcb6:1e02:4e8a%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 14:22:41 +0000
Date: Mon, 5 Feb 2024 16:22:31 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Simon Horman <horms@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net 1/3] nfp: use correct macro for LengthSelect in BAR
 config
Message-ID: <ZcDvJ8fLWw7DCGZv@LouisNoVo>
References: <20240202113719.16171-1-louis.peens@corigine.com>
 <20240202113719.16171-2-louis.peens@corigine.com>
 <20240205133545.GL960600@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205133545.GL960600@kernel.org>
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MW5PR13MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3f0f26-21df-41d2-bce5-08dc2655e9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VNljLFS9g12LsRqGglJREEqMKX4fvOcwLZLSCQrNAw1CS3az2ZnB5T6z7TOU9e+pMQDnxirNTWAXoWhnEfGnBoiHGP14XOa63p0phq77tOKiJeRsz6+JSeyXxJvZYhkT+UYACA+d3qwZQ+ej6ulrLy0kB3VPTypV+YeKGaBQrIgnCZ/1p3un7Cou3R6Drd5nLrgnsqq37RS5qfml3VfykuehJCZfwHR/gwTJvzikbxhz2f0gWM+dHoL4CT68AJ/2JFb0PAK4LwjPMgkcmE9+yP29XtzZWXmysac3pWAlOBa60h8G4YL6bSTveND4ODvr/6anDSmUg0siXj5PT8YWDQyWC0MIZtA/Lto0MXpSHCvGSzJk6iuaCl6OhJlS0OmqtlfFOX7dpVVXvoRcpDjFhZnwTLEPlZVNRwKmz+HU/rEVNDOyOlrYSgCovjAJDXXBYR51fZ/1qa2f7sDgXTWqD6yBgWqSxm/93US6tfhfad3YK8htLXfKEuIyrNmRldTKirMLzd+QSc+nuo9AkT/FwT06plFtwi1XRStJOu062qMo2Nn7/88WzxpWixmsDrGO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(346002)(376002)(39840400004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(478600001)(19627235002)(86362001)(33716001)(41300700001)(38100700002)(83380400001)(107886003)(26005)(6506007)(8936002)(6666004)(44832011)(4326008)(9686003)(6512007)(66556008)(8676002)(2906002)(5660300002)(54906003)(6916009)(316002)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DLapVX7LSD4jijdTmKRaLxK6QhxWOl1Wy1mGO8KQUYvWS8tc4DpzmwXa2jR?=
 =?us-ascii?Q?mm5OZflfiQzzMk7FzPUUUAj0eWUzd1rMNipCsz97sRkxK92sAJ86XxON8VZH?=
 =?us-ascii?Q?aMUmYW4tc/kmWbvt0F058roXqVYmJHuyve8EEMPtGfwiZ1YiPgmGQDajCLLW?=
 =?us-ascii?Q?46/DZH8fZ1dHVRMtJmvActiEzEiK7LehcM3nG9G3f6XYQw0EFdNVEWnbeaWu?=
 =?us-ascii?Q?c/IETZg9f/Qi3wak/T2ktdPe1NcK/5+PLttltDaESf+DlKV96Rw1WMjON7oL?=
 =?us-ascii?Q?JkrKTCT3lC5zL35AH45xCVcmdkppLFIsKmdnWwwaOLdaNJ41YQAV4WYgJGX3?=
 =?us-ascii?Q?FYIBSWalk2lOwAbfUlAdy54qqBumRaSXTE74V0R8VD9Jn2ORNne77fl9Wqfr?=
 =?us-ascii?Q?5pnD2b9p3UnGlFyxjpla/MSTsb2lXgMQtyumZRZCee246TpT+SYlHCzDJB14?=
 =?us-ascii?Q?G+NNzRmP+BegnFxNnIA8clvF+5BumpWf0x4okty0uHIZaf47J6LcTR5tJPjJ?=
 =?us-ascii?Q?jquEOUShp8NqHieaOph5SorO8QCgEgXZ5L3Ias1ZbUAxBYHl0pqi5Drv5JUC?=
 =?us-ascii?Q?uWZ+ezcrUkNaVPWIXcym/tv5oqgaCFS5DcmZb1WM3imqmEmtUtAnUkkhklDQ?=
 =?us-ascii?Q?I3uzb9n3d/m2Br1/OjO3Kv7jf80R2N6smtJo6Y5b2iJ9sizQNfp2Dd2VdCGW?=
 =?us-ascii?Q?NtPVcSrIeE06T0JE9fl12Hug1wXF2CR+RdPvALMMFI5+bTCmlpUjBIhBomY2?=
 =?us-ascii?Q?SKZiqhQKgGFgsltn1Tkst4Ktw4+Le5IXDzVxhm/W1lRlz87lWqnoI97uS9AH?=
 =?us-ascii?Q?oaaAHL7G5Im9JLecqt6EqCAJHCbFwfBB6iP2OUWjKuEZOtVbqq2nJmqL5JU6?=
 =?us-ascii?Q?4wUkMC8jfVks/+P5MXMh0nz1q3WxsI8Qd7dyc1wblN8yKrkbM7v5nIj0Jwxh?=
 =?us-ascii?Q?78vFJvXREAktcZCQ670wBJ8j1vXdZSv1+nuL0/xd4blaU338nSkJtcGT5jsD?=
 =?us-ascii?Q?RD1IBac3R/IT6y3848EIuRlNpbUzH1v+QJ1P83ot03hO4kJ4j8EvsAPpWl5D?=
 =?us-ascii?Q?DKdA1azTQYlKASVnbvN0EpEQfgvW8/OdaDfBuZXb9jND2NmeQ6IvfndAn8gA?=
 =?us-ascii?Q?q/OauErg3vvm6h6Dr+q5Rm2KlymwWyadwYlo8itpEy9HXs4QxEj1AnHFMnJx?=
 =?us-ascii?Q?o0CJ+UlDptx2CZ6ezCNqpa8lVtMMHJkbJhLWINVizs7wXkNPibeJl8d5tInq?=
 =?us-ascii?Q?1YKbJlCjzcCXNitBH0R1e5rb3bm8D6Xfn0l50ZfOfvivoorBa4jYFVXcI8o5?=
 =?us-ascii?Q?4JHHJswh2eLwi5wOys5EL0QeC1ff2lDbFPoLpdoSrbQncDou/xkWQxPai8L0?=
 =?us-ascii?Q?j+HIr4K8N5ffHKNnA8xYoTqL8fdpWqox8iMQgSwvy0aYpFN2Kc7HSBKW4C5L?=
 =?us-ascii?Q?d2qnD8VfOl93PmG2gzuaWnZ0A5nz0GDA82t++HLArZPtd8KKObygvG8qGyrT?=
 =?us-ascii?Q?v3KzkiQffOiIiIMHK8o36BAgjoVTVqvwDcByZjt0lRYLCXFXrTmTJNFCZPX/?=
 =?us-ascii?Q?v98aq/Ppgon9aJhBhb59FsueeLkxlRpc/s0Dhw0/ajmM6Es/kPCNC7RFk97R?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3f0f26-21df-41d2-bce5-08dc2655e9e5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 14:22:41.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3sd72Bk8OzFvRu2M3DRV6JD8o5ZEcOvrt2yXgYsb7Gzzn4fnz5GOv/19XdGnpSaWcosjJOqg6YHL7d4+J0++iln32lbdfA5yCL/WFDwbqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5856

On Mon, Feb 05, 2024 at 01:35:45PM +0000, Simon Horman wrote:
> On Fri, Feb 02, 2024 at 01:37:17PM +0200, Louis Peens wrote:
> > From: Daniel Basilio <daniel.basilio@corigine.com>
> > 
> > The 1st and 2nd expansion BAR configuration registers are configured,
> > when the driver starts up, in variables 'barcfg_msix_general' and
> > 'barcfg_msix_xpb', respectively. The 'LengthSelect' field is ORed in
> > from bit 0, which is incorrect. The 'LengthSelect' field should
> > start from bit 27.
> > 
> > This has largely gone un-noticed because
> > NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT happens to be 0.
> > 
> > Fixes: 4cb584e0ee7d ("nfp: add CPP access core")
> > Cc: stable@vger.kernel.org # 4.11+
> > Signed-off-by: Daniel Basilio <daniel.basilio@corigine.com>
> > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> 
> Hi Daniel and Louis,
> 
> If I'm reading this right then this is a code-correctness issue
> and there is no runtime effect (because 0 is 0 regardless of shifting and
> masking).
You are reading this correctly yes.
> 
> If so, I'd suggest that this is net-next material.
> And, in turn, if so the Fixes tag should be dropped.
Thanks Simon. I was definitely flip-flopping on which tree to pick when
preparing this, if not already merged I would have gladly dropped it
from this net series. Thinking of it in terms of runtime effect is
probably a useful angle, will try and do this more when picking a tree.

