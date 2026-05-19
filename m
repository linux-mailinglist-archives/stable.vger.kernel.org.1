Return-Path: <stable+bounces-249628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VOUpAwCGDGo1iwUAu9opvQ
	(envelope-from <stable+bounces-249628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:47:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0789E581B48
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC9523058BA2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C3E14BF97;
	Tue, 19 May 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d/cF8hGF"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DC408002;
	Tue, 19 May 2026 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204717; cv=fail; b=oOZZ8dwrk7vQWH+o35I5pqYuaaeUXsVgshlhD6Bg7PURLjVjqsFmVSkwvy7uX7ISIIB496UnxukvrdjXL1B+ycv9KeQoXSVsXxmPHevqtGVH7iQxSdNDPUJXF+HkJoA5jQqtaNKBk6k9by60oVset+eW5zZjhh5Jf4wX0WIdqyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204717; c=relaxed/simple;
	bh=n0h+Zkbt+OfCkz+0wCeL0r7LGMH/O9vmwGVCcu6D8cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S3ITibMMoGeGL5fhWSoOGhy9HQQOOmLe5Ry1mddMSLe09B8AA2/cHMqcF7DUfxguzKEwBpr5k2z3TpunIGNIG5MVqvGMIQtrcnGAsCEnRk4KBUcfeqTKO1o7gQR9AbIml+XWjbGzWecnexXdooveW9alOWwzUX1auorpzuPod3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d/cF8hGF; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icSRsBegDqnpHfPFiidb97z/CSvRHVxO3WWSezJxfekYJMbCqR0Xj9LlW8+jO62SHtfhp58FvfForLJL0FEK8EwebEjSMMnh8w0VNLh+SRdL05+LJVdi9hjaNqDtJgjmhoQJs4oECEvhtoydKtm+yEFLmUWiZBbElsV5sWQ1RTWDmw1gq78terFB1MzZgGoHoSWgOSqOjFHBpjWk4fq4lnaSoG2XwfgCOW7JK2sRbP5b4CTFQ4ZgMkm97CKKZLjGigi8XPH8wsh2+lZiGvPutZJu4AIW7UhEJzxQBwMzjYeZMJfc965FXQudzBxnQ8Bw/DZrZlCY/7bkDr187TErZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyd7v98slnh9nw/D0L4nYcYB4aXQ3E7tH/ytZUvzT/g=;
 b=dUiVXRyQoDxHxd7SX06H8UWgZU8NJcPoUNtPIs8NtZ5h8elkmuIexc1ZyJvOZHg1OoHU5nrDzqlU6RLXvu1EiR7Xi+JA5l+kcZxNb6vwcFkT9ygVMVOTD/wkBQnX4v4E3yFWIg0H5NitXaDyWeBGpA+HrFdvbKleQsIPb7QITQKIzDplZbgAEoAW7jVZSXqvLbq/2mlGEHcyWKydXk1/9Y7klT+FKY+lKUpy+Q/jOej2y81y10DoLT+dNTloHFEvjDioVQHKGQqNHya0dKRTVij5jDPdgWi5xq5LccTZYBY0Zch6ToJKWVf82mxKx6QI2LDCdEdGIYw/Q4h6bMUiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyd7v98slnh9nw/D0L4nYcYB4aXQ3E7tH/ytZUvzT/g=;
 b=d/cF8hGFIXYgpiAMhsZGQRvF4Ig7jTIGaVEk9k3it+1qdvcuTCAZ8fjPo6aa7gt2/7UttGGOefEBGCpQJF059uRe1Flek8zC9fBd3k2/Yljp+tjDuEUam2kUqNzDulCwDnuP238AF5UP8P+/I8vhYCI+pY5d9IW+BchGNHdvE2s2eZ8HyesHnroiUsm7x6CwSIRtGcFAnUBryK970lq596oyx5BSKS9GGdnvMitFZ43tQaB0g3tQPnKS1ox6nNsraKxtX4Naqc1YeqHWSS/o8wcyQtuIuMpJrKNPMv8u/vijxb+SwuafXUtuYC7Bm006wcmAkSCgN4vMm0Lgt92+rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB10015.eurprd04.prod.outlook.com (2603:10a6:10:4d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 15:31:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 15:31:52 +0000
Date: Tue, 19 May 2026 11:31:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pmdomain: imx: Fix i.MX8MP VC8000E power up
 sequence
Message-ID: <agyCX8PpWxGNoj0u@lizhi-Precision-Tower-5810>
References: <20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com>
 <20260409-imx8mp-vc8000e-pm-v3-2-3e023eaa245b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-imx8mp-vc8000e-pm-v3-2-3e023eaa245b@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB10015:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f69795-371e-4f16-f7d0-08deb5bbc031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|22082099003|56012099003|18002099003|11063799006|38350700014|4143699003;
X-Microsoft-Antispam-Message-Info:
	mwWZJ5BF/mA9wGDV5fzizK8J6Hqg07szSTFhogCqzI8kSMG5fcNabqIKMKf59zjHkB5b4MiSZiX7OO4UzzHUzfRb2ScC9tylt7yYjkgzLnbwDMJo4B9wv6wGAGbLMyW5+0vt2HXh6loPh/d7eA4tu75vov1mBUCjI8bPHdVRctbfTE7ei3SpDL+oYHKEYCzyb+B5Pq4gCqxtgk6LIAiGIzpQPW2m67djU1eXrEUCP1CHWCmcN5kUfBQ5SA+0s8nEOl5hONeZgVHSIz/kGuMnILNtvVe9Rs51ZQlxwn7QuJu1vf+HP91c8KsUiW1Gnu9VbnN0r1Om5fdPNHawm2xHSI6EOpdZHa7BUe0l9HpBVZjJ0RurS04xuYLL4hZ9RUJo4O6hIq2cZBH/NWVLghirYGhjK/NnBT5G5jUqJxPIB67glB2cJT4iVR9JZviEwWlD2u3kxSEAco1ZmGZhvJ0G/K50DwbS5/njdGi//yHLT7c5GBOq2NbL5Wr/oKrg7H+BPvgK2m2MSlI+KZAEieHqx+++aNmZxHl7ytOkyUEH/W96ANAXvmNLUiycD2p7eAylJLdehvL4mHhAOHIvaYfMIre/aR2SeynWHvuphjixT0HQ+nzgmoXj1YxLMtbfJuFatnYZIvkwODh1b9yDH3BYtPkHCJ5BgT/AzKCWF3l7UTqD2layFuboi5yxhM9iDlPSimd8wjKqYFUFAmp/sdVxDxv15v/Vke8s05iJSnWyXai0dBBQi9kZ6hn9Tswobn3N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dS1P/cSRuMg+P+KaMMjwL2Z6g0vwpa2oiIfTQOa49h9HSLVMbyJtSjFZZgpE?=
 =?us-ascii?Q?6+LZQlTv2erD7YwYqyY2qIZpKKHe/qF7VMchWdsQZ+fCEdHdMQ2G5d9KL7ts?=
 =?us-ascii?Q?1yrUQ2pxk9OA2Jo+MUG9cUxZU3CiyhjN7mMtw4LKRaksETMy97XTIow5/cES?=
 =?us-ascii?Q?Lp7MoH4oaE+7vvEKTd1uGINjAbt7YbyBt0/2Ri3dNSmF32ov+IRG8M08A05j?=
 =?us-ascii?Q?mOVCiVeXVi0OlrWqQ8QkDqNuioDr9YG/1DIiYroqFxp2xOIDBETh3cS50YwO?=
 =?us-ascii?Q?1rKRjRYMf7ikRCQRdZR1cDm5swJKtjHA6tTaRY9WENyiICKuURamuRM9UbQ6?=
 =?us-ascii?Q?xRxaDuJgea6wV/xJKlztjEfXQ6vt9IEKMTofP1HLFB6l/JLvJFMfXJM3foin?=
 =?us-ascii?Q?epADz+DmAE2293sKXMFBRLQ7/8K4TeG/w3xoaVEcYNDrwjpnS5/Wz5b5I1jM?=
 =?us-ascii?Q?gm6C+eLYtUr3TOeknZ000BkiNeFih5FMKXYcnb/3z7jKJ9ORIHkSNZdz50fB?=
 =?us-ascii?Q?Kwqcak1upQQmNsrzKp1Q1YwaoXjT1hTUPGbLWh+/HUOo335B+sDyGGhEGQx/?=
 =?us-ascii?Q?zIugnQIQh34DsI3NdtwHCVfQJeGNuySmMq57LWXnEkY0gAAX1GCg3k27mAwD?=
 =?us-ascii?Q?5Z3NhXcFIMJEUXIPiVvgeeyc/b8YVA3Ml6QlkNQDqM79U5kdpFXcr62eB0La?=
 =?us-ascii?Q?pHHdsHkkIAnvz6iBgxyzIZ/jNOjBBaZElRA/jrEkoMW6OdBGaxaBHUoUxy4+?=
 =?us-ascii?Q?GmXVAIejJQ3nCTDQKfjG3sCZd1QoKa11Cmxpk7p6mV9O38Q+wSP9pgp/12HX?=
 =?us-ascii?Q?sCG+Xs7RjAjPi5chNkh6RKJpr3bAUEavEPPktnNI3O2b20bMZjFfjlZc3Kzs?=
 =?us-ascii?Q?qVDkhgtuouBVke9XZM5NtGZd+oxIWPt+eMco6rbckGE5QZll6aFfd3MnhSZl?=
 =?us-ascii?Q?MaDt0fv3pUD9VT5tW4dD2/9VaqsRU2g5UHHZjGksFIo6hc///MT9Xu7WESLF?=
 =?us-ascii?Q?FSDR6PybqZQxGGCipcVhoCVuNTDTX6/7u5ojREMlMx21ac5gsArVuZQIO5d9?=
 =?us-ascii?Q?+3XVso+PCFKfoYLrtPz7427qj0wM0WJb+eO+471rAOPXeq9AXyp+Dauc8ZZk?=
 =?us-ascii?Q?2wCGTV+bTP2j+0IcVCeL9yiXHqyhwLSEqgibjnEfAc1HEQM4+yI45s7h5/GX?=
 =?us-ascii?Q?413997jDn8aLyXmG1PGh9pH54Vv29C/VJgdSlsuuiprKhHzIfH2O168s+ege?=
 =?us-ascii?Q?N2jLccM5RtSX52/qxgdAnc1EOrBJX7aCSIbfK3RvzuXmrQPxQU0gPAVu/KnC?=
 =?us-ascii?Q?Tm2KCt5pMv8KuDRsu5HuSUBCWDS16Dmf6EXZqYBniSHIyBee3Asq1jFS1jec?=
 =?us-ascii?Q?JkO0OMLBFMb53OGASswqWR7Wx4zv4CvSSRQ4hQbALvLyDjbKPdPpIS/WlYNk?=
 =?us-ascii?Q?o3CVIbPXCJTm3u4YndlcuDZ7xm2t8SqZL36Tl3iVqR4Wg/ebtPKZ5kGWqyUw?=
 =?us-ascii?Q?sK/PZwW+st5FCOWnopmm1zHRGXN5l5HylIGrgcEfxjIhUdG4xwDMV74HC/35?=
 =?us-ascii?Q?nUK+/ypEZag+RbgJy4wF5B/R9HHqXLsXe3jpR7NGwmpXqD9/2o5iyyCDnxU0?=
 =?us-ascii?Q?voElF0YdNXIqzvofamRex1x704AnFap9WUTpHPjiDRimBmL9gk1S7UGp/cBG?=
 =?us-ascii?Q?CEkwYd5KCAgvqrxi9lbmwV8MHDDbOmv9JeAoOA9m1XusHGRoQ6+EmOjDsq4N?=
 =?us-ascii?Q?Jr7GYhp7kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f69795-371e-4f16-f7d0-08deb5bbc031
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:31:52.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUUssa3P0MC9G15Cg7aXcKunPz++Welc8Yg4pJCCcdhVcSDvd63LW5ynKRBoKEQCrGgU8i4NF9jDKK+EKkvDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10015
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249628-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:url,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 0789E581B48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 04:07:18PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Per errata[1]:
> ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
> power up/down cycling.
> Description: VC8000E reset de-assertion edge and AXI clock may have a
> timing issue.
> Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
> both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
> VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
> de-asserted by HW)
>
> Add a bool variable is_errata_err050531 in
> 'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
> is needed. If is_errata_err050531 is true, first clear the clk before
> powering up gpc, then enable the clk after powering up gpc.
>
> [1] https://www.nxp.com/webapp/Download?colCode=IMX8MP_1P33A
>
> Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index e13a47eeed75d7189aa15370a7bee4cceb05a1d6..1cd0a22ce3e533358dd7449da9989162b36c5fe6 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -54,6 +54,15 @@ struct imx8m_blk_ctrl_domain_data {
>  	 * register.
>  	 */
>  	u32 mipi_phy_rst_mask;
> +
> +	/*
> +	 * VC8000E reset de-assertion edge and AXI clock may have a timing issue.
> +	 * Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
> +	 * both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
> +	 * VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
> +	 * de-asserted by HW)
> +	 */
> +	bool is_errata_err050531;

sorry, where set it?  suppose at least one platfomr need set it true.

Frank
>  };
>
>  #define DOMAIN_MAX_CLKS 4
> @@ -108,7 +117,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		dev_err(bc->dev, "failed to enable clocks\n");
>  		goto bus_put;
>  	}
> -	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
> +	if (data->is_errata_err050531)
> +		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +	else
> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>
>  	/* power up upstream GPC domain */
>  	ret = pm_runtime_get_sync(domain->power_dev);
> @@ -117,6 +130,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>  		goto clk_disable;
>  	}
>
> +	if (data->is_errata_err050531)
> +		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
> +
>  	/* wait for reset to propagate */
>  	udelay(5);
>
>
> --
> 2.37.1
>

