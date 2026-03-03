Return-Path: <stable+bounces-222903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OgQDS0Fp2k7bgAAu9opvQ
	(envelope-from <stable+bounces-222903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 16:58:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC001F317F
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91F33130908
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBFB4921B7;
	Tue,  3 Mar 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dy2ABM78"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968C48BD2F;
	Tue,  3 Mar 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553238; cv=fail; b=OOIN5eIrNqiiMeUSoD6LPCHLmFWnT4ulo0VMyrjlXXEvzOv8zHJ3/5thmi0doCJk7k4LfqyhGX1Sgbk0PtNhA5A4QFPKpzZ/8f/zAzPjoDHrtPEvitfu5zamlgGtyEkvhd+T7XAjhG3YhzlzuV0PIzs+cwI2B8YYFWdPsVhZoWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553238; c=relaxed/simple;
	bh=8KB7SJJedz0ghcFBRh7YECjx/G/N+4yd9t91ilfrEq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Afk+JwLr20fJ9KPG0ReipKM09J5tpSb4qlJ56GB3l/q8JGw54LDG8NhFZPuN2HuOzLoVtu/ucrmCmU+UxpQC8x8s2/h42iPQimJtgfXCd5GstaI5ccOCYSuGzGg6AWdaIs1htcGwjP0aBvVq+2VQ3JAmz4Q2cd9u66awDVYLL9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dy2ABM78; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wziwGCVFxIUJbIsxMc3JceWbcmHrfyXgxhwBekSPaWG+YhBvi8oihbPOmPXHUaHPA1JAp1+totAX5bYACoViUGHkUKlVrZhiHRuRKtvZ159rY+v6xHchAhYth6CPEQj/dF6CiQ78a9vEF3IH7qjYh6ioCRR9Le/0Oj8ZUHAQY654Pqxy/GoyNwJsVQvKQ5QzGu8ybeiT2Ro+VlEmYGhhmajQlawWlb502+atw9IkDoeWR61zRySIJn1CYpxbhPXOI7/MUNnz2zYdkSdZBRQZMCYTnTEJ1yvRaIQ9eybuTBRMkmZALauCqpq+uFHF021X7km/Kz+K4CTsQX06QoInaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KB7SJJedz0ghcFBRh7YECjx/G/N+4yd9t91ilfrEq4=;
 b=BE+f2VNtW/80TYr4aei/ygkrrmln7PB/5D6sAni+lzbKFC5TSJ5ti5HuKIvtUKRYUF4NKLRzoN/usXAsZkEFS52a73pgGkmLPFeq9WaHhTrFdzczGFhCEBnrRzWWDisOaaXAfaEYKlieIIA5ld31Dbzr7KvPker3Yk5QOb4JX2nVilLNfhGxcJ+GP2YIBpx6vyqZOAkWrOinhZZgTulgW2PE382W3u3VpOk/FefiDzSUX5nqL/brm6N/UXea2JnAhoAjSKpx5ASXi9sYiWjQB1sa1Lg2PLDcBZ81Ws06Zo3xO1N6FQqnxryNU3/YXNze1GZ2UlZkxiphyHr7RQbffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KB7SJJedz0ghcFBRh7YECjx/G/N+4yd9t91ilfrEq4=;
 b=dy2ABM78jTu8qw7gcu80IF3GPfQyFy1NO9xoPaneRagZa74AlZASfoThevO/snmI8a2qvxSWGKZUtSrcamhDOVWPV9vubbgLwPoeUOFWv9jvlXukkAB076ST1c81McphLG/c5EM+k2DG39PHPSBZ3HEhmShNhEvTFcxyTo74HWkWnWiQWW5i6EaqC46wVYW0fs+6PlpyC/JwxbWLTsVJmv5jt4iPOmvU1iy/PhzCuQzpD/c53ufiZ2+aoa8Rhngozduag9nw26/J++cvhQwh1sampwDAzUVhZTcNnrQsjc84D6Ow1x0Qz8g/pR+6PXn3sJBB9fTDfD8PBOekLWkRgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:53:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 15:53:54 +0000
Date: Tue, 3 Mar 2026 10:53:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>,
	Carlos Song <carlos.song@nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Message-ID: <aacECsJ6O8QjHsUa@lizhi-Precision-Tower-5810>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
 <aZXq4gn4xhInQQlq@eichest-laptop>
 <aaamYByn9dZEIBWb@eichest-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaamYByn9dZEIBWb@eichest-laptop>
X-ClientProxiedBy: PH8P220CA0060.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: b35e202a-ea50-4180-a0cc-08de793d122d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
 TCqvdkXZ82wIocqAMD2WapyfcyDobK1f2Gd+1hEdKG/5nkSeKdxcadaw87UTEBmmaixgBfmVtf3W0CWIiYHzKRiwAJWmypcibtLF10hNK2oKq1Zu4PSM/Vx1ZF9gncB7Z24INGq3evzy9EgWvfUKBF76fwVFp6h3ViIXpIRq5hY6pAOIY7y+3T08qtpKb3jJREqt+EyUAALWNhZLAsZmf8iUYMWPqOybqzbYoALPlSqnHwcWuBeytpv+uNhqHRw9gZ06J9B9xNMrdeVkrr5jTwJyp+PmyQEXl8turd6eGzSo9SrNfScx6N6HJ1Mo7eOmXc0GUWD88WI3ivXQtEOTyzHTzzdJbBK0N52en/OiK9aiVH7usuEyiBr/OqVsLQYNpb6r0Z0wfjX6GEoEkoNAGP0IN782BCupxsETn+fCcGIZAmw9und9jLXJqF0t6OkJUbLGq2YVvifHIzOoZusWXXCo+Z4//jBFLth8NUmLHtVtZgNU/rD8XtP3yeiZ4rhtqsUyETd8WlXj5YqcnuJr1E9rcT08KLnAQjNrUu1PkPqvl/KM9sMafmKB8KOcB61YomNttQFlcfSj51rjij1xqJ7Ask76gTu5tsWULIbviT4ql0qzTHwsHZY+k+C/fEj+GSJQjgClWfIr2oWjSChMPry8c7HvNts9UFTizTk+V/C2oq3LKmlqYHZvSR8jOYm/6ubk1BHNjVcE4MQcCL6S4d7oGpCXjozEXh+G3151cxykcIMuxsIPMHfMd+T5MhEP
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?N5s0zifpi0l5aqucLgK3JX6f1d1KNh8JtwSrZbn1Aam9ZZfkq0gXFY6Atvec?=
 =?us-ascii?Q?6o8BrbiLYn0a9GYunutAWNyLRQL9U82GDM/Oko7TWK3DagRPlmMMJ8YW8qmT?=
 =?us-ascii?Q?x4QC99N/CHtpoSMimN36BmElt1fLl/asRVc2enipPozlgXfx+X2Ka4SDcSgp?=
 =?us-ascii?Q?klWAe4i3jTedLcrp6irAL1mYnMIcvF28OZcSugYiIo58lKK6gOcoXTBf0jWz?=
 =?us-ascii?Q?HA39BPpYdqWg0EGgWCURy0e+smT5m8dGSW3Y43R8eZ9Sb/19vZjhyt3NX/vV?=
 =?us-ascii?Q?athOHpA0XLDYIJZRwwlolRm+A7DROvCGMFAnIGXPA4H609WDGGFaKhsElXXA?=
 =?us-ascii?Q?9pi13a9xtds0NGnCu1z5ziun4iUO7sE+mykOBV91jE8vRPMnL4T6yRwlJkqk?=
 =?us-ascii?Q?3WnS1/hiMpfNfME/jLO3rPycWHKR6IYa+GrEbdtOpuPpksEFDl+Ts3u82HmY?=
 =?us-ascii?Q?IiDgWf+Z1cf24AW5Vcfr4tJrk5RNko0BHOmLgyrG6kkNc5rvy7uJBdLes0hi?=
 =?us-ascii?Q?w88w0OMnKynoGr8knCFLo3nj5sl73WVqoh+tGlmHoqeNKJ9yYwpUXX6bqi/e?=
 =?us-ascii?Q?c2vQOvlLBkw3/xy4wDvuHFNHUV5D0davPtnhxHPwvENYvw420bh+CSTizwXr?=
 =?us-ascii?Q?ptWkiVhwdAN29Spx3xKREdT/yybV5IZKSeyaP0KxNYlie2XgYHdt+gZNWyKN?=
 =?us-ascii?Q?4TBxme1uIGecPMEhLofF1UBxjnLHBthkZQeFwquhevFJ9YH/F/Y8T3xk05+1?=
 =?us-ascii?Q?d4s8t6Wmoy6CHQsCGYp1aIChE3VRX9Q8kTz1oLxWLQZNRm2T0kqFUh27EiZW?=
 =?us-ascii?Q?sZyPy6OnGGnOfTF1RjhCLwvFSaDuMXdaaKVHrapwJJDmQ4KqIY7KzqNsH5+k?=
 =?us-ascii?Q?cTkD/8u603DS+IA/Oo3/mtSWf3pjfyWZAlK+0HylsHAH6CExbaWVY8j3p4j7?=
 =?us-ascii?Q?9M5dkJvnNss6trJTKEe18EmkBBUgRDls76Jvf3mRcTk1ZQtOgGUawB/8MFuR?=
 =?us-ascii?Q?MBc2o4whAjcXf+jmY7A6tm7RMUSkaPUoZB8iKeWGezUq/Jvcg7RIiYzoMi2N?=
 =?us-ascii?Q?nh3vpq7TBq5W/Wf7k7xVXAITWfc85He2ZN0qDfvaWrHlRwRynCfSH2eDyEpv?=
 =?us-ascii?Q?stHTjz83vAiXCBUt+16T6xlgBdzVkQGzQiEA5/j3LMP06NACLecx3k+iXhXm?=
 =?us-ascii?Q?EzG0Nc96N0/spm0A3cblRMl/wMVYZgnSSDBOIyYpa1NMceH5AsheOgpvFk/X?=
 =?us-ascii?Q?RvxriSaM1C4/TDo3iYpuwOxgO+kTiSH8ya6PjP51ZfwhbLt96Pyzi1loTutl?=
 =?us-ascii?Q?I16T+BV2AfbFm5EUSknn7iNu5A6U+DWBg4Dm/SbrAyRbCs/9JN+WgNmKHKo7?=
 =?us-ascii?Q?SjdV2uYAV3NA00tMa0DqMjNl7Z92UgJeuyeEspCVcUVcJENlpyABKhRPaLOo?=
 =?us-ascii?Q?uPVQHC839c0CAAOyVuB62FHdyQN2FEI4WvXe5FWjwJUlFn+HWHEoPr376f+F?=
 =?us-ascii?Q?p4JqAl8wP3hSWj1dOWBCQK7ksReXaKy6/18QN9iBhVLB50pSuiuZ/APxU74g?=
 =?us-ascii?Q?hvwKp32yh2bsvOxjp9YIuBcsaFEO/o9WSCvNX/oXAqcFfo9tVfsgBG1mC62J?=
 =?us-ascii?Q?UFf4IH+om2bplzbnauf3frsbr9O48ANnkr6H2JDQekHeaFvaQ8unogzgsNhe?=
 =?us-ascii?Q?9dfySMp1Mxezugg1xvhe7O6Qk1YM3h4zoJi0sgygWaPKOuPq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35e202a-ea50-4180-a0cc-08de793d122d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:53:53.9431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urbmlsMV/srGZ/a/zk6Ebidz80BJERXS0jwbvMi1t95kd7r95VMk3Y5befM9QUk1KtueUp5YjhJDGPowTluHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019
X-Rspamd-Queue-Id: 9CC001F317F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222903-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,toradex.com:url,toradex.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:14:08AM +0100, Stefan Eichenberger wrote:
> Hi Frank,
>
> On Wed, Feb 18, 2026 at 05:37:54PM +0100, Stefan Eichenberger wrote:
> > Hi Frank,
> >
> > On Wed, Feb 18, 2026 at 11:26:52AM -0500, Frank Li wrote:
> > > On Wed, Feb 18, 2026 at 04:08:50PM +0100, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > >
> > > > When reading from the I2DR register, right after releasing the bus by
> > > > clearing MSTA and MTX, the I2C controller might still generate an
> > > > additional clock cycle which can cause devices to misbehave. Ensure to
> > >
> > > Do you means SCL have additional toggle? You capture waveform?
> > >
> >
> > Yes exactly. We were able to capture the waveform when the issue
> > happens. It doesn't always happen though, it depends on how much time
> > passes between clearing MSTA and MTX and reading from I2DR.
> >
> > If you want to see the waveform, I uploaded it to our server:
> > https://share.toradex.com/dwnhcrl6b9toib6
> > You can see the additional clock at the right end, after "0x17 + NAK".
>
> Have you had a chance to look at the waveform? Do you have any concerns
> about the proposed solution?

I am fine. Add carlos, who did many work about I2C.

Frank
>
> Best regards,
> Stefan

