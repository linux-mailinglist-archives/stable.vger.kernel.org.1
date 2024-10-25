Return-Path: <stable+bounces-88139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120709B0006
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B27B24CEE
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB081DEFE9;
	Fri, 25 Oct 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GoBWA1xr"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AB18D642;
	Fri, 25 Oct 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851809; cv=fail; b=RZwmmVJWYj4RVDlXjtYlL2vGnBqnMDB1OoxUCAi9KKhbZNza8gqYfElmFl+cQhiChQHY5bZqu9Jdp/eH3ccFZ9Xf1Z1JF+i47XFNBMkVPNps8gb469P/Nu4smMeJm5jq4r+T6oGyCdCRyyws6pz1YJLVf5ApOAR5TJbBcxr2p4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851809; c=relaxed/simple;
	bh=Pv0AZu8HEUKGZ94AYg6HGV4DcDgSDyJzQahs/W4Jr1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sPI3zhLicJ0qtY6YapbcE9EM5Vgdx4IkBw0lq2FbzQ/be72NmuyOmjpjqJs8s8YZdWZYs20RPw3m2uAZszOO8Bhiyo9Rf4MQ9F0GFALiyuCR2LLkOli08FsJ4AMhm8asDcdEvcLd0a8Fx+bEbSgUh917gf2tX7tZmaSFOGkn9CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GoBWA1xr; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrXosK3eEqwewjAC9AZytMNXrZDwBc5sk4g4OCmM4tyuDI+0lE5ZiK22FedlH8bL/n0CsCJNlykykWwY1Amddxa0l1ZOXDABvdOIdscGwONuWpGAWuWzb4XAJRMErX0nBHe1EowtFZowlB2rV4HPTqD9hudXzErDeD6OivfIqUVw4n+xmjMZGRjvtDRPzModxwqc6JpELGAHHDJivCe7B4NIAqTMTsrvRJr0BOAxa17cAsLx4mM5aeQwKdEmT4I7tICB7mZBisPIQu17cPXTvpk0Mg1h94Llw+HSqaFD4BeSsmfW2PYVviTn29SwGd7JqCo8x42F9Z3nxhUl9CpGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2x3WWKdaHyoy1u4MgQ7icrpdW6MFTaKtLI5BylHDIs=;
 b=j8OJhJkPCLNGrH3iTLKHeepi9p2DPHjOL4KKDJ54gcppVyJJVwSJKfRTFmZf2N9bFWZ7LGEEe7hJmmf/oB5RzpQBUDxx21zxhiOYf9+8EB6rMh5iw9UQNBqDEjZH7Ho5UitCKDI582GYw5T0nngjIELiN97ulVm6z20VAqRCVVzrPvaI8zfDOtxAnkRSks7tqIs4+6GxYHPMbMzSAYiMhcrE4RF7NmkMsgg84cYX+2MI8CUDGGlLHkEhvukzn56gEgElRSCkXqnnwsCPFylbhlApCSmy+PJGlM9k6QVp0+UrhGNj9Pz84qJ2T0EUhNfbX0jLbDDwEqTzxfBC09z7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2x3WWKdaHyoy1u4MgQ7icrpdW6MFTaKtLI5BylHDIs=;
 b=GoBWA1xrhgctdolgWu7O+zxCA5zXhBHJLRQe1cHlHItjQKuZFN9PZvDDMOdPi0LirAFQQDZe7ovR7D37cv3x8/onmaoTFC7OdPm+lVG8fZ/b3V1+Job60VXGq1SfnfReUJ9pVG2tyH3p8ZSzeoQXphvJurh+lbk1OgtdkQjVebbsO3Bhe9JgdjZfddxXFg6AqvaefrK56HJnzZB/9cVQhqgY1pWBBcvHRp4nyoYJ03DXAocqvA+JXkFAA75hCkLBk2YFkKgaiupVx6OuvoB0AlbVRJJRFNCqmkwU64hCF2NNtJIyhXXADVazXIkMhKTcOG+S8dfZxPc57ip45FrBfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBBPR04MB7691.eurprd04.prod.outlook.com (2603:10a6:10:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 10:23:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 10:23:21 +0000
Date: Fri, 25 Oct 2024 18:21:13 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	rdbabiera@google.com, badhri@google.com,
	sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: restrict
 SNK_WAIT_CAPABILITIES_TIMEOUT transitions to non self-powered devices
Message-ID: <20241025102113.5vedfekktd2xgwsu@hippo>
References: <20241024022233.3276995-1-amitsd@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024022233.3276995-1-amitsd@google.com>
X-ClientProxiedBy: AM0PR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::24) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBBPR04MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 906a4657-18b0-4b7b-9cfd-08dcf4df0cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JZbb9hY89FlTnlDWtgm1sltkHQeaOWYCJAkELTo4e8IWv+6exvH3QXdR0bFY?=
 =?us-ascii?Q?J+Fjtt3muZ61JM1Zu4EH7zRJuhc5X9djhu4Un/wiL/JSFYDn1C5N57BEiNat?=
 =?us-ascii?Q?j549hLUKwDWfAcDC9UWqIT8gxUsTLhEjwypzw9M9Xds3jILk+34bSbDUyex9?=
 =?us-ascii?Q?WzD6C9liv+tQRpEyGT16ktF2eVM5Ec/hDkGOOYx9k/DHb0H11vmPqb7cFZwu?=
 =?us-ascii?Q?uCEP/s2Rq89sRsCWOfZpwQTpBm9tAaBFnDBAuoJ/6qs5iUGtnBXaMhaQlyhE?=
 =?us-ascii?Q?nz7JPqd/hmVy5aVLUZeTpPTnlli7H+FHw/TWsBpXbvif4vaTQxVtmYIyALLQ?=
 =?us-ascii?Q?Dzib5z6Xc1xh9jXOJwPF878KDfGWq1xIBTcVaESDQGyhHUZUxeXgGYwUUGwi?=
 =?us-ascii?Q?OOC7Et5e8FIMYuF7OhD83HhwrtQBKU9GKMjkgMi++LXQW7K0D5RIXfMh3Frn?=
 =?us-ascii?Q?IviVhE+XeCgr+xUxVYkUGGpifA88PB1SSa7UxGB7mm0NZffkG9rWxhHdq/K0?=
 =?us-ascii?Q?0o2wiDmRRfWLP/XrMWhFs3ZnnC0pCqSDIpyIv7w9d+/2EQGknoJsJS8exd0a?=
 =?us-ascii?Q?ggjodsveynGmEgNxi6BGAcZztqcOXIQ+Wb27camJecF0BAh2nSWQ3PQay9AE?=
 =?us-ascii?Q?pvTEPObdPCqe5CHBGF+EOP0dN4ZY9Wc1b4e+SCEPojCEnK2hOIXHRovtGgo9?=
 =?us-ascii?Q?FQIY7Xwfj2z6IDN57/2DZs8jWwS+HUeYKxIyOnPHJbmutk/Y3Gugie4Lpv3c?=
 =?us-ascii?Q?uccloGJ6kQa18WdEilLpOlNaTGN/qvjykV/0WgUJDjP6krepJ9bSeWg3gFP+?=
 =?us-ascii?Q?1M199EMr5H5xkjaFPGnWuAHoZA63QqAjgkCU/Ctksp+qMx2N+QTyNoJk3MLr?=
 =?us-ascii?Q?6L+LuvCE8s2dCuJLv5i8mx+F+lMZCD2h3nR3WBtcBGGheZau2F2vEvrIilA4?=
 =?us-ascii?Q?RLVQ5VX98KZowSCPcSzjPbBVTQujev1md/DAf0XGBtyg5+DhV/Hp0rYHZXDB?=
 =?us-ascii?Q?3/yLdV/YBmEPvMxB6niTwxqPyHIPURySkie78K0cCtEzUp9LsYyq6qK6E9ER?=
 =?us-ascii?Q?SqdZgO/RJ1B2AADUCChXX3raxEJrd8NQP3A75RKtg2ypjZpMYOYEhA9lTaMw?=
 =?us-ascii?Q?HhTfJToqaSsAsswyssFFbBeypC1vK37APGG1wUvDiZbHstEjWM/zDnOWpDtG?=
 =?us-ascii?Q?iY8tNWka1+xkLK/7qpDfqyGSg052Q1lO/Wk64WeAVJzMM1zgmpu0fV1tGl7j?=
 =?us-ascii?Q?6fTUGO4Hjzj8BrRrfc82/aH/u/ixpn4H2gp/W//8VjOq4xceRRunnJDZCoP3?=
 =?us-ascii?Q?ZpbV6nCMRL3HBKegO1Wd+4BPoTSIKh4ktZa8yRjtGv7t7nys95LyqRhnrmny?=
 =?us-ascii?Q?zsM+y+TP3GeC9R78dDq+IvzusFdN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3Kknn5A3azjh1+9IeX7V4BJLgykguhjBUYP3yqdD1ry6ybH2IpspekFxL9T?=
 =?us-ascii?Q?uFcmM7/OAlZmy4pqg6KS2exIHfJIxs9FFeJWzCio/Y/ogWJ9h3iOnA08VjKT?=
 =?us-ascii?Q?fKnk5d8ndKbPLmJzv5CIyvMt7a7gLxeUrUO/BoM7cokntgy19JAuHMEwtmNf?=
 =?us-ascii?Q?dkdOF8NPnnnaBTY6monUGRmcDXSyVDCGMByjQ2kEKYxh0ZMjOExZKrJP/rgl?=
 =?us-ascii?Q?uRCDVt5NZtq97Cb/PZAbQ23a3BcQjYczvzEuqwWyH2btbDOIuSyhizq0yEZd?=
 =?us-ascii?Q?rhv7qM3oOKC3ggrpZg9HkjtrhKGzIF24JKaq+tntQQmmGabs3MJAUaCb6glM?=
 =?us-ascii?Q?Qz4BrUvxR//p2jSKTn/G0rKW78mJLWt5EVdkVfLQmNPZnXb+6hj6Igt328d9?=
 =?us-ascii?Q?elTDsM9UM4m63i+vNn+O5Ht0ReWcR/tjt0wqQe/qFGx2pi/xF9dOSodZvngK?=
 =?us-ascii?Q?AICD92dUWuXJrrbcZFNWca9sddl1PNUngYMaGQw1EUda+oCyXaj0SO3zfWf/?=
 =?us-ascii?Q?1gifhMMtBJyRLxfq3cVIckmXXo96otLZpjozfayhQltSpIwJoL6HHIxbm8bT?=
 =?us-ascii?Q?mkaLfgmEYXaRGOUym98Q/1mlIGAFwzAdw2sJDhe55FW9UruHqkNpnXWOWZyO?=
 =?us-ascii?Q?CgAnbQQC01UUcuirQaw8xQZDNPEyouT5+dlXOGEvrvg/SubR6/qHhYclBpfd?=
 =?us-ascii?Q?enARbLfcqREZ6VAAYXp+X+fqjNQDwrbTMU/tJqJCK3+RW9Ft9fHHpin8FKLy?=
 =?us-ascii?Q?hwU64lINdvmRp4Ob0OZz3XDzzjFSwwsjJqwZES9SqvxjLxcknmixCIqjJbA4?=
 =?us-ascii?Q?RfEHPp3ZQyZJ21WapTcom9u7EXmh9pmhQma093s8G4Q56gPzeFpP+At2/aFA?=
 =?us-ascii?Q?V66SBfZComrja6QbnFdEpT4nPocevVJNuug/7kWgVeRD3e7M/+W8+vJ9oNQt?=
 =?us-ascii?Q?xCyjWMB2u8sgPxd0bOW6E/wZUyXPseX5EEsRYhNdnRM3JIXqqNisLoyIHeb3?=
 =?us-ascii?Q?F2Xw3RkgSSAGtk4cASwifN2hXNOnEnhrf6zaFZ6858kGjCYWuRFF1ZSVw1Yn?=
 =?us-ascii?Q?Z4O9umF2CyA/vjsB2j1FGURsUaWe4L0cUCtCFdw2fcNucP1Xif9NXfsf1fNn?=
 =?us-ascii?Q?fBBooI14NfGwAuH2y5xf5oQQpXMA0CwL1L8+MA7Huz2ejw8vZvmf/ddldt9L?=
 =?us-ascii?Q?7FW9VXsEDbORGmnH7QOd9W52oRZ8htE8Fp8uxPmiLnFsdDHXMdH56oa0yWQE?=
 =?us-ascii?Q?WU7LtqKrUVZIpXMVjrdb5OOAsZU2dQpdizIjZoZMG9pYkdvNPMtFt4F7FhGU?=
 =?us-ascii?Q?cGg0/juET7c7fG6Z7iEScAqJZ30w7pBkWREYaiQaccklaOttGMxTYkneZKoP?=
 =?us-ascii?Q?1t1oVAnM0rEMkS5Rfer3V/7gUWVEyKUuOjMgnIgQpBXvb/LTrIs1onPpXGQA?=
 =?us-ascii?Q?3Z9E1KzSGtvnt6fjGrzmEQ4QlpvQmucGfK+jLfDbpWzvEqcC9AAZ945I3QLd?=
 =?us-ascii?Q?VayTLBwcqrTDUxf8HRxoISEqzeM1HGcPwhiXiIyiG9vpRvNu2ir+WM4mAV0N?=
 =?us-ascii?Q?wT6ZigipI43UMBA7n1x1iNc1mFy0HV8Sq20i6C4U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906a4657-18b0-4b7b-9cfd-08dcf4df0cd3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:23:21.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSnwuNX29hMgYneYmrIcHy3qWVcU5YzwhdD2vNrhT+BXjTw5UuppyAYmQbwGw06nqLev63uhSe3+R5CYQK7wrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7691

On Wed, Oct 23, 2024 at 07:22:30PM -0700, Amit Sunil Dhamne wrote:
> PD3.1 spec ("8.3.3.3.3 PE_SNK_Wait_for_Capabilities State") mandates
> that the policy engine perform a hard reset when SinkWaitCapTimer
> expires. Instead the code explicitly does a GET_SOURCE_CAP when the
> timer expires as part of SNK_WAIT_CAPABILITIES_TIMEOUT. Due to this the
> following compliance test failures are reported by the compliance tester
> (added excerpts from the PD Test Spec):
> 
> * COMMON.PROC.PD.2#1:
>   The Tester receives a Get_Source_Cap Message from the UUT. This
>   message is valid except the following conditions: [COMMON.PROC.PD.2#1]
>     a. The check fails if the UUT sends this message before the Tester
>        has established an Explicit Contract
>     ...
> 
> * TEST.PD.PROT.SNK.4:
>   ...
>   4. The check fails if the UUT does not send a Hard Reset between
>     tTypeCSinkWaitCap min and max. [TEST.PD.PROT.SNK.4#1] The delay is
>     between the VBUS present vSafe5V min and the time of the first bit
>     of Preamble of the Hard Reset sent by the UUT.
> 
> For the purpose of interoperability, restrict the quirk introduced in
> https://lore.kernel.org/all/20240523171806.223727-1-sebastian.reichel@collabora.com/
> to only non self-powered devices as battery powered devices will not
> have the issue mentioned in that commit.
> 
> Cc: stable@vger.kernel.org
> Fixes: 122968f8dda8 ("usb: typec: tcpm: avoid resets for missing source capability messages")
> Reported-by: Badhri Jagan Sridharan <badhri@google.com>
> Closes: https://lore.kernel.org/all/CAPTae5LAwsVugb0dxuKLHFqncjeZeJ785nkY4Jfd+M-tCjHSnQ@mail.gmail.com/
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Tested-by: Xu Yang <xu.yang_2@nxp.com>

Thanks,
Xu Yang

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d6f2412381cf..c8f467d24fbb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4515,7 +4515,8 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
>  		return ERROR_RECOVERY;
>  	if (port->pwr_role == TYPEC_SOURCE)
>  		return SRC_UNATTACHED;
> -	if (port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
> +	if (port->state == SNK_WAIT_CAPABILITIES ||
> +	    port->state == SNK_WAIT_CAPABILITIES_TIMEOUT)
>  		return SNK_READY;
>  	return SNK_UNATTACHED;
>  }
> @@ -5043,8 +5044,11 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, SNK_SOFT_RESET,
>  				       PD_T_SINK_WAIT_CAP);
>  		} else {
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -				       PD_T_SINK_WAIT_CAP);
> +			if (!port->self_powered)
> +				upcoming_state = SNK_WAIT_CAPABILITIES_TIMEOUT;
> +			else
> +				upcoming_state = hard_reset_state(port);
> +			tcpm_set_state(port, upcoming_state, PD_T_SINK_WAIT_CAP);
>  		}
>  		break;
>  	case SNK_WAIT_CAPABILITIES_TIMEOUT:
> 
> base-commit: c6d9e43954bfa7415a1e9efdb2806ec1d8a8afc8
> -- 
> 2.47.0.105.g07ac214952-goog
> 

