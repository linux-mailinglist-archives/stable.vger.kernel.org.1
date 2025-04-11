Return-Path: <stable+bounces-132208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C34A8565C
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B174C0DF7
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D87293453;
	Fri, 11 Apr 2025 08:19:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26A1DF974
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359575; cv=fail; b=J/jWcJaIsLntOKn77XU+1YME8FZHl/wgACQPfNKWc13OH0C33vXDZgimwnZhXpwAF1ZsbELt3VLqQloPsZ/u38YsQTZN2tdPpKpD1h6oELfVA/YD9Q52KKfWI9gJ0aGOC0Fss6GlcoWLJA1MsX/NYDI3N3HxfzI74ItW2RUqoSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359575; c=relaxed/simple;
	bh=WP7yhPd+BozBKh8viYUBTzzGL898moVRBfR9NmSndSY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DSxv3IVv8kChzplecR/yHFArGXqeB0UmU9n/9UQVL06oOvaE6ELvSbSaPgFV4RoVGThuALJ9zk1DrR4OuGZvLA9WQIEVrRvyRkgnBuqTQ02x9Z4IsG9c2SbN0F765U+Q2uIBzIvEr8UrqLlp95ZW7mYBcYHmBlTl3q/HpLYt3Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5AfOb028040;
	Fri, 11 Apr 2025 08:19:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tug8r139-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:19:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJRFtShEEqJpOELZwwFTk9QBf58zVVGmfNXGw4My0Hp1UPASQytmO+V657H5DNdYwmy9TFqjLocXh0ZrP7mHn6vNt1jnCdbC6O2eTWDpPKEQ4k+1hFqlhOqOcrdhfhyFvQudut0DpovqBA6ZhM1J8T14fxyXXMtVH+AuQri6X6v8gbWimuUabb1i2p5De2FJFK1WEBiVoAUgC4SUJGgyGSmy+FV5SzGfT9QD24mZa6xpDInrGaQdP1sPlKwpiQU3GkwM9lrAhKKIiw/UAXMzh9tDxiLMhq0itl0eg96QDhiYzXQnLPmyuSJaN2KP498u5v72xocgO989eiLxIky2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OPKPcVDsAmshfXbIgGVGQQ5kV441LRzuwqGHk4odlM=;
 b=GU2613TnIpjgd9pS2nQBPh4RFUqwAes1ygaW0GaFJ95u7/K0clvOgqJxhK3PpnwLhf6bOEPZxTpQgpIz5DeAkLvHZI9hYpLNceqOgRlqxzGo8iCNzgzzUBXBgAhZhUMRbZSES2sYSivs3eQ2wjszISKUyuC5p6tM90fmwVGNFYmtI9h7ufz1YAOq5L3+iiVjH705TPd4FRRY9FpwGcQBC7S17E88znUuO7FFVstcl5Cgy8oFDRQACAMi5Ml9v10dWnOTpGn9n1YZ9+K/NoVBd4D7CRDkSdYty4GxNofOLdBk8gFVKX+3zNKkV8rDF1Haa1RXQwj0q3xnlPg3KVcA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:19:25 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 08:19:25 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: shenxiaxi26@gmail.com, tytso@mit.edu
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15] ext4: fix timer use-after-free on failed mount
Date: Fri, 11 Apr 2025 16:19:10 +0800
Message-Id: <20250411081911.219016-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|IA1PR11MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 92499871-8875-4970-7b4e-08dd78d191f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JmSetEi//cr2mmwV6lpEKciLdBFf501F3UpFGQZqOILhNNW7OhRRlH9oMlF0?=
 =?us-ascii?Q?xm4gVnITE/PCELnaItI8BzhV2/9E0VJYcg4TBuRmNUNekkHgYPYm7ekQCZbo?=
 =?us-ascii?Q?NNTOrRL8ZOD5O4zNrH+Wo5ltm4UyYG5PEEU/q0LE1pUNJbZvroxsWP5Zs+/2?=
 =?us-ascii?Q?+qBKMm7u2uCOuY2kSg51ybp4zfPGtlFdE4aHzIyQ22YucUVcRDfdaPt/BniE?=
 =?us-ascii?Q?OYJl6R7ytT0k+toH2wDlADdDcowkSqWeYQGY6BrfN6jY4s0ex6qR9E64HGgC?=
 =?us-ascii?Q?2JcHfI/J4kdjLDFkUGuP5XcQiJ5u4EVa6qUKUaYTPXYBh9Of8eUMPH7VlLAR?=
 =?us-ascii?Q?vPt/lTc4CwMWsOj39+m4ruU0RYsQRirYqA+sY0GSXZsj6vDDX8bfFaHM4XRj?=
 =?us-ascii?Q?PjvgbT6IXIechLPsnOCAQxiO5so0o+CoMNu9B7xCd2tJjZi4ujh+RkyGJ2Wn?=
 =?us-ascii?Q?tLpb461H1DqhlLVj5mr0rnBtj81m/DI/ZtxMkHXdE0uaEj0C6uK4xie2TWC9?=
 =?us-ascii?Q?ccssVLPUuEjazfbzXKwMy3DQAEnXYvdMk/KrgWOfhxEpNE/QmK0n43juO9Xn?=
 =?us-ascii?Q?TLkPvci/JXIi/loQT1K9I/Izj0g34v4J6GdExUa1WO9lt8vPmJggmkppxG4a?=
 =?us-ascii?Q?SwYFgyXfU21EsQBbafXi7wt9/jI/pKWeE4m49PD7v419YvNfRNJ9030291o3?=
 =?us-ascii?Q?UTrR4bxTw4ZwKPzsybjeeBVeHdmTzIcN3HJHdbyXZRfXUYhV5M4MZxTMFjg/?=
 =?us-ascii?Q?pIzWbf/gYSRLQ74vw55FG/fizs0dN3gMA4sAjYE2S4+rKqfhsfS62P4+GbZf?=
 =?us-ascii?Q?JOL5+R6RtFky5ANzPowTmetD6RxGbHeipUZMgmu8MsqZFvLGlrahpiiYWRQK?=
 =?us-ascii?Q?nyT39kxbTmqkAYACbMaf8hQfAsny3mEdL3h9V2WQaGHzzPW1OGPhtH0vNjJL?=
 =?us-ascii?Q?sP8PiA9EMovVUgRGkl8aYNvXRL1YOE6oTZGzOTHb1l1Nre4cipCTU1CAFlSq?=
 =?us-ascii?Q?yrn7uCT3Fr/nlNBwD2cURAQNFtCA54AWMfK5KJv7A0kguaKuM3Gn3UE8X6FI?=
 =?us-ascii?Q?/IMp/0jByOCOkjTSvGTUclqJop1wSh1NYVC36DyMkD0hNpOoKvh3TAsfX/xP?=
 =?us-ascii?Q?U+cgE+NCyeaFdI9F5B90rb3pLpaNIrdyKQrsaHH2Qzb958uB6RxpdyoZ9INi?=
 =?us-ascii?Q?8RlB0LldA2RbnUpnBdrpaYdLCmIhnTlqUgZwzMaherUTsdvReXZXZcIvosut?=
 =?us-ascii?Q?lqhi7TKyV75YvTkEUV54+b7xi3D8dfDmkC/ePvuIqk7tHVDQb8KZGGaLa7MM?=
 =?us-ascii?Q?gHwby57+j5VaZlnaVXsJaCpoCFklo+09KxxST3nkvQfLLcyR1FImNxy4+FVy?=
 =?us-ascii?Q?kPG/Avbs3j1wTpEKp95hWjgjREkwnH5FbAdlgPkyb+wAeZxHj9hM5ntEBTjl?=
 =?us-ascii?Q?SpTnv81mrc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NMKJuAuU2Jb2KMCll9Ns86Y8DesMGKKRv2LcRtzo1F/T0GSAUPWHJzEdjuSs?=
 =?us-ascii?Q?2CkofFmAxvuOxK13SlsN6+qob6iW74c/sIGVQBPNXYs8wxBHKKmw6xJ8ntpc?=
 =?us-ascii?Q?beR5kctcuSaK0Jz3UkCON/pZXH62SQvCiFIyAyXDodEW/749zCXfWkfsfih+?=
 =?us-ascii?Q?8ue8IdCwGYmwbT81lr7RWLjXQTmjmp5qG9Rjseb2B57toDd2RI7RhqKJe+Ek?=
 =?us-ascii?Q?Z0mKndKmqT2pTsfRNy+vgfqnEq57qEqNUQUc+kkpeJ9AkyYgYJtf796JqrQX?=
 =?us-ascii?Q?3m0u4I7y+Ff8w0WSBU8w8wUq3V6AYeYNwodO2mMRTFYaQEBJL5bF4JOQU4Hn?=
 =?us-ascii?Q?kWUNQbqMR9mWHxQUpdKlc8Vx989cPyg8zmpgcWapp/g/ugp46WwD5QBNCw79?=
 =?us-ascii?Q?XLrvXFsmbd58Scmfs5NijtsAIa1GyR8abV0d16f3Dg0VXGqPpjuRn85LVVoa?=
 =?us-ascii?Q?P1agfk0MZXLhwttbq9IUZDX9h4TzPsq9U7yHAEj11L1idGJah/Yr2b0VKC/n?=
 =?us-ascii?Q?Z/ttSvP8OYGhSk6seTtwLXSzsYWDKJQKb2B2EBudRgeXRBlWcfp494b3B07W?=
 =?us-ascii?Q?DF5wvyFVhbrf91QTNuci4EIpQDU+zyHutYLpGsCL3m1vaHS03u5ehkfJU6RA?=
 =?us-ascii?Q?vHakrK7KLLuqqqTQlA46cNffqcWnAAt6jn38eyKGxeeA7YRmaJ0iraJEp6Fm?=
 =?us-ascii?Q?brOcx/MJDSc7Ip8VOylHaUoGCu30qT2UkIA6fLtlOg6+M3Q2q0OBOTpmsFpy?=
 =?us-ascii?Q?Rh+6Ce8Vv+2jhr5b+Gz9OmEu9KGZeSqAK0l8pFsDpU63gdAGBzI+Js9U6xgC?=
 =?us-ascii?Q?hZ2DKuTpYqRny1PB85648pimPfdS+LqwiuOtvE4fq2n8mGcVqYfT/Nv4SY3f?=
 =?us-ascii?Q?pz1O3L4iykBmYhNvjtcNEBkccCG8PySrrGtKkxtprChjWWhtmpZBBF/+2Sz6?=
 =?us-ascii?Q?IQu37nWqDeF7+4Pb0NbpB/pPhhJNA/vDQZPhi+2uu3c/Ke4ujsupJta5dIX0?=
 =?us-ascii?Q?W91/7x6PkDLKsi8F57A9Fs0S4vkc+mHG8QHk6BMliSrJgg9Ukrb2d9VCgAQn?=
 =?us-ascii?Q?hNDn09XOYGoJcAIsNV8XC7toqInkbcfWDeW44S2qG23sDwcsmI7I1gP+6Xw6?=
 =?us-ascii?Q?TQe9pXrB4tk94h7MUEsHZudJXBstg/wJmX0PBfjripBwaWeKfZ+p7tVqN1eI?=
 =?us-ascii?Q?PIzmiskaFMXiT4wnUhblsuHBWNCk4ta5cGnR9wYJ3zmR5jY2E7DD1YpJt3D9?=
 =?us-ascii?Q?vxRNgRw4ZKyoyrbDdVSQuzr3jleoTxSzA26AYauCgyJeQ6ymyjyh97uS6PI3?=
 =?us-ascii?Q?s4qINKoAhz4oiiy3OenuDvQ0akw+Mo0+0Qm896vaGKA/9RCb7PjKGmotMxNx?=
 =?us-ascii?Q?M/OI4mw5CzhcFBP2xeNrD46wqXAjneb6u8b/hi4ItP4M/O054gfN225zwjsh?=
 =?us-ascii?Q?TK3+rXKb0J4IinS9d1WWdbKvANQ38Aiq7U7wiNNt8wrlDfwDnyS1zI9wc6VC?=
 =?us-ascii?Q?X2NCkXVP0RNCxCcNRmNhOvUcTg0vSXvQHqJASfHHqiVlIvmUVW2iE6I1WnJJ?=
 =?us-ascii?Q?6Hbrlx+qDpsJq6QBaj4zsKYnBl/m/HqDD68S9jvDvKgsMrwylahE2blJHjUQ?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92499871-8875-4970-7b4e-08dd78d191f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:19:25.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcx0pzWR5f1eEGMRrtRfMV4JZW0YyJ18nMc5ap0aaoItfmYTViCgE47XHwiGbWvT1/wewN3L7dCms2jLe5THweEHLQ1pno/sAbuPlKKE9HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
X-Proofpoint-GUID: VVUIAr3-uI0tRkuLtmHAd631OsyiI8BK
X-Authority-Analysis: v=2.4 cv=YJefyQGx c=1 sm=1 tr=0 ts=67f8d090 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=edf1wS77AAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=LUACZsOYbq23hAV1XZkA:9 a=-FEs8UIgK8oA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: VVUIAr3-uI0tRkuLtmHAd631OsyiI8BK
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=939 adultscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110049

From: Xiaxi Shen <shenxiaxi26@gmail.com>

commit 0ce160c5bdb67081a62293028dc85758a8efb22a upstream.

Syzbot has found an ODEBUG bug in ext4_fill_super

The del_timer_sync function cancels the s_err_report timer,
which reminds about filesystem errors daily. We should
guarantee the timer is no longer active before kfree(sbi).

When filesystem mounting fails, the flow goes to failed_mount3,
where an error occurs when ext4_stop_mmpd is called, causing
a read I/O failure. This triggers the ext4_handle_error function
that ultimately re-arms the timer,
leaving the s_err_report timer active before kfree(sbi) is called.

Fix the issue by canceling the s_err_report timer after calling ext4_stop_mmpd.

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
Reported-and-tested-by: syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=59e0101c430934bc9a36
Link: https://patch.msgid.link/20240715043336.98097-1-shenxiaxi26@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[Minor context change fixed]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 126b582d85fc..8f33b6db8aae 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5085,8 +5085,8 @@ failed_mount9: __maybe_unused
 failed_mount3:
 	/* flush s_error_work before sbi destroy */
 	flush_work(&sbi->s_error_work);
-	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
+	del_timer_sync(&sbi->s_err_report);
 failed_mount2:
 	rcu_read_lock();
 	group_desc = rcu_dereference(sbi->s_group_desc);
-- 
2.34.1


