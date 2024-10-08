Return-Path: <stable+bounces-81563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1A9945F4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CEC1C222A2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195031CCB33;
	Tue,  8 Oct 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="14qxYrOo"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8101C9B77
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385166; cv=fail; b=OFl7iHcGYEZgODJZcYdpuVDB1FsqPR/sZ+eK6nh8E60GuNX5W/iCwBJy0v2SXT8AnlrJjN38091lK0uwNUXTdXcK6+TCCVYKCk3XCNIa5x5F2/uwRc8LPVsLn4FGP1Mz372/xYvqA7MBTaZSbjGA9KWvhRqeF5w866gTlCTkZSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385166; c=relaxed/simple;
	bh=q08XqnuiZIXcE9rCZzajjvtpfe3vGu0YTx3S+8yoJOE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eYXtQwdKnfKwDTxZfB2o7zB+4hVFki5alM6fPAH2RENoD/eC/C1gVtxt0YRhDb35XoZl8TqCIvF8xfGxYMUtnzn8YaLYQztBCcHcCb8ZtDtDeUzv/YlgkPq/vQW+5s0Va41gm1EXHZVrkfoI+CIq442nIygpIb9n+9lPUtmbpHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=14qxYrOo; arc=fail smtp.client-ip=40.107.22.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fg5K7zaMHB2AN39mhJr9tGUXMyZ8Utx3DP4HqgIYeWh1BO98IeWuKqblVm8qFRi3XFjscbhWdCWKdIQiAol6rVae82WcQA9Wg1/hRoJQ5zpi+2qu9NRVERMtmyez8vrUEx6UXDyWm1jY3TQguKuRBbgWQ/I1tdRcWDm2TdhjWMV9pGiNJw4wsF7ylE8d5/V1qlzb4q2G9+QgWbhat7InmTt5C4qVdzLYMw6XQjfFFDwaArY7tldgtRQE3bYqN1M1FspNeS017uhAGBZobyU5ZJcpDnZ/EwE6tHHKTdwWAIGspLftynFZXBFgL7+fZUZ35eTl06icCINjAZOmHCW5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9pW+AZJ0FwFSQi0+jovC+Pis7cFlLtPsVo/+pP0UTM=;
 b=iXRCZNIsZcAc5b+62cS1FrsS8KDzPxPjIuwFJvKoGLGUH6UgYXANhtjEzeqFfj7Il/3OHH2vC7Ayp87lZwANESnH3BcVhmq3rcBAi9L+zlsOt88PeoLod5Vfu0Jfy7qECmaTvHUMpFCqRZqN3tqCCCdambyBy2e+UD9SgEEXjZUT5w0jtW+a8wXEtVpGtuHTmsDuuuS1twgl1+HVU8UM3PyR8cLi9rnYSW+6AFAA/CiFB+guPn9MJX2s4CCc9iiiNwZg3/52c7bvwGiPBOPz/21551Oa5LA1AltZ3/XSNDe7e9tSYxo28uEy1QI+Zqb96BknfXrDBpQo1IGcxNDjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9pW+AZJ0FwFSQi0+jovC+Pis7cFlLtPsVo/+pP0UTM=;
 b=14qxYrOoIImqyWCO8ziyw/Rb2b6JN+3G00bmwfK9+Yz5N0GJKOdUurLcWZ6BsodUI/wug3h0sk0V7ik8bt3gRl54E7WLDc01VOzjvEht/uL3I1Ztgk1uF8nvT6a1kZLSt5XUwRr6711SYxpzjnazwDNSQz7CokkjZiKuHLMsJ8Kmra8lJ2Xl+M1x5YeHkMaVFAP5jP7zmBSuU0OIjLXQuSlaIPihcdSsmb44gi6jTGN/SGSyj8b6DgKPnpYEnc4O6FmQuF6tNf16XZO0xN9SzLYXxlkokSLhxU4+tVuqq8UE7HaXbL/Lw9L0oxyfWV8Sw1pUazt3dmAuqVZ/sPecxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by VI0P192MB2316.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:248::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:59:17 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 10:59:17 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Omar Sandoval <osandov@fb.com>,
	David Sterba <dsterba@suse.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v5.10-v5.4] btrfs: get rid of warning on transaction commit when using flushoncommit
Date: Tue,  8 Oct 2024 12:58:34 +0200
Message-ID: <20241008105834.152591-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|VI0P192MB2316:EE_
X-MS-Office365-Filtering-Correlation-Id: dea05d71-03af-4260-19d7-08dce788409e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jSCLna5qVDZyfTIBP/tud7lN6+RMZYPBAOclOIt9d2aa/W8ny8cEcT38lMwB?=
 =?us-ascii?Q?Kncy/nhHBE/s2cudYhuBx1hrHvLIONe8rGKJJamybvAW81MfrN+kLdC8Fr1V?=
 =?us-ascii?Q?zXMFNvcbVP4G7a/iKJ6jWBIOy49q97ediAfarvI+ivzS3dEsG6gIIFk6Gg56?=
 =?us-ascii?Q?46Vs5/Bqm7ckexqeg9WiMr+lKmjMnIWCSIfn+oelJbJas9xKX0/jTqPwM1IS?=
 =?us-ascii?Q?kbWErGyvh4Tj5o7PyxLHss1w7+bXF2lsvXgFgGsIEKLoRqCiTRW+gxSk+mHj?=
 =?us-ascii?Q?TKIHPJfN+ppcVpqz6hckrQsh0jtoKOSvkwZG8NK54mD+V2fGCsdXI4MfYifb?=
 =?us-ascii?Q?EYFkIdNs4TzleIWOWjodLbbbh+fXGBVE5FLHSVhofT+5S0/Ei8jR1ERxSKLH?=
 =?us-ascii?Q?YWwWZCnnTpMCKR9nCckgu4rD7q3t7mqKG0dypp5mxnDTe/QaXtW3NfZrtdZM?=
 =?us-ascii?Q?OMxO2SMm7K+EFrRLqY9XB3yPXlaOzJk/axdPePzAaqSZczh9gswn+RgrbjRm?=
 =?us-ascii?Q?pQ7MmWFFN2uJ8XWTlpXsk2iSPO8Y2k2z8ZHVP3wdgbHZU2MmBFyvy4oLGi0j?=
 =?us-ascii?Q?DJZw6P+0JkXRRjjP/hLfxQGyW3xdGRW1JE/dn/7T53wbxJWtrcdOI0EiVtny?=
 =?us-ascii?Q?aq0s8sQIjNBO6VC2U0O9j/56yFziaYq9hHY/VJMEQ4PJ2iYdSbTpwUxNIJrq?=
 =?us-ascii?Q?qzuBr0ZOAuys/9IpktKnZqNypfbYuuQt3V+TAE97pgWKMzS3b9qYa3J9RyVf?=
 =?us-ascii?Q?lRqwE5ZSsBRlKeMVER97psONVr/Bh0I1P3p7WvhawBuvQmc/nO4JvvgmmH1x?=
 =?us-ascii?Q?q2ONH0CJb6+7FqA1KMPEDOJzaUddSRD3s3vxbX790CGSOK9pz0+m8e3YLhNF?=
 =?us-ascii?Q?abmDDq7nkhg9bNomnJbHFnR6Ba4XkcXTPimwigCrRPcj3hyUOZAhQufq4kHk?=
 =?us-ascii?Q?UvodFuXZ/C1ILme34S3w015H6gDp94JAOh2yj3YYVTYjcw+/wQcSQBRrL2Jm?=
 =?us-ascii?Q?VhCQ4nlv6VxLZezXXbzVbmOKkhU9w9Hht/UQ0ZwrwVlmCukj8lB0C/snBpq6?=
 =?us-ascii?Q?cGFb/WhQzre2unQNISDK+BEHf1rB+DYqiS6oyBGXftDZpyyhmszKyEqGFgMT?=
 =?us-ascii?Q?hI552Lc/MdDjpoovnIJPXQ8DHC46Bb4sFXG5Q4ZEiXw53/Vp4hsv3DxHSqJl?=
 =?us-ascii?Q?FwHba5fsh7yxreNEruOF/pWpCLMjBzg0HAHfgVWuLCjq9gPGvHT4dXX4O1Di?=
 =?us-ascii?Q?UsRSxFDG8wfhMRydTxFgXAYHy2miI+Ln7nGwE/8l1cVZZQT60ROSxJAl8lu3?=
 =?us-ascii?Q?P3n32ZOULfsgT0cFuKK2aRINY+8CZwGxK+VZbCIYKCHfjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Oub5F1X5e6ngTUZ0GXpUDI0kpKyx29vI0dEvrSVG4UvR5tduCqs/kFfQ3PJ?=
 =?us-ascii?Q?Vx/ek8tfWnOw4e94xGY723+7CQTeLJ7SiOO3ujWtlnmjTzZZ+iFcyPXtpUFH?=
 =?us-ascii?Q?7BqhEg06EuvXK9N2cVFm0UYlV9yO+zWm23LSfPKr/miH5JEzg6M0tKxLii3+?=
 =?us-ascii?Q?PgHjvVi1lp3fXEzFq36Mi63AVIKj986kUOx1UjzstkKdph59FxVBB0yoN8rA?=
 =?us-ascii?Q?ESBgr8fZ0QHZzNAqPIpJy1JqzCnFm+gN5MxZZVUfwEBhHuZ5uWaekrig5kKu?=
 =?us-ascii?Q?dwI5VtjRQLfKFT/5u5pd4DEEa0vABBZy1qzPPwBxlytaIsfq5AAoyvVQ8XDR?=
 =?us-ascii?Q?TCJ3hmcCTBRbkd/0KnS8tn5e5E0+T31cg1LAgc2hCAr2zP3tCIASDyB5Eryx?=
 =?us-ascii?Q?KaGFKvolmG3NosdGMFcYyRZzjgYKHXf8SZMNGgXS7fkr0B+WBL2iF5hs8FuA?=
 =?us-ascii?Q?eIP3KODwR9vjWagIi6enrmjxar4Vd++DwTJ/tfo1QqBxAJxQHKXDk1V701M/?=
 =?us-ascii?Q?97WbUnmrmXrOCqIGcY/jWi3PwntlPc96TNTp+6UonhfqbPL6qTHFtkFqYc9h?=
 =?us-ascii?Q?XytIzdAJVM9RCK4kXrRXtJghv+HdJKPOYmISsqjR6PFmz9JNYQxScZfQYlCr?=
 =?us-ascii?Q?6LwsEv/7HPIxOn3nFzEAFi5nKSftAvWN0P3Z82C0AUzKjwK25wIi24QN3fFZ?=
 =?us-ascii?Q?wHp4ckP51zkJrar6ftUz8FHCvR+figK3wS0vN5OO9iP0+FYHXfzyRGsM36IZ?=
 =?us-ascii?Q?qe/cbiWnBxlpS6WqfUwY/7nJmoru0IOB9ou2O8w8xI+OfFE/Zpz0Iu161p6q?=
 =?us-ascii?Q?nNhNM16uaGTQeYJzMe21Et2XhvN20a03TSRpez0GQS8b7w8XJj7p1rdPTtT7?=
 =?us-ascii?Q?O/A8POHZyEMkaGzjpg6wvyf8XzmW+u5jnDu14/0kgrgsKlCb8yr7F2PWgiM8?=
 =?us-ascii?Q?MsUDQMWYA3IXrkBSGe7yMDWKdblOI9KUt/aIxYIPNGAPssAkxl8CJVXWF4N8?=
 =?us-ascii?Q?IcyFnbTZpD5IKjJ7jpAqqqCewXBGYYg94A8FKP59LkhY+f40wus56LvPygxQ?=
 =?us-ascii?Q?iaJbEa6XmnPxWtFDa5UBM5KQ12mkwKSZ1TOfJYTgPNnOT92akOxokaUlOgp0?=
 =?us-ascii?Q?7456SbI5xjh4/yEF022T/wcZcieZmcmNh3FAOSws+2IrrH7ZYETbccg64xvt?=
 =?us-ascii?Q?V7U3c6kxLcb+MBGVrQS4nEVFjTwwDrVne33zfO5sD0m1eKFro6GXL3b7Z9p3?=
 =?us-ascii?Q?e38Zw5wcKWR3yqEadfQEs9hdMxlMQp6NgBnuT/5jsIxBgxVbMAmNmKtjBfyx?=
 =?us-ascii?Q?laityV7qEOkWk3l7lcElpa9MEgi7BzTme5MZdbJTZeX6PioQdY9mZZnus9LG?=
 =?us-ascii?Q?NOGqCOnWdOSFBsbHH1GJ85++lKvR89i5MAmdudu4nHAwLWJ09A8RdmCySAD3?=
 =?us-ascii?Q?ifzP0gLlDor2Slkg+kR8Z9seC/VN0+F/5CZRJF1xN7KtNuqzHvjbhOlquk1z?=
 =?us-ascii?Q?hXaYWf4MSFqwz4m+Ypy+B/Ihz6B9DkaYrZ7Mk6tfkEOFJeH0KYJtwzCeMuin?=
 =?us-ascii?Q?6RyQIq31+m9qwb+urE3OERpIirlbAtD63Z+1AV2sG2CLAH9tlG8fryxVRPbJ?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea05d71-03af-4260-19d7-08dce788409e
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:59:17.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxwo5tFazjFvbvdfNE7cEOo6hNMtKJYF4bkOW0tP0eJV7QbVbIRoSJrT/Dh84elOFVi7ChuzYJ5XVOGD/rlu2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB2316

From: Filipe Manana <fdmanana@suse.com>

commit a0f0cf8341e34e5d2265bfd3a7ad68342da1e2aa upstream.

When using the flushoncommit mount option, during almost every transaction
commit we trigger a warning from __writeback_inodes_sb_nr():

  $ cat fs/fs-writeback.c:
  (...)
  static void __writeback_inodes_sb_nr(struct super_block *sb, ...
  {
        (...)
        WARN_ON(!rwsem_is_locked(&sb->s_umount));
        (...)
  }
  (...)

The trace produced in dmesg looks like the following:

  [947.473890] WARNING: CPU: 5 PID: 930 at fs/fs-writeback.c:2610 __writeback_inodes_sb_nr+0x7e/0xb3
  [947.481623] Modules linked in: nfsd nls_cp437 cifs asn1_decoder cifs_arc4 fscache cifs_md4 ipmi_ssif
  [947.489571] CPU: 5 PID: 930 Comm: btrfs-transacti Not tainted 95.16.3-srb-asrock-00001-g36437ad63879 #186
  [947.497969] RIP: 0010:__writeback_inodes_sb_nr+0x7e/0xb3
  [947.502097] Code: 24 10 4c 89 44 24 18 c6 (...)
  [947.519760] RSP: 0018:ffffc90000777e10 EFLAGS: 00010246
  [947.523818] RAX: 0000000000000000 RBX: 0000000000963300 RCX: 0000000000000000
  [947.529765] RDX: 0000000000000000 RSI: 000000000000fa51 RDI: ffffc90000777e50
  [947.535740] RBP: ffff888101628a90 R08: ffff888100955800 R09: ffff888100956000
  [947.541701] R10: 0000000000000002 R11: 0000000000000001 R12: ffff888100963488
  [947.547645] R13: ffff888100963000 R14: ffff888112fb7200 R15: ffff888100963460
  [947.553621] FS:  0000000000000000(0000) GS:ffff88841fd40000(0000) knlGS:0000000000000000
  [947.560537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [947.565122] CR2: 0000000008be50c4 CR3: 000000000220c000 CR4: 00000000001006e0
  [947.571072] Call Trace:
  [947.572354]  <TASK>
  [947.573266]  btrfs_commit_transaction+0x1f1/0x998
  [947.576785]  ? start_transaction+0x3ab/0x44e
  [947.579867]  ? schedule_timeout+0x8a/0xdd
  [947.582716]  transaction_kthread+0xe9/0x156
  [947.585721]  ? btrfs_cleanup_transaction.isra.0+0x407/0x407
  [947.590104]  kthread+0x131/0x139
  [947.592168]  ? set_kthread_struct+0x32/0x32
  [947.595174]  ret_from_fork+0x22/0x30
  [947.597561]  </TASK>
  [947.598553] ---[ end trace 644721052755541c ]---

This is because we started using writeback_inodes_sb() to flush delalloc
when committing a transaction (when using -o flushoncommit), in order to
avoid deadlocks with filesystem freeze operations. This change was made
by commit ce8ea7cc6eb313 ("btrfs: don't call btrfs_start_delalloc_roots
in flushoncommit"). After that change we started producing that warning,
and every now and then a user reports this since the warning happens too
often, it spams dmesg/syslog, and a user is unsure if this reflects any
problem that might compromise the filesystem's reliability.

We can not just lock the sb->s_umount semaphore before calling
writeback_inodes_sb(), because that would at least deadlock with
filesystem freezing, since at fs/super.c:freeze_super() sync_filesystem()
is called while we are holding that semaphore in write mode, and that can
trigger a transaction commit, resulting in a deadlock. It would also
trigger the same type of deadlock in the unmount path. Possibly, it could
also introduce some other locking dependencies that lockdep would report.

To fix this call try_to_writeback_inodes_sb() instead of
writeback_inodes_sb(), because that will try to read lock sb->s_umount
and then will only call writeback_inodes_sb() if it was able to lock it.
This is fine because the cases where it can't read lock sb->s_umount
are during a filesystem unmount or during a filesystem freeze - in those
cases sb->s_umount is write locked and sync_filesystem() is called, which
calls writeback_inodes_sb(). In other words, in all cases where we can't
take a read lock on sb->s_umount, writeback is already being triggered
elsewhere.

An alternative would be to call btrfs_start_delalloc_roots() with a
number of pages different from LONG_MAX, for example matching the number
of delalloc bytes we currently have, in which case we would end up
starting all delalloc with filemap_fdatawrite_wbc() and not with an
async flush via filemap_flush() - that is only possible after the rather
recent commit e076ab2a2ca70a ("btrfs: shrink delalloc pages instead of
full inodes"). However that creates a whole new can of worms due to new
lock dependencies, which lockdep complains, like for example:

[ 8948.247280] ======================================================
[ 8948.247823] WARNING: possible circular locking dependency detected
[ 8948.248353] 5.17.0-rc1-btrfs-next-111 #1 Not tainted
[ 8948.248786] ------------------------------------------------------
[ 8948.249320] kworker/u16:18/933570 is trying to acquire lock:
[ 8948.249812] ffff9b3de1591690 (sb_internal#2){.+.+}-{0:0}, at: find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.250638]
               but task is already holding lock:
[ 8948.251140] ffff9b3e09c717d8 (&root->delalloc_mutex){+.+.}-{3:3}, at: start_delalloc_inodes+0x78/0x400 [btrfs]
[ 8948.252018]
               which lock already depends on the new lock.

[ 8948.252710]
               the existing dependency chain (in reverse order) is:
[ 8948.253343]
               -> #2 (&root->delalloc_mutex){+.+.}-{3:3}:
[ 8948.253950]        __mutex_lock+0x90/0x900
[ 8948.254354]        start_delalloc_inodes+0x78/0x400 [btrfs]
[ 8948.254859]        btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
[ 8948.255408]        btrfs_commit_transaction+0x32f/0xc00 [btrfs]
[ 8948.255942]        btrfs_mksubvol+0x380/0x570 [btrfs]
[ 8948.256406]        btrfs_mksnapshot+0x81/0xb0 [btrfs]
[ 8948.256870]        __btrfs_ioctl_snap_create+0x17f/0x190 [btrfs]
[ 8948.257413]        btrfs_ioctl_snap_create_v2+0xbb/0x140 [btrfs]
[ 8948.257961]        btrfs_ioctl+0x1196/0x3630 [btrfs]
[ 8948.258418]        __x64_sys_ioctl+0x83/0xb0
[ 8948.258793]        do_syscall_64+0x3b/0xc0
[ 8948.259146]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 8948.259709]
               -> #1 (&fs_info->delalloc_root_mutex){+.+.}-{3:3}:
[ 8948.260330]        __mutex_lock+0x90/0x900
[ 8948.260692]        btrfs_start_delalloc_roots+0x97/0x2a0 [btrfs]
[ 8948.261234]        btrfs_commit_transaction+0x32f/0xc00 [btrfs]
[ 8948.261766]        btrfs_set_free_space_cache_v1_active+0x38/0x60 [btrfs]
[ 8948.262379]        btrfs_start_pre_rw_mount+0x119/0x180 [btrfs]
[ 8948.262909]        open_ctree+0x1511/0x171e [btrfs]
[ 8948.263359]        btrfs_mount_root.cold+0x12/0xde [btrfs]
[ 8948.263863]        legacy_get_tree+0x30/0x50
[ 8948.264242]        vfs_get_tree+0x28/0xc0
[ 8948.264594]        vfs_kern_mount.part.0+0x71/0xb0
[ 8948.265017]        btrfs_mount+0x11d/0x3a0 [btrfs]
[ 8948.265462]        legacy_get_tree+0x30/0x50
[ 8948.265851]        vfs_get_tree+0x28/0xc0
[ 8948.266203]        path_mount+0x2d4/0xbe0
[ 8948.266554]        __x64_sys_mount+0x103/0x140
[ 8948.266940]        do_syscall_64+0x3b/0xc0
[ 8948.267300]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 8948.267790]
               -> #0 (sb_internal#2){.+.+}-{0:0}:
[ 8948.268322]        __lock_acquire+0x12e8/0x2260
[ 8948.268733]        lock_acquire+0xd7/0x310
[ 8948.269092]        start_transaction+0x44c/0x6e0 [btrfs]
[ 8948.269591]        find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.270087]        btrfs_reserve_extent+0x14b/0x280 [btrfs]
[ 8948.270588]        cow_file_range+0x17e/0x490 [btrfs]
[ 8948.271051]        btrfs_run_delalloc_range+0x345/0x7a0 [btrfs]
[ 8948.271586]        writepage_delalloc+0xb5/0x170 [btrfs]
[ 8948.272071]        __extent_writepage+0x156/0x3c0 [btrfs]
[ 8948.272579]        extent_write_cache_pages+0x263/0x460 [btrfs]
[ 8948.273113]        extent_writepages+0x76/0x130 [btrfs]
[ 8948.273573]        do_writepages+0xd2/0x1c0
[ 8948.273942]        filemap_fdatawrite_wbc+0x68/0x90
[ 8948.274371]        start_delalloc_inodes+0x17f/0x400 [btrfs]
[ 8948.274876]        btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
[ 8948.275417]        flush_space+0x1f2/0x630 [btrfs]
[ 8948.275863]        btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
[ 8948.276438]        process_one_work+0x252/0x5a0
[ 8948.276829]        worker_thread+0x55/0x3b0
[ 8948.277189]        kthread+0xf2/0x120
[ 8948.277506]        ret_from_fork+0x22/0x30
[ 8948.277868]
               other info that might help us debug this:

[ 8948.278548] Chain exists of:
                 sb_internal#2 --> &fs_info->delalloc_root_mutex --> &root->delalloc_mutex

[ 8948.279601]  Possible unsafe locking scenario:

[ 8948.280102]        CPU0                    CPU1
[ 8948.280508]        ----                    ----
[ 8948.280915]   lock(&root->delalloc_mutex);
[ 8948.281271]                                lock(&fs_info->delalloc_root_mutex);
[ 8948.281915]                                lock(&root->delalloc_mutex);
[ 8948.282487]   lock(sb_internal#2);
[ 8948.282800]
                *** DEADLOCK ***

[ 8948.283333] 4 locks held by kworker/u16:18/933570:
[ 8948.283750]  #0: ffff9b3dc00a9d48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1d2/0x5a0
[ 8948.284609]  #1: ffffa90349dafe70 ((work_completion)(&fs_info->async_data_reclaim_work)){+.+.}-{0:0}, at: process_one_work+0x1d2/0x5a0
[ 8948.285637]  #2: ffff9b3e14db5040 (&fs_info->delalloc_root_mutex){+.+.}-{3:3}, at: btrfs_start_delalloc_roots+0x97/0x2a0 [btrfs]
[ 8948.286674]  #3: ffff9b3e09c717d8 (&root->delalloc_mutex){+.+.}-{3:3}, at: start_delalloc_inodes+0x78/0x400 [btrfs]
[ 8948.287596]
              stack backtrace:
[ 8948.287975] CPU: 3 PID: 933570 Comm: kworker/u16:18 Not tainted 5.17.0-rc1-btrfs-next-111 #1
[ 8948.288677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[ 8948.289649] Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
[ 8948.290298] Call Trace:
[ 8948.290517]  <TASK>
[ 8948.290700]  dump_stack_lvl+0x59/0x73
[ 8948.291026]  check_noncircular+0xf3/0x110
[ 8948.291375]  ? start_transaction+0x228/0x6e0 [btrfs]
[ 8948.291826]  __lock_acquire+0x12e8/0x2260
[ 8948.292241]  lock_acquire+0xd7/0x310
[ 8948.292714]  ? find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.293241]  ? lock_is_held_type+0xea/0x140
[ 8948.293601]  start_transaction+0x44c/0x6e0 [btrfs]
[ 8948.294055]  ? find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.294518]  find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.294957]  ? _raw_spin_unlock+0x29/0x40
[ 8948.295312]  ? btrfs_get_alloc_profile+0x124/0x290 [btrfs]
[ 8948.295813]  btrfs_reserve_extent+0x14b/0x280 [btrfs]
[ 8948.296270]  cow_file_range+0x17e/0x490 [btrfs]
[ 8948.296691]  btrfs_run_delalloc_range+0x345/0x7a0 [btrfs]
[ 8948.297175]  ? find_lock_delalloc_range+0x247/0x270 [btrfs]
[ 8948.297678]  writepage_delalloc+0xb5/0x170 [btrfs]
[ 8948.298123]  __extent_writepage+0x156/0x3c0 [btrfs]
[ 8948.298570]  extent_write_cache_pages+0x263/0x460 [btrfs]
[ 8948.299061]  extent_writepages+0x76/0x130 [btrfs]
[ 8948.299495]  do_writepages+0xd2/0x1c0
[ 8948.299817]  ? sched_clock_cpu+0xd/0x110
[ 8948.300160]  ? lock_release+0x155/0x4a0
[ 8948.300494]  filemap_fdatawrite_wbc+0x68/0x90
[ 8948.300874]  ? do_raw_spin_unlock+0x4b/0xa0
[ 8948.301243]  start_delalloc_inodes+0x17f/0x400 [btrfs]
[ 8948.301706]  ? lock_release+0x155/0x4a0
[ 8948.302055]  btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
[ 8948.302564]  flush_space+0x1f2/0x630 [btrfs]
[ 8948.302970]  btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
[ 8948.303510]  process_one_work+0x252/0x5a0
[ 8948.303860]  ? process_one_work+0x5a0/0x5a0
[ 8948.304221]  worker_thread+0x55/0x3b0
[ 8948.304543]  ? process_one_work+0x5a0/0x5a0
[ 8948.304904]  kthread+0xf2/0x120
[ 8948.305184]  ? kthread_complete_and_exit+0x20/0x20
[ 8948.305598]  ret_from_fork+0x22/0x30
[ 8948.305921]  </TASK>

It all comes from the fact that btrfs_start_delalloc_roots() takes the
delalloc_root_mutex, in the transaction commit path we are holding a
read lock on one of the superblock's freeze semaphores (via
sb_start_intwrite()), the async reclaim task can also do a call to
btrfs_start_delalloc_roots(), which ends up triggering writeback with
calls to filemap_fdatawrite_wbc(), resulting in extent allocation which
in turn can call btrfs_start_transaction(), which will result in taking
the freeze semaphore via sb_start_intwrite(), forming a nasty dependency
on all those locks which can be taken in different orders by different
code paths.

So just adopt the simple approach of calling try_to_writeback_inodes_sb()
at btrfs_start_delalloc_flush().

Link: https://lore.kernel.org/linux-btrfs/20220130005258.GA7465@cuci.nl/
Link: https://lore.kernel.org/linux-btrfs/43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com/
Link: https://lore.kernel.org/linux-btrfs/6833930a-08d7-6fbc-0141-eb9cdfd6bb4d@gmail.com/
Link: https://lore.kernel.org/linux-btrfs/20190322041731.GF16651@hungrycats.org/
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
[ add more link reports ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/btrfs/transaction.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8878aa7cbdc5..c797563fa9cf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2021,16 +2021,24 @@ static inline int btrfs_start_delalloc_flush(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	/*
-	 * We use writeback_inodes_sb here because if we used
+	 * We use try_to_writeback_inodes_sb() here because if we used
 	 * btrfs_start_delalloc_roots we would deadlock with fs freeze.
 	 * Currently are holding the fs freeze lock, if we do an async flush
 	 * we'll do btrfs_join_transaction() and deadlock because we need to
 	 * wait for the fs freeze lock.  Using the direct flushing we benefit
 	 * from already being in a transaction and our join_transaction doesn't
 	 * have to re-take the fs freeze lock.
+	 *
+	 * Note that try_to_writeback_inodes_sb() will only trigger writeback
+	 * if it can read lock sb->s_umount. It will always be able to lock it,
+	 * except when the filesystem is being unmounted or being frozen, but in
+	 * those cases sync_filesystem() is called, which results in calling
+	 * writeback_inodes_sb() while holding a write lock on sb->s_umount.
+	 * Note that we don't call writeback_inodes_sb() directly, because it
+	 * will emit a warning if sb->s_umount is not locked.
 	 */
 	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT)) {
-		writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
+		try_to_writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
 	} else {
 		struct btrfs_pending_snapshot *pending;
 		struct list_head *head = &trans->transaction->pending_snapshots;
-- 
2.43.0


