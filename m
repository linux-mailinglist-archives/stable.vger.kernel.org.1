Return-Path: <stable+bounces-235301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sm3yEF0e12mbKwgAu9opvQ
	(envelope-from <stable+bounces-235301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 05:34:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E593C6088
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 05:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABE23015D26
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 03:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C62368264;
	Thu,  9 Apr 2026 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nFaW2bo3"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9125F7B9;
	Thu,  9 Apr 2026 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775705690; cv=fail; b=BRYHgLxKpnyXkKUugukDo7VlN5aaaB8wNYwXwWMUw0Wsmx3Re2s8UMww54zrG3M1g51ftGFOw2FIsBAS2yCeR+9NW4oLndZO5LWzi2DsyHQm4HxjGFrFszhORuXNosjJNpTX4t4E7cptj4/yb2d6hUkAxnpLXK0D1wzLn/xESoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775705690; c=relaxed/simple;
	bh=OG3jVtPVAHXDkOPxRPQuMDya6XpuoF+kjDVAkWfbgcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pwk4TR0usK4obxmllJlCkgJ/Ub7PxJhUQ95oIxtaw9UmHiHtEE6RD+GDLB3cDL5yPNfDuZ2eqC4jbrcW/soYj/xR74kjcJ7xHgynWllHzYce4cMYqTtLutTbbVt/gu5BSARiqwkUr2zvgymDwT+fKIAmnLi0QmLCHSQi+2d64pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nFaW2bo3; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0elGl8JEvLnXGr297y5zy+v2hMLhKrNqtPLgZUKxm+9lY8ApkyxcFfY9lJqZ4xWNoGIKm5mpp7FB3Tc2ZayNq7GjLNfyv9Y1f1i4A/k6OT02IYqz/OkvxvKr20iZ9Y47dK1EWMcaIru9Xy9sQXGFKK88UY28CEMRSM0EqP/s8NihdgeCpbWWhXlJmEqu/7dF2JPbx49zSx3ayhESrddD0+ho+ZyYXQwMnCViBS8WjctC4VnjkG3HkDnJ5Hc9wj0sJor0YRH5UPB5eV7kKE5uWOPDwH7oPUR//Ok7lHvFE0vV2znS1pwj/NOAs3or4S9OedGkV4I7XSRhkiiUNkEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+KIrMCJE/EP4jNOH+lQ5ryPmRKAz2kzeuk6e65xD4A=;
 b=XTB5FlQcKHX9EYohXS2Hw2QhYGqKgRt/e95RDlVSOlZeCbYDzYdudRgYeMPDPpqqcejw34ALnX2fWjpT8ka5Zj2K/zdg7/LXzlT3Sptps+8Ap7Wci/Cyd/DWkLl0msM5oUNP5/+OaHmrPkUR/nYi9Ppdxaza4KR4OpHVm+PODxdsC5RtN9LiIQaIzGbUAC+0Ea9zozq9XECHGZGfrTLlqOz7y/eHH/bYxfrtaCSCurhOa1TsdBz18c8J2F2luK9Xj5GDRNOH+ufAWQtsFUEkSCA+kloPaMOTLdXS8rFuethmiQTxDa6/adalz2rKOGI3s1Zv8Y33UIVwfqhW/tA7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+KIrMCJE/EP4jNOH+lQ5ryPmRKAz2kzeuk6e65xD4A=;
 b=nFaW2bo34VImTmd4tQA6ZHahYl7TIPc+PvV6svC/NeTDIH8W2G3ICLAJzicf/F2DzjfO2IxReuUx26gIuXwLOQpjNZEqRv52+WOiZWtp0UQEvkCwcmlYAR2Bq+5JWLpAmyuAyNWtrVdnOJLIjXbUmM1AZAodDJhVorEZPPFHrI6fQV85tq932hEmpK0Ya4nQ4f3UKdWE/OxNXGXDgaWX9EVzjYJ6gxSb1HxBmWU0O5m2L8zD9szClrKXDBGvrFMCAK6UO7dabFmhs1l0f1EITc+8Y2XTbcSXcN00bfsmU5HfjvqA0fuYSNZKxr1oNC2fvI+f6LJqaaXuvxBp68r0iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 03:34:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 03:34:46 +0000
Date: Wed, 8 Apr 2026 23:34:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: imx: fix use-after-free in
 imx_icc_node_init_qos()
Message-ID: <adceUA7PkOLjgyOt@lizhi-Precision-Tower-5810>
References: <20260408153022.401123-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408153022.401123-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 3392e401-80b0-4c01-ef8a-08de95e8f22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	5hwh+CaNRUqp/I11kypWJCtKvd84GFDMKzRdryuXvTLKmlCgM5bT9ClMWQQEmX3C4JLcw6HDLvF3ne2kkl2enfVjijaK5z8OwTE4MRfqu0PH8xZfnoQE6opL8EoqzxDa5nWn6xuCCHLDTHRYOt49qaYj72h2Z8Fx/OlpWnQ7O2gnjMWt9NkmH1SC+pk/RuZE2sTWf6kotBS6PPzixlLlJCPUoCPxIbCxUrj+7S7SQDPwrA48mTCbL+BQx0OkG3xMdRxFGyY9+lj0YUfvbLyFh9fG7BX4PzEp0VTiLULCWMDNUALMtNcr1A+3zxjuHrryWnwFMbKWHe/pciL56ZgrP4mSmknHVyQXgahoP7L00q1EI2G+VFspJdsi4bGO7szC//Ueci9VVSFI8xkyhAjBRZsZ5C0mm6ffaJRjKZaQNHW7O1J9Nm/0x1zhYgAi1jZ5nGpCd1+AmAz9ErP64cQweo4vE6d/DsNbv13c9muukgQ2fq3ZM9o6KcUjP9RWVWZbMCJLfXd/3lAxMaH2I/ABhnLr2Flim5uTVkVbIedChiP8O/nDYuiDPOvFD9kG6/dDiI6MU8HLX0dtAsBL9PKE0XrH98uDGzgglhZVBkPSDpCdvRaS1pGVWGSRlzIpHuNngNEt0o9vkfGHqx0XKrnA22cHr/4cKTYsoz/NkkC36LyanyDSxRNwKc10UlrUWm/rNC9Q77lp0bOByhAnn6hKy20JKOWFy/+BRGrtz9hL2tIDs7BRX95JEvkNJ7HA8bj+8RBEZwt+dsggg8DxAPIomE93zJpUGnXcHkdCprZvYuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ap2L2WsbPvIpDAA9jrubl/HhUdYQZkmET5qvY/8ul6BLJ0kYTrrHeI4t+l3R?=
 =?us-ascii?Q?HFXAhua8dIpMvhacw5P1AvBCzr7FFNwhv64FAdIscjQ5Gr5VzqVsCM0bPjhz?=
 =?us-ascii?Q?x+HMZgyuUIGX2gOiydT+/OpcobJw/fOqvt6lPhSMDFY8oFmgzPxwX4XANC57?=
 =?us-ascii?Q?ypNNm/H+xA6tf6iG8Dkjxb9ORw93ljmmRhnc1CZ2oZC8M/F8xs3Dtvhf2gcU?=
 =?us-ascii?Q?PnwzZtbWaSiPmuMdTaPqV09+dERcZOqjs7e+Xr7WYAzwCAqo820EVPO+u0wE?=
 =?us-ascii?Q?WNh2sZDedHfHJ0T7tldwuwoQFk5QncWBc0m2ryUD1U3KE/Z31I8Ky2CPeHBK?=
 =?us-ascii?Q?fnYobIUKcsE4teRon5duYJeDLEMwuYn9DV+F6lY70+HIphhNufsG1DPvRFW7?=
 =?us-ascii?Q?BPEM8sC/iZj7FWe9nCmLyqjplKr69JOqkqK9psWHrj84TofGgDO6FlK93ExP?=
 =?us-ascii?Q?8fHVEVSQqgjGoqDh/MlKvM0Z2qsF3T8HzWTsYhBzUV3aJTxtAA82cJYOYkiD?=
 =?us-ascii?Q?rI2Rke7ztYqSDBTBmSaN78ae4nVuN30REP90eepPCPEkHSJmZFTSqfQVxDN5?=
 =?us-ascii?Q?jLZ+GLd9u6NPtn+bmNq0kZOn10NKzjf8/Mkvq9n6a8HOTDPazILa11yllyMF?=
 =?us-ascii?Q?ZixoBA/7OaC9T5LhyrXUwKeLdvxzl9fR5TzchpQpGktyQ4XqmfVFm0bOBPoZ?=
 =?us-ascii?Q?Q6jKGxmHEzbNJ6Yge4n4d2dMPhQq/iazuGTlofuHvEMXkV2E66LJGLUc1jNP?=
 =?us-ascii?Q?q/uW8xBUH1ayhIJJnUxnlDru3hLHvQJnLb5A3YaleNoJjSeDO5ZbhixQKSYG?=
 =?us-ascii?Q?GCTZDsWu9DoEmo5tgDBtxMRnNnDX6NORXmSf83M4uvi1jho3YzFAbdIXXLG/?=
 =?us-ascii?Q?vnLMc8nEbboLSgN57TMtvlvy6SqUxg3m/8BfLHUZhpHbjDZc6ceS3klD7EQO?=
 =?us-ascii?Q?QhFKHzj/VcGhF55JvW4zGX/swrrDZSaPmekSGq1oUkAcud85kxhhxF4pDC/K?=
 =?us-ascii?Q?bzBBvn5IGU21+ebKCkOo6FsDxxjmBMTBkURqKgLTDhm1Q2d3yRcFTk3JpdbT?=
 =?us-ascii?Q?pGt4rB9HykKtQrx3jDKfpuSOgcE3HJsMtAglHFE1jnESF9jW+bVX5MGakIII?=
 =?us-ascii?Q?+s7O6Y4hjfcwKfrYQX7ufNYENAz2t8vpul4agktUPqdgqPOybUvo/s220DN8?=
 =?us-ascii?Q?ssIQf+fTbfWinPCakTtAAEzI5sVAASjnjO3enpqQBrgP9FALl1bciVCzQ/tW?=
 =?us-ascii?Q?DtZuKXAa1XI+fX+8X1rALCIzEFh3j79QP7Pf1Q5IemrExJlFNNDub6Rup2do?=
 =?us-ascii?Q?7K8+Pf/upPgaRqDgIhheIQ/MIKU55LCXM1dC0o6HYhMFOJtTolaq5+X166HN?=
 =?us-ascii?Q?zncwySogM2Llj2zM0qxozdM+mLo/Ka9QS+X4wHho3kzDKTUXuqb2FNI6d2lV?=
 =?us-ascii?Q?GUgUdpdR0k+ZePVjpwwwia5sbEHyDT27k3J0rgyCdo7oLVud5yEjq8DG6P0j?=
 =?us-ascii?Q?7ZiPt78vWE3kQbH8v38yOrbGh2bimrgdaiKhNnAn1A8e0CrCHiK6OXHMO6E2?=
 =?us-ascii?Q?CgJbmfRCAnsIW1oWiD7MOWptNQEytDzM4TQZmMwcImZ1zQTjp8SSc4h4dM9m?=
 =?us-ascii?Q?Nf8nq69Ii38RGBCK6YYoqEkXfO//ctebZ/72QRwXVFJ6KRqfkvw02v2LU6kl?=
 =?us-ascii?Q?Azk3sMOaG6EvKkDzglng1khqOQKMxHocVIMyNzj4qLl6HQ0f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3392e401-80b0-4c01-ef8a-08de95e8f22b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 03:34:46.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIzKDf6jcFAVCPmpMMsyF1NUHfui5rzKSmE7xA4D3o9OoKW5uysoFVLQdlxpQB4GQD5lqxlykDuXC63Tzd9MUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-235301-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,iscas.ac.cn:email]
X-Rspamd-Queue-Id: A9E593C6088
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 03:30:22PM +0000, Wentao Liang wrote:
> The function imx_icc_node_init_qos() manually manages the reference count
> of struct device_node *dn using of_node_put(). However, some error paths
> use dn after the put, leading to use-after-free. Convert to automatic
> cleanup using __free(device_node) to ensure the reference is always
> released when dn goes out of scope.
>
> Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
> - Use auto cheanup to fix the problem.
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/interconnect/imx/imx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> index 9511f80cf041..e5fcdcb88cfb 100644
> --- a/drivers/interconnect/imx/imx.c
> +++ b/drivers/interconnect/imx/imx.c
> @@ -120,7 +120,8 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
>  	struct imx_icc_node *node_data = node->data;
>  	const struct imx_icc_node_adj_desc *adj = node_data->desc->adj;
>  	struct device *dev = provider->dev;
> -	struct device_node *dn = NULL;
> +	struct device_node *__free(device_nod) dn = of_parse_phandle(dev->of_node,
> +			adj->phandle_name, 0);
>  	struct platform_device *pdev;
>
>  	if (adj->main_noc) {
> @@ -128,7 +129,6 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
>  		dev_dbg(dev, "icc node %s[%d] is main noc itself\n",
>  			node->name, node->id);
>  	} else {
> -		dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);
>  		if (!dn) {
>  			dev_warn(dev, "Failed to parse %s\n",
>  				 adj->phandle_name);
> @@ -138,12 +138,10 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
>  		if (!of_device_is_available(dn)) {
>  			dev_warn(dev, "Missing property %s, skip scaling %s\n",
>  				 adj->phandle_name, node->name);
> -			of_node_put(dn);
>  			return 0;
>  		}
>
>  		pdev = of_find_device_by_node(dn);
> -		of_node_put(dn);
>  		if (!pdev) {
>  			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
>  				 node->name, node->id, dn);
> --
> 2.34.1
>

