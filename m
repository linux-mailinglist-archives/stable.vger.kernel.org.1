Return-Path: <stable+bounces-249627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAt8DEOFDGrIigUAu9opvQ
	(envelope-from <stable+bounces-249627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:44:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E7581A82
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7EA32C19E8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC49348C56;
	Tue, 19 May 2026 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P5sP4nQ7"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011041.outbound.protection.outlook.com [40.107.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70516408036;
	Tue, 19 May 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204559; cv=fail; b=E+pOji8ZSKWpDXP/O85VH/v00Hb6IC05TFJ8H/OgnB/keSh8AuRs3bddfL2ltls9D+4UK2zT+x3Jg93yyAYc9vzc7/oW9Xe+MGUVFNa+SjIWTycJKvo0j+HAes+bakiRqFHBhoWQI5j0+lTZKmS+4NfdWUO7zFSiSaSCl0tMmm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204559; c=relaxed/simple;
	bh=cAFiYzNBFgLU1qk/q5jKzgMJMRSvM7q14+NbYLBtbvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fqCDNbgqS6I9mfHQpIoFNW68913/xCGPPW/XYcR6O1Pf4Cfz4ShXNag9nhXG95+ryRaSZT6z2HOgVf9v3L+M0jX8cuD0L027B0aGWBg2YhsEHQbkZBSCEnRccNyb9efJmF5hgQ9v5OV8I5MhfKNwXrtidjhAqFGWnwVOTu9jKB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P5sP4nQ7; arc=fail smtp.client-ip=40.107.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqi10g3gqbz3gv8xqmURuW7QmvhdPVeXkhj9O/WtX1RIGsolFHiqtXLup0tdaFwG227xU9YGYbPHMcnSNGPgYEU8EkpNgKJT8el6qItjwX+/QkrQfCix4yRN6cqSLEq8NXowLPa63spgsq1xhBvVfKRJo7dCG+tx/uUv5pF3aL0cPzIaQTjLPrQQE9lr0KdqywM0Lgi+rRHfKWcGY7SqsvE19HYpV4wdazZfjEH0i0k4JWOZOkDpki9hgJbbpY1OzUq2dPHXUFz58/mE/mUPkVuS1eFKhgBXqGuSN+UAaTZCvZFnxqcS0ITbGBBpFzCfQ1PHsPcSPVLZ3pIPIswMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0g/Je8Tz9QrjW3hnNA93bKanthgd/ef4FKFqIG9VTw=;
 b=PcgfH7CxbLISQsmzOyE9JjF0fEKLUtN8OF0xeKZyckL9HnPe22uB6PZpyb0tOvIqD9RHQD/uK5PD20iPWVWrf0qtlD+W0xFHfeAsHjyTkPIFCYQ4LWWNrtNL11tYY3e3hYVpA2YPH+c08XB0nnFPd7AUcyjVAw0ELMwtj19yUIpCTNLY8+DV26Q/fqTUTjeiIWBuAw5e8RoxVcS2XgCht/zCfK0cKuMIPqIkEO7YjbQDqo7C+t9m4DVf9kK6s0x/Ij2shJf4+xQ+dRXGP/TDdeinRx+7cwFIqPd2t7uQETDjMngKihJBQ7MeCX4k3Xqy+d7pO5B2oyAL4zKSdwmNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0g/Je8Tz9QrjW3hnNA93bKanthgd/ef4FKFqIG9VTw=;
 b=P5sP4nQ76vqQlNCuZlzsaHNNqtlnrVoQqoFma+6krFOkyMOo2mK0ffQVq2PDmwhj3vC2UdNASxo+WTW/sHccBXv9/50Ytdcl6+zUhN82PkAN/8VPvUx51FQcLbHb0hSAkGoLsaVCf2ldCz6faq+WohqK3AdKlbCERbkqaPK8StP8CvsAMd10VUYSXiSnXqKhkZWA+jDNB3Ig+otKZi3RjUI8ANrOaqwF9UaK3gKlgBgTkqxN8HMZmiQVZbE9+tHsX52D7vnbmdHD0iQoM0Zw9EvimvAjR4V0zzpgHx4gX+f8HRVzI1C+Z1RDPoSj1Ry6z3G9/WqC4h8M1VgBRq6SiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7826.eurprd04.prod.outlook.com (2603:10a6:20b:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:29:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 15:29:14 +0000
Date: Tue, 19 May 2026 11:29:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] pmdomain: imx: Fix i.MX8MP power notifier
Message-ID: <agyBwfAxcFs9Nm7i@lizhi-Precision-Tower-5810>
References: <20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com>
 <20260409-imx8mp-vc8000e-pm-v3-1-3e023eaa245b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-imx8mp-vc8000e-pm-v3-1-3e023eaa245b@nxp.com>
X-ClientProxiedBy: SN7PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:806:f3::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc18915-a2f4-402d-bf20-08deb5bb61e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|366016|376014|1800799024|56012099003|18002099003|22082099003|38350700014|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	5t/Tbxawh5NcpdGZCOKsMINfd0w2ztq+fSZB0bMLBRw0xp27uo6B3YZ+BI51pAQ2GkTGiqwdU7wvN4xLe+suYYcpR1vGQI3DkuBk96/72x3Bq3/8KnlKRLuFc4ljS5zeusfBaq4drOXniwFdIDtTIIYkJubPVfH9AqjY25TQcxAmp4ZgwkAVOzaJZIKKIZ34R7CsK/GmJ9MlAvV1IpUNfi7qWvipSeOMnDHvWHbFbipRiDmyuaZwlm+LkNnZQb2eMStDX2QY8Xm2EHlvY/UVNYM6yt/rLrt/Dje29ivjbHldjn2cDYzdaoJsIGh/Hvmxsnn6dIUEdWMw4N1vW+3N6tztfFWsRsJ/h7llCxlOUJK6k1oKdAePQNJBallCFReXGdtA/cwhZMMGRONGuluyc9b0vQ880/tZGQdXfFONCk2MgoaenXadm7ev+1+2MF+lWlcr7bWiiWucWRE5X2lLDjcjFmjtT/rNGxAhGrsPWMwbwurerY6/wEoKTvQ8rox1Cz0cOWKKTtPPVHVL5O5HBPoZj+vQffFlmj8aBGxPyHCydtPb5cKF4Vpp6gdyHizdMEfaWdZrOPmaF4GyU4/q9CRMGS2lw7QYVBI6R+Ha2EfSUEIWgGYLI2jCm8L8lRMpBx5cvM5NCL+r/HbOD3sO5bp1q5RJy1YcSMN0NS98cMv2qn+ybFUIrtJWw0y2FJuNhmCldOKo3AlyGxNZEmeHRSUDEcQeLEwUuvhD90g4dBGGmJRe8Ycn+79+Jkzjx0Gp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjMqt0kfJZulknD16tz97q5JlIzJHfkRZNFXMUuJhMJO6OnSRZRv03aMMDkN?=
 =?us-ascii?Q?0ITkL/A4iLiuAR+AaMJEC37GdqFc5eV902j//nGHz1mEWYqtP77Jtj745zGy?=
 =?us-ascii?Q?czuqci75FfLZdU1jMhmFhWW0MV1Ibple3o5iij69ogA5UORt8BIFC5oo2qqH?=
 =?us-ascii?Q?hameYLYfkjySDJITHOJiGk0ikwXxdOngZYUkLg596FccBjrK4pf4ylLKMgWl?=
 =?us-ascii?Q?Jd2UEu/Rwt+b51F3HwN4qyBvCjLsGvNDbmYkinLtjNsU6YrVeOAcAwN5NNfc?=
 =?us-ascii?Q?sXznMvlofELNISlMHgEGskX0GVB/tiQjObdWU4HPJDvvpmKDDROy1ex68YwL?=
 =?us-ascii?Q?Iy7o9yPoQfiFY4CgvqEvpeXfq2SNl96UQDoGu0fUSGO0EhrfdYTcDlGoBL8C?=
 =?us-ascii?Q?eNaJwmkhhPuBaJPd1Lf0gKRLRsBii0odtqt/S6OFjfOuQ786JJqGcV1iyg/A?=
 =?us-ascii?Q?taSNdEQUfQG08axcwnl6hO2zEjTBtDygiFJeP+Nw0sgGDJ+7lOiy5kCMe24o?=
 =?us-ascii?Q?eguhgLITAFbwTR5uUz8+tVcDBrGh1/pYYFpBs/Kx1/ACbqi10pt11ttcSzwz?=
 =?us-ascii?Q?XtHaLldpHVI0s7K720E+q4x1ovCtAMLlFeYOC/lmnhWPIN4gWxtOmvvT4RN9?=
 =?us-ascii?Q?164EPKGCZG8tkY65z+Z+HGm56THF0+mMs9Yp0S3vz7J2ZgdzU1zKhBvp6gs/?=
 =?us-ascii?Q?+koEfqmCM6vZsQKl8estMWMAvA6abPPI8QCRPVGoIaK5Fz2oRwKtKZ7mPyUR?=
 =?us-ascii?Q?UnnxfCVo5cBBAvthidYRRY/Z0HfKofMPLFFSmE7AiKUsDXiR2oFvqkh1KU1A?=
 =?us-ascii?Q?OEO3pXJGh+zvmVC49YfzU90q03vFN8hdKBrsNaXlzK7V+hV7Aj17Pcomup2n?=
 =?us-ascii?Q?5gHe5F+kcCFd/ac5Hv59Vj9e77X4TOq66ntsykhC4kfPwO9FKsUNJR7lfOmH?=
 =?us-ascii?Q?U0nJac/FezKO7batMLAEmeUtT6RRZQFed2cbCAdcsm8jO8B/ktwOX7wDmTWV?=
 =?us-ascii?Q?7zBeDuVK0TkCsXOsFLGI5l26Ks8dA6HekikTWEXtJn7Wnv/w1RucgnamnQsC?=
 =?us-ascii?Q?bRmqAWlP9iClXz/yny/QpZX+OR3JjKia96VL7EyWGwldnhlnz0xbINrq9S1b?=
 =?us-ascii?Q?DAOYXAkeuyQ5E7dSw0NRx851/bx2v6PN5VvBgRiDZvnb5RYYe7ItnMGI1G1W?=
 =?us-ascii?Q?ifZYqX5jAtn4/XGgJDFktpGFYUhzK4SW8zQCynAP2ODBW6d56Y2r96JDyaEg?=
 =?us-ascii?Q?RNBbVGW/3eij5ZIwOkBfb+hVOz7EsnfEqY6Hfme9gikUGlmpx8XAesmAkKNL?=
 =?us-ascii?Q?X5DQM060VJfE/Pp8b9X6C1fAIU9JwFD+9m8ir5g5qF59WJp1oZrz2vyxSKMY?=
 =?us-ascii?Q?mFDiqcT39arIvpSCOhGyE1XDeUUCqWInD03Kp+ty1otdEcpx4yB4nDJP5BZP?=
 =?us-ascii?Q?XVnHvPlgJAnyD9+ajr3mvxpmPBIK7tWIRgE4ZROnGjDpJRn9XTCSy98lK/8u?=
 =?us-ascii?Q?yKtPY1y1xlM+0W3xNzI9SaV5SlKmHv/HWW6k6YhXO0NSusyBy46E+/QYjOA+?=
 =?us-ascii?Q?osIPbKJdslaIZdRoH0uGIgB5M0ZToxjLUfWWqhS3FRWuORaKvJSu2rgU1ZmC?=
 =?us-ascii?Q?3F/FOny9K8MpKKAQQOPFJpcocWQhvN/tGqLXmIXdFL2rl0QqhEC1tgTU/x5T?=
 =?us-ascii?Q?onylT+n+NhYu0h5+Sijr/FUUxmwazQPabunvAI7ldznAPDKw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc18915-a2f4-402d-bf20-08deb5bb61e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:29:14.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkS59LIFcN7HRrSOKZ0eIZpG65zHIcpxFVLVMjbv9+Iywo0ArV9Z8ePwLucedzaMPvO41HC8USt065H1xLrXqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7826
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249627-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: A66E7581A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 04:07:17PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Using imx8mm_vpu_power_notifier() for i.MX8MP is wrong, as it ungates
> the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
> but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
> imx8mp_vpu_power_notifier() for i.MX8MP.
>
> Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 19e992d2ee3b845bc9382bcd494a5d96f9c6ac44..e13a47eeed75d7189aa15370a7bee4cceb05a1d6 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -514,9 +514,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
>  	},
>  };
>
> +static int imx8mp_vpu_power_notifier(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
> +						 power_nb);
> +
> +	if (action == GENPD_NOTIFY_ON) {
> +		/*
> +		 * On power up we have no software backchannel to the GPC to
> +		 * wait for the ADB handshake to happen, so we just delay for a
> +		 * bit. On power down the GPC driver waits for the handshake.
> +		 */
> +
> +		udelay(5);
> +
> +		/* set "fuse" bits to enable the VPUs */
> +		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
> +		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
> +		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
> +		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
>  static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
>  	.max_reg = 0x18,
> -	.power_notifier_fn = imx8mm_vpu_power_notifier,
> +	.power_notifier_fn = imx8mp_vpu_power_notifier,
>  	.domains = imx8mp_vpu_blk_ctl_domain_data,
>  	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
>  };
>
> --
> 2.37.1
>

