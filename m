Return-Path: <stable+bounces-55751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB6916617
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316FDB21D92
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909A14A4FF;
	Tue, 25 Jun 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="asv0GNAA"
X-Original-To: stable@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2057.outbound.protection.outlook.com [40.92.98.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF31494A0;
	Tue, 25 Jun 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314517; cv=fail; b=ETF/FPM5v9Jkzr+uh1uACKq5Nkg2ZGpt6RkMmrfZDm4dfmf5Y/DTmsreIueKPO8+yRQexIQQ8RrTrFOXDRL14nyJ6rKKqCO3f5DuFYcuKIKWzpKSwCPQgp1Low9qR+wzhT6m+0Y/X4x8Cv2cdnpfXTtm0eMtmwdo+Qfoyushx0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314517; c=relaxed/simple;
	bh=aM7UI+WT+AsAKgZQH5TViz8gwcPnFMGxZUbJgUoRPTI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KiGav11jDd62L2DvR5Wj3ifZbXlfcmigOMTSgoHiKnZxeCf8cGbdd3jWmt9s3/NjZpifw/XtfFrkvIkQJ2ieiAJkcrW9PB/k89z15T6xB4O7mJO9ShNS1HJsKEMEZto1j6J1vArEV0gIutn9kgoCCE7tGNsCk4B8WdflxtTHBHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=asv0GNAA; arc=fail smtp.client-ip=40.92.98.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDaPliKFP/lLZ1rmVyRlyCgVzQry0/G3lUZDdBchRav7eA3yFwopLZOqbf8fy0XJIrskfCJSmFyflmu/qxaMEYX7McG5oV84cyNInO4sBaeFyZKPa1p+fcBNr9FI126amDERu+4iANZ6+rF+wNlm8bJZkWKQ+w3g69bICHPlAe3118o511OWpU466sD0+Cd4XhSYLwPgMwBjEVJPfv81bDeMCp3YdL11Miib7Wzd1bi9iFTBaEWKQYWG3OM1wIbHpUfRY0SRqvsjAIR3DrHZPn4vr4yA4tk82sLXQFQpRutIYRjBfZPKZUhSeUCpMPewhOJqNaSv7GoZO840DUZJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1ulyIAQjzyUfG07pp/g/SI68AT+Kj5KdaZF30N67Lc=;
 b=UfFQj2WElQ/NE9jKJWrsVySXPYCv3eJwLiWuL7U4jY2er1kW+OiW7Qd4NtKabzjwL4aEwt75AniM65jvvsU9wB3mwAktIfv1Jc3M16qK1x4DJeb2TTMtYJkkygeZRhpcLKj9U0i+rFswPgd/g6dXm1ys5JMS9mJvBCLV/8gj9BSIBIugrExkH4jbWjH/n0orCBbpWNQjet6gksfgcyU/hnD2s4OSxBd7xB7FU4BCOmEym6DIXet7rRDGChx9HnkuAFqQFGfCD7vYb1dFpZZM0v16HacX6wjtWfh1R3kyaTpRIz/osfPDHXNwGu4RVR0ONZMzqhK51U1AzwbNwkyXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1ulyIAQjzyUfG07pp/g/SI68AT+Kj5KdaZF30N67Lc=;
 b=asv0GNAAca9zJwgKNCUjKKv9dD5yZuu+Zwxdh3txYWmz6/EOA+8NsKSE4cxDqQ+QArKbBwJ715c9jjBJWk0mJtjb2If3C2qxatwSMn1MP4hIGSTmXnjoK7mMWfKuTkSXXIGXz1OGo5GD+cMqq/HEuP53sT3LB77JQoIQUrFjLwXyXMiV5C1u0TFq4QkG/c2xuZSTnMEZZLc4ITeSRRm1/O5aeDFwF3jvlzMR042LHsp9hB5CHcZv8O/YYwuv7lDyRG7dZJT5tV5qdOCM9MF4sT7joDkZ/LFGOzNMMuUiu02BlClKO+ghxGyRNZBXKGDvvPx7HinZLox9JGcNfSVSFw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OS3P286MB1993.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 11:21:51 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 11:21:51 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	pablo@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	stable@vger.kernel.org,
	Elad Yifee <eladwf@gmail.com>
Subject: [PATCH v2] net: ethernet: mtk_ppe: Change PPE entries number to 16K
Date: Tue, 25 Jun 2024 19:16:54 +0800
Message-ID:
 <TY3P286MB2611AD036755E0BC411847FC98D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [lxrnpwbeAuex1Dm+o65ak7TD4ZWIGOB4]
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240625111654.4306-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB1993:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9e283d-ee68-44e1-08af-08dc950902db
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|1710799023;
X-Microsoft-Antispam-Message-Info:
	7T055KlO/VoMc8nOs22FLgs27phHAYdmxwg1V9+JeWyI6yoPzKibvFmBMud4SdEzmfnQlkWI1hy5kyW1A9apoNzKVOB/n1HI3vZJEUlNfRlQVJp0z+RochCKDTma/BWt5RwEtTenwkGYUeVDw8x39vbefazBH6ZcLWbG579llFsxHUq/1WQKsdhKl/zfhjZtgyTthcRMM0BBTns/lJrq+wouA4XYWFdwtjXUNUSVMDsBYyK8cFzxVAAGAgbi64OgnfWD8GNMk3ZIsIrbvR8PVYFW+TsOnspMWg0yfSZfuhnUQs6tiu4jtJWIFWvP9JlKXM26MXmMNOww6Qq13RMlgxfTuyDdte1p4kMimfW+n2CbOcck6JX/i+bQRsIyqFZqIkDmPS+HKH2F/1eILMnEeQX8rErunY2r/dE2ZA0cFO6JIQLKnygQ0VGZG1vYm0AR2acj6isuy7senYyBuNmXnUX2B1g7gl03sOQ6Q4T4WSB2ftT4esoYtmkmIR5YEk1leZaRmpqZDNjx0PLoemVFB56IDVBHL9lFdPmxhTZOZOqhLalTcmaxkDmWRQufmg0tFz4f8PRWKYt3kDjlid8ZAcHWvHRNKW+jFRM9CJh9mG4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XSBUCZx2EOAF/AasD3CKXWqhXaLnnZuUcLaBM7oS3bkx2JNrJwbTVqD3Y4v0?=
 =?us-ascii?Q?PLfLuVcOyvq0nbpX0PrqxOvK62DDnw3gdz9U43bzWH4V2uq0tCWfA3sL4Eqr?=
 =?us-ascii?Q?pKw0QlFvqz/YLQNka1tqjolDYweU9Od8tWc20h68l8mHC1mhpZuDSfW2UFev?=
 =?us-ascii?Q?yGJpUrlsAWfEnuvVxmMLtDdBYJtHu0eFmymrWg1l5F6bs00/Vyi0FH7kGxWd?=
 =?us-ascii?Q?UWJg5fMY5rY4RtGy4EPkS49Jeo7YmmDgiHKvbzNjzC6UzpTpGk0rabfIqOq8?=
 =?us-ascii?Q?tMuuwSo582w/kn4XD5RitKZd2mXt4Qos+lcarlkGfxpW+ZP3JzzQourqJXZu?=
 =?us-ascii?Q?m6hw97YF1QVOd+RHigKDveQrGMQG+saVl9Iqx4vskQE0ajyF1Ycbq8tzCcPE?=
 =?us-ascii?Q?4AWRoVqeVQisMJ+rpieWF05g8iYCvhs3ANL0diZzKM/UYFysF0UiMwTHOE5q?=
 =?us-ascii?Q?FUxSQiQKyFtIAFiFylix8Jo6uOBPXjjBDJyj5p0nzowMtmOQGhFo5voP1oyO?=
 =?us-ascii?Q?dkCtOp/yNbKy52y7kxI+LgRCjYItkskPCxcdqfeuJF9ZAJHuuNr7bf+Np1cm?=
 =?us-ascii?Q?qKyLeiilXoXQHfQZuN1oN70OXxq2FBLl1Y16V+FVRZh4SCY2DUcY0RIztYAM?=
 =?us-ascii?Q?iEeljOu2pMxaEC3yMnO1poVfRqp1jwp66h4T3J8Yab4aaGaEIql7XM5W1few?=
 =?us-ascii?Q?XvIgPfXkvrtGT0CdwMIrfGzzu/fPMkccVR19efAEry7OSa9PfxgQrWAPDxyx?=
 =?us-ascii?Q?x1yvy5dkwBZnV4nlhE9UC7BVQBj4QDO00wfSHVOMsuL2oRuyK1U2nOFzF1DQ?=
 =?us-ascii?Q?97jJ8sF2mZB7vf2gQOUHfgquQlRTYw9PEgfxYvDIjLvASMbLPr6DY9f+8QdD?=
 =?us-ascii?Q?nV/ph5QEUrV8r3cHp5UkwMc4IWEKB5BS21tZgnjp/d0qBj5P4GdAdmhciaHb?=
 =?us-ascii?Q?7183X3ZZAtKRRbzaC99HHMpn8v0F61s4AqCtWFiyumr28+54TDyeUaoWPRXN?=
 =?us-ascii?Q?28rzrNC8IBAh2L4ljB2NfODK/fWMiEQbuJlxdlxmgPN8hd+dAW74HdOG4MxM?=
 =?us-ascii?Q?W6lBMwnaNbkuTBlpA8aqIXtRpmZ1cuPog5FgLSXl5CEHStfwlZ1BAMnNGehN?=
 =?us-ascii?Q?N7eCvS1jN/Av8AAoi55WQ72ZZAofxpjQQ/pWcl1+uXsXLSSSyj4lO65NnqFV?=
 =?us-ascii?Q?SC+yaY3U4SM5T99mKcujtXthbNcjOs6iZen2n7OzNQw82THK6oYUObo7rsk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9e283d-ee68-44e1-08af-08dc950902db
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 11:21:51.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1993

MT7981,7986 and 7988 all supports 32768 PPE entries, and MT7621/MT7620
supports 16384 PPE entries, but only set to 8192 entries in driver. So
incrase max entries to 16384 instead.

Cc: stable@vger.kernel.org
Signed-off-by: Elad Yifee <eladwf@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Fixes: ba37b7caf1ed ("net: ethernet: mtk_eth_soc: add support for initializing the PPE")
---
Changes since V1:
 - Reduced max entries from 32768 to 16384 to keep compatible with MT7620/21 devices.
 - Add fixes tag
---
 drivers/net/ethernet/mediatek/mtk_ppe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
index 691806bca372..223f709e2704 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
@@ -8,7 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/rhashtable.h>
 
-#define MTK_PPE_ENTRIES_SHIFT		3
+#define MTK_PPE_ENTRIES_SHIFT		4
 #define MTK_PPE_ENTRIES			(1024 << MTK_PPE_ENTRIES_SHIFT)
 #define MTK_PPE_HASH_MASK		(MTK_PPE_ENTRIES - 1)
 #define MTK_PPE_WAIT_TIMEOUT_US		1000000
-- 
2.39.2


