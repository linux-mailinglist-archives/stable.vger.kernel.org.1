Return-Path: <stable+bounces-241191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFRdB7lx7mnctwAAu9opvQ
	(envelope-from <stable+bounces-241191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:12:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E8F46B061
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF6A5300D633
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09E39023D;
	Sun, 26 Apr 2026 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="U8/7Oitt"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D838F648
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777234342; cv=fail; b=OdPwqGdm6H0FO6Jm8Mx1Uld34MCNsasufH4FlodRemMha+Y9V/3/Arj1ksLO6obAQbHyaePHEsnIfFb+ob9Qg420Qv6Va6dYhRwDmNBP6GUKnEGQScG/yZHBitpJ5C9TwWeYhZOs3ChisuPU81LLrQhKcpcyNWldKyVWjqU2bTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777234342; c=relaxed/simple;
	bh=FCpj5NR4owrghwHO/iCJk+gBGZvig7IoXrmBO5nXu3w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GcfuPe5b0xzQVcWXcGLzu0V8c6W/o47xA1Hav4O9h87baQetVkpKT5uW33gb8DotbFJdymEdQIRlwkZuvnzYMJbTvFcpXU3dDQzL+UgrYLl1gNpQDumuAN1fWjWs0RKlyAiV/W8E0ElRLNWN6wLQDuYyiawacrUuKyrJaWJpg2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=U8/7Oitt; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU516+JNEVjd/SS/fHhapmZt6hofMMe203jxB0PnxmCC96F7ns5K6vuUTlwgZ+++yLDLTnwaEBaI77lV3u5qTwDL9ShcaEc4J+tBsbIovbgKdP7Sgh4dNEJciV4g6A2S1iqy9TNhrL5Qe4B5aGr+xD4FuyTwd8fsenj8MJSc3l08+QNzgTEZnZIUf2xHJP16d4BGaJdBMhbAm3E4MyMQPWgn1JA6dMbMEbkZ5TYKR/AFFncShLWPTPvLRYI+D/BN37HbmTUI6rlAMXB5MgHCbQyUBYuNwmgQ9d6CuLwbrXomgaXkxuAy9+WuGIS/hv2yjirPkcDdlVtq0EtB6czI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7kkdXH5M2pn9MfclqZ8LQuL/gTbMT37ZJq3v3U5LPk=;
 b=ndN70hNFU3T1cTa/eN7cpJOEDocr1z46Z9TW6Y9gsqM7kYNUnftOy2la8/ZfTPDKVYsu4Ud1iANvyb46/QM9BhP2ahiEAqzw+Z8rTNqWUypBbPZOoUCk4yhbQFNcA8TdIbt+Oydem8zNc47njtc/vMfLa3Qj4fHAwwIhKwflwOj5RW++Edn+rYIP4aISZ/gOIlgeeWKOG9UTvwRDmSEXv6pJOX6UM8cKwFAiW38OvKqxps4pUXcVD5BGdzkq3/9skB2kyMkKHyu/vR/JXxUwXKG8bgdWfrysqridIOTQzIk5xwym9CWLZ7kILW0+/shxHPRj/oBbyLFuyBGULfxmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7kkdXH5M2pn9MfclqZ8LQuL/gTbMT37ZJq3v3U5LPk=;
 b=U8/7OittbT/yTWmKYwwh+YpCCXrIBlFuoygGiEACP5UShE5/7i0CkmCfoLJuSoTwZyT1cHuJF0VM1GcVWodasqnmzwKZIRETPuykuRvHMtWYxz65Blnor76P/0i4fw8sxmpVBmSeskkleO3xXgJ4JSASuZ+TjLY1Q9lcdJ5n8sbVxiNPqRaToLQY6FAFobm6dsxKUo5c9Xf5B4xHfCakr8ol2ltP5AGbIvVC+IfoGB0e/8EhW08rvCj9L8TzFj1kwLrZqcZgzlgnPPURxp/OFOn/x5C2OCtA2pYj7Yru6EeUTpNCTDhXDDIsHvEA71JKQQavhmRqOfZNwHusczfngg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 26 Apr
 2026 20:12:17 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9846.025; Sun, 26 Apr 2026
 20:12:17 +0000
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
Subject: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail after slave array update
Date: Sun, 26 Apr 2026 22:12:05 +0200
Message-ID: <20260426201205.465809-1-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM7P189MB1009:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f62f8b-8cef-4fcb-130f-08dea3d01d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NzZHKtIShXvC9QaWndwtELTPZFw8QDvCKLPuU4ybpOkXLMFKv9gqNbrDvJbh6h9ECIc90WlbyfZM/a13xSlX6FEHT+PLlenKKkCtAMu/5PKc/jWoekt1TfYRbUd+67CFnHNKP1/fDtK7A0nOhXof2oTI5s9F2zKJzFXPUUFYvCxhKWilCgBHp9NgvZq/bkaVQd3LjoWzxLUjdanNpvw0Ifamukek3g19kG/JgGo28LiL9wS61qM4VvLuX0B9fSLpG2gW+EPW/8jf4kagu1C3QsrAuUKwu2zYZynXT33VjVg54GV5ZFujx83/YJnuMV03M1LcELnkf0wjARUHRkb3TOra0ejtr8J00Y78aZHsh907ei9DuIv6QwEWabU6/VyWFT5i8ZnAAVFbmLUS+AAPDDj13Fd6s1/zOUYcqFwqLwbsbvPz96oe+K14XJwv3uMc4eti/dGABugPoY+H39hufE/2Uzw+3O1/moLPzPVWVHyOFG7+15qxtUAapYI+wNx6weoNPaAAAMyJBkY3VNR0XgKu67cbcpe4iVHTMMfy29SWL4681HbK8v4DO/hGLQZBfia9ELXIog5RRv0354uPyqHMQxH7nbBPOa4rzuRdNGhFd14sXUE+p81vTQ09koiy54BvErILv7jblKXMjci3BhpjVU+HKLlv3Z3yNShfsteGBv/sedrj1lgePA8avoKe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FyMzuBRd72IyrgQliVGk9XFwSxA8ty1QM+cLqDOyQWpwIl8HHK/26E1dseXz?=
 =?us-ascii?Q?VIXNO7n7qrYLYYIzMjAayFkm/M+byLqr4+m5i6bKhApmOzMljdB5D0Ei9EIz?=
 =?us-ascii?Q?wbOhFBXhfru9nZZ//yfPsjwThEDXUtg6s5urZH7IIt06NK+5TjPzxX4KoQFM?=
 =?us-ascii?Q?6GDq9CJlRF9QoaFFM/94+zYFoNTy8yZbvL5ArgYTT2aatnHDk/7crp47iB/T?=
 =?us-ascii?Q?drvWn9z2wl8vFCcdo+qUCuhypIPHWwMNNdl2DmzziJSu+UA0R84kgo9NI+St?=
 =?us-ascii?Q?qR4d5/C8YpaaLRuZ+dWO0sVY1UEBCXvMzHj+AW7gK6nuJfcDTlxbVvizK7I2?=
 =?us-ascii?Q?zLF76SYS6lQk6V5lM3W4aKfSyFBTOgzROZK9jwIbCEnlEJqlOI+xjgcLWCki?=
 =?us-ascii?Q?wwpZnmLeQLMd3VQjXzCGy+0lVTC37EmTmqV+Zx9lPPngBL/VfzUzSF9SDtgo?=
 =?us-ascii?Q?FIKjiTB2+ptACAOAopk7ziWLC0H2kaABVIyzaR6dt1rTeUSIzMj5ZA+fJKS/?=
 =?us-ascii?Q?LQfTiJ5oRcj3TaTKLIundbkHU8FAwtHSFvRCNCFG2gvQTPZvx/wKvjpwFe/o?=
 =?us-ascii?Q?5a0S4Q0go3VlzQ4UYDBq5AMRI4FP/sgO3/dGNv3V7CHJDln4Tuaf5NIMT/t3?=
 =?us-ascii?Q?0mU6egfzRiCOWBt2A9kvSImqwQUylcIvh0sL8AQiwX96kgEbdDKvETZKdBAP?=
 =?us-ascii?Q?i2Gs7viPH+i7ozy/OIdsxyjAMS2XFUXEX2ultTuCnbbMyT8C76mTqY9FK7ak?=
 =?us-ascii?Q?m65o259slpmGeMEdMeMDMZ+szwrxvcS7WzlwGDGUdkS9LfJkXbTVIrtpTzAd?=
 =?us-ascii?Q?FbXD8ov4tgefSWEOM/MsVJDoGmVfG6ONAWaxtJc95Ie55+G3JKifRxfJ11+Z?=
 =?us-ascii?Q?7fYX/WIOOcVX5Eauzw8vPVl7u9m0NrdLzrbJsD5Ve47gbMjAdwvI4aKqwuKc?=
 =?us-ascii?Q?1NoIHz7wFjOj32g7yjlULyUL84q/ZWBi5A2iKmEPYLw6NLD6sG98Z5ohVM1s?=
 =?us-ascii?Q?vSMt7CN2d7zc+We8GbazpUarNupz8T3SkfD9n/fG7fUDO013qjZXLKbrF817?=
 =?us-ascii?Q?wHJN7ihT3Vl3JYSYqg/NEhsQc/gYTmCARtlyJwe15/n3vABHwBU05pp57qyx?=
 =?us-ascii?Q?PqVf1Smu+diaYYNAZCd4Yn7YMK+y5YmtPR7uaSbj0JB9a8ddmG6EbrUSj7v7?=
 =?us-ascii?Q?H8uyPInjYViJLMRKvq+jZpw/Q14SJNqkGzsjeIY6sQ0omnEI/iDFvi/tNqlI?=
 =?us-ascii?Q?8iwg26bI087NkNoHxKlFO9pxSfCEYMFP9oRuLvyDy/9esF3BpQ9vNM+BdWrH?=
 =?us-ascii?Q?RaX8S7kNji7IgzWjy6xtzBHV8a6I3kTHYfoXprS2ZXcNV+npVswEnnkRchUe?=
 =?us-ascii?Q?4JaJYeKdTN9W9n++TtZqDTxi4NonnWnXJ1DVqxkc9h7WPfM0g7IkEzItXlFk?=
 =?us-ascii?Q?x5do3yHZJAkLY1XkZcRM/V9Gv1fwi2h6twhiFvRVJxK27kRjTgzVLZCxgSKs?=
 =?us-ascii?Q?c7HYaT67+84DdWuLHfEVg7mMPUoIeljWT+1mgbMkSDWFCRqCkH44RrJkpTpW?=
 =?us-ascii?Q?oYBHIN0+8y5kTaeoj8Ykn/iY/Y/0QZ7YyQf9bTvY3sKosxtaSV2RuinCl5ES?=
 =?us-ascii?Q?oJMr586tvpzte1P19lCx9Z2BsesXVC8ZBO1O9GOsJ+Tjz7bJ0B8683d5C9EX?=
 =?us-ascii?Q?+plI/5Kg3tNBz0VkVspHCgROhUdxwaN+mQ7Y9TAzk72z5v9d3dX/ydvvgEK9?=
 =?us-ascii?Q?aQJt/QhKkbAdKW7deXCKh2oERz5NxX4880vUGG5uu4mN6Rtb6cHC479YFHyt?=
X-MS-Exchange-AntiSpam-MessageData-1: Dd0225F91mTnQA==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f62f8b-8cef-4fcb-130f-08dea3d01d85
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 20:12:17.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PC9UhRtiooEjIxWGXuGpZ0T6NJeGRY8XyqdJ9583lrfaIKRr1mL6NzJ/7YZm5vrKwUl7CA1+LNbpMfHJXZXQVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB1009
X-Rspamd-Queue-Id: 86E8F46B061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-241191-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:email,est.tech:dkim,est.tech:mid,linuxfoundation.org:email,blackwall.org:email,msgid.link:url,huawei.com:email,iogearbox.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit e9acda5 ]

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
index 5035cfa74f1a..0858116687b4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2349,9 +2349,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
-		bond_update_slave_arr(bond, NULL);
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2385,6 +2382,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	if (bond_mode_can_use_xmit_hash(bond))
+		bond_update_slave_arr(bond, NULL);
+
 	bond_xdp_set_features(bond_dev);
 
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
-- 
2.53.0


