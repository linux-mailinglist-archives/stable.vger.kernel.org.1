Return-Path: <stable+bounces-93929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB329D20E5
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46ACF1F21409
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715E1482F3;
	Tue, 19 Nov 2024 07:41:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DD1384BF
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732002117; cv=fail; b=OlQn0RUTI00E83DYmny8hitIixV4HFVib4t+g8Zhmd0gsO/l/bpjv0wYMYy1wE6F9SHOjlGSmoyoMHG9wHzDh6T7VvNFgebpaxFtVs5nc0pWVJ5TlZLTyZ/YVGsMKM+rXlGZDeGB6KeFfWLqeU86yZCFQciWo5h4IU+kNFhCEXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732002117; c=relaxed/simple;
	bh=JaRgyGXam5Bpqa//BkQ0DYzHJpkrjg8k44ybQi20Xwg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QU8zbrkhU/cShANe++41fkwK4YQce63zwGrcH/ZTg5UN0aJL3mZFeVIwbH+dfqElNQrlFTaoi8pHvLH0dRof39VqWiK2LmjcYKAumGVb0c+ypewDy7JrE5iA4pr0ebVGrYlk3zV+czSkSNdu2ae7iaFIcqFATyjU7t/Bn/11OkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ5e2Pn012133;
	Mon, 18 Nov 2024 23:41:48 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xusq2f8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 23:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veiGvZThNqYMPU7KPipD8b64K20k37tKx1VVBcDNKwZS1yJfmTdHIzbxFqD/GEANOdOgL3EarRVxc9I9LPdLOU98c9o7P+oCd833K+4EA79uVCtZIzM4Pd6xR4l12BuzdE8nWK3x2IGAXKY6XOtM29+nspNVgHXTy/VJQEIE9sj2hsYcv45lMDCQzF+Rc7ZNZLQ9xYaFeiDnLWMQ0OlvBwK0+uVirrfxBUZfET1qXELllUumsM7Y99NNPX0uv+m1LAGqZpYokTJQANHIu9G7pwB2d9BLlotPiE6IP1QnXUMt+HMLXTVLIlcbkXzjSuoMIaO7SxXUgPsFXHJoNScgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5kC0bIw+f34+6YjkepR7QbZsYxShYkMUKMIDU+5jBM=;
 b=b3uJ7O0xpBG2SR6qKnLgLiUMs3YP0KIpUTViFj9Dn4tdzZ27v6Opn2p7VuIr/2JsQFXIpGnpHTzYy1DqVZCHBbl/hIyv5o0ZNeOeVw8le0yku1OoSgD9idXcfhgvv5R8d85vICGAxlYBa8g3cC1gcg3f7RuKtZw6cfUN+AQ6qAzO5mzOR2PZ6AcqrJCZ2wWA9zKnApnsdjS51HI4RYt0nWwNIVHhr2Ccu34rfIN0PEtABLOJkyLWch4Z9oHWofCreTyyKh0z488Yge+XoxV5whOjaULePcdg4FzNsz5dKRtSqSS2t7nTZFjyMTTfXwPkYhlMXtHGPbIMSJ16xGc00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB6791.namprd11.prod.outlook.com (2603:10b6:a03:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 07:41:43 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 07:41:43 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: wei.fang@nxp.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Tue, 19 Nov 2024 15:41:35 +0800
Message-ID: <20241119074135.4005807-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4aae48-1893-4e8d-515e-08dd086d9cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qo1VVXqtwlZs1CzarSRzUbmRqWzoAKjyObkhZ6AJ51hTcIjG7k2IpggxZkb9?=
 =?us-ascii?Q?dM7yOBYcO0U0XaX/DR7WzgbVwaqrQGBbHijzQGOGqgAl7okFUrKSIB2dJd/c?=
 =?us-ascii?Q?K+KQjsl8Krb+rCqYfsgSADZJ3GXtHimH2XPlu/a31Kw3x1pvlOPDi6qVvgD/?=
 =?us-ascii?Q?UUCGxf1MZDoHBle86l666MVs5yzq3c1HsdEJ7EyDCHNb4ffEHmV1axd2O0qI?=
 =?us-ascii?Q?kYHENqGS41xMMVX2FP9U8zeCxge/N3aiM7NQKNYVJmP82dqLbQPPaD6RV3PD?=
 =?us-ascii?Q?R2JiizAMW3gBHQ7U3uWznE8rRgC+tdJTRNaJDcLT7uBfHxEK/S6bH8ovQoCy?=
 =?us-ascii?Q?Qq/oAORpecvY9Sgy6RH9gojTuXCz89Fy5rv+yuU1arfIknGunFtn3lvvcGcA?=
 =?us-ascii?Q?+gF9JFTK78BSSI4Y7s8Sgnld79pZpe01AC2l7942DEcSG5ExIBmU1VL58z+U?=
 =?us-ascii?Q?BRA60Rd1NNe9glxVCFwGK6QFFNpu4zF3jDec+rzcmy9JWto7bHeYWC8VjacU?=
 =?us-ascii?Q?q2w+3+hkodgFEsXhAQTfDEIwcJYWZ9mTmIYlEYV4cTuKUKY8wtb1LVCKHJpG?=
 =?us-ascii?Q?M8ZogVfMnzPtekkKvEc5N8OJLP9cPmHNwCKZcpuYmBYhULiEQfjraJlRfyfP?=
 =?us-ascii?Q?Z8ZogDmfM91hOUlaj1mDq3sqj44Eo42oOoPXKjpaLyucawTc7vNSTxe+wKx9?=
 =?us-ascii?Q?Is/k1tP3k/O+bHQc5dzJS+VVanA8cJMhF3DFPXy+RBa+31WDcmqXwLuzb48x?=
 =?us-ascii?Q?rkR/28gDkCdZK/xq9r3+ClicHh7I/AnDiYi5vwutcP0eIvk0f6oja340bVPI?=
 =?us-ascii?Q?3xcRxllrktPfmNGa1Fzvk/nM/Du0+23a8xmlOU/e+LvQf8yj2eSWQZP9BnRL?=
 =?us-ascii?Q?nvY7Y+nUklp0xbXayIn8BlbyM2kCe40FmSpiHmibAzc94otLtCkxP7hDkvxe?=
 =?us-ascii?Q?FMQHNRW9Db3V2MIeZs50YDPgnwrlHFc2t9XZcs1t8y1jFYT9HM6s6l8UhnSz?=
 =?us-ascii?Q?26/uxH702h5GivuV5oaKwzrBJpr3Mz9Gg6PKWx5KgdTCVlof8CDtve6wVYns?=
 =?us-ascii?Q?/ORic6mAzNsvK2xjfaCcdksjUtTuwJIuoBJZ6dOmFCXHIlyzREMRGHs4KfKt?=
 =?us-ascii?Q?y1lvo5xPNPbwD9W4ggpK95iV/Sdx0vPqsEOuGot7SiOFEzaGOVFbaSMMwoB4?=
 =?us-ascii?Q?MvArfY9LQYwHB2J/bZji/FEkkSIWHJRaM5ja+mYGXseQws3VOchbM+y9vkyp?=
 =?us-ascii?Q?J0Xzcx2+9Ig7G+yC8B/6sN0ol+p46R0ebqz/CS/PETzzZxauBtmCSf6yBOoY?=
 =?us-ascii?Q?EJxX16X7dKiWGZDPO0RJK5Q0tNoTBAQJ5JGIHinUL/LOV2lbgJ94Ggw6ERJl?=
 =?us-ascii?Q?PSLl0YyB4oA6SZCQn0Mm44UQgGGu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nIP+dgSoN6rbTjL2ImFpu0USBxoiaakY5PUIZsDd8V5yx8feID/4pPzT+z3Z?=
 =?us-ascii?Q?qhGwRiks9DW85379mPrkl8GFM53V7mFHUza9uZRYu8ptJCwITBi7duJ/6sHa?=
 =?us-ascii?Q?Jfr1Dsi68Vi4VXoQPirhGurl7E9U3Bk4U27AwdtpTM8+xouUxDlqm9BTtLV6?=
 =?us-ascii?Q?TGP3tTbRTNVQUVxCFJd8dd24WbdlUuHC+qx3vzzRyV/Dsl18OHWv+gTTg1GV?=
 =?us-ascii?Q?45C8odjxF8x57x6oiscBjlDeaAVwD/h/fM94W1GR9L8W8a2HwF03/Elx7eyA?=
 =?us-ascii?Q?dATj2DON+CBH0xQvJOqi92/Eun5xvJQLvm+d9w3+g8YZ5AF63fkLGe3SRJtA?=
 =?us-ascii?Q?w0f6P//xR77jN2AhisOvQaH1rFe490LVEtMFjgcJ+TO4P+gqk0nOGbMWGdRh?=
 =?us-ascii?Q?n1xY5wjGd8CjX/jhNxIIsO4drZSl3qFcrNRrP2loG5GfM5HhMW4O00RMhOQB?=
 =?us-ascii?Q?HYtlXGMu8AXwITmOYAJ58kkUyw8kGhfEHfDVWUUoCsrMZFCbpSHkDrnFT/0c?=
 =?us-ascii?Q?5xozah46Gv+KLOFRtEQ4TKwYuUyi9HdmUdWG57P3Wamn0lGWl3gPhdILsrFP?=
 =?us-ascii?Q?q/iabmlb2DBYjrVuTy2nQcEzL8g0egZPkmpg5Ir3g1OsOM1x4SnOq+fg0g1G?=
 =?us-ascii?Q?ZJw2a1cABaJDKJXJEtD/SngJ+SQ2JR1G7Zv/iYsq3Fq4EaHhNT9RwxMVGP5A?=
 =?us-ascii?Q?rptpTKVv/35ByQbhjLSnQkGQsdQRjxUadg41gef6s7RMr9in76jcDlYh5hQH?=
 =?us-ascii?Q?ioWEPJQDzo2slnGUEgBD6tXAsXSe3M2JqJvEji/03An9F0hPkv6SweMQQBSM?=
 =?us-ascii?Q?YMnCVZe1pQwJgZlNkfMAs+0psz2JSLWeTtndnPB2AITZzFFo3oz3IC2hnMfp?=
 =?us-ascii?Q?ZqAzq9pfGnblEd9uKW9NUmuY7w8b96hiIBcBXWBCG7demICVmzRlnPSNU0Jm?=
 =?us-ascii?Q?XTKjrMhnksHPqgxirqH/lQ/Dz9mnqzb5JORt/F612JaNKA6Me+nw4+wddqTO?=
 =?us-ascii?Q?kOop+KW0DZigLJ/iZ0bCbST06NLRiSGzLBPGsaW7aCx7ncinR2lp5MzVKPUk?=
 =?us-ascii?Q?KytmUiWTAPllz1sC+j+XX89An6iFiD8IgPtG53Ovx7qJd6qhK9t2z9860nV4?=
 =?us-ascii?Q?C48PaiR9i/8Fo+85EdeaYHDYwXGVFCICGqCl/1KD5f5WWsqYhGz1oyMEV8yB?=
 =?us-ascii?Q?bK1gr99/Gj96Z1uqlrp1up5/aUosm1/Bfyp79n1BobB3kcRzjxob7vn9Ozns?=
 =?us-ascii?Q?rqCHJ+YYwXkf1D/1ip6OJdYT6Xudo0j/o+UlRRdWOWJGzT/U429QM3Oisfre?=
 =?us-ascii?Q?RiFC2nqvoIJEBuLAs9tlXNI/iMajJ1jtl70U/DM8Sc30LcbEta2R2z5qNrpd?=
 =?us-ascii?Q?5qdfavcmkvdWbQTVSMYtUTLB0ykVxrOi11+MfG3tt6UFp7kw1zeUGTTzXyf7?=
 =?us-ascii?Q?LoQ6XyR4z65Z0NIAlEUuYgzQSRTL4qdDKMnZHnIkeX/RCT629P83bptJIwGx?=
 =?us-ascii?Q?ubtoYAd6AC/ZhrUuRbcYGlaOYjyCiJcR+zQ/3OCWYQNbcCBVwzxmfLcxPf2a?=
 =?us-ascii?Q?oWlTo72qEmlh8Dx8avcHm7ig2B25igGfZnouuANvJVfU3491bvFIxGaj9Pn3?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4aae48-1893-4e8d-515e-08dd086d9cf6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:41:43.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHKVT+xEKibeQ/dCBePO6tvSf6z0D7MHYAKXKMG4JStpMG8k2ykpeM6Jb3+xw9/ILrXdB3/u2G9aAA9hM/MAsLTxByJxTzcIbMvYHBAbjOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6791
X-Proofpoint-GUID: VmdbeQnrBSiNRv_lHwn_J4kRcbHR8TVn
X-Proofpoint-ORIG-GUID: VmdbeQnrBSiNRv_lHwn_J4kRcbHR8TVn
X-Authority-Analysis: v=2.4 cv=d9mnygjE c=1 sm=1 tr=0 ts=673c413b cx=c_pps a=kSx+wkOqrR7DBdLtetN7AQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=t7CeM3EgAAAA:8 a=IFCpX8b_31d8Zp-CglUA:9 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190054

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit c2e0c58b25a0a0c37ec643255558c5af4450c9f5 ]

There is a deadlock issue found in sungem driver, please refer to the
commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
deadlocks"). The root cause of the issue is that netpoll is in atomic
context and disable_irq() is called by .ndo_poll_controller interface
of sungem driver, however, disable_irq() might sleep. After analyzing
the implementation of fec_poll_controller(), the fec driver should have
the same issue. Due to the fec driver uses NAPI for TX completions, the
.ndo_poll_controller is unnecessary to be implemented in the fec driver,
so fec_poll_controller() can be safely removed.

Fixes: 7f5c6addcdc0 ("net/fec: add poll controller function for fec nic")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Link: https://lore.kernel.org/r/20240511062009.652918-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 26 -----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0a5c3d27ed3b..aeab6c28892f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3508,29 +3508,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/**
- * fec_poll_controller - FEC Poll controller function
- * @dev: The FEC network adapter
- *
- * Polled functionality used by netconsole and others in non interrupt mode
- *
- */
-static void fec_poll_controller(struct net_device *dev)
-{
-	int i;
-	struct fec_enet_private *fep = netdev_priv(dev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		if (fep->irq[i] > 0) {
-			disable_irq(fep->irq[i]);
-			fec_enet_interrupt(fep->irq[i], dev);
-			enable_irq(fep->irq[i]);
-		}
-	}
-}
-#endif
-
 static inline void fec_enet_set_netdev_features(struct net_device *netdev,
 	netdev_features_t features)
 {
@@ -3604,9 +3581,6 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
 	.ndo_eth_ioctl		= fec_enet_ioctl,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= fec_poll_controller,
-#endif
 	.ndo_set_features	= fec_set_features,
 };
 
-- 
2.43.0


