Return-Path: <stable+bounces-238678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBOAEPeH5WkzlAEAu9opvQ
	(envelope-from <stable+bounces-238678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 03:57:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E64261CE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 03:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE323012EA0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 01:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E53093C1;
	Mon, 20 Apr 2026 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TWKZVlCX"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D70375AB1;
	Mon, 20 Apr 2026 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776650202; cv=fail; b=ksSpGwToEQkMouYVWac7osYDWFDGdijZnSb+kVn2n364oXHsGZaiOxtnJIToqp16vQabilrLCFuOAJbi2ABH9+vbwgo4hhsm1Bxuq04X7DAMW8iTNMTXH3C/+Ro8+fFCTedOEMiYswShe0YSmKYJBxOXiMG18uXdW+ymzwDAMI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776650202; c=relaxed/simple;
	bh=adnAA/N9S9pso7DenOFzu0jWsfIa/30Py3z+zUdHEuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=garZIMO4thPoNnGp+3K/i0rwPV3ZFtjK/GmyWKoduA6vGD6V9CiJxvECQ8V4JAzTKuXZ/tzJ8Bsb7ddzRo070Xo0D2OBKal/B3WI6FD5DzLRVzXtLlIgVUpXPbd9BI0kOFmDk+u/7vSlHw7E9IfKn+YyhotD5QnWiEkG2odRGoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TWKZVlCX; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeXc3hAPcNKho+JHqJDkcLJc1kHEDlfV8V66kBLXlSzaUgn5ePFqgPaH7y4wgM6xB1EjTNtHIJCFWbRTaZevsrTu0drz8MC5B+in7TbDh0rNrmDTRDs7si8x5cwemHrm8GfBSNcDDiCtetiSaqmOUBe6nWVnOjz21dC8NkVZI0iOo7BNSF6EDu6KM1gYCkoK7Lv0I+MRYaZdCyr0a0IdlrOszr2IrT9h3lfpjielR1E1APdDmiJPHX9maBv79ArYrOTYNu84vKeieK3RcfMT9gYeqt7ACo2j53BHAqQiun+BchCnJ6mYyFYLyQTHZJ1GHqOZo/k7wd+ja1rIz8rvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXgX1cb7HFOza2Phl/z6KFIgww4qrHeWNXpzbwli55k=;
 b=DEpCUvAhVl4ljHaCsZU3PssU+stndPZHWaRhCfIqWUGmeCYN32S460jnOVa0bZmugPJMWOnSh1aN+HxkcXOf8FGZ+7rf2McdlG2nFd9JajmxK5l3Zpar8Epk1vFq24oVGGR7SJhlmCJ6of6QwaTxqCBf9PuRzUstaekUZk5BMN9BBxwTzZzCz1LhH/ZAl9uMVb8X59ruJ+CVQirLNJUvcOA2WC0HNpk5wAdfnTk90vFUzSY3/xOhXuunrGhJx8yNWosamQJAl3GfFsMgm63wbdcVxUt+pYWVdhRFNXZVeLEWnvlN4wcJ0BgdjD4V3mJD9yvD5c7r4XYGz0/a9IYiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXgX1cb7HFOza2Phl/z6KFIgww4qrHeWNXpzbwli55k=;
 b=TWKZVlCXtIZY0fyXqHEEtkUnr5/NkjMDD2d61nwlhHsqTx/f5DlH4qG0o9n4ixglSf1uyHYa+qFxcqSScCME8J04jYWNDXUYe2EKGkClYmTMho7AbUAq+0wnCXiM6GQ8TTiHSOw/Z2rRr5Vc4ikEdjqWVn0kEJ6HezyReqYBtb08SULRNYe5HXbk0bxzySLlqygV5PMw1XhDCNMuaqUGkYY9sCt6UqaP+29oM40jIsZ2zZJD5JyTs/CsCQTYui4xfIEhoWrEdC9hQk6w58A/ahkK5dL6ilkTFWgluZ6IZixrEbNn6yKPeeBQE7EWs2CiistG2f17bx1XZkqEMU4zBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7219.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 01:56:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 01:56:37 +0000
Date: Sun, 19 Apr 2026 21:56:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on
 ERR_PTR()
Message-ID: <aeWHyhp43ZbgXwFe@lizhi-Precision-Tower-5810>
References: <20260419122134.97529-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419122134.97529-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0657e5e6-ad3d-4b8c-b824-08de9e800ea5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 rIAmofEdLahYNu3x58S3BO95PGpYug7vH0rCX44CYDHW/hjyORVhyw8irA4i8nsMlaQO55eYgp8yrWsQHrL81QNBwIXxXzFN3+0Gxe7omXMwInOSquU4/TKdO++jFuIst1dyDpwd5Zu5TU7PovnAnvRPH6diaUyH/3oi5tJHyP1D44k7CXZfhdc652inPtS5lzMe2wY281+bFcQ9NlfDsh2g/9RitlPgOl4jDDnJ/exK0zr+8p8xXt4o7uRaDRFvPBC4NooPG8D4+GKTF6Dsu7R/njRQtcTL0kXGjiSblHDNEGDTW0s28qY6UTUyTnZvSKLmpZmnqyAspyh/Qn5mS7EAJt3xoM68e3BKYPyCYwZ+x0hboQqjXRR0Muuq8qpIqouznwfjyj+HxW3m15GI0EJJUMoT3lh3Xtj8kaA6HzBv/HyF7/UwSGZYHzjJQJrFBERZkWz/yR2Z5bacP2NZXdQgungoz7P41U2W3qCn9B0QbBNJty5emQUuwoeXOl+Nu0IReUA2f/U5ZruV98c/Iw0iVaALxW++z2AtUfvoHGwq+Ce/UEwbcvh/1Gi51cTNp3l9h/o0+YmZafShmI/XxAgd348gRlhaTuh21MmCN1GixGUnPrgl7kiOi+3cvSfaVK5+XWshNzP9/tjibAOMntOfr3n4uVPCLc16rtmhDzdLJD1GB/SUOGRtogtKrgZpwN3gdpGT7K2tdvhFXYXcco9gRfNI++fEA+wLL+4S9o/pibYIwpiF1e3RbwrhNW1qrveFCx423Sc7Lpw3a4Fieqia9rYh9yasdtJO9AgCBSQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?bbdGQ9RSADrwoU4umDg2HZ/wikb7eQ+zVDilujPvUZ6WyJVskGehTE1IkezE?=
 =?us-ascii?Q?oLQZAH5tVM4iA5DXGzZ11eJaY03zyrPKRmf7xTlIhRmtFiEUvZCEdZmwObY8?=
 =?us-ascii?Q?wSBOpbe12unfEOKv8CxvlDd+LXVcx5YR0QYGfptLJmZ9OoYyWbm8Q8uppXbJ?=
 =?us-ascii?Q?I9avoHzPGQLDLawJZgXl7r6yAxmQowAH9RydC0JZEqtOJIUuHKWGLighvnqN?=
 =?us-ascii?Q?4DSDorTnSLRc/0bc+5M9qG0Mrm6zEHXp2OyVzp8q7Ldkv/tE1KlvFgvyd04d?=
 =?us-ascii?Q?CIPkkfta5+rBC3JwRXvNAseLK4SRgGXQP9xR7vdyHYvaP5mHzMxgFOIOrkXO?=
 =?us-ascii?Q?RdWSENT/epsyN1LK4Ue7GZ9NMPsC0Mpdd+o0DP7Yzsxx2SN7ZqF4ulB5EBSW?=
 =?us-ascii?Q?zuSegER+5E/503zV62Hr1l5MqbUN5lMTf4x9FVL/fZORPj9hKGVKmr3qq3bf?=
 =?us-ascii?Q?OBoYwx+xfS5nRWu8ZODXhOHAJAjHeVBMSFvt9u5LzMZOiptKTEjCydEo64GB?=
 =?us-ascii?Q?WDOqtC6x1u0sLJ5mOwhQK+K7/TRH0VQTObWfcEpc7wS36s7QNl5i5NGHm7ds?=
 =?us-ascii?Q?s4McVRKYRYo29WKf/pF9RJvYJ8sBpCzKkNi2gUo8BlQebedW84PhbSK/N5o7?=
 =?us-ascii?Q?3jPhwxBK++LG66nZZgnZJEFQwbOuEmuHUd1NGK5uE216bhAeUBGLTLw37meU?=
 =?us-ascii?Q?l8ybczNWjxy8Gsx2c9JNaLDJuwem6qtaZcotfdvISjL9pOgsoHm1zecL47b9?=
 =?us-ascii?Q?kbrMcCFQjmJVHEjh/9910WSDJ3AbQZzrfAl6sCyTWw59gnCkbmwSGsQgdgYw?=
 =?us-ascii?Q?czXPOoOJd7YDEF9vcOn6QX4E2xFrWUYJcmYUqWkdMHHcEoqL/mmR078eschq?=
 =?us-ascii?Q?22pLyVixXUpT/0m+vgbbDdQuBH7V62Hgg2XJ5aO+v+Dpf9AlX/H4tj0wuhbK?=
 =?us-ascii?Q?CgkrPfzRG6/f4KDsM2uoSJncv5eb5tOkg7VBoFox7WYui686HiEWUrJMWgl9?=
 =?us-ascii?Q?fQ7EFprUDWU1/w2KvOjGawdIuzidUBRx4GfGEMuilR4bstG+jPMj+UKOBEEo?=
 =?us-ascii?Q?K/uIMc2Ha+ZSCK3KVscTtrxK7NxwXggVOnbeCQ/ef2S/2p5QH2FkGZBKg7na?=
 =?us-ascii?Q?lZF366x66pIOiTOhPH/3a20Xc1Iwt1iHZ9qLhIQB7L1b6TCVfEmgK54TSaU6?=
 =?us-ascii?Q?RPNiPMPR8FhnhiHny6U1c3c8SFD06Jk017EtIB8oaBmm7rncfz5vN6psbsQE?=
 =?us-ascii?Q?nCJTDHjVme4vqMDYhtuUY4d13QvFQ96WCk8s/91pBxOZWi9E2xkJg2cwd+X+?=
 =?us-ascii?Q?l0Rqh9WPdaVpqhocOLBIJnCbz1TyoafjHCUYZ1vsw+QWn14Xfb6aeefowGfF?=
 =?us-ascii?Q?S5Itmv8eACUOgSrCyjbKc4G38UkQ61+89PTmhj0BiIZO/wzan/YAzP79+tma?=
 =?us-ascii?Q?wqqrLhKyq0/DgVKEtf4v/24CE6V5zom6LPD1R9n1nmunIF9VK0NxjeANBQ5k?=
 =?us-ascii?Q?BNbQPtSXQ3SqXLByF/Oml7FH/L3BdvIzsvCw4hw2Wpnkh8FChGM0/2B5r59Z?=
 =?us-ascii?Q?L03eWWPeoELsjDL9jenTQHpPqzR5vRG3MXWmIyW9HrUvAuxKeD8ZTsylAcWI?=
 =?us-ascii?Q?6R4gCfchu8YkJafIC2MsXqyjg6DBq5JP/Bs0D5+QAxAQfI9bXPjHCknXrGU0?=
 =?us-ascii?Q?+3EGjbrudZTCn/VB2/shwAwxXCD/VmYhPhd7rtLFHCrmKM4q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0657e5e6-ad3d-4b8c-b824-08de9e800ea5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 01:56:37.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1F7vsasKVws17j4YUPI+ZuhVcnFM3GiTojXIJFaBCzyQQ/HCGPn8bGNaFe0aybEVv6vrQ18wXYNFO5JZ+X2VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7219
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238678-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B30E64261CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 08:21:34PM +0800, Guangshuo Li wrote:
> imx8qxp_pxl2dpi_get_available_ep_from_port() may return ERR_PTR(-ENODEV)
> or ERR_PTR(-EINVAL). imx8qxp_pxl2dpi_find_next_bridge() stores that
> value in a __free(device_node) variable and then immediately checks
> IS_ERR(ep).
>
> On the error path, returning from the function triggers the cleanup
> handler for __free(device_node). Since the device_node cleanup helper
> only checks for NULL before calling of_node_put(), this results in
> of_node_put(ERR_PTR(...)), which may lead to an invalid kobject_put()

Please fix
DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))

If (!IS_ERR(_T))

Frank
> dereference and crash the kernel.
>
> Fix it by avoiding __free(device_node) for the endpoint pointer and
> releasing it explicitly after obtaining the remote port parent.
>
> This issue was found by a custom static analysis tool.
>
> Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> index 441fd32dc91c..3610ca94a8e6 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> @@ -264,12 +264,15 @@ imx8qxp_pxl2dpi_get_available_ep_from_port(struct imx8qxp_pxl2dpi *p2d,
>
>  static int imx8qxp_pxl2dpi_find_next_bridge(struct imx8qxp_pxl2dpi *p2d)
>  {
> -	struct device_node *ep __free(device_node) =
> -		imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
> +	struct device_node *ep;
> +
> +	ep = imx8qxp_pxl2dpi_get_available_ep_from_port(p2d, 1);
>  	if (IS_ERR(ep))
>  		return PTR_ERR(ep);
>
>  	struct device_node *remote __free(device_node) = of_graph_get_remote_port_parent(ep);
> +	of_node_put(ep);
> +
>  	if (!remote || !of_device_is_available(remote)) {
>  		DRM_DEV_ERROR(p2d->dev, "no available remote\n");
>  		return -ENODEV;
> --
> 2.43.0
>

