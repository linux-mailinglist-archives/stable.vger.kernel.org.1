Return-Path: <stable+bounces-111108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C28A21ABC
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A433E7A062F
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B580C1990C3;
	Wed, 29 Jan 2025 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="r5ugMH2z"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2105.outbound.protection.outlook.com [40.107.241.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047016C854
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145486; cv=fail; b=XscPj+lO4ONXZd4k4t4V7TJD5Ihs4OLaD+PSQYiL36MNHBQCzVyAgz6RlhBobVN5JxzfCd5v8CAquY0qZ+y1F45Lv2VvKIt96wFhln6MQO4v6lMxoJpFQYYdcFi78RrIlS71LFn8XINYNTnNjla4ug9o5e0p6A6Qi9kn7Ddjit4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145486; c=relaxed/simple;
	bh=CIowmttKrPjitG7qCGvj2sFWYum6oBmjWPd/iyDq1pM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PU1xxsJevuDzSxn7PuyIa9uv+9UxpnlhsS0VhxxD5VbKekhZWjoxEzjV/mGdSLDeOF5cxb6rSPVraK86brLaOxtL8M251nHfsP1Jc6DLcbtinOSUaxhiWyOr5B2zuwIh6M1nohMUvLvQJyThrFa6ZYedf2cPpnMnKUeqFFp59Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=r5ugMH2z; arc=fail smtp.client-ip=40.107.241.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pooWXRNDDQZ3c4HS+DgQ/XshWmwqgp0SWSP5SYoEnyVYiNP2GlYmQbGttOELf3OldZ0cAes+gUQ/YnAN5iDlJXVG1gg8oSsXJUAvGkUqmopbDGsKjEqX0iKua0VC5KwXM7+9jnVpHZvnLUQlxCNEFwRdKEgzYXJuPtzbA4bkaHdhUN1XT9pT4a/Cc0sFjqdTKPjOFwEwhS9POypG+FXWFt2iJJVuhhMwjsxooRSQtGoPKlHuV97Dr5hVZrEllgxufkJ7gnFvQMryLRNwpP+20ZweWk1H84YjgGdtNHlK9D0gYN4ZhDcSDhYR02Z+pEjHreFVuAZyJbtOrTI/7CaWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueAUxxw7x4sV5+2vIAVzUBoFppqch9i5zA80WQjxrXo=;
 b=Kr2Mhn+5C3Wn6wVKrGzj0vaNF0B/mTOpYl/zgv3RDxQxKr7nz0SNUsRcP8hClIWdplf7tSn8SQih6dDzTGUuzU8r7xJRUEgnxk3GAj32jObB8EYPevVFYCbAT0xs3iEaKYjxxGVZgruqcKEW0v5Gm3oH3CwApOzHsKI+ArlcmSkze0P2HTcuEKLvQrBgLG5iSnZ3Op1GJBhAN3mXA8gerrL4XFFYkN2YYValIgKVt74Z48f7KfSAzjPp01pgIJLVZfw0ZhMkIN72ZXkkv62sC3eYXsfAV8OKLjtzhWzDCsf+VU0+DzzByK900uy5xBGfRS7TcbEDvhBSqxCkEUWYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueAUxxw7x4sV5+2vIAVzUBoFppqch9i5zA80WQjxrXo=;
 b=r5ugMH2zyJOuoZTHOQ7z5zbrequKrFWdZqNBXeVsC04Guk3ca2hzSPvu5lcjR0Lbdlbe38nytd108yOve2fSnaGokn14yyYRTKE2ejfOixwmrm4NPXJQjNXwTLM3HVhBnc9zv5FlZFdYz9RdkvGZOrFafNW07QvTmoiSJOtGTWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:14a::15)
 by DB9P192MB1708.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 10:11:18 +0000
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b]) by VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 10:11:18 +0000
From: vgiraud.opensource@witekio.com
To: stable@vger.kernel.org
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Bruno VERNAY <bruno.vernay@se.com>,
	Victor Giraud <vgiraud.opensource@witekio.com>
Subject: [PATCH 6.1] ext4: fix access to uninitialised lock in fc replay path
Date: Wed, 29 Jan 2025 11:10:46 +0100
Message-Id: <20250129101046.105471-1-vgiraud.opensource@witekio.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0203.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::18) To VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:800:14a::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1P192MB0765:EE_|DB9P192MB1708:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aef5d2-bb50-4222-f5a0-08dd404d45e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S50BZN3dAK+OGVle1sLfnwNUmzT+YRGc8x7ob+4I2AugsWT1TSK4bkmK4caF?=
 =?us-ascii?Q?fjogVXrGMEj2TF8eg8GcMwYk7tRt51qTxHcDUAEu2LqylX0/l/kmGkbbMbuG?=
 =?us-ascii?Q?68ZEuIv9pMQCsAS4zfNHxULhmHLcsJjeSpCwmtVYDczVp+EW1mL0s0hJLF0R?=
 =?us-ascii?Q?ep0pz+2oxO82sWIyHcaYQneUOh72CYq8NCfxmbOECbo5hFPedLWtWFYKkCRj?=
 =?us-ascii?Q?J8Fs9+ifGVGbh3vnkBvsnTMdlvbS2cHiVY5pe/UOwx0dSdrXi3lpIpaqDmb+?=
 =?us-ascii?Q?38iRb8VUxqQMJ9zvXuRbRwZMAmKgCPoUvCeb4dvQIJwYI/twHQ9hvI4493m0?=
 =?us-ascii?Q?B8pRp2h90MsQ4PqknVdYvUqTdHJh6nbxVcWh5GzQn2nPSpJKhDsRx4h+CxzU?=
 =?us-ascii?Q?+SpEv5n2Dbf75AFG9RMe1S5cNRUC2prLUjmKEJgk32xZHD3MXOfqN9j5c4lX?=
 =?us-ascii?Q?0rYEKDG7e5yh7zo7PyGvspdbGcF2JycPjDqgORlMJl8yb9kvwZ0jwF7SaBev?=
 =?us-ascii?Q?VjtaquVg+96+oFvRKdBFo6mSh1S8IVFJsz8fT8TWO7NeGf17qfaqZhZCd8y1?=
 =?us-ascii?Q?b1Ahgby8/tAOSzxEWxzlAzZBUSqJn8escGF4/26DfAtKRy2me3ke+0X/CgjI?=
 =?us-ascii?Q?cG0nOQwCz3jqC6ey+GLAsFJbQz6gjQvnt60pDrybIMjX6nnbGdI7r90v73l8?=
 =?us-ascii?Q?8mw2QWB693Pv6dnqxzBPz6MfhHXoGtWCYc9QTJk1ltojq6eN2keNsO+ddr72?=
 =?us-ascii?Q?0tkg03DDJKf5o33jNbiYT3BuUmKy8OBuwOiFOfIlymgqtXw2docGVxeEEKnR?=
 =?us-ascii?Q?+z7rhe9A3eThAKh1FtRz34+ZVgj15mlCwhflEdp4jIoKojf3oEsuSBrT5SKr?=
 =?us-ascii?Q?wQ7BFFW7f6k8GZRsstOyWQu1G9jgtkM1OmtdbRbBimHM+fCP/9sdxwWybYEw?=
 =?us-ascii?Q?PD21PNo6bi5GtkDPrPe3bFmA6GgbTTj/Ez8kPEf30z+Vxf+83hRVlkdMaiWJ?=
 =?us-ascii?Q?X6VZeOwlR19LSIQC4s2n2TUuQYjwwHUEjSLAtNB9gUOfzCoQyCAzvi6+qqAE?=
 =?us-ascii?Q?Aez1O/ugViTZAsDm8nuDk7ea/VUonkS/bvFoFw4qVlGLq4OI1oNlMHSkSve0?=
 =?us-ascii?Q?fRnMmM9RYIHIcrj74+wsfmonRg4IKGppu7nY+QXLlMrP7k2LFuk9YSpmKGKm?=
 =?us-ascii?Q?Ux5IyXrZBDKwZ3r2RZxTQpUB7ZSbQnGDbrxNBZaxzc3VkNoASbz7jkadYS6d?=
 =?us-ascii?Q?W6CJ4ch5IIEGLhVILLR/5rGxn4eQBYJD+E7J/nohwGJFeThUI31pIHl2Fnp9?=
 =?us-ascii?Q?QJ/4Gxpjq3zwOVu4RRAl8LKyQoFJUZ0orxh2oronmNkkPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P192MB0765.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ooHpwqUg4eY0VxHWtoMYNJg8AFrzJZaTbItgrbz6l14xTDrNoWFrCF+9RQLa?=
 =?us-ascii?Q?O7/cNmAM1oEprp2F2HWw3503+7mwpqzQfrnai7cRJFfnVOayiPBkdHDvbuYz?=
 =?us-ascii?Q?VI5Qawe1RSZsRBYDvUMVChAAx/g2sLwtlxoAkwbWyfuAPvJ1YRGrERa5diY3?=
 =?us-ascii?Q?h/K+X3vPAFbu5oWBaJa5st2GKlUcG8XSUxlz/2Mai3r51rF0tI8DYqY46B/A?=
 =?us-ascii?Q?oNvvvEOPCdFaki0fklZA+ehTnKCcotlKkDiCS6tAEXisXiCjK0YE8j2AlAzZ?=
 =?us-ascii?Q?wxd4vLyTJmnrdnH6jFNIAHmX3Fw833GvyLNnaF7DBWMEy+RM9nt2wJU4b/Am?=
 =?us-ascii?Q?p7Ep0Sx/I4wnEH6iqyJv1sRkuBDs0Y7TxrFzRwLtClsAP8/7S6ffW585dxC+?=
 =?us-ascii?Q?azAAODWk7c5F6ev4YXedoIJFEVfpa3cf4Q1TsXCJ+g+/Pa5kzlG36ElxIyrm?=
 =?us-ascii?Q?cEt0dvtwoTyu8NZ8zOxThDBDT1CxCN4pLyd5K5CFcah4umpOIfl2bpFYCzHB?=
 =?us-ascii?Q?PwqsZRB74v1bCMEDmtnlEBN7/kq7WFn5TH5Cvhdf9zTkF0xGyyVKmgMS+iCA?=
 =?us-ascii?Q?5+VCf4Ung5+fYxIdTaiB6gHh7YPK8i1r+5IgxMUbowMpg6FyWZsDieBhCNwM?=
 =?us-ascii?Q?EA0pXL0tJ/AcCcWfzaPySk14ry985XI9JvX84vAJ81tLLhWd4SIph0rkUwTI?=
 =?us-ascii?Q?18Rl0AfGtzFSdeUEUaTKoWo7ivVE/sKdHdt/D0HPJB7ysgWtxMd++5rOyftz?=
 =?us-ascii?Q?C6k9Afet7u8L+m75T+0a7ka5URBvZdwk+uZOF3YjO5Rq4zOz3Fjo1o9PoS2r?=
 =?us-ascii?Q?QXwwmLDNkLFlZQab/xfhh+3uvq74FQTLvAGSj7/0SCTbvmdCPK4s4WZj6ZMj?=
 =?us-ascii?Q?fup8+ghxlPMTYuN4Zwg7g5VRYUwmtvvVxvYfGS8n4LR43Tu9ytqZKs3S9lRw?=
 =?us-ascii?Q?VUjCUtQFytTHU6MNfx1cGtpDQc3CeRHWVOFWQjQXDPwKclxOQpy5ILB2cdEJ?=
 =?us-ascii?Q?Vo7CnJ1LnQnGGOVtN8wSXjksMZ8DD5xw5cONaeiJtrNT53UUJDldvhtmSMMK?=
 =?us-ascii?Q?Fisu2zD9zdmL4JHRmKA296n99I4mtwD0O7UHYvNzkJNmGcxN9rFBCynfKoJG?=
 =?us-ascii?Q?Uti4J84/BTBY5KVFw61mpImeapCl/ywKZ7Sh6/OptWC7eWfNlbY1ur0aiFNZ?=
 =?us-ascii?Q?KHA7WBhU2O1LctymJpnTP3CI6M/hUPSHDsVKcDVtT7KgOaOMYcVR7iNYT/NK?=
 =?us-ascii?Q?8NstfR5+1+6qkHSCHpnDnmj//7ecYvxdXOOduOo+NCs/pF965PclNPN4EsI8?=
 =?us-ascii?Q?q5qAvfNGnLEwmRnYi5FMO0FdAJ54i0JgbwgeDayGO+QQGX54F06biE2L2K4d?=
 =?us-ascii?Q?DBgF3iSKTZazegEktycqtNVehbR53VmCspLIOPbBC+NHrYFHcRjTK/R8uT1m?=
 =?us-ascii?Q?Bot0y4ewCKLdztKilDSm9sGX6KQuMGmeYc8h3C+rOKG2TUQhgj2iQvXYXlH8?=
 =?us-ascii?Q?3H4l5lV32R0G+MpBOktwsFKACcQ65RVrz00ny5uGXYi95xj5Bjwe0ZFNxu70?=
 =?us-ascii?Q?EAqg/qShUN1/T6BVvouFkz2S3rme+rHmsnUCtd8oQsUgR1xedAqnCDtOr9+3?=
 =?us-ascii?Q?1vlqBD3PixPnP3j7M409h+IpyiVKxSD4UPSX+F7YMQLn?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aef5d2-bb50-4222-f5a0-08dd404d45e4
X-MS-Exchange-CrossTenant-AuthSource: VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:11:18.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPWKCfz0fAhAlbXBRBrIC3QvIpSdvAQAQyZAgtDzWClf+JUSWcS8xNIsBI+dicLjndVNwS4kE7B2VPBKWiotCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1708

From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>

commit 23dfdb56581ad92a9967bcd720c8c23356af74c1 upstream.

The following kernel trace can be triggered with fstest generic/629 when
executed against a filesystem with fast-commit feature enabled:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 866 Comm: mount Not tainted 6.10.0+ #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0x90
 register_lock_class+0x759/0x7d0
 __lock_acquire+0x85/0x2630
 ? __find_get_block+0xb4/0x380
 lock_acquire+0xd1/0x2d0
 ? __ext4_journal_get_write_access+0xd5/0x160
 _raw_spin_lock+0x33/0x40
 ? __ext4_journal_get_write_access+0xd5/0x160
 __ext4_journal_get_write_access+0xd5/0x160
 ext4_reserve_inode_write+0x61/0xb0
 __ext4_mark_inode_dirty+0x79/0x270
 ? ext4_ext_replay_set_iblocks+0x2f8/0x450
 ext4_ext_replay_set_iblocks+0x330/0x450
 ext4_fc_replay+0x14c8/0x1540
 ? jread+0x88/0x2e0
 ? rcu_is_watching+0x11/0x40
 do_one_pass+0x447/0xd00
 jbd2_journal_recover+0x139/0x1b0
 jbd2_journal_load+0x96/0x390
 ext4_load_and_init_journal+0x253/0xd40
 ext4_fill_super+0x2cc6/0x3180
...

In the replay path there's an attempt to lock sbi->s_bdev_wb_lock in
function ext4_check_bdev_write_error().  Unfortunately, at this point this
spinlock has not been initialized yet.  Moving it's initialization to an
earlier point in __ext4_fill_super() fixes this splat.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
Link: https://patch.msgid.link/20240718094356.7863-1-luis.henriques@linux.dev
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0b2591c07166..53f1deb049ec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5264,6 +5264,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	spin_lock_init(&sbi->s_bdev_wb_lock);
+
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
@@ -5514,7 +5516,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * Save the original bdev mapping's wb_err value which could be
 	 * used to detect the metadata async write error.
 	 */
-	spin_lock_init(&sbi->s_bdev_wb_lock);
 	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	sb->s_bdev->bd_super = sb;
-- 
2.34.1


