Return-Path: <stable+bounces-109380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C5A15204
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494453A39ED
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D13158858;
	Fri, 17 Jan 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="mNxrN5Aa"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2121.outbound.protection.outlook.com [40.107.241.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10470825
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124923; cv=fail; b=pYDrppIyc8Odgej7IdKWUUXsRk5JLWD1HER2ZXiYC1SULTEhmERoR01B8OhWSY9iU+qPGrIK+51pncJk9aLyj007hSw4SIw0EpLvok37qS+S/9phtq1mq7nYuoUu50DbYr9atg+1ljcrCve8vObqO9OqxlJd2vlOYqiKlJU9nXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124923; c=relaxed/simple;
	bh=xaxQOrWlA7CExVEUS5kSSw0ZwwzH6Rjg+ZGHHdTvvL0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QaggXF14sx1neceyOMTjnXrgwo+DX3E4xvGmaciJHiBx7Y/qa0AtoA7qZsZiGTO1U5atnys4D/irntj/KelywQMR+cS3+uc0M1fdIiZG17/9ULdKQ4DUI/xdbTjcN8aPs4bpT7JAb33UPZg6mXUcd/njnnBV/OQYQDf/avO1Wm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=mNxrN5Aa; arc=fail smtp.client-ip=40.107.241.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxYqkA7xGbdft2tKSVCPqzL+B1Rnz0ByG5FCzE8cUHXmfoY8vRd/xKk6WsM7hJV4PEaW0I0hommwAW6CLS6Dd8nwZHHN1uorCMZJg7wbGBuKtLC7xVyW7iG3mo2dTnbAgIM92wMM1Z4DBhpbMip5lasJx6xYvMTtR97p1zqKK4W+m2MsD/Ppt/FF2ew9YBcYLJXBQqZxCz052AvOoQiHLxjfcI3emiX+fQDWWO65PmrfYXUeuPNXY/99wSDlHVyJ9P1hCmiInU8EQDZ0ggHQTblnhkoLdJvC9b8TM14OOS/sv2g/QakITimg5S4vP80B0hcWX++f4hod/eySCfdLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwWe639e2iR2t5YXlLhRIsnH7l4xOPWFYmHw/3hEs7M=;
 b=V+2/neskH793Aa8hxcgEaeUnfMdI4l9mxZ6RmZQ/exGkIbbRP7aYZrgZA3fYgOzEcSdToyczG9Qjx0lTA1UbqB3zyB4Dr7qKvDu813D39i20nr5web3nMZtBH+Ux32+gM3dBwDJi6TksPmA0mcHZEydTK3I4ifscUjrcJesb4a47UwztoXojoqsAMqTPM0lgsTRyyglaBZ7CAS/6QU+VBcUst5zRjRynQ+75zEBMGGO0fcnx3/SgkCNQdwBVATfu1+19lGieFTQENJ7b761LBRJqY9wAc+CwXXTUObuL7PNWNu2rQ5WSkCKb9W5JoVZl4UAQ/Uw/N8AnM0IcCfbOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwWe639e2iR2t5YXlLhRIsnH7l4xOPWFYmHw/3hEs7M=;
 b=mNxrN5Aa4zaqBL07ezpHt1lJlLeQsA5tN8E0WSh1LSMlprnEfn2ZXMnVL8u2MQRiWHCXGaIpgjA7qZnZjyXciNe4seJhRgxdSnfBt98S1ik5lWzmQwnunHO50ebtQOJdhC/b0LnDBIMV99ubanwiYRkCoheY45GCYVQZ0l7yETsFMPjcOcFe8+rYYJK8oNHhuPyME/a1JyV9s5PIKMvU+4mVm3YgpRfq2y8rpdThAnqnbuNlJEvbS6yiWTrmQvsmD9gmUYVRSrDJY0GE0SvIYKNtulS9Mr1kymMHNengRtXCLAlntPI/hYtNwGsXhV3h7mp4/K/IuJSktUX9zILyog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB8P192MB0616.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:16d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 14:41:54 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 14:41:53 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v6.6-v6.1] block: fix uaf for flush rq while iterating tags
Date: Fri, 17 Jan 2025 15:41:36 +0100
Message-ID: <20250117144136.6631-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::7) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB8P192MB0616:EE_
X-MS-Office365-Filtering-Correlation-Id: 9772cb2b-2fcc-4cda-62fb-08dd37051566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXDYKhUC65pxtlxFzGeZ7qIVYXF69tPLwUP9D8SyY7CEjUqE05DuP3NLQXdy?=
 =?us-ascii?Q?kY76tYEXTLDWK7nQ1wuiQQr16MDmHnLJYVbOq49ccHfBfkrYDNpvg3zsVJO9?=
 =?us-ascii?Q?TmNJdl09mfSQ3Kek0OtWaXud1wqdU1h/r5daM0n/5ucLsqO7xafCehKKXSoX?=
 =?us-ascii?Q?T0hSYVaTvUQe+qFhR8ECwaJ0N6b75PBrE5yky/lgLfjTgs7VPtG61hcdZOth?=
 =?us-ascii?Q?m9Z8TMd5F+gdHLwwOLkbnJo+t5tRktvp7+udiGLm6lMFIBIJPxW/mTWnEKI4?=
 =?us-ascii?Q?MXaOMYiJ3Zr/nH8BAUrfrqlRW8klZLdFkymck5DsbX9yjCKrjDxXKc6iuPb5?=
 =?us-ascii?Q?+EiSqJnYExREUnoX0lLEx8/u4WmTphYfVYyVDqq4VjY3um/Yl+Z9ORAqc9Ij?=
 =?us-ascii?Q?rc8NiZn8WtLbMd4Qphqlxj5AjOJo4fpP1UdATP31fC8VETX7CKDdBwbEMTrm?=
 =?us-ascii?Q?tbVlNDGXxE7YPicoidYV64kN+Vd+EOHbIEVBrrrR2wD63t3fF5A/WFaK189A?=
 =?us-ascii?Q?8g+LjY3Zgu4lJPuAM53uzrNqu+DDujI41qUVBkDNadRb4teVcKG3eOp60yqQ?=
 =?us-ascii?Q?loGUty84IOvva9ACsRZZzLjuZLeZd+2SAIuj4EKnu1UMVN8ekpPheWaw1MzX?=
 =?us-ascii?Q?Vzjf+rWmqPhG9XQEHRhVrm1jrtU3pmPtSVAqJRDLDNtShnf5EJ6+6K0fSkQ8?=
 =?us-ascii?Q?EyQNbXqXyIuEngC4sM/57iUEex0BRO3PF7bBhU9t1gY37MGks6zPg2swajnz?=
 =?us-ascii?Q?YlHjyAYwCisf96fA3ZVF6S2rebaguJMZlqERqaeTCe3AbulLbTJUg24GbM2x?=
 =?us-ascii?Q?z55LfJNZ7pQfLy3TxwwiYY7IPyDEGbutq8Se5GMcNjz2ZltzmsSNSSmJFmik?=
 =?us-ascii?Q?7Rv5fA4Zr2C+wfHRjd9MC/ujq2YeJyDlbG8vOuTqEJ6rYqr4KJnroUGjUjs3?=
 =?us-ascii?Q?PtJYuY44PhDBm7tz2OSF9Z1+MakWkaKZIZVqlyaQxSo5um52YvepGF540v9V?=
 =?us-ascii?Q?ru0SzpUlWoKdJbEe+xgHnF5V4EszWtEOeVF4Bf/2vc/M5+Dn0b93sjf5sDH9?=
 =?us-ascii?Q?khQDaPb1TdifuNifBNCHOh5iR4Wvi3F5l/7EISgx4kBX7P29st+ZUHR+kvhy?=
 =?us-ascii?Q?4GeGcANjii3JpyWjNvwMo6jNz5ENjbXC/Z0BMhIQYz82Iq7eT0lvZ1XzbQFJ?=
 =?us-ascii?Q?u7IKA636B6NtqyPDBM6MwFjD+wzcktXierbWGhgSBl7CglMfKu2nzYecker8?=
 =?us-ascii?Q?TzfxoKsffkXRqKYLWk2xEw4pfT4vWILi71qjDN8AJ64h8I2kyCa7YSylRrza?=
 =?us-ascii?Q?pqrdMMe/SJQJ7qYTxysyvcQp9c4dQJtFZdObJCE6Genq/sy/YW66AMaDux8M?=
 =?us-ascii?Q?mHOlrdLBzWd4zCML5WZ5XMUvCzn0peosb08VCcuLa2DBhYyrNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8M5lKFnpO/E4Pzj9BS63HxyablL6KSldlq0FkKfLKy/gViLiM9o38YvkROlE?=
 =?us-ascii?Q?kj9O+hobBMuLk3CbpC9nwIfSMpUH0KYm4ss8OIOTg/UOBnvCx9BagVBw4Ai0?=
 =?us-ascii?Q?8AU5rJ4UftxQDOd6hT2JIXcfJ4PHUwJ5QZ6xmH8Encap+YJ1ww0Fz7jOvbLS?=
 =?us-ascii?Q?x9eoBujsamsDDqwCFUOZsEIriVeVppkRxEm5ltqpz3MC9t2vEKBu9ooybFRY?=
 =?us-ascii?Q?BCDYLr/DiIZZHl07yZM3TjL1fub9A0HxmTTSGuoD9e23PzwwRZ2fSM0PHKdZ?=
 =?us-ascii?Q?KMbIpSTBy71MXSTG0pX1G0O5ReL40zsiNzhMt2l2CGdkz7ygjYAaPwiIeW9/?=
 =?us-ascii?Q?bKcOH5OouR+88PCrF/ToSS8WRNcGy7sqqJpz+7nxgHr7GQAUImyPdcFKnkt5?=
 =?us-ascii?Q?TglcQRz2WC7Q4uRt1LY5l0wm0NkYGsbRux4YGLW2ZxUq9FHU9yzfDfuZghbO?=
 =?us-ascii?Q?Dw2FA1DkIr1uEylP0n4en81vCm1Z3RZrZJX+QoyhqArTXfL67KyFGfsw9oB6?=
 =?us-ascii?Q?5NqWrJRLEpXBYMO83/GODUvOu8wtMRYbqR+D4ENAT1HNyCOR5Bd+qYFg75CO?=
 =?us-ascii?Q?aVnoUPhQTIIL9+J7DIETQX8MIfoOt5P26w1I8WFGqOgVy1nrfWyaK4qUtn5k?=
 =?us-ascii?Q?PA2Zc2ZEN+s7HCbCu4eJLvaTp4sGKYjoLqm5NQ22avb8cnDTdY86mkMwkahg?=
 =?us-ascii?Q?2jYsq8PN+F3Q/MBmiAYs0rrM4mOfIrNUJ432RrYI2KuRuMmJYfaNTjvrPIUy?=
 =?us-ascii?Q?ePIZu+6yQNHC/HgMo1azzN6cyLadfF3bo2ZmOlVSqnTGgrzr64p7oGAHZxOa?=
 =?us-ascii?Q?pS7Gh5sin5YQCQVgZDU/gRPU18mtHUI47l5s8UFG3Rw945CnAuc4RaYtoF/B?=
 =?us-ascii?Q?1jSnXxsF1WEoKVbTWD37l/5MGKgUfs5qsV2t/jJNjec5/PQzUZKBzuuSFZ0X?=
 =?us-ascii?Q?0z/fglvsxmGG/M87B+aqisB/8IaC4sB1GdwzlflErluBZNIMTVj4NEL1wFwk?=
 =?us-ascii?Q?puuDqJDGFNSlVq1POUlX4s8RuOWSwNoH1NfOQekbEjsCYW9JUaz6EmTpY4/a?=
 =?us-ascii?Q?apBAcPO4LMlsMlgS8kAtjeLBre4FtqWgz3eRgP6ddW14ZpnYeU2LCmjBAlEC?=
 =?us-ascii?Q?GZ77ys0foGQ/TU7InOsHWqD75CDbrBoXgCpKorfcW6evFppAbVQGPN5FpR2D?=
 =?us-ascii?Q?rDQqQOpdrXLYJVBTeVn57yVPsRo6tM47ECAgCshX37rV5HpTy/k/W5XDoHkB?=
 =?us-ascii?Q?TfauWz45YNleigmS98V2rMQFuPzjRq9FZUHBJYxpclxi33LbTFKB0ujTccI+?=
 =?us-ascii?Q?X/6jUx7/t3TPYAOy2rDLU40AX3zSbqLJACXGMSgY1GzGlclVhw6Onk3On68o?=
 =?us-ascii?Q?o9C0amcnlo9jCIbGy5fd48YnbC9QN/nCqEFVcBh6CWtPB0TmxZwgHerPdeT3?=
 =?us-ascii?Q?MgqsPD0K1dAN308oNqTzrq+beI8lfOcr4HG7e7OYZLdEFb47oKMV4jigDj4z?=
 =?us-ascii?Q?5e9L1Q7fmyHcAdVK1HBhb+rQ/R1EnEHv2IL935hxlMU9VnJxtcp371TW4+d5?=
 =?us-ascii?Q?YmiJDCghCOWaDyqGNVolhehQdc9ZThDkfkjJil5i?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9772cb2b-2fcc-4cda-62fb-08dd37051566
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:41:53.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwQOZ7WPk3yDAi6mBBPJaP9t8p3XoAX+7YICYc9IW9OgYqRvjEpskjUjJECFG4h15OwWIf9hM0YHP85sLsc/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P192MB0616

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 3802f73bd80766d70f319658f334754164075bc3 ]

blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
atomic mode after del_gendisk"), hence for disk like scsi, following
blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
cause following uaf that is found by our syzkaller for v6.6:

==================================================================
BUG: KASAN: slab-use-after-free in blk_mq_find_and_get_req+0x16e/0x1a0 block/blk-mq-tag.c:261
Read of size 4 at addr ffff88811c969c20 by task kworker/1:2H/224909

CPU: 1 PID: 224909 Comm: kworker/1:2H Not tainted 6.6.0-ga836a5060850 #32
Workqueue: kblockd blk_mq_timeout_work
Call Trace:

__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
print_address_description.constprop.0+0x66/0x300 mm/kasan/report.c:364
print_report+0x3e/0x70 mm/kasan/report.c:475
kasan_report+0xb8/0xf0 mm/kasan/report.c:588
blk_mq_find_and_get_req+0x16e/0x1a0 block/blk-mq-tag.c:261
bt_iter block/blk-mq-tag.c:288 [inline]
__sbitmap_for_each_set include/linux/sbitmap.h:295 [inline]
sbitmap_for_each_set include/linux/sbitmap.h:316 [inline]
bt_for_each+0x455/0x790 block/blk-mq-tag.c:325
blk_mq_queue_tag_busy_iter+0x320/0x740 block/blk-mq-tag.c:534
blk_mq_timeout_work+0x1a3/0x7b0 block/blk-mq.c:1673
process_one_work+0x7c4/0x1450 kernel/workqueue.c:2631
process_scheduled_works kernel/workqueue.c:2704 [inline]
worker_thread+0x804/0xe40 kernel/workqueue.c:2785
kthread+0x346/0x450 kernel/kthread.c:388
ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293

Allocated by task 942:
kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
____kasan_kmalloc mm/kasan/common.c:374 [inline]
__kasan_kmalloc mm/kasan/common.c:383 [inline]
__kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:380
kasan_kmalloc include/linux/kasan.h:198 [inline]
__do_kmalloc_node mm/slab_common.c:1007 [inline]
__kmalloc_node+0x69/0x170 mm/slab_common.c:1014
kmalloc_node include/linux/slab.h:620 [inline]
kzalloc_node include/linux/slab.h:732 [inline]
blk_alloc_flush_queue+0x144/0x2f0 block/blk-flush.c:499
blk_mq_alloc_hctx+0x601/0x940 block/blk-mq.c:3788
blk_mq_alloc_and_init_hctx+0x27f/0x330 block/blk-mq.c:4261
blk_mq_realloc_hw_ctxs+0x488/0x5e0 block/blk-mq.c:4294
blk_mq_init_allocated_queue+0x188/0x860 block/blk-mq.c:4350
blk_mq_init_queue_data block/blk-mq.c:4166 [inline]
blk_mq_init_queue+0x8d/0x100 block/blk-mq.c:4176
scsi_alloc_sdev+0x843/0xd50 drivers/scsi/scsi_scan.c:335
scsi_probe_and_add_lun+0x77c/0xde0 drivers/scsi/scsi_scan.c:1189
__scsi_scan_target+0x1fc/0x5a0 drivers/scsi/scsi_scan.c:1727
scsi_scan_channel drivers/scsi/scsi_scan.c:1815 [inline]
scsi_scan_channel+0x14b/0x1e0 drivers/scsi/scsi_scan.c:1791
scsi_scan_host_selected+0x2fe/0x400 drivers/scsi/scsi_scan.c:1844
scsi_scan+0x3a0/0x3f0 drivers/scsi/scsi_sysfs.c:151
store_scan+0x2a/0x60 drivers/scsi/scsi_sysfs.c:191
dev_attr_store+0x5c/0x90 drivers/base/core.c:2388
sysfs_kf_write+0x11c/0x170 fs/sysfs/file.c:136
kernfs_fop_write_iter+0x3fc/0x610 fs/kernfs/file.c:338
call_write_iter include/linux/fs.h:2083 [inline]
new_sync_write+0x1b4/0x2d0 fs/read_write.c:493
vfs_write+0x76c/0xb00 fs/read_write.c:586
ksys_write+0x127/0x250 fs/read_write.c:639
do_syscall_x64 arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
entry_SYSCALL_64_after_hwframe+0x78/0xe2

Freed by task 244687:
kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
____kasan_slab_free mm/kasan/common.c:236 [inline]
__kasan_slab_free+0x12a/0x1b0 mm/kasan/common.c:244
kasan_slab_free include/linux/kasan.h:164 [inline]
slab_free_hook mm/slub.c:1815 [inline]
slab_free_freelist_hook mm/slub.c:1841 [inline]
slab_free mm/slub.c:3807 [inline]
__kmem_cache_free+0xe4/0x520 mm/slub.c:3820
blk_free_flush_queue+0x40/0x60 block/blk-flush.c:520
blk_mq_hw_sysfs_release+0x4a/0x170 block/blk-mq-sysfs.c:37
kobject_cleanup+0x136/0x410 lib/kobject.c:689
kobject_release lib/kobject.c:720 [inline]
kref_put include/linux/kref.h:65 [inline]
kobject_put+0x119/0x140 lib/kobject.c:737
blk_mq_release+0x24f/0x3f0 block/blk-mq.c:4144
blk_free_queue block/blk-core.c:298 [inline]
blk_put_queue+0xe2/0x180 block/blk-core.c:314
blkg_free_workfn+0x376/0x6e0 block/blk-cgroup.c:144
process_one_work+0x7c4/0x1450 kernel/workqueue.c:2631
process_scheduled_works kernel/workqueue.c:2704 [inline]
worker_thread+0x804/0xe40 kernel/workqueue.c:2785
kthread+0x346/0x450 kernel/kthread.c:388
ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293

Other than blk_mq_clear_flush_rq_mapping(), the flag is only used in
blk_register_queue() from initialization path, hence it's safe not to
clear the flag in del_gendisk. And since QUEUE_FLAG_REGISTERED already
make sure that queue should only be registered once, there is no need
to test the flag as well.

Fixes: 6cfeadbff3f8 ("blk-mq: don't clear flush_rq from tags->rqs[]")
Depends-on: commit aec89dc5d421 ("block: keep q_usage_counter in atomic mode after del_gendisk")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20241104110005.1412161-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 block/blk-sysfs.c | 6 ++----
 block/genhd.c     | 9 +++------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index a82bdec923b2..c74e8273511a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -858,10 +858,8 @@ int blk_register_queue(struct gendisk *disk)
 	 * faster to shut down and is made fully functional here as
 	 * request_queues for non-existent devices never get registered.
 	 */
-	if (!blk_queue_init_done(q)) {
-		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
-		percpu_ref_switch_to_percpu(&q->q_usage_counter);
-	}
+	blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
+	percpu_ref_switch_to_percpu(&q->q_usage_counter);
 
 	return ret;
 
diff --git a/block/genhd.c b/block/genhd.c
index 146ce13b192b..8256e11f85b7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -685,13 +685,10 @@ void del_gendisk(struct gendisk *disk)
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
 	 */
-	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
-		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
+	if (!test_bit(GD_OWNS_QUEUE, &disk->state))
 		__blk_mq_unfreeze_queue(q, true);
-	} else {
-		if (queue_is_mq(q))
-			blk_mq_exit_queue(q);
-	}
+	else if (queue_is_mq(q))
+		blk_mq_exit_queue(q);
 }
 EXPORT_SYMBOL(del_gendisk);
 
-- 
2.43.0


