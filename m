Return-Path: <stable+bounces-224873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDeANBrWsmlDQAAAu9opvQ
	(envelope-from <stable+bounces-224873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:04:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF31273E37
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F3D03099C68
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B11379EE9;
	Thu, 12 Mar 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UC/wxRYr"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF035A388;
	Thu, 12 Mar 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327389; cv=fail; b=fkHeDfujPOeuKhOL1o4f9NLTAildUCdH3gMaN6cjATbBu9Uxxku3g9oAsLvzJT6FzFfTCG+5xxizLtfvep1emyjldcFxvzDWJ0uNPXmz5LpeR1Fdpbjo7XCMN6DKGvobz8lcuXCheGOdXETFOzOP44Oel02PzNuIUG2HFR5Pow8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327389; c=relaxed/simple;
	bh=eKZ6oAsC6w/PiR93ITWFpHOPzFLRWOrU3IV1jbNasfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OmOMXglaIZRIAdGVyeosulwZUJFqBMJ6tRwSmO8xmlXlndw12v6pIkautMv25PD7oIDI6MqNYZXg/fzQqynKDBbRD299YZmIoSbnYCQ6zLetslcsx3NhFOKGQj8w9bHvNU4B8lXZOrKCEVcr5ghu1R6dPTwSUaetXpNG4kby0Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UC/wxRYr; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoV3MZGwOQbAL88Rs91JTrQeefWJxqkd363PBsv6hK+G1sAOAwawt9P6HmqM2ZFMBJHCrvzc3BYY3i2fygYv3XTU4TKVUCal7lgVU2d8An59TL22YgMiHNE/i/78bXZQkZRDNI3mO27MXo4572khnHVr1PU6Fa8G4c767e0mPxy62QAUExluikehe2AOENYHe7jwpn3AJSYcay7/GlouIBSUUxrTh0QQovozOgrzdopnY0FUbXkou/ud6vFCEnppAUox45K9vjX8j8/QdMp/+twA5+Upxph0N1W484ODkreWQmCcwGDhUYY7kGumxTYNrepdi6rBEOT2x2OjV09/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0iyWLRCdpFvNu40d2vPiwyUpjKOKWtQzPJnWLdpPu4=;
 b=GqqYB7Ag4QY6QsTnJ3pzlBs8VkvYBIwVWk8oJcrH4UT5um8J+veR1WT+FGsy8MfHudP66QCsPJRHXZhggxFpn6lOcYDZGdyJgrwAxBwLl0hJMAUn1O2vl9+w+p1/KAS5EaufhZWfxWvsrT+8PmPMK4DL84c5uzJ6AyR4nHNMdnDAli4YURbd1T+IlS/vmPD642yMqZsFJrbr2VpFkp8KTahIVp4EUCj+3/neXkGWakVmwMUBOYThLpZNbJfgwgSTz8wa4JEB/SfKdPsRMaShGA24LQPR+wxwHhYvoMqJirhMavHiGQQDiVFsSaxzDcG+k+ufx59GBgep3kdGKvkakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0iyWLRCdpFvNu40d2vPiwyUpjKOKWtQzPJnWLdpPu4=;
 b=UC/wxRYrnwn/K+4mrBRU00fCTbT3u6x54xiby2zTjUmMcng4Z/yWYAHcZaHOa1QMe1U63ZvaEPJmAQtepH0CyzIHZ/9slq39EtrclfwE86L4Hk/kmeW3NkJctrJSBXbHZI0G/NYcsxLNjvKaSdGd7mZuvPpnoCfWv643eo61zEiEtOvGw4+0ZEy19XjUzZ1uhLAy/mPIxWEPiIdoiuE7FZeqv+LeHGncnQkeG24Ft/7OuWqMZO4cz4NAqbNroh/SAVr7JSB9Pca/YO7IHGZJhWV8iIlh3rVLx4f8FOg916+uHM98O0EZfoYsrbVdnHUinBxiGtOdl2evB9p1N8S6pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 14:56:24 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:56:24 +0000
Date: Thu, 12 Mar 2026 10:56:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX
Message-ID: <abLUEXiLy0fkq3K7@lizhi-Precision-Tower-5810>
References: <20260228080925.1558395-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228080925.1558395-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eafa0d0-d8ed-4516-4cfd-08de804787c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	VASaOq3KfBSmdQHCJ7IRuyChndPjeIIzSKN8ih3apciJxqx2TZn9AE0jcG8phHIA10eLMkefR0xQEPcMMs9UUv6RNdOZQra8VCiCAI0c5+3A5S0L4lFX0wuS9prrc2VeO4L6ymHCJdXZ4ItTRE/RyFUoYjjtHnL6QFyeFg12JqesuQIeCa5HKk2tYTMv3j7heDiO0OHcHR39NHPyg49FyJxl8wNI1KN1J7M2MVbEkpAkEAv0P7/Flc+yMI0NiFpWvx+Oqfn1B2GB18ieYghPn2wMZ2BLX/EISX+Ohuwg8WRBXI/NVY0VAUjWnTj7vsT2SCa4KKgzKfnVbC25OMwSfYSrBLEayUpVJKh/v2sIkpBIr+iQxS9ypB/0HF4Xb3zBkQW/T5hNcxYPHhVrW3z7AlUgCSM1s9Gry2cDSwCBjx866RuA/DhKTeKU5iq2414TlD0tsF1u5C1nH9G+1F/SOeMQWQu4bst/8OKyMt3jpJqQg13RLMwycantmREQVGMj+PxVKp3F55prHlVAUUiz8iWYqLzYd5fC9DuPN9iyYrx485pthrtomh3x+utAGXMBmF0sll25AQUGFLLxLJ3OG5VZawPSgMiFk3ltifreT+z8bhRdzorsEb4KbGKT7MW8uM3lJMPFWHzajkjmUAkURKBGLgPeWtsUL8SYrRvyuZ0RC6zozMN8xKS4MqiprELi4ygEir1kwvQ0txyxhqpF0oZIWl57GUrcxELbfsdIJEq5+jkw9i28Wx9Cy/je0SpUuB+Sf0YJ/pyDfPgnRTJItFiYXi/dpsE6hjD/UtOCCS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrMwmuVbQQPfFpu7Bp7bbtIXzIoo2+jZEjOxGmjGy7+G9UC7BmzWzCtBdniq?=
 =?us-ascii?Q?OIkDODKujx5wANPeTpXK3HJ/P+jhWWj5aTj7jI3Jm1oYE+ewuEGogOryijD4?=
 =?us-ascii?Q?qN1sbPiL94gqAC0Jj4w4nEfbvyj2DwSYRSLxWIL22hVvkXcoHMnPqcHG+jw5?=
 =?us-ascii?Q?Ht5zHnlqhVKWl9y2+Xs2dzqExYEA5n1rjLXRpoIop4zQklq8d3m/38fD4rzh?=
 =?us-ascii?Q?4qc6Bynml6kJUn9vU5fqxLtGfpVp/8laUvzH0xtR9bQ6gwC1cNzFES8x+AZB?=
 =?us-ascii?Q?bp+asfgwTwpvpeikJZFlaEt2ltP2HMa0XaU2TyaiNvktubU2hcepKBsTj/H6?=
 =?us-ascii?Q?YFrC8F5TLiG35ouqpI/fJlNv2A4+NSRa+AAyJ/lKxpkp++xBlETx9+wcmvqo?=
 =?us-ascii?Q?xbO63JTWPbyWMRiZ8wI0ieQm8+VtHZbEG8NdmXxhEhn7bMwN/pEkwW1CkGor?=
 =?us-ascii?Q?2IJH6ShX+nz8HZZI1xNOU7q5YrbaMDeoN57uYEL25tUEtZygynRCzyny9OrZ?=
 =?us-ascii?Q?/rxPcqvAf3SF5V/jpUJb4yooec7NTaQ4cPPkPZu1YDBVfP7Jffhc4NJgFAgP?=
 =?us-ascii?Q?sko33QVte5cgj626WqQUiGGFpc6uU67RFX4vZSfe8UuGLPYK657ln+gSwpsa?=
 =?us-ascii?Q?biO325JNxTpOgM8fY2+YgDGUDej30P/VWCP2xm0fD05ATaqD/ILANegOylT3?=
 =?us-ascii?Q?XegMyVVWwR6+gUqeq5MOwq7PzN/diVYPac1uyihdwwRivlI+iz9R/jfM10Ub?=
 =?us-ascii?Q?lSmnipCCz48bna385N6946FOQMA1qiRIOTshsG8VXnRxAeJfKhBdEm1kngmg?=
 =?us-ascii?Q?mqjt5IFg7lYvRSCSnEC21IJPFZa2sODBtcqYBaI2iJqkzuKy4oUjU4ak6x6x?=
 =?us-ascii?Q?sJ/fgfUTURTBDspGPidJFvOWg7xdy+2bRo8ds8CT0XbKx/NXTUq7vYsT4HRG?=
 =?us-ascii?Q?Yx1VrF/D9w08CLRXIYb54SYj369QSSyLITzBvfzCkUAwYQSw99RBPLMdxotz?=
 =?us-ascii?Q?evO9xc2uigOzSKYVHo/HmcdwlWUtbVzKT3RkyhmPQN3CwyvwYWIiyLUyl5GC?=
 =?us-ascii?Q?CpD3EOthwImIApwRb6qN10PVKaL1qJMeCXz0BUJENE6+RtlfvKAduUv9YmoH?=
 =?us-ascii?Q?W1cKekgqdhlCBhEgKEufrBCDKegbYWKMJNBKoVRnID6tqYomQ3rJoyLb9Gh2?=
 =?us-ascii?Q?Rw95aHIIeK3z56rBtifmufCrdj3DypTfLgpdFK1cSRf7v5y1M3mRYmyR/aBF?=
 =?us-ascii?Q?YtOy9/4D/ayEbBeIdqcrztksUDeO8MOllcskph92eye1s3yx+KyQJ16kpJlT?=
 =?us-ascii?Q?+B2X0afSlxhHX/qso/4S2cw1R1jzzcUwwwqJKVX/DMvvFrqppCpk21/Uxola?=
 =?us-ascii?Q?IX9tSWOZTo8zebsY5sGpyxbaLt1G3HPaxtXZCph0gRijP+FWOnYyomwrvVK6?=
 =?us-ascii?Q?4mEOA80cQC0DM95d1N51/Xl9WiS2d0uETR1yoPuKUC2hiQzXYWvWe6UKYh3b?=
 =?us-ascii?Q?PnW62pFC4UKGTBvJpCpL0diGbZLXtZSo3+MMOX2tJiMgjHJKS5VBHBmpRnTT?=
 =?us-ascii?Q?BRdtxE/SKmZO3I9Pvk8ki7d8wt/2RE/ozvLrIe55sBXM5rhdImKdxJnShh11?=
 =?us-ascii?Q?E4BGYPDkYh8E7aXo9YjWj1sI7+YJg6KMKJGXUx60R8OjggCElqA3HHyDpaKM?=
 =?us-ascii?Q?R4es/DfOkcUZ11673p+kT8segJx5mDY5PhNLHluYgek1kW6V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eafa0d0-d8ed-4516-4cfd-08de804787c7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:56:24.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9mfhqqfzgfh+ELWY6Zu8q4EGmABGGsJYOAK5rYZLQWaVwjzofn9LKx8ERzfw2NutmfzZlkhkptopGo+m1kIgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224873-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 4CF31273E37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Feb 28, 2026 at 04:09:25PM +0800, Richard Zhu wrote:
> On i.MX6SX, the LTSSM registers become inaccessible after the
> PME_Turn_Off message is sent to the link. This prevents verification
> of whether the link has successfully entered the L2/L3 Ready state.
>
> Add a new flag 'IMX_PCIE_FLAG_SKIP_L23_READY' to skip the L2/L3 Ready
> state check specifically for i.MX6SX PCIe controllers.
>
> Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2d01c21b5570..4385cb18e240 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1871,6 +1871,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.variant = IMX6SX,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
> +			 IMX_PCIE_FLAG_SKIP_L23_READY |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> --
> 2.37.1
>

