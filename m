Return-Path: <stable+bounces-76731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D816D97C58D
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 10:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BD11C23A66
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045A198A39;
	Thu, 19 Sep 2024 08:05:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0EB198A30
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733154; cv=fail; b=tZIvBwNMLbDXPgckl1EY6FCmUX4OqyP/CD21sDXmp+9xitkC5TfhykfN6FAcZvCoIGykzG+t9yxD+VX9S8CCZCu7I6duQfaY+T3QwWO7uTipLnMzGHYzQqT+6BihvszkQ+MW5/bIYSUjrDcRf55JAwPuT5eI6E/tgiEaalicaJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733154; c=relaxed/simple;
	bh=ZWXqyS+RNYu3ucSjzkZkMSsT5ejbVcaSWW0T/Qqcufg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JaFa7YjS1TQJk9XgWGc4w4JtL5dAqFDJL+GG6mputVRhg39u8m1tffAlV31nMZ/Tmm/3cEI9n4hXH4v5M3ZLBK/3oF2o3kFIO8Kg+E9Hoj8SNo2luWc547r+pCoUPT9kmgToStKVkYJ8G47z6pUHqLuWoewhUA2Pn13zVuAC7Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J4uQ3m017660
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 08:05:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41myq1w7v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 08:05:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJyMjiCrQQL/VmBoKikCKQE7H8CsyAgavd5j+wUGIiUIbn/OHxBLkF6aTWZV/fygyfDFg5yrlEB/UbS6NkDCMLn+URNqNYYXUNKKqdGOUj0s4I5KqKHmFxoC4tcOZyk8AOTJAeEz3bqBFPvyhJ8WqdJ0zxFcaIB4b36X2RJwR07MDybM1/Um6crtwVei4cB5v+9qPcaFLkIbigGS3KDENoHqgOBXG3896JoxZOKe64AGXXaxJJRy50/2/JmnCRbaw2nIGpYKusibO7Rokkc/VokI4YttMFcIxFafNs/McHBVVxluE86ygM3UIT3b2sVsh/LxRhoxVoIIwi5N1Ot04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCoX03aqYtyNqZX3en1zE+jy6N+0Y3ZPDeqxjLmrvVI=;
 b=Bc7DiqA9bAEceq2ozYUiq29L/zJaUcVkwBn1DBXoHrsqLvDiYidQ2ueUzs5o0DKiTt6uIKrbHTEyyCcRP33gQhh4RFDIzKQdCiW0158m2pE0+IxT/rXSzUMP4STyriN99QhOwbKRzIGwYWbFv3rvCigtGTbJYZ5/z7bBHksaHjFgz+q9NfpCgJBlSM2a6Q14TRr21sAHzTkHFGyc9QuuSmPQePdLj6pdTVHF+Ut3XWT/JZd+Rm4DDAgJLuWY6cJQwiT5kiNQasxIRatQztlVLBHY+Kg2mj3t/ZDvX6ViZEaIvKd7v5rSVIKHd422f1Zij7X6N6M4bkOwLO0mfb6sUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.29; Thu, 19 Sep
 2024 08:05:41 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.7962.025; Thu, 19 Sep 2024
 08:05:41 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Thu, 19 Sep 2024 16:07:22 +0800
Message-Id: <20240919080722.3565234-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::6) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CYYPR11MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: f842aa2e-2f9a-40ef-9fae-08dcd881dad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?muXIkhOZjtUSsSaktQwAj6y0VGe9f6l8sAqAp/m6IhCx1nEYS/3Tm/h69qlK?=
 =?us-ascii?Q?GbmbM5pjCV1wcmG5E2rzcQZT+zm8pDSrNTrPYyThKqc0AEZUJypLeUTHs0z/?=
 =?us-ascii?Q?Q+jXoIjZzSyHGndxU9oQnAvJri5lIF+qG8/ElZuqPWllrTkeikAJi4Oo8KBg?=
 =?us-ascii?Q?sXeXdPvQkY+PyQ4pClx81VFf7NtjS9eAxhYQ7MpO6/1NwxGXjuoMfXXEmWMO?=
 =?us-ascii?Q?gV4rJI6FpPLi4mvpAvmO3Chs34uYwlfPYYzFFjye8WoYssenHgdrMh4hbIbE?=
 =?us-ascii?Q?hiyl3kOffyg77A8Nm1Qp1mtgxoSdODplARm0OhDT9/GgYReXkbcnlFQwOTG9?=
 =?us-ascii?Q?6Vrb3K9xAqIsWCyXqwcIdEiJMhAcAkkwCkbbyj1c/9clHkX9aBmk8dsxf1QJ?=
 =?us-ascii?Q?IVPAHyLdU69GZ21GJd/w4jDln1ip57Q7VxY/q8uVFSb6cSq+P+kUWkOKVIdu?=
 =?us-ascii?Q?W9e2H051h7vle+wrlMILc56ndo4vKInZOp/+dB9d9joK1jkQmOoMFJ/0YxyZ?=
 =?us-ascii?Q?LawxZUFfVg9MboRHwnN40i+oA/m39dRf+rlpruesHS86RXIL0NqTybQnuSCN?=
 =?us-ascii?Q?jKeP7Bwr8j6NTdIzuVgwGn6fXJwBmwsCUGvdWrW1X4fvuO0aGpK733KGeJ2m?=
 =?us-ascii?Q?lPAGMMa7N74wdS9XEvvI064q4xx9/LJ4Nh/Hc3oWmQ+QkP9Po0DVnasICHNO?=
 =?us-ascii?Q?crMH/hQV4Urma7kxSQlCHuodyYmnfuqVMijJnJljIZE2Ue5GM2pQp5bf2cLw?=
 =?us-ascii?Q?8dPUVlobhw0dO/k+uhXzbO1eZR+XsHbP12AQ46yxhAIeI4Vh3h6THpd/DzBj?=
 =?us-ascii?Q?dNOJXnIwbFVljAcfwSky8qjImTM6DX7+Gebu0ms0Pyd9l82VH/1KzLO5X7P5?=
 =?us-ascii?Q?9aKiEk17PEN418E0982zqQya16os9nJnMRLI+fbIc+uGrkK65OMYNFmo/6eE?=
 =?us-ascii?Q?N288DkmBC9oxvO/qAHR16y5oPEd/Vhse2xOdchiXMzQ4cbY4U9uXHkfb0eLS?=
 =?us-ascii?Q?g2/fLo0lmBQceJPPcaWf/4up5JjqYucFgUHL7JpxL9vpO3h0l+ZCeFq859ME?=
 =?us-ascii?Q?FwUfDwLaciJZmBQyrkQTr4nkV2JmMtqQ54QnklmLonllhlBjQds2V/kIijN3?=
 =?us-ascii?Q?6frXeT4FyTkcmInYnMBTuisv+MUgXJewsGv2O5VYA8PhyWUn6xj6j9SLZzSK?=
 =?us-ascii?Q?YrQFnkltWU9eXVlzkW4WqUx9L9ZmfiG5Yy6m50xXgd8IUKF0JtXp3ULQmhar?=
 =?us-ascii?Q?OWiufWKYFOzL1qCy1u+mG1++fv0tB78ZTlY9S1s3FUN8+EJhBzp8FquE+OPp?=
 =?us-ascii?Q?JnXH5DTUGV2KxtddZiAXrGs6gG51ndLWTpB623MihdcgpH/lcFR6QLjVo49i?=
 =?us-ascii?Q?DnFmZYE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOCZULHlXXutYxad1qEjkdnbrcQUnpLC2RkIviBX2u3wJ8HPdpzalfyqVvNj?=
 =?us-ascii?Q?VA7vYRN7cmApVw8Q+xiPUoQ2DnbyH1EqyfAb4QslJ/LoCBW15X97GhTzZ4wk?=
 =?us-ascii?Q?9ZR4UbmsUgEGOo6WS/G/Dk2SgonEeOc1++SRqizKSobs55Onfx9JKu56m5iT?=
 =?us-ascii?Q?ZNcK8v7DRMLxGlBKW7L2lflIDUgj962PniPVxQL4U4zzPCmYOFjoPKk5bOtZ?=
 =?us-ascii?Q?BhFjhgTDu+lW/chZz4Es4+klYxJJPnQ31o+icp1Igpf7zsh3UcUTuBMxuWIH?=
 =?us-ascii?Q?VHj9u4RIbapXiulGktd815GEYLLuHi0jLQEWfOD++RHdrxH77iE9Oy3lgiok?=
 =?us-ascii?Q?TC8rmR483SeWLQkUH8nLiuGEMufQnfbzmP/862ANgDjN7vlhiyXvbGYHF6Vo?=
 =?us-ascii?Q?q28fX+0Izet80GArc1PnUuy2CVsXDbUYHHKRldgp2naVvDutSCiK1ndWBZCO?=
 =?us-ascii?Q?dj9+h0ngb9CogLdtcW9AnW5dXyW1JO/Rt440SF9JLLvc2UN8I09m1BJ0SK2C?=
 =?us-ascii?Q?JDuHCUVMpSHHSindAWQZLx4+BO3kP+fiaFj2Z46qc9ZtmepLa+pmjcRuVJHy?=
 =?us-ascii?Q?VsOI63/YIg5ljqIUukKbvcAPz6qLFRGTZuB/s8dFJSAZ3R1qqOR5NgjQc961?=
 =?us-ascii?Q?j6m1h3U+yRzWIp0eB4igS4oL4iIkX1MBxANeiDB3n8SpqEFzDEtm0HG5XpW7?=
 =?us-ascii?Q?odIU9kvvnTpTAgv6wMlFKShvCPGyDUni7JJZzXea/6AOUQMlPmBdFC3pnNva?=
 =?us-ascii?Q?/mcUt2x/y4sZfX4FTQzOSS+OU5u+UUgiOxCHiB4jUAEv+m8sZ+CDfp3W5HJ8?=
 =?us-ascii?Q?vxus9Ur8UPS5L3Z6kr2MjHXpCEX2UzmljsnHZBKif9LSCs3dVkBepJIeIzSM?=
 =?us-ascii?Q?TJcbg0NQHCqXG95H/TE3SyzKM+p6vDo6SuM8FIVlJVzA8Y94ieudNaL+m3R3?=
 =?us-ascii?Q?2qt1t+yJ+4KoMRPd+pLjotzAbHVob4UYCBQtUAcfoVLspP6mvUVkhxcB46ps?=
 =?us-ascii?Q?hMDUOYIdwTVX5h50F/73m91nmLpnbGH0U1lC7xirxPyIPsc3bDdLWBDQDIE5?=
 =?us-ascii?Q?RLqkjHAgfOsPf45Tl4VixbGHZUUY/6aRHt5ZaZY3ZmMNLMRwInW+M4977aAd?=
 =?us-ascii?Q?/6vC5fkm1Fk4FLBacl8Ya8GZLvCB7C8IArDvamt9xaXrJ4vKpaNeEycxUucX?=
 =?us-ascii?Q?2WDt6y3wE4F2H4YshufKXZnf3PtddEuhOBI1PjgXaN58yo+eIPN1t0/RVCyp?=
 =?us-ascii?Q?vdZLYFuOMS8/BlkRLVodxrkXptzz/WlXXtJIlkIx0wO3Z2AkuO434gX0UxsU?=
 =?us-ascii?Q?tvnuCO4occKjvMfuKhX1W+IVuZE1EVm8uUZImPXNxY4tZ1HbdTBFIlCNi8wR?=
 =?us-ascii?Q?DXfSeGiPKxpKhBbqc/IodN9338IEkWtusqLwyyrNJYqm8usCZMjjR69HhN4t?=
 =?us-ascii?Q?mJAp1+7RHbKryLpnfqK19GlY3bLW3Rmn7LwA1AKdvU7BpaYvwJvacMSS5KJf?=
 =?us-ascii?Q?j2OANhEynzrefUrUbntZ+k/QtaTSpqNswsu/+ZxAC4h3YrdKwSUPRBG8TzyU?=
 =?us-ascii?Q?P0jY5omUldwFBThkxB0fatigfB+mTbGK4O2q8F0XK036jJtA5k2iJF6sX/1H?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f842aa2e-2f9a-40ef-9fae-08dcd881dad7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 08:05:41.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41A0hwZQkBTYI65FU5IKdWYmLYhdt3LXGZ58Y6e9feMWyY0NeyU9wR2jdMPo6AoHhxa6WhvmdrZr64ok13OgOTKb8Mfn5B9ljuWNqPqbhqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
X-Authority-Analysis: v=2.4 cv=MYM+uI/f c=1 sm=1 tr=0 ts=66ebdb58 cx=c_pps a=CSNy8/ODUcREoDexjutt+g==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=7mOBRU54AAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=GquBNE67Clxwi3VJOoIA:9 a=-FEs8UIgK8oA:10 a=wa9RWnbW_A1YIeRBVszw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: odazPxdXbvZY3_AgnxcKFigZNNfPE0n0
X-Proofpoint-ORIG-GUID: odazPxdXbvZY3_AgnxcKFigZNNfPE0n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_05,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=765 adultscore=0
 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2408220000 definitions=main-2409190051

From: Kenton Groombridge <concord@gentoo.org>

[ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 62c22ff329ad..d81b49fb6458 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -357,7 +357,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -367,34 +368,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.43.0


