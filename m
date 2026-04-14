Return-Path: <stable+bounces-237716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHeGGs283WmCiQkAu9opvQ
	(envelope-from <stable+bounces-237716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:04:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C2D3F56E0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E723025C49
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F34313E38;
	Tue, 14 Apr 2026 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="mNHP/ZeL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31D2264B0;
	Tue, 14 Apr 2026 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139455; cv=fail; b=kN477HqiEMasBMxYblAe8a/mxEevZjOcnmhCL333lptfQNXJ54Fr3bTznjfWEV/9YZcf+2FHWtreLIwjgpnylez4rle4hcuqFTUID9v8yXhBvuuv9CUO+1oV7UApfdIbkGrstwGJiupmY9cJw3b0hevOihK6cxYeMPcSX6khiaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139455; c=relaxed/simple;
	bh=6uk18JC+SKGqWONztKjq8Y5ifF0DNRCm/V04Dl8OCms=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RmFQiCAszmlH97org5duRMo4SZKBrLd1VF7MKYn65rrfier7InKANcaFjXrWxR/FFMHBqy4p4pCIY1ml+ke5+6y7zje/4xkC4wi1uuw1YRyYrYrWiovVbCPUvAazDkxcAfjO6e6TbcKoAHb56fCrEKvoy9mgTlT01mMCM/RHkpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=mNHP/ZeL; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E2xgEc3873688;
	Mon, 13 Apr 2026 21:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ujBPgDqQS
	iTTKsRouhjvnJAu7S1pmci1j7OUBr5t3Qs=; b=mNHP/ZeL2tZXlnMQACpi7OyFT
	F2KJfw3TPvR7sON69tS3d7ea5n73avWzfTwgU0P53+dq9RYWVX17DooFbvTetjNs
	HSdFnn1XRdDKCh2ECLKPemFAmGUOYjqohpYLsRWCpOQI4RUaqOtehE/mZwS+2eBn
	rLyon5UOw3DX7B7M6y9u+ccj83oLA2/7pIbBLy9kSJ2ihWb/ctjgmzIRjJqVPL9O
	HrSQwq+9lOODH6n2hQGnm+VBeD32Vj/cdl/XRlKT1s9rvW+HP46lmvFzmgOEA6OW
	vs42GH01d1eqFU6zlSCR5sQAuAn0o19XztKQ7BMj7UDh5KJ7t3lHzwA755b7g==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh86m88ut-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 21:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLPW9JUv+GWjj2PNwsyPMqkawG1wbdKHfEiHLizxgfqYfUc9UYl9QIvJuBr8XUu0ZuShJRzdz6Xqb4t7Oqo9twrOCHHeh/dFaYMvRBICM3CgX6SFbCBO1TL4ZpvFYAdzUO+993ew69B7QUAMjV7emxZCIS9oKrUv3Uq/qcPZKVK3u0oOzOsz1ox9SRFnmiFuQkRsbXx9HkzEblEGdoKl8WFJOrd1lMtk6Ftjg1nAmczpLflV0igfatZ2sdydFu575tpIZ8KcNohr6flpzLi4sb0HBCifxIEK7KEh6MxR25MYm0p/2bIxihOr4OSQGyyVLgVHdjvfmVbPEmlAcRcd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujBPgDqQSiTTKsRouhjvnJAu7S1pmci1j7OUBr5t3Qs=;
 b=LWkhg9hsTGV4UCx5dGEec7kesgIhxqq/0TeY0zJTZWedB7d1l2NpkQBRRpCYP6y5ZaoNMVlRG9wfusH5Yrmvur6aPMWIduA0wgq+b7E2VCnL9p/a81DpLMSq4ILb3/P9rDkPAqXkkzl7x6UzD1gd4Gk/7XXaaDwXgCtk4EcOszC3/6Vk9fi23aUJc+ATF/OEuWLb7htrHyvBQzefcTuWBvBRMH1t+lwDEZY0nF1UZ2bKRq7H03VLO4mO5RXikfN1ksVFeevV+R53t0K8jEPwmAF9e5E/Vt6NHqEIKruR70XXIKrphTzMzmhhPzooRDFnO+/Oqbr1qNwc5+8jw3SgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by CHXPR11MB9649.namprd11.prod.outlook.com (2603:10b6:610:2fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Tue, 14 Apr
 2026 04:04:07 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 04:04:07 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, johannes.berg@intel.com, netdev@vger.kernel.org,
        regressions@lists.linux.dev, miriam.rachel.korenblit@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] Revert "wifi: cfg80211: stop NAN and P2P in cfg80211_leave"
Date: Tue, 14 Apr 2026 12:03:49 +0800
Message-Id: <20260414040349.2974854-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To CO6PR11MB5586.namprd11.prod.outlook.com
 (2603:10b6:5:35d::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5586:EE_|CHXPR11MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 902c5bf0-6581-4ebe-7d58-08de99dae006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yV0Pl+7Gnu+jiG+qHqJLGcPRE43E5h2cZ+zDVPgVksCy7kH4Z2MnBlUNeyO853sqedmXF++TVI8fk5wfmja36lLPuflXIPrQ8pJP9c8Ckjmlqzwsug0Kph8jH4qMXmQD54ZtegFYZcE2SwRqRXk+FwIFeG0rMtV58EMuslNK4NK3QQPAZLRPm8UnDAVi9dst2ORTJqjeQUCsI94sSimy12ccaN584r6ZkLsWzVNiONpKEjeSCIaSNZ26YEiQWg1s834rFrnn3Hu4Pt3D4JpqefTS6YOHkBcHKir1RdXV6F4N7n9aht2HpX51Nd6WFQByTNBSgItQQtRoGVXupYDhpnWLVBVtSSBl9xunGXVn340lJY/0gqCUT3GMKKZqdAKN4TQWies3h1ntqZeFn87fiiZR7d+6lmjlpsEusVEuvXD8mB47xw0g68zUS9ADa2SEhhAWz+cLbDGYIguSCvVIGr/pmMoBbSLyfYvJWyuDZl0BZzB1/c//bjhq8ecOa2ZhRb599y7HKfq3XPRHk0CQTsLbCgKpRqO6XNTUpt5RJLnulXac9Vr6uzASYvd7Puwb3EoJMu95d5JqRspvOjCP1qx3JD1VMeadyxNPjNpu4vnxny5yfnSvBjUPYdPHoK5lMfjm5Sozd5jLc4Thy46iQSQFt85LyxVdpXWlb70MGKkVK3sGzE71tYQfIMddfQasOYlcl78YezyQEmAuvgQFM3hzCuoMrooKhEo8YjWgHjvunO11E2pr7KfA7ABXr+0dDfR3fzmbqKNSBynvxTjjGzas8UmOtr+Sg7Q6wniJawE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOTudtr7pFHZnyY/6DBfvZZpGHuOFmn3bV0zeLvl4tXvbXzLxaxTnux4YQcE?=
 =?us-ascii?Q?uNS/TPioJmNPDxGYvLkFh5DtQyAhjmitk+xkWMZQF6hv8YlmqEc9D2sEXKDX?=
 =?us-ascii?Q?/KcUpnKiyTPtAe2vXk74PfcaUQ6qqXiqTme9p/ztPd33jvi44jTnDGKxM8c9?=
 =?us-ascii?Q?5NuKiWrGJyS0U3WMdRz8oqB/eWGwcbLR8Kw8a6eRU8rf4mie80re2q1qX+6x?=
 =?us-ascii?Q?jd/pCdnf/FTry1O/MRVwYvCV3mQ9C9EZK3rPeYnZdmjZTjjSuo+xEZc11LZ8?=
 =?us-ascii?Q?S0FNHGCDn2rc1jm2lqE8XMsk6N4S1hWpX2QxnvRwLEkElqIkihW1xbzsQjoa?=
 =?us-ascii?Q?KL4pTQK1jWb+//taIblwf26PfpPQsgIZKL+PLrKb6Dhb5hhwYyt98XK/oIL1?=
 =?us-ascii?Q?DQlJV1+nSErr/0cV35vcTzxIfl98RA0phwcfyJLDtvb4M4DO/bUmty3Xh1AW?=
 =?us-ascii?Q?S5FFKpFZkbiIDEKAo6If3scQys+LgBnsarGD6dylcalX1o5v6V83e4vIyJtQ?=
 =?us-ascii?Q?HBo2J5ZG0DvTcgHkQq/v19heJerz0TM/uiF4Yqu/3zT1lrx5G67Z4ebeK0wk?=
 =?us-ascii?Q?bSklRWawkdMjGiKFl/Py8/fJh2inCTd7R38rkYCqQoZ4yiqavWzSlPTwrkYJ?=
 =?us-ascii?Q?s3ZGRrh9pyJ+Z/bUfm+jVrC5WbiC/mOihAqmJB+YyOhHp4lgDA2hZ08v/UYI?=
 =?us-ascii?Q?fRPd2KfKEXHeTg0Ww83YsJegEB2rLjIbgqm1JytvLpQQNExOxtt+12H7zeBO?=
 =?us-ascii?Q?HIWgqcv0arWwa6t/1NrlIWQvE32XRTmf7pdJ2h/zeXpFrZn6sgcGMfeWEzfm?=
 =?us-ascii?Q?YPTPU6E+7vRKzvYP8TSJRUaA/No1A2B+3r525vQblU0FusHjnA+XMVe5XLr9?=
 =?us-ascii?Q?Tpbn+0BXQF28DDI9GDr4wSVLyCmkPDMmo6Ld5LRf3xe9BAeJsU4SqXkeFFql?=
 =?us-ascii?Q?SxfjnTYbKlvYKJyh3TNWJ9QIM1yb7IuZrwUxynFLGvG+Q1Dm1O4T1G1TPEW3?=
 =?us-ascii?Q?ZUitzYJkcdhVRaa/2tklxHFRklWow4SD7TFg9O4jyd1PLru0if+IzS8yjqzP?=
 =?us-ascii?Q?Z9n1VaARCF6fmbLi2j305/AFxQrUNGXVJUvB3cmQa4PC5xlv6z6t790cWOMM?=
 =?us-ascii?Q?CKw/XgpV/aNHKiIq/qXoNRVOWNCOnGyaziX3SRGcsFxp7tf2XuZ0zcu3pJ3n?=
 =?us-ascii?Q?2pQKkX+ghL3o5Y1/svDoM1cgfUcYr6IExSyYTS0DEb3PQPTF7NmBBjYc7SkV?=
 =?us-ascii?Q?8qxeVC5OIvLnfMGHbGhGRY8pDN95OVT/z4dAlNUIZI1oEC45PN8fAJt7H3lM?=
 =?us-ascii?Q?5yFXR01r+zI9z4EHK080PJBFQj71+7wjPAx9JsLtuVPq7wdrfOf1G8+O1mTe?=
 =?us-ascii?Q?jlv1jzqvhsdwovVTp44eGpSSRzcs0cPr0i9piZXr9eb5w2Xr/f6lj9+LsMvL?=
 =?us-ascii?Q?pYumyTNvjTv4ZfeME8Rs/TE2PqFlxk8gCuSdN+D7ZWr/RR1JZLd6Lyk22XzD?=
 =?us-ascii?Q?BIM10kMEL0PcGJF/KDFumWQnZe1zAi2liAng90chfn259xMemnsM6yW7ViCi?=
 =?us-ascii?Q?Xr8LwYzI1Bcw4p2y5N6bJV38y9CmjWOG7OYXIS/LHmv2jpSYZYdRSnL7HM6P?=
 =?us-ascii?Q?dlKQqRSqTpGObsgrRyMKu6kfE1ggrJzm+m51n9tmEFDquBJqolJHFnVcqvH8?=
 =?us-ascii?Q?tqLHHdPPmJDPCIOhHXxvvXlsRXJMWKogbd58DdoQFjqck3ZYFP1NpzpwkAvX?=
 =?us-ascii?Q?naP+gn69XuovuOl3bhFb9dS+lMzK1yc=3D?=
X-Exchange-RoutingPolicyChecked:
	myvSUxwPKSeKTb97eKDrKjFPx0TrGzBfZJtnW9aQDzt90AQgoMnCreDUC1VWo9fkqrgoZFChbIBhIPZ6mk5tl5dj2VSTvhDoZHD1w194WDCvd96IIZ44Wd87XCGANd/K1+f2ucuQusUBhqkt2npky5Ho+QXPUilZsvLrUxQzpE1g++7mP+dcZzdyTpkYOv9Eg/rG5oxuLHLIVi/Ar+wU4Z4Re82wuV8UJkwQRaSdnrItOW2ZNgqpM1qkVHYV2NscmSUGrEtIie7QtXjb3o7tPQyOnzxxVqew8togUzYVTwWMhZCWIU6pQGRIvgVAK9NaNS+tPHiUWOFhol1VabEpvg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902c5bf0-6581-4ebe-7d58-08de99dae006
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 04:04:07.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ob8IwtqI9yNdpIv7hb2D/+zM0d6h6eDuIXQ1ESQ+wEot/TVivCukwdu+hJBBCI4ym6b0EGdvzd3bGhs2gSiwgiEYuGKqV4CIO19QOaaLp2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9649
X-Authority-Analysis: v=2.4 cv=Q5riJY2a c=1 sm=1 tr=0 ts=69ddbcbb cx=c_pps
 a=N6h9FcIU3O7PIE8+NyeJww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=uYzaAjzinrSD3RYvTswA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ZDX-hy06XrG50ccdu_TO0idIEHKuc23s
X-Proofpoint-ORIG-GUID: ZDX-hy06XrG50ccdu_TO0idIEHKuc23s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAzNSBTYWx0ZWRfX3EuuR82yX0/w
 ptdqEOXAiP9RxIvMvu0rs1BoT09XXGEE+a2cghoMVmKTYPirqcXYc8/pHFEG6jPGBDzH7mKmRQq
 zLRBggTK0UL9Z+jxruOK5vpyFW9i+7/tHz+/i7UZUVNxYnN8wLHZgBG8fXtjcFabnYyzFmceIFp
 fJVagsawHKFFTt75cPiVtnqYhfSbgNfDmXr0xD6sS7g/nDPFHeNCSr5agE7J6PoYlxEtmotHBu8
 AhOdTU+MMZa3ufMIXKvHKiFWAA7Qb0mlFysyQ5FSZqw0bYgdPfcerSr52oYuw2QAExDDHOmm3K8
 U8gKaDilYg3m08STbqlVnmxR18O5wPM7hifvIhkBzKzvSlSKSbDBGU/dCZxPJqSTUH074kNffoO
 BGDoxH2RxsQembJ+n0LabmWDs+xTzYh+XdpWb3fh/ZSBBLhApAQsZ1Kl3jwjBqfjJXj+UCX7WmJ
 8IPqK+P+6Qg/qhYXvqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140035
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-237716-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guocai.he.cn@windriver.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22C2D3F56E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guocai He <guocai.he.cn@windriver.com>

This reverts commit d91240f24e831d3bd36954599ada6b456fb1bd0a which is commit
e1696c8bd0056bc1a5f7766f58ac333adc203e8a upstream.

The reverted patch introduced a deadlock. The locking situation in mainline is
totally different, so it is incorrect to directly backport the commit from mainline.

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
 net/wireless/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index cc2093f75468..3b25b78896a2 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1207,10 +1207,8 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		/* must be handled by mac80211/driver, has no APIs */
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
-		cfg80211_stop_p2p_device(rdev, wdev);
-		break;
 	case NL80211_IFTYPE_NAN:
-		cfg80211_stop_nan(rdev, wdev);
+		/* cannot happen, has no netdev */
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
-- 
2.34.1


