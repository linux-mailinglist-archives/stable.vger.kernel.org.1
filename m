Return-Path: <stable+bounces-103994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A639F0959
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355E2188C84E
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F771B87CD;
	Fri, 13 Dec 2024 10:24:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCD1B4148
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085485; cv=fail; b=tsRXJrvUdgLN8cVwlhNaaMb5gygb+Z1eqTujHUTgcidPfY862zQ3VsBDfAFGQyOWMq3F1X1qvuqpwoIRgXMGyEymNVSWckIxjITik+gTHhFICiG91sQjQ/mzuepaihtXC25AG3yp/EUup4E8qcE9gh4Vf7udUoansPQwwPYeLTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085485; c=relaxed/simple;
	bh=jI/kpCjKri0HH/fZR+R0FBw30ogvrcO3INNn18ZRaOs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=igbZjjEzGrN/s3KKM0NcatvDj1dK+kbWBYmypooD5GcH65MJHAU250cb1zPOdWWR9zkU8AjU3irHshIiSvofHI4j6DkIpx0vOLmJt4brt7r0ZHZ2vJf1HP2eUFkMKz/dRd9+3OgaxDODWjZ3qU4TueW8zy1rN/9QxVCNX7ZxK1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD8Icfh006157;
	Fri, 13 Dec 2024 10:24:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xexya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 10:24:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwX1vymNaH0w2xGQjSsj+lnUMuE9TzrTY0TE4xRIOcktEzQJiJa65cMFQq+WRbhsS1HUrm9HABLqffyUy+HVWNDLeMh0kGWbJEM3IomfgHJ1xXjWwpifWznTnlmSE7V85mwpUi8RskEGR86etNAG8JlGhVTuNVwIB5RP9RRbmpk1YvDNXWlBYsSvbRLzNO6UkHk+ComNIui5KJ1AIkmMIBW+snvCzCOyW5bDUNGJgObAqTLjrwoANYaGEb83Cv1vOCEqgFSvPdcmZ1fgtBqpHJB8baT8stbSGyqN4RnD9jTzZHE8JVQWWowk0XdK9L3F6JDSAyjBQvN5QJpFGRssyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwZ5f8rugdpGpNJ2sLS0dErApyE+zPj/W/Fy7o0+HUQ=;
 b=pMbN8qC1HH8RZtH7zgsTxqTsPrNYrEmTigNJhqB9tpb9ES1jrjQ1Em1adL81csPd9cfoTfPMVGnRsHKtOBG66XUB90BtJVrBD9H7zSplalgRwA/PqXk+1cpl+k/9cPNfBWGZwrzPBJa0lf+BKEI8AtCZfrPDVLBl/AUADO5ScP6wEhhkSJrlBHSth9tehEg4/t+450VRLAU0snL7zTcYgKX0B2E4UxedTqXcs1ndWeHruzgFQvHf3VffbOPFxY83oYLTDm3iQNa4d5fcgbpSeUkVhb6GvfLn30cRXMCMeGHKeqNIWbSlg69PLSnkDv7TFbiV45KmfRDMpIDyIeaVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 10:24:27 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:24:26 +0000
From: guocai.he.cn@windriver.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, juntong.deng@outlook.com, agruenba@redhat.com
Subject: [PATCH V2][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Fri, 13 Dec 2024 18:24:05 +0800
Message-Id: <20241213102405.3580198-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|CH2PR11MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bdb648-7ff6-4e08-6820-08dd1b60522e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZPfjTG66ELEhG64S55f29pMlWwMrehRYrltfFOtD20ksH/mX7gKs0SVY7UH?=
 =?us-ascii?Q?IEJ5Frm7KqFQir8lSj4svaZiM8D9dC4E8GZf3g1aqrNGPkT0VnoKeOjHPngV?=
 =?us-ascii?Q?0ediw/AIDnZcW37QcySrWq80jyqNn7EjWHf1vRzwKJvmXnSLksSIcEu1XaFj?=
 =?us-ascii?Q?hihEAfrrwoXdTpL9OylF0/UTj0WJlyHeBfh/X2mwH/T6pogAqzgSPN0p7WrO?=
 =?us-ascii?Q?XBm2zwFpryMDov0KhtQU6U3ZvmL9bC0Iju0v2DubROBo/xm+T8/d1C7Kbysn?=
 =?us-ascii?Q?SXHD5zpqhj8w39Q2TlgDAgy7r58LCiwxJkkBm1lu9nVX8gtwsuqgZ3xBLbtQ?=
 =?us-ascii?Q?lu+SfO/Gf+8o5vi4sM6jGbvqgb/Pju8uDYopu6A99EZFuXRjy4TZEwjtUNhN?=
 =?us-ascii?Q?quB4nsIvmwmDQdhZCUngtq3OB8nbhssZ8DRqnWYAAWr+RNwHMJV+obsp9Cj1?=
 =?us-ascii?Q?jUQrmaclpLXGATSnJBwhscuT/da5/MYauH1e+l1A5gwtqztiKKndjZcIsSQp?=
 =?us-ascii?Q?a/qQSpCS3wnYMxn6/UD4OsqTZJhwn3xmlt1IClE2Rw1CRUlU6cCWW/rZPWQ5?=
 =?us-ascii?Q?l1LuZYzVj774Q8GbSn94lF1NR4DVN4m84F9VVzrHKT+It0GM/ucWLFtNDZvl?=
 =?us-ascii?Q?ubM/mKlmO0y2u+wyN1oxjqmJLnRChDPjIY1A3nR2yk5JO7QM7qN1en7iGJ0y?=
 =?us-ascii?Q?SEOBWR6dCoHkT2TTbK+9ZDQ5dN5QyHa0lzTrDbr3UzyoQmVtpHix40XmJQor?=
 =?us-ascii?Q?b+UcCeAFiiPnU8StdV2Az7Sx9SGpY9L/T9k5ffhKQi8jiURkVypVNb8JVWYI?=
 =?us-ascii?Q?YpMzdBnP4LbJdPl7R2SeC+17olOYMKm11u3hJBgcl75pflzIR82XBMQBhyYM?=
 =?us-ascii?Q?5UBRaU/cTZaOUPKQaVsqO7w5Mbb3ea+ig+q9LzHR7Kdhm1eYodQPpXbuA9C/?=
 =?us-ascii?Q?Qizl6QZ66uCq2163qnrjtHG14MRvsMeABItWH/MBQV9a5uPJnCMtMGOgGU2U?=
 =?us-ascii?Q?7mIKjWsOxyy7DgqtHmh71rWc4g3IadTljiqlc7f2aoqjAoazy2beVa7PPBDu?=
 =?us-ascii?Q?Ofmiqdubp2oFOgi0Ey5QL+rXf5C7akBpBBwBb49+QfM5s3GLC/EuAj2U7O2z?=
 =?us-ascii?Q?ZinojkwFX0tVjCWTQfd/IHE+UjMymQxjnuSklb/lhPbzvwX6rrqaLxMZ/ivh?=
 =?us-ascii?Q?/Qfj0/hY+tJ89EXxH1V0N+UBQboB4GRonTk8KoxGLXO9rKA86mLoNc0i+12d?=
 =?us-ascii?Q?19+9Nr5eXpbeamAcxTfU7z2mHczVzixpoHjB58uaDA7qbH8nX6zYEIU/s20b?=
 =?us-ascii?Q?bXaTckor1E4cvghiz5QCFXTLZokDwpG+6m93GPvCTLzEKY2DhVZBmtFiSNQi?=
 =?us-ascii?Q?Ye5zLTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7WCKLHWwJL42jEBmhE2hTP38FqYQ6Z4HVEIuB6HcZMVDq3T6Hg/hDuL3BNK?=
 =?us-ascii?Q?UIJ/ZwN17hgaf9AEVZtyyi9vTWlp7b7r4CI56RA1usNhYChIlzU1qQU9ZJPY?=
 =?us-ascii?Q?uvNV3qYA5/itUopip0N4sIw/r30iO3J7WNWfDxqIZUGfXb6hrXhxNpvoIUHi?=
 =?us-ascii?Q?LBgraygRwlc45WVDItdBkEbuPJeWGjVHlPBDP2vNu1Uj7+7vnE9wlZIFGqkp?=
 =?us-ascii?Q?lOSs7dUUzT9KjGoHN4Sgs/SDWnavN3yEu83LFSvGGCcRgqGA1oc6XfYS5urv?=
 =?us-ascii?Q?ib1oPHex55nn2B9KnUiGDQoe7Wnb4WZ6YWEw1ay17h/CFi3fd8Kpn/KTyCwK?=
 =?us-ascii?Q?tcdkaJvPKFh7uXWR5jdY9SXjkxbl1mLRFFd+58Cbu2JAOjF8VzoHwzagQmyk?=
 =?us-ascii?Q?oCRDyImeSxJwgmQ+/tZI/jvri/33/f6g2Tgmws7K0XoCQBt/qd5I3TXbT1nd?=
 =?us-ascii?Q?4ZpIJ5BtxZc72I/Jz6JhC4drx+b8YVZQtmAOJ8Z0Ml0ORARuixvUB7rZOss3?=
 =?us-ascii?Q?rcNDggejutK+lOSeepuS/yh7ZhIC8+y7or6aOTPH2x5vW/japH6QjTLonDk8?=
 =?us-ascii?Q?cWOR2JvctM2fcXt11vDYLPl1egs3uOwjvZqrQjIetuN3M8bfJyoxJ6IeVIi7?=
 =?us-ascii?Q?/c6V29L8JXtNO0H1b37fP+pP0Jvf7lDhuKsOnlhPlFqlHgDceeCV+U0hiJWC?=
 =?us-ascii?Q?wW9qbNqms4zHDdjPhsgUJLlBDOAVk8I+meV2LCHvPbf3QGW39iaOaa+1xu+Z?=
 =?us-ascii?Q?+kO+XlY/ibblosjp539yo9IB/Pn6pbQEd9WwC9VqkkKBe0Rz7dLdFPAPHzj2?=
 =?us-ascii?Q?NIqeJjhH9utrTLg3G86o3cBIprKuNsVKoiv6K3ZDNr3pGvRqYE/ljIg0/m1T?=
 =?us-ascii?Q?p7lGw/WIyzfxywGa3/nRimGlGaQobF2DB9PdY6pbKrH/qc/ugiDVseTSw/m/?=
 =?us-ascii?Q?aYBoOYle6BGdahfUI4dxc9B0JjJo1wXAEN6lUgKatKfTpVU9K5X7Me/VHAfO?=
 =?us-ascii?Q?6OB0zvx5kVdEw1xVt8wInfSDNNAlAsx0Wx0rp4EafMp51xOFNFoSWM+VXpii?=
 =?us-ascii?Q?Ml/YZsM6kz0PfIN2fbKePZVDcN5iKOKmGdETW94FtWNTDSDp2LgVcitnrufs?=
 =?us-ascii?Q?JAP+eh3EgrwDY+8AxXoQtR+QmfIK//x8W/EaGdZP0vtxlF0hmCR7hErrII18?=
 =?us-ascii?Q?O4uTZSCKcryd11kUp/fI3A73IvPEdcKYMG7MvjvAGjN3GJAEtqxWkUv9OfXy?=
 =?us-ascii?Q?Y71bazH1RwpL8EylK/vw9RG7wHrjU5hS9to8wsXvWdDNJyR50BE6QZkO+EAK?=
 =?us-ascii?Q?ofx8UiaQFBQW6UPpY8kLnhhMptZLPfwqRZUIksE6jeeQPhcVAIbJQU1DGqk4?=
 =?us-ascii?Q?6zuZihkyGdL0tyidM9u0EgiUIk8Qn/OG/hKAS8Ce903o8J8xQpXWavsRNA2R?=
 =?us-ascii?Q?ORlbbXvzdfuBevblGt9OzKPIjJcUbjkwqgWTWkyWz7bjD2NvTezxtRXrGmC+?=
 =?us-ascii?Q?+5dS6tPzlVjo74FYnuuJcxLP2PN+OAwzVaEe0vGMs4cj9wq4tbDTzXk6mvyY?=
 =?us-ascii?Q?BJaK6Wm9+rj8BxFz/xIaJdyTPi4Vv+BQmvn8ezJGSwY01Z58XbQqxAMMajDs?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bdb648-7ff6-4e08-6820-08dd1b60522e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:24:26.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InIOYpA0576BZGcERTYssqbsb2apiVqrgSYgmNFPo6xcxt+U+gdCb66QNy8uWER5sgpnpJLxO2nwt/qZyte4RWfkEkJ1jIIivkI4YUWvlSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-Proofpoint-GUID: Vb9v7AovoJ3s2e475YVLI8MYJStEyZOQ
X-Proofpoint-ORIG-GUID: Vb9v7AovoJ3s2e475YVLI8MYJStEyZOQ
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=675c0b60 cx=c_pps a=Syk5hotmcjzKYaivvMT4gg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=edf1wS77AAAA:8
 a=UqCG9HQmAAAA:8 a=hSkVLCK3AAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=kJy0AXKTCvhfZgbxjNgA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_04,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=753 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412130071

From: Juntong Deng <juntong.deng@outlook.com>

commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 upstream.

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
Changes in v2:
    Correct the upstream commit id.

This commit is to solve the CVE-2024-52760. 
Please merge this commit to linux-5.15.y.
---

 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 268651ac9fc8..98158559893f 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -590,6 +590,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
-- 
2.34.1


