Return-Path: <stable+bounces-192920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C33C459A6
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB123A99F7
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202392F8BC0;
	Mon, 10 Nov 2025 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTcsj/fx"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48941E885A;
	Mon, 10 Nov 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766578; cv=fail; b=QoWC6ozKhbL+8UCUVMaVYZC3oNGQKkkLM0Wj0lUnqgGCBL9FI/tUzu4R29Af3uYl0KWqHZad3iDaRjf+1T7PgWkIXdqU1M6l0/gxVXjzHrAUHbw+DOw7qfAJFK2rC5eoBXdpkuJ2vbdK42Vn6FbwV/Z7S6MyXCFgSbGpOmOHxzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766578; c=relaxed/simple;
	bh=9oelSV9r7i/8QIl8I33jiacgu7RI2BsC/OzqR8EKNYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlmLWPDewGLLtfqruUE6XIky3j7DxTIRuKIIsQUa4NjugkPNi5EXBjjttEof+KeByNeWOQyxmQsq+WehBQ/A9oHlQy1tircJRZYr2o/zTtNns8C+fiMwDPYoJeY82l+WH2GmGmQPZe0KAaCC8vjFsxf5EYqmGFyq34djIZXvLXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mTcsj/fx; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CILHFrJiAnh2gjY1DcUYnA3GTM4vipY4rl5jIngtLidhd3ESKUfga75maMM67kgzZKO7oUOk2hgl0biTT/s4yje5MK0vZFQMk+iVvv/SV53eEd6pdGl59pNNL7a4KXMJdI7H+GqfreO9aIDvMCZzLKIB6jg8qmazMQSYAWPtZl5CUU0OoU8d872F6h/Z3YThS3Rmj5ZxGZ2J1WkJX82+lT6OB2QvMl66uUJvzz37d7LD8hPpsnoLTXnEYGR2BDWZ+WZP1eTs/L0l4WbHCi2LpZH0P4Sihz6t1LyYXoiAF/P3EFA0t5Sdmi7sRqaFBUl7s3sNWDUFXqcJ4L6wmbuExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ZffMTC0fCgzi60kA5uc/4edLpf/wh3XUqXBbo11Go=;
 b=uiJviGBIn0S0Rg4bu8R6IneoYIapCML2jyJUmcAG+1OstmiGAyWkue7lGk9a0MwWj93W1h4p2/9ta8b+d6FfS61F9QDiinHeJgdyGOpBhyjvHtPg4zDmk4cDtDehHtW7F+9QLVDDGcrHC7Fy6H+uBm/5xsf6dbOGEJxpVKlPsKgAOT1SLXBRpzL3+HqkTgV9SF+eZkEER5DhAYbwxtX/uJR14rvnzMV04n2rJ4zT1bUSwkQXnapzwlHz5vkw699ZJUJwx1zi2M1JXGMFrLwC3vy4ylnR4JZZ4Rcc0gipqAVk2PoFeMYYseCfbnWfT/dn6LH8rbf+g8OsmNslkg3XgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ZffMTC0fCgzi60kA5uc/4edLpf/wh3XUqXBbo11Go=;
 b=mTcsj/fxyPSSSQ0d4b49bkhAm6GYodbPgnJtPVOC6f6gNJb2OpYOoFWrqZSxLerLZaxZe34L/tOqagqjfn9d1DCj9Oj39d42pLgFiQBP7R+w/mjhTqfBkG/B+PFXYfEdjhx2HsD/vWahWvMgtfU3uZ6Yhwu4uNBJ4nnEFvl8YO++dCoyD0NB91Z60jaX1HUy58kq+iNgPMZ0f4hdCfGWgEEt9UWbovb27hBDEIGBX64MJoATR1ZOoVPKWmsUcFH+7OXHjtxQoFfLQyuGqS1KGGcPxacapEPNc0sMW0c/EJEgPQwwEbxlRAub8lYGvJau/58KsLr0w/YL0vr6gNiwSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:22:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:22:53 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 phy 01/16] dt-bindings: phy: lynx-28g: permit lane OF PHY providers
Date: Mon, 10 Nov 2025 11:22:26 +0200
Message-Id: <20251110092241.1306838-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d61f77-68b9-4702-5488-08de203ab9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BO5tXFyXANr/V5UNMvSs6Cmf9+wqH2Hu4TEtedqk8k4KSRwN9Rn02dh5GkX5?=
 =?us-ascii?Q?5ZPVT2YQ2vjUunmeTpLIWeQGH2vXuo5SmrQaHHrV5vr1EnLwfEL9yg6j1Lg1?=
 =?us-ascii?Q?Hen73IwFLvZN971ixfn8uTnu2iDlCkHTyQ6gkiT/vruNP0KnuexQAe2wqsx0?=
 =?us-ascii?Q?BaKwOu3G/JBa/JHgT2RZL7m9ApejRubmCJwBqzLbkYNBbbyJPenzoeZOE0ye?=
 =?us-ascii?Q?HAyyiedJjFi7G8Qe5Firpze412eXuIC6j10axqYzs/bTcQHgjogvFnfHbKir?=
 =?us-ascii?Q?EkinOq7bFpk+Ds4t4cEnhGX9mXgi61MzIyIhKP9JYXhMjTjTPY83LktgE1uZ?=
 =?us-ascii?Q?KEpY4VjJLWJWaU9GeUxilD1nwvr1rDLrPjrwbULEOUYd7/qTYfuML3/A4DBa?=
 =?us-ascii?Q?0D+VvQT82xDhChFusDMjSh1VLDkg3/XTmFfSC6DjKP/aDv4vi4fZlZxfjoA5?=
 =?us-ascii?Q?ksH9izAJVGpDW/nwEW2By9CqvebeTVX+CK8TJTBLLydj7DRMNFCTmSSUXKaY?=
 =?us-ascii?Q?2qbu213IMrJvKqf4Vni9fyvfV0BdSK03dYLwlhBMa2cBo+Fmd7oPJqzC9DWG?=
 =?us-ascii?Q?PSZD7bkLHi+FmnNH0hhFdefIoW95JBUbaB0pMYdaCYaZ8red0PLiCkF0z+Ns?=
 =?us-ascii?Q?Vq0HgA79T9G9MglBl62N9XHajmPrp262b1asqwO5KaetTtabT97ZYUXe0B0y?=
 =?us-ascii?Q?1H9LcALXyIQHQT/LUAEQoreTb/4JnnyBMZSXB4wQo9RyJLENyQPAdufZmJw4?=
 =?us-ascii?Q?6J0PhroGi5TFwQq6v7pPIuH1Gd9TvC8Amhao7QwRgbFuQOAh+zxV5iW1EFo5?=
 =?us-ascii?Q?2cXlYo2lxAW7UW2j4xZmwTCPp1Fz4f6uUZFI0cz+Kb64NNmP8ne88RTRYNps?=
 =?us-ascii?Q?ed/poC+k9wfTsMRTr6AAlkysopbvyUANsvSkJUfcjwIftVE6M7YnrFAHBXx0?=
 =?us-ascii?Q?E5u5sOWtglYUav+Dla0xy/tvNNz9mSybBc0FisNpFSaOVKjELkOi6coeb3mJ?=
 =?us-ascii?Q?gS1CHqtSWF0RJAQ5BtHLWMJ/dbI4EDL1EYdHaTJshq21fyyLwvd9fdKSDmFe?=
 =?us-ascii?Q?cHi+tX9GPkEFT6TOvgDlgNbglMHIZes53L0OSQ0vpoNLiFsTNwYND+EVRYHA?=
 =?us-ascii?Q?hjRGhkYUGqyWh10xWQSsuJW3TlU6g7iaaBvpTPFa9O1ui7p4vD12ARhhbe5z?=
 =?us-ascii?Q?MvzlchM7JnzGlj5jS26KVkuuPsrw1hYYOzrs5JJGJ6G4Mwjn2E+WEHMw5BLm?=
 =?us-ascii?Q?mri3XfwwwwwpbCdGgZ5QrnhyludR2OTIATQV+G39TarTeIRhk43tLv7iiqxG?=
 =?us-ascii?Q?VKj5djb9q/etGdRFziKxEIp28O/dCNPtK69pCyelyygI3UaJvj6H3K/N/OjF?=
 =?us-ascii?Q?VMIE1EEEfqNBWeUWUWGdZvn1ASQvydleuh43rpncX6tFn3oy0eXTAb5Nc+Lo?=
 =?us-ascii?Q?Xnx/F3rvO2olvXVAlaKg63lAEdlcxGzp3MfcDPzrSClnjbe6jIyyuyCSQRJM?=
 =?us-ascii?Q?ofwIAu7d637fse5b685c+MXYRyizZ8K+Sf7n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VwZe0a40WGqgszzNfZ7/Y/NKjTUXHnPoOE37HSJBNQDleV+aJQVXZat8eOl3?=
 =?us-ascii?Q?8TfmVZk6B84uypuQuYgbC47DRk50fpdG7Yca3BcWPnE1r5FE7mT7ixK86ROP?=
 =?us-ascii?Q?4ldu2vbNenkm5CH4egygNCyw4EO9UhZjF2qUMu/A8LwhkFyunw/+ZKhLd38U?=
 =?us-ascii?Q?L5QSXCP5E59CYt1MBUbqwRUX9SSFgPx0UC4BbTov05HOLkISmJMUDJcpj0L4?=
 =?us-ascii?Q?v765Ju38C+QYKoRYyaY2VjDdVViJKKFpjhpJKn6+lphpyvr3t7k4sFH+5WdM?=
 =?us-ascii?Q?cjsPSONN/iluTpXx46stb82krxBOlSn55RdhH7S2vS3Lm6yYRifLZI0SXFPK?=
 =?us-ascii?Q?HTMnwWq5jkBy0aLHfWTvM1fORK0LS1idRd+R1y7YWRSXH2ExOPQ1+OFHvwrx?=
 =?us-ascii?Q?MTm4VE1+uCfIfvD5CYPrbVlpS+EWqKLVNsCKJ68RO2NRS2p3k+vZqhb8GHTQ?=
 =?us-ascii?Q?GLBra4r/r8yrdfMKM/TGaNbiRjrNerpl5A0l6Kr275JzXC+FYGiB9CACPjxt?=
 =?us-ascii?Q?eTbUaP97nViaWySsjH2Lbd8vG4zYFx/s3vq6p6As7gkjkbDAzai/zc/rImzn?=
 =?us-ascii?Q?vbiRQrBSMdoMfLWNI+MkjDoT5ryz9s5vRfHyZ0Ju79zbBkPEsZNJGSKmClgs?=
 =?us-ascii?Q?C9ycRnjFHJ5Acet2GTqL4CVx+jpnxPrQ+jYLo5lUeFrPYtnct9/N8TPKqcS7?=
 =?us-ascii?Q?bilwbnEIOPBIo9euaqzeAPj+hAfEsI38AFLvepN645rUocuQ3dbPMgLQ71sK?=
 =?us-ascii?Q?KkcqDr8pX3D6C2eGaqRJVGJF1dWA+9+fAqlABk9iLPn7EX+83U+CI/+zbLnx?=
 =?us-ascii?Q?3TTtlTISKL6/aPrsOvy6KzGft2BqtUzRDyfLI+oP4fzmIFhfFlZptbZv0ovS?=
 =?us-ascii?Q?np4lITSl5c8PQMjTt0+rbw8blVfKul6EvnWbCXuddlfSXSX2Dtc9VXdG2CtG?=
 =?us-ascii?Q?vx2GxMGqo9B/OFUTWe8IRqCrZY83k1lNQpvOb8vDqzSXQhnIs7IbVtRsgZaU?=
 =?us-ascii?Q?W/UORgM8bresvXpA4wxqGsWdPeegHdv3gTKAACfLzlNx0wfrw7WNvQT2HP5m?=
 =?us-ascii?Q?ZiIglZX6vxe6t1ZYMBXullkkuUatYPnS5CYkVwXaXBu0gw+iczcwpzdjjTzD?=
 =?us-ascii?Q?cxX4KB80577VFFYB0gU59qJx+5SulfyWunbo9xS/Dg8q7Z/oaE7ShBl43kGF?=
 =?us-ascii?Q?dFptSK6i+IQhpBPxbv6w8Woi/iQ/x+SxhEBCSknkW1pF9hvnhkWE3CUujNk8?=
 =?us-ascii?Q?OMwUQ5qh9qq6XRkeP5uQSNa+ma/+cg6+UEuK20WkM+ZrUjOsKRj356ij806M?=
 =?us-ascii?Q?vdmZlZH5s44+o9L8DIJBsAcXzqf17dy14C7im/J0NqcKVit/Ly3xZwWsTt8V?=
 =?us-ascii?Q?+SOpxyKfarKfrXVxHX1p8gXmf0NEOmv755WVKGkQUH4xpm4YNZ6p/Uso0qEA?=
 =?us-ascii?Q?Z44VbQxJ5LTnJsi2JzaY7/YUqgwLA6gWgNJq58sKmrM5RkmwirDnAarGQh27?=
 =?us-ascii?Q?WBG1Iwye+5i/u6+FM/TepqIYl8VYTZZAEJuUL0O5JRrddojJ6jq1phP+w14s?=
 =?us-ascii?Q?5zSwH+B7DP+YIn3QpVdryes/uhv/4PODFSS2hBfeWO10mrdSDXVHjFKpxSqF?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d61f77-68b9-4702-5488-08de203ab9d4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:22:53.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPjog4Ptj6Qiqu/pcmmpIeoxjfCbBSSJr5rk8PFWt5MmfU3bGeqq2Uw7JSS3ZXL/QH+r5Q67UxjkHe+cA3Fs0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

Josua Mayer requested to have OF nodes for each lane, so that he
(and other board developers) can further describe electrical parameters
individually.

For this use case, we need a container node to apply the already
existing Documentation/devicetree/bindings/phy/transmit-amplitude.yaml,
plus whatever other schemas might get standardized for TX equalization
parameters, polarity inversion etc.

When lane OF nodes exist, these are also PHY providers ("phys" phandles
can point directly to them). Compare that to the existing binding, where
the PHY provider is the top-level SerDes node, and the second cell in
the "phys" phandle specifies the lane index.

The new binding format overlaps over the old one without interfering,
but there is a caveat:

Existing device trees, which already have "phys = <&serdes1 0>" cannot
be converted to "phys = <&serdes_1_lane_a>", because in doing so, we
would break compatibility with old kernels which don't understand how to
translate the latter phandle to a PHY.

The transition to the new phandle format can be performed only after a
reasonable amount of time has elapsed after this schema change and the
corresponding driver change have been backported to stable kernels.

However, the aforementioned transition is not strictly necessary, and
the "hybrid" description (where individual lanes have their own OF node,
but are not pointed to by the "phys" phandle) can remain for an
indefinite amount of time, even if a little inelegant.

For newly introduced device trees, where there are no compatibility
concerns with old kernels to speak of, it is strongly recommended to use
the "phys = <&serdes_1_lane_a>" format. The same holds for phandles
towards lanes of LX2160A SerDes #3, which at the time of writing is not
yet described in fsl-lx2160a.dtsi, so there is no legacy to maintain.

To avoid the strange situation where we have a "phy" (SerDes node) ->
"phy" (lane node) hierarchy, let's rename the expected name of the
top-level node to "serdes", and update the example too. This has a
theoretical chance of causing regressions if bootloaders search for
hardcoded paths rather than using aliases, but to the best of my
knowledge, for LX2160A/LX2162A this is not the case.

Link: https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3-v4: patch is new (broken out from previous "[PATCH v3 phy 12/17]
       dt-bindings: phy: lynx-28g: add compatible strings per SerDes
       and instantiation") to deal just with the lane OF nodes, in a
       backportable way

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 71 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
index ff9f9ca0f19c..e96229c2f8fb 100644
--- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
@@ -20,6 +20,32 @@ properties:
   "#phy-cells":
     const: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^phy@[0-7]$":
+    type: object
+    description: SerDes lane (single RX/TX differential pair)
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+        description: Lane index as seen in register map
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - "#phy-cells"
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -32,9 +58,52 @@ examples:
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
-      serdes_1: phy@1ea0000 {
+
+      serdes@1ea0000 {
         compatible = "fsl,lynx-28g";
         reg = <0x0 0x1ea0000 0x0 0x1e30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
         #phy-cells = <1>;
+
+        phy@0 {
+          reg = <0>;
+          #phy-cells = <0>;
+        };
+
+        phy@1 {
+          reg = <1>;
+          #phy-cells = <0>;
+        };
+
+        phy@2 {
+          reg = <2>;
+          #phy-cells = <0>;
+        };
+
+        phy@3 {
+          reg = <3>;
+          #phy-cells = <0>;
+        };
+
+        phy@4 {
+          reg = <4>;
+          #phy-cells = <0>;
+        };
+
+        phy@5 {
+          reg = <5>;
+          #phy-cells = <0>;
+        };
+
+        phy@6 {
+          reg = <6>;
+          #phy-cells = <0>;
+        };
+
+        phy@7 {
+          reg = <7>;
+          #phy-cells = <0>;
+        };
       };
     };
-- 
2.34.1


