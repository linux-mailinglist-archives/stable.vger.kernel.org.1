Return-Path: <stable+bounces-211247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHJDO048cmnTfAAAu9opvQ
	(envelope-from <stable+bounces-211247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:03:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615F684D1
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AAB3300B9F6
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD031076A;
	Thu, 22 Jan 2026 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqDa8xTF"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CB2F9C3D;
	Thu, 22 Jan 2026 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094038; cv=fail; b=k2NrFwuYihB9r2lUxPB1SXIdv7aoF4O7/1nsL2GIyrC/KBKN8dgo4n6nsGrB/GfLwveOrTyRoFr+XK81AtSpKmettRUnFnLSUtnP4jyrzkTLF1pL2S0G+gIsQkEewCt7VdIsZX+vvVFXpFyETpdTBk+fJ+tgba2rcTaCaOXaLMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094038; c=relaxed/simple;
	bh=uqius2VvB0lRFUj/kYZr70hjn1OBjDJd9GFqrhedGZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WeANeVmfOEV7rZss7cZ3Gy42YvB9o/I7qkDJIgM9v3Pq57yyF1er5pPt0QDXXaEu3dUGXf2SoLnC3ds7xMl8F+JOvmuGIqHqoYC/6V5/hbx7pvzuFWZRvu7FhO3DIiLfmsNE3H/DzKwX7dInMDa3lgUn0eGNPuxm6SDZEKeqb8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iqDa8xTF; arc=fail smtp.client-ip=52.101.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+U9VWBUYfHFXJR6E3D6Y3y9omPD2aw7SYe65wzT35NO5d3lI3uqK0Mw4Oi7Ym/9C7Nru2oheyWZl5DGMFpv/3/HwlCZnEmePs1lfsnN2vRugP6kRxrbWXyiFlC0rgpGijREgl3L6jZVYSbObQ+uSRw704nU5urXJDi9P4DQx1BO81RLO9pESl63j4fjE2Lb99Y+zH1X24kSjjofrmv1K57bcc6j4bSya0hUbX+oqndK7zK1zVbUWrT52XVlc99OMtKI8a7Mhuh6TLL2IOh0BTokzH8zMMOZrMgJLXrF1Sv7gt1mNYb7gurs702TnwSqZ+JbAcsD6HsJ58I+hBDWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iOfBDtHc5rUXY7Ed9OAnlf74Pe8rVgMc+uTMls4Fm8=;
 b=H1Pm7hzL7Ah8ChQOAKl0nbS/2Nwqm7+mCYfLNM9I5e5JEApMkwjuy50S+zEqzOrNK1IZfdoT+Es6rsOlRg6CGc2ot8eIzDm868v/gELo6xHEzbDbU5l6T008Jr6AFO3DN526deh8s9VdQPHz8quTzYL23Oi4YeWt70VuVouuuYcQ/dvDLBY8sO+1B2reQ3D7x1A7d5OHklgUQ2HiAg66XcMGSCmI1UZ1w+ydQZzEzenXE4vBeBbdbrBDnyygGZ78pUSBoJBoZwmphW8QRdMebU3LmGMINy5ruwK4LlYKtXRD+7Y5LAtT+9UP3PaKSRn9w879WTAUDt1iqlbSIDS2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iOfBDtHc5rUXY7Ed9OAnlf74Pe8rVgMc+uTMls4Fm8=;
 b=iqDa8xTFlnIf2jdm5KpJ7HJN2LdKkRma7d5yW+L4hqcI/WC80VKsUSkZ7Dt6w2t4r9al3AlLXXbvmI0CFmUK+h5mWpUwsSqiWwHt0UQS+F0W+aTFZW0hmAxwZE6yCVEwpc77arSp/jgzgCa2Pyv7z46Tm44Zqnuzcx9MlFRV9SMwaZVhNvm3gIqlvW85IEfV4StS2+SZrDwtfhmTgH3kIz5XrBRona2u+AkzYpgk5Uy2BKEx1SExHqhvurQzllwEIN/teIMUb0KpC9tl3WEAbJtLBL2qeEkqYMLfAxUSKLzepJsmEtW3y7EjBg/TqWvDkyzaAiCzYwtvy0k3MPpPdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 15:00:33 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Thu, 22 Jan 2026
 15:00:33 +0000
Date: Thu, 22 Jan 2026 10:00:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: Not report loaded resource table
 when none
Message-ID: <aXI7iL2Zf282uFlh@lizhi-Precision-Tower-5810>
References: <20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com>
X-ClientProxiedBy: PH8PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:510:23c::21) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 44bf2d9f-53a5-4653-d84d-08de59c6fdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y9F2BjWaY3xwMff5loJOSuLvtMPucm6qd/W8nXV2pkBdh7Y/ybOfyraahKOb?=
 =?us-ascii?Q?Y+/l3sfG3RVKAK3IvzpUfzyL0c3/DudqWqs8eeKVlTJhE1uqGywIc7p4sCRz?=
 =?us-ascii?Q?qNfRrONTlAaRuWD53Kb2lQ6OSL0JW3iGbNZxATxPKiK5NJdhQMfHXbbPQ9cT?=
 =?us-ascii?Q?tV02GHfE7ekTBL4WE+d00uKvl8q02X/f/Hjph8hDOWL1umnr5vGMf93L5xtf?=
 =?us-ascii?Q?Y2WrX+CE/0jUakEtIHmg1yaoeuma0rqa91mz+6lL9hVtdFJUBP66as7A3Fsj?=
 =?us-ascii?Q?ubJZLHTm7o/8LMn2misRdKODdHi6EbE3cGoxVvPYwShy036td5aeXWyCENHE?=
 =?us-ascii?Q?2QHR0+G7DT/vGYCV05mj2RPn8wI+0AD1t2Sd1GI9/bP0HJTlSGhA/70lxHaU?=
 =?us-ascii?Q?DZSUTZK6ilbRObAZ5DrIbnRWEmUfpkxpMszDblJHFIJhPpspageV9m57NvPd?=
 =?us-ascii?Q?UwsDIxUc6sI8d4BxaIhEzDF21Fak6gWBs7efg0oZKhjaSAVaKcLqh6CouOku?=
 =?us-ascii?Q?fWZoQvBUQnn4MWDTMTxhoD7a6FY3IapdHw05dM+NSQUW8I7xJ98JdafxDieg?=
 =?us-ascii?Q?B7O+nUkzRCe168IJl7g706DKv3EoiFGLRJnpmHYOE+vr+Vqp1tSNLV/5K2/L?=
 =?us-ascii?Q?KoeIlQ7h/MLGWJvzJQrV5ysaWYhuGqOeeaGLq5tYCr2vBMe3Qa5bWzGbqMUk?=
 =?us-ascii?Q?rn0ufpYvcalIN3U4JdhB7ZTxXWOD9fB8W5bnX8RE1dg5WQP6RM/0zcFJmMBd?=
 =?us-ascii?Q?2bWJA6BhqoiokkX5zfkUJ9xoU5fXFjCwcOOUvtKI9Nnap/BrUtV7vmWawjAU?=
 =?us-ascii?Q?D3mKxDg8Yi46qEWZ7Jw+jGOJV6uxsEOP+yWtXhl6xciZ+ZI1PsAkBp2YpHDV?=
 =?us-ascii?Q?UjuCFlRE0YH06tr97R1bzwcZuSqf421vFFXS8QntuKmCFS6KprQTM00OA8sY?=
 =?us-ascii?Q?S/V2iyQbusQGXMxezlEYbouAszEoih/zT0XRRmRQ/s/4h20R0oSNBoR5O5Ml?=
 =?us-ascii?Q?HrzMSlmGk011Te/uS6YqF04o2oK3fIQI9VJ/cptkYxFRKmjO7U1h90bJ0yfu?=
 =?us-ascii?Q?I+IW6Jav9ISSbhLXGS28DRW4nJDOdGyY3sdTzM+gEKP8dPmssb5LzOpdENz4?=
 =?us-ascii?Q?y/AOZGDm2hETZwHdidSaq7xoQl1h8Brm/HJ10Hxvcdg9U/4axU/sZFAyfJkH?=
 =?us-ascii?Q?0+cgj946gaeTXiMRoc6eeQ4CdTgGS0eNfvSloMsnA4YQFrxyfTokk/FAfX01?=
 =?us-ascii?Q?Q9q+tspCqzHsxnc310njn0YaLrJRjZGCTINBjuL8bNnjfXAVz6JPfQlIFsgd?=
 =?us-ascii?Q?ZqvVEoeOtRdmHVwIBTJgNU5+ji5jQnf0eN4f7yPQuksAIUnXtDizuuijwxq9?=
 =?us-ascii?Q?x/miBvCLego9c2bRaWoFyM0BgnRBl1W8dGC6ohejStP08urdI/I8YyavWZmq?=
 =?us-ascii?Q?oxVE7jVTB2tgI1VU8PL7qSQZ/pB+iw1igi90BfhWFwGLoJHxi35WPt9YVlkH?=
 =?us-ascii?Q?ZZp+6SCytVAEDZ7/LO0yXdzGc7HQPJ6SpwiV7w9rABWo9PT8XGGBWjoRmIfG?=
 =?us-ascii?Q?ORneY1PAibShtYpesdVY0tunlh4Fwtd0KJTI6ObTZcowbTtp4U4CN3ckbquc?=
 =?us-ascii?Q?PuajvqdZC0pcFrXyMLGGEB4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hj2V4wpotXdkVfGHxzDaI1np1oFgCiNeBWzDGdS/ygUCsu4gUtnFL+PPmp+/?=
 =?us-ascii?Q?GKav0/55ig3aRzkQcw/Vx8O9yUiCORSuMg5i22zF2WX5cwRHU9m46we80YB9?=
 =?us-ascii?Q?Si7MTzgt4QNssot1nRNPxu4ufAwUjHdoNvrMFmmKAQ/kjs5gAMuMenrtIRMJ?=
 =?us-ascii?Q?Tqe4n5u6JFqhmXrGWef27qKgd+qD53bIn+hHUQ5mV5HtvJicopiDAswnQlQ1?=
 =?us-ascii?Q?xpY286aBEZupzEtXwv8ASWOVw87adqUHSIzjthXpDxw7i6TJJJsDDptnpvM4?=
 =?us-ascii?Q?+jyh66Xu8II92bij80HhiFykkKgtwOKqXkbxHuIm+2ls7xlDOO8thOhtlsrX?=
 =?us-ascii?Q?G91NeBGUkou0VyFEZKOKamerjEVZSIBZaqAU7gzzvTtLRyYxIEoKIENip8ih?=
 =?us-ascii?Q?a3IE77su1rOPgYqaTOrljv+B1npioSD5SYwX9RaGFRKRBF3+dKwA7GSmXv9N?=
 =?us-ascii?Q?oAttN9yhMZ9r8zH/J1czwiNTQLo/G/3iLA4Jq2O5vmXMen/OmUE2vPXSLrnI?=
 =?us-ascii?Q?PA+E3fDRgYymNAOrVGkoaqSbJAfmb7NRzrhGkhHDX2jkq2tLq/1ARFkbuSL5?=
 =?us-ascii?Q?QTA48afCvYbcz2ziUem8bJ/8nEfH91x9Y0Lj80+6esuh53FYqw1rag3wUk4x?=
 =?us-ascii?Q?VcdviHEe3xrE91NggjoRHpvJobgssGYjoi3J1OypORw2k7H2WUCLp20ldsEP?=
 =?us-ascii?Q?zN0yXFpTRqOKlGqTZLvyT8e5+KfZTQd7NEitXJKqH6MOoLvDqO+gHCRD+ITy?=
 =?us-ascii?Q?gS20zAAWJ2S8lJXke/8EJvJ3iO92zdK+umfa5nYNwo2eHd3xlFO+8oXLcHsS?=
 =?us-ascii?Q?g/KL4J66ygBXYP4DGEmQit9iTdVIGd7+22ukJUzeB2FOeoS7lbuuxg1igzvf?=
 =?us-ascii?Q?q//AEvAth78B9krl6MyqiPl3wvoH16gv+9hjILYlgAyfdgFi0lLOQpwRYM+Y?=
 =?us-ascii?Q?OP4Kuuk39R9t5Ro5Khf5EWxTopyGfccvs7TzHqGunKkMdbUKPlqK3X+CuayX?=
 =?us-ascii?Q?71BuhNGBMopqmjsDiPqz5MpWaqvjzuyOvHpkA3mRNbG5pTWRxFj69XqlMbSq?=
 =?us-ascii?Q?RUuRpvnhUi0T00n8kvUpnqY1I1cI/2vuyUYF52ZnEaIjrws/Q7I5FF3G5Px9?=
 =?us-ascii?Q?Zg0M1hkZEl4EszyIlaK/cPOjFgtoSQa6KoZBJrtjLaw6w3OtZAP09YdmbGBl?=
 =?us-ascii?Q?++/Vlv9FcxnRz6/aox2vIdkbAcGFMABhFoIgoxmoWHkSbhrQxoS4vkM3pz/F?=
 =?us-ascii?Q?sHNzpkKyFgoIzaSc2b5GYCyMnGaXEqz0cGMcDYKWifBDJd4B5AywLH4rxURE?=
 =?us-ascii?Q?C/vKJsyHyMqTXoFJlhbc+wtiq+MRrP0N+7LjQR36iO1S+f2TDZhBuYgys2ij?=
 =?us-ascii?Q?IpfsCGwEfKCqUPTZ/KcZY153wWpVEyLyNnty6+zf94tt/4MgwBMf0I/YUAAZ?=
 =?us-ascii?Q?duaLHqVJPYTzh6N4I9i/kFsesRdcuL9pc1CIsqTQe3DoZqVY+Vb2sRWjPuYn?=
 =?us-ascii?Q?f6oL92x5tj4ULPq0ISNUf4M+A5fyrTh3P5Rgjft1X8W7ZJ/0V+m/R6F/0KBH?=
 =?us-ascii?Q?rSmMbqquzaCLHrRgx/LPTHf4FDPRXdZxXse6JaGaziEO1Qmc4DyHNhrzCUwZ?=
 =?us-ascii?Q?mJUrBf/GJlvwBJBRtidpqrY+4lqJ0xJA67ktH+nQOV3o5l4ZAoAzR0Lj7ri8?=
 =?us-ascii?Q?WlLrxpANmK1gnH0eSx+kVIIsC4K08YV53Ny0OzkNeAfi46AF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bf2d9f-53a5-4653-d84d-08de59c6fdc2
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:00:33.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59G9Smft2l8UsGNKuJGB3Stc/bYNO9GjFa8jcnj8tR8aLxC4nxZOV916VMuGieOHuESRU9SK7YAbnjyAUdsDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
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
	TAGGED_FROM(0.00)[bounces-211247-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 6615F684D1
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:24:43AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> When starting a firmware without a resource table after previously running
> one that had a resource table, imx_rproc_elf_find_loaded_rsc_table() may
> incorrectly return a valid device memory pointer (priv->rsc_table).
>
> In this case rproc->cached_table is NULL because the current firmware does
> not contain a resource table, but the remoteproc core still interprets the
> non-NULL return value as a loaded resource table and attempts to memcpy()
> from rproc->cached_table, leading to a NULL pointer dereference and kernel
> panic.
>
> Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
> there is no cached resource table for the current firmware. This ensures
> that a loaded resource table is only reported when a valid cached_table
> exists, which matches the remoteproc core expectations.
>
> This issue can be reproduced by:
>   1) start a firmware with a resource table
>   2) stop the remote processor
>   3) start a firmware without a resource table
>
> With this change, starting a firmware without a resource table no longer
> causes kernel dump.
>
> Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/remoteproc/imx_rproc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 375de79168a1c8d11b87ac1bd63774a3feac106d..cf044b385b58fe1e17d0fc440c243d76ecf020ae 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
>  {
>  	struct imx_rproc *priv = rproc->priv;
>
> +	/* No resource table in the firmware */
> +	if (!rproc->cached_table)
> +		return NULL;
> +
>  	if (priv->rsc_table)
>  		return (struct resource_table *)priv->rsc_table;
>
>
> ---
> base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
> change-id: 20260122-imx-rproc-fix-e206f8e6e477
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

