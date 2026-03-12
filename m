Return-Path: <stable+bounces-224822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLoDFph7sml/MwAAu9opvQ
	(envelope-from <stable+bounces-224822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:38:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22426F08E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 900153027DAD
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD51D382F24;
	Thu, 12 Mar 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tRC7R81a"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A537B031;
	Thu, 12 Mar 2026 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304722; cv=fail; b=KKzLGPUJJNTpBIInzfvHxZwrZIOPWH3p61g9SRTKAYnkZWuwgDhOCMrHxzrdAQWzp3NGrJ2WXLvFyqtCDWdsYiayLTABlPug/jpB+sbBSMSgSamJV1xaJzNge2ybFIXY9rTth4s7p8n/kygOfpwMUcgy39ZqI5v+FPn9r/kjUl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304722; c=relaxed/simple;
	bh=IK2mA5TErkrofkpd44cEJqFGyW+UxTIDMBkDFyDgGgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A27ZpRaFMEsz5Js3IGFZUdqOgsC5+Q1PtYnNXgWr+xjvFy+TE7Uy52o6MQ3vToIbVshcqrG6au7qchRu3cFcxATzDLEppwODvrq1oKJwXmHlacQPo0GnG9tq1j8NF/27CztXRA9OWwqpZ+VXdK/BUsAZxloV2ft1J5ga2J7nGv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tRC7R81a; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSxjY+EgLo5EGWRLfFUqQHfdHGsyaHFzcxYf5H7BApC3c56IDQEI7cKTLMPcnhYD8ePpffgA3RKz5DNHn3t+BNdKwDfKRM+gNi4Ixvzj0Qx9xQyZdaFbVftJO2ipi4MQaj86f8io1FWV3UbTLNlV7qJzxcHGDE5hdx75/5t3oKWHdWItZSkcXbq1BGVieH0G6JmAGbnbhsW7yP4vwd8BgE4hONCJ+G6jU+CSAxZPe1TLMRC+kuXsVfJv3wlLXLcrQZourUQV6dkJwKbUedwEkuRQyFZ4z/Aqeho/RKlF/fkhheFReWpK4IHmCQkAsj4hFm07mYtYyo9GfMVTRUZAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK2mA5TErkrofkpd44cEJqFGyW+UxTIDMBkDFyDgGgs=;
 b=QcxkMKD+dvMD9ITi+vNL6W8RqLyILL7UGIuyCmm5OO+KX0EM4hkiTeTFO1EbbaRSY3xN8c3ZfualMigHm6sIrP9B5/YIGawOtATeQfz0ZzK0Yhiob9DnuPIXmZJwN6p7cUeNV3h9wsC2r2HqgMW4z7FCXdv8YQZSQeQ9QxV0z9VOCOZCpflRHdrr7pUhjNkzBqNMi7qVvFN2kdsKDzBPiZW+T5FP6PaOf5gSi5n+6owUqtA4smtYZL6HgWl7Jk00vAuDjDpCCKPb9jLkBvoSQcGd062+jByWpj5AnpB9CNyy4AfE+cw1dUjXBimGdEn/jHuEeBVSfeR/nJ4w+9agPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK2mA5TErkrofkpd44cEJqFGyW+UxTIDMBkDFyDgGgs=;
 b=tRC7R81asuFi0TesiI1SaBRDyoap8o8kXeoeGnrOmPJdP/4QJmrRxTDL+1hV7XTlKIycEaBQZ+v2SGgnXOCHWnUHrMktuNw3x83gWO9/01TaypFVeaXIP4H3+cyui/on64MFVbfAq/lVUNl//DS8pnW0AUGCTeF3dIfVFKPAd/nU48wlxmBQ82x93mwSK7/tD4ugKzJZb2H07wZE4RRnXyfSEShpSSPPFaLbzJBWgCpJ2h8rsFDIjHOXK/2rstO10y6JW74MJjfG6Q7Es8ZS2YJRFp7n7vJxxANit44GsG4dZKJWhoEcOaMxZ1kYUGgd2eoBcbfYFK55i+15LyEilw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11991.eurprd04.prod.outlook.com (2603:10a6:800:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 08:38:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 08:38:33 +0000
Date: Thu, 12 Mar 2026 16:40:36 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>,
	Frank Li <frank.li@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
Message-ID: <abJ8BJvqinG8UVRw@shlinux89>
References: <20260228-imx8mp-vc8000e-pm-v2-1-fd255a0d5958@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-imx8mp-vc8000e-pm-v2-1-fd255a0d5958@nxp.com>
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11991:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f0f51e-b890-4da6-668a-08de8012beaa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8bsGMHVfytqCC2gJuB4RXwZ9ztQyH9oH89D3MKC1s5BNGXCM+VeH1oaszVN6pSZbzIQsfAUxEkknaP8g7Yqorwgw7FSS6q5Ks0GKgROoz997zGFEbu61x2gRAFPLuFioo5u3VD2c3GOxaeZ4MxuxiskzwhrJW4rxh2P0lz8m70XSjzn6o43MaCIOCMd9m3Lsn/TJxFG/srXdeQ9/HqSydWa/o8q8j6UMPzZ9Vwudji+JGj5LOVx15BzQKAv0LCQ7OkPeTBlH363s15/hQCjpEu4RYvNINZ6064S2iNiJZvt4Y48IN9bBvH7KK8bkLAix2BmjVBCORGt6ew3CUaMg0HbwhwShg9r623wzgdZX9faf/fEdLW0FvZFixNZydYUYU3bcXUQPf58RuAf8HZIBxbL8OW8PwsClgisGCD7oJrs6Pjmfh2NicStq0Tv5wA6lEhTCFNWSvBISxKfbEIXqIWDf/+p9ouUlVjVg5BRujZuNN2l2mydgz6cS1Nfwwpo73bI5qpiDmrzQfZAk2mBUWR+vPNCcdJ4VnCZtWt9c8eM/LU7KQT7nilcPMYkIcQQgR5MYgvq3b6WqukNi/opyu69/10zr5wNB+vRPCUw9srbt1atrSLzendL80bnxi4k08ujyOrDxA73S87EHnsciQxomUyF3hJr8TLK+iCM7Of/lJy39U/LQc8eUEWbfQvOha2iq6h+sPpxxtiq5ghjF+Gww4g7J2zJn832r0+C+am1pXTIVXlJsXjjwFk6B90QKhWdAQC4Qvghux3hKUr0peH4Fs+gxVq6bNnFEqMLWIQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fdnxsYgzQIlSn7y6mJOTJ3jK2mulsMyXjCtpULEm9cq+DETjssRQBvkJgDS?=
 =?us-ascii?Q?fiJM6x0K9BWim9zxw07cVUFh0QDcA6pHjxAmHFo7ftk0C060H0lF5+73TCrn?=
 =?us-ascii?Q?/PCpNlG6rDhW0alJpTf29cgbBn0dMoG+Mp0Zz8Qmjp0Qc1QysrayJzeqfGZp?=
 =?us-ascii?Q?bz0BzQohox2fjqYhog1+gAtEGdOlwabywPO1TXQrbhOfsc1ngTp4Xj8XFUnk?=
 =?us-ascii?Q?1LzbFmsyjy8tFm/Cl9wFIIR4tvpJZqpp/fk5o6j6Uj5I8CSiQ+81CB+a5SyI?=
 =?us-ascii?Q?v9oXvVKPaleTqqClXEuQPYmkig10N1KHMIjoPYYoNbTpVoc4X+sgxZxcddCG?=
 =?us-ascii?Q?+xImDUY4Wylp94JgDviGk2eJySTy01ImbMYV0laY4QiHqY++JDF273QeMuAv?=
 =?us-ascii?Q?gq/Nm78V8mb45X4+vRrP1gHM2fYYoOHY/mhx98SXRxpG4PY8Y4K8fGpmRA35?=
 =?us-ascii?Q?acuhLoZNEnhvl2yEX333p9dkh6yMhxenRwiGbzYap/NqoH+DMxCZB2KA955F?=
 =?us-ascii?Q?wBsq5nvshhvAcXt61x4PFNfgyWMa5akrhHQTcYv5mzHEyEfnENrOBJcQB/Ol?=
 =?us-ascii?Q?1aWNknx4VtVN1iWuzqMK3D6+yooFzu9jWYo923EiJ90M68JYYdjUTUPgeyJh?=
 =?us-ascii?Q?Y0hsCEDgStlibRZxj22vm323ZMoI1cm6mZJmDLotLmEvkYyMZ4vA8MLiRM+L?=
 =?us-ascii?Q?gZRXSX6xdPAfwiZEFI6t+NcBuY3soC9nz4fquswnl2py+t1iqtWWa11s+mMc?=
 =?us-ascii?Q?WAu2t350OfY7VFoFiU3XvkQhG0vN5PFiHLFoxIuaWiKYHXMylTbBUn1GXbpC?=
 =?us-ascii?Q?03POAwJvu4tGXDUu94BLQNfakPUbz0kgDH5wcIiwbb9E0DFivQ92JXv7QYU1?=
 =?us-ascii?Q?KtWESnaG6yPjkGe1GhRB1RIFImZo/+w1CfPvRJkc33nzasl/vEbYdfJynV4z?=
 =?us-ascii?Q?/zi8RMEben/DkcWnNGxZBEUWEfs95kfgRMPDRxaAaghjIitbxlGi0OHd/if0?=
 =?us-ascii?Q?1Y+slQQW0+W639y73p7MISn6Zi0Bwd97DsLgKI1cpEjO5KsFfcs2PBm8MkJd?=
 =?us-ascii?Q?tMh+zEOSCI4s8RszulKqRhD6kc1IId+NBFi4TNlbrAzACl2cfC1f6GER41ux?=
 =?us-ascii?Q?aseb3hx2owoSyX6qau6lKD3NgjiLtfg6AR2GuRJS8xZgaC+PDhyDe51jkGFC?=
 =?us-ascii?Q?XV8j7UR0REZqrTmm0PYIzHCQNErC2VBLQQi3iIu2SURdz8e/F7V06dvjCRPC?=
 =?us-ascii?Q?M6Xi9kbFTwmvJcPK4MKsr+fhUMytGWnoyMizRkdfPRedjRX/f3YuQP2mrWx4?=
 =?us-ascii?Q?L6oNfwMSrLMvfwDZf6UIKS/RbAcYhF77tqCIkil+U9fGsnT3y8eJ+9HlUS6T?=
 =?us-ascii?Q?ivlmTqbu42HrUOPjzURRuaizTiQGn0RyXGud1dxAKjHtqx4175YZwUibP6qS?=
 =?us-ascii?Q?5Q4NZEutcRynFWvGpAXpQ76lYPRyMCJB98lAQIFobQIWJjMxJLO97kVMTdGH?=
 =?us-ascii?Q?Y7OXAD3Gqw02SqoM3NyW3CfhDK6EeFx5BUK/A0Ili6BXqfAa4IJ83JE1Fen9?=
 =?us-ascii?Q?Gz4uDYPvy/nO9cmBJyIS7PGiLGmKqFDdN2T9NBLMnCfs2snA+E+2joviuxNA?=
 =?us-ascii?Q?zMDTKCRoRohV53+FNSa4nYDOdOAFZeTMSHMWcGzMyRhH8BhSzcU5C/SxHH/A?=
 =?us-ascii?Q?DYcBq84yL9rzKvGGRQeca3tTrsR/ZA7oxI4KwdKhE+knT24vpsSAhSU7PwMd?=
 =?us-ascii?Q?e7PjBvaEgw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f0f51e-b890-4da6-668a-08de8012beaa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:38:33.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6csJxpCz1eo7dFQSDV7LGFshn0VY6PR6X9sVohA/VvtKl0jjTr+bPTAooAvTU0WpRFeUXOg4zOclo8KkOmFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11991
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,pengutronix.de,gmail.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224822-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email]
X-Rspamd-Queue-Id: BA22426F08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi All,

Any comments?

On Sat, Feb 28, 2026 at 09:12:45AM +0800, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Per errata[1]:
>ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
>power up/down cycling.
>Description: VC8000E reset de-assertion edge and AXI clock may have a
>timing issue.
>Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
>both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
>VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
>de-asserted by HW)
>

Thanks,
Peng

