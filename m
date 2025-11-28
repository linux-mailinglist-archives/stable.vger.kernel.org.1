Return-Path: <stable+bounces-197579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E478C919F8
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 11:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D41134370E
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51E430BBB7;
	Fri, 28 Nov 2025 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="LqygZAyp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842C3054DE;
	Fri, 28 Nov 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325717; cv=fail; b=nlNUYexzOnUYjX0fZorRNtyzIUjUPeOiGfunvvvDGBxrm+sZnvwnNBEmFRWtkCuVEs6jCir/plwhdofuEOpBnju6dZ3Tu1Iyy+bH6SgSHHpc3xY/9wSDktLFOOp/s381gu1XQfrgxlKuqAtKq7RLDcLLVykNzOp6rLGN6mLqrrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325717; c=relaxed/simple;
	bh=+wdVlW50tuiC83/dqSqca6SMopMTwoOKAo2oh1rqooI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cLT7Nv9H095nYWZyxNWbVCVkegiulhFAZbwv0wuHOonKrT6n9fJa4EHzMa1Fd8KkPcDDZSBqw+vaI7hMjr0B2XVcHUmpBF7M2c1AMtxfB4QzcWeY23GiaI2wQi1qOHYPT+0ZcBX5duUTTe8ZP2C8Lrdbtsbim1exVP3bgeyQC4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=LqygZAyp; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS5YPmQ1984065;
	Fri, 28 Nov 2025 02:28:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=mzrsj8yFk
	OAgPPCHMQu4YdO3VA7rLNo2mMV1y2JK4s0=; b=LqygZAypaSUOOuWRG1FiA7tb2
	tdmEN3GEhTUT0b6IE0wJG8HG+733gJpgTx8G8635Rlwgsg7xzYfKKxHyTGyQAevB
	oODjvQLhR07zQXM49y5oKaaQxLnuvUxXSx0k1+ffGZDE8tVkI49gNCaIc9BWdtDD
	aJowQaSDdR6MCOhRhPYWpFF0n5USSWU0dr96nTKnP12inxSJRMuvQkegnY9zXJw3
	URcx6oFjfu5KztY5jgCfeLT4UUslmAsjsy0tzs6Q/JC0nDRVvl/SGtwNk50v5WkO
	aRX96hxtTQMICbSvNouGhVz62ddOFQHNYrj7QzfcnR5oGhBvPPtDeih5C6HFQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4akdjjefs6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 02:28:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeRy0ajSUE5JE+YdOFDYTGBe54CfZE9CEJJu1Z6bOdciKw/e6lyudIzvMr96p+rwWUMr80oGSbi7eWS06uzICtH7bGzV5M0mW96x72QVrMOUpjNll0/iycoznX+fp9XBEd3W/0TvSD6nDpnOXoa7qGPSPbEr3LA8zpvWJge5IR4ib1o63F+ToUgn38153RorD1zerzdLzkrF1Y9k3wnaE/9KBbspncb9V/HVb9z5sz6D8s/RkWk5gLPc/l6ZIKq442bzJP0hCCBFFJmklKTDWR/f8ThmlB1EOG4jkukUzon8t+UcKi067B3JeTLLc45niDJtfjmiOgI65beaiJu/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzrsj8yFkOAgPPCHMQu4YdO3VA7rLNo2mMV1y2JK4s0=;
 b=Ijgv87K7TsVnTIJrKKiZ54jpyPSBmciWonOEDwOWgA0cL+NdFt133BYx/mqf4Ig/dMTiWFjwm4mqIv6XZ7KMuyGTHoB7VKNqV5CBG/wb4li1tXWGNqjgVLOFOg5xrqNihE+gMT8ZQ59cdU3lSyyUhgeYxOkiuoDsCEwH8sVyKbGjZdD9sUGfjuJZHXSr6p60yZBm6zqGwTlAnZ+uvP69Yq2cDJb/mpcP4yU2a6huC0sNjVdyOQ+lOC6OCzaBQsYZ+zXTMrQ7CpMiIcGmhBLNomVXkDYywSuaGBT+FFlEABpyLMe3o3JWqSB1TKJ/rSqK4Og5pkdJs2nw9bYqb+E9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 10:28:15 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:28:15 +0000
From: yongxin.liu@windriver.com
To: platform-driver-x86@vger.kernel.org, david.e.box@linux.intel.com,
        ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v4] platform/x86: intel_pmc_ipc: fix ACPI buffer memory leak
Date: Fri, 28 Nov 2025 18:24:38 +0800
Message-ID: <20251128102437.3412891-2-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::6) To SJ0PR11MB5072.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5072:EE_|PH7PR11MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: fffa54f8-fb60-45d3-6506-08de2e68d705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1BifpyMsQBOhib2TPqeoNBUsKRYE8WbbBOTYLZWJRohyfnALgQhjROkvVYwd?=
 =?us-ascii?Q?2cR2krzyMJA/FReBB0Wa62b+WY7kK3fcOLBkQPHkbph+m7GIlzQrU8xSBJ4a?=
 =?us-ascii?Q?P2VEOkhKICnq3j27/ySdhC2C5PqzlwiDigFynEhCgEiaj2No3JfyQ0lase1Q?=
 =?us-ascii?Q?cK1LmoMyu+cqjnY5Tk1qUakYrckPsO3JlNPf1+AX75/mL0KHtGDU2CVtYiM1?=
 =?us-ascii?Q?vK5y1Gs3ICUlFDtXjGfd8B2KNHAoPM0bhWZR6YQo0tmT7JxY2QnCLJuccZ5X?=
 =?us-ascii?Q?RuHeEzT/00tP+RGjO5OfBhFsb+UXhJKsbsxkeyu4lyctUUQwKLK9cUpnPBR+?=
 =?us-ascii?Q?BgvO4lw2z2Oz7rRyIb1bTxiap4eRVIy3/+UtWPw4PIaJsR9DZzNXinFn6bMH?=
 =?us-ascii?Q?N3yMi/tejrqq/1zkaJlZ6OCJpocNCYhyh2ywpsHx8TnbDUnltz4Jx5AitI11?=
 =?us-ascii?Q?Ps1dH5t6tvny132fWxqoo9xtx9WD5L+13V1G+5p2F7rqZWaWjSyWkXHKOLZC?=
 =?us-ascii?Q?2ivwVkxW03TpImiDO8+t/5mEx554iEa4aYqDlc+VWcwbXK2tJvmnCPcpHinJ?=
 =?us-ascii?Q?dTJNO3sOtIl5Xfday3ldJEeBOE7uggyl6Ea9xgks9ntyseRGDHuY6/xb0yNh?=
 =?us-ascii?Q?QKBH4Q+dyFpPwzWlzcqxP+LMjXg+qDq/LTa7YQ6esFEx07GyiHkYTmyKx9vX?=
 =?us-ascii?Q?T7GWcwJCgrfCVfD8ru90fcxVZ476+kTEbrQ6EnjtqEgsWamgR50w1oDTRaNM?=
 =?us-ascii?Q?URNoa+WHze1NXF+HlquwDx86HbKWxmdWbweRJ/F3OPGXN4dnhdjf1jj8WDrd?=
 =?us-ascii?Q?O6bZzck3Dht6pG3QIuw3kKf+yzeK2eej1Lr+MX2aortblfO2ogdBJUBoWud3?=
 =?us-ascii?Q?ej+bU+ufiuZCg5Qs2UeVar5BpG+xpXxSCr4jBRiMIig4wp6jHr6nU6daESHu?=
 =?us-ascii?Q?YiXLz4OMRvuXeopaIB9DBfQBq9PspRWOm1vuydlU1LvzXzeimxptKvcoDhUV?=
 =?us-ascii?Q?CBxYRDyFOR3NVnCfcEwEt/vLhfx0H/wQmYdPLJcvVLzTY3LU3fM3oWv41PGq?=
 =?us-ascii?Q?484cVgyxsYWWWNqVIq9HGN9lzsebdOxJ/wWG9LKNsdxFBaEnSAdE/iYRQHF4?=
 =?us-ascii?Q?QjKP4VkkbG8S3ese7GiFd4BRPAPWyQP7G4cs9IVKRINjNwN9Uh9Gjvi3oGrB?=
 =?us-ascii?Q?Hau5gRgmhRJPWcywDuH2mFI/NhiR3r82JnSSwmbyIgdTMlAN6wFgNknizu31?=
 =?us-ascii?Q?4zO5x/QIWXM4KDURNVmgvPbZCZjuVN5LPQtWq7IVhJrw/aDvny4KMr0c+7Yt?=
 =?us-ascii?Q?slI65xtxb3VT1zsytdpI75ocOvONU8fdxDgVcAJ91zFEmZV1YCxlhzvUvS46?=
 =?us-ascii?Q?sIbFgAh6TyNSiSeAHWgyvjb5k7/+J8G3jhf+aeu5xAwQD/rvsb8ScbC7e7Bm?=
 =?us-ascii?Q?ss4f/U/Tu5XEJUGXGyT5DJhmkDRag+pbm6ivpKiyIWLzF9nrw7+ahsVr1m8O?=
 =?us-ascii?Q?h7+sbOXDCpmPm2cb7XgSq0nXUU97eSA+/24m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91esvR3Al/tzG3K9dERDCZzKi/Y4GPzUoEbLpa1ER4fFK4p99CsV39U4Gzv5?=
 =?us-ascii?Q?x6RKROrQr5r6Agarxfnx4uXrLekZHyhNsjHSMEOopDwuSsUanLUpQHA6xp86?=
 =?us-ascii?Q?7krcp81LXtruW3wwBAZzXtGo13G13/vj0kRVNTeRQsyEb8T033k9v5+WaAXO?=
 =?us-ascii?Q?5fXidpkGgQu+Zjav2T1FhuWhX4nKKyidsmcY5xsDYMUwoIxjEBxaww2ZvoLr?=
 =?us-ascii?Q?XRFcCVmFJhj+PBCwT6+66/bkgchdbLApMDOsbhfuATuvBbxoo9EcWe7SpGy6?=
 =?us-ascii?Q?74Zetry1ovsQ8zwjcKBRw189af+Tk1DUJuU1XF+fUrKZGhG28h7KfEvpeFMF?=
 =?us-ascii?Q?Xl218RVA3sesEqQ4oAYHyVspaSjNaGa15sQ/cwNehVUCLf80Ze5sAAEyKRzr?=
 =?us-ascii?Q?uvvRXK9YruUHEH7FmA/BbzZ3sPynkH1HAWtDTvDlIEC8O/vQ3i5g09+dUgCE?=
 =?us-ascii?Q?yg/IsToELVjw5Vf6RZuhlZ7rjXA9aE3PrJVIA+ewmhexIq9Y0q/vUcBecWWh?=
 =?us-ascii?Q?myZ9TeiOVawV8AKuk3DwkktuTlIulVHMBMy441jXXYmg5ZgjxMm7j/ZyZiIs?=
 =?us-ascii?Q?MidAurTQ5ZCpOdwOvTbnf/3JIk2Rp5LtCN/w+shM3tobmukxRGEBRDk8LGzy?=
 =?us-ascii?Q?rO0LUgnl3KR5hycUR9v85VP9JzL4uNw6usHbyqavSs2wOhBOn9Fj/zVd4j3t?=
 =?us-ascii?Q?FClhmm0wwVr2s2An6TAN3RBgWuu/T/pKewN/tcU3ha3h1QXCcJPR24USKYou?=
 =?us-ascii?Q?IZJTPjxweXALANaWGV8qkfi7YpchCl+LaYUU847XEb9pfQZRktUi75TN3Cyg?=
 =?us-ascii?Q?QUsIVAwQSwaFvYABGyknk31R84jeYJ4/qK6t8d6PHJ7+kJC61OCS2s8aJJpG?=
 =?us-ascii?Q?kDPzElkiTegdaOY5FPqkROjlMjLrB1aamxlH0y3S0sFq15dXcvXMPOsavcx4?=
 =?us-ascii?Q?GVP9QPrnVpPT12nRP0NLDhHUp+K8TeclKfFXt509X1idBofhXxtniixYnbUq?=
 =?us-ascii?Q?Amqq+RYhLOsD8n+GJUMsz4JVKkoStFz2x3nW4biaAL01ljNvS97c8g/vBXDb?=
 =?us-ascii?Q?bkFzeydL7wLPcU1/m9c/pS7BCBCRiM+hKHPRwhleFPYFlXjS3QBiP4zEv5QN?=
 =?us-ascii?Q?J805wjUcNz0HGZ66rA14561/IZy+fcyzgH1XU0e5MT0C/a6GHEvjZmfjBC0C?=
 =?us-ascii?Q?DteT9YKzJRGrNK+zncTHKsJm5h+rNHK3dbiasnMTGVllovK/qn4w05rCUYbS?=
 =?us-ascii?Q?jQuwYUNGDZTfaGzbuKl2I6klzB9iUsJ+8cIXyLckmLW4zPjWxQzhQdea7rJp?=
 =?us-ascii?Q?0z6Oi1uc4ERFoAjnG5sWLgzP8j+VrOM9yo56WdEp8VS4x10s0v2MNKjrdueN?=
 =?us-ascii?Q?GNOieOG2vyY8Vl5tFWlUc4ns0ZoCkSZNA8UutuDBu+FASkP7vgU1hGpjuOI4?=
 =?us-ascii?Q?m4YX2Z1S3QtUTUhWApnzVcpsRGVPpHY5KA0ncuaRIUvIYHrftbthfiMw4+8Z?=
 =?us-ascii?Q?OIiH3Ofdt4w7yofFvM6hJA8R4zkOBvgesk76MsiRCGM/mIcw7swLcxIMUPyZ?=
 =?us-ascii?Q?8fFzc38enMYvTHjCHsyHRh1rcl5phm8ZF+qSu2+cYzQyi4mi6tQn0u6FOdpP?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa54f8-fb60-45d3-6506-08de2e68d705
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:28:15.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlgOHPxwnazF2VdzkDN4+GY+GwK/XwR2b20sJtBqBwToxha1+AHOcUPZV5JhBqZe9dtDHNZ5zau6RpNIgJae4ZwnTXUTXkFXnavPla2mQDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA3NiBTYWx0ZWRfX9mkxRMMPBitP
 pAC6AQB47U8IO9cVRzEFVyoFD0Xw464ruDOA7divjWOEDkJ/ltNcN7ba7L9WCQf+c+j7iqIk2Pd
 FI192BtrKWRvpqo1QifwwI8YmtRtEBFaEPeU6FgPLx7wyv6Xykb3GIMEM7Swe6bSQ/cf2rR1KHA
 U/CVRRfdzSZ8RaXV9Dl6EjJDPkpFJTTjI/uLS/I9goPF8bVJedri7B/Ub8OLeQUhy+C4BtHGmwT
 GjCnw8GvIYuB4lXUdGrrUTJkdpqYOnM/zm1NaibNEP73HJtEiVFBbIUMwb4MB6Ega9mM5Q9uhT4
 yZrzSASwT1yEgrSjCjZ6avb7k4gqhANhdegjk7cm2tgYzILBN1tGHPEykpdIP0Cech3oeswYjtB
 ka5YJ6AxCb7q3C9EJbVwQ8uGG4LtbA==
X-Proofpoint-ORIG-GUID: WRXM2I6vTwwMIeDKwOXZzF2V0YNr76kG
X-Authority-Analysis: v=2.4 cv=Wq8m8Nfv c=1 sm=1 tr=0 ts=69297941 cx=c_pps
 a=IN6nX5sQGDwae/9PVKyrlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=GLtnJ_i9NkFmi9gY_58A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: WRXM2I6vTwwMIeDKwOXZzF2V0YNr76kG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511280076

From: Yongxin Liu <yongxin.liu@windriver.com>

The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate memory
for the ACPI evaluation result but never frees it, causing a 192-byte
memory leak on each call.

This leak is triggered during network interface initialization when the
stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().

  unreferenced object 0xffff96a848d6ea80 (size 192):
    comm "dhcpcd", pid 541, jiffies 4294684345
    hex dump (first 32 bytes):
      04 00 00 00 05 00 00 00 98 ea d6 48 a8 96 ff ff  ...........H....
      00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    backtrace (crc b1564374):
      kmemleak_alloc+0x2d/0x40
      __kmalloc_noprof+0x2fa/0x730
      acpi_ut_initialize_buffer+0x83/0xc0
      acpi_evaluate_object+0x29a/0x2f0
      intel_pmc_ipc+0xfd/0x170
      intel_mac_finish+0x168/0x230
      stmmac_mac_finish+0x3d/0x50
      phylink_major_config+0x22b/0x5b0
      phylink_mac_initial_config.constprop.0+0xf1/0x1b0
      phylink_start+0x8e/0x210
      __stmmac_open+0x12c/0x2b0
      stmmac_open+0x23c/0x380
      __dev_open+0x11d/0x2c0
      __dev_change_flags+0x1d2/0x250
      netif_change_flags+0x2b/0x70
      dev_change_flags+0x40/0xb0

Add __free(kfree) for ACPI object to properly release the allocated buffer.

Cc: stable@vger.kernel.org
Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add SoC register access")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
V3->V4:
Move declaration of *obj to where it gets assigned.

V2->V3:
Use __free(kfree) instead of goto and kfree();

V1->V2:
Cover all potential paths for kfree();
---
 include/linux/platform_data/x86/intel_pmc_ipc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
index 1d34435b7001..85ea381e4a27 100644
--- a/include/linux/platform_data/x86/intel_pmc_ipc.h
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -9,6 +9,7 @@
 #ifndef INTEL_PMC_IPC_H
 #define INTEL_PMC_IPC_H
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 
 #define IPC_SOC_REGISTER_ACCESS			0xAA
 #define IPC_SOC_SUB_CMD_READ			0x00
@@ -48,7 +49,6 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 		{.type = ACPI_TYPE_INTEGER,},
 	};
 	struct acpi_object_list arg_list = { PMC_IPCS_PARAM_COUNT, params };
-	union acpi_object *obj;
 	int status;
 
 	if (!ipc_cmd || !rbuf)
@@ -72,7 +72,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	obj = buffer.pointer;
+	union acpi_object *obj __free(kfree) = buffer.pointer;
 
 	if (obj && obj->type == ACPI_TYPE_PACKAGE &&
 	    obj->package.count == VALID_IPC_RESPONSE) {
-- 
2.46.2


