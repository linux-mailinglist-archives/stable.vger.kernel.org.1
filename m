Return-Path: <stable+bounces-183111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE30BB473F
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82CD3C1845
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450323C51D;
	Thu,  2 Oct 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mdwykPfQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xVVdiHSy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954922BD03;
	Thu,  2 Oct 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421484; cv=fail; b=gQIFAAfqpdAYu1yuU0dTuCyvkfD4jjJH2XKhw3xHFR2b7+ksdPe8Iyh6Z1hnUet0/lGeKUCf3kXR+PQGpSqNjIoVotwoPVaMXcEPxSP01SRIkOYvG6nle5OMf3VVfz/oOyrvZnrovjbEswjeP19+1AYO9hzF9K0oxIs6UK0iylY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421484; c=relaxed/simple;
	bh=GHSHVlflmwKbbOoqQtnqAdi+9AfpMp8Xl9e/VcTGUI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d3JN8RaVzhwKwUUZShelNCaWY4B41dgsdu4g+I+ej+Pi9PFiMCyx6BazvVcl62Nx/MXrVx5fnZPmV6XVoqZfp7WRRVPXgYIkMtznHzaFwv0nX6SfzIFN1hC1Tj8fusINBCo+iE4XwVltlrCV2e7j93rsRq93jZHynLyfDULdauE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mdwykPfQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xVVdiHSy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592DNE4V013769;
	Thu, 2 Oct 2025 16:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XdSUkQCrNHMkCxPcpk
	WJKl8mhOPpXIbVSlm8TNARHvw=; b=mdwykPfQu/fKL+VFe1TdJhkxXH/3MXdPWc
	pY5S+OmRVVS+Jq6ilXJ/ecj27ixZ+Ak7rGwgCBYB728eb76t800WajwG5AIELkYE
	7wA3vhZLdiTSQ5sqwqJfXBpRXnaEJtfxO/4ZzqYUTm4x5TNdv/tdOBXdvB8yLIsU
	HYqEhA4rfUr3B+e993ksScewAtrfRLsdRIGvDwUw/mP1Y+CMyf4LeAemI/A7HmZQ
	6X/qdKwIG6h4wAIy+jJwUIigoiMa8IgWTHxevI1Vxh+0zuSP2byf0Z3u3AlkCNjF
	Howpn4D6ienKbh/QhkiOEcMN2cYF5NSPLsHOOgf8u+i/gIpJtJ5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacunt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 16:10:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 592F6EUb000387;
	Thu, 2 Oct 2025 16:10:49 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ch47rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 16:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK5kR1QXZeSEA7SWnk//TkAM2OaXVdQ5U6kmAWnYkBrd0vH5i77aUz6ec3Si20VMZA/XQvrOy4SPNEiHQJ1avGV/KXgAnOm/MXFxv4ppDvUfrmz7+zImwrMtPE/3V0FPFbA0ELSY+6nHaLMl7SG7VGgcmXbkjQejPk1b0S9/8eFgY/UqQ8iWkA7/tE4WKCo4pBdWS/e6zp4zs8xkqH9eg9uq7Xe6OkUZhd7w3f+Y+vKZpy7Qq+ZbfmCzaWBPNgFOzWO9fa67Ej5pvfBWrcCgNXpwQAWjm+7N3V3+y96CDhR0HpMbaKnasSmC430ooI7EnBeb8qQ1JZKRCXjKiFpeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdSUkQCrNHMkCxPcpkWJKl8mhOPpXIbVSlm8TNARHvw=;
 b=avq1SvfZkFKRgWoAcoOM0HiNB/MCKxfAuVC6TCIZ3wskaoEmnMA6IUzYBZSX9f/lqW3w56ZI2Gky7+wb9Wex5gH14Kr5nWjz2yP1fcp70l3l/ACK3ncPNdwUt5+UO94qyWucW5j8QLdnuRKmUrV3aX8ddNIrx/5KaK+AGElO1j5FfvjGsyd4xOUGOSZx1AzKZro9SshhhVdThX2lClqZ2MduwFe7qFYoxzgztEEFamP5SD1yCcfSnrEQoWDIVifK048mjIQLgbWgSf9U/WjYaMinEOnZzUkmJSjqCbUyU+DUbg22jaL1n5hhD1/bMH4k6NY2eGRnx0eN20yMH7AdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdSUkQCrNHMkCxPcpkWJKl8mhOPpXIbVSlm8TNARHvw=;
 b=xVVdiHSymMkSDPQDlz1BBay1uT5u3+M7HgFxCvStW4q0iCAGn31D0F6pVkSKNJ2Bmmz/yYmwycUNvzSJHEsa55VQo0604hxSbU8LMi6gmjzR6AbXK5RZJj4pr9BiPydGQguBzeIFrfmiyUxdF1E0ak/R5C7O1HWTCWiiKh1626g=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA1PR10MB7635.namprd10.prod.outlook.com (2603:10b6:806:379::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 16:10:44 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 16:10:44 +0000
Date: Thu, 2 Oct 2025 12:10:40 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
        peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        baohua@kernel.org, ryan.roberts@arm.com, dev.jain@arm.com,
        npache@redhat.com, riel@surriel.com, vbabka@suse.cz,
        harry.yoo@oracle.com, jannh@google.com, matthew.brost@intel.com,
        joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
        gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
        usamaarif642@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, ioworker0@gmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5 1/1] mm/rmap: fix soft-dirty and uffd-wp bit loss when
 remapping zero-filled mTHP subpage to shared zeropage
Message-ID: <tappb77x3mkgtjrjnyl23xqydpqgqrqerx3rpnx5drwigfscba@dzbovn4xcsah>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, david@redhat.com, 
	lorenzo.stoakes@oracle.com, peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com, 
	riel@surriel.com, vbabka@suse.cz, harry.yoo@oracle.com, jannh@google.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	usamaarif642@gmail.com, yuzhao@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ioworker0@gmail.com, stable@vger.kernel.org
References: <20250930081040.80926-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930081040.80926-1-lance.yang@linux.dev>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cf1bcb-11c1-4557-60bb-08de01ce3ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZjhHpDqzLdQFN+CWp/pSVSmJ6/q+u21GxqgIesbdCLxZu/OpdUMY+IXVvx5?=
 =?us-ascii?Q?vKfuPcDLBT/CWuV6OvxpbHs6YBntNBuyDyIXg4FFDedDq/UCotdGEAxN2971?=
 =?us-ascii?Q?AYLKN0reqTNIvAs/RAMmLf0vilb+FfO4mijXzWGrTgisz5jczh6CoSbk1jse?=
 =?us-ascii?Q?KtcnyCBqP5oKK+yxAjD8hAEDkRkBsJYN+WQUyMQ6UmRpOqeWy+sOBgZNxhX4?=
 =?us-ascii?Q?5Sg3/U+YZRoWVObY3IqbRABYw83HlxLc5uhf0jRbdk++/n24pJkWlPILfZ13?=
 =?us-ascii?Q?XpQtg8+7fzAvlqusr2wGDIcnC5nUJHWRHkI7Fp2coPTOblMW5Fa/ONVWIY65?=
 =?us-ascii?Q?9lSELRlgOjiC2GFUYhPXeGaFLqCy/JQKR8r0FYljiUktPyuaddYtJloKYql4?=
 =?us-ascii?Q?sbHVbMt1XSoHtemhern8ku5Dxv7s+bixVufyi/Z9yuZj550/6LRQKUxhUg1R?=
 =?us-ascii?Q?+MpPS3iAOCf8zKauUjiOLiVv8GrT9i+qCkfe6KTm2BDRvwmllGqEHjAo+FvE?=
 =?us-ascii?Q?6YQnPs4QAAlpAhezA08jEn2cHsu8D6pBW5DSQBvU49iqrYCDMS2ND+mL1VoU?=
 =?us-ascii?Q?Jr8u2mgKH/1r4ullw0rW9Itw6nFiyS41J34gN9e62ZJ9aBZ7M3xdShsO+6c7?=
 =?us-ascii?Q?a4sPLfqwLPNih0nTr4mweThuSJT9isj49P/QTq/tfxi8RRdJUip6Ds/R4b2J?=
 =?us-ascii?Q?G4eWD8EskKfEA5eYhNyw7W8U3C2Ycgr3yyyBl5xQwVBUXCJzZvH3zCa3/zK2?=
 =?us-ascii?Q?0znyjTVOAIGSdZUaRqlsPW0P2Ybjog/hUG5DBKRmkPZnj2Q78IGwHpo+OzSk?=
 =?us-ascii?Q?AuAJgHHVu33hTpsbjZyIiK/69fdAAF+1UJ5Dd6RuCQzfFSOz37wLlLzTRzVt?=
 =?us-ascii?Q?KCmjaF5mq1QxoPhgYSquANnZfFz4nNHgVuj4RD7ZGIugbwRP6X+QO/HOczxQ?=
 =?us-ascii?Q?GgTKV5dhwWEdf36SOz2287mx9TQXAgO2TjKVemhrIF3O7ReMreeOWKmWx7ak?=
 =?us-ascii?Q?NuouoUUmoic/m/974Ev9Hnscgf6XdHY/v6Ny7QetC8r2Z5qrIoHDxuyJCTZp?=
 =?us-ascii?Q?mqbvZV/09KcbUuRvhiaSm800iREXmwg0xWf0kW8rQJmP9MkREetY3pZrMDaN?=
 =?us-ascii?Q?YBj1Q/J2S+0VdpQ59iqVF/AwndVN+2icNAGlX/7L7ri11AUkFnoJR9Bo91Me?=
 =?us-ascii?Q?PPye+uJjinYc8w4BwRkL2lJclEBHxEsUsLXNFj+U1UAS6AkQeBWVT1Cd4a0N?=
 =?us-ascii?Q?3dqM40qyAFuRxd54NXEjin8ormxo3CF5Yjv37/DrmFsynDKfzJjWboumD2KW?=
 =?us-ascii?Q?yg8OoXBrRMqRnhju+zo2UF19Y/lmf9zs8sZN7DR28I+rcQB9goRDfKoQotmg?=
 =?us-ascii?Q?4LJLnmGuQo9S3xbJS+pUF4mvab+TMrB/iZ77A033/3wm5R+xWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QAddrMc1xUvcN8pLzjynwqqizlnZ0rqISdobk8R2fhXRzyeOR7Evq1JxdtN/?=
 =?us-ascii?Q?MOpUgoe04Nuw5mUqMH1eNyqYpP+I8+hqRXc9tkzXE220CFjWLOQk3N/woetb?=
 =?us-ascii?Q?MQuhcB5VNx2I49fgIluUet/EN1ddpjnSsuauOqjHtKY74SDIAa+CNiAGG69q?=
 =?us-ascii?Q?+657u+TeS7P9vsWrRxYLncmHuPGPgytAo1O2xg9Yih2JOc6BSb3xOlFd7DdZ?=
 =?us-ascii?Q?RXo7sanWeFVvmoe/pFzxUsBkXp4O7xBoFJL7Mu53YbefJhGnB5G9H8iCRT+Y?=
 =?us-ascii?Q?KQ++zQntBt717XfLOByhu8Rn8X/Q4P7PGsjv1gG251qIQbHEqaGGbYfNvxo7?=
 =?us-ascii?Q?60q4sQuhyyapBuqir6kozzgzdR1XENJHJpSVUKwDaXT3cpkTrcYwjDd9SomS?=
 =?us-ascii?Q?6SKZU6bz+GnY9uI+VcdZ0TLmcz1jRZIkh0Uwgyg9cC0L2Vcsam0nyUbsrCYt?=
 =?us-ascii?Q?AnNqSAYPpqhZXMpi26ME9PHmgFkaTByONPIrdvEUAeaxT7Oyx+nd3iY3IbpT?=
 =?us-ascii?Q?DnioS7b3AZnw5mrm0SdveMDaTiT+m+8SLxp9JYSaxbOKXuUHuiqoYm54s6fV?=
 =?us-ascii?Q?L9VADOfwMMRjp+klur/NV0lWkkimaxnt3au14Poo+YklK4CZ05HmN5RYkfMS?=
 =?us-ascii?Q?Ey1/FebpNAb0gwGDWCXfRHtRZT93BGzWrk/W7/qO8Wq5sZsNSs3U5H03MJQa?=
 =?us-ascii?Q?kADfmueA3qwTDauk96RVTuMUuQ+DoKOVR8qHCk/rUrbzzCaqUmiR6spjJByj?=
 =?us-ascii?Q?7Lk+U7K3YNUBYgJKkJEmEQnDBfIVHl2AbZ8ChUpTyy5hPprct6t04bGM/QBW?=
 =?us-ascii?Q?4o5Z314dDbZsI8D+iy7w84rfipwRL/DtKqtPJypD7LABtiN7JOJSjjlpyILd?=
 =?us-ascii?Q?ufqWC4HfM20ptKBLwmMN3kvLA46aGWjQsX6ps69aKi2sD7WXETpVNyU89BHm?=
 =?us-ascii?Q?fYzzFof9CDlvbY7ULJHJyuCBIn/jwGl+s6X1iX1BVrfqCBMOXsrER9hUq/Hi?=
 =?us-ascii?Q?2XJEHUID0jwBV+mVxZkxI5PPrKWX1S/cEZ7VUB7kocyFewMq1lQMyOYbs9EG?=
 =?us-ascii?Q?GliWYPUkMBsfJElyGlJ8FN+PD5yrTSw78k5viUfUa4J97XIi5LfdvmAeKWjY?=
 =?us-ascii?Q?fEAqPx33hHbdbj79KerEwXMJvAZr2Q6FExHlu+NWPS1//8Z3qPgwxtc217CW?=
 =?us-ascii?Q?zYFBSeUns/EwYf2kcdLVnFPL6678fc2Cne7NHpkIys3+Jh2qL35n99IMnkZV?=
 =?us-ascii?Q?4107g5+A3lJ8WcFrFcI0kg0rLwm+IkHbxthZDEiFed33vdsBBWmj0TmCQYlN?=
 =?us-ascii?Q?AiFqJiTq7PDrrCBpZ1xEUd9rhiGtOveBME6YkZKQcq+SwRau2BjWIv3u4xsv?=
 =?us-ascii?Q?kb2UE4fH1UaZW72yNKsv6v+fuwU5i30Cu43Zf+M33FxxqsazXyPEBOd4iD4F?=
 =?us-ascii?Q?9SYnrRQ2AzpYhWCj6DdMlTEISiem2VyrXHRxdhh7228eYGUGOrBb5oItvMZs?=
 =?us-ascii?Q?8HL4R1aKpCWwL3KqZ9Ar/yw9lNGScAQugSrZa3aYOUd6ES1q27xi+in5oddM?=
 =?us-ascii?Q?nPPziVZ1rTHhtPbVQpGIL0HY2ypge96TCMAhVl80?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RZFS4dvAWM4lz9YNjox/8x41C/5X/VwrV9xfACmKtAr92pEYOJxMliVpP8j/i1UhDqW//P7i8JxkS6JLpb6mrmHjmimWE2G1RQHFgVgduEffSa84K5uUI9Wa38MarM1K7VGmBBhG73dj6c7tLST/wrMhOGzfP/r8zISSTefdA5sjjIQ/o8Eaz+wI1pbOItbehLXfhU8UdtgdSQ2g/zc5icuXjf18CZ9yC+04nqSqU4QMd5TEPjE7fnngQByEfxUKTHeUl5e+xYy36iGMEylOfSk+hTld8RoeUcn1aQksUds2AW1abF1VzdErfMxWU4WjH+vzpI3v6WpGOK5BDOX4RsnB2S2ZkfNAr2Jc4Htt9U1e5j3mgYTRgbFg7tcZ0DT6mLQWgpdEqxf++v9IxqM59+iURCU2I0QOaGNWaCHirqJD7c28BOoPSiP1ksMFyU6Lk3LtNGUj6KFfXi/Qo4WafSCARX0XlNNkcr2x4w2ySwxXkws/Y7Jj+2+VLLHoJ0K1WXWP7EesIuTAG75Th4jJoaZhlwQgQJdCi1pPo4sPgRTAUjLM5sHO5LNLAxDUxYWKKNVPijjhHu9fzllVTOmhGmN+pPFuZ5vyugVShUD7TLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf1bcb-11c1-4557-60bb-08de01ce3ddf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 16:10:44.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWkVyq5fClLO6A7c2+Gb35Qdm69N2uMo46Bhj4XK8A9v2O5DA6KVlDnkDv7ksw4PYo9+whZ8KDWM3RCEvoo3UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=996
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020137
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dea40a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=32i-lLLermmMPTXH56IA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12089
X-Proofpoint-ORIG-GUID: GU_FgiTpJr1mI3UannlYLWSbYX4kNY9e
X-Proofpoint-GUID: GU_FgiTpJr1mI3UannlYLWSbYX4kNY9e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfXxbUFVzCyxUF3
 28BmdK5ctmOy9pGANxsdP7Aa25pBBY/iInscKUF4T0jRcXh9K6qFJzujJYV8IJ5jDZGeTY5l7Ja
 3+0f+/W5ujpXtxhzi8fnEAroeaKjZhmnS0oR9jqxF2DZGSDHSOjrtYbJkMTvAznaQfGFjzxJP4Z
 Jlfp3T47/kTJEuc3FLBC1yYbMgMeNqDEsz3EBk0DYhwa3iEqOYTsGw6lr45mjwitD6cfKtl4qNA
 FmVeXy5Nc8ngFpggGrT/PiqHqew9nqegMtHJze4DRspANtI/TPHvuS+SIWzfmeTmMAi0Bq19JVr
 vlzc66Akjy2BjzH1ZZfKHyOJBAuNsQ6191dDi5mZ8sotXN39GNYWBhuS26LHK/vKqWaBNru+RrD
 vRAy8JA5Q1ZjPaW6cS1+OZZhpsIJdPAlj5SVoEeAbrLp4CnNa5Q=

* Lance Yang <lance.yang@linux.dev> [250930 04:13]:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When splitting an mTHP and replacing a zero-filled subpage with the shared
> zeropage, try_to_map_unused_to_zeropage() currently drops several important
> PTE bits.
> 
> For userspace tools like CRIU, which rely on the soft-dirty mechanism for
> incremental snapshots, losing the soft-dirty bit means modified pages are
> missed, leading to inconsistent memory state after restore.
> 
> As pointed out by David, the more critical uffd-wp bit is also dropped.
> This breaks the userfaultfd write-protection mechanism, causing writes
> to be silently missed by monitoring applications, which can lead to data
> corruption.
> 
> Preserve both the soft-dirty and uffd-wp bits from the old PTE when
> creating the new zeropage mapping to ensure they are correctly tracked.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> v4 -> v5:
>  - Move ptep_get() call after the !pvmw.pte check, which handles PMD-mapped
>    THP migration entries.
>  - https://lore.kernel.org/linux-mm/20250930071053.36158-1-lance.yang@linux.dev/
>  
> v3 -> v4:
>  - Minor formatting tweak in try_to_map_unused_to_zeropage() function
>    signature (per David and Dev)
>  - Collect Reviewed-by from Dev - thanks!
>  - https://lore.kernel.org/linux-mm/20250930060557.85133-1-lance.yang@linux.dev/
> 
> v2 -> v3:
>  - ptep_get() gets called only once per iteration (per Dev)
>  - https://lore.kernel.org/linux-mm/20250930043351.34927-1-lance.yang@linux.dev/
> 
> v1 -> v2:
>  - Avoid calling ptep_get() multiple times (per Dev)
>  - Double-check the uffd-wp bit (per David)
>  - Collect Acked-by from David - thanks!
>  - https://lore.kernel.org/linux-mm/20250928044855.76359-1-lance.yang@linux.dev/
> 
>  mm/migrate.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ce83c2c3c287..e3065c9edb55 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -296,8 +296,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>  }
>  
>  static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
> -					  struct folio *folio,
> -					  unsigned long idx)
> +		struct folio *folio, pte_t old_pte, unsigned long idx)
>  {
>  	struct page *page = folio_page(folio, idx);
>  	pte_t newpte;
> @@ -306,7 +305,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  		return false;
>  	VM_BUG_ON_PAGE(!PageAnon(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
> +	VM_BUG_ON_PAGE(pte_present(old_pte), page);
>  
>  	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
>  	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> @@ -322,6 +321,12 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>  
>  	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
>  					pvmw->vma->vm_page_prot));
> +
> +	if (pte_swp_soft_dirty(old_pte))
> +		newpte = pte_mksoft_dirty(newpte);
> +	if (pte_swp_uffd_wp(old_pte))
> +		newpte = pte_mkuffd_wp(newpte);
> +
>  	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>  
>  	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
> @@ -364,13 +369,13 @@ static bool remove_migration_pte(struct folio *folio,
>  			continue;
>  		}
>  #endif
> +		old_pte = ptep_get(pvmw.pte);
>  		if (rmap_walk_arg->map_unused_to_zeropage &&
> -		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
> +		    try_to_map_unused_to_zeropage(&pvmw, folio, old_pte, idx))
>  			continue;
>  
>  		folio_get(folio);
>  		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
> -		old_pte = ptep_get(pvmw.pte);
>  
>  		entry = pte_to_swp_entry(old_pte);
>  		if (!is_migration_entry_young(entry))
> -- 
> 2.49.0
> 
> 

