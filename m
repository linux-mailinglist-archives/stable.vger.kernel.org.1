Return-Path: <stable+bounces-114247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B15A2C2E0
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CFE164065
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736F1E7C02;
	Fri,  7 Feb 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="BskEP0r9"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2121.outbound.protection.outlook.com [40.107.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD01E0DE5
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932015; cv=fail; b=kiqAp9uRWi7FiQOY1Ms3uFVlAgMwKTuo/8gyCCXWPj/nIY7mPqvPcc3B6M5/YxtA0jwqe5x0yaECvVvm1VSSGu+IuvLgqi/2ubqZQu2UGlawJX5bqS+jXvnVPRzfINZ+M4Dmedo6PV+oSY5DqJMw6Lrbal4fs2pgfCqv5oEegJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932015; c=relaxed/simple;
	bh=tXt12gw4tWdEKS4lL4y4b4GWvvDUVA4r6uu2SF0jT4c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H4GsA2WsyQAet+7QDaUwOuCviRBrWIy3NOA2uo49lGxYGU/zweVDckGXD40y/cbsbNTp8c+BBnvdGXHRQ4EYzJA32OkfJSYA5zlQ0kvXbzfBS/AV2gDpfOMWh/HWHeB9YDGUk9kFNejPCAruIliTQkY8SHEXVsotV7t1u6aB5VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=BskEP0r9; arc=fail smtp.client-ip=40.107.20.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLmE3it6/EvAAnO6qTUd/wllH9HapHY3Lvo+8nWNCv+wW/uscfDw0aFThD6ga/Dtb813g063vy+S6EgM6m4GkeZr2s6W8Hbx8Wx6jJMo3mmSjpE4ko8Zf6l1hFk/SEpsx7Tc7SCsY6ZOgUfs8mepL9WGlKLvJlvpPjxkHDQ9hYP8kUmqdUrKW5KeVREfMxG5JI1fOygcj1PHthCv183yzTZQmJoO5I0qDmNWPclMZm/uiSo3hDFZ3Gp77z/OegXfdna3hJTnTjnh9k+djsFL0Q6lzwFpGGA8LR0kmIt5I7c3qwrnrNK/SOFmZDCDvEKeY6khwAHUsl7p7PaIIyUyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH7fJeX/zl5QMeE/2/7reLzAJb4n6ZVNq+kkUvdP7b4=;
 b=Yy+XEvHFp/VHRwZa28txoOo9b71G0xCAHBlQfk9mYD0sRO4QiCtxQsgOJ0Xa9rCi0czGVYGVuu8N2S0n3vXbjhw3mpZgboq+8UvxH9vYOwbGvkDS5b+wWi+XbkT59dZnNExymcXhg5nbiW3xf5xzwk0HKiP6NEEdwysq54+kGo27UPmOf4Wa5y7TD0rXRlXh3XihbiGLbAXvmU7RkphmxHH1SrpFaL/fU/XJbAUbE04OYogVb6YyKWUD3+ssJbBIK6C9HrRikekhGeVyFHMB4i/0gxaCrq5t5h6fjL44CxhgybNRvtdePUn/P5lk3/fEcM2KjSr/Fsp8gw7cRG+wFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH7fJeX/zl5QMeE/2/7reLzAJb4n6ZVNq+kkUvdP7b4=;
 b=BskEP0r9qFi+PkvtDD2x5ZmUtLJEr0VKwvgj1jw76PSQtCig/1pp/WzgUcBO0N0go04md3zxQrYRvvQ4tyfsMOQ63XJ7ACvu6Wov4D9GpiEJ0Gs/N/AfKxih/9V6Tym4feWnFI6el9HYHU73iwACxXh65uKbgdmiFRYpre4TNoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:14a::15)
 by VE1P192MB0624.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:167::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 12:40:06 +0000
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b]) by VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b%5]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 12:40:05 +0000
From: vgiraud.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Victor Giraud <vgiraud.opensource@witekio.com>
Subject: [PATCH 6.1] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Fri,  7 Feb 2025 13:39:26 +0100
Message-Id: <20250207123926.2464363-1-vgiraud.opensource@witekio.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0189.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::16) To VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:800:14a::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1P192MB0765:EE_|VE1P192MB0624:EE_
X-MS-Office365-Filtering-Correlation-Id: 5737d247-28d5-419a-f2f4-08dd47748c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EolL0FAa+aiiKFq/eBCVx6dOqcj3pmL6fSnQTlBzGLR/MCFmrrmUWjwxVxhJ?=
 =?us-ascii?Q?U5eYf+wiL/iMOM60XVC41zci6TuSNPp3sLw3hBwVcRdPjn5Q9Kpo29FpI8yL?=
 =?us-ascii?Q?iWDWnmHY9b4KC84+3KjFHY4M+f6Z43Be4OjLcKXLEAglW4AZawAEyAndsFsh?=
 =?us-ascii?Q?cvsj89Sa3B/AYa/75MN4smu+87aePPp5SLgKxZXg6G+yANnJkgVeJHE8dwgJ?=
 =?us-ascii?Q?T/dRcrP46tzK7oz1UgH6wV1bJrMfNnaA2lr2BTQUFGZoJcNEz3BNGtzxNdQt?=
 =?us-ascii?Q?ja2rsqSYQCYcnwiMuZ4s5YaNByJJsALtScUp+h0o13Qk7tYOJebCDvR1lYkx?=
 =?us-ascii?Q?EkxL8xlkx5lvsp11ec/TOyRImhQAH6r7oqH2q3g1sA/vwAmIO2TkCBuGgkUt?=
 =?us-ascii?Q?YLb3f+U0QXpYMTCPjhH3SvJJwz3ckxvrSNFCSVutLU0d5Zbg/I7P6w1RNXYg?=
 =?us-ascii?Q?0VTBq1HNc8svi7edIesDcB+BINoYwN+BiFBFWp3gUMukE14z/l2sAao6FD3Q?=
 =?us-ascii?Q?3RPAcxYNd8JzgYSavR31rzUUZRasTBQHF/kP0e5SRrzk8x8eS8j6NTh0dyQ+?=
 =?us-ascii?Q?8iAkP3kAZXrvuF2xxu6gDhj/V5xq2eHD7vX9DbVAphRTE3byjqOc4UKAmoVo?=
 =?us-ascii?Q?9xs1uphnKh1NXQLxbpyTjkL4u/fLtfYbtIFytZJv2aHiDw2W/r3Ihumul82C?=
 =?us-ascii?Q?X3NZhRXcubl7E3TRaseIOBbscy43LI47DzQ9qpYvz8u8FV+LxxG4hCKxgF/q?=
 =?us-ascii?Q?p0as1JgUO038pvGKJGcIBNXy7nl+DC3CUE3SW6Of38DKNzI3N33hf2CHqJm1?=
 =?us-ascii?Q?zJ+/I13pjlYgz9kDdQZsO3bXLrYXFIFNaQd2q2Rk1K6dp+dBnIEQrVm/ssff?=
 =?us-ascii?Q?6xLT0cx5yCrTIwxpZcloWiS1+XtISlkuJVwGHB74Aszc9blYSoNVjLvd69qo?=
 =?us-ascii?Q?CWkkRXaHxf/5MVgEPEBg28Mn+vgbIoCStkvsmwYKdIrwKUCHnOGFbx81HU0h?=
 =?us-ascii?Q?HoG27K/hzAv64tP/+Wm+z+fpn+ml6fWjaODeH9DzQsVS8wBaf3YXEy5KlEt0?=
 =?us-ascii?Q?XYqkWvxo+bdQu1LxgzMcOrmarb10LPK/DISiCJFzFPWRobyDc/DDiwG3wPGe?=
 =?us-ascii?Q?sJPeGYCae4oE5JhNQPzA/j9KtLJcUIr9IYrmPRGap+xx3NFGMs6/Oqs6kJq+?=
 =?us-ascii?Q?fMV6rgLte19MNhrBT8jPvw+x5cPasXGEkva3oXTHsDgffad9KzORyvzygOSs?=
 =?us-ascii?Q?nlza0c3YppCNTPy6Oq29LV3FwMWmUdnsV5cMIhsVrLebAPIjUzai9+0b1QZq?=
 =?us-ascii?Q?SgbrYn+1jVAJdxzTj95IEYc02sUKtputzGkbSx6OohDDWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P192MB0765.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1li9rW2p50GP+geCAuvvnXiixRdCwIiAd0MVylk2MsiZk42wQc5fE+CR87vc?=
 =?us-ascii?Q?qe9yVE6konCLxUoxJFdD27AOCDCyga1sE/8mGwoCqmZedEnmN3M44CyAAsO/?=
 =?us-ascii?Q?ZFcrgkq8AXk9Cl/P760hVdkTd7QfnalmvQ2aPNOoQ/TQR3fpRCLASIYisJGS?=
 =?us-ascii?Q?IODc7cc0uQWt0DVaYX/LnynZKiJ8NWmgxkIj90IzDq6URSvjvjTpzGJHYOO6?=
 =?us-ascii?Q?rurWEiarjn4SU4DuHmAhuZg2tZv+wxpasv9fvsFXH5jWLXnA8yKMGFMJ+o9b?=
 =?us-ascii?Q?puQVm8HqeHR+Y/AcTNsGKRVMfa1f/AR62fK37eOGsScR26WsDioo6t/oL/5n?=
 =?us-ascii?Q?t/e33mT/nbd71jmHZag6t1tLj2hnlG2cnXHFsq75oXU9XAqY43ycNa+ILPEm?=
 =?us-ascii?Q?kFXR7INJyZdVqar0nIDEVuiq5Y1PPfj65xFTuyLHU3+l2pAeLxY+jooJKSLH?=
 =?us-ascii?Q?wyhF2Kt1hHV2sIbMw6Sfiznu0UGyctoYxE0eyzJjRMG31XgIK4N9A2+wdUJ8?=
 =?us-ascii?Q?sKWwlxRAJDrRSxezcwuIXRw48N4trokMYD87KnNjNmDKbVd2Zk9gIFTL/1Pg?=
 =?us-ascii?Q?+IkeXk6DF39WLgMg8R48nONcjFmNehRLhkzmlAl3vw3XsNaKJ8+O9T02J9fx?=
 =?us-ascii?Q?nzyttU/vVtK0KxOL42R2tRN9THJCdk6rhpBEYDfL/ogcLLZXI/8kCvG2lp9w?=
 =?us-ascii?Q?RUMCnxAfGdc4Q1VNrYJuwm9V6Qg1xe7X6k7GUtcRO4VrRZ+RKPzOkgbG4+3j?=
 =?us-ascii?Q?wgyRB0vt/ZaVKZSD7qrVmLWvkpBot19D1+5b55Zg0Dc5udatNdXdc4gfKy/d?=
 =?us-ascii?Q?g61RhDarxVQD0w+kgNm0TlCMA7qCCp6Kw+9XqrDcbjLrqH2w2XmUG5wwoZdY?=
 =?us-ascii?Q?+xHjiLXpjveZOp5MggpCk35EYi5geUknEEe1CE5aaLEtWrwf7tvgln7QAOZt?=
 =?us-ascii?Q?KN+Yv07MmZt80qZDkplDmXAvkwpc9DFHN+l8Hi2a8pd5a+wtAATyx7TMmd7e?=
 =?us-ascii?Q?Jnl6l1ZsM7pUuKCUSYuMvVuiK1hVUJs2Ze7i0G8nL91ne9F8GQFQNV+5fDTT?=
 =?us-ascii?Q?mls6t3PcOSBepZFQIvslSB4i+/8rGeEPyfVWCcnqU/6zNVi6GmBsATwJuIKN?=
 =?us-ascii?Q?Ge/VOKtFuue9rI2J3CoETxbUkh0e1eFu5iSQGP0z7Fb31D0VsXmnM2Nnwav3?=
 =?us-ascii?Q?7X+fGj02UMRy4wPrTjwd/1c7hvPivDMEUYzVit/l2Hw63HSRNHp+rGXTBIBa?=
 =?us-ascii?Q?fl+gzAWWK4s8vBW/BO3zSMa9EVZhGBrrjmFzT+D0iQBzJ1ZxozqacOAuadF0?=
 =?us-ascii?Q?1PIseuu5iS0eKj79LL+scc2SF31IRjxAheUuyXqYuUgc45IT/wNKUePiPpiS?=
 =?us-ascii?Q?4tsDB+CUzqRTe3qENcrc+1TcHjWQDWyRmDHIwUjH7jNt3Sf+LEGEsEShZxJ3?=
 =?us-ascii?Q?e1PhELpjJG448+DK/DC7QO9dNfdiq1LZ60fI/HVcXbc6bVvZVP+VuEOyIf+w?=
 =?us-ascii?Q?TxoaMnFI8fbPrNGS5l+Yp0uScubetCqU8Rj2fLK4tQh9mhN8bwFVbN7yTdfD?=
 =?us-ascii?Q?4ZiWD/r56Qc3VwV8rFdivfE3E8u8ItZcRFqtfkW+1lqFjHFKzQVG/ICiHr7v?=
 =?us-ascii?Q?ptkLsXQYTw/DdxvWK0TsBgSG6cpdES/5X+uM9I2Ff5HE?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5737d247-28d5-419a-f2f4-08dd47748c7a
X-MS-Exchange-CrossTenant-AuthSource: VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:40:05.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4JvFQK2bU+KXdjKuo25xmLJApwXnMcByUAHSm2JmwQ5TuWRd0LTrsAVOFcmfnK9xmH3CE2Of0wbd5rbPCYSnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0624

From: Lizhi Xu <lizhi.xu@windriver.com>

commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
---
 fs/ext4/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 53f1deb049ec..ca1d9a36aba2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3547,6 +3547,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 	}
 #endif
 
+	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
+	    !ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Filesystem without casefold feature cannot be "
+			 "mounted with siphash");
+		return 0;
+	}
+
 	if (readonly)
 		return 1;
 
-- 
2.34.1


