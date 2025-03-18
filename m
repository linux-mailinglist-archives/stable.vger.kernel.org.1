Return-Path: <stable+bounces-124755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F8CA664C9
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 02:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3856C3AB833
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132078468;
	Tue, 18 Mar 2025 01:15:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D92CAB
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260553; cv=fail; b=oLtTkxG8v8FVOWrUdIrT+tzhaVGQgQ54bfWOQASFm8ec+gzO5QY7oYuzqiA/SFoqxYwPZERPofMb6Q3J4mNOHZX0eDPEVsCi1E4nWW9w8XWmjcFoJAidR6Pc61seLv3jEj2+WdPFgqM3KifAMui6YB2sw0S1hbNTT7nbAzMudrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260553; c=relaxed/simple;
	bh=mIs7ACMyBRJl6N4ebIBY4WIwvTLuGaf7C5e119GJCBo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ek7bXi0v3sEh97b3h0qxX9PXZaDkhGk486Lza7sSGkyIitCeUTdrGJ20zmypeHFl/ADRk+Skq7HZ8CEiBBIXnTZGmA+4srZaGGUWVbcUTCodnulz31+s09JfhAgJNG3qckOk3vvflqoFrzrk0oS+pycsklqyGc0Effl8NBgXy2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HNhZks002630;
	Mon, 17 Mar 2025 18:15:44 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45eprr8fg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 18:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugfbhcVonEU1fwbXp6WaGsNMnIlda6ZsjLYVGOnOUPoG1LDLKpZedLZ0Cxz99E8lCiXt2E2KfYkcvmO50ADMzbmA6WEU/KFr0VCTGuBkWaKaR9EiI/bk+9C6sRxMQFWdVQQRUDaCzMy+YDtiI4s6f7c8LxhJYaPg/Mbdx09CZi0Gs5piHmKlbx/l9zJu3l5vhFh1FKAYLgQdTMYvJLz7uA/bmV/TUktbuI+q3fz/XgPakFKmtJYsNt5pKzrPCQznSIqnqaIdp+5XKY8WdBwqgA1ztvK55q7IYrRj0uQNkG+fhNsqRl7zmU4goT14oeXv4NzzA267KT6m1xLqOas3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeapoXcCcx0Q4I4fNBUWtWdQGk5MDGMndCKMb8D/98s=;
 b=tG+MWYw5yYQlIZKTNDvj/UWR6XLY52oyNcNgsvdVUEZnw588QS53hCI+eGtESwzVeyyyul0tDEQSuKitnx4VLncSDqODx94jVtOSRT1ocTMN0PUITwDnYkowhoAf/eKu59WxI6CJK+aOTuJsdzjvJ8c/pd4JpIc+L6oUEqrmBFOa+C4Hd1SelpKg/jV4Gq/moK8TfZwD1d5nqCP8M/w0ppotGhP7QdKxNy0POHxXhmjjMxkYnaK/Dli/gXtbizKghQ436zKVdqWQuqQR6rvEejdDQIeTrRMRHFHtJy7SYbxMuGei61V/3Qu84Q2Fv/80OeH8RP/GZpKXVQ6tvReGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:15:39 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:15:39 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>
Subject: [PATCH 6.1.y] drm/mediatek: Fix coverity issue with unintentional integer overflow
Date: Tue, 18 Mar 2025 09:15:19 +0800
Message-Id: <20250318011519.3924779-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0171.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::6) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|DM4PR11MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c5470e-274c-4e2e-9716-08dd65ba64f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8fb0uPqBCcXzIHa+1JCQ5PMs7Et1r946QtyKJi0gkTSDE2L2phnMOXbMwIM?=
 =?us-ascii?Q?AwmOBQSGXCFwgKMCM0wWq+EeY9fKejdADJI7QAmcTZwsmhXAG4WI5nRzOoJ6?=
 =?us-ascii?Q?P5cLQi3gTLw9RxwT9FOvTXIFKLLp5Jboao6MF4DVWWKtj6c79oHVncRyG3VD?=
 =?us-ascii?Q?P1YItwxCJddXtItmcN52+k7f3+etzFv9KAZDZdeeBTKUQqFj3ddp3HaRGlo9?=
 =?us-ascii?Q?IuIf+9IRSkn+oQOp7b4gOXV26zxsIwZtPFPC/TleXCrzNIMBxkxRNgfwuGaM?=
 =?us-ascii?Q?ctyTbONrNQ0Q76rqB8l8QvO+WULlDV8G8isg40rzH4TB4VZXL+K3/nirtYYg?=
 =?us-ascii?Q?1bcEdyRxO3jc8bZtKuDm+4g5zqIeccdTsgfvBSxlFwGHD2UjyGCElKvPDhHp?=
 =?us-ascii?Q?5oCOtHp0+gKbxgCI4++QQj3MP6veFWRg0kiXnQqugJM10L9pxv6Zqxbp3KQb?=
 =?us-ascii?Q?bstarkrSY/iptqF8JC+sIgHVv6QtFUQuXpm5Wuj2G/4Kda/RFecrUrLNN815?=
 =?us-ascii?Q?Bc7L/9llOMcxIv2rwk6C0nljvf5NuvHXYZWw5R7zmPiO7Pldg/awm9+IZxE/?=
 =?us-ascii?Q?OKG3lUi2jVqToW9mX0vs0qi4BoJQkOCvfvk3xizGWSCQ/nRRFs0jT6NiDhjI?=
 =?us-ascii?Q?LZeA4c+FvPQjEYGUDPRdY2x2Jz+44/tbQcHl2lDe3luaoXe0sqYZOO2SvV1u?=
 =?us-ascii?Q?7eKa4k3SqaNVuQmKWBiwp++ZXktbdtNOr4ejehs9l85JmJmhfPS3cWJ3DUzZ?=
 =?us-ascii?Q?bJbhVrD+EVHx7uzZmGuAYnE0hNFrDf6S9Cb5gbDgofiMLQi6gG4FQ39ZPDfD?=
 =?us-ascii?Q?bBL0ORJBQaaba8tXaY4z6N++KdUHzLM6Rrf5KAf/YRNvPEYjvGlx4sNgp+qC?=
 =?us-ascii?Q?2IbIGy3/uBBLsOqeM1T3kq2aFKv8JC6jU46H8ePKoyYs0kYFci9Csporrtbt?=
 =?us-ascii?Q?uRuJjWUwjxISdlwaj9m0wrVfUk6gxOsWLR6kIsxXAQKWJyE0vDuub+oWmNLC?=
 =?us-ascii?Q?QYPF1hEgo1gsA8m8ENVOPruLOxy79Z0D1s6Kgr8eeMmtMdD4VZWoafn0PJIH?=
 =?us-ascii?Q?iFfJrpli32DAyarsSrITFFL7vdsOibyjGBguRNwFQQLIZqQmqu+8YBlQMdGM?=
 =?us-ascii?Q?QKf4xEXCYbMHh5nYdUFvMsCHrA2dloKQOK1+xKfRF7tJauR53usTsU408jh5?=
 =?us-ascii?Q?iMIRdDH8CaDnMNILZ10Ly0UZheC+M0x2N7O/xAlOPcX3Tr9MwOGMJYFC78cR?=
 =?us-ascii?Q?hLc7yy7G1dI/uEAv03CH31u65LlFn7vRegJeam2WlyLu5gqOZY6a83we9Rvn?=
 =?us-ascii?Q?ba/+dXBul+Ti9EghU5yW4MON4gVw/zSDu5eoJqyMHdY2LsusOnlvzm76OsxQ?=
 =?us-ascii?Q?NfxS06wINV8tCcPsZz8ML6qaDgzEQth8wFN6N/BCF+d91haMGQKG79LZQyP0?=
 =?us-ascii?Q?aSjLN1wCSmkxUQy+zvFnXaSfb7WChrQx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TpEEwAZcplkRjLgf2Q/THeIfIJbZIC9fqwzf/LonklR4///Tawgfxw2uwGC/?=
 =?us-ascii?Q?tXunf9Gfw+Z7PXXNzV1TXljTuZAqjSNIu+NO+a5hcOC/mR+7v9mEICC/4RFb?=
 =?us-ascii?Q?4T5lQxBNwN9iM+t1spEjgCzHQiJvpWq+9N5akf/7IGvBst3rvfivsLvUU/lE?=
 =?us-ascii?Q?G+PHbL7Y6WHoRSatcoinKFMyC/u4NpwzIcmQv4E6b2As9m1eE7IXG0faYYku?=
 =?us-ascii?Q?onfCBrM+Wj7Ivi7RIQ0facs/32w2BiUCraW8JLCCJUfKUXkk/Cnvr/TTODtD?=
 =?us-ascii?Q?uXB8Fz0Vpd7SvKf6GPYm04KO4+RzYrLVJW4MtPF3qUW/tzxRHAi/278BjxoX?=
 =?us-ascii?Q?Xr6yawBYLRf4NQjP60RpYg5c9fuPT1rim32S0GN1fT20cbSzKSac6mVxnMvX?=
 =?us-ascii?Q?hGqZypaimdo83yeMqS1KD4dua4kZV15VJagtDjMmq2PSVTmXJOx/4WcYj9EG?=
 =?us-ascii?Q?F9cuqdYh74/xjQScWgaUo0eGUmJKY0qZ56dAwNqs0CARD/YHqAqPFcVN3jIy?=
 =?us-ascii?Q?vq39krUKxWP4A/KjjachOE4LwemvqYvQo9NkJLCfOdWCyohQj1B5mB8HuJE0?=
 =?us-ascii?Q?xVaaZFTuZUbcVr/qtN1oBh/pq5SKP4jfMBQ2Q3HGsc/qkz/nEtDSES0E/RWy?=
 =?us-ascii?Q?9GvacnT7VqXODdcyTUFf52a9BInbJAGgCRT7zkjIcYgMwc2ZsuoAXjSDmyjo?=
 =?us-ascii?Q?iJKCw2lwKqD7nxlEPnv1bp8GtXFqDXpJjzyqIYM50yRyAzBjBzfnN0Q3M4b/?=
 =?us-ascii?Q?SS2iPfynnv4Jui165tCgpKLGCv4R3Hd/gK85pyHsXy6eqxFeG5XmTjd749OK?=
 =?us-ascii?Q?mNlN0ejQvc7j0sggHL7+swFqTeMLiYApj+/Uy+1dJIk+lHrfWMPJBT1OgJbw?=
 =?us-ascii?Q?nnKBgI0ZcEXI3enGxS2+Ersbb8T3ZZHv5KZS0EQtqFhW8VgxfgtqpvKD55Vk?=
 =?us-ascii?Q?NY19ndOANQmO/xKoAPrw9SkpEHnZ73GDQnjwp8uI3QjaXXxNSoPt9xu4CUxa?=
 =?us-ascii?Q?k0yWZ7WYep/Lie8aCNgoGYMyRDsNJLyvx1rm8IxXAPZPRtD2lg+fGDWrT1OC?=
 =?us-ascii?Q?Nd68f94qHBU88jchmD+vbDko9NWlpa3q4QIRx9myBTwA54XGXJjkcxpi86Xa?=
 =?us-ascii?Q?WiU5lh4xcVNW0ofSahwZgabCtkWIs+OBhXf4H+PLiMszF4G1RDx47noWYMvR?=
 =?us-ascii?Q?e8VpJz3NjGOvxJ9ioEuWYz2nMnsZUYendt9vKzLF96f2wy4BLfp3Xie8qTz7?=
 =?us-ascii?Q?d6QF8h4THrrTsg+9V8ew4jr82CTxRQgduKQLTB9073ZD0MmlFEHN5I8oQj2F?=
 =?us-ascii?Q?rBytjubMUTHQCCKzx83HVJo6e1CIZlQFQDCDaYYIu5EA4Ob3GGMjQiI5Rzus?=
 =?us-ascii?Q?u3MDrFIdAQazSvvzPjjFd90GxF+3P6c/NjrB2H3/AEpcWLd3V/kWS366eVG+?=
 =?us-ascii?Q?2logt9fh+pqUcafkAbe7jn+AMcs9tbdbJUdx5/wK0VBrPljgEhxJ4dVs08+N?=
 =?us-ascii?Q?TyKBKtnEhiYiuITtOyxZ7RRuRtVxrTNXponq8kjobnRx5+ecfZSTn1X1sPRS?=
 =?us-ascii?Q?1E+vAjR/K9sa584Sk2XZJvBTitzI245NhvQ7LFf5n3UJeF+kLXvIXu7AJ4/K?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c5470e-274c-4e2e-9716-08dd65ba64f8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 01:15:39.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nKWb1WNobrwSgt/IDOgHlcERJQLgwTKv1XgI6xIxkDoBTyMzJIXQLv6emgUoCyfVvcoCwObQKdRn+aaxWznm1ava7U2wNpAxHDXlfqGnhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-Authority-Analysis: v=2.4 cv=LZw86ifi c=1 sm=1 tr=0 ts=67d8c940 cx=c_pps a=qvBKVd3KFl3zkoLf5jvq7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=mpaa-ttXAAAA:8 a=IpJZQVW2AAAA:8 a=QX4gbG5DAAAA:8 a=t7CeM3EgAAAA:8 a=cLeGU6ClKJDpL31gtAoA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bMwwWPSwDX-45nxup8cFTkucctd5AFi2
X-Proofpoint-ORIG-GUID: bMwwWPSwDX-45nxup8cFTkucctd5AFi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503180006

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

[ Upstream commit b0b0d811eac6b4c52cb9ad632fa6384cf48869e7 ]

1. Instead of multiplying 2 variable of different types. Change to
assign a value of one variable and then multiply the other variable.

2. Add a int variable for multiplier calculation instead of calculating
different types multiplier with dma_addr_t variable directly.

Fixes: 1a64a7aff8da ("drm/mediatek: Fix cursor plane no update")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230907091425.9526-1-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
[ For certain code segments with coverity issue do not exist in
  function mtk_plane_update_new_state(), those not present in v6.1 are
  not back ported. ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c   |  9 ++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 13 +++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 21e584038581..336a6ee792c6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -119,7 +119,14 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
 	int ret;
 
 	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
-	args->size = args->pitch * args->height;
+
+	/*
+	 * Multiply 2 variables of different types,
+	 * for example: args->size = args->spacing * args->height;
+	 * may cause coverity issue with unintentional overflow.
+	 */
+	args->size = args->pitch;
+	args->size *= args->height;
 
 	mtk_gem = mtk_drm_gem_create(dev, args->size, false);
 	if (IS_ERR(mtk_gem))
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 30d361671aa9..fb062e52eb12 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -120,6 +120,7 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
 	struct mtk_drm_gem_obj *mtk_gem;
 	unsigned int pitch, format;
 	dma_addr_t addr;
+	int offset;
 
 	gem = fb->obj[0];
 	mtk_gem = to_mtk_gem_obj(gem);
@@ -127,8 +128,16 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
 	pitch = fb->pitches[0];
 	format = fb->format->format;
 
-	addr += (new_state->src.x1 >> 16) * fb->format->cpp[0];
-	addr += (new_state->src.y1 >> 16) * pitch;
+	/*
+	 * Using dma_addr_t variable to calculate with multiplier of different types,
+	 * for example: addr += (new_state->src.x1 >> 16) * fb->format->cpp[0];
+	 * may cause coverity issue with unintentional overflow.
+	 */
+	offset = (new_state->src.x1 >> 16) * fb->format->cpp[0];
+	addr += offset;
+	offset = (new_state->src.y1 >> 16) * pitch;
+	addr += offset;
+
 
 	mtk_plane_state->pending.enable = true;
 	mtk_plane_state->pending.pitch = pitch;
-- 
2.34.1


