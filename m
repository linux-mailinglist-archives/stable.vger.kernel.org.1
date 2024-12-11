Return-Path: <stable+bounces-100625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B59ECEC3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80631882972
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942DA195811;
	Wed, 11 Dec 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aQyfZfCN"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB9187870;
	Wed, 11 Dec 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927863; cv=fail; b=Zv5BLskBuV+Jivl23wmmKwEyfwmwaPc3PdZiDaNjm7N7fH98dhry4bAZ9B8M/u+/WJmV8dqoRr7WNsDt3R0ZT4gItSsp/SdX/e2uLMuFPIHYxNZ0HMlJ2XlzZ8Nx6yA7egbMUUhKIfTXBFDGwZft0BhxjtIxpRl081qC1pGJj18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927863; c=relaxed/simple;
	bh=NAUrkGXqC7vV4Pn5aaHqVt5VOGBiHg2tQ4AAdczG6jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmF0LuskWHPcoPAeNrQeomssTkPjbBYxjCCSa2Xp28mmfU4mfnEsGYvQpgkXs3Qi3FmQ27SmnuLnGAxOJENkPM04vC2uXaPwW5UpNd9pFQh8+J9xl8RBdEu2QRQ8NBfsdk8u5bSje9iXBoAuSWPUfDerNzWhJQT6B6I997AREIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aQyfZfCN; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5F3d9YRM0RZhRex1FhcrSy2BpWtFErJiP1sNcoIvmUL0eFmmLeQDCe0TXxcaXz07s/Fr6+9PHiuk24wR5fWlRC7JHB8a73WF1aDU6FmLiSLsbAb/yUEudkcWVUevekUfWup+SxSTrUU+NKG0InNRC+vjvelxx9XlV+cl3UTFQcmuGUvQIOu5dtkANBMQHiP9N1TCT9lWBMJ5eR2D05Lwsyxr3WUX+rG9S27bDhJiFCGoJ2Vf15AHbHlKTY5qgg5U8U7Dc+NAuneeiRsFcwyke5QV71BSbeZqRs38vOLDgIzGJTpTqftg00bFmCkj7uCX2JIvdv/ZLyfvzxtIXAE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLrX8/YOBvMCfCH5Hw59p9XiZYNzYQYhDS0I+YWkXLI=;
 b=iKaEPJ19CrmtCP8Aan0Dn+zKU9zuZzyDHAMEjrRI0klDh7LFvrkfvjyvVsBs4VnNFyMupPzun9S2smrMcaevGKj1ZTgik3fheXdZYsRIGh6VK2/vlrWN9jwYPrbXmZJFVo2eJ3h60A0EKGD3orIHurd4DRtVhdb6HTJtyqv2qzZ06P/pJpIG45mamOn87XAdC4enYyXCCnVaeiY1Y2I0tbHgE/BA111hnjFNa1EAQdP3TXV0soyjpN8J6CTC56fuIRiIsfB2FFCW3k8VRPsaxe2OuYmKaoFIyhsV6gp0UgjszXXyKkHaah9JAsYZBI7Et8N1vuufPSfyzS0m6D0vBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLrX8/YOBvMCfCH5Hw59p9XiZYNzYQYhDS0I+YWkXLI=;
 b=aQyfZfCNL5MLoJZvRc3mpPkqtgZhjwcGqKx9++vt/KgSAZM+9l/e21xl0zKZod973kZ01zyHqu9IFbzSbIQzP7COWHWcY3fScef1rgYqFfR6QFd/2DN5bshadd0Q5K1DkXMMkIlvj8GZHIpwNOjHwgJMlEN0uiAIO9T80NVDu9Oy/+uTtlhc2BgpHYGU8+UimnGcyc+6+ElxEPvfHDLKrpnFZnizWmkGOtPTzBurd7uasR2Gd94nRF/oiEhQ/89RInZ+jrRlXy+Am9fg9nq/SUh9gkn9kLBMxVZhGhD70NMbSoLNbHdJ7lQ09EKOsIpKN8Nm2lPk+ZpNwYXwQWEHAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 14:37:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:37:37 +0000
Date: Wed, 11 Dec 2024 16:37:34 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Robert Hodaszi <robert.hodaszi@digi.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: tag_ocelot_8021q: fix broken reception
Message-ID: <20241211143734.d3motemj7kwao4td@skbuf>
References: <20241211124657.1357330-1-robert.hodaszi@digi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211124657.1357330-1-robert.hodaszi@digi.com>
X-ClientProxiedBy: VI1PR06CA0185.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dac541b-5e52-4597-32a3-08dd19f15bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Mt5DICb1Ng/DEtI9aolvwU6QWzKtW0A2Par+fy8HD1QYbzA+MdjPE4yOYMz?=
 =?us-ascii?Q?4Bs+sol9aeNG/cS55yQO4Lf1YIxGQZqc64DadFXmke7YxnIvlCSuraQ+Azrf?=
 =?us-ascii?Q?5FsRd9iBQFBzp3fi1o61BbNVUvmVtZaiFENL8WFbrG5sihkva5YSGrg0A76m?=
 =?us-ascii?Q?mS6ssFJFZslhYLCty2QLSA3WPWPRVJH99PaqF+gTpcDbUKEBZWQwt+YexHFC?=
 =?us-ascii?Q?4coCifI5iTBxP4hrKCSrs8Vgu5AHwLZh1TvyPeri3xihnXJUkikJ7m7CdF6J?=
 =?us-ascii?Q?vbmqwDuUBej4lqxupv+5MbB8LFFqox1nJjsk0FhPugzbnFkE3M3Oa+vvaUsD?=
 =?us-ascii?Q?0BYRNyu5TFlfih9U5Eh6u0lR+nqDNyJelS/m/5f58tuXR1MfJENk09/utm9d?=
 =?us-ascii?Q?eCSOjJp2FnFRcn5vbW7BQ609T1N0w5EuVKNA+S2QTrt/0MMabe44hOMqbpTJ?=
 =?us-ascii?Q?vO8pRrvQ7IWD6bBe+J68t4lCoD9Mj050BSknq39myDhbQak6amNyYQ6vJ1/h?=
 =?us-ascii?Q?FoZugdfzr6wAViXC4SwGqXIAtJN0z4H3hD++3XiPHES+mChufA1WeR8dnhOZ?=
 =?us-ascii?Q?3Hs7m32+jeYBKXMThImj/Zq3xqUynC0QtL/AU31Ltm2nrDTQz5oeGW+jgGYb?=
 =?us-ascii?Q?rf1r4eQxG4AMM8xxfXUj07GByZ885J2q0E5RGcPUbOXBJnX54qFoBPTgDg7H?=
 =?us-ascii?Q?n538yr1n4I0TnhWbokCEb+GSAvd+rRhvsKbCzMTiWCHosr5Am0fugXZyIOKG?=
 =?us-ascii?Q?7ueWnZDnAQFiBhibxfOoqa2Pd8UWd6DhnyaGvtKq2GqFA6BKD3W3O4FaHfV3?=
 =?us-ascii?Q?nwNdlST6EiJ7ar2vOCIoKsDuNIZ5oHiWpg/ME2WBHqGUBxhe4Ah9C/a5m6NL?=
 =?us-ascii?Q?hMBj9K1bv6b8VZoJ6vrm3EwrrqStWa97y8BsXYU8SUCVeemS6Jg3KF6l2bzU?=
 =?us-ascii?Q?w7Fjbk621aO1ScVLxM86xtVmOTMvqKqiHhK/8UiL8JXJ85TyaHkju2DwbrOy?=
 =?us-ascii?Q?5QizL4Vfm44f7fFbB246BI3Z5OULbHutyOgG7ePmeamjTKNjysz+7UIMO3r9?=
 =?us-ascii?Q?4GXN1aeQaPz0JLalhI/weFr1L7yf7455pjCjHCwbTaGXFBmXedipFhRARoyo?=
 =?us-ascii?Q?I3IDd67fjZixBo5KFHbYLQfNGBe2Cgpuffhahzel5CKsIX1u634PZ4nXPlJ6?=
 =?us-ascii?Q?47mLVAteey1pr1jT1AG7G0Xcj6Zlovu4kSZ9MQI8BosnbTF2A8JYFzBAxj+t?=
 =?us-ascii?Q?E/RYQrJQu8cQadFzMF/U4o609mMLXG2f2Pg5xk4wUFvbeZ0vznFQx+0JGZby?=
 =?us-ascii?Q?74KXV160YG0ss7zkmnDMDR1yhgNCaRKp4cBaDWGw5nRuTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h8irYzOmOJc90sSk5o5MrGvx6CmnPD760h8SWb/nVuODYyhPHm0D3rAaeDBG?=
 =?us-ascii?Q?ArgrMIxZhY9ROShtzA9yJUmwRue54KLJWe+Q4opAu+Nf4BPI/2xYox9y5pGd?=
 =?us-ascii?Q?aWRH7qdnt8qHjZmPOv905TaVCjH2LO5AbdWWm8kD/7M+fz6sGvJU9FxgO8Vx?=
 =?us-ascii?Q?nqoQPXS9DVQrozL0rKmhCGvKVoTHZyopNh18NsJMKFnJSol+srSxdNl7x8Rh?=
 =?us-ascii?Q?72FkTbdaPdhXBViZoJ+lI124NBsHTBC08N7C/eeGhbhdfEDrWnMYRlsU45zk?=
 =?us-ascii?Q?hYdZQPwB0wFl+Hz7++2NA1D+Ys2mnvqNxDibPKX6TorWdTsbVag4unIqB027?=
 =?us-ascii?Q?WSlXp2jwnrerTNLozn59rxJXOGBAWjHIjPncs01OL9a2ATbcRpgVrdDz7Gcx?=
 =?us-ascii?Q?4p8QTygsrXPGJSPvO4YE2uuLfGd9GMSy3vIHnyiR3u2mEPtodeiHICxj7tyQ?=
 =?us-ascii?Q?ts4bg5O/knwSBvEu5+D/s7DRAvbEISxrpIQdsutaiOmocwK42c5WkdFhIr1X?=
 =?us-ascii?Q?YfOGASekVlwCHc14BciD9JKGjqMBFrTLx6QYUeD2Wb5s22/rPFtqtX1UbuBk?=
 =?us-ascii?Q?nDFFuP3LfKUZxKba3U9gSMvHo1vCWrG/cftuFqgEIHZKNjfLyIkKs/mRuSn/?=
 =?us-ascii?Q?edI7WuQd3BxK2IcZBFf3EjfFVGY6AabBLJ05zgMmhT7ua8pa3CvkjGsOgfTM?=
 =?us-ascii?Q?6Bb9vpb1inJTiAKD4ReV5LbMKSJ/mbXdig2OYLrg9ZlWE5S6AeS8KVnomZD7?=
 =?us-ascii?Q?kq2uufXvuR6ghazPCfl8izMvY10Pr2Mvg2WLTrG5e7846AzG/6F7GSnwBjL2?=
 =?us-ascii?Q?NN2evyLdPAZBTqGNBt7elZBs42zMnlgB0v4dUglzvmzgspvqcZQmAbT2dj8U?=
 =?us-ascii?Q?F21WSPtmwFTkTL4Ib8xHXMc05wOtPSrPiZMWKg8fiX21qDzAIOQtbOm291Qn?=
 =?us-ascii?Q?FMW3pYQAYH8SAXpBiMiedlJgO8A9Tlj4nMZpUvn5BGJt7GmovKwzy92ffyoC?=
 =?us-ascii?Q?yAu8SNYkEw/ZdnfsYHPJRS8oElSC4FhbNycVxD9EV+g1UumsncoctQKPyAaZ?=
 =?us-ascii?Q?pZLKWnrzJKnk86vKtA/Yjg94E4KXcPIRoCDrygwmiWwwN/mN15knpkhlUgD9?=
 =?us-ascii?Q?aG5FT3Zwa2WEAUEzwjHNLntzWiypVAWT6l8UrKaHdhY5Ujj3D4vJKDJxJWf/?=
 =?us-ascii?Q?ziP3QxYQOYviSj3nPpbsvp3YxXAXv94F44W7r5CfTtG/qrtTcjjsqLvNXsjR?=
 =?us-ascii?Q?Tbb2Z/6dKuNyfjf4zW95ELVPYSkDEPCY8awnu3vNLIzZxm5AKD0g6UX7mElf?=
 =?us-ascii?Q?n0zWCeJhIBZekJdswcp4Y8evmsOcqT+Cp/XRms0clpYNufxWArQb02MCN/Xv?=
 =?us-ascii?Q?mpcXb9XsQE4mtTdOkbGFoD+Yps+pJKuwiMKp/d9XPQnBJCXOH2DJ6PTXdJkp?=
 =?us-ascii?Q?z0LJ3s1mLWt3eHiNw6RxC+Ey606/3UtBWZY4tm/qMOso6jbwgZYbW/3GpOPM?=
 =?us-ascii?Q?lSpmJbaV2n5hDdR/f1pRdDZQDdVUUdYotjLAu4gdBVJ2bkg9Hc/MIRluLrCa?=
 =?us-ascii?Q?h6G71iIPbcMgSbVYvi+UEYEvogab0vqyAnKaTsBjzozu5Zm2LBhdbtBEJLTx?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dac541b-5e52-4597-32a3-08dd19f15bbd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:37:37.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goPvGyGIIQKsQn2SLmI7oQLgKG8Arz1wMeXe5fY+KwDiQCJsXpoXohV/FFk5q0PRm+LWMNZP3cGqaMRl4/xBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7284

On Wed, Dec 11, 2024 at 01:46:56PM +0100, Robert Hodaszi wrote:
> Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
> absorb logic for not overwriting precise info into dsa_8021q_rcv()")
> added support to let the DSA switch driver set source_port and
> switch_id. tag_8021q's logic overrides the previously set source_port
> and switch_id only if they are marked as "invalid" (-1). sja1105 and
> vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
> initialize those variables. That causes dsa_8021q_rcv() doesn't set
> them, and they remain unassigned.
> 
> Initialize them as invalid to so dsa_8021q_rcv() can return with the
> proper values.
> 
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
> Cc: stable@vger.kernel.org
> ---

Thank you for the patch, and sorry for the breakage. I suggest the
following alternative commit message:

  The blamed commit changed the dsa_8021q_rcv() calling convention to
  accept pre-populated source_port and switch_id arguments. If those are
  not available, as in the case of tag_ocelot_8021q, the arguments must
  be preinitialized with -1.

  Due to the bug of passing uninitialized arguments, dsa_8021q_rcv()
  does not detect that it needs to populate the source_port and
  switch_id, and this makes dsa_conduit_find_user() fail, and leads to
  packet loss on reception.

  Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
  Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
  Cc: stable@vger.kernel.org

