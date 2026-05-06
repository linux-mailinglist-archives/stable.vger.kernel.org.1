Return-Path: <stable+bounces-244383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O3ZJBY/+2nTYQMAu9opvQ
	(envelope-from <stable+bounces-244383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:16:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8D04DAD5E
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFCB8302AC32
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567753EF64F;
	Wed,  6 May 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="NHCGOJqY"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92C323D7FF
	for <stable@vger.kernel.org>; Wed,  6 May 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073130; cv=fail; b=KK43QzOl+KhJbdk1ZzVw/v5oykfKU+oYHxtV161YMA4Dv2VkSoEEXZ9UQRCXGNWfSFeKIm47saP909Rp23MpFO6HAwztevAPkL7/afW3JTsoaFNiBEqYZYd5ibpqt+HhcVrtHJirK8avTWTnXhI24EXt4YwYEhSUinkPscE4rtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073130; c=relaxed/simple;
	bh=p3T+K7h8Ibvg6jRwW52RAsz0eQpeURl6nL6micJoCoc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O+oCv13VE5KzJpKtmHT2BMOr/m6co6yu16fnCm8uO5n5yNHvmXJL78bW3OSYtX/lU5LKNmikHPA5CvWXaTAPkdXgfx3FOsxkCqiNxZLWTm1uDd7zHB7sBM2ZoHtLl0XCZL2pc/4vrQgRFIxrQHGlcPCtpmMavWJk3J5blodCx04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=NHCGOJqY; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeg4HP8aacSefVpsp25znrtnX4grsI9fSvasTvFUBOw9FtrFIrwSmBlsrRS3+bNmKP/KjYV6/xmjaEE8KO0JGR/pzvr4k85QEZfSu537XaBmlKOFl773jnlCVupNnHCP99SPYQbJe3dkuqvVnaIThJbYZX6f4RvNcFW3lob3qhnLWKKpAd/Kt4HHWYYpncezLBbsL8OlRzB3zpyhCPtTnt29RIN374ZukfcpdEhEySLYXk8/ol9tX92RkLeJ3Z3edK+udqKo62xiBBC4KX95NFPHECTBAXs0HzlYgMAqSxHqanSyyReLUzHhGRoRfded6ZTQRwHTYNpyB6c/mYY62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2XwSaulASAtcZ6R/IArPkLQ7q5GH7XeyP08RanaSjw=;
 b=xpX/vOhOVyRNHT6aqwJZn1qbegAKWRF7erICwN0T2mpzfQtMQb5auNOCTkk15cxHskUyrMbztoR9d3ADZm4NuWEF+LZ1mkx3U/I9ZDpF6Zb8PTYpv6XU5ZQveOoeDVn3lobjvYCLHqM8/i7TgTsVyYvsoHQpaEBTSrDldGP+dk+nU5gBzzOOyVsrdFF5+Tk8grYT4cBt1u9TVI9kWGmyuFa4bvOY+M57ijQC4w75psQZsSuIneebgK4dvMfMAEmnvIQEu9zPjCLtUjFfdonjG8rbch7Je8zLfzDz1LFLGBVdPAeiGNT/WlM6HohV6WJTnAq3PuLt84ruVUI0JkjqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2XwSaulASAtcZ6R/IArPkLQ7q5GH7XeyP08RanaSjw=;
 b=NHCGOJqYFOrqvoOyzXLFDLbt4S0qK1E8EwJXFH5BbNIcg/wMUYIduheh6EmLiXAR/YjyqkAhN5Mv4HzvUtwnckPHzhdx7Mpb7cQYaM9Vlm85G/xhUkKxm352DqBGbaFqqWXtvy/dpnQ6Ax+pTZQJm66DOV95Nd2XTLTOLc7sZHvqrpMwd8fbmxGJeJTSMLOxrQ0QHoSOLuW/k1aFGIc2kRwsWsg1FA7cUlEBz4/J4PSrYo5bNfHP08p+u5XsY0VSEIsPNhVQg832NNIQvjU7z0VaosKW6cwb5jOphExhlQlpt6NwGYsSeTEYQzjinUA62CHgwqN8Vey8D0yD+Ywonw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AS8P189MB2441.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 13:12:02 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:12:02 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>,
	Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	ysk@kzalloc.com,
	42.4.sejin@gmail.com,
	Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH 5.15.y v2] bonding: fix use-after-free due to enslave fail after slave array update
Date: Wed,  6 May 2026 15:11:03 +0200
Message-ID: <20260506131102.525680-2-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AS8P189MB2441:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2fe5b6-ff07-4bcc-782c-08deab71102e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a6Nd8pOwhrOr1kZ0S7QycujBgxDP39eZlHhNCmsfkmOQPrwcuUI38kRwEz5aU208AGVglsDRZ04VJ3fQbl/QFHk5W08ocYMgMDIcrCWxjdJQ5bJQZ1H/d059HftlH13HkGR7mhahqo92nbXX53ljehi0CWns0Lgw0E7ykPmOBv0GLE7yf95Qx/0GvmMjIZeH5mgUv81ccXH7NjQF0Qceh3PYjAyjvPObi9Fxnn543/9gy1olYjboRAGwoGqm5AnEJVs7mN8CCEj0JHcOad26uUSTxUwjlqXGBrLjhG5itAqjGBFbZ/lOLOXf61HSgehCB0mgUulTmHaos+WTRB4Mpy4d0XlPq8wVCg0ZTJ/rK5naRQFzZNgDmt8SyoJ1XBp/jru+qIEtnnYgC0UcfmRWk+ET1aqupBaxu5jXOV9H5SupiX82gBfVsPnQCtzoU2XqXhGx3uM9G2ftBnEqWTH8VkJfVRoHq4LCrWTMRprbKS7PHcgD1jY2l7XmGNSNnO0OlXpLqK3MFpoQn/ZmuuSwNBOBUY9BEnANTQPBAlcGtdlLSTB5qMEAAz85yDqR/9XApCT1mt4dd2J/baLkSGt6ShwK9gCXcyvtUzTb7TQ1B+7NKhZ0uAdeCT0AnVjRf/bKzAOArQs9xNep5oq2IeqNZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ut52ngkTtaHNIcL7qYsb/lxnAkW/jIS830T786uldrDxZNtx3wX8wlc8mlx5?=
 =?us-ascii?Q?zsgrXHKWVrSpbnsfyYsItPiW8wWDeRSmADLYFQXInTzbmqhGw9wzDYoWzq4p?=
 =?us-ascii?Q?O7IoByW3n5iRju5ZCzNwMXtC9oYGlYPcNsMvsVCZrkXSUsa5zGcHTl8S4pco?=
 =?us-ascii?Q?SMAqMxjrtsYQkCkmfiO4P0gd3kt/kfbSJBHhv7y1w6RpU4UgxcY8wJRE2ytv?=
 =?us-ascii?Q?rpDoXsrpxQQvhx/Jcxc9X9T+qT4md3v3cBC+eEbcZIJGsu1tu3QM9GS0Wt/p?=
 =?us-ascii?Q?h7L8my5XcYYOPbdp0PnxHG//ogHU4pmg8X37uByfmBOWrP9rJD1jdNdP76Dy?=
 =?us-ascii?Q?z+yEZPVJzQb2ex5D2f9dZgASnX6fn13RDDjFMX2jKw/lmxSKx2yM0zRHfwhR?=
 =?us-ascii?Q?l2Ufz5pkOiwU9ixyWMXvvfCDqTEEQYv8pDfncmh5pXV0FZnxYuXIQ6iKXdla?=
 =?us-ascii?Q?m5MPbseZqkW/+ttczLhCBd2SVU06aiy7L9BPXffGeDi4k+VA13bbPwyQDWHC?=
 =?us-ascii?Q?E2/lCjMpb3kKmkyrhLuI+Hg+cygpN14iEWqO60idlJO5Ka2484TAhvsp7IB3?=
 =?us-ascii?Q?vWm1HS4EF40xYJ5TabwQ8FimJzvMfuwXAuQ8LG3ujHhwja5C1tJyFUG28dBd?=
 =?us-ascii?Q?+HH/4U2yi4q+CxNuxuD080EFuWkRCjfR3WPs5XhUJpz/GIpg1cPm3cCs+P7z?=
 =?us-ascii?Q?RIV3lGtL9XHBi8j2+O5/ucUQ6Rwnsvrx08cR7wcqVupbuFmctWBD6EHP/dLe?=
 =?us-ascii?Q?LXaTUsBK4JlAHnwNRJNs29Fg94Lejy2pFci/Dn2cGSTC8NprnmLs6w/2cysF?=
 =?us-ascii?Q?+g7oRMhuMJIgByHVvHnZaZHwwAGLDC40hOkBJsYUhleLUKtb4r9D8+jFEsJQ?=
 =?us-ascii?Q?ymnD6o3P78w2mmkpal/cgC8kSP+cAySKdSCkbawXvYK0oQPqc6hcU3LdQkIU?=
 =?us-ascii?Q?FSL4npKrMlG2xxL0WifsgRqjp/TL0VgJYmbb1GHgBxiwq5NdnHpMlMdaGkHN?=
 =?us-ascii?Q?PxNjZUg4RfVXhdfPE8zO20K+psbjEMPAq790leKAmU6NL+naMS0V29bAAHnu?=
 =?us-ascii?Q?Q5JY1tV+gYncHsH3cXVFkOGkdGaupR/HMH+0kiySZE8RLbsXq8fA49mDMMs7?=
 =?us-ascii?Q?Wu6TSw/JP2XD9dsup7LtZ7cjJfN739MrRsrEkSGpqphkwVXLwPEL0CRFo5c/?=
 =?us-ascii?Q?eZx4u5HRmSJUX9b8psfBk7NgXGWryFYmTbqxA94Re1NpVvEXWV/bl+/N55ee?=
 =?us-ascii?Q?//E5M3MOtuG/L15+IG23tJSzZExR2Ijg6BdywrhBHYir8QobTr/GpExtBXir?=
 =?us-ascii?Q?VE2FT0HfghMf3e/yQX63LyLy4bTfbHbe/2WKBF9MG0CgwT8tbUkuD/okf3uc?=
 =?us-ascii?Q?ht+CMKki8sL/e6DoJ2EeiHOe9r+sXqRShGaWqsVqR8JcsXntGqNfXAV+YXMV?=
 =?us-ascii?Q?dBZiMSPpBGyQ1iRS87WvxJkn325/z2oeaP11eYf2nbws34oUi8NQ3pf7Jv2S?=
 =?us-ascii?Q?Q7+yZjwKr3NIeix7EbFb5sH7aCvt5e86AOrgEFnnbMuJ6CYgunGz5J+rZdzX?=
 =?us-ascii?Q?AsHpaQhrPxSbFYtvCSdMRXtgkPCA2KL/2rjOMD2VhV268+B1aaQQKNscsCYF?=
 =?us-ascii?Q?lzj5NI048Rt+tXwUOhOfrEoSYiU3uQy2fC2Tc92UfXd5CkVVSRSle/KYPV9M?=
 =?us-ascii?Q?9yHNPlvvF7MjrEkgJjeoRW7PZQLp1/QzrFw43gex5euI4aOg+EMScslaLizx?=
 =?us-ascii?Q?Fbft+geFLg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2fe5b6-ff07-4bcc-782c-08deab71102e
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:12:02.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdtPrgjXnGd1uGFgmSSrV0btHzUtzYw6Q+LosR4tVLa/Jnv8Hgl9hqdDayVZZpml1NIwmZ4pbFc5Nx7jQB3WMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2441
X-Rspamd-Queue-Id: EA8D04DAD5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,kzalloc.com,est.tech];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-244383-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,est.tech:email,est.tech:dkim,est.tech:mid]

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit e9acda52fd2ee0cdca332f996da7a95c5fd25294 ]

Fix a use-after-free which happens due to enslave failure after the new
slave has been added to the array. Since the new slave can be used for Tx
immediately, we can use it after it has been freed by the enslave error
cleanup path which frees the allocated slave memory. Slave update array is
supposed to be called last when further enslave failures are not expected.
Move it after xdp setup to avoid any problems.

It is very easy to reproduce the problem with a simple xdp_pass prog:
 ip l add bond1 type bond mode balance-xor
 ip l set bond1 up
 ip l set dev bond1 xdp object xdp_pass.o sec xdp_pass
 ip l add dumdum type dummy

Then run in parallel:
 while :; do ip l set dumdum master bond1 1>/dev/null 2>&1; done;
 mausezahn bond1 -a own -b rand -A rand -B 1.1.1.1 -c 0 -t tcp "dp=1-1023, flags=syn"

The crash happens almost immediately:
 [  605.602850] Oops: general protection fault, probably for non-canonical address 0xe0e6fc2460000137: 0000 [#1] SMP KASAN NOPTI
 [  605.602916] KASAN: maybe wild-memory-access in range [0x07380123000009b8-0x07380123000009bf]
 [  605.602946] CPU: 0 UID: 0 PID: 2445 Comm: mausezahn Kdump: loaded Tainted: G    B               6.19.0-rc6+ #21 PREEMPT(voluntary)
 [  605.602979] Tainted: [B]=BAD_PAGE
 [  605.602998] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 [  605.603032] RIP: 0010:netdev_core_pick_tx+0xcd/0x210
 [  605.603063] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3e 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 08 49 8d 7d 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 25 01 00 00 49 8b 45 30 4c 89 e2 48 89 ee 48 89
 [  605.603111] RSP: 0018:ffff88817b9af348 EFLAGS: 00010213
 [  605.603145] RAX: dffffc0000000000 RBX: ffff88817d28b420 RCX: 0000000000000000
 [  605.603172] RDX: 00e7002460000137 RSI: 0000000000000008 RDI: 07380123000009be
 [  605.603199] RBP: ffff88817b541a00 R08: 0000000000000001 R09: fffffbfff3ed8c0c
 [  605.603226] R10: ffffffff9f6c6067 R11: 0000000000000001 R12: 0000000000000000
 [  605.603253] R13: 073801230000098e R14: ffff88817d28b448 R15: ffff88817b541a84
 [  605.603286] FS:  00007f6570ef67c0(0000) GS:ffff888221dfa000(0000) knlGS:0000000000000000
 [  605.603319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  605.603343] CR2: 00007f65712fae40 CR3: 000000011371b000 CR4: 0000000000350ef0
 [  605.603373] Call Trace:
 [  605.603392]  <TASK>
 [  605.603410]  __dev_queue_xmit+0x448/0x32a0
 [  605.603434]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603461]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603484]  ? __pfx___dev_queue_xmit+0x10/0x10
 [  605.603507]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603546]  ? _printk+0xcb/0x100
 [  605.603566]  ? __pfx__printk+0x10/0x10
 [  605.603589]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603627]  ? add_taint+0x5e/0x70
 [  605.603648]  ? add_taint+0x2a/0x70
 [  605.603670]  ? end_report.cold+0x51/0x75
 [  605.603693]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603731]  bond_start_xmit+0x623/0xc20 [bonding]

Backport commit:

 commit e0caeb24f538 ("net: bonding: update the slave array for broadcast mode")

The BOND_MODE_BROADCAST condition was removed. Because introduced by
supporting commit on the v6.17-rc1:

 commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")

Neither of which are present in this kernel version.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: Chen Zhen <chenzhen126@huawei.com>
Closes: https://lore.kernel.org/netdev/fae17c21-4940-5605-85b2-1d5e17342358@huawei.com/
CC: Jussi Maki <joamaki@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/20260123120659.571187-1-razor@blackwall.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Tested-by: Yunseong Kim <yunseong.kim@est.tech>
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 drivers/net/bonding/bond_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5321d9dca698..96486f53bfa2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2179,10 +2179,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
-		bond_update_slave_arr(bond, NULL);
-
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2216,6 +2212,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	if (bond_mode_can_use_xmit_hash(bond))
+		bond_update_slave_arr(bond, NULL);
+
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
 		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
 		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
-- 
2.53.0


