Return-Path: <stable+bounces-132209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65330A8565D
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CB31B64974
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D568293B49;
	Fri, 11 Apr 2025 08:19:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C6293472
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359575; cv=fail; b=KTwbzHJPXW2ESED7XE2fJCylni/Pd1ClPLYVdo2Zr16n/rV8qNMrUzEWjCkGZllbOt2QNF9A8w8W8luzYWtSvyUn+GNCebJGz5fqAdcqBy24ZlPzNlMIXfnrpnLd/LffWBZkkL2tAH7UgIajF5xKSOabvag53wvIsu43Nc9iUZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359575; c=relaxed/simple;
	bh=UI040WeNjNXUanMrIARYDd/003b2iUdNgxWj5JxqDvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ds4NCFY1JEgt+80xdzNP3FHcKcD7eVsSUXQ8BjgTXHRB1Ql+k4Ig9Gwm3xkVpzhPMUAzYIxy2uc2zn2Iar66M9tD6bJLO06eQZHBKJxQMAj23MoNHwiM9LmASeDpFBpTZOC9yW4P9MU5R68PFr5bIL6tMBtIdZkykt1eUT8EbNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5AfOc028040;
	Fri, 11 Apr 2025 08:19:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tug8r139-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:19:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrhdEHcE4y+sRkXUI5WdLW8YxiRPtv0lFZSsIaw+ewBCTDbXAlZVCfi4ariUdtHq0mKst4Dh4/A/F06N439DBIm0kgOIrv5wVNmTRoH8A/fBC8nHYggjBEQU2gXIEFOPra9xzSRIjrTiOvzhagfee3o7vhbq1MDk35NNArGb2TRUbDE9fwqSy9Ya63DNsMZ2eYo5gDN/NUtOSA3nT/zTxFsxthcmgEl46c2esZeCWFfxybB3VCNNxjBMtqO2sEo5E6+GYgj28R2clKWvOBtdG/eINnkW269tBsWzMXxAGragn8MIQqlWP36p3aSgIGcZCGZCPoVKtlpMlOhboHv3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjK7suFWkvfziYpa7HRzAl+8BoJbOgHB1utV/FkAI/o=;
 b=Ow59uyR62I7adZYlHGEr9pP0SrTQM4BO2v+QvUkx6PDWqRoHji0pl6y677uBHvjY4tF5SFXrp97lQi8tEnpjb3VqIz39yH/uL1jNuMaMwvryIZMccJ8cLw1oTuor3KxPS70x5OGVBuSyUEA3cw5M0sKtgEkH7NvluzcNf2cMb1/7pBox4znml2UsrY99C3LpEqW9VZZtuTBG1LbyEaCvmOGKQQWt2l14UOsLjBwvjc1muc/an1XMJqfP1NKgoSHDqoWOTOqmftWorVgMDsu8BWwYwIuYh1i1hBdgVPZHBuWg+Qh/1iWoCNEHZSV0JillQyLfdkBQbmBkgB32F2QIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 08:19:26 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 08:19:26 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: shenxiaxi26@gmail.com, tytso@mit.edu
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10] ext4: fix timer use-after-free on failed mount
Date: Fri, 11 Apr 2025 16:19:11 +0800
Message-Id: <20250411081911.219016-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411081911.219016-1-xiangyu.chen@eng.windriver.com>
References: <20250411081911.219016-1-xiangyu.chen@eng.windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: aac48e1b-f909-4ca7-3b11-08dd78d19303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9FWAwC4fy8yyLF6mJiknrsghyxkw33rwy14V0uaOzey6bF0+hWMKTTBnYrUx?=
 =?us-ascii?Q?nMI8oqiuIyP2SxjW+oQtKS/uHuHy/Dc3DK99MVXNCqJJxyMRi2ImV3k0KUrY?=
 =?us-ascii?Q?1C7c8lBAnlWooF+HzhKQz289ipI3XNX/3K4mqXk2pKfITUXJRIcBhO8LoKqc?=
 =?us-ascii?Q?TvHGbAsBcfxxriHUV3KVHrviSKRrBzapzewokz2eJHDR62QJqOf7gEsYXkXx?=
 =?us-ascii?Q?wxOaasQnwNwJz6QuEgdREm0uJBFUpvH9jdptdQrUiAAmrQ8ZbOymsmw+BoVx?=
 =?us-ascii?Q?+yDspiSztOOTsG55RgbzvzeKLCd3HNGKWcuTnfkoJQwtaxm1JxJ1BW//N9vy?=
 =?us-ascii?Q?gNdZeWC6Ik6svX8XtsPqF5F77x7nga4cOu/L+SMqCbT8m8eHlABuLfxFdQ6N?=
 =?us-ascii?Q?DUaehsAZs36MbXK22nIHGRxJ3HE0yGb44iIlYH2CPqHMA36mJnzDeKZEtwbe?=
 =?us-ascii?Q?HyHHO0gf6Yg0MUIxGndOvUBHe0Pa68Ywod8GHJ8tAzs71DaCuDS3GNuvNEV2?=
 =?us-ascii?Q?AFNxxt1cd10EydPJ5KzGx+049KlVc5ancbbf1l49cvXY8MiVHNLYmtIGJjrt?=
 =?us-ascii?Q?753uc7YXjEbuf37uD+SGoF818YroogQJXAC8RBLci0OPQHSkn6fHtCLLHYlC?=
 =?us-ascii?Q?ciWPgBcRCKyXF069zOD60n7lNuJASbcJxbu+Sxdr11DWL4N4cEkL7I49YC5f?=
 =?us-ascii?Q?0xV9P5pZKSbFW4BeURSK9YF8EU9+ETe2NbXcALTShCIb65N4F7JSMMy8ohFU?=
 =?us-ascii?Q?BoGvHZ2c3ELcXI4WjFPdMlr5qZcUlUbKsgkUSy1xx4yjluwQoFJXfpD9CF53?=
 =?us-ascii?Q?0qSCYTPQb77pIzkihuBpTJAU57JRN8j2e5FgMxEA8YiRmNnoxTxt8Cnr3rzY?=
 =?us-ascii?Q?YZWZ/kieK3ndp8dMcVd1n8iOJKGfuyB60zGa4EDvMKeEDVn14dS/H1b7Mg/x?=
 =?us-ascii?Q?jFjV+Lm2hmUEkLdv/nxiKgOzniU9uiONWMTTtQMGABVbFHuVlcL2BHdLk7d3?=
 =?us-ascii?Q?cq0wZ3zUVYD/4/hC8rJEZywVIPkNeak4HruXQ46hjgGz9XfGHWHdObYt5Znh?=
 =?us-ascii?Q?IwJfY9VasaEwknGTDpd3/wPM19WdRdUEySzg09QTTf1A2GSOB+riizPbGRoJ?=
 =?us-ascii?Q?9OgpWGHXOk9XvFOIEGq+WrZaJtZINoty5HRqaJDg3H+vHfho/h84SWsrr4Xy?=
 =?us-ascii?Q?lMPc8L8NjXmB9swl/bS77kBPhL+1uH/lM3e0H8pqHcr9Ot5+YOz3Hj0Ueguk?=
 =?us-ascii?Q?pMwrhk5woOl1ACzCY2kD+yO6RXQ3/UJnny0njWKfYo4ZOSjtBGCjjVt57Rnk?=
 =?us-ascii?Q?MD+/ZnLk4ctTBUc7+G3pzf0NH6oznLS4Kd0NjC46dboa5wU1l0hFxoi51GAk?=
 =?us-ascii?Q?V01kAQbVxAdu/awn8Ulp3YSRmy1CZ7tj+H0QR+svMm2M0/3fmPyN3IjnpISZ?=
 =?us-ascii?Q?10zN60oAPpA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBYz62firtps9fnimyZgWh9Y1LqnKkxy6LnOaEhozk4JM1AIcwcw9WpztYH+?=
 =?us-ascii?Q?hLNBoAsGiOQ/Fldwy3A5REPGxbiGG59386J9bXfYBMb4g4Tmu9a54yum08Y3?=
 =?us-ascii?Q?cE3z5t2o6nKs3n34ASqOduIOvgrCSKxQzdDywXxvwTaDfleF0gIreaivCjO5?=
 =?us-ascii?Q?otlUtHB7PUG9UhtUCL2DtB50XlRQXnZk2+IoN8tMKQuW2JS08iVKyhij+JPm?=
 =?us-ascii?Q?U/ZzlfAlf2vVAvTtDnf/h6vFdRh4vMwO4y3XOZ2MY0rsbKd6KLU35+KHkzbm?=
 =?us-ascii?Q?+yJQcUSV59Rc+misqqG4vwgjmaSq5Fkikkas6+h8Y9iKLCfb9NGepVXWBjrX?=
 =?us-ascii?Q?Xh6ZlM658qYY3o8W3JKMIfOpHojLY690z+1OZvy2XPfl4aaAVmUSJgMr4aG4?=
 =?us-ascii?Q?zO8ezbfuVbBpDQ/h760YvM4pWaMkrLmmZ0WVSKsAV6uE1+dCEXp8l0Pv4oAw?=
 =?us-ascii?Q?gfvDfhSjFljI8eoHSz0fOH34kqpjOohJTCrea/aKh510xldfgTJupJUUb7Qo?=
 =?us-ascii?Q?k5NkQeFBblnD0jIARRCMUTlB7/BlWylTKjNHrRg5z2AQ/arYtEc+fYOwVKkH?=
 =?us-ascii?Q?2TGd+PPQ8IBj5+XrczDjfzQPti0gSf3QY2BkB4A5eLEhpZQXY07e/who1CCb?=
 =?us-ascii?Q?RlO0sF4hLwos7r/jkgkk4a266hIfwW1gg18IecPMY4oq5b9qHjuMGc+1l3Un?=
 =?us-ascii?Q?GiNkqr6nRQPCIkBAAdJ4byB+Ph3oUTOfQzAHqG+WYlgjxDw9sKJr8hOQTDAO?=
 =?us-ascii?Q?uSTDqny7yGuf4b/B0b515dZbmIlu8mq2uYuToDnIhVMisMOAOk7UNvV6zLGz?=
 =?us-ascii?Q?1UgVoJmUHLG3t4zgVsKlS/QhSS1jY2ccmQCK6/rYOOdmGUSRsv8SeyAvS6ui?=
 =?us-ascii?Q?f5OnCmRMuVvEexsRF2dAvrM70JWjgnsHVgTTmW4mNl5GHNKBPsvzCq9yJC4K?=
 =?us-ascii?Q?PCV223Dgd9sxajGLf0CtsOFdLKNo4wHYc17SRWSkDvn5bVTzaAxKdzUoHR1i?=
 =?us-ascii?Q?TkpYyfk4DHuSQHrZsk2sNdQhnyAeiDPySY1gUiQwuGuoi4gxGRfl3Mwpd/bV?=
 =?us-ascii?Q?fa7NeKQwJVbdnYfH3X1Y49QMgHH9ZmubyjvtzyjiIQ6Co+OIiKBf2vt8fBW7?=
 =?us-ascii?Q?14PUDMX3BJs4b87w4oXgYTF49qkyrmI5owDv6c6aQ8QHMIrTpPeGPDAZnUdL?=
 =?us-ascii?Q?7PPBR6nYEszOj20/tjJzMK/28QE2VF6RxXTyieBL/Sf62cAegjIpt4NcynGK?=
 =?us-ascii?Q?8IwgbVqM0d2MlFXW3wpTQ62G6CaANIHZ3ukVDdCzg/Z5bLHaTCslw1cnRMJN?=
 =?us-ascii?Q?VOFiOylYxpQoGphHikNvwOq/QhRlqe9DhytioMMXo6vgkDUXXbeCsK1Qithd?=
 =?us-ascii?Q?ZAEjbZyGuTBiOWzZ/6i4PtbCIqULEmBHF2E8ECO9nPPcUuZiQUuXQ28OcJKi?=
 =?us-ascii?Q?+b7BZX9881g0Ie0aacjG8VcZlTkaL0ahwAB9cd+hHdz1RW1qCqVdGHIHlKQ5?=
 =?us-ascii?Q?fSZFFy7qYF3D0QPNbXBs3j8Y6XtY9Q8AcFG3+wowGnI2CgSQLen0FusEly1s?=
 =?us-ascii?Q?w5g4OmZJE+w1wPaU8JnmwejblfKWZ8NKPtLB+59KpqsXeBetzk3BkMgi4cmc?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac48e1b-f909-4ca7-3b11-08dd78d19303
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:19:26.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlj852Wnj7W99RbDQKNqNVPjhLrMWifyPuG7DT40LfPNH/65794OIWFnWPFnKqox74RYPnBVBlpD+NBYtI+oRx9w4Dwka5NqKiw8GzB84vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7727
X-Proofpoint-GUID: QVZB_I0CcjcSDK5HmJXHaQZwZY51anes
X-Authority-Analysis: v=2.4 cv=YJefyQGx c=1 sm=1 tr=0 ts=67f8d091 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=edf1wS77AAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=LUACZsOYbq23hAV1XZkA:9 a=-FEs8UIgK8oA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: QVZB_I0CcjcSDK5HmJXHaQZwZY51anes
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
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
index 9d7800d66200..522a5d85fbf5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5185,8 +5185,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
 failed_mount3:
-	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
+	del_timer_sync(&sbi->s_err_report);
 failed_mount2:
 	rcu_read_lock();
 	group_desc = rcu_dereference(sbi->s_group_desc);
-- 
2.34.1


