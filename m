Return-Path: <stable+bounces-241189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GjoILIRx7mnctwAAu9opvQ
	(envelope-from <stable+bounces-241189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:11:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A446B043
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E116E30073E4
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBDB38C400;
	Sun, 26 Apr 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="yvH398d7"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B137263F34
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777234303; cv=fail; b=vCcC7V6ud9GNBIqki3fs7o/mSoAUp8IbcdKFGc2gVcry1xf03VqvaeuCRkShCHLnh//5IfrAq5/F2HIDwB3JoSbgQuAhT8lGE8UCA8dCDOmC5bwAWA1Si+G6sni8ke/rpmUa7mgm5Wk7mHugYakbRXJODaCq0+9vYSMtkakdrzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777234303; c=relaxed/simple;
	bh=ScMyUgi+iY5foT4dY7yMslNsumSkV4mQtD90/X8kEls=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rjd8OTfd8/ea8hGeUdMg+PT5QFpHOTJDt3nJn7LvCn14vsIMK+uCt/+qmNlmACeXBc4rb+eBdkkMjNLwoospAEGi5lo7rfpbJzC42ydvNUNFB7Vs7+HGBaA0PZu8eSTi9CcAGFBFcXRRXetijEa40aVH6uty57Aca+bDd+OZCd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=yvH398d7; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URlt/PZQ6YsilTiVoub0p5lAwDZxV1Br0zWjIU0UHxMwz3cFgUEU2IN8mqu1as4Tae8MDOplL3r+6Pphz7o+AcmbanMqgzyVdY8gfTrLUJTawqHrYhbGsCuurSoQXMQWxLAUX9EnLA4/NceUbAem5smZdoAWLAt+IXST/ILapYPzXp0c+85X8bvdWw4AIkTIBBtLfUes+OFIcPQTWX3putFSM4IDUWYm2E37Kq63/4Azy5M1oEIwZOBAz0WY92KVXigk2P+Kaa5m9dD5iP4v+D85krQlBjEuI2/mHtuoqvp/+U0ucdSoP9IVNf9Qjcqzf+6VacVx7oJOXb8Qa4c2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Xtai6Y8Gf/w9sXDa/vbK3avdVQam2zlXCluQnpWayE=;
 b=Qnpm/llwQnpiNCGfrlHdJTkmugUPCPLlt8Sg+9lOzousDyfbVkmsTzvVCfkqo9+/3Srleiey5Aui56ZZOdQaH5eOKVt4tnRnvZQKNBTNjVh/sXnYWznQWwCp75XtCLe7BaHt+yybho0Vo9wa6ig2aPhKm9d0JO5EQ2FFFQrNFBFPRCYeG+suCUQgw9xkxhdPeiepAjviuklUc/MHPM8UvBkZoAog7jbhUo42rcbSgAV6Damk+tEWnK0dGQiDlNfviC2iMb7pgxzIPadA8SpAYinHLGyIuVvfFJ9PMxEXLlnuwbDffXqTqmhMjcjKtcUzqiuP72PzK8UWwqATRe6AQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xtai6Y8Gf/w9sXDa/vbK3avdVQam2zlXCluQnpWayE=;
 b=yvH398d7gY2dMw3uep9bStjcxt3b6crYuYNzKbcoD9erpcuAnjfaTGar7ozR1tGqtAQ7r79zmP1mHiySzd4xZtVr4YuDSscZ09K/3FicLiMpGrZqv1wt3ibk2e6PjHfq+xbRM8xThio0gFCVS48etLqqHb+sN1EwLc/Bueq77h2Vb0mDAOWaIxwiO+sLLqzJoUV5L3kkmZQVfPGnRJQoDuo5W/sSg033t+vNlnWdng1tfRkNco54ulTPzIAVhZWdQ5YZdIRzg2JXk3G5EQF+DTX87R+uxWo/LuTc7e7HObRkyaVJuzAZTX4iYZPqxjjGxcv4vR7g/+3UVE8XqjgLZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 26 Apr
 2026 20:11:37 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9846.025; Sun, 26 Apr 2026
 20:11:37 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
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
Subject: [PATCH 6.1.y] bonding: fix use-after-free due to enslave fail after slave array update
Date: Sun, 26 Apr 2026 22:11:08 +0200
Message-ID: <20260426201107.465633-2-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DBBPR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::17) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM7P189MB1009:EE_
X-MS-Office365-Filtering-Correlation-Id: a7571a05-4353-465d-0de5-08dea3d00519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kVAKrUDiqYOoWe5fks11x9mVgdKfvLL0ryROcKEISc2wc84AZWzD9volwGhffT+dVfP8QkM2M6WwPcJfJfv+cvAdsjs3sVEI8yqT6JhWJQF/D3D4iFxioXRumBitTSH2rTMpN1sLNaml4mkVWi2BXDK8LQ/OvqUd+on6Y9NWQqekb98ORp/NBDuFKauh0FtArPiLr31d8+G/hAdQqiFNR5MSjOnEYYBY8lQ4TLzW5ehve+ybOJpYGb9OmWrK/NGMnNvmx2GvoKBWHm06TwN7oBBj+t5D26+PQrhf1xQjLIE7GtPIGxdcyKXul2KAQh8pZ/EyU4YpCLf5Xq0JQb3kMT8B7Qc/2NAknbqlWBLrZtAqnQo6QYHhL6Ns9yOpWwpCs2HuYvVS+Vy0thZjLtf+4agLD2NzClooO+VVqk7wBMgMu1hP6jrD72hNJNu+/PvIksppNhrqoRRAnBNDWbJDiyHk7WeuI1TZHVI/BvhGi3usVAzhlA4y4tdKMXdpoe1tiGA5B4z6F3b+sBB1lYHsaO1BS/1KhbsKlFY1o2paGhEI8JZ4vhLvNw/xE7HchDnh6INLvgAgNXS54Z0vT37gTzAbhT8yRmI8MBJwn+jVnOhSSNRtx1ZiJ6zV8gYwCGGuK3GRPkOoVQOgjpJx9pqeghPuJHe0JcQhY1nBfkAqiY6tutJcDPMi/1piKpVkprxZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Yjpp/8NTth125b/20s7f/TOf9arL8PGY7UJucxIbpyytFI9lk/kVW3u4r4y?=
 =?us-ascii?Q?cEnL81oEBVgOtiv+4Wg0G+GGgorXKuhnlKO0XwOR0U8Jso52qWKeQt0ylXQm?=
 =?us-ascii?Q?HEPcZgL+Mz1PByeCt2BWmbH5PTb/I3H4vavDMzv5PyREQwJEvETKMTBf+80v?=
 =?us-ascii?Q?xEyFQLqW3PPd19aJ/FW+/ESOMmDPDX/T/unaLIxwUA9XaPukV0fNtLPFD7VX?=
 =?us-ascii?Q?DrFBM/quVRiy1EJKYXCT2Q1nbbcAJdFnsorO8nB/cZwJ62QTRx3vocTtGFs3?=
 =?us-ascii?Q?Am7+StBrJc9eoNi9a7yeXAepkCufEdv16fVhVm7ecUuCt8OIulZN78blMpIN?=
 =?us-ascii?Q?iqDJhSvQEwf++LtHbPF8aIw9kq6z+4BtwMVGl6J1PoAKVclLAx5pLEsfsjdR?=
 =?us-ascii?Q?4utpmOTJzldNqtj12g5XG1cSSj1SFjSYFPdvpOPacJPDqEy6QEeYqp0bMzcg?=
 =?us-ascii?Q?iwxsWlL8M0PlfmbvDeEP478hZR5+GWtYV6yB84USfyVByxDYgxi16V6j8mOW?=
 =?us-ascii?Q?oV5y6u74b6Q5Uv9MYHvjxbSRyKZbKS1sBNyBvkel5MTT3VRiLMCSJ3Q4buuF?=
 =?us-ascii?Q?4nGyA7NxYDF5JS+yEAKqGujYJLA82G0Ugeu8VUxP53/Kh7JL7M6k602t/MHR?=
 =?us-ascii?Q?WOL2JRtCDbR+VKsnSmrpLtfz7kMHLhw0NaLJ0DGrj2tPcrRw8vMVogfl3z19?=
 =?us-ascii?Q?73Sg7fEIlV9tXca4J/AIJsyP5yKtJiW0dUgXWykwPSL/+xb9QuWZE7Q4Q6gH?=
 =?us-ascii?Q?35XGp1yaDx0iK5wr/IrPvIRaEQmSHfdThE0u+5ex2HDqtr08MlgD0dfKxaPr?=
 =?us-ascii?Q?jnxmzrCyyjZu2w6dDf6p6qoVQnjWgX6ywEkRRzOxVgCqUYyjT/1oMjqw3f23?=
 =?us-ascii?Q?0Eu0XLfs5UqfgxKep4az+JJgacwuOEM9lygs+nyd10BZKnXA2rXFsktXKa7T?=
 =?us-ascii?Q?r1dNvRL/IzW6MGVIxZVYBPjL1ccla8hcmnjkgtLSHwQw6ky+3CD/xKsZzRX8?=
 =?us-ascii?Q?u22tO7jKcuiP3UZoTPUvt3YZZUgI889twl+aEzo1cU7NGtydP18DtQpsSFdK?=
 =?us-ascii?Q?eyhJl07arD6XPi2Fc1KN6Whzagig0emNz07UqiIH+IBxyPl3HyTmIjXRCBdl?=
 =?us-ascii?Q?Rzs+50yGhZqFdAAW45wmDlV8xGDgE3HDz+59VE8tAg16E4Kh9I/SYoyjobIS?=
 =?us-ascii?Q?Fi2XNrTvn2Bvkv6xdS1vvkoIcb++xEaU0uW/6LzZl6nqY2f32niSm14nvLDH?=
 =?us-ascii?Q?+h8kW9r+bBTRSNNK8BIQnsiy2MKhxfhyVxUQQOKlZFsrROJ9TmD7rKnBVPem?=
 =?us-ascii?Q?NXMlqMUWjQ6GUv6xrGhITJC3qVEr7qpr6WYjepZ1ne3Gks37aOZEjXYFDBw4?=
 =?us-ascii?Q?xynUDxEa7NZXLyqxxDuXTHKKvNco3P4IOHUk2cwQodnrfszPYy6N5KsMNk11?=
 =?us-ascii?Q?WneqNPqNmfneoyufqqGSyE+RxY8AnUsDxgyazswHFq1/oW9xsGGYQXKYGifo?=
 =?us-ascii?Q?b6l4lW4fV8M5tVyjWj3ocWTor7GSiG4jgUN9eq7+bTComzNQ7QeNb26ewAXd?=
 =?us-ascii?Q?kTBYz37bQZJwq+MrjDLATQndySciHFkEe4Hd4h/ZEpZQD4tZQARb4BHLT3FL?=
 =?us-ascii?Q?WL+d5RmmDkCmb+ajkdxn8RoCTKnnyrVe57SHzmncu3iGrPmn977d6lACnIXD?=
 =?us-ascii?Q?hmG+6L4vIM9zv+hi52boSDjK6bXuta0kphJ5yNOAYkHRFvpcV6m+gvD3tuRI?=
 =?us-ascii?Q?oZycvzICUa8rLF63P1c91c33C2KSgYBjvdZGguIQMuSkLFSh/ljvvZHslFWy?=
X-MS-Exchange-AntiSpam-MessageData-1: 0vj4VoBDxiFZVQ==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a7571a05-4353-465d-0de5-08dea3d00519
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 20:11:36.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJO3+GHBZ2WWdFYWH3kwyGEAZaYn4tM4t84s0Xudvv3qKEhS13wEBsXST/mKokupcFdDsieZA+J8/6arIyYsHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB1009
X-Rspamd-Queue-Id: 205A446B043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-241189-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_CC(0.00)[blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	DKIM_TRACE(0.00)[est.tech:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackwall.org:email,msgid.link:url]

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit f6c3665 ]

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
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7fe7485fbb16..d38d31a83ce5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2256,9 +2256,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
-		bond_update_slave_arr(bond, NULL);
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2292,6 +2289,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
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


