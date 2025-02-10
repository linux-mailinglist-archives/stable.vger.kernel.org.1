Return-Path: <stable+bounces-114491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B6A2E711
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF8E3A144D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F81C1AB4;
	Mon, 10 Feb 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="iUiKn4jJ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2111.outbound.protection.outlook.com [40.107.20.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECC178395
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177801; cv=fail; b=t6fxSFYtYuqgQ7poKw1NkP+lx7x357Qkeo7Cx13M05yzHe5jTOsujtB5o9+JRzLmi+O98WG57LyuMlnp+GqaiXzH6Nc9jLRSBWXI/zCiV1R3xh0iZx7div5lBBNjpx45cXBRR8q6klXHlPKlaRhRirqKATbPUVtqTcEskXe3zuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177801; c=relaxed/simple;
	bh=krGWUXIDM3mY60s94aGyjbWjYLJof/9LPPOaoVw7qz4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=azS93AnZ2kX/Lb+L9/wBHfC+gObV5gzERT2mqz9LT/qIsA/Rqb3TTKUTr0GVGz/vdi+pmlW5gnTq3LmisK1xP4lj+8MrfGq5qeXgtYHbTtIE3moHV18fpV5/I2N7GzoEyBU3jvjVxUaSmS3XFFv1BlhGJG6A8g0xJ5wWmXidiKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=iUiKn4jJ; arc=fail smtp.client-ip=40.107.20.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdza28gGATcsokeq0fnWvi1oJpQCLmeLOpupQ1KbXFGD+URcgpBUexr2fudGzlQp4b29CAjfV8KnP1OBT7Vs433zX6Vl9WyllVPRLp0bPoAQPe6CF91MaQE9KPQ8l7go0xqTLOpRElh2bPPQCWgofucGqeZr36Gd0U/WPj3BdhOWJmeYjiwHJ6LxvXqfF3AgcjTdDLz+CH9hxJUYapwDtDJzGvyDnDmC5+k+93nMhR2ApelFvLH/27qdPIUnei7KLHDLRmXHCsOIvNIxgkoZXqVgwyxC0HtfGv4zZ3wQ6uOhXCeTyIGL/Sw365kKdsW68jcN21BUIxP9xP4Vu1xzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kI6uN+Mkk8SxQb/IiMW/sgrnHVF+Qa2CbY4bY3Qpfo=;
 b=fvIDUJrfWN0WseiZh7W48xiCacAwMKtihy9B023ouzTttShTGZl1idPZ/pJaOmEVn09OBuuQnUJpFuznGE3SMah68zS+W2V4k8SIotxuBfL35be0jP71402UMpSI+k9v34uetHiI9aG3cUuxK4BwgI7DU35UC3q74v4W7JKPBJWeiDxo1aOLrgKWIE2RCIobRrwvSNq7ie2Mf9mlGSXuAQ0MLMzMzFSuQRwuXCBWuOtQZhf2+OrIIgGJUXIuJtjhUmZSrRMbImUTYdZ4lUTdE0hjBLcMskoaM2+aBvAGVHFX/l1j++swDZnhiQcXDbrmMQBo+wNl/IpmcviDKtxW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kI6uN+Mkk8SxQb/IiMW/sgrnHVF+Qa2CbY4bY3Qpfo=;
 b=iUiKn4jJDk4Sr3Q9nDiulMofHKvMwrGWaHcqjSBQ49DVW8jmcYvfY3LtyEe4hYvnV/RUlE4heiaHD6xq/G8MRkJwLw1sXuNSIYOvUahbyzlOKEcpie93yJakoDkNA31PIgdcv8xcNAb+iawjQ2eZdoNqsc7OpeorzBNKDGfhkcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB2176.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:639::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 08:56:34 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 08:56:34 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pavin Joseph <me@pavinjoseph.com>,
	Sarah Brofeldt <srhb@dbc.dk>,
	Eric Hagberg <ehagberg@gmail.com>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v6.6-v6.1] x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
Date: Mon, 10 Feb 2025 09:56:09 +0100
Message-ID: <20250210085609.91495-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0226.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::16) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS8P192MB2176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd56c5b-7562-49d2-0a39-08dd49b0d1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ei9WKmBTKEAZwKNG8st4nQJ1n46Dw/Y+X9K9GNKIjro9wOkquxs0ub9FGch2?=
 =?us-ascii?Q?Nv6JoI32FSJKHhwSFTbjPhj4eDHUDSJZQFMXM57AYHtmFsVC7aKGEgpc6ymP?=
 =?us-ascii?Q?px0gU7dyyVSXbL+KhJKs+3WtLc0a/I9geMFkrsc5nmM6FItoNw4IFvugCmC0?=
 =?us-ascii?Q?N8hc3ecb/joaYgKuTmHvenLJZFOoE3tFLSzeDNyYNakASEzJmPCSZOqbw4fR?=
 =?us-ascii?Q?ven79FXAiXr1n0D6UGl9hpXd18XtjG0WyC7F/6w8y+LdhpM+zzaQO4QrWv5l?=
 =?us-ascii?Q?EZ2xsMDE8GpGoWOUZEZjK1eN9nwYn409mqvo0MkuzYDUZs5c3bWh2vyfmSY+?=
 =?us-ascii?Q?HcfWZq+vReqEsfae7us48O3c/dxrClY5QKx2XChr+Dg3tCAu5NgQO43cS+zY?=
 =?us-ascii?Q?fnmBPT4YeX5WsDxDEp3+t8zGAC9ohOSLpPEpL/WTksAGqYhnQNbACEiB2l/g?=
 =?us-ascii?Q?e9WIZz0fMQ0GopRbtjhc2Ndnf1nIeiXdi3UkVQl8BDm0EfDuBwYCtfQmkfTM?=
 =?us-ascii?Q?1UKySPz7JOLyD+rY+3ZB3NxdY6kZw1tOEyTJ4N0y8VQREWDCMHCx4o+x4LyP?=
 =?us-ascii?Q?fLCsUNslEDYrpfFoNi6tJpLhBM0NKEaQFj7k1zfN5ZBWZWk8W+88DV2RImL4?=
 =?us-ascii?Q?eYobm7LY/dPB189UVknWhaLxhq7+gNYhGBamkcDuGfN/yVjhTgbNZSoh2q3n?=
 =?us-ascii?Q?ACJ/dBzM3iKCpj9yC7yqnm+UjkDD90VYS5ENQ1fqb+wEWwuZ9TsZRjvA+Ld5?=
 =?us-ascii?Q?82ej7Q9ayFYUzrG90GIyG391eaMvcd00EWbszdAyBiFKkfSoGEPrQVr4ex2j?=
 =?us-ascii?Q?7tq+XXEIDAVXH428XYGBHjnzJ0o3248feRioHupx1Rf+cj4kDtubDt7W95Yj?=
 =?us-ascii?Q?8MeRK46VKt3dHZJ5iTZczKsSAXXVnoObx3ylqAUX0vO4M2CruznvlbQKo+f9?=
 =?us-ascii?Q?qkztzhhIOaTapnRbUV0oB+4NEzxAb+XHkRbnGk4LEi/wVOxxv8NPeZgXowmL?=
 =?us-ascii?Q?qrBaOXg2z4mYlaTLPFjruWal1VCXk956muVwo1Nekb8t7sgKaKkuftjzhdxh?=
 =?us-ascii?Q?tU/LLuQ+rn/b025w8SmjBm+N7re9Cujlhp/5vpD69knzvh4X/ktrmFDZwecV?=
 =?us-ascii?Q?VX8wPsgSRxdTFFTkVYsOz5azDyiDzm1pfFrGcur10q/+2yaq8R4/BvQSV1RA?=
 =?us-ascii?Q?79ehwcW1MSM+oNyqB+cKPVPSoSf/KppNKpR+uHE7k7nfFbP4m57kg8phfUBm?=
 =?us-ascii?Q?cf4npjqJfW7PoYIUKCqwg13IAaF72zfzFjm53k5nK8Vl/O42rVTpV86vcUJZ?=
 =?us-ascii?Q?m83XFVfYV55nHMwYQoPlYxeHp28R+lu7QPvdlq9EtiOEvxUMQZA+hTcVqOZQ?=
 =?us-ascii?Q?AwwykQCLPHn/tTZxpm3AuwqZ2htiaKEPTVkBBiLtik1cIDXQ1YeGom4zPEaC?=
 =?us-ascii?Q?sP7v50rlFbAFPshN0I6gyDw+jDqKjMF1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8eV/E4WN2J/iEjhg9dhDuNIaiAIR6onluEeoekhudgcZivr8c/4gQCfEhg+6?=
 =?us-ascii?Q?f0/VWK7bNq49Hi0+TlzME9jiLakdGJHN0gmoGeWx1uZD2Ih1/qUwZwFJ7xLs?=
 =?us-ascii?Q?nHnnbGTOa3Zrv7ZwTDlU26i9frlVC/tcAQwsSMNMggU+Ev2rb5s3vVhSGU4O?=
 =?us-ascii?Q?AQ3VDCxElqMWPfXNuqaG6ZJY2vhJHAIHaCXqqVWUnS/V/wwPUjfB1MElfyvX?=
 =?us-ascii?Q?udDDmxNeJqkZ25pNMPx786bSOiH9rYjEp8AbKlb9Y8IInlehCgRN2ne/Zi0j?=
 =?us-ascii?Q?kC9EZQAtqM3DUy4diyvm3LdsQ63qliRQiKLsy/+M8tO+HhlFIVYJWh6Pulcm?=
 =?us-ascii?Q?jd9dTR+m0Mo9ye4e5C/LWaxvTIoN/H808L+2Eg0dOnOpMdTAygpQS9vbQKNC?=
 =?us-ascii?Q?aEypPhkZyITKtp0b074dyETQNxreO+HQB4FHnVNTAW+UvpeCs5FeEpKzODX5?=
 =?us-ascii?Q?VcsVzLU+ICaXSeiNn9h74/ajqz4mUcfLlJ0ZxhImvMydbYBsmt9hgO+Iwl8R?=
 =?us-ascii?Q?KMYdnbJuKpgBS7PMiW5KzT1cvfjrJu8k41T5mxmkfDpz3a9HHtjw7TItqC4j?=
 =?us-ascii?Q?Xe22OrxjhggP96Tl4ZoXRhXhJPdzxd9EBBnixLsFDNxV8D3XUF0LvMv2YDG+?=
 =?us-ascii?Q?orGh0LbLHzUWamVO3IO77hmF+QVdet9h10W5a4+vveRmLM/0i7e4+muHqv1C?=
 =?us-ascii?Q?tA2VXHEGbc5Xw6ZDHE/0SqZ4ODJMtRSEdj5xSkMJK+fzvfPADF8ChSL4l/+9?=
 =?us-ascii?Q?PLJMe/pstgMhYhXx5l8v9exQYsX5ihtTwxYniGdA2xB1z3nWXKv6yE6g8MPU?=
 =?us-ascii?Q?FW36kwJaL/xkfK2JdSpEBMjh71AS3W4/7EmHqZHjditTm1dvYwKv+gJCVHBq?=
 =?us-ascii?Q?Yf805YNlzVyRA35/ZXuawuMHemx08ZeEDPeMwSMamOWDbf/lsfiUnlWU2WPN?=
 =?us-ascii?Q?cm/L4hx80rdDdEpZYACNoc9d3sNue6uzbUmvutrwKwrOimYZwD02hLYxfrhQ?=
 =?us-ascii?Q?NRSozsUapectuc4cXL95ZGVW/mQdwdrwNc30VvdLa0DNnR/EgleRlopxZeBN?=
 =?us-ascii?Q?DtwAp7oet5uTnkAx/fZO5MdEwcBCr8ODz7yABQrIbS+4YJLLsWfIyv8tn6B4?=
 =?us-ascii?Q?clzjQ45se6AG8JEJTzHxd8Ou4OnSwpUAiHGEEytOhN0D8R19myI0yBAvEctW?=
 =?us-ascii?Q?b0/rIFK73j/cKNGrFIEIqWdziMnwXxkAtZYHHqPy8lDQpWgl9ogbGrhK/s48?=
 =?us-ascii?Q?bOJZCRWoDrfGratSxJN5KGarissaKWpRzpHSfQfwoHoZex1mT57a3tlM/TWk?=
 =?us-ascii?Q?+SyuKjRPBLyDh1k2goqMRoya/TE4LO4pTDh5rI0CQUDbHgMG5dImbnIq/YgU?=
 =?us-ascii?Q?ff/0NdAT6VyvECNtViuINn1PXxeDScEtCobSlcKrqy4C7+58fUoBp7LFib5P?=
 =?us-ascii?Q?CrDbVAhPPMc2IVcn6ylbhGnh4xhCoKg5qpsQG6BqSwzcCzAfXh09s3Y3hiFy?=
 =?us-ascii?Q?gvm6rrgsZ5tLT+cxiBiXi497jrv4aXcadUNUpP38eRIS8aYijXGSB+7cPpZd?=
 =?us-ascii?Q?rzKFRY5OYmgKHHeNOjm939KI+aIz2TPPbeHvMtAi?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd56c5b-7562-49d2-0a39-08dd49b0d1c9
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 08:56:34.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTGZnCNjZ0iw0EBFnfSmu0aREVeXOPGTDIyGUnUVYpONysEXNO1AbrMH7SzlHm4lcl3Rb448QHR/rImjrxNr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2176

From: Steve Wahl <steve.wahl@hpe.com>

[ Upstream commit cc31744a294584a36bf764a0ffa3255a8e69f036 ]

When ident_pud_init() uses only GB pages to create identity maps, large
ranges of addresses not actually requested can be included in the resulting
table; a 4K request will map a full GB.  This can include a lot of extra
address space past that requested, including areas marked reserved by the
BIOS.  That allows processor speculation into reserved regions, that on UV
systems can cause system halts.

Only use GB pages when map creation requests include the full GB page of
space.  Fall back to using smaller 2M pages when only portions of a GB page
are included in the request.

No attempt is made to coalesce mapping requests. If a request requires a
map entry at the 2M (pmd) level, subsequent mapping requests within the
same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could have been combined to map a full GB page.
Existing usage starts with larger regions and then adds smaller regions, so
this should not have any great consequence.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
Link: https://lore.kernel.org/all/20240717213121.3064030-3-steve.wahl@hpe.com
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..a204a332c71f 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_leaf(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
-- 
2.43.0


