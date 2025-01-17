Return-Path: <stable+bounces-109373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1ADA15109
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292B4188BC09
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728E1FFC40;
	Fri, 17 Jan 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="KNmrj9X8"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9A1FF7C1
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122081; cv=fail; b=GK+4Y0ONHGcOAweaM4YCvWocMkrWeb3q/gtlTB0WQn6VzDowbCdG1GKvJQ/gCM0Dfl892v7I/VZBSOIfreMi9ijWNTQKfSWTsf62RhaipKmouKiArxZp314mf7j52bKYJ7hvKVmTKdJ9Iu7SdKfHFNYGdfNL+hrM5KbX1A5Z0FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122081; c=relaxed/simple;
	bh=rpIqeJmRayQnbOnsnmuZBHakc2hwOM/ztKJvZypt82M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l4NsQz0wI+7J1KX2LybZJ9LSUK2pAof9DdKQFVtcIfnk9XrzxtIECz8DsKN+XZB8C8KBOd3I3wjm1bU1YB/apjBJhRoQAwHZr4W8m0HmfJaE/GSFLDG9p5eiVvTbGweAl8ayCy7sNGhMHzC18KE0DodH4ECp41YUweLVjzCOPqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=KNmrj9X8; arc=fail smtp.client-ip=40.107.22.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuM2hu1S29dvOXx+acNVA8ij0a7I1+GKtrh64HbB/lfTbu7TaWag+KyyMZoQatSv9GvFGbNubugWjJmPxQpHTn9avzMdvqiFfrICODaL01TL4ILSOe4+Shz4oUpZFcURrxZoAndy4MePzN1Md/9iIbO+gGr9ZhCcggs7WhIhwjPb0pxNMFsIwht2hJD9g9runTjOwqFYPiwMCvhhuyh/hcs2pvwwYiIlq+0bXjrpU+xB1um/jGKjFULW17UvMuIbII73slTfmzsfq1kxAPvpBjtUWsuC1zrWkcFtTpFNGVx1DIRv8rywgT0ZfAb0q9WhuH9DIVu7UBEFB0bOqPzfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LoLCb+yCs07oE3m628YMf6lh63Aa4cBXhPGOSrJnKc=;
 b=OB4ad+PMfCTkYGfRHrp5HfNukIWm4LX4oZnu7kvzhcZT2pye4V+coSq/lgjcyCThM87i1w2UkJP+HAUh3sR5AOMvN/n2G/lZdZ+kcPgYQ8GepSS7ZxdKJRfOl+OO4g73jLiut1mrXX/chyfwSHd4tWLNh0rdiBjwpB5V7bamEq2Fd18wzROaO16Xf48FIooBbAlzNHq/+/IMDCi5Uz9EHTAIyiArfPTFpCErYoS+lSSVG+QJnZbzWyiRxLodRwiI8Le8eY0E5u75VmD8DZcnG3iCMTZnspZetNtuM1G6gSt7lzfh1KAhEXUSiIaHQmylFuAuZOjmYyhSxsNB6/ZQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LoLCb+yCs07oE3m628YMf6lh63Aa4cBXhPGOSrJnKc=;
 b=KNmrj9X8lPowO9NMnTM9ImwVl9P+GoMyaU+JBrgEY09SL4bc6e5Jpr4IODcPgT7j1uewJMY7lGZxZLe8bCbz6apv2gAH8E+DQqNNOtV50KVyhE7dgDKxZH+onUN9JacfT+Cj0gFklQy57SnFco3JNVQF7gyTOdk+PjQm6GdZueJWy+jwB33Szl3+/rwi9+gAamucack5mzByH9iAJ9CwxsgX6sjnkXziQxpCU974UdqcE0z6noftTe+acFhdWiTL0oNPdPEjcbtfxAQjS60guB+otKsD0qKYLNAku60rS4dlI0LDti2wKtDrtr+ENfoVI3lfNUzNwy84Yiioy1AcCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB9P192MB1873.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 13:54:33 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 13:54:33 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v5.15-v5.4] ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
Date: Fri, 17 Jan 2025 14:54:14 +0100
Message-ID: <20250117135414.4756-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0128.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::9) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB9P192MB1873:EE_
X-MS-Office365-Filtering-Correlation-Id: 86313b77-cddf-4273-3821-08dd36fe788d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N0r2/FLXIamkbztULX3hV7ObKiYFefZfWapCI4ACYgatOCXBL6u1/aF9MHne?=
 =?us-ascii?Q?EyQoqSb5Q2ZaWmmrQgiX6tpfARlRz2cOimD5YD4fVJOiB9iXRJCniEWLlQqP?=
 =?us-ascii?Q?MVelYeJLIAbyEavbuQPN2/G9XAnENXKjnLAjzoIaNOZqvMVdARBu4I10TSsk?=
 =?us-ascii?Q?vBfcpeVF9H8dH2KZqhKzWV3EBDf7nR++PB6q+t0H1X4BFQoSz1a28AUqor6J?=
 =?us-ascii?Q?v6genXuG58NFiPxV0hA1eZGCX6qZwnDFImFDcFmQP0WwyLGWa5dTF95/1ksE?=
 =?us-ascii?Q?YbHBs3lNf8aCiposuCJFZgOx5fi+LZEiAipxOhj5F9j3W/ZRVm+ocUhVDacs?=
 =?us-ascii?Q?NbjPCAhB5cvoGzJp45xfFDxM/18jF0o0Z5i30fg+7QAgPAJD8Mx3pOcl35ii?=
 =?us-ascii?Q?RuvxKnL2T/I+rvExqxOW610h1hwThKJr+dwttNhDTYtj8l2tP/eTdouu46/l?=
 =?us-ascii?Q?DFtolEsNIdxN3SlKBrQIgP8eEYN43LqJlrM7PRz2DlmVdfDbT4Q/ehsR+rDV?=
 =?us-ascii?Q?c4rMCNCsSpr2Jm3gSyflqQWTHA6GT4ZQTosVYu2eHM2hXDRMdu4do3fjp2LP?=
 =?us-ascii?Q?iHsgFQOSBJSFcKA6FEK6w3b7Qc+yNvbKs9A5P0uLBh6m+xz8a/znCndyhbm/?=
 =?us-ascii?Q?cOWkNwRHC627uJqTpxQy/UhGf+c2rOmH+7ZT0bp/EKBYKJkcejP7iYensyMn?=
 =?us-ascii?Q?KMBpzkk3A8d+GD3D/X8dIusrGys+DQL4K0Sae/Vvq5XWSaiAjcVFZNfXg/1e?=
 =?us-ascii?Q?Nfp5FCsPCFm+yz66/rKwi5kEYbJuBuTmX9uv0iJunM50e+s7wwgXw7QgNQbx?=
 =?us-ascii?Q?quJC4vgxshHPPgIWnqVWVqhXbtdo3srLhTXgcDhiNRucXw9h+p9reGDEy1Dm?=
 =?us-ascii?Q?Em6YZiGMicjXn61c803Awraln07SUcZk280MmlSav0yjRbHhnzMBE/K8dLaq?=
 =?us-ascii?Q?l0Br53oRcGUTC36sduufFDB0kyKMEQoPKSWWaSm92eI9rKPKBmuARWzzYTfl?=
 =?us-ascii?Q?ME/C7Ds9L0dMqcsHTyaXZXcMsyUfALQxooa99GnMMxUM1Ey8FgZ4GukOQJ1g?=
 =?us-ascii?Q?z+hJJGlv5VzPri8i1FcZ7ETLJmADOZYu0EbcXGY7vcJgjQXoj7EKQWIfyo0v?=
 =?us-ascii?Q?wLt0DReatMVn4fnC7nwlDHwUz7ynK59btbqQD3Ck5iYMPvhWQJhdk0BRiZW2?=
 =?us-ascii?Q?jLHSb/iieoZe2+qUw8ZXeHK60sEougW7rJSb+FHfR4sfAQY4rvmhRe9/Fifb?=
 =?us-ascii?Q?5bKEQ2mmRoaV/Y0jTJLZIKWUvdNjiomKJ+cztZko/GWzlkRWOunO8dKe2+zx?=
 =?us-ascii?Q?xaaYUSeapQAJGL5qnbOlQdSLyqB8dqF8vIMZayCOJUX42+ioVE59/3iBEvgE?=
 =?us-ascii?Q?77yb01+8KHTcJGNI1EE4OyIWS2fb8gTcCbghotgzSpmwN0pR2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eoYP7FbH6Bz+LismTW10bwdXDaxljP22CYxvQkOvbo0wCtLdeoRdBBjvHfb8?=
 =?us-ascii?Q?esuxqSvqkL80eMtBbPC7xGLahypsDfv7FIdI3uTOT5GPNGtQhllg8nXDQCV/?=
 =?us-ascii?Q?mLSCbfAac8d6qtDPQCaqPNPHIY0c/QqAicc8f3wfQg2FT3QBZZiQrLP4ICU5?=
 =?us-ascii?Q?PH8ENiUx5jP6r9sS02XgR7Pb6mc/8geSlVHkJNIhAx+Q4pJCAGsTCujYIhYJ?=
 =?us-ascii?Q?tZrnD+3oRKEASsznqyUBKC1XHTFC2OJ7T9tOZr6UlKSQtkHHcOGTKhS/Mt+S?=
 =?us-ascii?Q?P/H4JH5/TFkwJYtn0nwm4bz9Dc2XwxjF4jJJ7u9wotzXCCcCCp+P6iBjXtvx?=
 =?us-ascii?Q?IQvRnPdG3axKFJLY6tx/cw3Czq1gXehOQb3hhUcbEDY3x8ATAHUVABCFpNMK?=
 =?us-ascii?Q?XHX0pB96cq84z0jppEvlQ9O/RPxcjCBscEaZfXHZxThjUqJiLv3AM98401E0?=
 =?us-ascii?Q?N/97Zl5Fi/f2+hA+frOB8SPojc3aQekMRtf2pbbTSCxrAFYJYwldcIjpHCx1?=
 =?us-ascii?Q?gYRlK3UU6NKD4DIb/LxKQpH9VmEJJH6+Y1ZnrgIBX6stU25gYf66D/OJbZ5E?=
 =?us-ascii?Q?CzCEQqZc/aTN73m8uOOFrxSeMcqooCpSZIirF6kApIGHKjj3x7Aym3yvoqKd?=
 =?us-ascii?Q?GIcZLGFiKBHz+ixUMqPdZof2+ru6ndCDEw2+SljuDpJMMyv8QnY4ybOJ9v7I?=
 =?us-ascii?Q?W30UiwKo/Mk0MlqucXs8vlgWPxGBoF70vW/KjCcLUoILB/4hG2DoiWTHBE/5?=
 =?us-ascii?Q?OuW5z/ZxihPaP28+xc00J0JqreR6lgSFB+x/iLR5z44cyOtmOwvixrgygYiD?=
 =?us-ascii?Q?wqkOlQK/P9TOaiskp65fTd6IXrDhvRTg9+/CE0GFYxn3y/kS8vJMLUFCNmMy?=
 =?us-ascii?Q?VPZa90HNLGoHdLMofAbRSbVBC5N7IHM0h9glnBVpdX+xA/b/GdWlJ/svZr2Z?=
 =?us-ascii?Q?NM6btki3eLn4n69+RCjsXHuPbz07e7RMbEtGF3GRoaknKql4sb7UZIy6+Ac8?=
 =?us-ascii?Q?T0QjR3P1quX8enRL8zmXgO/wRr8nyZj3klfsUTHx3SFWfF4PfJxqjkxlObtZ?=
 =?us-ascii?Q?5PDRqvbEXV1l1Q7V5DAUuKtqiQSvVNI9VDpeE4ie3fytG67oeqZMooAOm7I5?=
 =?us-ascii?Q?NX8XM7n5yzfUdlgmnwvyEY4DXwOsdur5oQ8fryZbr/FQrUC5yANe1TpJkIRL?=
 =?us-ascii?Q?ZJuvrmazsXKjD0JgkfiXXJBfFS+OInwIgQ/gqvulousvs4yAcD873S5xYqDW?=
 =?us-ascii?Q?A5zM7PlG/m1A2s8zqaeeCJcebbfrjJgFJLnVL23DGJnsS7dEtNBOozpJf0iZ?=
 =?us-ascii?Q?FHEJph3PfaffgpACuKhhjBtmqJbPhVYVvwLfcTUKGXsjBguW+o087MfqE5cd?=
 =?us-ascii?Q?6gv2B7liQzW/VhUUk9wrkghIFLTBMfnOPvlUHB82u3AjjcIhjW8XneFYSZt6?=
 =?us-ascii?Q?Hk5Z2POM+sBtRXHfvVNeM3vmVvOe1aGFl4c7gAzv2/6DTjYYpizMRaSUsK3C?=
 =?us-ascii?Q?c1++kOxSqWPGO7kyArOuXLi9MizPMMxXybbtTwT8Vit1tp9/9FLSqKarpbQ6?=
 =?us-ascii?Q?sO8Rz7HrWLCIJ5LrsBYTNOZ3HMY9GGAzrZ8fnvHz?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86313b77-cddf-4273-3821-08dd36fe788d
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 13:54:33.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FD1VWf5bMBnAWt5oVng1K2d9QhNVJxgsx9AMo0DHQvjhyukEtNc2H93Wwwkd2H6amic7QsfLw2Vd3QpaXbK3Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1873

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 04ccecfa959d3b9ae7348780d8e379c6486176ac ]

Blamed commit accidentally removed a check for rt->rt6i_idev being NULL,
as spotted by syzbot:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 10998 Comm: syz-executor Not tainted 6.11.0-rc6-syzkaller-00208-g625403177711 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
 RIP: 0010:rt6_uncached_list_flush_dev net/ipv6/route.c:177 [inline]
 RIP: 0010:rt6_disable_ip+0x33e/0x7e0 net/ipv6/route.c:4914
Code: 41 80 3c 04 00 74 0a e8 90 d0 9b f7 48 8b 7c 24 08 48 8b 07 48 89 44 24 10 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 64 d0 9b f7 48 8b 44 24 18 49 39 06
RSP: 0018:ffffc900047374e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff1100fdf8f33 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88807efc78c0
RBP: ffffc900047375d0 R08: 0000000000000003 R09: fffff520008e6e8c
R10: dffffc0000000000 R11: fffff520008e6e8c R12: 1ffff1100fdf8f18
R13: ffff88807efc7998 R14: 0000000000000000 R15: ffff88807efc7930
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002a80 CR3: 0000000022f62000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3856
 addrconf_notify+0x3cb/0x1020
  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
  call_netdevice_notifiers net/core/dev.c:2046 [inline]
  unregister_netdevice_many_notify+0xd81/0x1c40 net/core/dev.c:11352
  unregister_netdevice_many net/core/dev.c:11414 [inline]
  unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11289
  unregister_netdevice include/linux/netdevice.h:3129 [inline]
  __tun_detach+0x6b9/0x1600 drivers/net/tun.c:685
  tun_detach drivers/net/tun.c:701 [inline]
  tun_chr_close+0x108/0x1b0 drivers/net/tun.c:3510
  __fput+0x24a/0x8a0 fs/file_table.c:422
  task_work_run+0x24f/0x310 kernel/task_work.c:228
  exit_task_work include/linux/task_work.h:40 [inline]
  do_exit+0xa2f/0x27f0 kernel/exit.c:882
  do_group_exit+0x207/0x2c0 kernel/exit.c:1031
  __do_sys_exit_group kernel/exit.c:1042 [inline]
  __se_sys_exit_group kernel/exit.c:1040 [inline]
  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
  x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1acc77def9
Code: Unable to access opcode bytes at 0x7f1acc77decf.
RSP: 002b:00007ffeb26fa738 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1acc77def9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007f1acc7dd508 R08: 00007ffeb26f84d7 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000003 R14: 00000000ffffffff R15: 00007ffeb26fa8e0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
 RIP: 0010:rt6_uncached_list_flush_dev net/ipv6/route.c:177 [inline]
 RIP: 0010:rt6_disable_ip+0x33e/0x7e0 net/ipv6/route.c:4914
Code: 41 80 3c 04 00 74 0a e8 90 d0 9b f7 48 8b 7c 24 08 48 8b 07 48 89 44 24 10 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 64 d0 9b f7 48 8b 44 24 18 49 39 06
RSP: 0018:ffffc900047374e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff1100fdf8f33 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88807efc78c0
RBP: ffffc900047375d0 R08: 0000000000000003 R09: fffff520008e6e8c
R10: dffffc0000000000 R11: fffff520008e6e8c R12: 1ffff1100fdf8f18
R13: ffff88807efc7998 R14: 0000000000000000 R15: ffff88807efc7930
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002a80 CR3: 0000000022f62000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: e332bc67cf5e ("ipv6: Don't call with rt6_uncached_list_flush_dev")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20240913083147.3095442-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5dbf60dd4aa2..d7d600cb15a8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -174,7 +174,7 @@ static void rt6_uncached_list_flush_dev(struct net *net, struct net_device *dev)
 			struct inet6_dev *rt_idev = rt->rt6i_idev;
 			struct net_device *rt_dev = rt->dst.dev;
 
-			if (rt_idev->dev == dev) {
+			if (rt_idev && rt_idev->dev == dev) {
 				rt->rt6i_idev = in6_dev_get(loopback_dev);
 				in6_dev_put(rt_idev);
 			}
-- 
2.43.0


