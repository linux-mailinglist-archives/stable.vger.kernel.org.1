Return-Path: <stable+bounces-207913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B7D0C227
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 21:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D35030116C5
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD13659F2;
	Fri,  9 Jan 2026 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fI3D9tn1"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAC22DC34B;
	Fri,  9 Jan 2026 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989091; cv=fail; b=gp7XqK21ouycOdnR8hGrWOWl7l+IlamRe4Jf5oEyPDtWNnmQu51bfF4MMxj9ScbfAFwT43nLfNIMbTClnLru1OCZ/vkwuJGzhQTk5zPl+vu7vCpeoku5nNZC6Ny+aZ0FXRhnc/NOQDw4WKD6Qp9xV1yDoFYKYJ8hOIoExB3hWaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989091; c=relaxed/simple;
	bh=5i9fTKsxvYzMYw2mpPi7QPjbfH0mb29SpforXBdpSMc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOLqCsqq2LMjbRLY1kelm+twqmMMsAw/M8OCfXi4mOraTvZjHiJneMf92fbwEGHku6xDMwq1+9b1+jkse8TTIc0jDCw1G+DBBPlchywYRsp7dQuTF9zqz+D+dpWfg89/+6wGSAEJH1jZP1qjlJQas5stvqjRVhB5B5Fj/hQQXoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fI3D9tn1; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBLfPmu3GIb4eukJ5eEQIJFS8BdBXctjppr3zATxSzOFOuImbr/sCW/Ay9jYX2vZpdgdxtcTy0abLrPwoFK0IzBZxLCcF9rpyIQf35P/7Qu5HEKibtFu/Aqv5S3I0PtjTBTOwfnwj138G5gKTWbKCz55d9dpOL6tYPy+MBOBLQmREicKWuqi8RTUG1C6RFSTeSuVrDTAWUlqy32qdUxd6+aXpFq7S4u37nmDLMvHOlEc4tHUdv5Bb3NJB99EyVsl7kA9UiKj0aFOG4xRXRr/uIAyWLp1HXJjlANBUATBOX5VPIaPYjGCVnnHN0tojOmpifSacrRWyP4NDYMZ78sb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLjptxB/VJTXgYq4W25Ij0o1LhSrAq0ZgZ1JQeZa0C4=;
 b=onuvcDrm/ZwQOjOD/ZnC5+lB60IhocAi2/SghHRQz9pQ4ajbJf1JjawKzOM/A7Xvugu02LWugXFUDFNCiq809YnjZee8FGbCch+IWR9lcuSEHEd9MQg0OXYR/lODjOBOVseuW9+oRz5kZoj5IcIuFh4G/lsZO5DrIydYxArojlsUSWetnYC2SxRaH/FjzAl/5VGdZK5mEJ2MA20vwFQpxX9zrpVqF6V2Dk91tmQAm11mYI7FoxspO6zoKm2E35vBnDECV++ejfAYztCoLuFdGiN4Tz6KBnuj6IaiOdvy9qShA9iw3NSPW05yZH3SQ/q/geRJFcSNBNfBXJ5+l4QQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLjptxB/VJTXgYq4W25Ij0o1LhSrAq0ZgZ1JQeZa0C4=;
 b=fI3D9tn1+EZyfMdZrZBuRNf5luWqpRWX3f5PgbLxYpNCSKmgGzv9kw6s4pXLnzzUsRRtLBpvSWOvuDF8JG/HkUc+nMpMGrnKGHCKCue1BhlZ/39SSh4ppY2ObRxHfX/imS8AybkweJGtAuGQSUIReqkAa0+RHlKXXzl12c4gNI4=
Received: from PH7P220CA0172.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::33)
 by CH2PR10MB4376.namprd10.prod.outlook.com (2603:10b6:610:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:04:46 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:33b:cafe::70) by PH7P220CA0172.outlook.office365.com
 (2603:10b6:510:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 20:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 9 Jan 2026 20:04:45 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 14:04:44 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 14:04:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 14:04:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609K4i9Y588470;
	Fri, 9 Jan 2026 14:04:44 -0600
Date: Fri, 9 Jan 2026 14:04:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: <vulab@iscas.ac.cn>, <linux-arm-kernel@lists.infradead.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, <stable@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] soc: ti: pruss: fix double free in
 pruss_clk_mux_setup()
Message-ID: <20260109200444.k4kyd5zqqsjeojsx@dreadlock>
References: <20260109152016.2449253-1-vulab@iscas.ac.cn>
 <2819dc88-51a5-44f5-bedb-6759e7786fb2@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2819dc88-51a5-44f5-bedb-6759e7786fb2@web.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|CH2PR10MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: f110924e-bcc0-45f2-ad53-08de4fba55c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXNRWmxuckpsSHd4c3V6SVdTa29LQm10SEtaeWpUU3FNc2MxZzZIRGI4U2tP?=
 =?utf-8?B?WXk5NWZITU1zcHR6UHJwTTJzdGw1L2ZBTWxyb3ZEQUJiL014dlZZNTkwNnI5?=
 =?utf-8?B?UkpxKy9nQnd0Q1MxU05uSDc2K2d5bmpxcThjc1dENkZuYWMyTlNYalU2WEF4?=
 =?utf-8?B?M0c5RFRSUStqb2tETmgvWU95SnI1SE5idVlpdlFjaDJHOVQ2cm1OQ0U4UnVy?=
 =?utf-8?B?T1gxUlA5VWp0T0dsNmVTcVBqSVVkaStoZzVGYkJPQU1YdUM4T0Nvc0MzaHNE?=
 =?utf-8?B?UU9NYjlxZGg3bnA0OC9UenVDekRINFErdUg5RHVSQXBBSGJsOXRzTDBqZVdL?=
 =?utf-8?B?YzVlRkZDcW5JblQrNnBHY3MyMHZwS3hRcW8vMHFIaVd6QWRRTWhlbTl5VUcx?=
 =?utf-8?B?SDdDY2o2cFAzai9CM09ZRExiSTlpME1LcklOUm5mdGMzRFlVM2s2M0l4cStx?=
 =?utf-8?B?SCt6SG5ZZWkrTkVsQVgxOGh1SWlCczNZd2piVmFXMmlOS3dRb1Bpa0x3c2Fa?=
 =?utf-8?B?UHM1NmtWRjBMWDdTMWNkZWFMblF2MUVFRHdmOHlFelEvM1p2UktDdHZONjhY?=
 =?utf-8?B?RjA5a29QY1dUbjVDS3phVFVDeUxWVFh6YXJrdjIwU2VZT2k3NVEvVzJndmVj?=
 =?utf-8?B?bmN2czFDcjBvTm9BN2FoV1RwUVFQc3FuQnROYTBGMUVCWnY2VHJYQW1PQzJh?=
 =?utf-8?B?RXBhTm5UN3R4cC9mbWFnU2EvanVBejVFK1V6b2puME0xUEdJMTc5WXA0TERI?=
 =?utf-8?B?SEl5U2Y0OW45SysxeHRZNk4wRDhvcXZhNHIreXZEMlFYSWxwZmkyMHNERkli?=
 =?utf-8?B?bW5tOW1WL3hSR1U2SUlPRVdyaWkzZnE3SVJ0N2JTOTVMSEtDSXA0RVVrWURM?=
 =?utf-8?B?TTZOSllGRzUraHJrZlFPQjFhTWt6YlNSeWI3THhPL2VpS0NLOXN6QlRZbmFV?=
 =?utf-8?B?Y0NsSmVRS1lMOEJoNHdQbVVJdG9TK2lSNXFWYUJkcWhBenEwdDZUeWZhMnNO?=
 =?utf-8?B?NVFjUDg1N1FudisybTQ3MmVSeGNJdjhnWVVWNU1lTTdDcVUyT1FQYmkyWktj?=
 =?utf-8?B?MEJKcitzMTZPWDZkbzZkNHowVVp6cm9UTUpLcUhaMGFQTllZNk9uRE9UWXNq?=
 =?utf-8?B?dnRLWUZXS3FZMnJwWE9UejhIMlpGamxaOFB6RVE4czdPdHF3NTN0YlZIRmJ3?=
 =?utf-8?B?VXRTa0lGRjBGK3F0dlVvbkZpVUx3WkNYMzllNWU4L2F5RjA1SXRwTURlUUZv?=
 =?utf-8?B?SGROaStZR2tkNHZVd0JqUVRoS1F1Zk5VdVpHRklZc1FMUHhtTStETld6UzhS?=
 =?utf-8?B?L2MvNFhCSHIwUWp5QnR0ZndiQ0Uzbm5MU1VWVGd2Zlk4NDJJQnNjcTZCSy9E?=
 =?utf-8?B?dXdwcWJIUGVsMnRTc0NPOUI0ZnlVdUZyaFp0elVqRUxsU1dFZU5IS2w3MWtQ?=
 =?utf-8?B?dVd6eUp0VWNTL2N4RXplZUZhQnF4VTRBT1AvUTdYNmhGaWNHZFR4MDRrek5E?=
 =?utf-8?B?YitxKy85U3dHMG93SWJtMDdPOE5rZER3OWpnQzNpT1B0SHdJbFgwbksrT2Zj?=
 =?utf-8?B?dHVDMHZRTXpKVFZZMmkvTnNZbEVGRXZ1ZjROUHh0NS9oczBrNjBaUFA3aDFk?=
 =?utf-8?B?TS9FM0dyVmk4blpERmtUcHUyT0hxZDFTWHBGOTFpT2tmVTRvVVRzT1FTSXcw?=
 =?utf-8?B?cVFmMjg5T25wcDdlS084Z2t2OGxvS1JDYVR3UDZnZUJMcDlzWEpGK25pVGlK?=
 =?utf-8?B?dzNPaENyaHQydUdKZ2VzQi9lS0g0cTZvTUYyOE5XR252MnFVWklaV2p1NmNv?=
 =?utf-8?B?cnJpc2ZlbDhYQkNoc3ZDT2o5ZkJ5RkZaQnIxbVV6cU14VDNPWkFVRnNrMmdv?=
 =?utf-8?B?OUZ1bitQWll6YUIwNk9mR1ZJU2d2aGJHVW1OeUlrK0tkUEhFUml1czhvbU00?=
 =?utf-8?B?YzBOWFRXc1dXVEdCV1BjdXZkYlhLNnV2ZzNrRi9NRmE0NlhKY1JPVTFXTE13?=
 =?utf-8?B?bGt2S0RoREFjZlNvRVlKcWlCNzJtUGYxcjlCVmJDY2c5WmZXZUlZVzZxektq?=
 =?utf-8?Q?XYoaem?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:04:45.3469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f110924e-bcc0-45f2-ad53-08de4fba55c5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4376

On 17:40-20260109, Markus Elfring wrote:
> …
> > +++ b/drivers/soc/ti/pruss.c
> > @@ -368,10 +368,9 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
> >  				       clk_mux_np);
> >  	if (ret) {
> >  		dev_err(dev, "failed to add clkmux free action %d", ret);
> > -		goto put_clk_mux_np;
> >  	}
> 
> You may omit curly brackets here.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc4#n197

agree.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

