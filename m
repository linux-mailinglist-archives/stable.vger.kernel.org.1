Return-Path: <stable+bounces-244360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKPGOH0P+2kTWAMAu9opvQ
	(envelope-from <stable+bounces-244360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:53:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 728484D8F86
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7742300CCBC
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874E3EBF02;
	Wed,  6 May 2026 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEUl9OkI"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313793E274C;
	Wed,  6 May 2026 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060969; cv=fail; b=q/r3KaCwF2Yd4e3tuEFUKF9ry2Bv5iQ1D71/5Bg7C9LSonLiHPNdrq7Li1ZTUnRppdFyLBRXoq1DxrONx3R12BPFZCDe7HebZNSUdPle8E2HlmqPA9uzPsiaZ1ggPkAN4z8N81+m3U1ddhaRaQWt7JuSbQO/aRMTucSIdRRAAm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060969; c=relaxed/simple;
	bh=qyGkogNrMB3XxIXCoVQUcN+eBAiWHmLyp0xtrw3GDnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPmM+PmXgT9yE7n+uK0pFW1vR0+AXylDoy6kA24sDBEKltMD2KRhQxBKSHbX4ESjK9Wj7h8thrRtvCWR552qsQLxHbkWGcxXOVLu/aTXCxMCihCbENaLCUG4Iwrm44pc/KnQimj7s/OGCUR+JYXIGaKSOhSeTaOi7GKx2EE3tsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PEUl9OkI; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBrFDlcGroBPV5Pd9OlmU4LlD70/BZI18BAIOkK7XNMu2azDI93JukBmERYfr7tskcBawhU6x05Cd4T32j3yxnRWQSdFhtUN8VPLwrrVsHLQunDg6DNkYA8k3eY/ZGSddeM6moY3jHG7B8sxsW8FQPKAFOSuLasfWdMvXwlB27Q6S1VmpO3t3jXOSA83T2ZHGnoiaw9QJpOwrdljniOGu1QENJ+yvT8nZJ9Q2uFcrOkBypsk4Ejv7Lqka26gcqWfyn4g4WoZyCN4/FPeshEto4jQuyhzUx+RwtwH0JpteRkkVnu8aPg9Dz3NQcgyh1dAj/mt1NGSBdAQDkrniipGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbT7eYbrTDkqK9kwna8h+8xmULvqe7kKh4+/p/UJgQw=;
 b=TCEDm19ctBr5dV3YvX8KdAnuB9UQ7qxNJKiG+mvKznE4Vj4gDE0KQfIFYilr1v3ZvLIr6J86DFJoFKkVh8cIShjajqcveSnyS9s2wZENIYWybvspzL7AMEbfJ9ZrRU4FVXjpXIeCo+OB/kA3UPX60+BGpGG7W6WOGWjBMfDqCszQzJlyfWmUyPpyKavXd85C4GwHPSzVx0u9ACxCZThoRLMHqC7htDWfmSj14rhDzrihPBrteNrLPbG2rBhT1Iz1KX7vj9AaQc3QWqkesBRyiuNwNUNRLgVlTMEgzehd2KMMF+9suKU3Hk00pIZOUZcJHc8VTN/SOVs7Jwu4WcOTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbT7eYbrTDkqK9kwna8h+8xmULvqe7kKh4+/p/UJgQw=;
 b=PEUl9OkIt6bR05bUC0eYbaDOALYTv8s0SKIPu/nKsyu5bGHzS+klIckpmHiaCD/Vi0GlzrTv719nOG25f59SiRVKYK7OSPApHZ2nY/mQiRa0rnClyiZyeeRZ6Tdmtb6J1y4472x/1EfaQBk+EzDoFN/rKx0ToEA0Pv/RI2q3Myvdq8JDkSLde7IY3yWBrUMMJY970rWHJjbuy4pIR7lQlBO/bfxPkfVq47teO6vRrIYEMPnKd7fUqmoy8UulXZlYRABtH8OEWrNV0e2FcelZvGjtUNSz6ehoTr2/ZhelsYzMNeIMxh89j43u1jaU3E7GtZLNJSdQ6XiJShwPrMTu9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DU4PR04MB11815.eurprd04.prod.outlook.com (2603:10a6:10:622::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 09:49:23 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:49:23 +0000
Date: Wed, 6 May 2026 17:50:45 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Message-ID: <afsO9TxVuz79FFQ0@raspi>
References: <20260506092324.635014-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506092324.635014-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DU4PR04MB11815:EE_
X-MS-Office365-Filtering-Correlation-Id: 63204cf3-1fba-4d8d-3890-08deab54c07e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 IGOgOCA5+G2jn9CQptqTkpAneC28Llnr+D4yJxsfIvxZdtmX0XKPdxhXHTrvZ5aK+glsUdlYTY7oBFRr60FzBn5yDU0SzqHLZxTavH4gjv638GetS2AHYexIt+G0o8suAcN5dAES500uFQrKi2FvOrhedumfxpcorGbk7lDi1P9vEiYV3G/AC23lSO24HU7rBpVI0zYxlw1B1xLe3lp5SD9+n7A1NscHB2dh1X7NmeQHH4XYV4wTOlRROvOrlkdBypzv1EUDqEEDg8TdMT84cnhBeVsVGSfLY7r777PRBFdP/AnEBKHdlcGAlVY5hazR0luSf3HPM8bfffv17ovKyALvAoKLqreys2AfSG5f12MA/Dkrx6e3l7WO8+3FhA6QypJOVF3bDj5UGNOnAK6zkkze6soYjXEv0tFGfkCj/8bvGaOyUHJ2Eb8E1soQaLHS4flQfDxeubxMpR/NpUcLRLQWQxP8utmIWc2gSbFh5nm75rUCzSlnjTQTUJJ10Hmo30wxxHEo+WD/8iGr84vauJaQoo88lmNq0t9dHmRzHU4cTsLYXuxiGEsd88RxUHpDQCDyUDTFhI3LKR8j40ytGtBj/MpuCRfObO/PgwNF1DDAfgNUzl0xqajwdXG2yfXRqqLhwqLuKGlQgqiBIlpWYgvlTQAD928NvKpOr9tuPIi2ylBYaiOc5d3LnOLKpBfq
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?h/rDrF/2EFkaT/kQWfQEL05gWmp3LaEbrukUmvvYFodny7Z3I1kBd4yugWAE?=
 =?us-ascii?Q?+mrRPuzIl0fe+HJxEWg75IiUAH9h0azuXrtXgflF9tkWRE8SMnEZYnrIa9tm?=
 =?us-ascii?Q?4Oh6XWLrsJB9D9hq/OBMTYop5v46OxlSixHGP5HDfeLenIiu+ZJVs88ENfzd?=
 =?us-ascii?Q?HYoMRXH3VCP1auk4/ZOoSFzx4CTvI7oM8CSDwZWhlxnENGm/ad3JkARzkQYY?=
 =?us-ascii?Q?hvNTmNrh2MMSd9Tri/ONrFwdztyavFKh02JTqo6vlPfq/x+ozHrGsHfEG460?=
 =?us-ascii?Q?R3oOgSDo+RwT+3o59HQQ3RVmW89PqhQZt+XrZpDMPfRgQ8DjflbF25Mrf7/J?=
 =?us-ascii?Q?SOlRwdQuSdrfxhgMQxnr/KoPJ48wB0OYNW/XBmtvAXgWOoEIuGYrIngGMZ2N?=
 =?us-ascii?Q?TIXR5s14JvsA4W6CM5MQqTtC1aaZJQ/sobVOzz2dkJXiAntH9GAY3qyafs2r?=
 =?us-ascii?Q?zhQY+ohtfuHsdGH6w7s19OvpacSyAyVwN5RTAaLQrP5hcojl1RbLHjZnKD0w?=
 =?us-ascii?Q?KWPMFc0tj3yqtg+9/OP7C3cYfK/oDLf7s5sEoQ1IKq0mtTc35zm7nEZrYRD8?=
 =?us-ascii?Q?wyZljbMWLp4PqCRyFe9G87FlV6pFguJX48j16Z+6RzfVGv1ToY80+T1X26y1?=
 =?us-ascii?Q?9deY6yPOAd/wmceFqoJ5cEQ8Yqy7itz+oSzOw45Yma/T1FQekdFGdP+sgts7?=
 =?us-ascii?Q?1aaIUTy0WFzEHGW4l3lAcCUXIsWe88upjgET0GaKxR2RUq+FhgT5+2w4tAvk?=
 =?us-ascii?Q?mmWCpN90/DnOeoer4tPvv5qx8mMHnMUF6brt2y12p+O9KZTcWK6s/ht+/zVq?=
 =?us-ascii?Q?60IIFlDZkvrBqoNwopeQaYFVt/sUkmZFs204cCavO3hzunzIuIoJeoBo0XOH?=
 =?us-ascii?Q?ch4oal8PO3JcsbVOBH1gllPNtBD4E7+8w4rbRdf4JmFOFU/P6U1xRK4POGJL?=
 =?us-ascii?Q?ezLNDYuP0CXzd0Usgf9gnBrDv/0vfEBl1Dvz3K/fC07ctk8U6CFtQA97gm8G?=
 =?us-ascii?Q?6dpZs5lgnQF1gLDf1WQP1qbLSGWZQFnrPmWjQlUb8Cv0+oYypphvzLKPZS2W?=
 =?us-ascii?Q?5n036idHn9pE0mM2W3C0gFGkdIXiRfiY3AZct1GFmiTpMPqJe+pKI23EcXF6?=
 =?us-ascii?Q?A+s7aDDy2S96kdHRuzVxXggAdgjrE1k3EGye2ab9uA3xAGaXzV0eMbjsbPOx?=
 =?us-ascii?Q?N6tVZPrLs2ORE3FBw7onsBmY/XYLGdXdFTllornnvOT0hDn/SqYb7qOmZ+AU?=
 =?us-ascii?Q?47QrFd0YhgU16OuRWdLukptbDx4T4YpVrRf9VH3WsUEo/HGralUOqmwdp2nh?=
 =?us-ascii?Q?3MYQIm/ks9+8nrXJnlRdg3EKGDb9VD136rAzIbiC9aKhUF/0H+qZv6uPXIxj?=
 =?us-ascii?Q?r1j9Lku28zSwn0L1KPYC7hoqrZAvOEZtKaX2oSUuHHO+5sCdDsIv/+xXCG1e?=
 =?us-ascii?Q?4xadFkUhanLPQYcVbYIpFn7N5IKkyY5jI622qa7nPSPj0JdrMRF11KBIt5he?=
 =?us-ascii?Q?Dp901aCxtDoZ2cyWjabiQWWNf3cSJYp3Dy2fjwxVcFabWAJ7ap7e8cJH29M4?=
 =?us-ascii?Q?11xK/5z0Rdpv9JivV8JmY7sbNj2gn2ZI+Y9f41g3GNh4AI2IHxrajXnP0tc2?=
 =?us-ascii?Q?hteQ2i4T4oK3IlsAOu0gKvenS86flZ2aR7XvQmoF00myErS7tNXg6F7Ys4R0?=
 =?us-ascii?Q?8UoW1nBHKVTxWiS5PKTXZoMD66LjiMzvOAoJYx1/hdFIbTL/h4MU9dImZWz4?=
 =?us-ascii?Q?rBOhiCLGbg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63204cf3-1fba-4d8d-3890-08deab54c07e
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:49:23.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48pWGZ9glEPe37aDJVbY+s3U5mbV/xTxuzko5vqEEJNWnfmJfshLGyZcqGyKBN+u+vsmahK33tQYPgRlfBl5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11815
X-Rspamd-Queue-Id: 728484D8F86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244360-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor.liu@nxp.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,nxp.com,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]

On Wed, May 06, 2026 at 05:23:24PM +0800, Guangshuo Li wrote:
> imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
> on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
> value in a __free(device_node) variable before checking IS_ERR().
> When the function returns on the error path, the cleanup action calls
> of_node_put() on the ERR_PTR() value.
> 
> Do not store the endpoint node in a cleanup variable before checking
> whether it is an error pointer. Use a regular device_node pointer for
> the endpoint node, check it with IS_ERR() first, and release it
> explicitly with of_node_put() after getting the remote port parent.
> 
> This keeps the fix minimal and avoids changing
> imx8qxp_pxl2dpi_get_available_ep_from_port().
> 
> Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v5:
>   - Make the fix minimal for stable by avoiding __free(device_node)
>     for the endpoint node in imx8qxp_pxl2dpi_find_next_bridge().

By "minimal" in v4 comment, I meant not to use __free(device_node)
in imx8qxp_pxl2dpi_get_available_ep_from_port() and
imx8qxp_pxl2dpi_set_pixel_link_sel() - please keep using
__free(device_node) in imx8qxp_pxl2dpi_find_next_bridge().


>   - Keep imx8qxp_pxl2dpi_get_available_ep_from_port() unchanged.

No, please fix imx8qxp_pxl2dpi_get_available_ep_from_port() to make it
return int.

>   - Do not change imx8qxp_pxl2dpi_set_pixel_link_sel().

No, you need to change it.

-- 
Regards,
Liu Ying

