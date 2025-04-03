Return-Path: <stable+bounces-127471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7CEA79A70
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 05:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F6D17210C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC618FDD8;
	Thu,  3 Apr 2025 03:29:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D2178372
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743650998; cv=fail; b=FzNbkBKrVqtaDGeWs6fYJWYAiAu3lHBHt+yu8km2NVjwcGQlZZfTtxnVaSvF1er+xgZUjB5+TCfpzQkkMCLKduld1efayeDJEFZkX68QgFr3CFBWTO6ZTdgysAZxPM1mW7D2swu6l1DLcCJwrKmu7wn+ODnTwxvXckMUh3IVfE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743650998; c=relaxed/simple;
	bh=lasE/dA5NL9/d0liGcb5xRrQxr8cxSmZOtYR7oc/Y+8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tvfAk4+KtMAKx2IQiTaZRJ+WBkkMs6kN46RwL7VKvG1fSXyPlQKXaeTx0+QQZp2cAQmaxXSpjyyX7RSFLsRLRikFCNq5jUCEk9WJHGwORBiSNZb7HvEDchEJukVGmeQ0/o49vy5919UAfuIn00VjfYm2sUnnyVMF9hh2gv8VyvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5332RiDL032209;
	Thu, 3 Apr 2025 03:29:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg0q84vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 03:29:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBCr2cznlN2RJhpyKWd+Y8Jxf7HPhrrguWUSgLjnqvkjg5OgK6sJTVuVe8ZJlXw41esayjit7pAiUSsR091+z8p927U1H0WA/rd8VM5TpCVZbSgtG0+mXI/Zu1z28tnJmHVEwtNbcSqxj0ryDDg8dX3ZWN8UHMORxSfcemnAK4X716SIt75eCeE5UsOp2DeFkuqba171uzbMU6rXc/feFLaV85GXgfBpbfEQmQmRmroZpBaPU/AntdA0oMlNkxV2NYsyo8KL0p9RstyLOt8Pht+A/mK37zBrWxL8jCQF/yTLZazGPC/3NmpOwtuFSgtPLSkFMmXsoJSAPHgd7LCYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hEMh9zR/ulR+EqyN+yTToKfHkwaY6gX5TaYVMXubYQ=;
 b=KnbXj/DRU0ZSIjkMeETtveuCAGC/+z8kRFYNNX2sje0AHCBsPRc68QSOiu+ONtOvF6CNhM2P/e3HRCVboHI/0dr3Ga7mz93HDM6K1ha5ITBLjBiZQAEivN+4prx47/mL3fNpxFeRwgX46xMTmc08TYqaZPBgB4vg1L8m/KxZUovVGgzAFs9mygKy6/uhUEDxCr+o2eS8kjxplS3EM4Yndkq88YHgjWGW6oDO3O/mfjNtXVjAQw55OUuy80cw+v+mtEr0CNArqdi0r5hNBqk+/30XhUFhaxjRNl4dhiQwU2l32jyidCBcprejZev4+1a2i1YLM+nETM08BlGBmU03PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB8470.namprd11.prod.outlook.com (2603:10b6:a03:56f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Thu, 3 Apr
 2025 03:29:36 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 03:29:36 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bass@buaa.edu.cn, islituo@gmail.com, bin.lan.cn@windriver.com,
        justin.tee@broadcom.com, loberman@redhat.com,
        martin.petersen@oracle.com
Subject: [PATCH 5.15.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date: Thu,  3 Apr 2025 11:29:14 +0800
Message-Id: <20250403032915.443616-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: a7947984-24f0-4579-490f-08dd725fc277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZtL5qPCqb7SSx//3m7XTuiDmHVTsACHDvDqTLG5pquk+Ndh/xx03/adUgzU?=
 =?us-ascii?Q?7uKFzY/PtO17XWfRk1/2HlT7bm7JAEubWO8jIkHx77GpKS9sYKsLtHaQGJ3c?=
 =?us-ascii?Q?fhnVcMaJ8rE5u56EcqFARkphxVllW7W9sKyazTNa9J5Jvip3O4C2PKPezzqT?=
 =?us-ascii?Q?UAOQtA8/KDxA/vlx7By9/6XTgrNkxbT1Wfw43nTdK9vAiXGbVvfnFjHwNN5Z?=
 =?us-ascii?Q?JX2X7jXmBROt+q+GLMh88p6W4tqK2/wqerKgCWTYfW8Ft1/gg3SU2wEtHfvS?=
 =?us-ascii?Q?nWXzLrgla5ZfHbCLJMR5NgXKa/Y7muN4F64ovK60Rgx0Mk2NSd5KU1N5p6Fy?=
 =?us-ascii?Q?sS69mVDSK5yf2mF7tfZRmKcsWFiOPq0/R9alx0r8/UJtWMgR8e2FRfZwFO8h?=
 =?us-ascii?Q?1727zY/2sf2ylK+IiGR5MIqR98rS7zqj14dMemuHc/DuB/ogK086vnNlwqeS?=
 =?us-ascii?Q?14i+e5Bm3bvq3mu0Tg3q76Qq1/E3jQsp0pvBigWMmhHImnkf1YhBvslixOi9?=
 =?us-ascii?Q?4Wk8ZBIKapYni55uu9SZlfeScWKk4ywOpe27+jAn/bzo2bIHw2ZuAvHHl4Yt?=
 =?us-ascii?Q?5nn1AURdGPGcEWncRI/b8YVML7CPbIImfopKuqbN3/mLfeZ9Nfe39h0tB0hb?=
 =?us-ascii?Q?y/Etem7r4r28fa6r8mcvi2K5CyuHMEdlxaHKk/SI60MoatE6nA98G4B2/3dj?=
 =?us-ascii?Q?DRNe3jTB3p6jXjG5siNQAbe/OM0mQA+MIzZDoq+n3Obfetd2lvWTeBQJIaAY?=
 =?us-ascii?Q?ADhW6RuSNnAaxA7N/nWn3Rk6C1hWGIXvi8u94yaPWN7oADATje1x+ppQzCD1?=
 =?us-ascii?Q?8/rFiCNQGS4/fHmlsptkvhA96O2YwjqTIVW3oD8/Ts3QJMf5REJzNPk+Uvz7?=
 =?us-ascii?Q?RMmjZV9nRzeQzXywMd67OqlhlDpGF49KWcl1YdeBHC0rdmoGI9+dGrkWLJil?=
 =?us-ascii?Q?/gxD/QPYvOhmdqTCs72uY1ii3DTkxS2vvzncnYKrmQNEKyyT9OpRB229rmyB?=
 =?us-ascii?Q?EmHTrFfg48K/SVNkiz0o0O2mezLkRrELb66le5FuA+PDzVe+x5E5Yl9NgdtR?=
 =?us-ascii?Q?njHDG2dFs278zopF8lgiMp/+FQ92ArgkI/ujCine8ejPc2ieKkJDUhlGcYcg?=
 =?us-ascii?Q?uD6Q7499k5dqeX/YPgbBUzWFZHzzLdJ6BcFsKmaDguZfMHf8uCnRbtkak4Xm?=
 =?us-ascii?Q?KwjgdLFgxt1EVCKdbOkld2MXddFzm/Ig39wAMvxvhQrHwXLF3HJ+ZKZBhxHy?=
 =?us-ascii?Q?xIdDgfmA8qyC5iFFzSv/Eq7qv8bnkFW2vhHKsqneNhiXf2jDsw/xdyKbAmzv?=
 =?us-ascii?Q?smWqtbopBQyvyUtLAODaNgX6YjLSY323a7Y3fUVJ/G0ERU1TqhBKzVl/nj2u?=
 =?us-ascii?Q?ra+OJOy67gz0dFjCbPcoXxm0FEQ5Q0tSYLt0jET/KZZJEhSa/5NOheIGvHVj?=
 =?us-ascii?Q?eJddSQr0iX2NL8hZmSi1WR1/HZMujua7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwhb/wr5TngNGuN3WRP1zB5DOhYRZY3PeJjZP1stq4+VaH4aqrUBkn99Rmsd?=
 =?us-ascii?Q?JleodjCnhZWFdBn5WFmNImuRLlgTtW1vrs9bhSWk47ztK5owi6U/ZQ3VuAWb?=
 =?us-ascii?Q?5yPbdEfl8umMqsrCyd+GiruWeonpRr33ejYbThc/AKUby04+E6/EgJhYRH65?=
 =?us-ascii?Q?IEonmJOuR5pK5CAwi8XHwHn5cM1R6tOAeG+sTOFKyhrxGLV9psSnUw6LNj0/?=
 =?us-ascii?Q?29aFMo2SOOEvZNen3Ajpm1weCVWsEgbyMrx2RCkhdXc0Oh5CjwPUJ+1MmVMu?=
 =?us-ascii?Q?wZUXravVttEcFYu4vy03gi02SCnHcLDqG4aER/hNzlw2NPD1EDqQDkfQ7biR?=
 =?us-ascii?Q?dZYT4RLq6u44dgGYgHO1JZcn11LJFWyv6S/NoSISxKKXoessckpZhhNS0c8T?=
 =?us-ascii?Q?X2+EklxNJSQVIcshadO/PbUaHGpa8F3qmV+lHp5PQA/gDO1C1Vo3R6/2sQ4l?=
 =?us-ascii?Q?V4JMw1FM7JOpw9tXdx9bHvDuDhjOvMo9rw3GgA7EcNYGuoj5Fp8oXZ/Wreio?=
 =?us-ascii?Q?u2BNHQqgDgtJlYBvITkIa3ZHT7ChcwMCE+mj9PNt3yr/XctantoSqinixK1N?=
 =?us-ascii?Q?nXAb6JqjXV7uuIxsQg4suk6jUYAFmdLF6UqNVhQy+Fq9p2Kgo76PZSaZdnq0?=
 =?us-ascii?Q?OLOyO5UaRjiBpppR3WKY6H9xeT6sAfXyWXQk1fFSbt0pSQbR+rBBdVn8Wxzl?=
 =?us-ascii?Q?nd90oNUFgOsncEJfzBJ8HVN4amMad2Wqz26fyYOTyQYfEu7hUO/RWzijOvOA?=
 =?us-ascii?Q?eVWXjp8KTYF/ekW+XsRdfdCRHfeBeSkfr46GMN1Oks6ANMHBTkEA/z4csw17?=
 =?us-ascii?Q?M6f8wxtZDyfMI1Y9FhzkbFqvpYThHv9678GyMBdQn0bFVNf8RgsJZyf2ZSBZ?=
 =?us-ascii?Q?ySFy0NvPAy9tKsmVx3J6TGAQPkFxTcO/ptN4MbjvjnD7cOW2ZbXMUyypMkcB?=
 =?us-ascii?Q?XrIAlTOFeUae7FlX4cc8AkgnFrBJJIuJJOIMxBLwxQN50SvvujI+Cz92boap?=
 =?us-ascii?Q?wJDfQ1cajSwf0sqXCICygQSucgJDWaqLDAsxM9ijs98vMOfWDq/EpNMMwsK+?=
 =?us-ascii?Q?2zTGRWsV9m1vDkQK2/x4pgHYCXDgLOSBKybecm+TTBexAOJt4MMiYyb3yUka?=
 =?us-ascii?Q?uqXX2IBNDNjmqfNYGQ9AYFAehnUKIaIbY3+Jwx3kD/KRtdC9JSWjF1LEnsaU?=
 =?us-ascii?Q?SI3aeNMHSRHYdv6K5pWgVX06xKb4L78JQDXhN4gP/0PQ9QbnofygBGBaDP8z?=
 =?us-ascii?Q?Cp4BoUAGq+zxanCU1MTGrxyqx4Vle6ecl+EkEg2ZDV8+MxtGWLXMAriS/P2J?=
 =?us-ascii?Q?Nyc9yI89cTmbQce24nDaC4BGrCNw4CoG6MPThLColuXWP4rmkXs0te6Ne8Dt?=
 =?us-ascii?Q?iUzgVOTE2wmj+s/TrAgERLkM0SeKlJGgnGYfIHPDbQE0JLxf6PLEJMUtVCGz?=
 =?us-ascii?Q?SERMU82WQijn0t2RwQTLWsjW989KJBG026PQkS4gcHujvKwcQUkZYPYCrFJj?=
 =?us-ascii?Q?JlaRyQ3Fq55Qoj85kE9FJUBYFydah1OYz9IZZ6iaVfQvsBL8miQ+1+h0b5ZE?=
 =?us-ascii?Q?gv4GVOCJxfPLVvH3OAKrpF3HgR9jOqKQJL3JiqmGVuaHWmmX9aioy/rNGxzB?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7947984-24f0-4579-490f-08dd725fc277
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 03:29:36.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMxm4boCbm3pnX96DI+nIxFbU7epEby0GBBMAOyrBfAkohjWDB7ocIZWmMO4H8uLqWq4rR4jb0jpuseWUdJaLfz1ACLsFJpCInGdLNKILaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8470
X-Proofpoint-GUID: PNaNYYzdrSNW9UCAVUlMti3MxDortQLr
X-Proofpoint-ORIG-GUID: PNaNYYzdrSNW9UCAVUlMti3MxDortQLr
X-Authority-Analysis: v=2.4 cv=G+4cE8k5 c=1 sm=1 tr=0 ts=67ee00a3 cx=c_pps a=nskeBUqQUen4dZUz4TdP1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
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
index 4bb0a15cfcc0..54aff304cdcf 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6954,7 +6954,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
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


