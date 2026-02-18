Return-Path: <stable+bounces-217307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H+kMGfolWlWWQIAu9opvQ
	(envelope-from <stable+bounces-217307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:27:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 107CE157B91
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54F9301A38E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7855344024;
	Wed, 18 Feb 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EudqczG5"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843333D514;
	Wed, 18 Feb 2026 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432023; cv=fail; b=la6/9W6a4MC+IS98V1DQ7lcspYUrx/OW+/OEej3hc2Eu2h0vfRApwNWaXDgLsk3RibiWtOlUJFuMgbL/Z0V7pSgQ3/7e9sWm/FXsJvqMWlQYptSVcRtaXXdOXKaPJvIq5M9DEuvBFaq7x+Ifkcve+ZomaJXkpCRYcU5LV7yiX4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432023; c=relaxed/simple;
	bh=dvGQEJxyYsMVFTrliEPCr2sVhG7rQ429ZQgPnxyrnFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b+T6r6wL/wQNfL07YaH/303TK6NFwa+Md+JVPifD4oQvO9R6dk0lfeRjti+xtD9NyvOkW6byn3P/uzyvrk3Spbg45nyUU716OGVJQZG0Smg6RcRKOh7o6uyrdwGIgBAgAHnr0ZHB0m26S6D/kYjBnPHJKuL8NHWluNsvr5gb3aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EudqczG5; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptDJ3o3a4MI2pmPfsB/6Hm1WtjJ2J9G9hPO+zLk63bFU4ZtH+m/3K+6Wqpnzu+KEGlhwXSO6OMNrsrwQdcbnFoXbtnAo2PIOipL40WNUu+tHKuqYp9gRmaoTuGxzdA4H0iw6r/Sf11l6BE8E09msbDoh8gFOl4R9a2S8ctSEleC/rneTKuBN+Jh2Z/U4FblEO23DY9o/Uin0obvbKDwi0eCIYCmvURYoZdXJoNAIfUO2V/jHa8B9Xkto9fSXoLUiFgDqXQGSPLQ2U+DcI013h/qOffXFftVGdhIJOam4+S1kD5Vs3pjL7f7vVfJx83qYuiQryV4VvQga7mMqIPMMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/2E0qvAj5d1ErRFXUB+oHriapqINYsaJcbHAoBpwpk=;
 b=Kt49ZzOFUlGbOW7EQS19q+KKEW7hK3R1wzN1CoFOGBXJgQIIvw2zTdLGLtT4fUNgYMxDwG04QVRLi2YjZ0DyKriHRr7Esp20QjYh02fimp/k3n3gSGr7lCwAOGKvgLaMbRzdwpNMPTTAkKb3IRjYa+8OdEeOPvHhXlDtfUv7Qu+yLcXls5Ylp2sVOTbu58o4tUimPXRLwyo/VTw+XHMQVj7FF7ftQhhoNiCzKBjjWOhKfancqguWtWNFod/je++f4uwqWue+VeqyaKhe5Pa3zKaLSkHoocclJpqbkmu+EmK6I2v5rlsdR2nudwLQME8eio4xR/TzqxSynoxZUkiiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/2E0qvAj5d1ErRFXUB+oHriapqINYsaJcbHAoBpwpk=;
 b=EudqczG59XbJbvLQlmcnZI1XyUH40oKSgZG967HOTiyTLMSeunO2Fh6B/luIxWh38pvQoOnLt9AsH4humQDuTysBGzJbd4Ij24BZLEULpcGgU4XvJjbrWmj0uT2PzhjTfGAH27osFPLgPqEHEqOU33Rnmz2Qsu4X8Ug1ywfmPzAey6kWLdelU/DMesVhKNJ5aABeHEyRWIRGpnG9FeTALpwg81PDPPbSdy+r5WkdHz+eOgGH7OqYQttC7xDZkfiB4XckOJBjwmE9hYpPu0X5G8Uhw855JsyJ17bgJwZqh14oQii2Dr9hMxRpORcGx7KbUYU2mC5lM7R33mXDGjrePA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 16:26:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:26:58 +0000
Date: Wed, 18 Feb 2026 11:26:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Message-ID: <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218150940.131354-3-eichest@gmail.com>
X-ClientProxiedBy: SA9PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:806:27::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: d75c048c-7c93-4a25-ad61-08de6f0a8983
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?41xWytWZSmyGMEf9gKXuHrPaYPxzYw8dL6aAN/aE23Uyu7DmY/a6NqWyoz64?=
 =?us-ascii?Q?56C3WJBNkoU2b5wUNxfyA8eZ9WTAbZ7qoZdolwIuzcmQkTpehW9pr1d73F+4?=
 =?us-ascii?Q?d7cb3SdNhX6kTu1NmrZACW0PoPvwSrFzKQ3G2kMz7fVPfUl6xK4oUYp5vA2k?=
 =?us-ascii?Q?uIa0Ns7LscJF+klOZL5TmLJ8Ipv2eSx8XhVwTI9So/5wYywnPMcE5Q6dlnZr?=
 =?us-ascii?Q?b8LN6wHJ+FGWLiqwWPxq6jYxCyNumlvBUozPpwzTayFCS0LbFor9D2VTQOJT?=
 =?us-ascii?Q?uxjK+ChdvTeGuibaEmlm32IlUmgF+SIEeYXRcp7yia/4XpYYkMRtLCjB9EZB?=
 =?us-ascii?Q?ZdIIni0JYmNvzZ0zpsHQAMwDNH33RQD7PG6MGYIibd0vA57rLIogwgJSdeBv?=
 =?us-ascii?Q?8tcOtZ9LRlq4Pr6Bbld6ebxUa/OPvHpuSW71BAj2FWzGtNi0UjRfCA38Cgfl?=
 =?us-ascii?Q?9IoMd+J1e6J/BXCKIyfw6Nf2k4NgI+pWsi2wUFeTLW6zanJBiKha1nOGO4QK?=
 =?us-ascii?Q?sWA6/s2fel0I1CRDnyLeDwgKdvf+Yva4ZQIGHdg39yfaF3md3HyYYURSuCkD?=
 =?us-ascii?Q?4234WYLZpXA/yHF3zR/Bi9VBph3OgP+Umm5fcesTmAvW9atEUBN9Rt7K5xYV?=
 =?us-ascii?Q?iDyzTIrselMhmDcT5UN61C5Of7nTnD8SjTDJbGqO0PX+kl5aS+EvMxCB+ZD0?=
 =?us-ascii?Q?u9zm86h+fsqVuqskj8zponANrqjtuG0vkXyY0GzDEHAvUJGcU7t/ARRNlS+c?=
 =?us-ascii?Q?vGraPBTIDERjTAT/V3VdW+Q6BggFmx3PKQxE/6mCVpQvDiurAgEY8BwM2ucO?=
 =?us-ascii?Q?1GMXBWsnR88gzi2Sr/HFQ2aaWSIDy9NHMTfhJ3qbBDt8iFDYysNFxlurnq6C?=
 =?us-ascii?Q?UTm75188LqFUK18AblWZxPnpFCrXOmlVNDN8APCTWYhQNCsEbgfvRDCGetpI?=
 =?us-ascii?Q?0D5JlQ2wyDuirMhe/RAIU16AXtdCiMXLEdzvvh8vpd+Krp4LenSHC2aEXn/u?=
 =?us-ascii?Q?jdkLICrYNNK8uRLT7uXawrWkXMoSv2NJ4XhuqTsSjl/OUCcb416hJmgXl9Id?=
 =?us-ascii?Q?zPORAYbPwsgy9y91VYHKt1R8SVeKAQ1JbGeD3TwKiVY3T0vMLPBq2dw5oKwI?=
 =?us-ascii?Q?o9V49ye9t8+YBaxo/wxK7JY/mlcGma3XFVuL+nrbrRnjZJSkR+1vwVPR3dtV?=
 =?us-ascii?Q?sc0tYpUzPvkhxdZZ+aQAnQjZRtxRnmFg4nHkWqBeZMKQafcSKvViR2QdkR60?=
 =?us-ascii?Q?qpZdfLz13H7UQ+apvU+Rvv+jAISBwubMFxmFKVhML3gwhN5reEm8xpmCvesO?=
 =?us-ascii?Q?vd8XdRLXZm8HTcGooRujO9KgF2WLlnuTvbo1AyozbYE21FJ56QUV+quwjVF+?=
 =?us-ascii?Q?dbTGp68GEiDLExcMBx9AJgL6Ma6Mr6MKKRmbSjW2HDPr9I8+GzgR7kvoBEX+?=
 =?us-ascii?Q?9f6UTtnZ7ZlzJnEPH8K0epLVYVJjTx2f15y1PBlgXRBZ2Fz9ESOV75626abF?=
 =?us-ascii?Q?hndcBmzrNnhhItxNDqkzhRCVTkSeybdA97tN74SLUet7bxikbOvUn14ikW9T?=
 =?us-ascii?Q?Oy5+Ih7cW+NGuJtDZCcFP+tskgRwvLH6Lz+F5IxIza5+xJdphArWt9SB88nI?=
 =?us-ascii?Q?EUJxM9ReEqY19GywnGGK/+s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?DPPPUeJsyxk/0jf6L6Kf9qr+zCDm6NU8ARJDV8JSjPSGSL9eBWmc9z4fzR8A?=
 =?us-ascii?Q?DyjtIM8IxWvuFnF73u70DL4DruTCjwo2847WIeKYXcb5RonuQ9tjwsR89sIp?=
 =?us-ascii?Q?NDg8COWXMjom3xOvDNhZa6pCfWa+nNJxUcQxzs0wqsyDxi7L7NcoR9hc0Nvi?=
 =?us-ascii?Q?/JPNBobZPa4rYhdjw7ARM0ua3Gs3KfJpF9Qkb819yBstFxlSMT/ZuTUbbzJq?=
 =?us-ascii?Q?RnP7cz9FTV0hFhZuweB34UmWUhwBMeW4S296oywmiPDps2lf5txNaOLVaW9B?=
 =?us-ascii?Q?CIzinfDQTLVcAaJWoe4hoAr9djfyNEbuzJvXag2fAsMr9JmHYDxt2syNyzx5?=
 =?us-ascii?Q?vmUdhK7FRHSdq1SUnUWX0cK8SCgMCCdGfU4buvQyFu0mrdXDSx9GKUitb2IJ?=
 =?us-ascii?Q?b4kOipw93UqYvXOnZ4nG1at7+8zx2RCOjww7NGCQ0k4RhIVXwHGNKXZr5CQb?=
 =?us-ascii?Q?w3rl+anaFebuHezpKdRuXSeNqFUSx+8fpnvnF7pscHg4riCdkU5Zxmvr7LNT?=
 =?us-ascii?Q?L4pYUBPlzijH56TulB1w8R3KUCiqpbcH4/ukLeGTRwndodT3mjYmVvmhi819?=
 =?us-ascii?Q?SupTF5AYpQkaz/3p5k3F0lpk9En5+lCx6hATaBvp+itvWIfIewHpj8g+cFyM?=
 =?us-ascii?Q?IiBIRZQIldIqH/kPAYuXHwwP2/ClKqDQ4Tzhy9G/6oPCg8y3XKyd+YTLA94R?=
 =?us-ascii?Q?AZ0gYCYwopH9hvB4ohHZddZeTl2Unyg1dYRLt6WVRDrhus9BuJxtJ6qgOfAM?=
 =?us-ascii?Q?oqogdfbQIEek2uIqj0ft2/pZ1zoY2DI5/ScyvG5ra3NL1Cx1jtdlc8zdnX27?=
 =?us-ascii?Q?Oq33opQUn8+noeks2dipYebPiqQvRqMPDoLHCBmGybkIuy/J4PwDJiUrriBx?=
 =?us-ascii?Q?thYNHTBPx/4bRdaoLxEjxFqYCUX6SISm8nPfomUK8+jM+XOdcXWkJFBToHKK?=
 =?us-ascii?Q?ojnqm0ydPqkqCAU185nj3uoSXLVB+e643NTRzV3+W1kPr1DGIR2cFF4apwmv?=
 =?us-ascii?Q?GOTjyw/AimdTBfD9VWhRpXC38g8p2dGbZi4MOLhxotEMfMT5i48c3GbjFG2H?=
 =?us-ascii?Q?nUZ2oV1wNCZIgzfLjURHYSzCaSbffGMWfZ7nQmmjRPmmfJ3DHnYDKX+vlaSU?=
 =?us-ascii?Q?ICAAS6KkAg5r+FdtWBHcTdUn8aba5K/z2RpjljsvuG+jr7NyAAKS8HB/gcvn?=
 =?us-ascii?Q?Hzu6799cljlX8GpNZZWgaOLVSygxRlgjgAXiFeoKlP39rYafq19c6XcmaZ2q?=
 =?us-ascii?Q?ET2I3oBHlLLFjRdKgPQb5kFpCsVI7bcH8uVRWbsBWH3ax8Eq1OeKEtdgyLJu?=
 =?us-ascii?Q?myU5CzOzMw5Ab/xI+02GnA5FSJiIcM2a5ki7DCNZr1jb/H30yDaV/7q53HI8?=
 =?us-ascii?Q?YHHoRYsBwBHkdDeuTIAhssYQ4f01xEHPQhRgx58xBuErIc8TuqL+lMOo1lhW?=
 =?us-ascii?Q?2sU56NMbN0Y2O0DU19GMODm7CKA5QREYsfqcKLiYJKhQP/9g+P7148WMYrNI?=
 =?us-ascii?Q?SkK0Qrpdk7OUBA7N8FeVIzRjtQG/jFrIqvMgkXpP18sarodfHTcxTEQVbp1S?=
 =?us-ascii?Q?05jpN8BUwDUH33NDONQ933+JgHgXfbEMW9kLN3CxAkY5AkuzBF2WmY/Q55Di?=
 =?us-ascii?Q?1O8DDTl3LqvO37w4sYrKbfXDLKMBPTaGxRC8oEoLb2wqyd4M8R4KVupr9IjY?=
 =?us-ascii?Q?fcSA4bDmPgm79UXmDtp5a/aGkBv+rALA5VIW6jdNaihC+xlV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75c048c-7c93-4a25-ad61-08de6f0a8983
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:26:58.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUJSqUIzOV47gFOxzb1ijEq1HMGLD+gHqBjOv3K1G6KX/p7jow8UEoJ6VHHJ4TMSjxUpQvTscOPNEsnEJzMHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217307-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toradex.com:email,0.0.0.0:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 107CE157B91
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:08:50PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> When reading from the I2DR register, right after releasing the bus by
> clearing MSTA and MTX, the I2C controller might still generate an
> additional clock cycle which can cause devices to misbehave. Ensure to

Do you means SCL have additional toggle? You capture waveform?

Frank
> only read from I2DR after the bus is not busy anymore. Because this
> requires polling, the read of the last byte is moved outside of the
> interrupt handler.
>
> An example for such a failing transfer is this:
> i2ctransfer -y -a 0 w1@0x00 0x02 r1
> Error: Sending messages failed: Connection timed out
> It does not happen with every device because not all devices react to
> the additional clock cycle.
>
> Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 51 ++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 56e2a14495a9a..452d120a210b1 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1018,8 +1018,9 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
>  	return 0;
>  }
>
> -static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
> +static inline enum imx_i2c_state i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
>  {
> +	enum imx_i2c_state next_state = IMX_I2C_STATE_READ_CONTINUE;
>  	unsigned int temp;
>
>  	if ((i2c_imx->msg->len - 1) == i2c_imx->msg_buf_idx) {
> @@ -1033,18 +1034,20 @@ static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
>  				i2c_imx->stopped =  1;
>  			temp &= ~(I2CR_MSTA | I2CR_MTX);
>  			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> -		} else {
> -			/*
> -			 * For i2c master receiver repeat restart operation like:
> -			 * read -> repeat MSTA -> read/write
> -			 * The controller must set MTX before read the last byte in
> -			 * the first read operation, otherwise the first read cost
> -			 * one extra clock cycle.
> -			 */
> -			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> -			temp |= I2CR_MTX;
> -			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +			return IMX_I2C_STATE_DONE;
>  		}
> +		/*
> +		 * For i2c master receiver repeat restart operation like:
> +		 * read -> repeat MSTA -> read/write
> +		 * The controller must set MTX before read the last byte in
> +		 * the first read operation, otherwise the first read cost
> +		 * one extra clock cycle.
> +		 */
> +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp |= I2CR_MTX;
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +		next_state = IMX_I2C_STATE_DONE;
>  	} else if (i2c_imx->msg_buf_idx == (i2c_imx->msg->len - 2)) {
>  		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>  		temp |= I2CR_TXAK;
> @@ -1052,6 +1055,7 @@ static inline void i2c_imx_isr_read_continue(struct imx_i2c_struct *i2c_imx)
>  	}
>
>  	i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +	return next_state;
>  }
>
>  static inline void i2c_imx_isr_read_block_data_len(struct imx_i2c_struct *i2c_imx)
> @@ -1088,11 +1092,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
>  		break;
>
>  	case IMX_I2C_STATE_READ_CONTINUE:
> -		i2c_imx_isr_read_continue(i2c_imx);
> -		if (i2c_imx->msg_buf_idx == i2c_imx->msg->len) {
> -			i2c_imx->state = IMX_I2C_STATE_DONE;
> +		i2c_imx->state = i2c_imx_isr_read_continue(i2c_imx);
> +		if (i2c_imx->state == IMX_I2C_STATE_DONE)
>  			wake_up(&i2c_imx->queue);
> -		}
>  		break;
>
>  	case IMX_I2C_STATE_READ_BLOCK_DATA:
> @@ -1490,6 +1492,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
>  			bool is_lastmsg)
>  {
>  	int block_data = msgs->flags & I2C_M_RECV_LEN;
> +	int ret = 0;
>
>  	dev_dbg(&i2c_imx->adapter.dev,
>  		"<%s> write slave address: addr=0x%x\n",
> @@ -1522,10 +1525,20 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
>  		dev_err(&i2c_imx->adapter.dev, "<%s> read timedout\n", __func__);
>  		return -ETIMEDOUT;
>  	}
> -	if (i2c_imx->is_lastmsg && !i2c_imx->stopped)
> -		return i2c_imx_bus_busy(i2c_imx, 0, false);
> +	if (i2c_imx->is_lastmsg) {
> +		if (!i2c_imx->stopped)
> +			ret = i2c_imx_bus_busy(i2c_imx, 0, false);
> +		/*
> +		 * Only read the last byte of the last message after the bus is
> +		 * not busy. Else the controller generates another clock which
> +		 * might confuse devices.
> +		 */
> +		if (!ret)
> +			i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = imx_i2c_read_reg(i2c_imx,
> +										     IMX_I2C_I2DR);
> +	}
>
> -	return 0;
> +	return ret;
>  }
>
>  static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
> --
> 2.51.0
>

