Return-Path: <stable+bounces-81564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571079945FB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12214285E85
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0618A94E;
	Tue,  8 Oct 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="eroh2h1N"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2117.outbound.protection.outlook.com [40.107.241.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5C3C0C
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385380; cv=fail; b=mM9wUzOp1Ge58+/5bh/hGGs0UnWrd3JqFJvMZGB0m25G92phEnr/cSA7IbsqKJH4Np/1LTLmjUjPbWjiY032ylP5rPFW2327NlA+yv39sLxlyt0RXzfLFAmKt3P9lh6VB834l9Q5TptVzJ7BuyLMYDCeqemJ2NXpOX67aoGvsrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385380; c=relaxed/simple;
	bh=2p4Xj55bEi+MeWHhYbGfb6nBrSI71Fsu+1M+2ueR4Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YQwTIUtWHVtaR5PSW+bb+eZwx/fo5Cb9n2yozfLWfN2012JWC0SQvrsqpY4/M9bEuWIKwKDyghaqaCC6VM9quDY3yTpMq5T6lKRBVlLC9aqj2aVW1oWU5vX+GpsoK5If73iuNSwuycIx4FuGu0Sb2L9wVlKBA5AbFPcem/Q1btk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=eroh2h1N; arc=fail smtp.client-ip=40.107.241.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2oRXjs1pjEArc8nK+P6ksT4qU433iTPSOwscjJEZJsFQrNe7rpvl7S+tRrN7VIRWoKaTZoOuQKasmgJ+2IDQpeUV0eHL9EOGtrH5ZUfeiACnh4QaBg7k5IrJ2yeMntKZrkpxScreYqBqmTIwYdQk1Z2WadJKIAK4SYBWyGAvXMg/EiMeDrGlBAQWyQK8Iv36vPqunyhmwN1cM9A0C3+aCDT9eGBueOZC+eKj1eAIOMOL0BB/aYjA8Uq8sc/m9s07omyvC6RJmSQqr5x5ccjxK6llWd0j3DhutUIqGvsAsrn7iHwoob0TiTJsCRoEJXjWm1UqAeVoT0PV6GvimLL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJSsEd+xfZmcBTZ4nD4jqMFxZawTNFrA5tKr+X31Kls=;
 b=RCXM59PXC+s6rtNJx7QL6vOcJCWQ00fzKTC0VLebqj+qr2TGn3m6a05OSxBGkL+bLSC824O6o/yH3RU4/3cYqrAwhlokR/Up8z1c+F8t0Q9tZIoQ8K4HxDZZZW+Io32Vi8Xp0iApIKFlJaTedEnNmavIx5kwYBs/PHZhgj8Js2j900rgjvPrvEtDUljyK/S6xhHGt8vxDekY3OlXMY2X0jrdGKFQqVbGYHVXKD1khtVm5vS8A6CRzuFV1fU+kJrgD/9jvOifygZOmIbBQ3RjviKzM0vG8K2k3qYA+GRSlQ4ojSzW/Ge1ZJJUuxJcn8F4PnzZrfLVHdhEHb9PR7PuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJSsEd+xfZmcBTZ4nD4jqMFxZawTNFrA5tKr+X31Kls=;
 b=eroh2h1NSPju8wvfQ/IBgADDE5MiwgJ1oRLJPZ5kV3Byu6j6F6cZxu9Qadjx9JghW7P5FdDc9xeDn77xkdtDffR8q40WRMStwwBehf2NDHw93nVrbev844GkXJSnxaNp2SEo9wjrbqA7NgbiFGKXn/goNYq4rtnz3NkSIR5OSzMikeX6xfAVWYpMuK07eqDcSF+Sf3dNIhGziGw3MMuB+iEMp53omD1nkbRO+pq/YHymYUaIqNPADn26j5Km6IUf5diS2U/+BrEooIjb5vyc+bfnvLhHP6q5dTXPvGwBfQWFSSt5l+DXTP82zOzxfNSglApPRHDZWPV0HTTwbZ4QCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by PAWP192MB2177.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:35c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 11:02:48 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 11:02:48 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Omar Sandoval <osandov@fb.com>,
	David Sterba <dsterba@suse.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19] btrfs: get rid of warning on transaction commit when using flushoncommit
Date: Tue,  8 Oct 2024 13:02:32 +0200
Message-ID: <20241008110232.152682-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::19) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|PAWP192MB2177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a22e7f5-b601-4cc4-941d-08dce788bef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f4moZozwq/kr+dTkpAWoptOIadI0bXF0rBQN9B0NcWw+sBiOHWRGSDIbPq0X?=
 =?us-ascii?Q?hTi3iBhJFp4BYICs5HteIHuiqIMiN95UEQrxvPsW8/PTkAdUJN3GFfaxZtaz?=
 =?us-ascii?Q?DeUe91CuCewm5YGZdBwk43mPrQDUjtMn8CpBvj/wN26bkPrM6q7jSdwJ0+nr?=
 =?us-ascii?Q?kZwDjW+UKjlYyUH1hMQLM7Dz2t38v7ktPxtUYjmC4poD3yqCZKeRnKYoO5WJ?=
 =?us-ascii?Q?2NBEaXXxQj4xoHZHFW3OvR58U5EVo6FTtyMtArg9aG0z+5EoHtvB6WEleoPp?=
 =?us-ascii?Q?n8Oo7pkNC3vTx0Tt+CN/HwyO/U1A529rjLrDOzDdsMh4O12X1c+MUboLRMUo?=
 =?us-ascii?Q?zKSnf1Tn7XxIpjeDmy08ndIR8T7Tz+NAM2HPmG3Gx9jeKhBJoGpFZ8O2qzA3?=
 =?us-ascii?Q?RnpJuuYEd0nDvyUygtL6xwFYzBLcZKaDliC2UJtRotMVfetc6oCaM78KxiO6?=
 =?us-ascii?Q?zc4y4y4RyHsmcXZc6YbP4oTQkw5hXR6cJAo89BdGiSZBoAVVbsyHOyqm4kH/?=
 =?us-ascii?Q?Qhbv/rP6BR1uV5uDzW0Tj2ayjq6iNDrPo+4WZ2vZ2f/urYSsFnCPAsw7f/7i?=
 =?us-ascii?Q?tw53v7KuajbDCIyPz+IWAouuBPhdauAxUtDmh+3iLYBIUe+FhNImpZiwUMAW?=
 =?us-ascii?Q?s0MOm5L+Q7UToAWgFydxG6xOgbtCb14C4T3PiQ6jW0GBrEdfNYCghxEGfiP/?=
 =?us-ascii?Q?GBdbx6vuxJiDq6yA1kXap38KDbQMKk8Yf/6SfzBZcdr+ldEihLxj8HIew29W?=
 =?us-ascii?Q?uSmcqS4ziwHxiYc1KpdDJZt2aV/++cR0sVE0rvMCP6+PlmMvsYYMUk6isV0U?=
 =?us-ascii?Q?B8+aZTtdxKwFY8IpEpl0R8o9Mrg3ox5FbdV2ycmI+7ZVhr9b9+L2aBeJkj0B?=
 =?us-ascii?Q?7oavnul7TD5HUGKF87l/V1CuBbo63rG8hKBZ8JP4e/Ft/+QQ5m5O2jLZWpms?=
 =?us-ascii?Q?4qa6jx1h34+mbJIg7U06fPY+YwnGcYYt1Eo8FSbgB4Q/x9Od4ZzJpmYrkETV?=
 =?us-ascii?Q?8nl6j8Jgp+7nk8hzE2U50+yF8ekP5blj4Xo8UhtiFatWmXk9hqMsl5VdLNo7?=
 =?us-ascii?Q?1HbWR2qc7ByTIXUnnniKUnOx6Z5nRYPsXyF9doe9w5wq0kCidSFXeehKOkJF?=
 =?us-ascii?Q?np7RHae+IB3J29z44wtOnj8gwSkCoPgctSJHPGiNLAl/oPy9xKE8U9/cgs/0?=
 =?us-ascii?Q?BLGc0BYv22vdKUfJvYGsetdEjl7OY6wI+tCds6tBvnyLxF30l21/69vLX6in?=
 =?us-ascii?Q?heEKenYwaxy7KHtjdUht7GqjYTxMsfdfKfqBibVTIMuZPmnpP8p4LB/BeiAW?=
 =?us-ascii?Q?+OQy5UwicLKEGeiBq8jAc+5m9pq6S2+GZKOkr1JA2Pe/5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tIVl/7D/TjmwkfU8uuL8tt48S8E038Dw5Ru/yS+q1rwbuPY4Iu4yavbpJF28?=
 =?us-ascii?Q?g8KGRtHsqdo0sFMbltUTR1FKQJ64ZmSaeSjNndBUwvPfqObetWX348QR+J82?=
 =?us-ascii?Q?SQ9jIaqGHtVlRAyoNIfZ51Zst/iZQexHdkEjNLsLOpTXTxBCToiCjFCoy9vY?=
 =?us-ascii?Q?zsixPD6Pj4VVKURnjtUw6PGN9XdBF3tWj3w6OdXnVco1ChXo5p/e/fjI3n72?=
 =?us-ascii?Q?AwsUpfUgDbnCuL9qS1O5WxxkXerlcULet1iovfPR/H9dET+xLRDJ9DbdgDAN?=
 =?us-ascii?Q?jwP+4TapeypZ4ypTfNjj8K+RE8HeNqBqBTftUN2p41ddWpQYZmmOCPMU3KKA?=
 =?us-ascii?Q?BOjOi3uMqT988/7JQIsZ4tz7N1ak6y3csPlZ8XIafAZLIWQZ0LpYf7Vebcuo?=
 =?us-ascii?Q?eC9foAIfFIRSBfztUcIaPE4+PGFbf92Yi3hWkEPCBcnwNorg6R4v09stBXFo?=
 =?us-ascii?Q?QKfjZXXUdcpREwLWKvjDY14weftM52xhN7MfXrAfFq3eq0FuQU2Aiu4s9ofA?=
 =?us-ascii?Q?vw15oFgp3aL4XLahFn1j5jPB6ZfaHEhjYIE6umGpY44BZrRuXEP00CLhGngB?=
 =?us-ascii?Q?ffoLxIt+1N8jaPd9sosDQQdJ7r2Pmx+NQU/y8/4pgiosnh7Sc0eIABcOahCx?=
 =?us-ascii?Q?seH9puFLCSjFzQFHjwxbTbbJ/BvqZYFJ4hP2Hu4cB/513hTkUkDro4O2rdCF?=
 =?us-ascii?Q?CmIX5iNZ9ZUKICvorFnjM0V9NdEahF83CHOUqKtRfnj3XBw3lwa3FaqlWbbb?=
 =?us-ascii?Q?XnI7xeBAESCTxCnYXGSkAcWhJjwxufm+9QicM/HhNMJRGc79f9uaZbTkD6vC?=
 =?us-ascii?Q?OYYZryVkTl06FbDAJWGpbRB4lh7bWUiA63vVHPQmOYLMFBM/jYM4jz3Z250S?=
 =?us-ascii?Q?lwyG37tVI6ohFHPU0UxLY7ptNZhJTx9AegZ74My2he732C8FeE1i/6Vhwv0s?=
 =?us-ascii?Q?wH8P88kSL4Tc8KZExrm9akAt2Gm+5m1c9ZguiZxqryyKhnfS60Y76jdXu+TZ?=
 =?us-ascii?Q?A4GopVHtYIYLxpNLpcMSJ84gN9B4e4vGaFWJ9AN3srhHdImjaOW+aDWpP6AS?=
 =?us-ascii?Q?tkPFW4+cr7lxpYoftp51SYuWySC8uRdv98yY7tm7tZJhhmJ21+/4xBQ1Bu0Z?=
 =?us-ascii?Q?hTyw/ekqOmMh0WdoAGKwO+ajZ0aQ3OG0k4wwrvwXKBZafc8qrtR66ROyxoMH?=
 =?us-ascii?Q?dDqyxKeCsYs7nUSPiIrdbH4MM/G6jaXjso9MacWPMyJWIAdt9bbVeZF57lDN?=
 =?us-ascii?Q?DQDOdWQrdi39JxTDsexuIZlFr07D6i15A3JbmbzCTBc263B3e5vL/Ra9O2JW?=
 =?us-ascii?Q?cIZQyJxB9mm50Azeuz7IEcWQ7rANkOsyyTEhtNYDOIXjKmr2pqldxt3Ses3J?=
 =?us-ascii?Q?VNRDUIXxVaR3R0HA9jWED+HViExfSXeRdyFGLAkT+WDn0auO6arGnHeHW9rx?=
 =?us-ascii?Q?NF+V0nBSd+IdSU2a0LxSBWwCYv2A9oaG94mD9+Bu26rp/ez4JQImOW48xsZS?=
 =?us-ascii?Q?xdmjCzr8wObvolI7jSCCsSm3lO7zUq6q2jm/Y9SdMvjvHRFcLZhywm10FYqK?=
 =?us-ascii?Q?ZIqhgHHOLyeGnstGz7k0nUf1n003FJmtwVWvN5u6p8+DnEZcNqkcBUZn+8Ht?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a22e7f5-b601-4cc4-941d-08dce788bef2
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 11:02:48.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJDt18qUXQTSXd+OG+XGJzzKYJb7D/LfwGoWBrCmtEAmdQABTBj89iZTRdklYtchANiTW8cjyqIBPpp6tdHsYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP192MB2177

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
index df9b209bf1b2..a844e3b2bc2e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1921,16 +1921,24 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 static inline int btrfs_start_delalloc_flush(struct btrfs_fs_info *fs_info)
 {
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
 	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT))
-		writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
+		try_to_writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
 	return 0;
 }
 
-- 
2.43.0


