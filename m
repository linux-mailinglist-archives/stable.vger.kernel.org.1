Return-Path: <stable+bounces-152714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13AADB2F3
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13800168787
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEA62BF01D;
	Mon, 16 Jun 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0Fs+YDa"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6B1C4A0A;
	Mon, 16 Jun 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082717; cv=fail; b=HOLt0OGuAFSQRWSEBJ+3BD+oFIayAB1j0HcliS65+Unl9rhpx5ZbAFGuZHS9O6TSPKho1ujusvahgbLjEdk0mFQliaKwJRwvOA6+LnNEg20kpKpdWpY34Do/WRB6PNu3eqOVcW05vBpKK38KECDwQaYyfG/ExFG0XdA6n3gibJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082717; c=relaxed/simple;
	bh=lAVTJi+wXMlfox2aVuavQwA8UTMx33ajFn0Bx9e/ol8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UIQMwurdogLb7qIkq07HNtAz0en/rFG9Di9lJR7xJYxN2gkJzEkh+WO0UaOK/BK34MLPEJzIpSgpinsR2jdbGehotYEpLTsXhHMOT9EU5sGSelS4OQ89XjbVDQmnGcpehjcPp6o6O+3nDLHx/ahhB7NItz+ovY7JzKihT1jb5M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0Fs+YDa; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1m/e5Od1XKMNgf/KOTePg+umm221xCb1v4cr5v3vepY4C+lBpGE0axsygDD8cYk2Q2Yn010KTe0ympEOvi+Qqek4jg5AyW8WbzMVdFTDmFJVf3hh9TjdZivjHt1QemTuk5iJDV9W5mnTmqVu7i6Y87dGoAHWb1AYqyPxmc4C+v5+OG67jSWg2/Gb6DbzSZ4G2h6wl7bwHbmuckcWaRZX6TftZBtLhSjHGqd8VLoTrFju+dASFoBlJQUT7OD4pJB+fz32vw4geCFzeGoSaLwOsW1atTncS0eykc7lEv7Ry8IDRyccCrJD6yRAAG5lMdD3xPLULq8+SQQD9R8LhX1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zv0y2lROi6qFbGebpltEch+ESDRhZib34r23HUsNmsA=;
 b=aNm7H4vtsdCU4BYbzOZX08lrGzlzfFbZh4aTct+LRdaBOpSGDCeXirujMLptypT3KJQzGkXar0MdTGUHu7IFGG6u2oyjdH/1ff3NsXRXpLDBNQPEvL26rWiOnzUiVM+Qprgm8N1boSCcgrjaChzRVqKK7BWG9qquRmfTgYTdNR54ziT7lvpvHlsY08/xoDHPojNeeqAI/Np2NI/8W526bi4BWlU2gGDc+IrWtnvoYubq+GvflnhdbsIWF7j9YsDkjCgSL2xWEY+054zuH04xT/aPtV3PPAt3yacXog1Y4yExeDI9J9j6G61FG84optAps6eBwRcQsbMTfMA1DjD0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv0y2lROi6qFbGebpltEch+ESDRhZib34r23HUsNmsA=;
 b=Z0Fs+YDah0mf5tVzkMLg0RVYv1VhLIyw+uZ/yEW2pvjl9yRhGkj4iyxdW/L0cKoduGWuxc2HGDCJl/d4ZbzvF4rhO6QdkQfqEauywRzX+mK9iI2OnKgYM0b6Dv5nyWOi+eiLP3b7Tk6ZeSPJQ92l5GQRP6uqQz3dsHvnaP4FSK4GlTYPSUZWoyGlZrzinMg8M5ZzqRqsjrhY9OMiJEJogDNobZWWbcheO1GRfVhQTZMJUVhdbBZ20a5vg2x3lVlmupDBAIUlQM9x0775C8d6tDt0AJCNYSj4zN/xayurMMzgQqFy/eegOZ4M0V60MLZpp/QUhmuQEtFLlqCs7T+G+g==
Received: from SJ0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:2c0::27)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 14:05:13 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::62) by SJ0PR13CA0022.outlook.office365.com
 (2603:10b6:a03:2c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 14:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:05:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 07:04:59 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 07:04:53 -0700
References: <20250615131317.1089541-1-sashal@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: <stable@vger.kernel.org>
CC: <stable-commits@vger.kernel.org>, <petrm@mellanox.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: Patch "net: sch_ets: Add a new Qdisc" has been added to the
 5.4-stable tree
Date: Mon, 16 Jun 2025 15:50:09 +0200
In-Reply-To: <20250615131317.1089541-1-sashal@kernel.org>
Message-ID: <871prjvl32.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1bd758-1000-404d-34a9-08ddacdecfc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grOrOJs/tsOfDYZUVnONXdh2m/pusnLeALIrbpdzgKI1L19gvqifndEXOQq8?=
 =?us-ascii?Q?Y2MCYp6W4uzyjtf133bFoFdQCALS7pFtKdFhCkN2xOlXzpjJzifp+lL86NHL?=
 =?us-ascii?Q?k7zpm9Lbc/uM1lr2E/in0eeLarNbNn1zK3ox6E4FO24lZzmld/NJAF/KM/F3?=
 =?us-ascii?Q?rWRoqWwvagLCvLvB0D2i5nTEGx5pJ5WSSTsdVUHwncc0SZQxmGz4LLBHfOG9?=
 =?us-ascii?Q?8oglfOpDJ81RROVj6vjWHXR/AblLvp302hhGp4x/ZqGh3jGjGUCIcqh6i5uQ?=
 =?us-ascii?Q?T5o5vV5zxWm2AFCClRNHOvz02ygTSL4fmV8BiXb6dVfAQwKIzNPfpObsFjgr?=
 =?us-ascii?Q?IlrI6/6rySQzGqQUiXDLQV9lhn1U7ynD+8mh8MICaCxyaToKRfLYS4IcAGF6?=
 =?us-ascii?Q?W8mLP8WfTFiXWVkvRtaSU9n3lDVCQFS3SKj5C7pBShBQAo2iEmbegtiUBkfl?=
 =?us-ascii?Q?1ZLR8XLJXjRM9rjvlDzRX8Qtqqa3Iab8EAApGM9edYtd9aeXcHqNnRvHvTEW?=
 =?us-ascii?Q?BTbM86hkEezLewcQiUCsJl3d8f82guYLgf4Log9K8GHF6id7qBrbbTAsHtwP?=
 =?us-ascii?Q?8BPDLt9ILfGUzc3ZOrpxn3BUVVtgza4o1+vB5FgQBuz/vCHTg7tnX+U3/6aN?=
 =?us-ascii?Q?EYr07m30mDAi0dhbrhvFkjDLggjNvvaII5aRo5ouvtHsdbRZWjQIUxvfWVNz?=
 =?us-ascii?Q?xY9p86WBdyydy/NF0DWmr6KfubD10XvBTBC15Ro7Fq6k2QYzPpeAwotJCuAe?=
 =?us-ascii?Q?x7QRfDnmSM0QQ6K3Pqz8ktmghdXQqFkbBDcwrBuCmG0Bsg/glDMZ5bEogLg5?=
 =?us-ascii?Q?h6c5tcDQX7XMi4xAob9ICG3ogO2Ag1AC6j4EHBwzYuH/s/21YttL1PXjd6xs?=
 =?us-ascii?Q?kalA213oIZRH0x88AJfXR0K+E2WcBZCavEPpJPBFiwsggqGUMPPlGR49B3jZ?=
 =?us-ascii?Q?Wg0O6aZhuObjD6VLf83TFJ5DhYBoNC5J/OWA/Z2bYTWDZCiqkrdPGVlFW29i?=
 =?us-ascii?Q?OpZGkk9Eef/JHg1/9kp3SuLbfg/lHPCd3dyL2erujIeEO5KEna8SttuJ+oVZ?=
 =?us-ascii?Q?XEGDwmXoVITrTS3XpZU1/IUJzOOOWa50eGb/N9EB7yH15GVU4qSnquH3lRQl?=
 =?us-ascii?Q?gR2jQPTKi5/fhnsxESzJvW3oW/YC5wME/RLeH7UvPC68mqZiWBwU8sAvID78?=
 =?us-ascii?Q?Pe4IlWDCiyWx7C8r9F7ewSAa+ccSj0xzcwgmpyz3dr9joMTcNADggCd+83dn?=
 =?us-ascii?Q?vjvFl/pPEivq6PLqcXCKfBDORzaRNRNRikpCElPNc+YTS/T0eHUOUUoZIj+d?=
 =?us-ascii?Q?jEQ1+2kHwaJeCE6zuSirfoNJhyemnf0ShxNoSiQiNwsFfvM8NZJpGtvoUvxH?=
 =?us-ascii?Q?f4m3irrQIUCulLOl6u2cTtja/gCkdywofya9zZFQPu5+878wAYRwaPAA+InU?=
 =?us-ascii?Q?z54Ji4rvA7kt8gpjAHE5UU3HGmu2yI3dMwzjZzyjf3trqcPaqOxdVXNcJHR+?=
 =?us-ascii?Q?318e1KUgWX4bhuGcpi3unFAKHWw0MPX8IOS16OHQRCvnv03Fr5lD65ZAJg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:05:12.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1bd758-1000-404d-34a9-08ddacdecfc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208


Sasha Levin <sashal@kernel.org> writes:

> This is a note to let you know that I've just added the patch titled
>
>     net: sch_ets: Add a new Qdisc
>
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      net-sch_ets-add-a-new-qdisc.patch
> and it can be found in the queue-5.4 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Not sure what the motivation is to include a pure added feature to a
stable tree. But if you truly want the patch, then there were a couple
follow up fixes over the years. At least the following look like patches
to code that would be problematic in 5.4.y as well:

cd9b50adc6bb ("net/sched: ets: fix crash when flipping from 'strict' to 'quantum'")
454d3e1ae057 ("net/sched: sch_ets: properly init all active DRR list handles")
de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond 'nbands'")
c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
d62b04fca434 ("net: sched: fix ets qdisc OOB Indexing")
1a6d0c00fa07 ("net_sched: ets: Fix double list add in class with netem as child qdisc")

