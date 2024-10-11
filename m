Return-Path: <stable+bounces-83453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6599A53D
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 15:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B137F288E3C
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0D804;
	Fri, 11 Oct 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="I+80+Ez2"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2139.outbound.protection.outlook.com [40.107.103.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD71D52B
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653868; cv=fail; b=E/zAfwApJbByOHLeSduinvL1yx0m+cdWztkT4uxulxo6N350M324zelbh4N/G7yZf3A5f2p2LHssOQHR5EtxPB7+UkgG9sXs1XWKy1Wczdtwbld7sNwMeYOg7DhZs05EVrkfWEXTDFoKUVNHkeBkYx75KQ1hXxW+bwrV3JtRPCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653868; c=relaxed/simple;
	bh=mW3vv3n2GMbKLG/rwpkwKQV3RLj0GlxGpxIxMwucUaM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z1S0xUPVnduwT3aJ0wjnv1B80goLuHnlxqM0Z0bufS5uQzGn4mE5Ot3WINe4uVDD//AwaJ8izbHXGwgAlq+vcZFiJjYYKjS2UpcM6PkOvMAuhDBCEsOm20ClYQ/ndkl9oWe+6XSWcTSuFz8wAirivTn+ymJEn3EP/kDf7ZEM9Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=I+80+Ez2; arc=fail smtp.client-ip=40.107.103.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB9Zl0i/T8Ewjgep8ElV//iiMQo+VlPuzFVzXd5eKtMuIXpcGTxNaBv3x/uoMTP7fUp/HQqx58U5nMgUmUC1JXdQ2ITCW7C2p3M2NHxhGTX5EXAJCiDZCvBkhfrM9KkhcFPSZkEi9yKAa6UeBgACXffToGqguslB4ElKoPBEzqffrE/P3AJURE3Vchvi0DVx0xIFOKM4rtNB4HPthrLBZkJDSCtX6gHCIUA+G6CeXyShqNb3txhYPVujUBHjuzMBN9TvZZeSC88JUvBf5gVnny1h5/TvBuEgf8vndVlQWshKaG0wwA10ctKmkSWfYRrVZJYO7IJrmOU786HkquV54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUneT3dupbsZT4w7VhzBSuDi98nMfEbi81ynfWO6AaI=;
 b=JBiO6V/Qq40FYFHOnHD0fvyEU3vz0T/us68n1wF0lnnPwXLhaJWTE/EAuFV8Hi0jKfTz8/5TJ7+vfLJq5llIUjLX4aTw2qIeKT+fhWypeduscOb9AW8h336WjDetcD8eQgjT79kMuUaf4ub/9XIo+AE8uUV2i171ax5qVWvlNK6jd1x8LxW3cVaCJRy+scQVTRgs0n/YBEvgyXCe5nG2njPxsfy0Niz/q3tCdnk99XQg+Y/CJ3vdxnbBz9IZ+aMyzn5dP/4Vd3jNp7UX1mcPCuOIwboNEzZU2H5VG3xl1lKZ08/cEzNHAFTb1oXnfQMBsRIYShWU3FeFwxtEaoff+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUneT3dupbsZT4w7VhzBSuDi98nMfEbi81ynfWO6AaI=;
 b=I+80+Ez21imqwHn9m4BbXnhOKCT+7w7jCCoDxrZbGwF6PB/nL6nnAUHU35Fc04mw+DpZE1BTQ06l1L0ZfWqC9fX+xEJHr6DccS5xQAJtYtFxYPnj0IdvY5GNMaq8qZtlfRbTnb+moDIpMnggaypTCH20B0rMTRocSTFG5QQsC8BnBWbHyDwd2AVsONJaP+Mvx0gbZ3uRQi02vsIckGks3eTnZrZavwHATZHHACOuR7TOGgG9NGUKgTAFWY0eRqSVLbc9U1ZlgSYDrlu73UXVTCg/m7V+9xwTczXLbPirQl+4iEDJS9Y4SabMOrk+C0F8cSBUolg8zY/aCmumrpXIDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by PR3P192MB0812.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 13:37:39 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 13:37:39 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v5.4-v4.19] CDC-NCM: avoid overflow in sanity checking
Date: Fri, 11 Oct 2024 15:37:16 +0200
Message-ID: <20241011133716.32015-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::24) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|PR3P192MB0812:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d92615-8c7c-4416-281c-08dce9f9dfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOCov/Z5AxnHFl/Imk4efyvncXmxckAIeWijCf9VlNT/uZel49rnqq/s8gwV?=
 =?us-ascii?Q?cQQEaW4vekhQKJVsdcsMYjtPbEoT58CK8WbKNHeMA9LswkVxaQw0maBLLAML?=
 =?us-ascii?Q?dgNzsC5RkkmwD/rscmNT8R7H4vUx6ecsUtJBSp+ySuiQgKW51P7PemAtYraN?=
 =?us-ascii?Q?ypgkQuyTvNaZYWRxvN2sKnoW1tbQOlQ7PKUDhOtS/hK2EWxXylkcSN9X0Ekb?=
 =?us-ascii?Q?kqOpIzBjnHTq7VmodeuTDVeYRbC8aLp3dAMVxKlqDb4U0GgpTwVdAMqH8SfT?=
 =?us-ascii?Q?CgJvcTHywe9WA8ljOsfqiAGaTHS8clR/v/TWPFBjfRlhfpAYml3Maz3ALNVy?=
 =?us-ascii?Q?RJKo7Yg+vkfIRuAi4whjR42mTAeOi1huM33+oBg3IWH8uu/LPHhlKQijo+/j?=
 =?us-ascii?Q?jt7+y6F+L30GHvhy2oWcxU+ryxw0hLtqkuTo5vCi8KFsOSrJ5x9sAvtv7dQv?=
 =?us-ascii?Q?Ca8fxO1GuklHWn6eSXfSkimxD5cWDOSDCi/FdH20tSNX/UaUIrmS7+Jm70c3?=
 =?us-ascii?Q?2BA9HouQCDYlM0R4Ln0AP97wqBWf0xmr/1CaCi/sa8FhCemdz5LVjxwObWLU?=
 =?us-ascii?Q?lURGRuHXEnU3tV9J3kIWwgK/zNP/aoceQT1INdi4ZEg18ZIT96xRkV3SorQP?=
 =?us-ascii?Q?SAmw4aQxT4dI28wh2LJdopAr5v9HdDWQ2UA/MVf0GpQ5ki2d/w2iwhqTbkTC?=
 =?us-ascii?Q?dsKiGMALsM7V8GmGz4/uXnSsDgjCP/Urqz5V/F1UsVK2kYvUzrZOIWQSMrah?=
 =?us-ascii?Q?YA6fiHgB/BLHqGTB558Zhir9sDIRziba9yA63bH3jdpY59zLyR/KSIEKaCBi?=
 =?us-ascii?Q?bNTWFqZq2OgbBsFsXbBaOpzmy8QopFQDk7aJwPuDHNkAWqfv0Xw5Inpe6Dbr?=
 =?us-ascii?Q?CR4jY4iqLfQwq+OQWOeC2WxNguyim1vBhzEqMeKAjgiHbpMfOaXJJ3oVGxHh?=
 =?us-ascii?Q?sLxwG1Hp31KdyAg+JFmmoP7D7UOJPxPoiOYUOD7D5CbzNe0WFDeXGxahKl1l?=
 =?us-ascii?Q?y9AGdZGo3PDk8DwlxPA0JeGHV/V2gD3B9iOVL9C10/dREXnnpZfjUBE8kVDI?=
 =?us-ascii?Q?Yktq8QdNfRlyFKrC9Omk7J3LpjLcIWJ+9KpB0TJl9Al65ZChswo7TXAjACHT?=
 =?us-ascii?Q?Po3sf0c1Z+macPMNqL72ry5v38ATK8/G7TpouaGZtdhKqRJHBIdPgS9brLc9?=
 =?us-ascii?Q?zDM50VgBb74C14pbwqTesCPQiLGp/mEQjDH00//zyAvruK32HV5I3qzKtzyA?=
 =?us-ascii?Q?E2sYRyRCE+DZzJrAX5N19UN+zqmdcW3T2nVHOt7oOo+D2JOo2v5W9GNRiKvJ?=
 =?us-ascii?Q?5Flx+McG1fFaDxZkMQ3q/LrUp/MXWn5j3GZy/xMeuwGdfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lVf9DkSU301ZhGKev3M37UwC9JdfAozLbTFytHVq6BGOHzR0rqG8LvVN2rkZ?=
 =?us-ascii?Q?uHc2JTJbHnEXsSRBVFXMndfeqqq79whgM/VMTrO9/MNE/Ib5lWnQmiKCz3MS?=
 =?us-ascii?Q?X96BVx2JqV2jl/zbUPmkTcwD6o8FdpreEOv3GWLtqlNXhmSPX7wmpIsLDGjF?=
 =?us-ascii?Q?Zmr8eHuj6R28RgR0KUVlJ2TVvajZQVp0fL7yz5dugybHvYUHMzSrnPxUCZ2/?=
 =?us-ascii?Q?ZwCNjMm0t5ZwGBInLeL4aosJ2NzRkz6vUth7xwfgYjBy+CBbvnCEpgjK6fvZ?=
 =?us-ascii?Q?axkVojYxyrvFgCgRpnqPJds/HD361/7EeOkjZWjWHBdl31+cth6lhLJQke9/?=
 =?us-ascii?Q?wgEA4/M7tNN3POjE5aChorZ9K6ej9qIL+X9zRfei0xc+MCk0UER3aO3aTrDk?=
 =?us-ascii?Q?iYoH+zjHBdnC1X7sxk7oOZES0T0Q/4WObQc15BgGEloPGomX2oSfdQkAaekN?=
 =?us-ascii?Q?r1m5cBlYG+t5APm75TkykLmpP+kD94a6/+1kVBOhmxyturcnGR+rtKEnf3eJ?=
 =?us-ascii?Q?YN28rkIrhJgVUu6JXh8FfcJ1KCHfKAz04k2VljkZdpfi6yeLLRJCfyF9VEHp?=
 =?us-ascii?Q?/bsm3305amH8Z19kqlsv4tKxq3jOrgeJQuwVUoQ6cmIhvjqcWz4Q1+bTiFZD?=
 =?us-ascii?Q?AfvJWdIRlDgLzJnDz61KSFH1Z/ZTN7P4mFgm7ayGhyvfLv3mnFQM1TJgPSEn?=
 =?us-ascii?Q?aqirsJXjCTrNAagycU3vuxMAKF1xiOi9MhCSW2pWuvIZuP/NSEBkDV8EtKgw?=
 =?us-ascii?Q?bGxNbWLFUpZKARNSufbL3vohwu1S09MVopu+CnQuRN0N7DcHunr5paoNjNR0?=
 =?us-ascii?Q?vFP3BhePxkOdvz9lgI8ljhjCfFuU4XPAPyWTsixTlDHNofgR4Tc3AJtl7BR+?=
 =?us-ascii?Q?a/WWGE0No67Exgc3W75FD1Atg+4ZYZfy8XZ6ynWa0/tDo9uyOqtKO0HzOuA4?=
 =?us-ascii?Q?cDL2U3a76a6O0M8W7gi3WGyLXcPU4gu5yLoVx4/Xcc0MGfLYnXMEq1mJ7nMY?=
 =?us-ascii?Q?vQMGhw6CEhJZCG5Cu9jOpLc4MCPZrBVE2nk8xoVhAYPbndb2ONurmyNrIjc9?=
 =?us-ascii?Q?rJWKHtajiptqhIvSK9Zwtu5wOPuonBfzBEi0WgJwVEbIULkeBjHxiPACAZLZ?=
 =?us-ascii?Q?r98HvGP9nY/MQYgIia5iFWl2a29WSpbDix2zi5WqoS12h0GVD9c7PbFv5Dnw?=
 =?us-ascii?Q?EJ7C836oXQzU5/d4hFV0iYYXjtTZ8L1Ktx4wD1BTA95narEPQjmeDd/L2eIy?=
 =?us-ascii?Q?O11ONFwpLR8XnqEaqLo1xQb2n+t8mIBV3wLmlXEMA9n60Ga+3vkyBVOiGkTR?=
 =?us-ascii?Q?/oUXrw2gDxs0pI3VYGdlbu0kGTlLMbT2hQAae87vSSqiZLw8BmWSW4VLsWBN?=
 =?us-ascii?Q?0GGw0mfsbgTYgHlNXv0SGwlkG3w63FFEaqcFLGFj8rp3pKKp7MM8jPYmoYwE?=
 =?us-ascii?Q?/ZGFub+odRmKovBdEtufPeIEOI/UGYzCiZ5BqZtaECVvJGkFHa0L9MAccLTw?=
 =?us-ascii?Q?qebt+Eyl2ZupuAEDwrjo4QNA6eMDpUzLAwezc9hVUvUaBFruxfrLAn9lZ88K?=
 =?us-ascii?Q?uo2CBscaJ5Xu/TuyR/0HGx3wr9GYKHghiXT+9DYFjgz6brCSl2PYKsBZojdU?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d92615-8c7c-4416-281c-08dce9f9dfe9
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 13:37:39.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwNK6+JB2zJqVvan0j6IeABAPnhE+BQEN//poxsiE10+GwIRbHIVdAzzZ3rLu6H//oedzozIwI7bmWpDNsLRNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0812

From: Oliver Neukum <oneukum@suse.com>

commit 8d2b1a1ec9f559d30b724877da4ce592edc41fdc upstream.

A broken device may give an extreme offset like 0xFFF0
and a reasonable length for a fragment. In the sanity
check as formulated now, this will create an integer
overflow, defeating the sanity check. Both offset
and offset + len need to be checked in such a manner
that no overflow can occur.
And those quantities should be unsigned.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/net/usb/cdc_ncm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 65dac36d8d4f..64d83f7905d0 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1708,10 +1708,10 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
-	int len;
+	unsigned int len;
 	int nframes;
 	int x;
-	int offset;
+	unsigned int offset;
 	union {
 		struct usb_cdc_ncm_ndp16 *ndp16;
 		struct usb_cdc_ncm_ndp32 *ndp32;
@@ -1783,8 +1783,8 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 			break;
 		}
 
-		/* sanity checking */
-		if (((offset + len) > skb_in->len) ||
+		/* sanity checking - watch out for integer wrap*/
+		if ((offset > skb_in->len) || (len > skb_in->len - offset) ||
 				(len > ctx->rx_max) || (len < ETH_HLEN)) {
 			netif_dbg(dev, rx_err, dev->net,
 				  "invalid frame detected (ignored) offset[%u]=%u, length=%u, skb=%p\n",
-- 
2.43.0


