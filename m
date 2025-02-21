Return-Path: <stable+bounces-118559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E6CA3EFD3
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 10:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F1D17B9DF
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE619201004;
	Fri, 21 Feb 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bJNrVwxz"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2091FC7EF;
	Fri, 21 Feb 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129524; cv=fail; b=loxcTiSEcF69xA3avIeFTCBLja1tH6SZsjXLe22FHJljawhCv0GAI8SF82orKPPUan9MvO7dGqWKSTLhPqg6zyxxvgQqzjAstJw+b5nAM7yrjg0sv+BROKINDXZtYmNJ0P61sKuAr9NqtjiAqokyH0AajPAhKj7YfU9FUFzKqZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129524; c=relaxed/simple;
	bh=0ta3kU9wOQ4kKfp46sQfH3R77fl4wpFWWoY3iUyKAhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZFoQRtmsVhgujdggkIoG7ys4IcsGkMsU8EqpkQrraqF23831KWg6VyMfELTf/46aWJz6L+pSmvnpyrMeKfWcX7/nB0NdM5T8vXpanTXRnc4v2Np1GqNLLuUZ+Z+bx5nq+mX2rmVK47XJzghmrVMOZRuOJESXhRHi3XJLJ1Y3EBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bJNrVwxz; arc=fail smtp.client-ip=40.107.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADhGODO9T5kJvXl/NXjGtIzOnhLDR8/QvFWEKZhNGiQi+WJRXLBIpdU6O4Qf9pg1gn9A3BKxFzIHgoApqlNCqz9hiaKuKbQ+bsc6l2rB0Ip1Fs2y9nzuWNXMv17VVYsxugjATmYhKVLX5j20BNEyU0WJS2B7jn2lJfq0YH6uAAhBt/hj5vASOezfKPpshOpxAojq/LR8KNLQaES5s9OtPxlyDUUo0TQfrF57X4I7xHNy/iCRRiC7ibChztARivYOcmDMXEckGs7sPOU3++XYGUDCheo+DPae8sNqiLFkocLJ3DyR7Bhc4CcSxAM7c2MFjhnYzChcrVthicUlyp+Oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33tdgpwxSf7rob9QCnB4ikurSviwc1DpgVPHaQAznuI=;
 b=TfNm3+BTCgctvCXChub3kXqErlBAw/+U6Nr3tkDmLycIjMB7YLqmqNRXohO4Y7+vgi1voU+KoRYCobpMzZqCSF5gKENhGySIr76IW4iUN9aFBA7UdYjYrSoAk1E++LEb1sAz/VbemB2QZOQPN96ebynB3QCpDQ4JB+cyQXHziYAAp0t3is/04nB31L/rDjTTZmwA33sqaq1H84+LtPFz6dDgqqv1ari+bYW3u2fj7qnoKWSoMhfdrvpPzw2XmRW/0Eg/qWZRNOiknFBaoe7wioXnik3xDQNBzN52+b8GmKIY0Yo6LqjETRpwqhTrwszoEymiA/RyDOb6kRVM2ViNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33tdgpwxSf7rob9QCnB4ikurSviwc1DpgVPHaQAznuI=;
 b=bJNrVwxzENMWL+gSW1g1DMBBdshM7TmPpug52u91IZrvGfzE/rqW9r4UXfk8uiid67P3bi408CNzxy9q8qEHi6o7G/3wTjeB7cguAlhngHxq5oQkdc93l0xe1PxGIeABrQFE34AtQ0ZM+EAbd/SdAyjCYYTOPhS+g03PhPr3SkFSY1R+uQAiYKzkZjFfLrskVhk6AJrNIC/9gXSl23I5V/p+e4to1v1AAM0Kh5IYNOd2Q9HkYkV34nBXE+6cG8kV+gsajR7K14BpkH6otnnvzYsEXXgNgaisyJbUY8p2HuZ6MUZU8GzB+XpW1kehpJn8D0zKRkEGggN3qTwjsaH7FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DUZPR04MB9965.eurprd04.prod.outlook.com (2603:10a6:10:4db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:18:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:18:39 +0000
Date: Fri, 21 Feb 2025 11:18:35 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Message-ID: <20250221091835.g6ybtng4wiltg4ii@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
 <20250220160123.5evmuxlbuzo7djgr@skbuf>
 <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR09CA0131.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DUZPR04MB9965:EE_
X-MS-Office365-Filtering-Correlation-Id: 415d6e9b-5402-45c6-ae26-08dd5258ba0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a1eBmfB/zlgw/1Gk7gxlsFq6qhey4wHhXxyBYu/EhHR1/AefB4kroYarUpIy?=
 =?us-ascii?Q?Fidtg4BJ4EcJ+lXCWx46eeoyhf0o+R+poPXaAGj/rpUw3mIFg0xZYwDn1Dbj?=
 =?us-ascii?Q?MU1oFGPl79K2+yT85hId1cFUsgEF6/Gqk3ZkPaXwog4nOGLjkJsX71xQuqVS?=
 =?us-ascii?Q?QkxWBu99jgHfzsrd8SFM5ll8SAtw1fHdR8R+D/b7aVZeo0cExrcokWW7a1VE?=
 =?us-ascii?Q?3m+JPUS27HA8pw2TvHapSvRmVd2YP6yfDwf2UVC7X3jQ4jxvy4AEyvi+s4YH?=
 =?us-ascii?Q?WM2nlfMAKrnLbreXS9/EVK8Ye+6n1CXHXh+FUD8kUJcqF1azj0tDw2ceWHr+?=
 =?us-ascii?Q?LmtlHJNLAq7dSkYclg+Rl3dVZdxwZ0V/bOgQFprTWyzbZW2K4QhO9I8BPpn2?=
 =?us-ascii?Q?0sIkduVrZ+4GE6B280HkvgtvxtApS7R2OoZ6NeBEoXPAWxJDrlmNNe2VvoQ4?=
 =?us-ascii?Q?4hGvNi5fipe64D2TV/uWciMYIeDEmFnGsNGP7YAVuuEa8bIe/1OyCv3YbmAA?=
 =?us-ascii?Q?Gm7cQRpIiZb9eHBu4JCyyau4qHGyFzB7M4BeOwsQrSeG8eeYBhtnmHG2nlBx?=
 =?us-ascii?Q?VLqjVg3dUX0gtsFib0l2vrbxBHpf/9a/Y910tZH6PqLUJRFtM6JBSx2Gwr0A?=
 =?us-ascii?Q?Lso+TTNV/0ptXpI8cpmazs2oFw/vce0XzAKd80nXSNc5PRxMGzMC0TvaCE2s?=
 =?us-ascii?Q?YlzSnh21wvNeMY4hYVQNg4zKHXb08v15/QQwjvl5zWOMrZsLX8EaWHKDRLnX?=
 =?us-ascii?Q?gr3IlXrMdx3P2Bj5dSGYl7XZ+AAQSdteYrprOMfZGgTmxU5S80v/hGrZOty6?=
 =?us-ascii?Q?WojHApg+bzfAcZqD/k3sPgA300hBIvAbQR7NfhyNx28C+hKb9ABpIMmMMson?=
 =?us-ascii?Q?VjsIca6SFpQN1+4bmxdqR1K51DvierimBoFhamT58mU8LS6Oc45OhjFB+zJ+?=
 =?us-ascii?Q?TAtZhZe+jmoWTmEchCWpH9lGin2rYt5dM1wTIeBO/o49ou+Se+q+4U/5fsPf?=
 =?us-ascii?Q?jRYM74JYyd0z7+59MJWtci4dHExFQxH7/sHDc+Te684+yh1O3M/Apj29TTqj?=
 =?us-ascii?Q?m5lYQfRHkznbDiwv6VzYM5wJUd6BX3tYgg1J1k4OiQzfepjYoAicdr8NfrhP?=
 =?us-ascii?Q?NcZeOLJ/k77UowPcrR4LoPPmepG0sg4NQQWLg/KR5hhYTndIq+HeQ3OenYFK?=
 =?us-ascii?Q?gbagie0cyOD9etGfKf6r8CVDrAVX9lV6Ltfg0eI9THoOxu9PApFp9tmiotgz?=
 =?us-ascii?Q?DztgM0dNzhXlqmKS+4DkRYQ014wBQrQSz/lOOrJQe5IePThzCYCfE5TR8Cel?=
 =?us-ascii?Q?ZKdQEgVvjtTv2Kq9/DLvZfH1+G1I7LNEuVHy5YbKxUlZE1k6IP/1Op8CIemO?=
 =?us-ascii?Q?+XNuhbBRGTMDGNSqJ6aG5G+Y2z87?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Gl4x+gFjPu5t097t2fj6N9fuz3YvUoYGO4tTwC6QNqC4jwseXnzezhorQbU?=
 =?us-ascii?Q?CwAg++HVqUUgOfMiJCj2YG6aybdYrrc9O9mtxsN9B4FV7imdL0g9AIM3P8Ju?=
 =?us-ascii?Q?h1ey6cD3VpmWjBoX4SF53e7bIhC6M+PBwMgNM7p2DmwnXiRoj1JqOCvkMSNh?=
 =?us-ascii?Q?JJnkTc5Kyh2C4v91IxyxEDfK4KKMB1ghmmpxWQy3ucyUyF00O3b24bJ5Ej9S?=
 =?us-ascii?Q?KT6vENaxCtsourEMRlB4mr+S+sbnwE2T8G4ioJezB/jiiCxXSphUljoP+SB1?=
 =?us-ascii?Q?w5Dtr6k+B+Yg4NFmLFRniEzvpRTerNBZ1ofIjxQb6JOPwafGEyInMmH15BSJ?=
 =?us-ascii?Q?VyPCSY1QSJFqaeJT83ZvOE3ILUhxgMCUeD7ycTUN0sJHcOt25UQU2SzZzNmU?=
 =?us-ascii?Q?BUlRj09PMHwmzwI7ijuKpPwmzWULD/uUqO3IR5EuqEhZJPLDqeqrCL00gLXn?=
 =?us-ascii?Q?HXNppBBE+dDg2jFfkBAQvOM4oVyysGH0ogENFD2DdgwNTAFq/dIYez45L/Sk?=
 =?us-ascii?Q?s3A2pIYwenUhwspo21JOjmtE90bCubPTLBEq+qurNl7bFg+tWZ5wb1OKDodu?=
 =?us-ascii?Q?7y0YOpQDttVBN0ySVgdR0oGkQ9IDBajJGtmdwKVkSQ+ix0lCuY0b6w49DA16?=
 =?us-ascii?Q?osFI+CVqj6c1wbyoNhbULFYh7t8eR68mEhpSB1LcJLE8GlD7ACQ05d6/Rpue?=
 =?us-ascii?Q?0rrFNIFhL08mbE/DPkNvKr6sMpFV8Z7uWHpaee3c/jnzKy4gTcKabXZCuhsw?=
 =?us-ascii?Q?sG0OtrWb9OIiuvFing9dT5WjeW/kejJkYq8o3M7mMFO+HtleCfDx9yj/nXN3?=
 =?us-ascii?Q?H+JKLPAH2pVLHnT9ak5vWbozK9kgaX+nMwI7o7u1omzNi6p5ErLJceMPBsS9?=
 =?us-ascii?Q?IVYnSqE1cb1tn6/Z5fJ17D6f5I+grBm6QQqWjGI3UTiLK3JNEG2m68K/fkvO?=
 =?us-ascii?Q?P70fxh8SdQMaPXYvRYih+e4SOXg1C6jYGiO6YqV6rsepGCHVa386dbaI3UiB?=
 =?us-ascii?Q?GYZXxoSU0Euvr7cpoqQi9CH4gTAsAdTFP9lvDKtB1zF0TpTg2TzpuY0ITfRI?=
 =?us-ascii?Q?FvdaUZl1YpYpe1RUIUh78uccvYLT0POrPcYNpaVVTtP7Bwda6FqchiBT/dDE?=
 =?us-ascii?Q?fy7XmoMBtuNX23WSO6WyE79LE4vz9b1GG99fti8wRgQ182SzQ4qIMSUwqap1?=
 =?us-ascii?Q?Qm6fAV+lzb+dbP4UZnOV2fttmV9vAVf2RrL8cqdXb7Swn9BriHnSCAwLeMEt?=
 =?us-ascii?Q?vBABUKSMTVkCiMRk06DoPZGlp9Om9/iu1rOF4aqNBSRyq1/VpsOyRf+OEhex?=
 =?us-ascii?Q?3RNIjA3Ra/YlS3ABtATuHPu+pOGlWrS+CtvwoLCFrs+VjFaeyF6mUU8ziC3E?=
 =?us-ascii?Q?Kch2PvhHeFwxg66J2Q3c4V751crJWbhCfOrZeJvWD2DC4exkO2mBZx1rgSMW?=
 =?us-ascii?Q?8YffI6ReoiaHkfYMpl05j8Yiszh1CE8yXHbjP3+7HLwEDSMPSS0S/v754kFE?=
 =?us-ascii?Q?ZZPIM08HtTzjdfDIbXO+sn/yRvF2/7oXboJne86LBR9tyQRAyLxX473dFzo2?=
 =?us-ascii?Q?eiPWoyGNR2Jhc6TiOltJprqVNtNGGytwjJ5EFiHWpvE2uyaVbfHx3cyKaX39?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415d6e9b-5402-45c6-ae26-08dd5258ba0f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:18:39.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmX9QpkBpOW6arQltP+ucyDFPMTKz6zgb8Ygl7mP4obyTDhpYGLUIzVKs2w8SqajbzJrbNx/e9oOk+8xT5mEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9965

On Fri, Feb 21, 2025 at 03:42:05AM +0200, Wei Fang wrote:
> > I'm not sure "correct the statistics" is the best way to describe this
> > change. Maybe "keep track of correct TXBD count in
> > enetc_map_tx_tso_buffs()"?
> 
> Hi Vladimir,
> 
> Inspired by Michal, I think we don't need to keep the count variable, because
> we already have index "i", we just need to record the value of the initial i at the
> beginning. So I plan to do this optimization on the net-next tree in the future.
> So I don't think it is necessary to modify enetc_map_tx_tso_hdr().

You are saying this in reply to my observation that the title of the
change does not correctly represent the change. But I don't see how what
you're saying is connected to that. Currently there exists a "count"
variable based on which TX BDs are unmapped, and these patches are not
changing that fact.

> > stylistic nitpick: I think this implementation choice obscures the fact,
> > to an unfamiliar reader, that the requirement for an extended TXBD comes
> > from enetc_map_tx_tso_hdr(). This is because you repeat the condition
> > for skb_vlan_tag_present(), but it's not obvious it's correlated to the
> > other one. Something like the change below is more expressive in this
> > regard, in my opinion:

It seems you were objecting to this other change suggestion instead.
Sure, I mean, ignore it if you want, but you're saying "well I'm going
to change the scheme for net-next, so no point in making the code more
obviously correct in stable branches", but the stable branches aren't
going to pick up the net-next patch - they are essentially frozen except
for bug fixes. I would still recommend writing code that makes the most
sense for stable (to the extent that this is logically part of fixing a
bug), and then writing code that makes most sense for net-next, even if
it implies changing some of it back the way it was.

