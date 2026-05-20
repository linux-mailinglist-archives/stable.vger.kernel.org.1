Return-Path: <stable+bounces-250025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKmyJjLdDWqC4QUAu9opvQ
	(envelope-from <stable+bounces-250025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:11:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DD59194E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE59330039AD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5C345738;
	Wed, 20 May 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DbDVjlB9"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371F3403FD;
	Wed, 20 May 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293252; cv=fail; b=oDV3jyX/ocUGhTRi/2uhY8Z47n05o5YvxpQ+ILTRUoAgUzCJ0kZtqNNnbmJqarAQrN+CU2ICroBAfzCnBJ4IlIMDjMwaOXnighc5yhmjfpf9K4fRypJhMAFtn1ZMIAz9LEHVtLYRapfgpuWiilCfz0DbfPHQRwd4GtszZyiWtO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293252; c=relaxed/simple;
	bh=N4F3lkU7webg2bzhbOlSqAe2qHoEaxy+brpgQ5KuPRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QU2ovYdbNjjs4G4Jt+p6CAMGxEX82an7R8e8Rk9bOu3bUooA6gJRZZGRA1V7Zv1zBFEhM7QeCBJq1UOWN5bX1PUM7Rs76FNq8tQK+eQ9346uWQZqMoVyJ4u4+bpgknh8vUdF3ep2m2sWd58ZVSnkShBAi/NsQ9vzVYI80p4SrHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DbDVjlB9; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk4j7doYDME4HODF0BS3nNush/40O2Wbk7PketRiy9tGvsWOJXceVP2/Yubqy9eoHi2YXmJmuAAiN8mq0DkPZqjVpMyjTdNNePF1OKVbrHbviQ1RtRK8OaAbs4kaO656CkCcICeW7KJLfQ6fBW8gWFysHuCOp5dxd9f+C+/tHIIenL2G7UKiyZt03/hz9pVkSp8feaK4HppuURln0pTVwldNVhGLDAcqtNO2yDSQkGnzLAzEYgNqzCA1EofNeFyH7XhCmY79dWqdfgclYB2uXdvgw1OKrKl5VXwps8v1NaOmQsQMUdf/tlvDyQXbcdxvUauhDwoRzLkxU20+22mbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVwsWb+bcclDmwNpTWuaw8M0x7KXDFIJ6fnnAC7XGZw=;
 b=MjjgbUAng5eqxAIMXzeFh/F2E1+AWNBDeKBkeTqaTrQkMYLq4yuJ/CAbeNvjajk+TL5FZSRLUPT7K+4WVyXtch4iNx6Be7prvj1ZySoSDVmmB2Eqbm4FKgSnJwnzMEylXXAs5vhhBHeah0u/fzLMs4Ng9UHHr8aNJ7a5/5iPWR/k+5QinljwRGiCPA4VSTnZkdMwFM/iyXc0QpwpAjZH5SpT/nZ1EReNyacS/xIYRUamL7bLT2Z4HCJJHLh3FdaqHjEA1zRCsdL7HgfzV24AeKp07WgUV6+uAmtnCDf+hyoM/S8MuN/AkG9IMTjiDEw2GRy1iLmtD8tSSeHUG1bDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVwsWb+bcclDmwNpTWuaw8M0x7KXDFIJ6fnnAC7XGZw=;
 b=DbDVjlB9lf5hMipEv/O3RZ17Ka2uKEFxUTfNfGn3o4pUcLDqAyG3066OSpzPO9XBrqkhyNbAk+zelabt3Zf6XEgpkqnvMgdyIYpwwivrNKkkS5CCEgzGpsLRE73CCP+bXkMDVbTfPm5wSbLSrMnUwWLlbFolFF0L2fONbXrGzxLKnTaXmF4EEoF5sMYixg4yfg2oN8ewyJ2OYeR8S6XgZKeqjMHV3F6j2hS1HXtXJ2/rwV5SOsFK3K99KdtoVBnj9+RttukzTRgHcqoWyd3WQ7Oh1Xzy7CnsdfIlO8HTosYE0jBEykzxYRD0kOjySccqc0fYh9c/IhqldcsEWJxoMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV4PR04MB11426.eurprd04.prod.outlook.com (2603:10a6:150:29b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 16:07:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 16:07:26 +0000
Date: Wed, 20 May 2026 12:07:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: imx: fix clock and pinctrl state inconsistency in
 runtime PM
Message-ID: <ag3cNT0TIrGQbH9H@lizhi-Precision-Tower-5810>
References: <20260520104939.2897110-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520104939.2897110-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV4PR04MB11426:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ed4528-08c9-4c80-0d28-08deb689e26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|3023799007|38350700014|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ctc8zVvaOLE2SsGS6jijVG3jZDaBSsa2BI3rCo3e+C7NS/KOh79dK1JE1TLFN+U0LpsYQD7MG2zVhG7y5ZgAE4vhxQ5RnjJozwSysLFwaLG9uax4L7lvTfBHPzpkZlTUHLxBJtQinmrJ0q4MX9N4PWAo9v7B8CsHUiwuvRQtrcyYFA/qxv0dry3+YUj4ULgGB2ZPpGnGMD3LK8qcVwvFHg+9/KAllHO1AfVJk9Rj8oU3YVbybpJl+iDZTY97vOl2DCXlwQebIaX3J2zrx2H66jCPJ+tsioET7u9LZGLN0C4JMTifEksuFwVwvl14RKJaWPYSgCZ1n7D8MZnvf5jbOK2LSJSojSLRIDmbi1JVSMXY6fStRqhWbD0924F6y11qrccCT53mvkMhdQ1N69pb1G5d3jUYjW+IvFw1fN633E+BU0CpqisuFUwDZmRf0dHdMjbPdLFt4HnhwKIwfEiKk/QJ1WkXFnAkjHoHjbsQ9MOjK0RDXdTcn4317GJTFp/CC7q0k4EZsMeIkc9o8SQcXz5SGMeZ72awTvU+G0JGgGYcfjHGcfE6lOTyun9IU25qSEPiLWlmzQgw7hvYdme7tg6gaGM6nzintOvGluRx0kN7NzKdb2MIFEPb/LaZiWu3A1FOyp6sjo4uuXIC0y0/MUL8If29fFyKq/Vi+HYVvqkCGVF1nc7Z11k7zJcgOB3KtD1gcDioZj2d4vo4+oOzPDuTSWPRklHQWZ9ch6efYFkKp+WoJhNtHIu1vX90f+1m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(3023799007)(38350700014)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WTx9JBOeQm1kieLaVmVtEms0Ke7X33vkjfLwHSU4FIzHWzh6atbreNBmqWLr?=
 =?us-ascii?Q?vkYKXJ0lW1ghKFdT+Tjl6x8eUZitr4YIV1fTtTcdt+xYpLvXYLdXbvWRF34M?=
 =?us-ascii?Q?vXovaIZLpZCIehl1pAYmYJZl9PHMTiHNaxKnwpRIx1xFBK8JlYDgaUyQFd5a?=
 =?us-ascii?Q?4aOkqXOwajsN9jjFBcS2MCTkeRcNy6r5BL0Y4eN6XUmjZo2K8FYkVFsdidut?=
 =?us-ascii?Q?4uYaGmcMswfr7NzEunla+EsLvtrML+/SBaNVHPohCBs02XIayMrF/3p3jLg+?=
 =?us-ascii?Q?LShPLmZudbl1kmh4ePmtF5rbPBQIcaT+aKzv066CfPdCCbF1tjvgccB30ZxY?=
 =?us-ascii?Q?x4BS8Oj7oPKjwVmBUm86LerQb246olKpy3GO9LJtqJOFloJP/l8zOy/2iv2e?=
 =?us-ascii?Q?PIAVVwAy5RUywWdy+Ysc7idHu/OP+CjHtO22d1v860azjT1ntQDI340VCzVQ?=
 =?us-ascii?Q?LuJxkQcSVg/bNa1yqElXu0PJjS+pz7hqvN3dWtv+qqaGU8rtYo+jNlInZqfB?=
 =?us-ascii?Q?bt3uxuUluM73xEZR3jXGeXjIi8zazqwMUk0lezPy61WvM3PgyAZDQeWLdBBw?=
 =?us-ascii?Q?s6kwX7j0JZdyH8i+xymuevk3kZYaXWzHL9tyW0vQVEXrLX29KZI1ZIy3Q0hU?=
 =?us-ascii?Q?pKJcqFRacL7iiJucCZW+4laZJbXoZQ1qlSW+sCeDHIAYIjnyQFLMFAlxmV7t?=
 =?us-ascii?Q?X8iKsMzoDOUiYrsMO9RorEfEdShRYJBgeEQ6qxrzNOj4ZMMpDd5Xj92PvygN?=
 =?us-ascii?Q?3zUDpFYSbZkBIM+6FN03lwTtSASycWWZTnvh3Prg3ejqJ+oR0QfRlABThorB?=
 =?us-ascii?Q?Oe8NomtleJZRZo28Dz9k3usgi4S8tMRaH4DE6or2tQF2O7lWj0lnUrQ0KnSd?=
 =?us-ascii?Q?W34bdeprGNBvfYtsJMpUtodRjNBJpzQwO7cI9w7n+FRT+qD9SHabTxcZdINd?=
 =?us-ascii?Q?mrKdbvmaJ6Ax5zaDDtapeQI67DBs8vJNxJNFz56QI5sKR8apsVy4yslxlTuC?=
 =?us-ascii?Q?a+rz8PPn+ADyjcxbTOyiSBPfcA6DgCHBRsKXLhiZl3lJqPXwKy/E3iW15BVa?=
 =?us-ascii?Q?Q6Y6f8JNLkXrle/LrgUQsxP0LpUIB958QK4b5EXezDItb4Ivhz8huZLGX9h5?=
 =?us-ascii?Q?+3FdFQYiip6NKLs1Zi61fQpq42jFD6lQR4qU1Wn/+71LKe5TyumgSa2pw12s?=
 =?us-ascii?Q?xNsPul3w34FoV5Q7HdRXHrMNuel/3+t5dY1hEUdvGmm0HFD7l+XKhdNcBALw?=
 =?us-ascii?Q?n4NdvQl8uhRR5G08Eh/VtezhO1gSHT4El60KeFEtCxJQBQ76aiJfSQWdsx/t?=
 =?us-ascii?Q?AyC4eVASZpzeoep4wZxkS4G0P6Ta1mBKLI8DTlgbHVqq043heC/CaFCioTef?=
 =?us-ascii?Q?AABCIH3uDzBjCTSmyIeil1SvyQD6Lf3vEw0pikT8nFuUV3/1pMhGYQjjm5Ug?=
 =?us-ascii?Q?BzpMqAOXtsqpXJHuWVEeS2dG5x/eAEhmnv1rqCK54g1r4RKqTVROjAuUn1di?=
 =?us-ascii?Q?QhkCzx/vlxsnqUu0Wyix+GALksM2fIo8SAUDuvf6DalTPUMh8VkQDTSNu5oU?=
 =?us-ascii?Q?fpFD9vfNFgn8yhzGKxebk1PhYzW1W4nbsXkc9gR24L/y8+gwYME/rzL5kRhi?=
 =?us-ascii?Q?JpmMdqiGwQ20FFEGNHik/mz2zdTf0WCsZqfQeUIkvV+UK4sixfW14mAq2Pvj?=
 =?us-ascii?Q?FD+HBRFUesP8TudmU3VyGWUp4VwIYnNkDlYzoekfMI82VwfCu86S+3LBZPiS?=
 =?us-ascii?Q?9qxar8zx4Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed4528-08c9-4c80-0d28-08deb689e26f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:07:26.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVJP0dvF+zsvS0VoTjaGXCuIu7igV5WMCFLMWlQm6khtXg3IHwrX1mp3AInxbM5EUvcspyfmspodf0TSedIhLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11426
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250025-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 5D2DD59194E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:49:39PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> In i2c_imx_runtime_suspend(), the clock is disabled before switching
> the pinctrl state to sleep. If pinctrl_pm_select_sleep_state() fails,
> the runtime suspend is aborted but the clock remains disabled, causing
> a system crash when the hardware is subsequently accessed.
>
> Fix this by switching the pinctrl state before disabling the clock so
> that a pinctrl failure leaves the clock enabled and the hardware
> accessible.
>
> In i2c_imx_runtime_resume(), restore the pinctrl state back to sleep
> if clk_enable() fails to keep the two consistent.

nit: remove "two", just keep the consistent.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Fixes: 576eba03c994 ("i2c: imx: switch different pinctrl state in different system power status")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index d651ade86267..54fd5d0e4056 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1892,9 +1892,15 @@ static void i2c_imx_remove(struct platform_device *pdev)
>  static int i2c_imx_runtime_suspend(struct device *dev)
>  {
>  	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_sleep_state(dev);
> +	if (ret)
> +		return ret;
>
>  	clk_disable(i2c_imx->clk);
> -	return pinctrl_pm_select_sleep_state(dev);
> +
> +	return 0;
>  }
>
>  static int i2c_imx_runtime_resume(struct device *dev)
> @@ -1907,10 +1913,13 @@ static int i2c_imx_runtime_resume(struct device *dev)
>  		return ret;
>
>  	ret = clk_enable(i2c_imx->clk);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "can't enable I2C clock, ret=%d\n", ret);
> +		pinctrl_pm_select_sleep_state(dev);
> +		return ret;
> +	}
>
> -	return ret;
> +	return 0;
>  }
>
>  static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
> --
> 2.43.0
>

