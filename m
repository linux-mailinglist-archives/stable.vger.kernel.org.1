Return-Path: <stable+bounces-227238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBVTBcW/u2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:20:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5C2C8825
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0A09305C78E
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358ED3B19B9;
	Thu, 19 Mar 2026 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bxw07ToP"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7536CE16;
	Thu, 19 Mar 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911251; cv=fail; b=TI8A9ns9BcWf+/KgphooqKHV4wjhw3RfyCLbkY5KXHoZmYxWojeZS3Sw55Wu79KYeFqPftwRIfI4YnAcDglLXtn0/QBQaefkVVrgwQCRpVPLKVTTRL4hzX0s6xT3OrIRhoNV4wyR3RsUOZgzeTGWKFDMIbjoJji0IHS4ncFfom4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911251; c=relaxed/simple;
	bh=75yQxNiU4aXOMvopX6zL+cLKzkqDDSsxOpDpNmPOxKM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NKuthZYsMfF/6PgDngkV5DP5NFMDEad6yvzm78Jm3gbQpuMi/oQlyPqPnDyATJF2LlQoL6xPZ/I+tof3Kjd2bM28syXzsT5Z5k3gDrqem94vCeuwAYn5u4OMb02OcipCJVAi4l2FlPz5Rk6J/zO7mLrTcDAwKqcSuarikZYI1+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bxw07ToP; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB2P3qvAA3eURtxhAPoS9JM91u95lPKhUAk9QrLRgGmIH2XrDzjwVUE9rHzUa1A/PJ3lIVIUh6ezOSaB7kCtvgRLiJFSF4edDLlWYYYjuTkdClF6hobU1s4CT7SzrO8WeL00tfX5NU/cBynqG4Oht11WG4LxzfepCE+KlIsq0+plItxSwp//TXWG3PtNECpJw/3aJ3qYMYwYyxbW4vecFgXrl0aBthXM1zzrBoW/9q4K3tiDLvFfBtk+Od/XoG9NR+ZRst20JKIOJnZ6HB8cQqRcDkmqKZ2fyWbjSQ21xz48sXhsx1br6YH5vHwhwZIzQaEfHQ5RL96rB7FyDnDpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N72Mb9M94qv0CnnYQ7607xYoCdx9tFn6CPtqvtww74=;
 b=eCOC7bYo5/+64ZIFIU9Ew4C/WJ5sllZXSTnknHVkFxnFXS++nQC6DIy9bCbcSbIFGs7Fr/qE02hjYmL4mUsSAc717LUdR87OIT5UT9+y098GGC/V14E2CaNrGEONdmt59IGS48wOvS11LaikkCgWvQiXgsyJWyQvUyJlPucqt+h/FWVRBWdA66lKdh7+JvUE5L9c2pNo/V+AXs3TKV2XgOeWsOKEsR+pra1y4B+k4gExP5+H68ue6AR66+YIZ5lixVf6H0tPj6XFhuNJFELQVEvUjb+qVJWyv2M6oDruFiry//+A4ffEYeM1pt4Lu0Lh1dDPhrurBw3XSV0QBwqHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N72Mb9M94qv0CnnYQ7607xYoCdx9tFn6CPtqvtww74=;
 b=Bxw07ToPSeJhzfSyXVCdmM9sjHLjAZC+ximkx3llOSA7PN4BqTApDUy3YcyPNE8mezxuF2zJgXQIDH16SFB6gU5WiDOQ2is3+6FwF91G5ctx5NMce9PdnCOkbcHo7pBe8RfHUjkng4wQb+G+xbRFuSO+JH8l5MaOBzO1b9EE57KkrdQhuclZK66CyH2UDHL7xbvpax9F/5yjRECIUv+isvut10ZMsompCXY1PpHDwQktThcOV5OehNF89UOj+9fM5YZQefzzlCo2dYNqj1K1EnxIS1MOqgHLDh4cx0rGthG4UTnci4g3qOTYlKVRgEVlRqx/w2vBKIIs7L1qIrmRjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7677.eurprd04.prod.outlook.com (2603:10a6:102:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 09:07:18 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:07:24 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
Date: Thu, 19 Mar 2026 17:08:44 +0800
Message-Id: <20260319090844.444987-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::33) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 60585623-d105-42eb-7960-08de8596ef22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	La3cj3RHpDdVThpiksHt0agamEaKcJbgugVHKsNF1zk5/MPUVwI3q+WzMX16+QvYNm21WDUtKseYC+1epyomF7iM0bDsGzxKYMqTaJtx0UDGoiYVJwT136VQhJa5Fyr1cXKg6Px5cpcSkNx58XE3IbktlzStKizGtnvgPDHgbYxuVIoMeMWe1DRKKrKpVmeYj0yfIr3vtATIdfwKJwfcKy7Q9D4xGUTzORk6TQksYZovrAE0ViOkke0MQMTLG/x+p2579dJ684Xh4Byy0OORcxZFtTyRWgQdMGMeHnZyhzH1z2QBHsqXOkjC5hbKhufcghHkWghXmZoE0Dje4ARNAt5/JT0qRbQrxn1fXq5QDVdTP3CWDnD9tfu39/mRZU7K5lvf6QyoTt49laKNa/n2EIxXWQMYHB5KebqHFIYkxnFSyJACB6aJJsQ2489K6MRpHVwmA+i0nIaxR+J5XwPEd/ry/fE/MaeYqZDoUYRE2/+/VlVfn8DpzDVWsdV+WFFDaNdX6rZWax3ilUsqQFiOvdBQEYQT6FIuY5FXf58/Lv8nACJJILuz0rOBLw/nyGFw6pKGAwVVHCIhBSshLtuA+NhDwOxYuryC0G/mqo+MMTDHCb/MBofdWWZ33mSjJumuroQDn6qOnNIeAvIADIfamGbLl5ZABiJ5z9DsNddt4nWZmpdZdVk+9xAqoWlp7Y9QxIT9n3R2KVxgzAYPUao7niIqL5PVXXJytFZ2aJQnqqF4I+XIDt4RwkLaEuAh290FgP/NeS012ajliZYkYGGAtffqNFPIdl+m/pjqJS/OzNTBeiRM3FiiOji7m/D127Rk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YNpatii11aEu2Yofwx4bT7z0V+c9EabuluiZ5zZYC0GF/hSDpadnTdVzK3Lp?=
 =?us-ascii?Q?mmNYIFmvO6rRhsPJ6X13Rxnh5I+UDNq+ST7m5OZr7Z5mLknIeGCjXmel3vtY?=
 =?us-ascii?Q?Yh71uadbATLLt3OSnzTzodTHzhDFXB/5fI+CTssOJgMNByixLbQpo6VDHGsG?=
 =?us-ascii?Q?RaZWlbAF3qkza+bj+yEJtQkY+j/jP1c74yGyhBktdgnOM/3wnnRl9s+XXxnS?=
 =?us-ascii?Q?hwHl/6wlnJG903+gv6Hbr5cVVZGoTU2kZJw/H3D0Y5s31a9IAdi3Rsuu5UGb?=
 =?us-ascii?Q?vnJOLjsnjpEV9E12r6rxWf6fE2sG6qZjE69M1hxC1UsbPECf69IOg95AxEcY?=
 =?us-ascii?Q?MSrahLkFcSa9MNfKdzPClLMcJhS/Q5qQbqZX6Ayc+NgkP4M5kFAtk4K7Pae8?=
 =?us-ascii?Q?18oQtzooY+L0uTAbZnjPwuwruNfJWb1OUrxpRAX8WVGQ4fy0ndPHtJLLqla2?=
 =?us-ascii?Q?qo101ydvv5QnpoJEkG2oW+LR20nhXUkoMxxDW3YtwaCRRB15w1S58bECXkkO?=
 =?us-ascii?Q?VvH2LjJV+FTolwuQjm8BzlgDcOxd5WCcWBOJXsf+W0L911TFYe4kCwNazyzs?=
 =?us-ascii?Q?di58MVIzIfIM9ouR10MJUhjpKdAJWNbSg1Z0NLc3xIrKOC7LrCh0cXsSDbO6?=
 =?us-ascii?Q?sIDaYzEj1xP2H+2zK2Ml0/Jw4jVYdmd+WEv9Gqo8bFpxNvSakdgc5vCqFWh+?=
 =?us-ascii?Q?hBhPzMJFygO/J/GuHsFNUbQWOn90vmlEMZuJ1DXam7gaM9dNZBcDaZaoCnSU?=
 =?us-ascii?Q?a7r7rtbHXTb4ReY4QBYgYrVEq4KdtGkA9uAsLqcUoTBPG1IUV34S36m5au1b?=
 =?us-ascii?Q?lBCex/SVIaUYXwvtnODMVjLRhpNSmPQli/tdfGcce8wQwL6JE53bflV57ZUA?=
 =?us-ascii?Q?J8Qr3CInPMyQ+nhNy1jyxsbXW60c+TLhPtsh/sLYrkG97tRgt48DvIWLDZMD?=
 =?us-ascii?Q?usGdZkb8RTb0OM3VAWgm4Ejw9HXhlyBfxcmlV2oq6kMzdFZqCP8hYnbgf+os?=
 =?us-ascii?Q?VRFdKhU1hsPKX2E0TPpx5p11zbYa4BxfwMYWnkfs+1+W++q3ff/7TPbb5CAf?=
 =?us-ascii?Q?sOnDWFngeafBWxCWXOXVg9ecFc5sm6a9nX/fsg0+CSCSGuPKtq965HvxRsAW?=
 =?us-ascii?Q?CFES/OYajOGkQV3QmqrxbblMQCvJpuhBpEhAWoouvlD9nD0+kdhJQ2yvA5qg?=
 =?us-ascii?Q?yuZz2VVNtvWc0CQyoDYEPo05B1yL9nP/6TAa/R8XDxi7W/YgMuBi3e0l9a/r?=
 =?us-ascii?Q?zHf8PYMES9AhduomgrjKZFUv7LgJ/Oiek0K579S10NYJJH2buYGjLJPCG+E/?=
 =?us-ascii?Q?LpE825Mx5Abmfil30IWAADTAg+njeF2FXsLTScevYeYsqQv9/ppQcKRnaM5o?=
 =?us-ascii?Q?vnZiPL3uPO0fYhgHRf8iHYDnUi42FzOXpAgAhXyFhYVz8rg3iMHqfU/qcs2G?=
 =?us-ascii?Q?Jt7SkVc7efjfCNsZ7iCZ2hetUmmiJsWtuh7nMTzizfk3hFWoEFdpfkodHYLD?=
 =?us-ascii?Q?1BLAwtmcQAZVC+T1+hBN3Ek17nsXq80pjkFqbYlW/OFmiaWBLQa5l+SxaPru?=
 =?us-ascii?Q?nWjcVxTx5QhL+maU4KvfycQfUspyDaLcPswzh7OTdMz+DKkhT+0gFCl+0Ath?=
 =?us-ascii?Q?7H8TuZV3vRDVjUjGd+/6nZz9trZQ6OgvOEPvYMM9kO3Wps4ZLEPNZKqOF9g/?=
 =?us-ascii?Q?/uJYyJlXN3NUHVUWfpW+YJcp8NYed46P/jdBZR0s6kf0/H2n0AuzYuFyEz09?=
 =?us-ascii?Q?Rz/72Dpe9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60585623-d105-42eb-7960-08de8596ef22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:07:23.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUBFlMttlUj7QBakBF0eNEKdMvZvI3CCynu5vM9AJV+yg2Voy6CglvVWkzg7QDXIQcSlTXSnhGVlKDrrpbQEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7677
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227238-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13B5C2C8825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IMX6SX_GPR12_PCIE_TEST_POWERDOWN bit does not control the PCIe
reference clock on i.MX6SX. Instead, it is part of i.MX6SX PCIe core
reset sequence.

Move the IMX6SX_GPR12_PCIE_TEST_POWERDOWN assertion/deassertion into
the core reset functions to properly reflect its purpose. Remove the
.enable_ref_clk callback for i.MX6SX since it was incorrectly
manipulating this bit.

Cc: stable@vger.kernel.org
Fixes: e3c06cd063d6 ("PCI: imx6: Add initial imx6sx support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2 changes:
CC stable tree and collect the Reviewed-by tag.
---
 drivers/pci/controller/dwc/pci-imx6.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a5b8d0b71677..2d01c21b5570 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -663,14 +663,6 @@ static int imx_pcie_attach_pd(struct device *dev)
 	return 0;
 }
 
-static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
-{
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
-			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-	return 0;
-}
-
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	if (enable) {
@@ -784,6 +776,9 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	if (assert)
 		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+	else
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 
 	/* Force PCIe PHY reset */
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
@@ -1883,7 +1878,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.init_phy = imx6sx_pcie_init_phy,
-		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 		.core_reset = imx6sx_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
 	},
-- 
2.37.1


