Return-Path: <stable+bounces-192741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F004C40BBE
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 17:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 855AC4F3FE3
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645425B69F;
	Fri,  7 Nov 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYaQJOVo"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003791DA62E;
	Fri,  7 Nov 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531311; cv=fail; b=CtxONe485h46gKk6z/pkcZ8u6paVvD+WjNdji8K9H90oF4s28A8+jJVhr3g1ykZJH1d7/JUlx8gWq7qMO7RSiFNW16tffFXExzXt+uYIB3ngaOifcDVv3sL4ioxsYi7CPJ5FePZAodxMGlKrdznot43trslKid2ccO4V8t209r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531311; c=relaxed/simple;
	bh=BUfGFa+6gpdaM/4QJiq94U8HeNBIGbZKHMjTnTMRYZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oY7+uRpnC4/sxaQuAjc6A0DRGNGQDr8Vr7vhiokigJF1ct019WgY15F7LbvxCdmEvFj6hwOz5tAqUKj+X47vJSXFZ1vbdbPBnZ6gAou9fKcBwjeoXcWMEaRquED+eRPWik+DVDwvu601YlYZ4xPj9Hmkcapa2WMu/5bu62gceds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYaQJOVo; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKjKeYX0iR3txymMbKB3A0aL7c8dcWNC5Y3eGelXn2CNeaZBthWkyZeOfPbMyd6cLmNJS6ZMAmlCC9FmcmfrHBVTc9Ae6P9bDx1buQpr0+lKR6qDGeRjpG0ZcgF4TPxOl/xq7od6SSbudtPqeqTegu+6laaUfBnF0/HBaJFPMM8bZBLoUw+FBtTlsWsc761OBWjbOHFB3k+faD5nrYmtG2kmK928IAZ0lWLL7skkXxiEsHkvg7qNmBYKpTJJn0ap3UK1tZuyODwYdNXKWjV/dVcD7WTLiIFl5016D54LnWriaOxcXiywqw6AYZT7rvQgvfJIpPBOz63fMrvWw5eAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZoJ2hKryKACymwm11YWLeHl+zXO6knEuLiQC8WmJWw=;
 b=B2NXz9Ww7eCgmd6cCOGkpN2BEZ5f+dxk5ElDEyj9gXaalZFjr0TZdV74kAK3sypppARZ/Y9zeZFX1J1E6WwY5R51ZixScK9FufqnyYjvbvRxcWJEBaJksCpS+53K376SRMWFe2AiKDeJsFAUvBI1wt0ywkV4JZ2mRB4BypYFMvLP8NIrobLcpgENfcKGCn5YsMRw0T4laPvUNKlbSEFTeXRr9SHBPunazgX4DONgNuoTcavhHqnl7FHLpDSRVdnIZ/K0dNHzFDWK8e2F/ZeQTd7tRDrZLTHdhb8r61BE34lN5WO87mJT8Xd2dAM+Ubmw0iKovg5ux3bBg7ICQEvVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZoJ2hKryKACymwm11YWLeHl+zXO6knEuLiQC8WmJWw=;
 b=DYaQJOVoxICT+PW9Ou3ZpSgTKhNVB4E4jOVHYFS4Jci+nNUy0LVNxr45loqpSQvWIzmLMiYaA8hekO8yQRxb6vMN/oERKDiI+ELoSFVPbft4x4OkIjZ/ANMYl3cpfNrXUpsAM8UU86Lkih8TQkg6qI/fGKMrxQpxwWZ7Cp94gfU+M/PxmMTPuS3apNV96U8ya9Q18LLQuhrkEnhDTttG+hpuybjBmBkyLDyIJsZe5T948TXczU/iso9nRqq3mxy4ZcIidzQfZq6KYdK34GvHSyPML8KnZH9C4Uq/jNdj+e8RCukZId/QOQGooWxlQbvgG/VjVZmK4NPFcfq0zFj5Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8486.eurprd04.prod.outlook.com (2603:10a6:20b:419::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:01:46 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:01:46 +0000
Date: Fri, 7 Nov 2025 11:01:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Hans Verkuil <hans.verkuil@cisco.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Michael Tretter <michael.tretter@pengutronix.de>
Subject: Re: [PATCH v2 2/2] media: staging: imx: configure src_mux in
 csi_start
Message-ID: <aQ4X4o3CqOI7e0Dm@lizhi-Precision-Tower-5810>
References: <20251107-media-imx-fixes-v2-0-07d949964194@pengutronix.de>
 <20251107-media-imx-fixes-v2-2-07d949964194@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-media-imx-fixes-v2-2-07d949964194@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 8643a627-012e-4947-c236-08de1e16f3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drUsbkql5q2CVpFQa38B8icdbcB1Miu9huvBuNkHeefLRPxtS+x8wwGC+rYY?=
 =?us-ascii?Q?puwDE8y6pg5ATk1Ll4bJhz+J8vTeuL8olN6CoNc10aYlHZspBCTHxBr+eFy0?=
 =?us-ascii?Q?P+Ma1A5FG6WNtsp7nxpd5gBB9iccv+fu7tVNg0McpccTxDTCZsMXb091OpDK?=
 =?us-ascii?Q?+Rj0+27bYhxtWNuK1r06IWkBdkwyIHqJ+Owjq4Ud/GLAycc6vecfu6DLFM+f?=
 =?us-ascii?Q?fHTxP7avvxAT7KSe/v6LS6WcfSjdqptJaewKOMcpCaD0AG2c/Rj9+F1BVGZs?=
 =?us-ascii?Q?ggOQvzzdE1GIg6ClMtASRY2NuqF7zRMtYRW0ob+WRFTsZQ1PCNXA9nM/vYBc?=
 =?us-ascii?Q?qzSetWU/WtlESTo3cNvOgbYnR2MW3ZhZSKTYpiTyZ8ImpSH0x0w5TSXKTpy3?=
 =?us-ascii?Q?+PlLr++XNXjxjmAjkJT8kTq32mlogdKLfT0lnQYGbCgVLE8xZUa0buLbLr98?=
 =?us-ascii?Q?d2lbTY/sNu82k1CY5RrlIW32REjsOAQAIW85wXXv8YjOpL2Kse0ddZ8LPzpe?=
 =?us-ascii?Q?EweBkUU205G9mTMhxCYchUIy8BMcdsk+aYzAORgAh9WK/LsH6+H/tCvhL6m+?=
 =?us-ascii?Q?F64aFcnjwMYeTlpzVsTuXEsHd+VE8rXIoU/o7FCqJWZ4Czy2d9u4mhd92UIK?=
 =?us-ascii?Q?ljwFy2x9AgvVAWqf5pmWcGI+LYPkx7QLSvkHu6xMSscLUfRizdTVLq0xKPIP?=
 =?us-ascii?Q?QkIjT4BDl0WN8WB6IN1Djke9TKgC95sqc3AIcfvx8zGwVljKjuRAE8wc5dB0?=
 =?us-ascii?Q?cWVIR4KXJMJOyQ45QNIQu5NckAcH7R5sscnM/OTjbZfJmsH6Sa9Ka+tnMQ26?=
 =?us-ascii?Q?8OY5sNz43Vvd3WWyxDf8HMKCksQ2sgPl96ltuuLvJfQo59Ib/cL7OEmC40Qw?=
 =?us-ascii?Q?pF2X6iDPtCxRH2LT3938q/qYfB0SjxOFWz2G12pqVFSFgJXSFQBmrIVo2sO3?=
 =?us-ascii?Q?fe//5Zgpp4i8DkXv7j9lWB8NkOqtxlVkc8qSthx4xP7ZlQs3o7yENn+qN6IS?=
 =?us-ascii?Q?OFej3Kax0DF6YWWcHySW4tnnH8ogzlX7efPftLIBUQoyZOwGJ2baqXd21sWK?=
 =?us-ascii?Q?0ePjPWU4p0g2hLOpYDbPJ1VLXOPIGrmHsi4rwiqgGlgehbRiOJgysk8Ifuy0?=
 =?us-ascii?Q?q8Ej9KCLoXh1CR0lKTqz25jwxGarX1DiYjBG/Z4KZp2YwYXdMJ2HNAIDapn+?=
 =?us-ascii?Q?L75Lm5nWuqib3T4ppSRgVAljqBIRXz5Sy+MlxwjOAi763vUyAEBgUQiehcLY?=
 =?us-ascii?Q?KBtTZ0ZxgZfQnFDvUrlotNs4kCFvogp/CDTj7Oejft3rR4sYy/pLPB6DtQ70?=
 =?us-ascii?Q?M9PksXTHYBaJcPaHURIfLTdJQWRn7kEOfSdmpWTiUXpil018IdbOTTLU3epI?=
 =?us-ascii?Q?GI6HduVcAzOXwoiAzGaUhCnIMB50Mjyzk/yKQKpiBVRgwO7CP8ZdkGbkWNbo?=
 =?us-ascii?Q?X/wLsC2dUpRZeUIVc3Iq1aQ8VUBfwSa3t87Ey1rGV/wQqOLGk/5YoGd0LOgo?=
 =?us-ascii?Q?9reYJ7/nUSIZfBCNhmP/c7XXAGKkei5CAFRc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xf4MPUoE1rHT5z9xsxrXvWqc2nw15Oetw37X+vZkfCoI4WIRJ8KzSdjjXAxt?=
 =?us-ascii?Q?mlPkSg12ehwNxVuoYxq8nLkBVFxcIU0ZBZR1qDYZYT85NbUsWIKwSHqDPzoq?=
 =?us-ascii?Q?tndjnxw9vqmUvn/Wpnmk7s3NW1WbtV3bfgaYvA5YqHSNxqFJCPY5MYd0R8sm?=
 =?us-ascii?Q?Eh/tBu6Mp+Ahq2TfCsu7A2Ar7keJjobfbwyn6M72tA3rpUo6nENCpOJeXx7A?=
 =?us-ascii?Q?kLLT8c2IjibcKPm+D3DZY/TMPfh8Z2BEAsUd1jiaqZ5GGxauZe2+KUfXnC1p?=
 =?us-ascii?Q?4kOBPytdFeuLqx/dvZZBbHIe/UDoalFUW+6/8hwolgHzWn0rHickapkMebtu?=
 =?us-ascii?Q?A2vnBS7L0cPE1/57ZbINapfohWdygxve0oXPsnaJUcB0brF/Id5w6AsLp/Df?=
 =?us-ascii?Q?sUxQtHKRfG+3SEJbbhdeARU4AwZsHDHg7Z8RJTzp4vtbzK05CheYkoUpUax0?=
 =?us-ascii?Q?40jYttRnrHTQSLrb5bej/wVNkxQ6pkDaFRQ1glU8Y5YlKqGHRj5pokA8eNAA?=
 =?us-ascii?Q?yvvp5q29Znay9SbYPVzFQR9aQkqAPBN8JMHSHkwbdx2x8Vzfpl7HRsbppp97?=
 =?us-ascii?Q?PTHYc/t2Y1OOkP0+EHUXZjnL0zbWQEu5MfuPUI2CT/3HKI7waIYkHJnsiJDj?=
 =?us-ascii?Q?t2CGeGMvhDP96kDOp+/3fElnvvVx7OWAsNu2GXI1db/TTy4k8bkAwBrh7dSH?=
 =?us-ascii?Q?sZ/eZ2SamwkFXWKfma3ze8J8Mypye48g4PXZkHZdJURvHZuveAUXjXFQHFJv?=
 =?us-ascii?Q?8g7qG7aMmK7sZ3/050tIYAPaYEnV1tlaq7S7kKbocPkdJuuL+oVUaM+2pTS8?=
 =?us-ascii?Q?pvlCpg1JwF2fuwA97Qit3iwj0cRq28k3lFntUriPd6iOX7G1WzNqInrHwN3L?=
 =?us-ascii?Q?EmxLbYYDs2Y4/kkWX6LHUQMVV0dPSCiUY+y6IK7agLsLRhWj9kpyN6o1r3MA?=
 =?us-ascii?Q?Zj59v+jiOLcE/jfc3WsGMY9cfldFSX8hKSNQHWO+uZQW8v1KVRd6id0anE5h?=
 =?us-ascii?Q?o6rtb3DMioXu3GiD7/E8CtiVb7yxxfGHhva5uYbOmcuGSgq1g7SEiJlz2KNX?=
 =?us-ascii?Q?zD7m3slT4KGqvl9HWDy1Y1hDFsLv7zxbfWs9GC4DQq9NCKbYOtHhInFN89qs?=
 =?us-ascii?Q?7Eaq/ishr2J3RylCJcujgvXuweCGVMh6PvGGUEd7AgruPyqBz8Np2arR81Q5?=
 =?us-ascii?Q?PIj+O7AHKoy5ucTslIuwGcP6+sG7cWlwWTazmvQzHOmYynbO49tlm837Yw98?=
 =?us-ascii?Q?JdK/lPg7JAImMiIriLeq92mLeGoID3501zda1B3SfQmWsXzzyvDiOdqxm3dR?=
 =?us-ascii?Q?VMy6t3NHlD1kEIUnZpgfuNI8Ly/PZeH73bxPK3xE0kseFcZAsLBCEzr0DCAs?=
 =?us-ascii?Q?yT8u5R2Ko83hK9PVwqI5qtdm06xI0XU21uS0YKk6N1rFdNTQ4w/jdD9vLlgK?=
 =?us-ascii?Q?i3OMv6iNhQLVDNOTtp/pNmnmoYsa9cXIsQonrKnlSQtMJbAi4BRJgMigqdHZ?=
 =?us-ascii?Q?1KEvZHLOBkMGBCT/Sefq7QbqS6qxsAxlBqvP9DIVmOKZeC/yvzsnwfHFMKZN?=
 =?us-ascii?Q?XA2a+1qLMiIQjfFqUBYpfb17RQ6ohe5zJ6xR8igF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8643a627-012e-4947-c236-08de1e16f3f0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:01:46.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxBRcq/tDBr+lHz+ltuXPbp1HRphM61qfSVO1WSwS2eqirRtn4o3EXxfChnkalBGqTi68LF1ja6IE8/Iat7UQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8486

On Fri, Nov 07, 2025 at 11:34:34AM +0100, Michael Tretter wrote:
> After media_pipeline_start() was called, the media graph is assumed to
> be validated. It won't be validated again if a second stream starts.
>
> The imx-media-csi driver, however, changes hardware configuration in the
> link_validate() callback. This can result in started streams with
> misconfigured hardware.
>
> In the concrete example, the ipu2_csi1 is driven by a parallel video
> input. After the media pipeline has been started with this
> configuration, a second stream is configured to use ipu1_csi0 with
> MIPI-CSI input from imx6-mipi-csi2. This may require the reconfiguration
> of ipu1_csi0 with ipu_set_csi_src_mux(). Since the media pipeline is
> already running, link_validate won't be called, and the ipu1_csi0 won't
> be reconfigured. The resulting video is broken, because the ipu1_csi0 is
> misconfigured, but no error is reported.
>
> Move ipu_set_csi_src_mux from csi_link_validate to csi_start to ensure
> that input to ipu1_csi0 is configured correctly when starting the
> stream. This is a local reconfiguration in ipu1_csi0 and is possible
> while the media pipeline is running.
>
> Since csi_start() is called with priv->lock already locked,
> csi_set_src() must not lock priv->lock again. Thus, the mutex_lock() is
> dropped.
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Fixes: 4a34ec8e470c ("[media] media: imx: Add CSI subdev driver")
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>
> - Add documentation for the dropped priv->lock in commit message
> ---
>  drivers/staging/media/imx/imx-media-csi.c | 44 +++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 55a7d8f38465..1bc644f73a9d 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -744,6 +744,28 @@ static int csi_setup(struct csi_priv *priv,
>  	return 0;
>  }
>
> +static void csi_set_src(struct csi_priv *priv,
> +			struct v4l2_mbus_config *mbus_cfg)
> +{
> +	bool is_csi2;
> +
> +	is_csi2 = !is_parallel_bus(mbus_cfg);
> +	if (is_csi2) {
> +		/*
> +		 * NOTE! It seems the virtual channels from the mipi csi-2
> +		 * receiver are used only for routing by the video mux's,
> +		 * or for hard-wired routing to the CSI's. Once the stream
> +		 * enters the CSI's however, they are treated internally
> +		 * in the IPU as virtual channel 0.
> +		 */
> +		ipu_csi_set_mipi_datatype(priv->csi, 0,
> +					  &priv->format_mbus[CSI_SINK_PAD]);
> +	}
> +
> +	/* select either parallel or MIPI-CSI2 as input to CSI */
> +	ipu_set_csi_src_mux(priv->ipu, priv->csi_id, is_csi2);
> +}
> +
>  static int csi_start(struct csi_priv *priv)
>  {
>  	struct v4l2_mbus_config mbus_cfg = { .type = 0 };
> @@ -760,6 +782,8 @@ static int csi_start(struct csi_priv *priv)
>  	input_fi = &priv->frame_interval[CSI_SINK_PAD];
>  	output_fi = &priv->frame_interval[priv->active_output_pad];
>
> +	csi_set_src(priv, &mbus_cfg);
> +
>  	/* start upstream */
>  	ret = v4l2_subdev_call(priv->src_sd, video, s_stream, 1);
>  	ret = (ret && ret != -ENOIOCTLCMD) ? ret : 0;
> @@ -1130,7 +1154,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
>  {
>  	struct csi_priv *priv = v4l2_get_subdevdata(sd);
>  	struct v4l2_mbus_config mbus_cfg = { .type = 0 };
> -	bool is_csi2;
>  	int ret;
>
>  	ret = v4l2_subdev_link_validate_default(sd, link,
> @@ -1145,25 +1168,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
>  		return ret;
>  	}
>
> -	mutex_lock(&priv->lock);
> -
> -	is_csi2 = !is_parallel_bus(&mbus_cfg);
> -	if (is_csi2) {
> -		/*
> -		 * NOTE! It seems the virtual channels from the mipi csi-2
> -		 * receiver are used only for routing by the video mux's,
> -		 * or for hard-wired routing to the CSI's. Once the stream
> -		 * enters the CSI's however, they are treated internally
> -		 * in the IPU as virtual channel 0.
> -		 */
> -		ipu_csi_set_mipi_datatype(priv->csi, 0,
> -					  &priv->format_mbus[CSI_SINK_PAD]);
> -	}
> -
> -	/* select either parallel or MIPI-CSI2 as input to CSI */
> -	ipu_set_csi_src_mux(priv->ipu, priv->csi_id, is_csi2);
> -
> -	mutex_unlock(&priv->lock);
>  	return ret;
>  }
>
>
> --
> 2.47.3
>

