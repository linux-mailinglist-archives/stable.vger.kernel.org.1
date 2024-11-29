Return-Path: <stable+bounces-95776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78419DBF7A
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 07:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE55B211E3
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 06:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591761547FD;
	Fri, 29 Nov 2024 06:27:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A833C5
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861659; cv=fail; b=PkSkNrC/R2HdkCiE8IC3aiMwJQ6AzXMXJSEcHBZW+jIBDIxd+kPB0ZM5JEa5i9ldO0aOrjXyeMUQipt6iYlT8+q+N3411a4JU0QBODt+8VUY+l3Lq/hSNM0tndDXFCW7yo9Ywlhw67ggklF8n39Ir4TDP3uBmRFIwBz+MTADruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861659; c=relaxed/simple;
	bh=Y+QgxVdvVet0lD5vt5Lvq2/jBj3bvWNnJJqCKjRVAGs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LzcVYahQQBQEFwwUNaiXFvqpR54ZVcX6J5ezregcq6lWyBgbOKAMYW8CEbKNepKMrJmRY9EKJAl7N+b38Xcnwgb79SDFCZpOfQP8Wk+JGudbDt0KCBOXNDzdMRBjTBZqFKSVOy7R60dn0KJu4ByIrdGFrS7BCHuSuI8eEoX5T8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT5UgHD012523;
	Fri, 29 Nov 2024 06:27:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43671astay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 06:27:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyXCKKRkEYAzYzsDimggzC1YyuUINgfOPsUllCH/QB0n1PQXwWskfGWIW7JZmfWwIvz4yO4VidO+8WQm+t4sGsdb1gAlrJix0i29sttkeZh+/ezpCf9cDu1wNHUVlE+AxE3Ap1fh+MnKjm+QR2WcD7hcEQKA0O0gqRklramGAJohDSUO/d9fvfXFyUy6Yx0TgZHobyIUj7hQM1UnCwk7Ocmhyd6deq6uqhf8cD3ciYyAeBfJZplTRn/1f+dyIi0Ll1yv3fdix7mKCzQN8iTU7vHS3SlMV3AB07ieARcjqU2kBFLSF51PAmbsGIkkD/Jzpa8VqkPq/2xss4b5yHPe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=van+O4YwZ/iqqVtlcOHC+HmzEQcPmxH1lkGtaGsqMSs=;
 b=XPiRm6II8zC/AIfXFONZn78VWOfASnyEXQH7/rSYDjtipX3MF1F+on9Qnh1ZdOWo/jCe2lvFS0Ub8OgpQ1dKhMEoQCqDxUTx81yhvKTi2faP4rTENu8CUrKPzyT3G5iMTMLlQORWGN//e73jrEpoY7YHN9UH3A+QPwUcbdydgjB5i+DSgWVLXu9r31kIj/Whc+bRrV1R1LJ6Q4+KaIJyjbB/PN9xiSQs1/5n7jQQY4AkrxoDaXdF1TCAV1PRuxPZpI76q+eE21rnMiETuRrfG9V2dZuehOfZGY1FcUVtWZ0rAZEHCzTeiwXZKnT7uXvwd3AUr6txnCGLaOTP54j1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 06:27:31 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 06:27:31 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, fdmanana@suse.com
Subject: [PATCH 6.6] btrfs: do not BUG_ON() when freeing tree block after error
Date: Fri, 29 Nov 2024 14:27:13 +0800
Message-Id: <20241129062713.1510250-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|PH0PR11MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: a3af4a0b-c3a7-4737-bcad-08dd103ee707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ds1TaTI6KGP0JauVYctkzgZhoTo74pjeD6A1u8hzkd5zAxVf2ysWOvoVUIW?=
 =?us-ascii?Q?ZIL5vQXjiFKuuUoH2ush0JT4HWwhhSZRgGCIB2NXNenuXc+SztqjTzcxk5AL?=
 =?us-ascii?Q?r0vk7JWUHm7rn49duvu3vHkcgw1z49YcYk1W2r+9e8SstlreSvfKy5+DfMfV?=
 =?us-ascii?Q?Hg2fdQj1PaHN2g1sGsjfYbC4lGmVpknOrvbP/rdvctnKECGK0TVSmS+KSKIX?=
 =?us-ascii?Q?7022qb4zuufdO5FMZt4UntwVn1t92UPeMWeOsaqBFbGd6xrZwKvhzUs/iIJi?=
 =?us-ascii?Q?j2LCy1LwQpKZ3wlkvm/er29cnFVpSw9oH6r6odIPv/iymIlV2j95fOGLwD1h?=
 =?us-ascii?Q?pH1HgQehQz9/PrVa8N9vZOTzfZQbJIKR527Mr90nvV72Pl1/AsE5oZGDUeR8?=
 =?us-ascii?Q?zSBqExB3Ar6o9iu98xoPibc7IEgjYD8ZYV87Pv9gdkE8CUlI0DUjGxNDaFqI?=
 =?us-ascii?Q?nZ4AcjQ41Tza1iXNr/DDFyeyfd1drMq7GZMmKLlaBhPqQqGAyXVtBGzTcOrw?=
 =?us-ascii?Q?rfUNZ+wBW1eErSN2dKoQcxvpL/Eet0znUfrYhNEPVVoMccMb09OHzgmRUg/8?=
 =?us-ascii?Q?2Kn+LW4YjHLc4zVAZ0Dyuot3UJhCe445abQBdnMXpFK4WeU/YnK/ln/6ne4/?=
 =?us-ascii?Q?cMrRpgORdM7GlYRPuNRpSWNOUCJtGXb16gmkqZJlkVEqrzCheXZ4DTtG9HnH?=
 =?us-ascii?Q?XDXlafk4ArmMZv4SyF4r96CI4zsl3TH/YgJWko2aWLQJiLzeUN9QQjzZeOrj?=
 =?us-ascii?Q?mQ86XPXmBGWFbE3mKr33U/Qp7U5r9Po0oKnQUdJZx4OYy5bO21AbKHumnChu?=
 =?us-ascii?Q?JM2iB6XZtJaQowwL2J8aozqOD1pW8dM1OPRb07jlcnkoVveoO/EUlSooHRKi?=
 =?us-ascii?Q?MABd92fZAHJvYywrL/iw2A2zsnystVNZ1Bxnj2xqozXS0IuhhtIq6WGLN61o?=
 =?us-ascii?Q?8/2NE3A2JlCiJWek0OctJa18YSSiX/zFneC5jiNvWqn0UW0JTZNkR9T4tmRX?=
 =?us-ascii?Q?CsRObsTvpNGLG80NDfkikyb60ex8XG5pBjqtB1h4hFS4ThmwfY7Dld18bVMI?=
 =?us-ascii?Q?4FA+z+6i09sFbI/gmIEzIqUbeix75ZXgEielHREzs7zTUw3cwkaw6P0WRH4X?=
 =?us-ascii?Q?9nPkZAX0VO7u6aadXkxNoDXp7ohhjgNlKKgxJXpWH7JYHKfiWl1MfiaDaop/?=
 =?us-ascii?Q?UaCyXZTqfx8yPu5P8Ak3JuDydtlpNRsUV6aDW9wdAxLvgNs0OnyD3vNK8KLE?=
 =?us-ascii?Q?da6wta+Vx+2qy9z6Q1tjqoxw3dsH0C+E/OAUuobfJW8Q4Xcu49/BYx3R9yUS?=
 =?us-ascii?Q?mQaSRX9Opm2q3xrZvwcPH2t35FN94e9cH1vutl2PvRxH/7wzWK18y0YhtbbV?=
 =?us-ascii?Q?lnyDZUU7+oqVfTEc21i72zfaL/n8N7ptZaixH/vAAKx8R9pfLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+MsMB9/n0C1bUeEB0ykL4QnPwhwh1hVflmzBqT8xg6mik1qw9GFR5UNGu22L?=
 =?us-ascii?Q?N0VZncGDVfEQWN1/4p9MpUymnRhESqD3eCcEGm94qKLs+elIHHqVnNeUW6JM?=
 =?us-ascii?Q?Lpik8DocVcdHY8I5N0vkZy0EO3Mslb/2a6U5V3UXhibceyjTl6RlwmdJf6RH?=
 =?us-ascii?Q?hjyySLFcqHYn5HQptV9hllCbbhUtCFg0XvgRuXk1abbux2KfnXDi8Jo/7yjy?=
 =?us-ascii?Q?UA1HQHXYfBWSZle1/OLo1lJzFQHBHQ+Kzb8gK5hHHnDRt7DXGhTQmqQrIked?=
 =?us-ascii?Q?UzDXYhSfI1rZ+OQGFUhksNOFTJ8puJ2TUeR6g0yTaCLRL10Tvgb19/QZ9fpw?=
 =?us-ascii?Q?ffrtiVqbZckEJRrTvwBHo45IMtAXp2iJLyKEkKeTRitx8lInwI8htAamY8yw?=
 =?us-ascii?Q?nP8HDJA2jQRPNCe93+hrtGHWxHw4zbqmfaGMjGyWG8MsET+Z2nyu5Ac9A2k9?=
 =?us-ascii?Q?C7bMFq4PyCkAfTdAmJHHIc9i2fyC3Sb43MVbkVPTFPIH7gUweouRNsvQt3Cx?=
 =?us-ascii?Q?Rq0Gy0OhJCQjyJkNuOAvN8/ALvbYX1MTw7lkTeWxXm9W4jo+t8rPZZpGQ/JL?=
 =?us-ascii?Q?TkxuueaG7Z6VdQvX9YPAwCEMltonJ8e5PtmBQ8QxCZgst2NSRzuZo9Hn0yBt?=
 =?us-ascii?Q?2E1eBVQEWh0vDS5zzPwW/13suEKbmCQbDyhG5Np9rl8vS91DAENaY+/TqXWQ?=
 =?us-ascii?Q?np0ft+EEazjXQpj8oW7XkOPPd6vNE7yDStAO59LUcJXlIeHKKhAIG/595NoE?=
 =?us-ascii?Q?Qqjk/LUOHVJVJjAs5gOJQr0xY2Xrs/u/iEohCfyPTkX+CqdPo7V8BVI7SWZ3?=
 =?us-ascii?Q?TxRVSQvs90PBj+EKIIVy2Vwi3/iIJD1FCg/A+t0YptAwGBjy5bajrTbv/4Jg?=
 =?us-ascii?Q?VTA3v/FzFEzh6CyGTnzyDx+uI3XeLekE+gJjyUBKwLB/G+C4dOPMLr/Yjb1+?=
 =?us-ascii?Q?g9Ri8hQTTnDkhpr4DpgIgWPRrEcA0m+hxpM0JZ6WIyJrY93kJBvFEV+Hr683?=
 =?us-ascii?Q?4utunXOOEeDth/53ixZm37tzJxVdp+YCRn9I4A+X8DvCdsivSEJhmNPyk7Qb?=
 =?us-ascii?Q?IIkDEeRbWVRgfjAJIyOBm7GzHFQ8vdTWUxH9yrpyNYenLfVW4ZfwsqW7+LTi?=
 =?us-ascii?Q?1taixv8MVtR/lAGvjmvACm4D+XqzQG+sfl2wUiRlRokN/7Mb3pKpiCB61Vqv?=
 =?us-ascii?Q?EQRBfZkeouIO1qpi8FbTg8td5Cup4aMq//+Zeiv1SrksMYHlytaKJMCeubuf?=
 =?us-ascii?Q?7yVO3rad+E0Ntv+NihRsWBEyJzGta0enwlblukSM3C2lN2jotiL7GAK8p0w7?=
 =?us-ascii?Q?OG0WmrXQhKXm17ZjoqmVnv87zNGtSuNT/E/YwRtd6OrFO+IM9E8g6n3x2/9m?=
 =?us-ascii?Q?XKk1+PoyN/jZWF0qAtQlvYrLoSMb8QxOMWT7bkpeCbqCAvA4g2ISb0tv/KrA?=
 =?us-ascii?Q?89OoPDbxklL9shlGzOrt33+tA3w42wnioYe4vb7kjxuRrtrGATdG20WS63UO?=
 =?us-ascii?Q?VtBOPcJTVpPR526wVAIA9TKCCvQkuIvhQ5mjNkgZNp3RpwKL6jOYLhKlFiAl?=
 =?us-ascii?Q?NnnJLUK7iOF841irg1V6H3raGKh9LtT99eH22aOrzKSKJ1Oi1FzTBRgKBSQ7?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3af4a0b-c3a7-4737-bcad-08dd103ee707
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 06:27:30.9244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4AJoXy0R49rtwxJgx4z8EGwitaZn5JXcQUarRbMVt2iWDZF8N0Av91TxZ4BoTcETU/EtLzKk2MfiWBMe7Tbsb67woDDxSB6tHj2Sb4uDeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4869
X-Proofpoint-ORIG-GUID: cfWO5ADbaOXMHnXHl55IUO7FP5-AjruA
X-Authority-Analysis: v=2.4 cv=TIS/S0la c=1 sm=1 tr=0 ts=67495ed6 cx=c_pps a=tpf30LWoD3GURU9dwhXxZQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=j_naUNGCuZfYz9K5coIA:9 a=WzC6qhA0u3u7Ye7llzcV:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: cfWO5ADbaOXMHnXHl55IUO7FP5-AjruA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_04,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2411290051

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit bb3868033a4cccff7be57e9145f2117cbdc91c11 ]

When freeing a tree block, at btrfs_free_tree_block(), if we fail to
create a delayed reference we don't deal with the error and just do a
BUG_ON(). The error most likely to happen is -ENOMEM, and we have a
comment mentioning that only -ENOMEM can happen, but that is not true,
because in case qgroups are enabled any error returned from
btrfs_qgroup_trace_extent_post() (can be -EUCLEAN or anything returned
from btrfs_search_slot() for example) can be propagated back to
btrfs_free_tree_block().

So stop doing a BUG_ON() and return the error to the callers and make
them abort the transaction to prevent leaking space. Syzbot was
triggering this, likely due to memory allocation failure injection.

Reported-by: syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000fcba1e05e998263c@google.com/
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/btrfs/ctree.c           | 51 ++++++++++++++++++++++++++++++--------
 fs/btrfs/extent-tree.c     | 22 +++++++++-------
 fs/btrfs/extent-tree.h     |  8 +++---
 fs/btrfs/free-space-tree.c | 10 +++++---
 fs/btrfs/ioctl.c           |  6 ++++-
 fs/btrfs/qgroup.c          |  6 +++--
 6 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2eb4e03080ac..bb5d317fcdbe 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -617,10 +617,16 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		atomic_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
-		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
-				      parent_start, last_ref);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+					    parent_start, last_ref);
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
 		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
@@ -645,8 +651,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 				return ret;
 			}
 		}
-		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
-				      parent_start, last_ref);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+					    parent_start, last_ref);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
@@ -1121,9 +1133,13 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		free_extent_buffer(mid);
 
 		root_sub_used(root, mid->len);
-		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		/* once for the root ptr */
 		free_extent_buffer_stale(mid);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 		return 0;
 	}
 	if (btrfs_header_nritems(mid) >
@@ -1191,10 +1207,14 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 			root_sub_used(root, right->len);
-			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
+			ret = btrfs_free_tree_block(trans, btrfs_root_id(root), right,
 					      0, 1);
 			free_extent_buffer_stale(right);
 			right = NULL;
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 		} else {
 			struct btrfs_disk_key right_key;
 			btrfs_node_key(right, &right_key, 0);
@@ -1249,9 +1269,13 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 		root_sub_used(root, mid->len);
-		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
 		mid = NULL;
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 	} else {
 		/* update the parent key to reflect our changes */
 		struct btrfs_disk_key mid_key;
@@ -3022,7 +3046,11 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	old = root->node;
 	ret = btrfs_tree_mod_log_insert_root(root->node, c, false);
 	if (ret < 0) {
-		btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		int ret2;
+
+		ret2 = btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		if (ret2 < 0)
+			btrfs_abort_transaction(trans, ret2);
 		btrfs_tree_unlock(c);
 		free_extent_buffer(c);
 		return ret;
@@ -4587,9 +4615,12 @@ static noinline int btrfs_del_leaf(struct btrfs_trans_handle *trans,
 	root_sub_used(root, leaf->len);
 
 	atomic_inc(&leaf->refs);
-	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
-	return 0;
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
+
+	return ret;
 }
 /*
  * delete the item at the leaf level in path.  If that empties
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b3680e1c7054..94fc86c9c65e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3290,10 +3290,10 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   u64 root_id,
-			   struct extent_buffer *buf,
-			   u64 parent, int last_ref)
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
+			  u64 root_id,
+			  struct extent_buffer *buf,
+			  u64 parent, int last_ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_ref generic_ref = { 0 };
@@ -3307,7 +3307,8 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret < 0)
+			return ret;
 	}
 
 	if (last_ref && btrfs_header_generation(buf) == trans->transid) {
@@ -3371,6 +3372,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 		 */
 		clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
 	}
+	return 0;
 }
 
 /* Can return -ENOMEM */
@@ -5474,7 +5476,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				 struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	int ret = 0;
 	int level = wc->level;
 	struct extent_buffer *eb = path->nodes[level];
 	u64 parent = 0;
@@ -5565,12 +5567,14 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 			goto owner_mismatch;
 	}
 
-	btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
-			      wc->refs[level] == 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
+				    wc->refs[level] == 1);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 out:
 	wc->refs[level] = 0;
 	wc->flags[level] = 0;
-	return 0;
+	return ret;
 
 owner_mismatch:
 	btrfs_err_rl(fs_info, "unexpected tree owner, have %llu expect %llu",
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 88c249c37516..ef1c1c99294e 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -114,10 +114,10 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     int level, u64 hint,
 					     u64 empty_size,
 					     enum btrfs_lock_nesting nest);
-void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   u64 root_id,
-			   struct extent_buffer *buf,
-			   u64 parent, int last_ref);
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
+			  u64 root_id,
+			  struct extent_buffer *buf,
+			  u64 parent, int last_ref);
 int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root, u64 owner,
 				     u64 offset, u64 ram_bytes,
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 7b598b070700..a0d8160b5375 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1289,10 +1289,14 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 	btrfs_tree_lock(free_space_root->node);
 	btrfs_clear_buffer_dirty(trans, free_space_root->node);
 	btrfs_tree_unlock(free_space_root->node);
-	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
-			      free_space_root->node, 0, 1);
-
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
+				    free_space_root->node, 0, 1);
 	btrfs_put_root(free_space_root);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	return btrfs_commit_transaction(trans);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5f0c9c3f3bbf..ae6806bc3929 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -707,6 +707,8 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	ret = btrfs_insert_root(trans, fs_info->tree_root, &key,
 				root_item);
 	if (ret) {
+		int ret2;
+
 		/*
 		 * Since we don't abort the transaction in this case, free the
 		 * tree block so that we don't leak space and leave the
@@ -717,7 +719,9 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		btrfs_tree_lock(leaf);
 		btrfs_clear_buffer_dirty(trans, leaf);
 		btrfs_tree_unlock(leaf);
-		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
+		ret2 = btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
+		if (ret2 < 0)
+			btrfs_abort_transaction(trans, ret2);
 		free_extent_buffer(leaf);
 		goto out;
 	}
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 74b82390fe84..1b9f4f16d124 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1320,9 +1320,11 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clear_buffer_dirty(trans, quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
-	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
-			      quota_root->node, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
+				    quota_root->node, 0, 1);
 
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 
 out:
 	btrfs_put_root(quota_root);
-- 
2.34.1


