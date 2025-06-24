Return-Path: <stable+bounces-158329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FCAE5D98
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 09:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97C54A2F84
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7C253355;
	Tue, 24 Jun 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdMPIbKH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CjOqa/DB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB36248880
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750749951; cv=fail; b=ixrihFFtujaceybaR/qN7/JgCXu9WhER+tLhYgObOH1s2vbTc7SYl3B86Vh9ibFtDglboQkBUTkV5WunT7GEBktCt3zUFQa8xJssmh1U8oFPxQpGMES7rkXFvD2jc/p2MNPcb8eRkZjdCtoY/bHgmJ2Azyzv3NwdLPnEugyv/7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750749951; c=relaxed/simple;
	bh=CKSCof5QfXtsQR1Ho08JyJ6YmGcfgcaPNcq2k7eQk0M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mvd60bqJCG4KmsBoCGIzm+G8gLKiQ/b/2X2AguO+F6EoQT3WyJYi40W4s7XkIbJxjJTLKqhvxvZTxc9jitN43V1wl4zCqWgWaOFQ7xS5d634z3n/hT0Q5ODMDumU195Q8gy2trV2OqH7O8qI0KNyIm1OXYB3gSoVNQsUDCZg+bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WdMPIbKH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CjOqa/DB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7MZDi015112;
	Tue, 24 Jun 2025 07:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=carNHtait0puGFTE
	SoMkaI4FkOmEzUA8f30qILy/tgc=; b=WdMPIbKHncRDFB6OIXUaMI3uBz116xKy
	sGH/P/su/C4Mlmrn5g/93m7p5LCPn3wkJ8cNabBUTHijH1sObUPCCzF1ohbiH+gg
	OIEk5bR+zX1wuRS7UniGi7tvyOqWxE4ZqjIZLLOz9soE3YAxN+n/ztg05WmViMRA
	078GeXZTOnrVOHS1dcd/Q/dCx8EOowTp6UCvN0k2mmpB8EPkPgTVyyHogs5Y+giN
	DkP5/62jW2XkPjzAcDDvns0Ln+GT2ZGtXDQnapUdlHDLaSPnNsvhpkqzaYGdiPQT
	J+HAhaF57gQl1m/5U7EjyEvTnFDIHh9RgxtTlspaVLwJfvJbefnLcA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1bb37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 07:25:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5vWGv024347;
	Tue, 24 Jun 2025 07:25:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkqa2ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 07:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3tjpO2CRP69xjJc7XcfK/NRF1hcnkWmk7bfSl9zzAWUptLlngn8NL8zEd60Ey1D8/K6kF1dMAEAXlJriX4Gn958WQC2nrtItR+ZDtDX+aEgOWn6ej1NcfexeGP74WcjpCS0aVaOUoV0Pi1Rwbhmk7Hq/kxzEIcXPjt0VLlRIqGuezKjZZ8wOHDHrGjna0ZRI8uku1q5Ex0IJ0JmG50kG1LCYS1gGBWDXf0DfRYPhbtiJIXbg0TS3TVyg3V2mbGuXIKvBKRH1yTb5F9kqyLvzbWY19U3equzXPsXs2xP12e07flYLkd2KLwc+11lxHm+65HmGEdRmSm66nchevu+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=carNHtait0puGFTESoMkaI4FkOmEzUA8f30qILy/tgc=;
 b=lRH6QEcOPrD8lMu7P1FbVn2IBeD++PoxhVRN4hDDc8gO/n32bXDaMUcSlnW/CAVmERmE+/GPVkST+YPvs4dLRVM47HdJ6cP3D5McTvm/nEANwUwAx/FueZNKmSxCePf41pmbFM7rvlVAyHdf6j9upQpLWkt7jtzgBEJ0Pdp8UWp6XyQQJUBE1sJxOzHupSnNpJEwD/HCUHQFiV7nvxXxzG0wTmmEcoWAnUeSQDHnHDRt6A3+7a8QVKk+UfB0O06oF1b6c3zjIMfrEyUg1PFBShmvheod0Y0wncdoAKxkdYTgoRmTb8MVF788XTuwBWuqKuwdJbKlOHC+vjFaWFx1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=carNHtait0puGFTESoMkaI4FkOmEzUA8f30qILy/tgc=;
 b=CjOqa/DBHV58WdSbferMj4grrNL1qcjI60KHhePkxut+0SNMcvi/xX+F6uCtf4Vs3BKPdDMDlix6kW0XRjbfY6L2Cb0dTz1+/nhRfGi3n0+ReIi7zMU2LI9MhNMU6mXUUAnj55sBcKKI9Y03MkatxULDbYNdAdELDiC6LW2zufw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB7452.namprd10.prod.outlook.com (2603:10b6:8:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 07:25:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 07:25:19 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, surenb@google.com, kent.overstreet@linux.dev
Cc: oliver.sang@intel.com, 00107082@163.com, cachen@purestorage.com,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev,
        Harry Yoo <harry.yoo@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
Date: Tue, 24 Jun 2025 16:25:13 +0900
Message-ID: <20250624072513.84219-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0116.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 020352b1-ab23-46ab-6aa3-08ddb2f045c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KQyBJH4Kc8yTQrmU39oK3rNmXhTOiCiG9xA6jSk8xSSIWhj30TgT524cYEan?=
 =?us-ascii?Q?7znsZtjzEQvnCitDNS3N/B9t9hxBKIn5ncoqMMomByxY9i29DVIMYFs9AvUn?=
 =?us-ascii?Q?1oG261atoRZxeBA+TX/fErXyzb7j2kDOlu40cWBtkuqL+PIiowzOgX/w9Tpo?=
 =?us-ascii?Q?udgUp+qoocyJr72SfoAI3EfwaltUfTww618ydoLiumsCibdSNrNjJL+tEba/?=
 =?us-ascii?Q?aVwtMTIN1xwFDP01URtgab/8x2TdMyomKc2WCLMsFz6KzpFY57VcBGcpuFLY?=
 =?us-ascii?Q?OzNMsEX5WdmI6zAXqrYvZJYnVP1xgCiOQRtB2rxWdqFYTvprm4zRswOFpniK?=
 =?us-ascii?Q?McLsf6hrEyo7RT8DsZa4ZYgcDL5wghj2Hp1erxsEiqycr0+b1woi/SiTD880?=
 =?us-ascii?Q?tBzne9PHCZurKXKvkNfX0Uennz8nvyoZqZThOB/Gc4ToNEvlrDEeIaoHKEZ3?=
 =?us-ascii?Q?TTnEcDybljUNOVf/cGGoGu6W3otn+7YZSZw7pSelsyy0Jv9iD/QPMfw6lvFE?=
 =?us-ascii?Q?8QnXN5JU7h6v2/kK/mkZ0ml+1ANeTHnWrISU3/Fg+oDUNSOefEjDb3wrNOa/?=
 =?us-ascii?Q?agiJObPJyXus1yKV0bvRTHNcSvO7nhpKa5Yd8FYkiRXLayeZjydSREo7xIPG?=
 =?us-ascii?Q?gRvSGYLg+qT9bdgNSdHJf2HoJBWtvO1uroVA2JBkbPRjIyed9fjYXO8bUkWF?=
 =?us-ascii?Q?Hegcp/SgrvXMyA5fSksMxYCzEvv6h7Ba4H7E0sdKd/Fnbpx3hUFsUNMOmgTI?=
 =?us-ascii?Q?oWP/16I7Jxcyr6tM/0bqrxXfndNnOYo4Go7EDWa1bE0+AAozxR67tG03VsZR?=
 =?us-ascii?Q?YJlAQQWw0sDgpVGZI2LC0Cm9ezj/+E91LtS8X1TN7NkRl3vB1P+yHkZighC7?=
 =?us-ascii?Q?LNk8RJhFppCuY7ZjAzAWbCDlHgjnxXMzSKrowg/amf9aZoTaH3p2UXvbIDdo?=
 =?us-ascii?Q?Gceu+U0hUlC5B7tMsxhxx/fLT44mWB8gK44uCZx1nTSv1GeKO8InbDLllaE6?=
 =?us-ascii?Q?F4uK4n2+ZW+UVIX64O1IVUtZMUVOtW9ym0AgXCyyHjinkrlBrdAnvGZmuuHm?=
 =?us-ascii?Q?wcJ7VL7a0GHtfO0DXh+/Jukqc4RHb1EUmxa7fZdK/dnFOyp2qpDLihEUTorZ?=
 =?us-ascii?Q?t+9nAv7+45tOhZpdnFzll7ak/FZHG2Q2C1T54Nu7DNZnDzyvHc4LnX2+YBtt?=
 =?us-ascii?Q?+yPhNobBXwGKZ2vVxVgr62Bf9iFbhrNX8oB+KuJfKGmwlxWbgyrjWT6tp09H?=
 =?us-ascii?Q?FVq45fRBPKAx8vu6zZDo0YJHZ5BprDOLAJqRocqw/esAi91nAFdH9QsBV5C0?=
 =?us-ascii?Q?M8Z4R4gCKV4Apcm8uI+ZmaIR8gODAWguBklq/TyWeJA9RPevZcGeVZzw7y1R?=
 =?us-ascii?Q?AA6GPptOusoJPZb7U5Giw9UCXqDbM3btF+vkqgLflLhcv17XrrBWh1HQTjOj?=
 =?us-ascii?Q?An76n99oRJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61dZVmRw73Iba403eJjDqJgvqvEIvmZH9d49rwZLmjYaokuu1fdcxSuJp4rS?=
 =?us-ascii?Q?0EykgxcMdkr0QZVakks2Q2xpnrnJbtWPSQSSt0YjctfWYEXzTCmQyIro+2Ad?=
 =?us-ascii?Q?yUWJBQaLxbVM6UJwuRKDZtTuZBtEdR33apx6yYJLLLhZqT+P9rQmfPML6/xb?=
 =?us-ascii?Q?8PPQCMP8ZG6tTDdh4il7gjCDWSyz51ufxU8Y5JxfqHMVCPP2GRaMDOCbMFWk?=
 =?us-ascii?Q?ciGPBBrlmlLa7c46UnLwxFguG4k51QZHwitxbthtHbgBgqds8tGZJcwfI1Vw?=
 =?us-ascii?Q?R+ZoURfkBp5yIjBPV+JLORmMIuchifnpX/78x2l1MZrSH91j9FzAy8X06/Fs?=
 =?us-ascii?Q?T2rnQfcCNqiUOOhTW10mCcTMf3QkrioVtuI9Ss5G6TE/j+1tcUyoE1k/egHJ?=
 =?us-ascii?Q?MBdhuLAuvoBIK4AQwuyoiYjbXdKn1hlBu1f67pJ053koZbXQRXOh5hBXn9Ao?=
 =?us-ascii?Q?k7mY/yw/EzU+O0dNusHRFk1McyQWDqIRUF+jV7QixR/lM96dsiwoez8M/8eX?=
 =?us-ascii?Q?Pf9qxfkVt3GeS3s1Nt16PELwpwNkd9CAlKv8aPrZKbuSg3uk1l+94x2PzMk4?=
 =?us-ascii?Q?/si4K9djcJ/y1sNDz+fwPVd8O/rx2ON281UNI++ov4iSk8zZOyWPX5XNadcI?=
 =?us-ascii?Q?Ch7mUjYHuttU5vKCAxSTDXewCdwR7bCr7RCFJZIHZn/n5yqbFZMJXpcaZjTj?=
 =?us-ascii?Q?Ph6E0WydjtrJ94BG5lCpFFO7Oedb1t/q/F+p/icFV9Id/YuqiM3hrE6YzWyE?=
 =?us-ascii?Q?Y7WDHtqvItdO7XGGJz53pEmysMp70O/V/sa8tKkZVw7UJaaFhLl7/i7DIfN4?=
 =?us-ascii?Q?UY6YVCwRplR+8ZzX8Qs2ZmnlyFC0D96cQyf+2r3FeZAgpfy+9rYfft6VlbUx?=
 =?us-ascii?Q?Y0i1aicO1dy4r7XQPgMdAdq4BNkbCAjDqJlxQcf99u4q8QID7Nfw5MP8NVGG?=
 =?us-ascii?Q?K/b3U5tKpSMPRpPTC7155nN8N2E/7td8lMw33jTyDW5ImyazZ3Xm6U+QWymX?=
 =?us-ascii?Q?JFaB23SQeQk7GGDMC5RGeHwcVfy91yvMrzQXq7k0AHKvWMu34+AQHDZRt9hr?=
 =?us-ascii?Q?VsEwqdH8A2zNB+l6m6HUiY2vXQMHv/PBc7WmAyh/W5z8D9ecwk8Clm6oBcbH?=
 =?us-ascii?Q?DRge0n9QakoswqqXcZ9ksO/d2DUSCRqYrIe5Vi91PO34yTObmV0lRA6XmB9T?=
 =?us-ascii?Q?9HFiGTJn3UQkyxlQtyyExnVbL5ZThDD5u3gmxsYM4+9QHY8fQxG2FRsE7t1w?=
 =?us-ascii?Q?aLQ+PGR3PKs3IoyF6Vyc1Gh6r397JA7AjW52oUr1fGWGT34J28c3CDJCWhUO?=
 =?us-ascii?Q?JgmVO1tJ6igdEwvMk54RVnIrlYq5c547F+W/Ns1/ymINbjv+ik7Dj5vA0FM1?=
 =?us-ascii?Q?0J0A1PKeyg1iEmgHvevxFpzODVnnVqwpgTAWWTiLPMuMDRLwBFOd0oVeYKx9?=
 =?us-ascii?Q?dqSGplfX2v+R+PS35xKzgsHpcHfnKxAter3/h+yd9YjSfm1wJcslw4v3dudU?=
 =?us-ascii?Q?zrRqJ1odyItWJzC/XDbofVHtGxiEpMe1FrTPrBcmc17XvabbNSyGUgJzxmF8?=
 =?us-ascii?Q?6KYYDvWb34pXVUror9wK1Skhp6wEFug0PX9lOnEC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7VjmzWHiFs9Ok0ufrC1sELKnbYuY5iD6897ALoqCPSSXXG8ekyreaFxZS7k/jZ8y1Z6WDdzkWI/weVGqFggqBiFKxUS55E6U4ggoMmDQYfWvYLG+u8bp2D0VfZ1N1qdcw1gHENnr0wOzJRJcenveHypHj+ik9A2PVQSe7ZpM9ACYGbJIagF9373Z4UzbCpnCN8Iuq6SPiZbwimjmlm1RG1u6Sn21dIe4XtdkTJyd+NNWijDhN9pDv9P3NP/bhMHyJdMYhcDyKGp32pPo1+GOW5ZXsuA8cdsVai8HURIPVkxGDCCTX7XPwg55YG53Lo64J6G2x93UAWTuiRibiOtqBmxp05y+6CbCLfpiVM374BJWpLzT47GFV+v0jww6qqQSStkPo0gRiqRywAbekTaMPj8bEteozJqyLENrH85FugGGufaWExD6NSahwlKNOib5ZoT2HhNGYxM5/8bAnQpzPH8hOm992XX1LT7IwDK9pntMuxELidcO2JXzIl6fxTsafrMgd3bsFQ1hcmiwgO3ZZ1bhjUKnavJaJJoHXcp8CzY+B11OD4fcpuAtgGdiqs2IaaA9MyCvsPbdt0tOf6u9encilnZnwbUYqjmjTXA0grw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020352b1-ab23-46ab-6aa3-08ddb2f045c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 07:25:19.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KBsA1FMSemEf/osGd9Jt7wLLOoaQlM04CBdjUP++BxZBJYykzTOojhyuAGpcH1aWtRflDi1gNOz3Zv7JLWELw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240062
X-Proofpoint-GUID: 8hPvzUetnVU_5-fDq3abuKJcnVG5Iy2Y
X-Proofpoint-ORIG-GUID: 8hPvzUetnVU_5-fDq3abuKJcnVG5Iy2Y
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685a52e3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=jVbCQwm9tnh1vyDj87wA:9 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA2MiBTYWx0ZWRfX92pp7/BcLEx8 vm8tNdleXMZsFhb6+MqRDz4igToPmQQV1LpPRVKEAh2doOiPWAdrnssBK/vjp0LlBZE0OJBHjUt deoHq7mjXVG4P+QlngFzg1ANMruI2JL9/wNW7LZjWA3hxwvtirC5I+AqEyb87w6EGiZFBme2Bsa
 t1gfMIlWit43jnIyQjKCDKiD/wrVNiMU8Y4vibDqwU7QBpVy2PknlYCeQ4ysKmvTM+2gvyikC3b 8xZzE7ajPbDyhZMu/dagP9juOlpsZxPM7Edz1PXGnfRRktg1ova9Ae6iR8VUp09zKdvzmKADzS8 kVJrI1ja8drEYVtCRE03Y1CaDqoSjhE1c7auSosClWTUjuAh8er3hhFd7hQBVul6CNtout4NgZY
 OjKtZTIDbOW5fmwogZJ5Byz1Jhh8EAztdf9hdHWzN1ENQ6LxixFP+XwaDPNHKT/fnebBrPc5

alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
even when the alloc_tag_cttype is not allocated because:

  1) alloc tagging is disabled because mem profiling is disabled
     (!alloc_tag_cttype)
  2) alloc tagging is enabled, but not yet initialized (!alloc_tag_cttype)
  3) alloc tagging is enabled, but failed initialization
     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))

In all cases, alloc_tag_cttype is not allocated, and therefore
alloc_tag_top_users() should not attempt to acquire the semaphore.

This leads to a crash on memory allocation failure by attempting to
acquire a non-existent semaphore:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D             6.16.0-rc2 #1 VOLUNTARY
  Tainted: [D]=DIE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  RIP: 0010:down_read_trylock+0xaa/0x3b0
  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 0000000000000000
  RDX: 000000000000001b RSI: 000000000000000a RDI: 0000000000000070
  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d1
  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d37
  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc0000000000
  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   codetag_trylock_module_list+0xd/0x20
   alloc_tag_top_users+0x369/0x4b0
   __show_mem+0x1cd/0x6e0
   warn_alloc+0x2b1/0x390
   __alloc_frozen_pages_noprof+0x12b9/0x21a0
   alloc_pages_mpol+0x135/0x3e0
   alloc_slab_page+0x82/0xe0
   new_slab+0x212/0x240
   ___slab_alloc+0x82a/0xe00
   </TASK>

As David Wang points out, this issue became easier to trigger after commit
780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init").

Before the commit, the issue occurred only when it failed to allocate
and initialize alloc_tag_cttype or if a memory allocation fails before
alloc_tag_init() is called. After the commit, it can be easily triggered
when memory profiling is compiled but disabled at boot.

To properly determine whether alloc_tag_init() has been called and
its data structures initialized, verify that alloc_tag_cttype is a valid
pointer before acquiring the semaphore. If the variable is NULL or an error
value, it has not been properly initialized. In such a case, just skip
and do not attempt to acquire the semaphore.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202506181351.bba867dd-lkp@intel.com
Closes: https://lore.kernel.org/oe-lkp/202506131711.5b41931c-lkp@intel.com
Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag_init")
Fixes: 1438d349d16b ("lib: add memory allocations report in show_mem()")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

@Suren: I did not add another pr_warn() because every error path in
alloc_tag_init() already has pr_err().

v2 -> v3:
- Added another Closes: tag (David)
- Moved the condition into a standalone if block for better readability
  (Suren)
- Typo fix (Suren)

 lib/alloc_tag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 41ccfb035b7b..e9b33848700a 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 	struct codetag_bytes n;
 	unsigned int i, nr = 0;
 
+	if (IS_ERR_OR_NULL(alloc_tag_cttype))
+		return 0;
+
 	if (can_sleep)
 		codetag_lock_module_list(alloc_tag_cttype, true);
 	else if (!codetag_trylock_module_list(alloc_tag_cttype))
-- 
2.43.0


