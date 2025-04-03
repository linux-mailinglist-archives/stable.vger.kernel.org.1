Return-Path: <stable+bounces-127470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F9A79A6F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 05:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2532B1892D14
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 03:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF518DB18;
	Thu,  3 Apr 2025 03:29:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340EA2E339D
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743650998; cv=fail; b=YH9TDkPMYf0ktyu8JkhLdmHO1kfTz+yyHjtRdsS4ppoYObZ7wh8o9No+e1cEjeuAlnLGEWUAj7rdgkMrLa01aZV7ks3547Nct7AAwfoWxvHZvKAVGUdSkiP3zTdTJ7WtXv1apk7k7StV3HQeSifyifueEHlMI276/rRpwIh/iV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743650998; c=relaxed/simple;
	bh=e9uFY78NRD16DxnUr5vp0zV9B9BoL2zBapKJXgGTQtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNv1iq6HCfgWG4UcqKgnDV87KJJWXmP06Ev24Q0WH2grkYgeWsB977+K7MX4xTiZIRJzi7mu7s0kK3R8morpCFFNMF7VZ4bMwKsoQkjlMmPl+J58BjPyL4XBXvCTdS5smKXKDrRN+ZPGXHSNVu41I5QFBZVA5KfxZNtYFyHZ/+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53334LC2019730;
	Thu, 3 Apr 2025 03:29:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg0q84vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 03:29:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTxXtm3uCjE4Sb30pQ8yFK5m522SML5AypQmXoLX36A4OJcCPDPQ7kWTrbNxmT1laBVsE4nUGmHSETrcs4cX3aHdjcX8bRb98+RiZnKnctAEPQbH9hmuuujVchsZr8pn9+DuDJjojx2RoiYq52SxQiUpXYd5fKj00XDgM338lCTgsPC/kxr5POT56Mb7VORUCF61Fqoa8y3Z5CqP+3vMb1dyPqv2r7h0Sl6Ct4icMfFwDZvh1t8ebJ7rdg58+5RDbQy0YNietUHrutr3/bPOim/hVRZDeMB8d+feV/sHtb6weG34GInMQj09mukMukODl4H10Tq+EYLS8L5VS53bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GbHT1SyVaoF86oqJBBf3X8ONoVnI3IcUurtG9K3u+s=;
 b=mI2qaU4VXLFD91tjLmE9XqroRW8qiVC+/6yqofL8j+o2obxQ2ksUMI3RBGmFAFv7z4w5M9dpJNvRhOUFb9q0C9IZHrHboAhIbV8QAyMch2E8FTxNJ+aTR2mYBxLc3lTDIvcqfDz2Ty5SQZyimot5nEMpyWfcs8S4HRh0ZEXTgLgdzDo7DaedYIy5yhdtZLhP4YBzVc3CwsuvHXTmkURFASO4kWWhq6h2W3bo/rvMkAYXhMlc+hLfZ61ThkihqWvSwm52aw9ofKVr7wM63RkhjucvgNGVIyrwbTi+Pd4zLim0c/b40VTUnFMxD5HTf/OKxySfZBUQyHJuYVLPsIV0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB8470.namprd11.prod.outlook.com (2603:10b6:a03:56f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Thu, 3 Apr
 2025 03:29:40 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 03:29:40 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bass@buaa.edu.cn, islituo@gmail.com, bin.lan.cn@windriver.com,
        justin.tee@broadcom.com, loberman@redhat.com,
        martin.petersen@oracle.com
Subject: [PATCH 5.10.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date: Thu,  3 Apr 2025 11:29:15 +0800
Message-Id: <20250403032915.443616-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403032915.443616-1-bin.lan.cn@windriver.com>
References: <20250403032915.443616-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e261c7-d54e-41ac-5a03-08dd725fc477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzjG7TyXXlVIZp1EGxdCvtYjJXR7taljqaIM28hHZpiXgLT8phrcpfi4hqjH?=
 =?us-ascii?Q?JIdJGAoNzMHsrSrXutomc3Av0n+gjxhxNAdBc1sE2rRQYBLRifVFOanAkarE?=
 =?us-ascii?Q?TJkDzxE05ZMIgavqzVKVE5fmt5JuFwqLk8Yrg3YCkK1Q6G/qcSqsCCEmmZAS?=
 =?us-ascii?Q?Rl5D5KyO0A+xTXZr+muexhtqvNaqthG2YqyFueHBnfmwgaBSqWODp2upXmgC?=
 =?us-ascii?Q?LvL9XJGTK1e9ceA6EEEkEJoYWDTUbGGlxQPpq4b+T3WHI+7XruWQKaL3AYal?=
 =?us-ascii?Q?9/lbXGkc9hHaC69cbGG60k+4SlRohFfM35wrcJg8bxFbKKdoZNqF/hrtYKFG?=
 =?us-ascii?Q?dzBLx+DwG4zk0HTofVEt1d5Ohy9NnYhK/JoHNXNav+hKQeeiwlhr0kbvtXo/?=
 =?us-ascii?Q?1MupGxwGMuzxzAyE5s1fIAhyAVIbXzlCaizUiHNyIy9G4D0s+THzgdWG7iUi?=
 =?us-ascii?Q?L+5V4wWHi40qRDjwQteXeEpl5s+MwV9wG8QGbK8ujKQD8qAvHW/fQkexa2vE?=
 =?us-ascii?Q?a4wkrHcw4VIRSvQMXVDMSLqQhIxDfcEDoLCYYU3vxosu6OHrw5Bn3fahsbs5?=
 =?us-ascii?Q?vqPras842/exvwwdp6PJqoTY7txuWWGnPtw1eSHfU7awbfo282CAjADkpq/A?=
 =?us-ascii?Q?j7PwMyuYBBtLoPdUay4PWCRkn9zpXTEVkgQpzbukM0d/8dVg0uocnjLFxwaZ?=
 =?us-ascii?Q?ZGZA4zZ3wdPr4NU8X+Ck9nwzyEm5iU/WZEHEqXe0+N8Fqm+KhdvG82Sw054L?=
 =?us-ascii?Q?BkFwb+YmnE0gn54LzW/Tt+qOV2FFL0c+L1vicHC4lxxWD02e53Cvk+2ghGAm?=
 =?us-ascii?Q?L5NHEqZDhD0V7wO0f2D5lI/utVbwBEZe/qkXntxEvrBybdaQUozM2n8kErqy?=
 =?us-ascii?Q?aAgJLdffegxxQkiuECtkzouZJQQtUXNI/UA69fIe0fEXcY5WFZox2jDLEPHA?=
 =?us-ascii?Q?vJPiUHzXcGpaSFF7ADKeEBSpZ9QwO4fkAOwGMMCS3/Yn8kgD+y4BKv8QS2Lv?=
 =?us-ascii?Q?lIIaCkctOW1hfXX+rRSA6P2wzbWbL2hUm6BqZL/QWRDob5sl+NrB9Z3HVKFO?=
 =?us-ascii?Q?HZf5nnIlrj3iIgtYdSXH8Om8qGAs1oJZNt730+ystP5+e4O+MTw2dWUiHHC1?=
 =?us-ascii?Q?Po1Oav92G+lBTsgrc3VExZ9mQxP7bOXS6G3prhzyCk8UyOTnoKjr/Vmskp8T?=
 =?us-ascii?Q?cEuboz+k8dVRjJl+ANB0vGQcNFYpmrcCwWcDJK/w9ezPXtmWp+z4gKjx5ycX?=
 =?us-ascii?Q?KhrhxJFXw0SOVxDUxUzz/Ya0LG1Uqj8vkOdJGhoxXS1k+H0+nEbbBkVd6bYt?=
 =?us-ascii?Q?eZZVra3nOF3n3c8dGhDQBZT3c/qxVvhqNAtEJh3SQMzpH9z/a+yKXxeV/b7E?=
 =?us-ascii?Q?tax/8PB+Et8f1ulk0YCBGOt1snBbm+0LgvCE3FOOFRPenh5a/JAZ3cyf+/M+?=
 =?us-ascii?Q?+pdP+qmErZwKzqV+I5x41o5Zt5lrA5Rx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtvbb6gZCtNNI8/cfItVXMqQ8tt9ohyAJ6+bXm5s2/SbZMN/qIQIclyyx5o5?=
 =?us-ascii?Q?1VRaN+6f0EbSrpXAqwgwRI+t/hXP7/WuvY+g8gos0Fe5Ogjl1RzwvQNGW5pk?=
 =?us-ascii?Q?xCSSsMK0swMysKC8kMKZ5q11s6NrBmnz2DgCwIc3EC/pZxqI67XBMDq6vZp+?=
 =?us-ascii?Q?YR+NqBzfsu99itkqL1YsD5wME7d0JSZLCu8B/7oW3MdoXmq64vbElNiAp4YX?=
 =?us-ascii?Q?d8EtopwyBIktMjqINQZLeqv+TY8/2QHB81sw9mhEc2zsp5/xfv9mE713lFze?=
 =?us-ascii?Q?nUJM0GZ1KAMbsrzt68HRt8jrCd2+eYLl0r8ctVutiDKMMPdzQPIPKFq0Rnga?=
 =?us-ascii?Q?/tTxwcMjvAcczeozrFROberxNy90Bwi+y/8O0AYSfjnIfPBUn9N8ojZQZjEr?=
 =?us-ascii?Q?BpnEVSYKcWzqtbjKWnnK/aB8dg1UXGpt7qLT3IFxae8f9d06lMpozEgq85i7?=
 =?us-ascii?Q?gaLRUDSOgjHU+2S7Z16uFEMKpErFDXZkWGms6V03I65YCRYxnzJ/OMIQCgE/?=
 =?us-ascii?Q?YCBa7MoGI/i3BJPpsWKzVTQxy12U2pa4o/NebD9ilVwy2sQ5vpxr+SDtqKrE?=
 =?us-ascii?Q?JoODUEuTJ6zMBEdgYUFV0M822Hv2YuT2xML2LOtl2AA9aOYzSm60kU8r0Rei?=
 =?us-ascii?Q?Ol6WE6tDwJ3qR+gteHH9RwElIrSOiF0AY+swWLvnujC8a3YoVhndAt/zSBGE?=
 =?us-ascii?Q?cpSJICmf21GphRvHJFG5A/UQJgbkcI6xZ7wqTMEIU5oF9oyCvFGZHVNcWgJQ?=
 =?us-ascii?Q?MRBElA6qiHrQX26S6iXxgFUINyCRSHgC91XDpcri5Lwetg5pzXRGEbIogQxE?=
 =?us-ascii?Q?YcoVfckaVcTdbtrpRlPlGXtxLxm4Dl7vyDOms/yxkfQqSKS5mCfyUFTdQuWI?=
 =?us-ascii?Q?DdRpXONbIruPj39Ay4lDqGHo9tDeuBKVIqQ2nFqyLqx0hNJIixPT1kwvH1W8?=
 =?us-ascii?Q?/cOma6ZTInQDmCgGREAkESAm9oMKdkmEwmNNYjkrDqzppuDCmzOV/Qpe4o1a?=
 =?us-ascii?Q?XfvYuXH6yeSMr5IZ7oUy/e3zB0Q/sIZ9UvO/6O+nj7VjAda7w3VEsUlbG1Ix?=
 =?us-ascii?Q?HOq+xuFG9l5Wz0LyciKQlAYzT1v80BHGHHaY9SKiKTkr4SimGw/s0XuTn2V5?=
 =?us-ascii?Q?WADxeR9DV3kl0Ul8mtWmxXzusBR3TJplSDMFroS9ymlMIlfOS4lWb+shDIiN?=
 =?us-ascii?Q?2IGIyh/EA9kpMuJg18wk3Om+ym0z2yZJC+5bG7i7WK7s4CK/a5G1Z31cF+Fa?=
 =?us-ascii?Q?7Yb/3uZdXhGHjr7VtpBr8mG+VgZMWO6qNMBnySNC09n2/vexJRtVupdiPTVQ?=
 =?us-ascii?Q?sfmb1o6vCWIB+TVybyRCYMYCMLXrz5+I4QKqER+tXja1KwyXQZ/elKdFLSU3?=
 =?us-ascii?Q?amU0AVr2mM/k1kbfhMlSCTZdwbW102jYUQNJccf2Gae7YOJZ83Twoyo+vruJ?=
 =?us-ascii?Q?B7D6ocxKdzswKDyqqnPjic0pFMwvY3bxCvSOxoLRcAmrkEcwNhfA4aZzaKzk?=
 =?us-ascii?Q?ib6BzaC8n+hx/QrvK7QJAz4HdS3nQpsEiSztCy2AlInyOdbz3IG6DnroCq5A?=
 =?us-ascii?Q?lz23A/huTCis2FZlhdMa+2O9eGhzYoVPUCFB9urDBahGLUmcWRxtpvJHNgNe?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e261c7-d54e-41ac-5a03-08dd725fc477
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 03:29:40.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C1fNQ11MWd9e4ov/rB5/aI7prBAfJ4A67LZhM+wOZ0mETn3TOUJa9CqBpmKWLHk2ixkN5hBgwYkJOX9XlMlkULjCRICy/Cp9Jc+5sZSOh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
X-Proofpoint-GUID: 6-FokQQGDSBI8qrqAgTPCbSDQMW6j1vT
X-Proofpoint-ORIG-GUID: 6-FokQQGDSBI8qrqAgTPCbSDQMW6j1vT
X-Authority-Analysis: v=2.4 cv=G+4cE8k5 c=1 sm=1 tr=0 ts=67ee00a6 cx=c_pps a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=xLZzXQ5yfAxz6kcK0vIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_01,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030016

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 0e881c0a4b6146b7e856735226208f48251facd8 ]

The variable phba->fcf.fcf_flag is often protected by the lock
phba->hbalock() when is accessed. Here is an example in
lpfc_unregister_fcf_rescan():

  spin_lock_irq(&phba->hbalock);
  phba->fcf.fcf_flag |= FCF_INIT_DISC;
  spin_unlock_irq(&phba->hbalock);

However, in the same function, phba->fcf.fcf_flag is assigned with 0
without holding the lock, and thus can cause a data race:

  phba->fcf.fcf_flag = 0;

To fix this possible data race, a lock and unlock pair is added when
accessing the variable phba->fcf.fcf_flag.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/r/20230630024748.1035993-1-islituo@gmail.com
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 68ff233f936e..3ff76ca147a5 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6790,7 +6790,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
-- 
2.34.1


