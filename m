Return-Path: <stable+bounces-119916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D491A493DD
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9773AD36F
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8892505CA;
	Fri, 28 Feb 2025 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="mv168b4W"
X-Original-To: stable@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF330276D3B;
	Fri, 28 Feb 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732357; cv=fail; b=f1DMcTz1QKRLw+nkc+Oyb+Icaxb0tEegtoH45nrnUw7QUG4fEoHyzHkitpbHvyitcsKY07FDF/tvlUh2rg6Mvn3cLH5QoRN0DOPYuxlTDcC57ZR+Lr5h6+HtYDLoUx222Ofd+eh7is+aUfkqTH/jxCu8bxvZ3xvFQ7pBqtJUaeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732357; c=relaxed/simple;
	bh=j844lNhOdFBP+4MHpBlrDC9g01RdtfWIt/fT9mmLhIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGI62bVynB9Lxtycw2wGSlnqPkipQ6m+KvgJb+Bdi7dNnulaZkO/aYOoEzlflTO9lLi+hqOPR0JJH9ZCGRpNTkPf0Fr/dcp/lSgK+iDeOTcP+uzjyQw/NiSowhi8E5abuiwkaVL/bdjR0L7j5RSevZoVE2weZV5LT9UGSWMIYpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=mv168b4W; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S7HiY5020100;
	Fri, 28 Feb 2025 08:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=7XjnJsLygPVM4M3gwK9gBmeR3QYIw4O
	YEOCa3ErMeko=; b=mv168b4WNewfWUC/CbGoThepC7A+hGiHj+t6F9Gim/Y13lB
	9NJOIEqBPE90hahK4bgA93jNWbNxglBdSzzEYrBz84+Q+xbLgv1sk7M7K0QK6X7W
	IEoNtHDqX0gCelmmNvJhi8ijy/qytmuuwqCcDh+kdk+BspQ95QKK4+3qRBCf7CDH
	GZHSsH0BmMeunGvp+BWOqHvigKtQ+01Cg4aBSjb7EcSLVhdcovLaIlWceVaNKtn9
	Tmdzvys/D+3cym9zSH3sWIQFUQ70052HzOe36cODNrH195fIEdvHA9Vs0DX31g2O
	1CV9cZnn/PtOli4Ky9FFW/wH2IrBJwvs/grY8rA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 451psvadxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 08:45:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jfnj1uLNgdEYGQ21XbWWZQByW0X+LqktLV/36LMprp4ymDTKS3uY+l6LRXT1OE0HT9sbnPnoDZSWCG2iB/TLG1aa5ry2qRI6JwgXmAjqZ/j9FV6WCtCKLNkIR+yO0n3XJqEbW1cC1bKGLgzKzkPsVN+RfHqebcGi76DdbmDDtLszopBCReZkTUpWBe9uszPHgXXZ51cym+0QV30rRAM9vGU3TksrB8o43FsvRl0rRbhw/1IoLKwWs/2Hxf9f3dQnXPXNIjBSdjdHxBa4Y2Efh7z9x8g7ehlOI1gpZxGqY2oiX/64Nr1MGqtLIV3S6UnHuEEkZ4t+tfubCdj4DX89iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XjnJsLygPVM4M3gwK9gBmeR3QYIw4OYEOCa3ErMeko=;
 b=Z4rfncsxYgqSSaix8ytk04CTup81OW4FMMNsJ0EIG4hPrkemAnLBNALRVdm/1hZcYF0TZ2bRHjMSlCN7aGBTinF9C0wM9OMqCfNHSqLd6mgba2MXujxqYKYr5j7uZT9j098cH68JONVIl263JVctt8TP2jtH+aznr1BINNXo+vYPIHzaQdNmrR3eD1l0Exf24Id+pJOX7aNFNguS2eJaB84KS8l9h7xJsITg9NJmxO+QcilHVC14DumHFuTPkplatYkMATU83Re9nJIbU/PKJtTuaUmfmOtQaPNjRK2ViKogAVn001fQGw+BmMhWT97SeGijW7CjDgYr1zP5x1V+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from DS7P220CA0041.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::27) by
 SA1PR13MB6799.namprd13.prod.outlook.com (2603:10b6:806:3e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Fri, 28 Feb
 2025 08:45:42 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::f4) by DS7P220CA0041.outlook.office365.com
 (2603:10b6:8:223::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 08:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 08:45:41 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 51S8jRMG014423;
	Fri, 28 Feb 2025 16:45:40 +0800
Received: from APSISCSDT-2369 ([43.88.80.159])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 51S8jQax021802;
	Fri, 28 Feb 2025 16:45:26 +0800
Date: Fri, 28 Feb 2025 14:14:17 +0530
From: Krishanth Jagaduri <krishanth.jagaduri@sony.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Atsushi Ochiai <Atsushi.Ochiai@sony.com>,
        Daniel Palmer <Daniel.Palmer@sony.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] Documentation/no_hz: Remove description that
 states boot CPU cannot be nohz_full
Message-ID: <20250228-dugong-of-incredible-piety-5e4b88@krishanthj>
References: <20250227-send-oss-20250129-v2-1-eea4407300cf@sony.com>
 <Z8ArXtTa8zAZDCtK@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ArXtTa8zAZDCtK@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA1PR13MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 3384f06d-55f3-4ea0-2e00-08dd57d448d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PiTwBNJiO+pxVJEIgb6h2U3V2ttVB0FBRPKBW+5aJLC9YnUV2L+4Ffuu+wuq?=
 =?us-ascii?Q?0lv3La86T325g1esGizQ3DcqM5rNGLFTGGg3FAbIE29JZ1h1SYb1YMIoLUst?=
 =?us-ascii?Q?/rjILD6YVUwOHtCrZW8XdkvxAs5BLOthNWAxfcI5/Wa39FbdPHlldPNmSAh8?=
 =?us-ascii?Q?P3aGA4OuoirstOIQitijZcjUZXTIZzdTZEWgCbKgcMBKIKJx13EFLFii3SMW?=
 =?us-ascii?Q?h4dxhieQTfYqextN72jQB9iu9Mg/WiC7uLqHjM+J/jtoC7FBRQE05a46BZxi?=
 =?us-ascii?Q?EVKNx7PJCxnWSja35FB1nwB9LmtD9vrGfRhvvt2zutp3kazGTc0/WRhz3Xto?=
 =?us-ascii?Q?aRtOT3vS0iWzDJgMacI/gztvunqv3q2HG8hWOKKhdlWr7z0Ta3ptBrO3oJ28?=
 =?us-ascii?Q?bpgvqeDV6OEXVzCnv7lIYSD4muK//97IQtcCsdi9v30fAvhdlqw9a1/eU0aU?=
 =?us-ascii?Q?efVMoz+v2qVgtERCsq/V25u/JlCExOljXWPVHoM/aVzAtVGzAuIocrLF2Pet?=
 =?us-ascii?Q?G9c0laygjnAQQozmBo1GTB/9FIgJvRB2gO5Acbv15C2tQDaK+wpPRjt0Qhlk?=
 =?us-ascii?Q?PckAhhnpH2qU7oBkFx8Xt0HzRYcAacBYrsLYh7xmI+HCJ5+TkDr4t+fiXRs1?=
 =?us-ascii?Q?5K4NA1ojybDzqZ/HpIl2sDX9RvNEzB/ZpfmF5tRUslhFrCRc4lDqd1QQ+JFA?=
 =?us-ascii?Q?ATpizv9USYVHiS4eTwUsyT86qD01GIozKT+rJ2qhq5OoVmJBBvezsSsTJwqi?=
 =?us-ascii?Q?DsqszU2IadB3cUsOrfE/hATkOoSLb14TbHS/ggM4XmFyNUfMUwJd7bTuGKRH?=
 =?us-ascii?Q?dIIxj4GkM9Ne/FWbD4bbFfhBwkJnzIHfNeh2A0+U3ydnIvjQGgsO8i36uKzj?=
 =?us-ascii?Q?PUDYEh+oQJWBarB9+zZl0yFQOnGIdJX0AT3QImGJHWfUyBMLbxo5rg1bQgO+?=
 =?us-ascii?Q?KuLOj88Koiu1c/qxCEx2+R6UqXWflSBwKLltgZrZF+Cgf0Q129XensRj0gRf?=
 =?us-ascii?Q?zZalL2tjAmR1+5kCluBguvils2z9O/I9YeBKbOjwTCkd8p2Lc+8DhxG/FcEm?=
 =?us-ascii?Q?3bMBCjzyNvD3wiAQBY62AB29EbHwOfzh4Gu7RAlKLEnV7T2p0mVIlV5TI4d0?=
 =?us-ascii?Q?In4YDK8D3U6/ChlT2CStNbcBkxc+hak/fvmC7bHPGOsXbQJ+/fu5nl24g625?=
 =?us-ascii?Q?zd5BT0mJvUgFihnLsZf9k0ZC1NRumxnxAS7H1I8nYNqtzjxPAw6hejg/Bjy+?=
 =?us-ascii?Q?lYlt/8vml3QchbU0dP/ohlVG2TATuEvZtfyN0JLfym415X5jymDqOUDwj0Mf?=
 =?us-ascii?Q?zstH4yoG9V7K0oi1OPyQwe4UhENyxxunHP4hH+bV33TBn8qZRMycixAZbzoz?=
 =?us-ascii?Q?VCiO6bpe5US3PA2KrjRe2G6nYKFKFj2mbK8xD7GB4OKps/9Y+ATNUcfJh1Dj?=
 =?us-ascii?Q?PZ/m+hTJKxnBFmmI2dEcNcQtGtA9tgi+7U2Fs0T18PqnsVkwGz4LgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XezBUBZzLKQNqk7ckIdlB5Qu6I7cHqQ4RSeHQmfKRiNWLx6kA1eoAD5rSa2CxEgGQB0dHYqtIN9H3uhAET+9cCP/V7Vf44A+yjrnvGxEKYHHvQxOFy2dI0L1VvHEIT8fgDfRsdbL7Nb1ZHodwzB5fQ0IHC1PoIwLKznt6hyXScysLKdTxUR/UmCufSWT2rFOp0PMiGRr7SI7sB3bh1McbXhDV9Nneb3hBxNzA/kdxKbLiZSSkoMvGgrLGved/8ikgrJrAqmU3MvjRzPz1YG0BHk19j5qSDNyriGAbAN0boS42rC0t55usaYFCw+3LIE3SIeTSvwK0ZfSnzglOZ9hC2H+QHPyYdnJpvplQmV+V841tuwStmK2mIktd+4RSPpFStlR18qt3cdW8e2ptc5pGZ0UyEgzSrwrauuC8STieW4VK3jZ9CB00YpB4g+g5DflTWAbkZwjGKvFNLKVmSYgn3ju32BjzFB+oKFOSQVfMKiDWe2Bev+vx5eGOn5vKGgNLfGgPUomnfvyhK6xNvnRWNu84dLO84f+Ri7nD8cEzx68tSootdvO8YOiQ/ROyOdGFibxWuxgSpf/hkB9yPPzYdJErC3Os+aANqG245DIP8sPOAsK2d1tVVivQ3xWj6Ae
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:45:41.6660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3384f06d-55f3-4ea0-2e00-08dd57d448d7
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6799
X-Proofpoint-ORIG-GUID: 9W21XhqcShvEwdVNxrCUGIlResIfJfkI
X-Proofpoint-GUID: 9W21XhqcShvEwdVNxrCUGIlResIfJfkI
X-Sony-Outbound-GUID: 9W21XhqcShvEwdVNxrCUGIlResIfJfkI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01

On Thu, Feb 27, 2025 at 10:07:42AM +0100, Ingo Molnar wrote:
> 
> * Krishanth Jagaduri <Krishanth.Jagaduri@sony.com> wrote:
> 
> > 
> > Could we fix only the document portion in stable kernels 5.4+ that
> > mentions boot CPU cannot be nohz_full?
> 
> So you are requesting a partial backport to -stable of the 
> Documentation/timers/no_hz.rst chunk of 5097cbcb38e6?
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>
> 
> Thanks,
> 
> 	Ingo

Thank you for checking. Yes, you are right.
I feel it would be helpful to users of LTS trees if this misleading information
in the document can be fixed.

Best regards,
Krishanth

