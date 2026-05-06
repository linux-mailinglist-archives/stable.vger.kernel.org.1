Return-Path: <stable+bounces-244432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Em6C6Ru+2lmbAMAu9opvQ
	(envelope-from <stable+bounces-244432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:39:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A784DE332
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 18:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 265E530057B7
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621663F0759;
	Wed,  6 May 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="NwNOCLg4"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8413ED13A
	for <stable@vger.kernel.org>; Wed,  6 May 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085537; cv=fail; b=S/wYZH37HzNkixPp2uavmcOWIcValSjXtsbtAsVA3kyTe1E6bXPKca/3rSTjwf7Vro+CYsHQ8bT+nBEIFZrHfdDMiRwBHAL50i23n8RaTBljySYvt1beaYS3wPHiArhpqec5ZWYYXDnU6xzNzSA3nz/K/G3MmzjJ9knpTwNmpZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085537; c=relaxed/simple;
	bh=dC7GgnlhBOu07hj77c11c+k9N5EGhD9PpUFriwBDbWA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DpPdUjKHUQk6e1toXRNduEtEnwXt5QOqv/avOyCjp3+/p6my4Ay2HB9FfWh98uSvHtjMD6S7UR+FYW/7uMzQ/eeB9Cfr8DiLkRFl4v+q+cJtY382jNoHR9smguc9KPfwxgRfiv4kdJDL4QiqPgE02RNTmR/CsoZOJuhlyRMXYSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=NwNOCLg4; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgSBGy1sVuk+J9qa95Q2/srj6ddVfdmiEZp4QsFF2hhOspg9/k984klV5xBM2H5r92ucVmxoRFc0cohbqqSbZD+VQNGosc+VAT2aMh/bryNMrEbYzlYGjXSvcPqAkxWeDpYjaf4cllnE7flBNaCJDhSB8JQ+rt0elqmeeSCgHimnIEW82bK0bEuk078/PbL6cEcFs5PwW0B5JC45+LA+WSB8gD8MLm+/MhO1+Lp0d1Dw5JHs+CswnIsopQNkXJkbF5VFGekAOd4CSRI7q66VRal/nSon0pbEdKrkZ0l+bh0HgbFxuARQoNo9t0Gxn9yLaSCKuBc5EqkvzSKdklF1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoV+Fx8Xh13/2dpxkr2GyvKVNGCQaqt8ILkS35Ah+So=;
 b=P7SaXiJ9XZjPzy2JBmWD3bzhx5wyWX3RS162ElelyZcncDQa0b5o38U+Fn0yV+7XhYEUXROpPVQxIF8PvrK7epNo6z3DajqM1vhSgVHFGcOfxWz1oP7YTeBP7WRLruMLSu8Ek1GqM526hXypnD5ID2pZjHQ09Db/onqu3dsVe/ubIsmc+xdmZnVyTeKN2pwPQwsQmshCoQ9h+af763r73lODa+K0pFPKeGEejHPAl1ihQQKfubQg1Sk0JjWNI6rGnTj27i8DBNv8qbUDckzDBRk+wI3/yMc/YjRh2t3bnO5tXyjx03mfN6cQ9ZwIQVM2M30FBsX8peY/Na+YMYHMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoV+Fx8Xh13/2dpxkr2GyvKVNGCQaqt8ILkS35Ah+So=;
 b=NwNOCLg4TVHMUX1kUjKv1IHC40rgSSAZJqDBzZzsKrxGEcP1qmAm3vMyBbhwFN71e3zD0rU2B6vIHEWUbShWFckbskTK7Vy6Va4zuV8n13jeg6+XeaoM4XMoIw0/PyonVmPSi6CCM7KJNawvgCORuvaVIra1LOWrb9qqL9cELYzyjZuL0hSaG0B7/gsARLt1vOnGKPHICNfqS+RM0EJyon78e+W3HifFMfu9uIQ7VkmHsbKmWB8jWjEIC3/zhlvrAq4YiHFsN/gsO6s+8Ta2KI5OQZHkCFIUuQjnyzSwtGGR8PtTBqsPP+7L5q+JWnZeOS5bYMMlj0Xa4uIspxmXiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by PAVP189MB2483.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:2f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:38:51 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 16:38:51 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>,
	Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	=?UTF-8?q?David=20Nystr=C3=B6m?= <david.nystrom@est.tech>,
	=?UTF-8?q?Roland=20Kov=C3=A1cs?= <roland.kovacs@est.tech>,
	ysk@kzalloc.com,
	42.4.sejin@gmail.com,
	Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH 6.6.y v2] bonding: fix use-after-free due to enslave fail after slave array update
Date: Wed,  6 May 2026 18:37:11 +0200
Message-ID: <20260506163709.552612-3-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU7P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::13) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|PAVP189MB2483:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b4bfd4-7f9a-464a-bf9a-08deab8df448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UDu4vz8sPX7i6fVslIrwHQy+OThf9mrbRcrjZqjgNOrc8+qPQggA7d5aFKO8r4smxVwZs3EGx52vrMOsJcRo1jNFTxd+iMrcWNP8Sd7x5fXuE+gV1+4ztv1ZVntwWYEXdisA7MZfTXFroLRhdYMX2z6SJ2eLE9nU9+wUZwmg1WZgPIOozQYcIJhUo8v9tQYiHSQIsP2Tv4kmnIsW5UP3PZ9hbg+okdTDaGcXOkoyTsk/+rVBc54muFiVdC/csgaXlbTNtTC2n30kP+zlAK9G5mG1yk+78WllBCG/LXdDyh8DaqDj70oZiGSIIeD+sTId2ZiOdersLi7i2zAC+NzdhIEEWcwVB9hDtcdUUBZhLsd7De0mbO8NZ/kMxb24pi5SlqWX+HbqtKf1h4o37fvW8gOzKPDjEPvymXAydY3teXuvpvLi6KCmcFTWn9N5GxKtZ1+xGuXNzCO7wcRgySl2UmsVNPU7BdSUPjLnv3DnKj5vVkB3TkuJn/7tfvJA1BdHn+ySsgfYePfgJdf4d0Yis5VdV1VuznK6ejtmPP3D3n9H5aE/lkoog/QQVJWmF2A6H7hPdTzdoju5SoHzMH7T1xDLDi1TB0XiwTIhWgy+4SXbQV0XvHmXuC1kyMX8EbME9Hzs9/NNScuvYcxproeP4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?otJU5sCOALDeYlNQszkKRuK3MYfFKhZSSSng8ENcllo0DgVe7vygViEbIooy?=
 =?us-ascii?Q?lVTqyWGfFHgguuVaAgkozXiaQX4RIzQGApNb2FdaVNOuoVwF/MEbKKzGlTgp?=
 =?us-ascii?Q?qbB2gis5SKrEG0DvqnvoLV3MFW6BWpFzfgwTgSFJ7tGP4brvnetXQubkCTyD?=
 =?us-ascii?Q?hk6P9XcbirlP6bRZXuHGHom8jKy5FGG6rJCKxFfSehPK8Wdp9XSs1dVZzNMF?=
 =?us-ascii?Q?iklS4l2MlY4zUoTPVF9S1ros0JV1SaFT5bON8BuBn/Elsr9Lwr+FnqDGUSEW?=
 =?us-ascii?Q?UQ+Ad/mLPpN5aOrzuYKjzh1n4Vj8PcjR0ID2CpNoWs9n/0WG8t+KnD8g/dYw?=
 =?us-ascii?Q?pyLd9dy5a0cP36OZzu9unegjfuVcjyZcHv3N/RbMplNZk+Moqzwgn5cwM9Dm?=
 =?us-ascii?Q?fJTtuwL6eVAYgGTql1XuoZLcqKVfyN9XTBBjj4i+bL4uevW5XiB9YACSaR+h?=
 =?us-ascii?Q?QRkDZu1P1DbFMdljRId8aa5t+w6Tznkuw+iUco0550F7PwdYflo0Fe9ptAfJ?=
 =?us-ascii?Q?dvVpf0d2hj0ccRjMZN2siLy/Kdecm2lMgd6YjXTwdhnABpLd2ILgGlKG34XD?=
 =?us-ascii?Q?XWvxHbq+BSSI9TUQ9qYeRYoHlaT0z4vDZwQHOkI6ZxkFqoIw13GqkbvBPUFP?=
 =?us-ascii?Q?bxOmE3zXRPIsB+cXnpj9zx3vrx/QSPCTvtPYyzwyBL5kDHJ5fIPSS7uaBJVq?=
 =?us-ascii?Q?qOlojzYWKq/BXcydCDKUO+2CEMklmrNN78mSFMhl3AYCsXnxFtzANNiccHr7?=
 =?us-ascii?Q?T8hGY4WTJbXp9s9cd1lTfMoV4uxFPEh0qbhTDkjGbtT14Twf+tu3e7lJxZKA?=
 =?us-ascii?Q?SS2kQ3j6T2FntldIH9sH7iZsKp1Hk7/ej6e7jSCCevsA7Gyj1JqyHSM9JNjG?=
 =?us-ascii?Q?TPjsXd3fElfEVd6785SPEU0/5fr5GVoFvNmVBi6vg1q5bfrkglfT3kF8d1He?=
 =?us-ascii?Q?0moqLvWSSUT1pk07KmcHD5k7z4p5fmFE6vbYqGXTQpOlHQ8Se72W7GDcdnC2?=
 =?us-ascii?Q?KEhXkOm6ZhtRdhOm74jYVBIwbJ+7eLEdF8dsIDhvxcl1xpKBfFoojH+7I7Yl?=
 =?us-ascii?Q?eKLLELx5GoqBjA/w5nrmTId19N3Az/jseM5F7d6Ufco7G23qocnPgd3rxPJ0?=
 =?us-ascii?Q?LS/UTmqy1dZXW+lAqs7Jrgn9GCbYNIAvvLU6XSW6wAeSEtwSQN8ogF6B3k2d?=
 =?us-ascii?Q?g56ssAettEZLEUaXFmrgABO/TEuJycV1G/2b0CkEXXRoGc5RAd4qhnRu+FIU?=
 =?us-ascii?Q?DYZstNBj3G6pYgD9saQf68/RytSWjJOwFE9Nn8xmOb88AcQ2o0aVWj57MMKI?=
 =?us-ascii?Q?7XW+WE2US2DF+9aZjbATdlHGIYFfzBQYL+lqPXj2Sh1iMT/38FTxprStEMwC?=
 =?us-ascii?Q?bmVVsfTKzdwLt+xU0Pmu2Ai5eYatjv7ocE/Zp5tZEbr21MVP4FrBYduuB3eZ?=
 =?us-ascii?Q?qCAc9QLilmq0eEg4J03jMMcg9IqrqAvlrRItDlBH8KXhK5rl3233pMqs7mC0?=
 =?us-ascii?Q?2Y2uAsVBvDj9dJejdY6QZpNCC5F3CVTlVTll2rYNYw78thbrsKWCJqeZR5sD?=
 =?us-ascii?Q?0IAGpFE7+vsAb3yrhHqebXpLogfr8eQ6RdvQI16IVjxSyuRmRsryiWdd4cQh?=
 =?us-ascii?Q?iJi5MAch47s/dGeGFZvRHMpuyQKosr7qEcpu1YQccVjuzxXMMGrCqmiIx18c?=
 =?us-ascii?Q?sKmj8WqXcVWoAA9zhnKh4r50VWVgp7nEYIKNyD/2LZ4gLQ+KavJkroLLN4PZ?=
 =?us-ascii?Q?+JVf0E3WLg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b4bfd4-7f9a-464a-bf9a-08deab8df448
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:38:51.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srPPXnk8e9TDTlTjZCBIugPyb4BFGWC2RMzMBe5sTkI3DYDJYiCu9cumR8ldR1QAN0atZvGM2lgwPbI7S9PPOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP189MB2483
X-Rspamd-Queue-Id: 70A784DE332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-244432-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:email,est.tech:dkim,est.tech:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]

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

Changes since v1 (https://lore.kernel.org/all/20260426201144.465734-1-yunseong.kim@est.tech/):

Changes in v2:
- Fixed wrong upstream sha1 and incorrect author assignment from v1.
  Updated to the correct author and full sha1 for the upstream commit.
- Documented the conflict resolution due to recently developed code
  not present in this kernel version.

 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 114ebaa284da..8d481a6495e8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2309,9 +2309,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
-		bond_update_slave_arr(bond, NULL);
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2345,6 +2342,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	if (bond_mode_can_use_xmit_hash(bond))
+		bond_update_slave_arr(bond, NULL);
+
 	bond_xdp_set_features(bond_dev);
 
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
-- 
2.53.0


