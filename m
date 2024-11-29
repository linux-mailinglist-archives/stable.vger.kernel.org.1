Return-Path: <stable+bounces-95769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02F9DBE6B
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 02:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6C7164BA6
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 01:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7112E5B;
	Fri, 29 Nov 2024 01:45:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AA28EC
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732844747; cv=fail; b=bCPYF7eZqxxNHMvPvtLZcv1FhGfUASnBZL7BTya6sog77UCVoXtsXvzARXEWZq7OeAsrISeLUEBLbHgxTDjTdsaLDMpsMTz4CvvtG2HP0O6VKil6Krejx41xZ4bvKTPh5ECLbdR6x8m3Lp3k5QtlcPWxp6TZMbWLBFrxsturTMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732844747; c=relaxed/simple;
	bh=N6MM7CUGqsp0/aqvTyHM+Ia3b37Rm/EBIigWmeOvJNs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tUz5gPwORf8a2q1xSLIL/b4n6ghH6GnIlzbXbTeermMr8f8Bvo6EDxlbikrVTcokeJXrlK05ff4hz1iQoMuMujeaHhEkEkHFy2U/8gDaRIpn1NWK3mXdj85qo0pZ6rbBKIqXcdMwwRfuml06WvjusB2yaqOtifq3yR0Q5TlYCs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1NMs6014413;
	Thu, 28 Nov 2024 17:45:41 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43671c9jt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 17:45:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mlgc5K0+zcU8IcDMgTIegM4TcriEffUW4HJ3cULBZQkF33NTrRzKAQzkVhaZd4VUo04c4nqyQTZqKaWJxUvWMAXWVJumfu/Ec9IKdYu8tpaoKricHYQpUjRStJZulSSFPDZ3EiJT/E+Ok8rx+U68hMukAS70z34+fazs/XU/h3aFu4y8MQkgqk182CL3hs25IfN3uNlFdqYGuhTlfwiuZ0k4gLStCAz5AVuncxru8VL7g5sFeKp978GnfKoo/HUF1MDTT/8VKv98q18ef/zW0oAfgukJDsZ5Ylsmil+9PiKfmqUkj1QD40XEWxmfiNQnquM21s/Xhm74NJgmrDYDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgBXsigmWQPOI+wISCTfwd8Q2FFzkCrMOpIJ8X2LKQA=;
 b=yZVETBmE1k8izaE4LXxuUt+zIRV4gbYO6yqwiUhhiv4aMeB4mqXRxjlw218IHR6gVg/FuHZnr8wFZNrd4ygWXqDO5lVd2YGkg8yemn3ueufCBnavxP3hoMsX1kNKZ+7gXBp2u+b09WBo7h7N2vEHyL3L+T7yXJxp1lmrS9JOjdpB7ODw4xHVv7uGi04NlXzNeMHDDSZVMHpSgxOH1HPKFuwEVK+Dx2IhOpQ7ZtEG4yBK7Cv3L+9MMeeHtIOpGH30QyG8/gVzvhblMaVAWcY9leu2LSgk7nHnvLhrzxp0z9i6FfytOukG6AARzapIHW+0Ka75/ogxJXBcXLAcE40cDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY8PR11MB7798.namprd11.prod.outlook.com (2603:10b6:930:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Fri, 29 Nov
 2024 01:45:24 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 01:45:24 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, daejun7.park@samsung.com
Subject: [PATCH 6.6] f2fs: fix null reference error when checking end of zone
Date: Fri, 29 Nov 2024 09:44:54 +0800
Message-Id: <20241129014454.2055882-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0192.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY8PR11MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e717f24-9688-404c-5e8c-08dd10177e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wy0QBjt12KlinB59glaU+KMEu/kFKQXPkkSt+BMhbLMq0YqGlRFOAXpRxjh1?=
 =?us-ascii?Q?MhH2dsmqPBT906DS4w0jl8HpBBba4t5l2zIosT7zjDJLuhz1Hb+PHTf1Nim4?=
 =?us-ascii?Q?2Q7aqH/BgcgPmwe4hfwoNpU4cdXOTyyN2svf3Hc3JBND0fOMlnT1YAdqRh6N?=
 =?us-ascii?Q?9/AdJ3+qa5sdmLhSZW/7pFe0jG9IrRQzwFeBmL6h5Ek2LkJz/mmgIsymOk33?=
 =?us-ascii?Q?HXiG9LDdHUKBd6yzHK9GvjarcHuBEhiJYBoZ9puUS4l5sw9rCZo0Vfbx0Adp?=
 =?us-ascii?Q?EIRcru0rxrNg/1PBQ6yitphq9lND9pCtxXDJgzLPHd/9SyOl4jkyxfBPz1r2?=
 =?us-ascii?Q?fgchQHbBTekpWw4R61yLsugntnwW2IB7aqnGnUExT2NL/ranKghTl4tXISGT?=
 =?us-ascii?Q?1qXcg8lWN8dOATHFTLumsj8uhbC9ipz+B88gH0ITNhrbU5I5bW8b3r0aZsQa?=
 =?us-ascii?Q?PD6ugrwh+7ef4DnJtaI3EHPM+wtptLefpWlCtrR3RyPjP5+ZXv1/ShhN7tHV?=
 =?us-ascii?Q?N+NGlaNJB0GFpShy83MfM+2AG7f4ME0iwQIRdOliSfELNFKsjBFpCNZnvTIg?=
 =?us-ascii?Q?GPJIwAoOKYXI/2HjlMTKaeGDGMTrEzN8xSR6a8fxJ5RteqokpkLGjFHYWSKI?=
 =?us-ascii?Q?ab2ZaDIIHrRVQ1xHTqvKLHC0+U0UaD6XOmOKRrglFCoNd8PJEfusDqVJZ/Qj?=
 =?us-ascii?Q?P6rZf+bjMXsaqvb2Q63uSNnWzwWHlJXNICCPq8ttXwy1RZDMt0Bq/OvCxNC4?=
 =?us-ascii?Q?pjlWpBBUYa/z7lLqWsAIGpdvsS2oGYAH0rRyCVKhKZYtoJcdBqs6kg8Nk7dE?=
 =?us-ascii?Q?vwox3oLI8VvvY/ckXpU3wXuhTvSRGixH5ER9pmQnnsAFsLuLoSMwVWVnnj/W?=
 =?us-ascii?Q?8Ni7hQk1TsIZhP1W7tY3ij+hFINFNpcYycfwLd8xYI1IIIX+N3fF6B9Lc04h?=
 =?us-ascii?Q?p307AgqthSVvTb9M2oz9GLHvXeEyrkM/VFzAfYoJnYxGjMPSQDwM/FX3lBc9?=
 =?us-ascii?Q?V67KWpr0try7SyhHs8U6v4ajQz3K8CrfcGS8M/5ZSp0F0aZ9oWfii8JA1k2b?=
 =?us-ascii?Q?FI5u+ileYWuUP8e9940mvgv6P8vXRlbrCOF3voYpGui6ItyoERhgu6y9HHzL?=
 =?us-ascii?Q?he08iYiFAXKF1uz/NwB9CXPBABh39UBlICdt8H248zRf9V7tjvc81u1VD9Nh?=
 =?us-ascii?Q?cDhWpVShDOzPmFLAHRfRGia/+DGKfQvZFWdkms6Mj7y5RQsZAeylmHQd2Q5v?=
 =?us-ascii?Q?1PfxZAh73twcLcxV2awIX7Oh4Lc9FPOVnZgkt/SzIlKjvTk6ivLQq0cuzx4k?=
 =?us-ascii?Q?Ty7b1BQUuFcX9wsQDU++idUmdX+bsgYvYQhoLknm5a0Z6VKVZ091SOpGC9pr?=
 =?us-ascii?Q?/i1ez08NyhGFvQSUIP3XMmCEvjpf+j9pfmLr+SojHDPn6zy9Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F8aYX8zhncDGK9fjMkssX1Gr2hqa8xmpCJK8+wi5BvS5YNwQRYoYPw/ocfza?=
 =?us-ascii?Q?i55X95ZyyZutb3k/YlbO81lcY4o5f3QuXgH04HXcYr2oipP3c4fFx+94NCJK?=
 =?us-ascii?Q?0DdISWK/WwUB9iYnU5gUT8DJfhStsuRzTds7v0IgFP1lkZEEmj1bhcIXjWXW?=
 =?us-ascii?Q?dzXABMXfM2Y8FVcetYG45Z5ZUayIidb5R9NgRJ3NpR8B0i4T/UvVKnb7chly?=
 =?us-ascii?Q?46TH67y7jtQvbGn+HlkOtXpiSYUho4RGotdH76DxOBcl2S+aGuD4f4c/nubB?=
 =?us-ascii?Q?XZN5AxWCetWmQCifOweRlX5ddAvytb4U3VZL19U6mU3D0cBOPdffBIeaHWYq?=
 =?us-ascii?Q?hI3Pv0jLGcse16rWJdtw1y2wwRS9BoPk8snfyWgLWfaZNz/01W2VM7JdXDW4?=
 =?us-ascii?Q?AvIa7Cs3kbE2mE1KvTzI2XLD6eRQZOIN2uQ3bWcSIuwsZ+D2+SDqXmiBZu2e?=
 =?us-ascii?Q?q8nWCASlG9k1lecge/HgU/GIZjLfN8q36Ht3VoSmB1D7fWZAesFJOvER0/S+?=
 =?us-ascii?Q?mhk6ltH/oZnQNMp4SCpE0VqVxVx0SUauU7cgEteyV65ffDAVG+qintkPxOC+?=
 =?us-ascii?Q?0JZRqm3pi0c1Izq7og6PMt+UdwmQH7KTZzDtIa5sd1rKxmn8DIs+dkDdif4G?=
 =?us-ascii?Q?KjhQ83Aav+Kbka+K9/dBXcmVUyxN8/YVK2OoJR7Yw2IWqCe9mFL4e1H7WNmJ?=
 =?us-ascii?Q?Yr2HaqVKULI2L0K4JO2emBMHcKeIZLuqc4qXGfOT91Lh+xHnMrFk1To+Lr6v?=
 =?us-ascii?Q?I/VdXj9tFk9BuCuVMSfNWJpUpl0UgXtZ/H7wqGq4ED/B7tcUfCTA+C+HVsms?=
 =?us-ascii?Q?rrNyq9gcpcAS9D3HBoqympnqkwcVvdluG/vH1CctocAonZj/Cp6RUzu2QdZD?=
 =?us-ascii?Q?Z6/VvpU2dUsOI95N64k911IXeKPA1wzQOXS1oxuZ1Ogtxw2tBhckHRRnLyIq?=
 =?us-ascii?Q?cNUNcv4haJL17ySHGPS6omgoI7JQQSRfg5fq1AersJ8yM/qAsVyBbITlp6b1?=
 =?us-ascii?Q?2g/s2TSev7Q9NHmWoKQwEzu9927wgsJs212P+LGF7E8qrNyS/BkEJvW6CMzu?=
 =?us-ascii?Q?sh7ZxsBfhCuTZqNZ9+7TP0KgE97ADA6HArz12NjhR6/0Sy3CXWEFe6hD3inq?=
 =?us-ascii?Q?BWE0e0lKgV/atmJ/PrZcvwwzm+09/AAvr5gKpWljUNZJan0RSirJtSIwtD+A?=
 =?us-ascii?Q?HsxGzJe3uLh4b6CVeV9nHGLTveQEltHJJif1iRlQTxc6vErf3mCQCrxoEADE?=
 =?us-ascii?Q?EUOzDCVU3l613t6WKn+b8paO4dbeUnkvMQGs0gsNwl319v5xkdirfiNvbDv2?=
 =?us-ascii?Q?5+DF0hQiFE5eXZwYHVC29jmnX79/uZ0doiGp/sStJQcXDhdrUBMlH+pySEPB?=
 =?us-ascii?Q?GMyM/3CU4hF/FN/FSp/3SAQmpwyC0n8nhxZo/6eEBSEkLf/2Gd9Xln9JVMdP?=
 =?us-ascii?Q?O1HBp2m/Af1NYvyREEu6NQLX1HzLBCDcoqCYlAToRP37pTiTcV/CY20vPrzR?=
 =?us-ascii?Q?LLuZW3aP4jdKmdfly50r2xdTC/Wt+ZuFL/kl9n9VMpl78eGrHTEK4tX6KxhQ?=
 =?us-ascii?Q?1GHmr0yOJ7IK2eQP3YHrXzOGiZxTPl3kJN6fusSfz9uzxf9sk+z/Izk6MTly?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e717f24-9688-404c-5e8c-08dd10177e10
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 01:45:24.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c8TYHA5GnSbPrhsmOiwY3RwHloZ8cPPf9LxDVCuanJkzQjG/TIubEeU+/Q6q6j3xmv2A9IXCd1NRg48ew6qOkdVAaJBRwo4sdzA22X1qPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7798
X-Proofpoint-GUID: DagPy9QcB2Z6jFFQKQhBQg1EL5E_7SRL
X-Proofpoint-ORIG-GUID: DagPy9QcB2Z6jFFQKQhBQg1EL5E_7SRL
X-Authority-Analysis: v=2.4 cv=QYicvtbv c=1 sm=1 tr=0 ts=67491cc5 cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=hD80L64hAAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=n4AgMSqV4wFoh8OWXMIA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_20,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=879 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2411290013

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit c82bc1ab2a8a5e73d9728e80c4c2ed87e8921a38 ]

This patch fixes a potentially null pointer being accessed by
is_end_zone_blkaddr() that checks the last block of a zone
when f2fs is mounted as a single device.

Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1c59a3b2b2c3..d5ff22138bf9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -924,6 +924,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 #ifdef CONFIG_BLK_DEV_ZONED
 static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
+	struct block_device *bdev = sbi->sb->s_bdev;
 	int devi = 0;
 
 	if (f2fs_is_multi_device(sbi)) {
@@ -934,8 +935,9 @@ static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
 			return false;
 		}
 		blkaddr -= FDEV(devi).start_blk;
+		bdev = FDEV(devi).bdev;
 	}
-	return bdev_zoned_model(FDEV(devi).bdev) == BLK_ZONED_HM &&
+	return bdev_is_zoned(bdev) &&
 		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
 		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
 }
-- 
2.34.1


