Return-Path: <stable+bounces-93931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3DF9D218D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DA11F22755
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7141EA90;
	Tue, 19 Nov 2024 08:27:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201F197A7A
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004851; cv=fail; b=cMLTp1+9MibDN8t8G358urbgB49Ara2VbzxQZAbNss6rJamt4GjLbyOQft5mXU5zduoX+qq3dIdvEnGzktqY6uiODtdpOK3bDBtaX18h7Sy2ywHS31yZhHsWSoV3wFNsJGnFlztCQKTeQKttBtipD1MNzYlV/zOmE6KlYIelyEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004851; c=relaxed/simple;
	bh=tm3PKguEMHJxcQ0C1pyH6Vzn/Lfh1TrtbWmXFagGiZw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ffnEp5JJxkRYAwZdWe7igS6V020DHFe0tV3mjEBvYgXWOebTjHKTXjbJsUd6g8LSzsLKwh67L3SXuZrVuJ6E46OfNc8tbu2nXcOxuaDgsKbr67+ptBQH2sPXhy3GwUQEEyf9Ay+vADLkVBQGGX7L10HJE9ITDyn19t1N1CaZA2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ8RNUm027527;
	Tue, 19 Nov 2024 00:27:23 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xusq2gcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czohqpfaey0dcdDRtGgS+MVyQwdgOgelAS+tB1f6zr1/PrtoLYZJL84nraKqFV0QZRZuVXnnGENgAVVW6OAriqV9hz8pVeI6oWpCGFE/mFQX4ZoOZ+bZaEmz5GTEN9/wlUlast83rjP/sL0zAygVXSKwdOsp78jqJEDo7n0OsJuY3dD5/GhBNhJS4uaExegWHbFsoswWLFtQAnI0toMvQBA4yCab8EKcHHIVGUvqYfXzVLYt0e01qA7JLxIDaGoUS0khqe+W/gUZvY6lc5V0nhfyClPirBHcNseGmBtyiIs1URhNrQvMPF1CQbB7utziG2XrlXeO8i0fc4Kdc5xI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q904kQvMCpLPdQQzjDIZe0sRGmdfU4+7VYuiixNow8=;
 b=pPpqcRPM/6JwguH5Q73HRNo13Rjt9ayFavyc8gx6BP77v0RG361Ns6ciEhj8up1aX6x38mBmPsIYTVNHU5hdaO6FLpJvEJBsieMoSF04bi9tIzQlhYZBmpsg7eWyDf9rVFc56bc/S4/14j63DhYKHU//8rpAv7JwDOmgH00H1+Ew+L3WK6XjEZWbfn8MGnj5nW0z2sDWdHUvqddQqf/JE+65v01qU8GFaTXjuE5FM66dJ8qUgHMvtOIFQ1boEJfqns7Q4+x8sSFpfs6CrRLSlOOxD67soQ4CEMZYhWFT9tYt5c35zxlZxSTw701fUjVHgygSKOsWsdn1BF79C54Dnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:27:20 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:27:20 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: christophe.jaillet@wanadoo.fr, yukuai3@huawei.com
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 0/2] Backport to fix CVE-2024-36478
Date: Tue, 19 Nov 2024 16:27:17 +0800
Message-ID: <20241119082719.4034054-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|MN0PR11MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d49b57-1ed9-4a2b-6a25-08dd0873fc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MAnwRoge2GcxjiOdMsXybsJGuaG7aOZmqcuMx8k8reXyLCtj6oimOTrKOoKA?=
 =?us-ascii?Q?2oDM5ngyuno0Ti4UPnpjm5Ty75iDtB6CpONiHZEQdiSMsWYj/XlTLWmwf97L?=
 =?us-ascii?Q?wjSWLbV5LNim1MNz2kuKvtYkC0SYBlNPD3G/VMFRQDMIexfS6HsQNXx5JIdB?=
 =?us-ascii?Q?AdIZilA0vxITy18TEb5Spto8fRqUGv+UEk+5stLD6043Ffd6yyksBwyFKuLf?=
 =?us-ascii?Q?8asC9VS5InjWDmmkHF6xz7UN2xc6xEw4SeGqlzXJHvVrz1WWx7/ILlii4NdF?=
 =?us-ascii?Q?xQl+6PtlngAbcYZCqSCxCtAQ1eldHbQCveaedpAqXdzExiF1JCmgnYe3Y731?=
 =?us-ascii?Q?1BwztHGLUgP5dmK+zlIvRx1pSG4uN/z7eUiTRIx+T8MlScRYMSTjHp+ux3hK?=
 =?us-ascii?Q?UQt4Yetc/1IqjfNrhGbkc97/luS6CEYfaOoCqjNJgO/3nOTpweVaElFBcFML?=
 =?us-ascii?Q?NyR7kO3vW5jwp/3MSe5zbIAnanxmbc5bMSe91Hgd/f0J5vBUGYr5yOWyMB92?=
 =?us-ascii?Q?HuMztC5mDJd3LuD0NdnamzDRrrvApPRybj8R7b9mQO4FW9RE7QDGWo0GJ0cw?=
 =?us-ascii?Q?gLU9szt+KPl51xDO/64AICgnbV6AHt9uTMtDxCaFNXF1uI1spOWk54Dxf9CK?=
 =?us-ascii?Q?zTv7gGyx1uhKIDLjatttizB+WOBBuNx2AqSFMsrx38lTK4zHIt5aJLrTwk6E?=
 =?us-ascii?Q?Dkudo29AXQnopRGoGA0GJJkWinAlI7Htg34xyc+U/7Xl/O5veFpg+mpWreHT?=
 =?us-ascii?Q?cdddNsqQhBa8lzm6hVeswohKWBXuO6yKTinuHqcNRqmWXQ/7QjVcRXTNetzA?=
 =?us-ascii?Q?23UQALTLLNy17eI1jngIVQJRzrlhJcWRStsvm0RXuD3jAjfpXKfYnnlOuTDo?=
 =?us-ascii?Q?K06xQ8//XDUXh2nX1Dvb43KrqckK5nSdwtJFNMCZxVmtY6rdgUaMPIgXhfLu?=
 =?us-ascii?Q?612nWsvG0iNpz4pPpORLc8XULTHudfZibozvEyimSaQPXHzV3O25RYQmjirS?=
 =?us-ascii?Q?8JZeHx4nMgpwtDSXNifjle+82K6UQOE5fnYXbWnBL9vyCbQo70D/L6HEp+b/?=
 =?us-ascii?Q?duMTtPXx8oNQBJR1fnP+glyYTCzjW7DYqp18JgrPAGDDncMrmJlcc41Hb0Jg?=
 =?us-ascii?Q?PbnsPxbHASt4ocSzxb28e/U0Sd9e7BOfObo+lmoPEn1SPTpPL6KH1cdRTZK2?=
 =?us-ascii?Q?FW/z6cfUrReSvo8O1SdRwMlUF0wyjTzwNqvD3SxfLvKoI+wzlXJ1fDJ5Q1Kx?=
 =?us-ascii?Q?KC1j6FMzCTwoolM/oL/x1Ypb3uxetco7Ux/YviPdIecPmEwp72tzPxJbC/LV?=
 =?us-ascii?Q?hICcXLxFHTKtJcTQnJbxusa5vSfVq78KNZnE/EyGUexVw4F1u0V47lSVNx74?=
 =?us-ascii?Q?DQWK+XziSBqKKBEw/5fhpzhs0zqK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnyWIwWGtGqv69U28dBfmG7RD2AcOZbi+wd2n2vvEeKvSSPL5aGLE+xasFlr?=
 =?us-ascii?Q?wlas8TsgSGtRdI5RAWdAXiBog0rMuFifRonPt0o2yTRbgBjW+5wSSimyjEH7?=
 =?us-ascii?Q?nmPnGAzQ4Jm7uGc7YRcLkFlKu5A+iMzyaPr5mX1plxY1wS1Y3BSTpna30n+9?=
 =?us-ascii?Q?J00ziyPmUj9c1OCK6zEPooeS8kKXQzb4ozEE8jHu9bH6unlfmhfKKIytcyMU?=
 =?us-ascii?Q?NLzkQ1QRtIVY/RO1HHC/+eJnEYABMPLWWCUHGPlw4/uiypuVMW8XfUfI18NX?=
 =?us-ascii?Q?W4jXmuTbDPzcu38wIbGtNyhpg3qYSEaDBcVXSKxmvW8v+RoIfp005+0/xXTT?=
 =?us-ascii?Q?ih6U54VXpGfFud9MlzT4wugoq6SybmRqqzF7i4stM2C/iqpBjFwzUPycJTYD?=
 =?us-ascii?Q?oK0RT7T0grCk34xuTvHXpNLqp3RWm/sT3rE1T0f9pwRGc7bxQpArg2dKePyU?=
 =?us-ascii?Q?gaUNxU7uSgMmhJSPxYnUzmQb+c9ennz53+6SXv4Rw/uC78flHQYDrPQ83D4N?=
 =?us-ascii?Q?Z3fJ8BpSDbkRM8XX8HEpuoqnRoX0HF4645qyZQHJmmir7Q30UKxJgb0Z64ny?=
 =?us-ascii?Q?qbisb1eE2RVfj+ezpX8t7OMmy7vIK8nGtL1jOBnWBl/GP1RlQJyTXEgbZ9Rg?=
 =?us-ascii?Q?HLzA8hngLwiw/F71r53M1DUGk0/LirKHgxofi8DErO+FYpUpk/msc7SsxP8f?=
 =?us-ascii?Q?eWxqWr5wt0MzxDrtudvwPUYMzv7lCXg/Es8RR9U6wjC1OMmMNEQnHCEWbZzP?=
 =?us-ascii?Q?AYTppaLNj712vl9snh9+wQejpneO0v9Fn7OFXmpuVYf9UeQ5Q/GzZK4EUCSt?=
 =?us-ascii?Q?g+YdOGAVzc6bh86CehiFj3A+TmLUOh4MoYqg3sT/M2IWm0K7Gz4HxF5FO+co?=
 =?us-ascii?Q?VMXLGYFvMxHkyPDhDBJ+5yiPgqxag4Vbwbeb4RzobAqujEJgaUn9O39MjO5C?=
 =?us-ascii?Q?Xs08AanLjqqpJ8mVvn5o7+QW8+3TpQBu81pTnbwnAe4lQdVxdtRBYrih+bGM?=
 =?us-ascii?Q?Jd/eXsIwSDtjXdArNPlGZUOg3FMQ+ys65O0y85J5au9f7AL9x9V4gVdubvrv?=
 =?us-ascii?Q?eJnk9lpRoAipsYxM+2vaWwj11gyF9zKImIeMlP893r3oelhDsz3M78hujHOf?=
 =?us-ascii?Q?oGCwI70uqh9cp5cGc/BBncsCkMkVLH3ilXuq3YwmLtk3hQA40JhmsEgMZjF8?=
 =?us-ascii?Q?B2jX5fbPpx+0+TZTnpMnD0DVeW0cAosvuexRjDfPSRg0/PbkfDPiaekgMqpy?=
 =?us-ascii?Q?LJHqu09siF8L7WTmMaP0kXNS+4a9/US3clxasTqbZSGlV5DIOoPiatsruT0g?=
 =?us-ascii?Q?vQHdqbmfIVyUJnfVOSsps1WNZFqX/vCAU5c6Ygb04ckvk0fUIrHd3LNThlJP?=
 =?us-ascii?Q?zuc3KlZare4XmBj/G6Y1YmwQY3h5QMkmSOVscXfBnMMq7oeOqWkDQicLtZ4/?=
 =?us-ascii?Q?T/F1o3Durl5CIKyasX+rl61uqFPE/YlN0g8/7B7hjzatEtysRx2XmS26Xmhr?=
 =?us-ascii?Q?AP8rSAFQIDmkbCr5Q2wjGmykYE6WCGoXMr+Cj54RWB+Apy99jfI4LOcV4AXX?=
 =?us-ascii?Q?/pfg7PYPT0c/QIJANFFUytbveoOjLka+oMcJAbG/KOJeko/1mljc1HlM6OsZ?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d49b57-1ed9-4a2b-6a25-08dd0873fc0a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:27:20.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmEqeco2G2EmqFkxphuWTJIcn4VFDN6/KfekCWy/N6XxyLXtTrZg3xJlUidbX6jj7nUe4AQtu81HJLsKTDXmJOWbuzP5gz1nrCNtjPjEdHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-Proofpoint-GUID: UEGkTRO9V_ksznnhu7aF6S8PnnyJJNfC
X-Proofpoint-ORIG-GUID: UEGkTRO9V_ksznnhu7aF6S8PnnyJJNfC
X-Authority-Analysis: v=2.4 cv=d9mnygjE c=1 sm=1 tr=0 ts=673c4bea cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=ifpdVBqWFMikVErx1-wA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 mlxlogscore=831 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190059

From: Xiangyu Chen <xiangyu.chen@windriver.com>

Backport to fix CVE-2024-36478

https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/

The CVE fix is "null_blk: fix null-ptr-dereference while configuring 'power'
and 'submit_queues'"

This required 1 extra commit to make sure the picks are clean:
null_blk: Remove usage of the deprecated ida_simple_xx() API


Christophe JAILLET (1):
  null_blk: Remove usage of the deprecated ida_simple_xx() API

Yu Kuai (1):
  null_blk: fix null-ptr-dereference while configuring 'power' and
    'submit_queues'

 drivers/block/null_blk/main.c | 44 ++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 16 deletions(-)

-- 
2.43.0


