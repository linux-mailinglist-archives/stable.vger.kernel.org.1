Return-Path: <stable+bounces-241190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPFwAZdx7mnctwAAu9opvQ
	(envelope-from <stable+bounces-241190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:12:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D0146B04A
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477BD30038E8
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61938F648;
	Sun, 26 Apr 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="AyrY2riO"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54D263F34
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777234322; cv=fail; b=E115n3X3Xk7xKPDPNVuI62RHibi5RoGRcA4HUEERVFHWjOoslVlVa/yGt5EPR3GnbmPZPr/IhA1x0ZA5yqa+VgkNkdjgPrjp5EdLqgk+GuQRD0+4ep3Wa0/0X33rYN9AdgkDyQPVMxcuHw0+Ifed8ZTj3ddBsT4B9bucPQtR+ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777234322; c=relaxed/simple;
	bh=VFItTl1C+wS7QELxh8iJ41/Xi+Ppb843NXa2hHKQ2Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n1pACxfWRbcdOh+VTxQFRDJpBxtEOiWAjtmKQ9r9EXEkP+5tbAQ/JwKtZ5CvEPTk8wlSDtWQ2UI9jyKQMeVKTXitzSpys2GgczcTdTB9FMlESDb2RNzOBPMaCpWBb9sE8ebMQBgK9pFACpWd8jPIb+lXitF+CCh7AJE1NoBh18A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=AyrY2riO; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjKP+JZyzKq2k5BD9aHo8KZZnrWNbMVTaEuF721OHXEufD//KPnWiiHlnc13IxBRmUwW8g4gwDr33A+Gjyx+l0UpPEwRk2ZzinISNEBLLW0sGU6L/MKOhfeA6qpUGWndtnrw8Nr4C5ZvE4QtPB6gUEOC1d6xmFcDuuI4aiJXoUV7bKNyUniqvksriLgcAey4pey1zcnfkSMiwJ8NdRC3D0jzlLT+Jfhvmje/ImGCBIQhF7PChkk2Et905C1FHa8xXAYZzF4FKDmMYQKYkbfg6NmTtUzAjDb3iU8dGaTB5afIVRFeqFDe9QlYRRTmuZ9Ujeg5boKGTFQpm7OjqtF6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/36N++rsoD+sIUjuuP3n2aA02W49rNs/FWZIu+iZ8Fk=;
 b=qTq7htakBQ+BA8PjdyM2wpHlAH9nuuTYM9XqQ7DwjlH0EMi+S7rLCc7alROX5GwoTvIzLfgzBadiDHih/dW0LRyiKPok1PVVh6w3DicWyzWEzcJKcQ/GEQ4ZpwMEyx61Cu7TBDVUKyYT71Hs8tZW/KHqpfffrLSAK4l25H0NAvvErTVSQpXixwobCmy41u1XE1alNVCiKPInx9BhJAzRwCW+FShc6Cb9aKMrXHI+t7KdN+Mh+T5HUqhEegYP1efmZMstZSireC/47fkrLgq34UCMd+TLoYRS/8KjL/4fbFy7A5/VsAobZpk3/83c6hsXg2atJJ23YTsSbub5dORE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/36N++rsoD+sIUjuuP3n2aA02W49rNs/FWZIu+iZ8Fk=;
 b=AyrY2riOQrabgFdlgX2qzbRiPu7FSqpMBd/VsZoAdzotR1saQPT2SWS3mWKF/O/bP8rbCAT1ICtXiEEaDttT06AyjLAJ1ghVJzuKLI3bPTEbmLmzjblrnwnCaj6DaQ0/PTZosZ87u/HaDb8+U8tYbFrg2XuG/5ymmXryhTrLzE1yjJdpI3kC+/6rP/dmgtPnqGa36I030WFRVnmBxKsEP26kI4vuOo7OWjXzSe378VQ1gRv9fx/usaEkECvcpB9HntPx3ZXVBaa+PZSM9uXf1jngcVp6kdnbQhlrJxX4Q00AluPa4TdkhFii8bq+0ioF1evXUCS63hV6p9nrkuFYwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 26 Apr
 2026 20:11:57 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9846.025; Sun, 26 Apr 2026
 20:11:57 +0000
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
Subject: [PATCH 6.6.y] bonding: fix use-after-free due to enslave fail after slave array update
Date: Sun, 26 Apr 2026 22:11:44 +0200
Message-ID: <20260426201144.465734-1-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0283.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::18) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM7P189MB1009:EE_
X-MS-Office365-Filtering-Correlation-Id: 679e45be-90c3-4583-2061-08dea3d0117b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sSGGLEJDSANQCJQt6zaVhWyiZLklxMDx3fSYwhX3nXsh2Pfng/TnUS8nJtteYTkGlWypx7mD9vc1tlGymIxUvpynU/gKQdLnEc1uIspxpGh0Ky9AMVPAvobxezN8RYr5WDQNZ/jr0pcEeVkub+JXb0qGwgOINS+ODIkNG52XZqz/hnaBDNKecVOzJBcfR/Q6KvAjnywUdsRJzWgwNVqC4jKdYZ2J0k4rXjlsxIjSZErn7kufWaCQKUQZ59QKR1bLFq709JCbZbB9/0zr8cbTNHGNCUNprriyd8stod6v7iz6qDIjGtA1w033J2aGPYR8nPW7kLMCZUqtE+xnWFcbUNgDX+s45ZVjT5c4kL5O3+ch2ME/hGzRpzFmz09Bt3Wo6NwaW4MK4w+sTPUhU7gFNiEnHkzFQ8KdbSwzPMSdZbdIWzi8BviDFoDU7fA3LKneJ5FkSohv98QPCb+3BJQrd/CeV6SmEXBOUIpnmK1CDr6+pMkG9C4ssp8MS1XYTYDHh4uPBj6R2+XdOnztdLD9wgGg+Ml/N/UqJjI3Fq7uY/ssXHzMeS/ODluM7ItIuuifpsLVHxpDEIy/3jgMlLvfpqzBpWevByvW4RuLtgYNsqg8UufKTHgFxIvPln4YN9lirfLHRjC6rVLISJycOs9/8cY3WzGPMee05I8w6ZjU9oTlBPOlE02M+NppZc2z6o6v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZirSSbkSgb0YnhV4IpDTkNWpmJNV/TMw51chuXwGBf4RJ95alIGUQPakBQQ?=
 =?us-ascii?Q?JwrsjdZQbwRgh9XvfFXnkbiRx+GRpG1IFuNrDntnhtLRtrwK31QY5vez+iGY?=
 =?us-ascii?Q?qfq8EVcOSs8FHRll4raNJ763NR3UIrqRiF+7KxyTTmWVwDrG6lNH1gGsuaC5?=
 =?us-ascii?Q?UsaohKKV6PwSdhaW9+7NAq6XU3GMkfhrCw9ZGbIt4ZfaaZy6HdzUNWm1F1kb?=
 =?us-ascii?Q?rMaiN9/VKUegFUOjrk+MFi/LtYRDIsMoAzuffSgNX2tJslPCDizPI1NdQUpU?=
 =?us-ascii?Q?n3Ajj1Qr09J4mHJmh95TGvaMzRCt2qtTwNG4lGGSX47AekIaxGFrtYyUeLWx?=
 =?us-ascii?Q?ufGRB0dxxfeI9MrJVK2YiGWZcthtyKjTtXD6cZRNloglisR2D0BnUxJN4l4K?=
 =?us-ascii?Q?B3mTCR4sEC0Q9AkpTcHmasc/qowaLx4lqxVoEYyxlQX3PoE335aM3xN1uCo5?=
 =?us-ascii?Q?qrD9ANM0VwUXS44XecsD+gd0Ibq3kOtuWKhomLxFD8k+mcYyy5sXhPnCWc3R?=
 =?us-ascii?Q?hcTnfYnlr3iN3hQhdnM8Q2cVoy0FZqPyaABOq2GJC+dMW9Ws1ZSADF9sRu3K?=
 =?us-ascii?Q?EHz4NRw99mWXLOPNK71jgBDXB2IFBWWNonDh+kSrT+LcXJQDbRkFpoEbsyqc?=
 =?us-ascii?Q?XgVXOa4EoRKAUe1lQFrVMZD23C+eqYbkThDMROwi7Rx18cJtirzwKiOlT5aQ?=
 =?us-ascii?Q?yHR/dV01gJEnNFt8yWnk+ZNcyEJtq3hUUcq3HtCyHoIr5hhFv8uFD9meSJDy?=
 =?us-ascii?Q?xnntJFbroP/e7ILDTTVJO/mNySmxMjzWD21Gmt5Et0dumAFP2zCbXaaOUvE0?=
 =?us-ascii?Q?xFizyOkXoMoMIrPqcxQ2tvbyhEiFsBwSKryFKcMlus0u2fCDEoompGMvLM2m?=
 =?us-ascii?Q?LsNBlvFbCYDzLxuySS5Ld323vUSF+UYYBcPCm+CITTc3G20x6aEdvxnbafy9?=
 =?us-ascii?Q?hQE4BBlmxSFMV8pO//LYCO+/elVDJk5g3cbpya0DAXcPPfs/Q/OTYvWYno29?=
 =?us-ascii?Q?08r764m0Gpg/nI6vToRdMbUYwEvwf6l6TLE47CTyTBvWwdirN5b/cmrbxMp2?=
 =?us-ascii?Q?uHnVm0OrHJEYJWcVdcLvbllA0QLPrvvtyRHV5RVYwgTualTZ697/J+YHLVSr?=
 =?us-ascii?Q?8zhvTx3jHzN2zr3pDAhR9busO/ZG+RLNiEsAgBK5z+pUjEvCA7MR8mKWTfAK?=
 =?us-ascii?Q?OE4gP9U7wt+PTAHoF2fzxr/1jaEUrbZzPoBm8bdkZpypQ+LEzbqR94dcGtt7?=
 =?us-ascii?Q?MJigmMpdVTsQYBOO8cCPbQ+hQ8rfrX/NwdD+D2jwVfuxYWAIe9Thi39bOVfJ?=
 =?us-ascii?Q?0YAGqzcOHWxDTuq7/R2L9EcwaBjQ75E7qBJEYANfAZzR1tepVWNBGp1/WPiE?=
 =?us-ascii?Q?2o9dXW8w9V9WAARGVMIYd441awh1SjmvPLwyL+IOlBXKwYgEI/x1QbaHyR5i?=
 =?us-ascii?Q?dthnzXA/DfUkFY46BGB6RY4584ZtrA+wvToAiPjYXHSfXNdOfVpn6T58UuQC?=
 =?us-ascii?Q?O7saqXiFb9kpHn69LnIZLCjTEkV+hvK7mbNs/ErbDzqjcfqR44BbCQwJ/JoU?=
 =?us-ascii?Q?1DaPHyQzih2QFx8KupqsIkPlFeiKMv0yAnwhaSaSEYdGvC8lbL84Al53O5yn?=
 =?us-ascii?Q?h1ZCEt5zgyWogMaoSnQOWeJjVGA24HpAnOog9uDWzZ5COVqr9GUYTtAVDHma?=
 =?us-ascii?Q?b2gUGx2Mlz3e+AsaMOQX0d1Xxtj32NM2UdtAsbgYmkeT98FIJDkLaZMQHD09?=
 =?us-ascii?Q?5SoaNQlXjhWkLpP+XDMa8efN/f5ctnY3UvoKFtnS/0Ekn967CMl5MXenwP1X?=
X-MS-Exchange-AntiSpam-MessageData-1: EM2JGmTKY+eCBw==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 679e45be-90c3-4583-2061-08dea3d0117b
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 20:11:57.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZT7OOaZw7eq4fzITLAQt28hkgA/ZwE05Fu0HNNx8XK7VTS6a95wBXHWw5rxK8rYF0eKPEdsM5duKCHr2oA74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB1009
X-Rspamd-Queue-Id: 61D0146B04A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-241190-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,msgid.link:url,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,est.tech:email,est.tech:dkim,est.tech:mid,iogearbox.net:email]

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


