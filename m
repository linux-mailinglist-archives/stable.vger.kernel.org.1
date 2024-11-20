Return-Path: <stable+bounces-94091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBB9D328B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 04:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FD7283F81
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6A156649;
	Wed, 20 Nov 2024 03:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061840BE5
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732073349; cv=fail; b=CU8zbUFGwb+KOAmPArWZYgOn9c1ldjPUDQDqFvA4kyjWTQJWSLn8XkP0aXEDToZeThP6S800HYDirWEpPmRd3Ua1kh0KczRj6sE20j16JztyvDVLuLX95/Ky3hiRlB6ubri/Z/DDuIW2ZdX2qcLaK2s+Xvq4LYiMSvMbOw5JANs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732073349; c=relaxed/simple;
	bh=Z+iBe+NIvtcT+D2GAApfGazm0te18HQuaN1BjVcnHJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OcYMRraIfB2qVeU3KdTCD0khQEnXRhJg8Kj5FKsVsxDWxQaEUAaztNvb6PxTSQtiZrQ+VJfWey7VgMhqn1H9M1nf3UmJtryDfWv9lugDyflaglneBgLx9flXd8aF0yQXFMe83gyMSRIjQmwMf7os7NFm63lgVOqMDQyYbVYGvxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK2t1AI006989;
	Wed, 20 Nov 2024 03:28:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0kv6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 03:28:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQL6hOrTAfHCe3zkSp/HKdzyqPrQvw3XgS55S4qyQjt9kTvEKvWTdFATScwFW63nH+1LT9RnBD8z/WnoK0Sq3NZXD6Ds/InCIMn2PDOUxET456BKTQewNKoc7J7Mp2qlvCkLFiQuSQOnzvSjWCHk4liT5HgsHRJjgSEO4pk4l5NLDUmhNFLi70z2Sr5DPimqlTJ+oFKdiB7EB2YYNqbXKM9qEMGVjp7Cv/RmqXYruz/YTRkrcO1Q1gq3khPAdJnwXpCAtbHQdEVzeRH3NDvKj7/N5Qi6WjKfoR6BYiu06k4ej/pcitIR8uDjyL9kgHPcD1w15W6CJMsTJLkku8C0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad7x0fql0+wSJnTU/6ZzBSoq3cPM4W0k/cOfeAbH+tw=;
 b=cR/lhjTVRkzpoDz8acq0oe5Hbeg+aDlbPXvnIiCOwNt2ltETFs9NvueYbZL3dA4xObaFbtkFeXbRTw1mgIgXweSkWoWaARH4JDanwzdLaExY2Z4TzgiJjU7iVPaJpLcZx+vIvkalEcxROsWFPzljphORX9qFFs+ZLKezOv4idTTNCY6oHePqnS4scjqMWFgBn1M495LvqPrDETOwtorkWL/4WmW1XL48TIPrPoe2LeKA6dwRxmTvOWzAs4fNw6zdaVqEuANkxJo2aLmmF8SvkWFBIJCQBzLn/MbBNewSxCy1X25b9evtkyICTGU5Wcdk/g+16EzRXQy7dy1JAyBQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 03:28:48 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 03:28:48 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: yukuai1@huaweicloud.com, christophe.jaillet@wanadoo.fr, yukuai3@huawei.com,
        dlemoal@kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH v2 6.1.y 3/3] null_blk: Fix return value of nullb_device_power_store()
Date: Wed, 20 Nov 2024 11:28:41 +0800
Message-ID: <20241120032841.28236-4-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
References: <20241120032841.28236-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: fa21d99c-804b-4a28-1b6e-08dd091371fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KHHhi6OEa66lCSt9M8utt/DkTxoob59DWraIIURgf9iowE7Hbj+UDjUshSUI?=
 =?us-ascii?Q?ecPvcj49f7d0npjAmzyWQ6Hca6mTz0nynazmY+PJ/l0xelmTFKTh/btxFRVB?=
 =?us-ascii?Q?NRHLjRePx4J+8VmFBvzrNm2pJXZws5GV/krfm2mg2lHrAwXjo7f9lCv+uEjQ?=
 =?us-ascii?Q?FvKD21cF1sdAJltWCp8948A6IEtvIjpGTOrRjZItXwuAENyxIpDSfMat6A0N?=
 =?us-ascii?Q?+MgRcxP0PkxqcUjjXIPEhl3e/tJ3jyuSAWDV0ucykaxMPhC/Yh+uklbfYdC9?=
 =?us-ascii?Q?dAJJk/KTgVhp8YroZVLlnRNwZ9j2fiU+9OoFWLVxvujjkApc2rCotXFmXxDQ?=
 =?us-ascii?Q?TuhU9ehb4CMDKkE7DkTxeagMkYRiI31z5nPOc8KOaDL3JO62d1mAglViWNcN?=
 =?us-ascii?Q?80QnQVF8hCjj4Hn1P5QQDwiKqoIWVTK/3fHuU0EpXU0hL0ymLnlHbSYQmr2f?=
 =?us-ascii?Q?o4s9q4v4qqqGNNGbE879po9Egyy7jQ5WwlhUXhYXrr0lvCj0OQhFCKglsxN0?=
 =?us-ascii?Q?I6AqBG7jCVDLZi5wpInbjHAt4J5xUN8j3DTxqjFF7KYeLG/2vV/G7IB/07As?=
 =?us-ascii?Q?NqVhvcy769VN75Hk2s5OtgiiUCKVHbx2QpRvsC5/W3AmpvRvh3cFnhYArnKj?=
 =?us-ascii?Q?A2UEsJ1cxUGZD1idEiCL0rfrD/92weUs/1jxCPWzVTYMOYrwM32RtyrH1hmx?=
 =?us-ascii?Q?mH0NKw/jgexK35sldmunkVhQ5k41ZkFeFbZWOzVPMAUCYD9j/NzEfXrxwVXj?=
 =?us-ascii?Q?kXaPyQMJ+G9HgKKKU1d82Esbqyzy8LUbRYswddB2lq0nMVd52RUXW5mncwQG?=
 =?us-ascii?Q?BvJu6Juq8F/wGtaM1Y3Kbqs+ktQwF0UwotHUBuwCFL/T5Ru5iNVef5wI6Bdz?=
 =?us-ascii?Q?tun74dV1i8jFq1VNMvDVmQY2T7S7ZUYZKCBILWhbpUMKRgzvM5HA7qO5gArP?=
 =?us-ascii?Q?Pxc1Shk7GQIpLifLK5ucwSjdcV7KG/TR2kxyyrGY5ZbIJmKFXzxieVxgoxbE?=
 =?us-ascii?Q?GteGckKAy5Ejo0abgbqlEJL014N1mHaWxctl3IN3yuknABAp4Vcws/qzMEwN?=
 =?us-ascii?Q?qAPdyYsuTRTVo+X8pO5HuFCFfD7jqAhsLu1EnUYvNlFudDvxZdZ8D864NgRt?=
 =?us-ascii?Q?7/apHP09uiKX5cYtf011wFLevFvsmQatlnA6rxNm5Hdpfd0GkQuSqt2vlxKo?=
 =?us-ascii?Q?veIQZQTO5HVmPsk/4cSQJiUh58HHGPjbgZ8oy7y5z7z5iN7AcuASPxYcSTNA?=
 =?us-ascii?Q?N+zhjceaYz01eaukRwmPfGpGy85/SBK5IjpIRienCS/e9Y5v1p4tKrAcdoA6?=
 =?us-ascii?Q?ECoMnggxzN6OxtZDTqVOWEycHe/pO/15XUoFh6+VKp+NdVriR2gSwEv5pfZt?=
 =?us-ascii?Q?VLpFuaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQKNk4otwNs9eE/wVW/iiZ8UplVzH7ADzFI4Q85Z0+HKTTyCEUiVW5wPRuAW?=
 =?us-ascii?Q?vrQoJ0kR8dUMIN4QorN01WbRSW9wqAs+kdA8COOs5aOzPGFk2P3QLal+qK9O?=
 =?us-ascii?Q?5Xh+BbuHdT4PqGXnTGV0fCqLEn5CALJmq5ApheWPzmZ5pKo67dElkDD8nS4J?=
 =?us-ascii?Q?cjQ2TpZj54t/vDZA9DZelvQ2/7MfSwsiKC7HOpTv7bomyBlUNAz1uGF5xLR0?=
 =?us-ascii?Q?CbFBPMVpRGjyUXx1rcZXEH38gevkuXJxR7d68pT6LJWMuBOEsCkDeZM+F0Cl?=
 =?us-ascii?Q?5pi7rDPhJfXr8zeUAKsEaLk1XUOfpfdFIrUdxURyiM3r1bRsZb7W3kjqlHc9?=
 =?us-ascii?Q?typQBr6/vkGAIwwZZniTLeiV27vOABvcFQJV8u55WU02iJKZrrMNgR46Odyw?=
 =?us-ascii?Q?c+mbqNeTNVrQ8wrHUaCUMLsJf0060gRrEzjX03/E/6rrW6IwqanrshA78QOI?=
 =?us-ascii?Q?JqYlpuNlQpTC+B3BrpjJvRtF/cJsJ6Qn0mLayGeshbzHNg/Uznyq66YthBRV?=
 =?us-ascii?Q?kshRgNS8uZc/e+I5kJ5idpUazp2ifOCtyixlHV8BbV7CUXojdgcwHlKOANsX?=
 =?us-ascii?Q?ve2QQ61/7Nd17zDA/QRDVlfrmAk50I3uGmxchh5MRAyde6VXa0NwKofl94Mx?=
 =?us-ascii?Q?Z78v/7qfxhmVno6T0Om5CzNcB31rFHuXozFtWG79oj8GhOGCBT0c38M+93O8?=
 =?us-ascii?Q?bfaD39fzugbKOJowL7UByjTS9ZkB/t3w5LWc4To/NBPVrj495FcL2fgt081E?=
 =?us-ascii?Q?zTP66epxcNlzsU4I8cq8D5G1rk3QKuOhkWIzfojWUfSYKIdxBVMW/KnjQFu4?=
 =?us-ascii?Q?QGvy2YdOMjFeCBJ3j2/4seDIu4vuTIY2L0FP4EhrwdByx7KnyHRSY5PY9U9J?=
 =?us-ascii?Q?HdaplUsh/WpPvn5hQaduf6d2vmlSKbeifKizZSrhlFia2eMwj15pRnFXwY7i?=
 =?us-ascii?Q?BQ25uRTULBck8xHV10aqVlj9Pp0ztsYAJ6AJMt7t0S5n13b7E60/GGSiTm7G?=
 =?us-ascii?Q?2xw/epq/8M4bDxUfImV+PzceG9XzPoDKMOetAsmubEjmeSO4G/CsQ1Iy9MHl?=
 =?us-ascii?Q?amr84UDrJ4j+zr0oKO8zBAi5p3uu44AUfwo2D7okUTWwLI8d7+ayESrSkVTF?=
 =?us-ascii?Q?KszyDf65JChX+FJ3Uv4IKuyCuuQGk695r28BFYfh52O1wip2A+MsuSS/XFOz?=
 =?us-ascii?Q?7wVMotvnWxpehLpucD4LTBLonjSePfMSRIr1Eyfyxko+tApRejmH5TKg7Tf6?=
 =?us-ascii?Q?NEBO2CDHrIo9o9QR8uFybDwT5VdpZvHidX/LbI0PRoC0U35U6jRd84RujDXc?=
 =?us-ascii?Q?NTI3k8+4RcgvyjAYnqUp9otfgOb0gHkA3E+xap9PKUrahN42K1ZKyai7w8qc?=
 =?us-ascii?Q?RYu57wxm5tmhi4Stu1xTu+1hOfemF8VFkT1CNZZDnLskXPgzqLFDTQOJDo5X?=
 =?us-ascii?Q?MIF8EkeBKXpe1P87/3/f1KFvyRoJaLEQdyt+eUfEZkj6K5M0hS819HUAhgEl?=
 =?us-ascii?Q?Qd3hgf4lYIPOZEzeW9L3uHQhSKdXaQerh8loDjc1GEJ5jpIAK9jSHpOdEi5l?=
 =?us-ascii?Q?Pwm4fRmjyrmOugHYVDVBRB0zU7zMNl30KULVkWghwdXQOVwJIkGzuhzAIJvu?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa21d99c-804b-4a28-1b6e-08dd091371fe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 03:28:47.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQW4cTZKgO/c1fgyxMOZkZ5bYJ1a2y6OxZZV1YZH/iGYj0eLuuW7c/3nUK/CzVsJPKpGL1vA7sjHwdpN4GTJec/Ras0tlitRdPDn11GQZiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7192
X-Proofpoint-ORIG-GUID: lwJ6eID2CEfRijsKWLXuqNAQqX45p-hz
X-Proofpoint-GUID: lwJ6eID2CEfRijsKWLXuqNAQqX45p-hz
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673d5775 cx=c_pps a=wXDgSYWbwZencpnnUUTq5g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=hD80L64hAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=Puq4y9IwgNPiuzXzUAcA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_16,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411200026

From: Damien Le Moal <dlemoal@kernel.org>

commit d9ff882b54f99f96787fa3df7cd938966843c418 upstream.

When powering on a null_blk device that is not already on, the return
value ret that is initialized to be count is reused to check the return
value of null_add_dev(), leading to nullb_device_power_store() to return
null_add_dev() return value (0 on success) instead of "count".
So make sure to set ret to be equal to count when there are no errors.

Fixes: a2db328b0839 ("null_blk: fix null-ptr-dereference while configuring 'power' and 'submit_queues'")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Link: https://lore.kernel.org/r/20240527043445.235267-1-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index e838eed4aacf..e66cace433cb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -470,6 +470,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 		dev->power = newp;
+		ret = count;
 	} else if (dev->power && !newp) {
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
 			dev->power = newp;
-- 
2.43.0


