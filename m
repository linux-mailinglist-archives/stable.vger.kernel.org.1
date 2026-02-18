Return-Path: <stable+bounces-217306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG8YNrLnlWnKWAIAu9opvQ
	(envelope-from <stable+bounces-217306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:24:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22690157B43
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC753014968
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28127340A57;
	Wed, 18 Feb 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aaEEowf6"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4B334682;
	Wed, 18 Feb 2026 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431780; cv=fail; b=r6t8X+eU8MUtss1s9/+5RysBvkHN9C9Yx6oWrzgG2XB6DMjlXUQ7iEWCgWzNVFRBBliVikh0jwBJU2yRonUx9JUg+5N7nXgvT54RmPDAjePGk/wpmhD7WTb1ANdUIPPjZxgeB32hbB79t8W5xJegSr7rGT1SSbsq0iYyxPNRLwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431780; c=relaxed/simple;
	bh=fPsw1kldIiXrJuHwTPybQXMkPqW+kTEbLRtJ9pl37Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IURgZQdXL1QsU0jqENuLQlnDBlM6BfjS2IyPWlox7YnMStAM9wTyG4YJKzmE64uPZAkzruJ7CtHHQZjGiHNmo0VpbP8sDnA5t+uxp1F6HP/gQ0HA/DWBu4IOtdIk8+l1pyykXt0HuwZUNcy/L02zfPu4f1nRnJQlMStbJR1t0wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aaEEowf6; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXJykL4CZ0zsmnQOmBbET0zWK/SEW/G/2QErcCWwnOauc6cJ+JCiqiIEQQHUo9atLcAjhQ06hgobCq7FThkAJXQ+aq+6C/0lWDLVqi7mNUqzFKrucXKx4X0Za8jxY0o+TUwhUf30ZIq+JIjAh7yOgTv2tqWf9h91CwxzB7eGEur+XpMtVwp7J6sDDAmoR7dg2tf6yK9JigllnYyzEfDYpP7dUJ8oM+rCnwMGJw8BgbWGWi7+1XP9VBjaDM/0HQDgCL49NrpK5Wg3gPZuWNonuuw89ewYZ6E9PdkvNPVTu12tyQ2mzZeN3y77bHVn6uAmY7JT0t/0zMc6Gn8f17gARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iih5KUiM5tM+QCOGXlFAiLqlRRD8LmUO0lR/3Gk18k0=;
 b=pykhhjjYHPNCdxmiBHUGnqilZCSEZh/pwNNWQu9VQBA6VU2Um4xFwk6BCaBex9aPt1FBcSnptKTZm4Fg9FSgx9Ht1mMueGlHj6aigXwwT6+6SWElAMjAItNFxRgSuxLL5rOxhucjGt6Q3H6BqrE3KDE0yJv5eI1egl5rWUEcLCox3RlGkX8b7jM3MQeSwj/MM8NURds16OsIbh258vx2eVIbC0iFc9n7kmkQeyB7O4atOh2zgoTXomKYgI6orFBu9R0CdaUwVnRmhkVyvfJldFM21mZsgOJqpT4c+sNL2xsV7wlIQRVL0oglSMzsF220ykuFbVRxQ65UnKp8LOoFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iih5KUiM5tM+QCOGXlFAiLqlRRD8LmUO0lR/3Gk18k0=;
 b=aaEEowf68GFbgqDDKAGLtlzTNSDkSCxTIW58afd9GRd8iYihQOIuULo1kRXAcVbO9yaAfuZV2937zexdz92SVmwgrLdumbA7FLySczznQOcGdDiCd9BEEw+22HN/o92j4X/mGm67+9FWt1qiwUrwGB2Eo1PuMYchEsADQY8mg7FUuyre7dg9S0FlX1FIxuqgUdVQOosu5DSyVManXabq1rTgjmvOZDpt6rVXBfGt4T/ic7cSMXoHIzW+vBAmRoWzDPy87wUFH/tioZBsDHEPE1MI08WyIxzqAnh2SgTQBEbOLqSA1RM9ylM3nmhJFkbtxRorYQLDNicsIacrrREj5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 16:22:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:22:53 +0000
Date: Wed, 18 Feb 2026 11:22:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] i2c: imx: fix i2c issue when reading multiple
 messages
Message-ID: <aZXnVHOuNt-2JnhE@lizhi-Precision-Tower-5810>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-2-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218150940.131354-2-eichest@gmail.com>
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: ab354887-2260-4294-a598-08de6f09f7ac
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Ogzbuzysiitn2LrbKJFXlViOY3Z3viJ2nZmzqszcvf0zU3NEB893aMwJUbbK?=
 =?us-ascii?Q?1KZ/GiHYoVhiKvy5zz84JZ0rZP5entjZNmZdFF4sUWYhxhkK0glblMaGDzOm?=
 =?us-ascii?Q?N1JyDQVuDkiDy88F3F8hyTyY3P7ll9efRlOuNol0qD4UNpBjEkP0Y09hgz36?=
 =?us-ascii?Q?uhFyGyOYsWqnE5/NVNulg2QK9dL/rroXRmNyw3sLL+A38hnJzjMi2MBW/gXm?=
 =?us-ascii?Q?JFUncsu6GTk3XSJx6o8ZPooZouW2QCjuqK9M5ax8XkQppzd4EBJq/9zmadBm?=
 =?us-ascii?Q?AfLWWzUJQqw8w1z+VSvyqT9XGfC/fd679t1mNQyy0VUIzBwtb9SroLgq9Rt+?=
 =?us-ascii?Q?sj9tJRr0IULfuoswaaOJWCkmeNruNB0GtQIo728qTaEN5M+v1knf5S1sOpN6?=
 =?us-ascii?Q?e9XLH5mEsIntbQQGwdQetq0Zkqwj1dFsZHfuUC20vnSH/Chu9T4g6PTYcNHK?=
 =?us-ascii?Q?b8Jha6l7/D7EIlDEsGOdJAQRKZROrquSrN2y5F2Y8CJhBThkCsaOHWIZeVGl?=
 =?us-ascii?Q?+3KT03Fo/Qzm5c7ZWRZLJdX+bzZSTXmrkT/5XnJyBWKq4rmfEDT/wYv6GzsW?=
 =?us-ascii?Q?TH5rmqVHbm0+fPm1AEwaaIT04k2tVOSRnhS5/eM2Xn3gNzk1n30eLeRYBdX1?=
 =?us-ascii?Q?/+QwhqjFkLcWsJlwLxE2y1L8jocsQXiV5ftJ983vy4JcLxnMnwDeKmjjUmc3?=
 =?us-ascii?Q?TwCJ8YAa/7xULpSSaj7MkQI+LDcVXE8Ndp+ZPW2prg1ymb6fLTe0jymTXUmP?=
 =?us-ascii?Q?WDVMyA9i/d/zSfi3i/wXGHVYvadcdTwK+oNnIzVAUiZq5XT4yCRQprhFvpw+?=
 =?us-ascii?Q?l9GwT/1oqD1mOFratB1MbjhurPWYM0+mhmjmrkPWBgJo1cfBg0Nl7Ur8JOMp?=
 =?us-ascii?Q?/gUeiuJGbWUi13bn6AJKr5U6bXSBwILaRYdFBOkuD7D3AO1+PQ06+IpGPoEA?=
 =?us-ascii?Q?lx6smVC9UXfc9I+ADEg8PjRkx5QKJdy6as/I5qdgoLmRvqNNoxRmCYEIhEio?=
 =?us-ascii?Q?BZ9hP0Jfw0PTlP94F1Fkda88ujeUhNjsoQ5JkRSSxxxQGOAA73cPNT849dsa?=
 =?us-ascii?Q?crH6SJIOPHD6t+v2gXd6pKdQcbXAje4ns9dCOXL1/otq0+3ErJbAKtX05vZX?=
 =?us-ascii?Q?hjHzgJstLiKQanqIXqQ4WZMpuKdkWey/reYQ33lYqdu/x5Sf/rxwh0pW5rec?=
 =?us-ascii?Q?4CO/Yh8j2IfgM3bfKr6GI3V66OWa9FC8LLdex2TReGTnekBg+T38nLWKrFrf?=
 =?us-ascii?Q?pPur4ggVOuGqkDe1W1ahXV+RhWKZlxDtfq+sD7foEqksVzBiv8nJ3NXPp6Gf?=
 =?us-ascii?Q?ysK7iO+wWdm+75qC6PaYAoiefq+bAPbKcL4jc67/XPCMnhYP4CES+Nhav9+G?=
 =?us-ascii?Q?D5BagVf6XHOyvMLeC2tTbL0zHbT4tq12Zu2xyMo7XFDAHvTwz1TcxcAs/Uh+?=
 =?us-ascii?Q?Ll1m5xPrcv02W23uty1oxSP6BR0QZG6fo97hNOq5iktomKo+aTewhxFpAVmC?=
 =?us-ascii?Q?fa6Hi0AHrqkOA77MppJ8KMYN/8dJTXqqK97C9fRyB/OxT1R9GcdDmpWFxIZX?=
 =?us-ascii?Q?xVVU7cSpZoBzIZRKpbZ42Z6NsOSQwPzHNuwKlAOoD7ve5aAR2NjeIqsdJupx?=
 =?us-ascii?Q?ZiK1sCcTcWbNfgm8+1Opbu0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?hlWp/nRSsD/bDpP8pzWn8PvHExwPXsMh/gTT5sxmB/cy4NCNMmszAfDgm50c?=
 =?us-ascii?Q?aAytMj5CEK9aovpqJuyz9NEJpuw64SHxteC95Jb7i1L6RVzFS5SraE3C/H5K?=
 =?us-ascii?Q?Jh9S1TEAd4wbfXXDGDXhf8Gb33UVF8YKqlOMsUwhEqIeBYBGVRP8o5clSvQA?=
 =?us-ascii?Q?EgXtypBtGtdc1JCJcZsQotPVQPgm57ModdpRAhEBUAGtL5TZFaeJUkjwWlmY?=
 =?us-ascii?Q?eLRLK3BhZCRLhwCqTVmhNd49IMhsPkr3+RxnPT7msgn+ZrmFhLv38ZK83EXf?=
 =?us-ascii?Q?yiG0tgTBbWGgwj+ruSKg9kbPcCO40oaGEK7GKj6+DdE7qskZx/g8XlQx3Zni?=
 =?us-ascii?Q?FT9svFNm1UiUm3dvJVaoJAYDtejbY/+B8nRbS/kmV7wdN34sxqWIdl9M326o?=
 =?us-ascii?Q?JleueSfp9Rg0XI1f7PNKD9bkZ9pgSP5UA+tmEV9/ELBLq5+ATOoJvN7hsNT1?=
 =?us-ascii?Q?cT2BH+cKt1VA/sHHEi55oDxvPo8ewGLnH+YyCru7mAb31Ru2edwzt350woMX?=
 =?us-ascii?Q?te30tz5p2hjXb634GLwKnfq42GTVW8nbzCy8rNjAPp2ARKJ8NZfLkJC+pboZ?=
 =?us-ascii?Q?8DujrbVETu+yz2wBTZmosk0TEpQIQgbWZsEXh2NEi1IWdnn/KMrFundpKmru?=
 =?us-ascii?Q?d/26+mFd4cPTwFAxUiihnM2q0D2GQNkb9cQu8Ug+JgRW5xoCSTiEjQnm96gK?=
 =?us-ascii?Q?8gU1ERI/fYPLnEjm8hVpcyauQzMb47+NL9UB9FQIjUWWLeJY7VVHM+dPFufQ?=
 =?us-ascii?Q?8T19wJSoaqJWNFUr59OCnHiIfsjc3SRm3KR4lEtwHwoT+gN0Wd40MVcfhaq3?=
 =?us-ascii?Q?HoMbDmC+SKlgyGEjYyrWYKsOSnX/Pu31J65xba831sdiw3bugYF6UqzV/nbP?=
 =?us-ascii?Q?npKNV03b6x2CrdP5RderzHyL8weULNMxNhTeleSyvhhdCHTsG1UiRTvWHbDh?=
 =?us-ascii?Q?QD/tWrxp6vKBI0k18oQGv/nphhu0FScvZ65n392PTQ6sMZIgpm1jE5izhgLf?=
 =?us-ascii?Q?d4nDJEr5LfXuQE0B90h1hKOxnoNtkRUbvnEeflquDyUzoFVy7Cf5ik/9mrV/?=
 =?us-ascii?Q?5G+yNfTS83ErclT2oAbffYUSyi53Ho5HyLhNDEr7pF5YS8pmzCeVBC8rwQ2G?=
 =?us-ascii?Q?7z4SZYl6vyP1EIbb7VDF7v+k5C0xo0ZB8XX9fqR67jAC/KHHmkKk25joYUNP?=
 =?us-ascii?Q?tQytXuE2urf8Out+9WPGxtDIbB32Y5cd7j9kyAYZRk3DpK3oTGaL5IhNz0b+?=
 =?us-ascii?Q?Fa/90msGejBbEn76/WEQELiWp3PxyqupZ3tRaKvkiQcGBGq+p3URaPZ3l60J?=
 =?us-ascii?Q?TsOyo4xEH9zV1YtGht+htSpcFpHBF1vqwgyq0MfQM7Ek8Q246zCLLJaXt+oj?=
 =?us-ascii?Q?WR4zbHmV9V9HdUrWXrjFc60e1bJCiEQuKGQQMdd/eYclgE4azNghlNBzVCfh?=
 =?us-ascii?Q?ky4PcLuTRx1UOku4juxkw0zTc1+2Aa+zk8AzY4RoPu/Y1gzT0nK5R8VeDMGz?=
 =?us-ascii?Q?ZuWEuZ7LEHzErQLyJaV2MtQbwjo6CHg95i3OkS6aZmCQGTkluUz8FHcuf2xX?=
 =?us-ascii?Q?OGlLb35HrgrPiJsNUlBDPy2fWngrGhMuaSpHd3oo+YNVHhftPafnLqWnvr0T?=
 =?us-ascii?Q?UWJjiXNYgKma1N+y/9d85LKJ+M425YkagZkk4237WXVCsLyYngxqBO/Srh2m?=
 =?us-ascii?Q?bkFY7hr5YnYbDe5Ki8TcoU7OR+PwhIzUV71oAMozWZMdLQbh9q5wmc0NlHuD?=
 =?us-ascii?Q?mxIBouRr+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab354887-2260-4294-a598-08de6f09f7ac
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:22:53.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ReDEYDU+b2gvlvuCdM8sMuz1Spx2LJlmtqE1Yl/O80NgBYay8nIRJUrQeaQnXFMFGduaAowSNIA16QSPwbclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-217306-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,toradex.com:email,0.0.0.0:email]
X-Rspamd-Queue-Id: 22690157B43
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:08:49PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> When reading multiple messages, meaning a repeated start is required,
> polling the bus busy bit must be avoided. This must only be done for
> the last message. Otherwise, the driver will timeout.
>
> Here an example of such a sequence that fails with an error:
> i2ctransfer -y -a 0 w1@0x00 0x02 r1 w1@0x00 0x02 r1
> Error: Sending messages failed: Connection timed out
>
> Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 85f554044cf1e..56e2a14495a9a 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1522,7 +1522,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
>  		dev_err(&i2c_imx->adapter.dev, "<%s> read timedout\n", __func__);
>  		return -ETIMEDOUT;
>  	}
> -	if (!i2c_imx->stopped)
> +	if (i2c_imx->is_lastmsg && !i2c_imx->stopped)
>  		return i2c_imx_bus_busy(i2c_imx, 0, false);
>
>  	return 0;
> --
> 2.51.0
>

