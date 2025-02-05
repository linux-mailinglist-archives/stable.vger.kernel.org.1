Return-Path: <stable+bounces-113975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E5A29BFC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1777A3A7928
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709C23CE;
	Wed,  5 Feb 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ls0bX+F/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gbC//Yvr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D6215061;
	Wed,  5 Feb 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791655; cv=fail; b=sYw8a9HDUOrIA8ucM9h0U6Jy/Wmif3E63c3XENQ+nAWOMt+6+0pgf73AyAnUZwFU26GD1sGuxI9atH633teSAGA+q6EkY8erx00UqDZzT13q5TmeqLkIUcuxgHF3qH63j9kAsxi8Q/Ypfv2B8J5pNFviKCDJuaDZIqE6em+2HV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791655; c=relaxed/simple;
	bh=ElLtUDJ05VdPB+NRSdcol/Hb8E2Hu6mZnRELDnDuDzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d15UuULa4iO+tfEJpuQ5HW2S8kCqDjjbuttxj4PVLBRgMRo90vnt2XW1vmh81FcRsd7O2GQBkzI39O1u2clsWqC+gWlu9v5JAANE3J8sjnAn5N2UtOSbk8CHM/6Xq6vcEH+1G1DP65nRvVZHymTJNZUiS8HAb6aifUWGwsgP/Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ls0bX+F/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gbC//Yvr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfpuM015241;
	Wed, 5 Feb 2025 21:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CID9FJPQFXo5Kbw4BM3DNHgaE9wkagmEyD2F+eXKT5M=; b=
	ls0bX+F/TS7ALI0xg8Ri/QhvH2CHepXsaLdDhsQWGIoM2Z6z8uEtP+Wh8EVriNtK
	LRuEoH6ckleVZJKdg5eyvyHrdyqai17yzwkzQOasALSBXBbg+7U9hPvco62pO82w
	WXtXQFgjFv2p690PWlOz5LBF2nsMFeXkgd8G7aR/+xooeMvt+eQsMarSGmc/aqPU
	Xnaac00E7+xPt9U288JAJ2cdKIbM1eHZuzxDljp/w988yq3HxeTbz55GrdikfXUk
	E8HIhl9LYdbjG1/YG1JoUoWgIBoxll0kFpo0bpxslrOgsmbIMAxWJTD1T7LYSS1W
	5x/nzo6GRZwrPJI8tML/BQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u9f02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515Ld9uo022532;
	Wed, 5 Feb 2025 21:40:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e9njbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=basILUcXMYMEbRAhzCpt+2VS2gDK4cAqq2Jqp7BducajHZ811l6e6RrzwTb+MaOFJI9++uOwfWUANollLEcQYbnuWFPMLagk1JAn64BJp7YhChQKrKDHuNiA9Mme1OclJFWY9kgAVPbWSL8tj560IaJoyzlDTdudaUp9lUnazCiFz22yXDqwDSgecLmjDR1SsHZSuHHE5PttDL8j/aGsLIbfcPkxMv7/5Gp1fPDfJTaIWJ+Gb6rf/+38svFfcTUJGbImy88Z3kPg9KRIMR1XqgBThakVmeFeyBuwdW4tFvyUHjZv9Co/ZiAaCFQNtPsiV7lIajjkPn51D0+yTzC0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CID9FJPQFXo5Kbw4BM3DNHgaE9wkagmEyD2F+eXKT5M=;
 b=UvKwnLDyBbxyLFqjw1QPffQb1eshFED/KPHzzvXo/l4NDzkQv3UmnIDe00oOtbQyasnq6yYlmzRxoKgHjeaFPl+dmRMtIp0XJX5tJLxBx5FDM5Sa1EeUqFC+qZ6cBWIJZVtj1/X6uWPjXohNZ8aGVYda/vYAw5wKEBGLtGXvPu49Harf6Tt2l++IsveYZaG8RPCZ+k1M/QxJpnfecLZBr7jWdIpxLleBLH0E+LpCTPqe/5RVOT61K0OslWU36rGItLRA9zWWTt9IgaTfaU9/zZXHnflD/IVYHoMmQUAIj54IOSFPVVsJ8ldqMuY/uPt7R5WXBe6CX3WKaRNMp3owrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CID9FJPQFXo5Kbw4BM3DNHgaE9wkagmEyD2F+eXKT5M=;
 b=gbC//YvrXu2CEMBX+nQC52xwRGJQVyyWQ11j6n6ef28eS9F3DeHm0DjDfJ2CL9jjI/TXtBEVXGlmLhMIt3GBFMaYQDNhJsH4WqFTzDnjuUU+XXSmHp8u8CBkR3L28e+hY2geDJGPTMcxL8pKMx9LZHe2BVHoqJHV99eVCsjpbB4=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 21:40:48 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:40:48 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev
Subject: [PATCH 6.6 09/24] xfs: distinguish extra split from real ENOSPC from xfs_attr3_leaf_split
Date: Wed,  5 Feb 2025 13:40:10 -0800
Message-Id: <20250205214025.72516-10-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250205214025.72516-1-catherine.hoang@oracle.com>
References: <20250205214025.72516-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0162.namprd05.prod.outlook.com
 (2603:10b6:a03:339::17) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: bfafd8e1-b0a4-4c16-d096-08dd462dc0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+B0K349Sfr1fGtpj400EcIyn3COFjnVQzBYHKhRxFlmD65mOWZq6I4cnzSB?=
 =?us-ascii?Q?Td0MjTrV8wwZ7BHMD/9QnUbFI3Drht5XSpxAEG8d8oH8alnmmzTJyHjX8BNv?=
 =?us-ascii?Q?uWUOTQyKqhOHvm3kvkcYL0t3IVSztpTDrMz8LB2WW+MA0kDPbWBM+6F6QN/o?=
 =?us-ascii?Q?3j/+iZ2bOtC0+7igM5VK9ERLMLejgTZbQJ/8mrAjJaUWvKrW2iYMRBTTMerR?=
 =?us-ascii?Q?+QpRhlf3en69b9KQi1fwIAGLdDK7m7a6zHHrJzLduKeNAaptH0xOgNsISpAM?=
 =?us-ascii?Q?dpHw5xDbGtYzZMcHFotF9fsTIe2sM3q0Cl4a12U+U33jqqCOvoc5YGS6yvYr?=
 =?us-ascii?Q?tqDQwsBZT5a4w8HIDcsLcx+P5IZwBN6Y42WGUploqXcyhu6EoA1VdTtqIjX2?=
 =?us-ascii?Q?j/QeaVMztznBDpwhKLFc3B3gXhiOaUkug/TN9oBYTQm7decTNsAUdTZk7u7O?=
 =?us-ascii?Q?RCO9h0DlKgUO6NaN7X6bdtkECC7GYD5AskcaLo6bpTiLNsGlb92dUzYjv7h8?=
 =?us-ascii?Q?4ydKx2RZzsiOs58t+7xCCzEHILuxF9IEciCrAocNqFXS0JCTyi9gRnJU09A4?=
 =?us-ascii?Q?35QdA+hVoXO77BgMZodzMKD2YJCmGUI1K+aFP4KBuPqEp1UmkODRbkgg12QF?=
 =?us-ascii?Q?pGcOeDu7sIUXq6bYaaY86hM2Sj62XsF1H/CVOg2u4MORh4riELPjBBRlnjFR?=
 =?us-ascii?Q?mVC1JFIHFmXsRqosTjF+OaPGnV1J0EhkhPEGvFQTdUV6vZF92QXOqWQ6JaM0?=
 =?us-ascii?Q?aC/yQ4Jfs083OgzTIBx9CTd2z4fp9KH+ivn3Fkq8Q3tjwNABJrMAKJC8AqBd?=
 =?us-ascii?Q?Lrjm7gpAfs/rdWiUn1f92aK0V+vZgKaLE4luGDpmfar1u0mQhFlND9OZG+ZX?=
 =?us-ascii?Q?EMGWa7jEj/Xa2xkrAgTSSCA8OaBVI7qiE4IXCwTQHwlnL1+7smJjUHGYb+M5?=
 =?us-ascii?Q?LbbRIAYe8HKRp2RsK7Y/Hq6/V/nsxm85HRfCMo8uqT+/GIVDs3g02HsTwO0f?=
 =?us-ascii?Q?IOPQtl93bY2ulBa6/lIPE8DwJM9YjA0zPzhaKtOwo2SnwUKjdE/FtBNiQ8x9?=
 =?us-ascii?Q?zzeq/u8omVvxZ8E0Q7I76XdWdAmthiwool2cui2swm8SfEFdKBzdg8T6uOpz?=
 =?us-ascii?Q?gRLptCBhYS1Z/VDkZMuAoLZ+mmDgioWDj2mGpqPCl67d8DeuKQ43jG3vUn9G?=
 =?us-ascii?Q?fJrF84Dp0ab5jQCwQyZzGFMNoFXIB3YO+03Qao/+YhQ+RWMly7U4tZGYey/8?=
 =?us-ascii?Q?sLo84m9mPl8ngQ0o4UxS+UAA9MJbfuDyxwLxDD+X1H69y7v8r0KoWM8E+ll8?=
 =?us-ascii?Q?2QAZowCPEBMC+cG0yYxCW4vnqXYHr2jGzk1z7Te6n0FWYvgSAkK+MOcWxUKE?=
 =?us-ascii?Q?al4dolLaULylMS50Ds7IJfEzuK+7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5RnE9ayfCesx0kOC/W/29H44griPrcxsBopN0EbgFWH+ZR6Ul2pzQT8uOKi?=
 =?us-ascii?Q?6LnzIqDT3h4PkcKq1eDFAMlxKVqtdmQWdXfZMdQ7GL9L5AlbxI6qluJyvU6t?=
 =?us-ascii?Q?PCnzk/XkdXC0V8xlpnVzcBcG64xBWTdnRsWbGwQBs965H901RmuR1PVFnPCx?=
 =?us-ascii?Q?Y3MbA0zF6Mg1+iz74QHYxokOzliriUvxtjJT0Op6XEuUmPIjHocVkdmqjSeU?=
 =?us-ascii?Q?t7LFTQb41MK4+N1LQ5/Nb6TLrC4z173j+MqcmRIwtV3rNj8rORktXx3ZHsAl?=
 =?us-ascii?Q?JdxWR6nCtI5DvLUdp0gMsS4fucfafwqm30s02DCv0+GoDuMFpCmMIBiw52Es?=
 =?us-ascii?Q?gtUwiyw+wsTb+Ow7QOLr7UBmN4RkQcQT6A+oDdS00+FeP8mnnNunkYMpzHsP?=
 =?us-ascii?Q?FDm61zELJg5NxmYvvfh4KzoHL30YPJuoswY5QXQwQ+OJKiH/PNGW0lC/onq2?=
 =?us-ascii?Q?ZNAZqdEDgURUS8OoDLclJJHrMYB7rcFOV0Ncgy19idE/s1PPOtzxdyhxqYQy?=
 =?us-ascii?Q?m4fvss7HrH3GCEEpHDsnXlup/g+yH+yNH/gPMLVPvpXNrH7u8NtS2qdHw98l?=
 =?us-ascii?Q?zLdkTRSDtZqNKXntxMFtiZcOjv7MgzOtqn6r6PU0ENBb+oZcKfsVvbSPzSOK?=
 =?us-ascii?Q?a8zyiBUbp+Pf+n6wwWwSSlt6YdA08U9IEpIXNgnvAki5mc1TwFSOhPHDJpjD?=
 =?us-ascii?Q?PzSYNkBD4Fsm0IcjXDrItPE+fs9by45g6hzIicoqM0pxYjVwP9VprzBcU6el?=
 =?us-ascii?Q?YutL13GEtKFJkVNxBBAOhzzqK6KmRijQMfnY7mhvCiNJlXUrBxaikjQHd9xt?=
 =?us-ascii?Q?AVGtJgHugtSO3Uq5diOZYP+OGjIxd1kOpjJ4A+6zZfH9F98OFiZ06SvQtuC9?=
 =?us-ascii?Q?PQrpx/+vYJQqrUIZ5HxQ6D9bDzTFTHvxijy9Rs6wcRJlm37ixAoZvX25vhik?=
 =?us-ascii?Q?M0sUN17YW1rm82XYwQjyIIEpU6ztAAn/Luvt6lguSSNyFuaoRSswVG0a2K5o?=
 =?us-ascii?Q?R+ksnAUwa9mD9E+3W31rXLjAALaCumcQY/NcyNsN4AQrVmF8DyEZcqILnryb?=
 =?us-ascii?Q?du5uGhqBFV8V32ymo0WqAG8XFxtvJJuESkPMR9guAG3muSqfaqBhR+LCG3U/?=
 =?us-ascii?Q?L0bGSaYEy2E0h7e+2ly5lnbwnBylTS0zu3sV4H7vnNIVdYNzHxnD1c79DEyW?=
 =?us-ascii?Q?BEqNmg1iPoYpERqi0NhEdQsZEmO+NwWv13wXxpgZirQki9ncgSaGGe3AQbl3?=
 =?us-ascii?Q?WOcG7bSnO7K3GPPEqDNGe3vYwBtfjib+tJGL1qmvJV32+91UYVr5psfVFIQM?=
 =?us-ascii?Q?lmzTykLSgrUatgPwcaZ1WuGJVN0D1doiblYrPqHjFBjPMHlzJ9CoGy6C0Zto?=
 =?us-ascii?Q?2uzp2NZrwFLL7n2rVZadXtKH4Rw8EVpqKlzzw9zJ0L4Am6HLxqL7tVcUdL6Q?=
 =?us-ascii?Q?43dTftoIsyjRE2GcbBxwvb0OOjvL710kscMnNw5uw6MXA/OyZMxqMr2HepYx?=
 =?us-ascii?Q?S+RIzEjtwabgWkLMB+tmlOXq/6/17nb2VmaRxPNuj8kNRBeO59JL1DLEpsTw?=
 =?us-ascii?Q?3WEyTuaWM1eer+lvFtaxbPw8S2FuBmdzu9gYotGOQCg/EMJlO2iQgC+tR2iC?=
 =?us-ascii?Q?0yhMFlOgZiI+294/nWZ84njVSsnhL2HPHUIye2ErvB2mDjY9TTOQ9AzCEZc3?=
 =?us-ascii?Q?QzORCA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pApBQrsctfLilp9vn+YptBQVxzGFfOTnCcu1BA8/vNZS2yKJutUfpYo2nKXPHMUctx1gdaqdtRG5nRNqOOb2v6TN8mqRaMzgChyw4s4io7gFo/3pV8fhqK4KWlHu2UHI7wxTA5MeKGTfTKqx0kWi/CSgP8aMO431RiOYmHZkUBUrb7X+w1MUBALs1pd41SWb5xescfuQqvflrEtX6GEbQ6+lkLYH8UifMnEOi8ufQw2Q0zqg35q7dKTsCUUnTsM+1iJYmMie1u64fs4k2EJ1CrT5189FzxnLJXIUtQC3y+HP/b3ZEv6Osk9bKkWBzxd/Jt4//rlByWgSGOtIIxPrJ6STqcjcpz59oXvuJ5gx8L5KKHfPT+RTb/sbscvwpGwXxUhoE7CzkBO+dGFJl/f6XAsItM7eBwqQKtQUFPs7ZfVyp5YUWLIURxQvY34KzhMi/kJBznjX80Kn+ndvtCLo0ckgtmirw9i6FouiAQaQpx3Zd6suVZP45bWIeA/9WH24bF51A/9QhnYMWXwkToRGcep83q0fYaULxrpaeA7W3Dla8xCXKGYDc9fM84H2hR8qVul7m0lmzIkXzaHlRKzgpVps9x9J5TjOwclp5AFFF6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfafd8e1-b0a4-4c16-d096-08dd462dc0c4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 21:40:48.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 254hfISzRfqpJbs7h3OR3/ZemticGdcSQCBc0/nXRTD0UkCazWn1r40kYfvy5mHcFQN7Ej+nw1I9n11Z/7EXqnXt5Kn672o4DueSWaulEog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502050165
X-Proofpoint-GUID: iAbjqYByN2L3IlhWxXTTfuIt1euA8EMr
X-Proofpoint-ORIG-GUID: iAbjqYByN2L3IlhWxXTTfuIt1euA8EMr

From: Christoph Hellwig <hch@lst.de>

commit a5f73342abe1f796140f6585e43e2aa7bc1b7975 upstream.

xfs_attr3_leaf_split propagates the need for an extra btree split as
-ENOSPC to it's only caller, but the same return value can also be
returned from xfs_da_grow_inode when it fails to find free space.

Distinguish the two cases by returning 1 for the extra split case instead
of overloading -ENOSPC.

This can be triggered relatively easily with the pending realtime group
support and a file system with a lot of small zones that use metadata
space on the main device.  In this case every about 5-10th run of
xfs/538 runs into the following assert:

	ASSERT(oldblk->magic == XFS_ATTR_LEAF_MAGIC);

in xfs_attr3_leaf_split caused by an allocation failure.  Note that
the allocation failure is caused by another bug that will be fixed
subsequently, but this commit at least sorts out the error handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 5 ++++-
 fs/xfs/libxfs/xfs_da_btree.c  | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 539fa31877e7..4e5ede2a296a 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1340,6 +1340,9 @@ xfs_attr3_leaf_create(
 
 /*
  * Split the leaf node, rebalance, then add the new entry.
+ *
+ * Returns 0 if the entry was added, 1 if a further split is needed or a
+ * negative error number otherwise.
  */
 int
 xfs_attr3_leaf_split(
@@ -1396,7 +1399,7 @@ xfs_attr3_leaf_split(
 	oldblk->hashval = xfs_attr_leaf_lasthash(oldblk->bp, NULL);
 	newblk->hashval = xfs_attr_leaf_lasthash(newblk->bp, NULL);
 	if (!added)
-		return -ENOSPC;
+		return 1;
 	return 0;
 }
 
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 12e3cca804b7..28bbfc31039c 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -522,9 +522,8 @@ xfs_da3_split(
 		switch (oldblk->magic) {
 		case XFS_ATTR_LEAF_MAGIC:
 			error = xfs_attr3_leaf_split(state, oldblk, newblk);
-			if ((error != 0) && (error != -ENOSPC)) {
+			if (error < 0)
 				return error;	/* GROT: attr is inconsistent */
-			}
 			if (!error) {
 				addblk = newblk;
 				break;
@@ -546,6 +545,8 @@ xfs_da3_split(
 				error = xfs_attr3_leaf_split(state, newblk,
 							    &state->extrablk);
 			}
+			if (error == 1)
+				return -ENOSPC;
 			if (error)
 				return error;	/* GROT: attr inconsistent */
 			addblk = newblk;
-- 
2.39.3


