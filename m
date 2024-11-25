Return-Path: <stable+bounces-95343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBCD9D7B48
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 06:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E13281693
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 05:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0C158218;
	Mon, 25 Nov 2024 05:38:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515375589B
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513103; cv=fail; b=d6Ne5stA4hwZfrF4R3+eGv9Akj0TLTozcccgo+5c8sruRi2kl6tio8xtkibAB9XC0bXpc56dgWblNiSFBNxAjt26G2op8TzX9cBver40RwpVhFildZ5zjGe3E9N+XTP10S/GIe63XFnDpHukDUdVSGDQhN1kd/+I40SVdKQ2G08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513103; c=relaxed/simple;
	bh=OF6MGJ8RJFuSpT1RK8h1iohAZwuCM7RcbmyAD8ctfgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nY14CBS6lzjzeJ4OvupO6kThLiDiGXYmYaEakJoVAhAmaQEel8eW5IVqNWc2ddm+LpSKVfknSJDyQuXCM2rHTRazFBHFKi5DeLxfsPON/6k1hVJCAKVY09AKSuCx7+aQVa4EApgETmr2AEoqtWxLlOgP3qIcbuwhTju/Jw3eScs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP40lrQ024079;
	Mon, 25 Nov 2024 05:38:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4336189mgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:38:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2r5swxAcq7CGuzl9D5GdSETGLKFGzF7fUAIwKmTN6ZwfL/K4Ovz0tc2rNidZdk+EO+TA667nUQRKUZbvtiMYAX0/bMReIPGlC90uJrH4xPTQh2OuM+6dP3DPo2YUXJV2rEa/82laM22vHV5XIMhze5rXtHU9zlG58QV2DAgfbfsCsNNgR9HwZjiDuU/dQ4dksbybCwZctS84AklvBAWvpkkCyQSVHihu0iH/sakbJYCqUU+dhQ3yR8LadKp9afRCcCWr/LnNIYJGnpsNQ24ER+daZNSioc8xKv7xM08SuLIPO3Idzt4oeHz6kDMVzxHS99rZ+5CnNPU/rsQ8AXsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i29yjdq3wjzYSBjO/vBv16G5BhXG+SML/rtL/gkl+sE=;
 b=XWiMwIbiEmY4WC1HyMPaCCEv3OVmWdPYYaf9VJlw1320JagY4ThmnBEB4wnRyQglJa6vkA0w+SnQyJi9FN83wnvTq5GCPZ2v4H8AZLfAlyGFaWYNOGKTIy8G8PxDx+FGXYFgPhWmCiYSC0ZMA7i8tN+mB+sT7ql/hzABTvAjby0/JvbYAs4vVLdQBsouFl7zExXhEphSo8HV1v/aYxRuDgzzhm2p2TPs1C4NoJBHcezPoFKzts4tR8YOsEtGlBuiKc6w7Q/fVPowCaZmEkcQQuba0o/jH4w58j0TGBIGWdlZ0B49fJ06HFg8cIw+nlqQ1bKbQ40o41UkkgGhJcexYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 05:38:10 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.024; Mon, 25 Nov 2024
 05:38:10 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: marpagan@redhat.com, yilun.xu@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1 1/2] fpga: bridge: add owner module and take its refcount
Date: Mon, 25 Nov 2024 13:38:15 +0800
Message-ID: <20241125053816.1914594-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125053816.1914594-1-xiangyu.chen@eng.windriver.com>
References: <20241125053816.1914594-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0340.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 084e362f-4083-48fc-d724-08dd0d1358d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhXIsyvm3DF5uB2hIq6Yp64iWfVDpWA2Gzi4P2mFG0nqHbHIv95g0TpCKllk?=
 =?us-ascii?Q?Giw0msNwYGqFdantsWMt0X0GQguHuwWGgxCjfYIzgBMP9KN3/wiJG1rMTFCe?=
 =?us-ascii?Q?rGYs0wqLSAJSbkYHWg6VqoSGQ2y39mkOWXZg4tU6EZgrGNq2YugMWO+HQPaX?=
 =?us-ascii?Q?sHCgNeV5ZJttbuzx1KZj/h5m3EsaaOi7qu1I5MJvk1nUuW5sYgHyR9Me3YJ4?=
 =?us-ascii?Q?FbqXGzNdLBG8NyI3AtosGOfD9BFjAwXg/vJU7Henw5/KEwrU5VGsAC3gn2qt?=
 =?us-ascii?Q?dAtrMxWxR1tt+JT1TTrmf80LLiYScmOBY8JO+4Daj+yOj2n0iRyUC4fMoa7t?=
 =?us-ascii?Q?H8BDJZVaTAIDWjGVzJ4xGC5OWh1VARK+UHj8KXu3W63hpb4a0fHnO3bvMaOA?=
 =?us-ascii?Q?na8yDcznvJt4W/DwKYeLL5Wfh28RYHyxMUYXBlwXmj3tQya57KNbqoQQL4YI?=
 =?us-ascii?Q?ipBPxj1QIBx8a1DMlPw9Db70hgkkvjA5Q1vk3aV64unyRJ2+xugxXrGG0EnT?=
 =?us-ascii?Q?1+/mel+UwLXX8w9oRQD1pL5jN04LAqG4Bxxz+fg/qIFM3YhfEy9cLXkF+xyY?=
 =?us-ascii?Q?ZIgJpBXMYUEuObLQcQuwAT65Vf4aUZszc6mZFm96xO4LEExN/5rhogX0vfqN?=
 =?us-ascii?Q?VivBi1c9xyMim6tZBy175eQsnI9xDrdrUGliMrKKfgARU+lRb2DvXuN+tHxn?=
 =?us-ascii?Q?PfLJ82nF//9WQHUB3upkTx6oO2uzixU/OB1Nw0SFELNvCcMbP6WMIKm/IZF0?=
 =?us-ascii?Q?64hrqY3GYI7QkRQp4Jzcz7kTol2Hbi4DognGTynOI45O7ydTqM9wxcS6+KnJ?=
 =?us-ascii?Q?nGXGc533rRTU67lHo7t+COuSbDi/301gDUlM8k6JVEbkTOqSd8hMTyCij9Ci?=
 =?us-ascii?Q?Of1iAUV/KeBzaZGgYr+RoIRGV85NJW+GpGBsEwNharkQD8ouVXPlaCeOb05z?=
 =?us-ascii?Q?uCgnAUyhlHJShLTRsJwxObpP97H2qlMi46jc9fu2lPSL8LgmwO2kj3ld4yzD?=
 =?us-ascii?Q?YcApxncSk8XsCP+reYcgksMNwa8nXC/mzEwHY3+eORJdzva4AjA+8bvRoL7y?=
 =?us-ascii?Q?U4wdiQ7BBzF2rq5uI+lcQVa7Wtnae05uCWdffNWDpqnmwEy2Ytcm5ydYtffK?=
 =?us-ascii?Q?ABjNDPL7GQ4JE1uefJ768MO+Lp/EcIhr5Qu65E/luB/hh6AJvcr1QKL6HZLd?=
 =?us-ascii?Q?4DgyGoXkBlDtv5BtvIV60viJo7deRShi5yRmC1AJSS3J/4jPTR/KocLAkG2s?=
 =?us-ascii?Q?Rg8KUoxAlx8Jv4ORXyXwbUSO/otTXE/DCKXE27vp+hvDwEJIPUT91zfdhBJ5?=
 =?us-ascii?Q?78YUEXI6iMZV30a+CZ6903hFm8zo4wT01/1uXmtBEatXzDGZrbpT8pcvBAgY?=
 =?us-ascii?Q?11Lw16w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X7H2+DRRNXBWQjIrA8cnwyxiVkmIw1ZTkg7p06cIFXelBD/dQKqWwK4GI7ur?=
 =?us-ascii?Q?Et64Uyl81wpjwuqsI7CUy2cVQWmzYK5Xn+BM8HDxCzetHfBPVBjFtltGFxQd?=
 =?us-ascii?Q?Dyh1wCabo+qrbyX1VVWsbbd3Js/Q+egwc5GCzFUGIRQ7fOK9YIRRH5MAcwez?=
 =?us-ascii?Q?jFXzhirjwhmmQSE284kDYhxyEpUHr4ckyuD57dYPIYu0zZ1v/D1XjrksKTUD?=
 =?us-ascii?Q?1ZAiuHNYH8UvFHLWWB4lb0T2+S19ys08RTgGHIaUEkq7G635cgrnZUZtrzNf?=
 =?us-ascii?Q?T6/sRWQ+efhDzVBHbyUDFFGYgP3tElyOyVH90Qkbhnm9IczpJRmINCVVlXhQ?=
 =?us-ascii?Q?ktpC1AlXE/F45JJqu+UNS4vpG774+Tvm7iP0nTTyUjiu1ujAdhIL0EFE2IVO?=
 =?us-ascii?Q?+a1jmx7R23QGVaku242YMxYoq8yOab3GIby+NQWC2aTtncfXy6uonc1jkrzT?=
 =?us-ascii?Q?IX4vIa+vwSLlI6+bw/8FiKkJyAzubJSo/sAvOzKSctyxwsWF2x8TNT05SakY?=
 =?us-ascii?Q?//oZtm+B4EvnzH+RMNQ6TrEc7ivMUM1ENBx4GWQwKnnk28jHmCykngsuZ1+a?=
 =?us-ascii?Q?BmNblLeXxjeokuM4R/J25IhDTzQtohH6iADzBB9i9H6a6nIyuxdbF/VyImRs?=
 =?us-ascii?Q?8JXS0LUuiCLWcWKpl1Rei9TTPDfoS7KUk+yi+oVzHZml56XvDKEs2jClnVyG?=
 =?us-ascii?Q?Wr7SQM/4tXbbJMbz/HhdyRf6YHJ9l2K1TtRZ+A24g+Fd4lFADi8Cy1UEd1hF?=
 =?us-ascii?Q?PkAqi675YLOEU7V70/f+feVKwIrXktg2QIOOcygx7Edc5FvURelzQHUTqNW4?=
 =?us-ascii?Q?8/gEYxmozUkOSfu+gQnyl8LJ9aSQBLfGTQi8zLVhD8Kj6r6V75eFOgrYiyGU?=
 =?us-ascii?Q?ixlIimSMHfRQ9UrJzM90SdhZ2N+Hh3EwANHCgRmkttf+cHiwitjs/TGS5ePF?=
 =?us-ascii?Q?vCYr4A1WjLOl/XRFFDzk6wjSMle0We2z0AjMs6JZRXCixq5PpzJ8MUqgVZA1?=
 =?us-ascii?Q?Eg835z5vedYzNVg0fwtSgs4GztDTLdfMZSryHM7LhOC0dt2S9yVRRTwVfh1x?=
 =?us-ascii?Q?zg2mdkaGjKvgdxTu+9W1V383w7ko43W4zyHKNZBywX2NVRixLOSe19726pSC?=
 =?us-ascii?Q?6Fx8s4LMnt0++qpnIsrU1vSBO4s/sM5jB7FuQPXzMvRgYGzNA0VUdZitmi/u?=
 =?us-ascii?Q?jKX5S8CfOO6PlRh0XCU4gHyppnZsXXNZJyoTjP2vPEUGTAgqLe4HneVQ+pnH?=
 =?us-ascii?Q?cmDh/kicV4rhNGohk1XfHWgGuCq1KX1NayGC5QQpA3kspYsd19NG6De4R0JT?=
 =?us-ascii?Q?ne8cuJDOmNvV/OpnPySMo2CNXvbKnYez1Q4SoH1I2k7Q97sFPNfgT/TVcnAl?=
 =?us-ascii?Q?YRK6RkDcVqLc+B0SJGR7iuCKIpF0KzfW22Bs3UHRunSAqH0b69g1lcTDz7HQ?=
 =?us-ascii?Q?Yo+DPb6hb3kSHoPweCO5scoWZLSvNCLEw7O6wSJrpTMpr9Pp9WhdsbNdy+zU?=
 =?us-ascii?Q?Vd5W0A8Sas8/W0dS24E4QtEBOXmoVgHG492f6QdntOeQ+8vDoQOExflSGo7s?=
 =?us-ascii?Q?HBcsMur7QwiH45uKit6U6OGtBmBsODcL8/k7gToRh+MpnT5p5duKkOesIxBN?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084e362f-4083-48fc-d724-08dd0d1358d9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 05:38:10.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnf51rH+SwwVlt+939Q2LzaZwgFf9BXfDQpKPMZ6m4noMwMaEg4FX2Q2qWjo/kLltNUsPMKvKIipT5q4ukcE1XsJBEgtpzAi0fmqQIovyIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-Proofpoint-ORIG-GUID: s_gLLk5utxUi9eqE-eM-eJRm-1c9KawY
X-Proofpoint-GUID: s_gLLk5utxUi9eqE-eM-eJRm-1c9KawY
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=67440d44 cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=pb-scjWI82oOB5rjM7QA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_02,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411250046

From: Marco Pagani <marpagan@redhat.com>

[ Upstream commit 1da11f822042eb6ef4b6064dc048f157a7852529 ]

The current implementation of the fpga bridge assumes that the low-level
module registers a driver for the parent device and uses its owner pointer
to take the module's refcount. This approach is problematic since it can
lead to a null pointer dereference while attempting to get the bridge if
the parent device does not have a driver.

To address this problem, add a module owner pointer to the fpga_bridge
struct and use it to take the module's refcount. Modify the function for
registering a bridge to take an additional owner module parameter and
rename it to avoid conflicts. Use the old function name for a helper macro
that automatically sets the module that registers the bridge as the owner.
This ensures compatibility with existing low-level control modules and
reduces the chances of registering a bridge without setting the owner.

Also, update the documentation to keep it consistent with the new interface
for registering an fpga bridge.

Other changes: opportunistically move put_device() from __fpga_bridge_get()
to fpga_bridge_get() and of_fpga_bridge_get() to improve code clarity since
the bridge device is taken in these functions.

Fixes: 21aeda950c5f ("fpga: add fpga bridge framework")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20240322171839.233864-1-marpagan@redhat.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
 drivers/fpga/fpga-bridge.c                    | 57 ++++++++++---------
 include/linux/fpga/fpga-bridge.h              | 10 +++-
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 604208534095..833f68fb0700 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -6,9 +6,12 @@ API to implement a new FPGA bridge
 
 * struct fpga_bridge - The FPGA Bridge structure
 * struct fpga_bridge_ops - Low level Bridge driver ops
-* fpga_bridge_register() - Create and register a bridge
+* __fpga_bridge_register() - Create and register a bridge
 * fpga_bridge_unregister() - Unregister a bridge
 
+The helper macro ``fpga_bridge_register()`` automatically sets
+the module that registers the FPGA bridge as the owner.
+
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
 
@@ -16,7 +19,7 @@ API to implement a new FPGA bridge
    :functions: fpga_bridge_ops
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_register
+   :functions: __fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_unregister
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 833ce13ff6f8..698d6cbf782a 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -55,33 +55,26 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_disable);
 
-static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
+static struct fpga_bridge *__fpga_bridge_get(struct device *bridge_dev,
 					     struct fpga_image_info *info)
 {
 	struct fpga_bridge *bridge;
-	int ret = -ENODEV;
 
-	bridge = to_fpga_bridge(dev);
+	bridge = to_fpga_bridge(bridge_dev);
 
 	bridge->info = info;
 
-	if (!mutex_trylock(&bridge->mutex)) {
-		ret = -EBUSY;
-		goto err_dev;
-	}
+	if (!mutex_trylock(&bridge->mutex))
+		return ERR_PTR(-EBUSY);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_ll_mod;
+	if (!try_module_get(bridge->br_ops_owner)) {
+		mutex_unlock(&bridge->mutex);
+		return ERR_PTR(-ENODEV);
+	}
 
 	dev_dbg(&bridge->dev, "get\n");
 
 	return bridge;
-
-err_ll_mod:
-	mutex_unlock(&bridge->mutex);
-err_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -97,13 +90,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 				       struct fpga_image_info *info)
 {
-	struct device *dev;
+	struct fpga_bridge *bridge;
+	struct device *bridge_dev;
 
-	dev = class_find_device_by_of_node(fpga_bridge_class, np);
-	if (!dev)
+	bridge_dev = class_find_device_by_of_node(fpga_bridge_class, np);
+	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
 
@@ -124,6 +122,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
 				    struct fpga_image_info *info)
 {
+	struct fpga_bridge *bridge;
 	struct device *bridge_dev;
 
 	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
@@ -131,7 +130,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(bridge_dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_get);
 
@@ -145,7 +148,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
 	dev_dbg(&bridge->dev, "put\n");
 
 	bridge->info = NULL;
-	module_put(bridge->dev.parent->driver->owner);
+	module_put(bridge->br_ops_owner);
 	mutex_unlock(&bridge->mutex);
 	put_device(&bridge->dev);
 }
@@ -312,18 +315,19 @@ static struct attribute *fpga_bridge_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
- * fpga_bridge_register - create and register an FPGA Bridge device
+ * __fpga_bridge_register - create and register an FPGA Bridge device
  * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
+ * @owner:	owner module containing the br_ops
  *
  * Return: struct fpga_bridge pointer or ERR_PTR()
  */
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv)
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops,
+		       void *priv, struct module *owner)
 {
 	struct fpga_bridge *bridge;
 	int id, ret;
@@ -353,6 +357,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	bridge->name = name;
 	bridge->br_ops = br_ops;
+	bridge->br_ops_owner = owner;
 	bridge->priv = priv;
 
 	bridge->dev.groups = br_ops->groups;
@@ -382,7 +387,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_bridge_register);
+EXPORT_SYMBOL_GPL(__fpga_bridge_register);
 
 /**
  * fpga_bridge_unregister - unregister an FPGA bridge
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 223da48a6d18..94c4edd047e5 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -45,6 +45,7 @@ struct fpga_bridge_info {
  * @dev: FPGA bridge device
  * @mutex: enforces exclusive reference to bridge
  * @br_ops: pointer to struct of FPGA bridge ops
+ * @br_ops_owner: module containing the br_ops
  * @info: fpga image specific information
  * @node: FPGA bridge list node
  * @priv: low level driver private date
@@ -54,6 +55,7 @@ struct fpga_bridge {
 	struct device dev;
 	struct mutex mutex; /* for exclusive reference to bridge */
 	const struct fpga_bridge_ops *br_ops;
+	struct module *br_ops_owner;
 	struct fpga_image_info *info;
 	struct list_head node;
 	void *priv;
@@ -79,10 +81,12 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
+#define fpga_bridge_register(parent, name, br_ops, priv) \
+	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv);
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops, void *priv,
+		       struct module *owner);
 void fpga_bridge_unregister(struct fpga_bridge *br);
 
 #endif /* _LINUX_FPGA_BRIDGE_H */
-- 
2.43.0


