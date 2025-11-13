Return-Path: <stable+bounces-194711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80114C593DA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0131E56121F
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1E35CB85;
	Thu, 13 Nov 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8oyGxmY"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65635CB68;
	Thu, 13 Nov 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052905; cv=fail; b=OcXI9ShGeyVOEd/wEqsMuvjylPnnCIWkUfgh5EtScx3d1v1LVkrorzZuH3IyvNLA3elSh9XA9M0FGVtUvUlpGyfw01RRtfoSodXcosJwO2jtajhgdX+tMpzhDIiByOqBVBXTY+yp6IsH5FW0l2R+knEy8zDirEISQPundub35mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052905; c=relaxed/simple;
	bh=xSUz32N/xkEvG4wVG2PFJCDe9/z0CEZEyUgRXrXs6mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EO8R2wrgvvOxb9lq3gPzUHVOH601OGYDArE7Q4oXf+9MSAoEBif5MxtujLo9cMpxd8ICDoAn87bRnWSOYpYbGw/BSvAWSGdoT3EVQM924m55xkIYctqocmDDLqJMJqbO7qHKGMvhAgpLKZ15GjDsmvBvgzCQsjsfJ52fU/392N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z8oyGxmY; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIfB6cQs1E1WRDBYNjGf/WYadSQfVXDamA+3SrQkENNblSNbTU0M5Vgi/EBDegELPV9l0yPYP4xgCiEfI5S8pKB5fOtEfYTf6VImfTKkoBFh8gW11OVUp7HtWDE106fL3EEzdcntj4ad+DveEg7Ln6L7KmpcLtJ+yk3uw0FLBt+BfmSvXIeIC3+v9r4iFWuGXdcGOKyX9+qFJUdXZZgwWONBYww4tZBicsUaX51nYgOB0zRLCCxOivo4ouCIUPOhXOcBviEYdgcbMba3HDjaqGDX3gKfJ4KJ4pK1+GqAYXaONJ2DjBFyCjLflpMOwPGeWLMGzP38jHUijZgO1LFzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAlDM17YPyxQY3I/7yGloKWpV7hSz/3jDBT+QCkGqDU=;
 b=zCLUwQhrmwstb4dBXxU3yOxSBpmGrB0d0k9ekLloRiK2wS+p+lbGC3OZTU/6kxIOqQn0cK75rZ4XlnMXzAETgRn+cPxdE4audn2HxKvX/T+9t3SHsYBDTnJ+ELwc5gI1X7nFG+SLbsAmJ/XiasVao0I5OsYfxEZmWQaMsVWny/fcRfLevZSSySSHZifTCY0lkS+UeuzrTr2lTvOpJlDt4hYwUgAGPGjtLrIOhHYcCoENYNwzjDaapne5fWH6DVBkuDPoURov4qyEKYIm+5CsRqt++DkgAgEWc7vXjDIxDyFrDOcgJX8tyS16Hb+S8DCBauDAMmVQgPxGjYDVzYvk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAlDM17YPyxQY3I/7yGloKWpV7hSz/3jDBT+QCkGqDU=;
 b=Z8oyGxmYIeuiiSPY2gxdeF4l/jtWuD8JGtXlkYSfvRLCCMZYgH5XBT6KPQePb7uG6ukqy5sjpfhEy4/TswMQH8Fn9/gqGCl56hQjnoluH0mLBtpd9u0HJtVOAz6R9d/EdkTIojQnwmxhCTN5ho6JO4cVe4ptt+rCBHDpmHrvdkPwlXOyXZ8NrtuVV3SvXGZWDx6s4pSiZm41BtK2edogdD17lj4vXucUFp7VrMTmv/QdXV0ZInbQqVYkNM8Em7PwWsLQ3f6M1lqSag/hbFP7sz8Tjjo/9MO9cFKNcHnUGx6C6lnJVzLER/dBDc2XoYdNJzH6+0ZxHpdTRq8HkmuvOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by OSKPR04MB11367.eurprd04.prod.outlook.com (2603:10a6:e10:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 16:54:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:54:57 +0000
Date: Thu, 13 Nov 2025 18:54:54 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 phy 01/16] dt-bindings: phy: lynx-28g: permit lane OF
 PHY providers
Message-ID: <20251113165454.2fxy5s3ejuepjgy7@skbuf>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
 <20251110092241.1306838-2-vladimir.oltean@nxp.com>
 <aRYLeVUSk5G3DYlF@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRYLeVUSk5G3DYlF@vaman>
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|OSKPR04MB11367:EE_
X-MS-Office365-Filtering-Correlation-Id: a88d00e3-65e1-4139-f64c-08de22d5601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xq+bKUW6WA30xIH/OeLjQSs6FLmAWCD25330Tb0a0fvk/sMqVf6MLunZAGTh?=
 =?us-ascii?Q?ZxNGmv4c26BFnRGPIexLIUuWqddDwu11VeWWhH0InJ7ILOHq/+Io7X/iXIQt?=
 =?us-ascii?Q?i4rvlDZqwqbnoyyT6cDtj8sHAZc3WvSeiODcL6MOxgCDWw+w6MjyT8uguwOe?=
 =?us-ascii?Q?B2mBb5AsX3Y8sA3YM0735+kyFl6zHZLYNyzNJMyoRNndT/1VqUlT7i5YlO9T?=
 =?us-ascii?Q?pD6bhyluc+8rFk0UkqZ6ZuNkjc1NReOe4SfBWG0z6G0szflWhe1CX2WiHDXc?=
 =?us-ascii?Q?1hrOy1quEKy6k1L/ceih2RSiW69zAbCn/Npl3z+DYhHcDMtwVX16Y3tzNR3i?=
 =?us-ascii?Q?U3W914mgvPe+1TLhNBa7MhLi67Yfdfv2wqxxHGyE35m/cyQNmst+JiJ6iwQL?=
 =?us-ascii?Q?lhBJrH49XBw8bdoLbLeR1PU1z3r3Qq/pZyibt9e0Epl5++VAAe6rpIhRc1gg?=
 =?us-ascii?Q?BBSfKZXx2EE5woEjcWIghIDNXtnLFORZJa7kyM/Q1w9tgs9wpubBLqp0+1e3?=
 =?us-ascii?Q?dboB6i2HxMG6bjXhDsEHbs6iK2gOBJHui8UpM9JUb/boJZ2x2Fo4V6EYTysb?=
 =?us-ascii?Q?nI1Roxw7B5hP5Vp9cB5ZJO2+ap//cr6BqfHdVz0szFbYBS5RbuLgx/xfMVcP?=
 =?us-ascii?Q?8t1mCPgpHj7wBb1kJMMvwM97pupIs5l2O+i98G3wYDcBrPe2Vqs0ChlAkUU+?=
 =?us-ascii?Q?J/mTyWRjo9ImorQEFvAL43zZMePNVSf2BJ7Q9z1g1s6CXManOkgnsiAnhHm2?=
 =?us-ascii?Q?8+oVU71QbeAf/DkQwMKC3ulYsi6XiYQvGSaY327oENlEiCOgcCTK7iPDpLkH?=
 =?us-ascii?Q?lcLETk93Y/83TPMlY2CwDa3ePw3mohRZz+vUWHTL3pNWbRZXdyZS3p2SrtC5?=
 =?us-ascii?Q?qKNanDouKpbjVXPFlRCrZN+V6YlUFDVhsZHPH0SbYBCSA9riYeUzRTH8AJ5x?=
 =?us-ascii?Q?/7ddEO5EcH4BFW7zaiSFyuawjfCQAmpXCslFA00N6NZanHQdA30TVLd14Hiy?=
 =?us-ascii?Q?2U8wPyY1A3QfSGan8FnGjAsHYq7N2d/H8Pwei2a1AEDYVh1DeNkFiCRaangW?=
 =?us-ascii?Q?K6jf5vU36XI5ju6jHsc6ArexxG/VODLHX0AAjTkr8KSbhv7L2GYWImXEx8sg?=
 =?us-ascii?Q?14t/rDXy9rsG/cEQ8WYgVrkfkHL2UrpXt1/btzYUpU1JWU0pl490H37eKHiw?=
 =?us-ascii?Q?Wso8/NBwAg3z903a+hsFMWJU0pyr0+mlAGDb5Ah3Zu32rd/xaYfrnB2JksTR?=
 =?us-ascii?Q?GDJJrXJpwwMrbQQTzgNQALr2J8wt0Lvyhhoav2Pmcxgqgsz5s2vL+h7umPqn?=
 =?us-ascii?Q?Sf517SBtmOLGVUD+q3g4akc2V1RIS4BNmK6Y8jn5JiIwkbgLDQPgN3IDbWTn?=
 =?us-ascii?Q?kxe3eW/jbn61Z+5VsaWY8XEDalEWPsGep2QtcIN7E19R0XS+IjqvLwH3CE91?=
 =?us-ascii?Q?LBM2p1tncp3mN9aGTLYs8ZSuv8CoO/uGPclKLbmNHbg+0dKgW/UpDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BfguhtEDovZ4r6CR7gSidquT2l3+s/Tqd5Ot64P+ecXWPuBJaP+blXZSk7TV?=
 =?us-ascii?Q?/EFssxmbEq52/EFCUXLFJLi3ZPBSLRzuFqYx9wp7qvNPAlb/XV2qBGFCgpqK?=
 =?us-ascii?Q?F0U09dF+0AwIS+mlDmSgIdSqa/anbzKSmifrbLhF7uUmPHzzV4/LiJqp3hFx?=
 =?us-ascii?Q?fwr5/KQTwFoNI3aXMalmEQOQ8KAcWwWcXKQC4XX9cOVpw88VPilC+jYnwhnz?=
 =?us-ascii?Q?a+pnRvNnCkNBWwlZZlKiGX0czM1i92tLufKY04QTcUUwcmmk/ENkZBNs0We7?=
 =?us-ascii?Q?zeMOSNm8QpFOfzxFpo/QZZUMGD1840ErmwmPOnSU7pK8Dpxq7DdTphCvMnZF?=
 =?us-ascii?Q?ERSyFFOUIpBFHvBc+hAMGBewBVyERdPwSUIO7J2MEZaazurb1g6yinDnAHFT?=
 =?us-ascii?Q?N/Blj4b2t3JpNCv/lYkLcugIWpT9OOFReuzvkQ0MiLY65FPWTFAAH/cY+bFc?=
 =?us-ascii?Q?qJvaE799RgsAfSAWIP8vEwCl4iTsQJIfOvM5qMFYYO/O4sJPzwVnwo89eeyL?=
 =?us-ascii?Q?MjLjWqECNePC+f4NlpSeXAGA9K1foCR1uLANLgMLP4EKSwJg9ESpZsknTAFB?=
 =?us-ascii?Q?MbhGZMc9MEeU1UhqDsACjreXumWdEdkGS08g9RwXpr/MU8WDpOWDAYisZcKa?=
 =?us-ascii?Q?/ovCJv1KwYwk6ELVrUIGCRWT1FLSF+rUnYM40doEtXANu5UTJ+ZwjrDyJpGX?=
 =?us-ascii?Q?HeMNEcru8pGbfryRKM1xC4H0Se8JQC6ZDT1WaShbl8pVb3oSDeslRmPQD3Mt?=
 =?us-ascii?Q?oxh4xRc7ABR46ltrvQ0DP/lxSdtjVvEipqv7m36XNq/KoMgYMDSv1veLJ6MK?=
 =?us-ascii?Q?219q9+5J4W0hzxDpLmrZ61KoO3m3uydzZNGgsyzd5wlll7tHe8SJrtT6KnmC?=
 =?us-ascii?Q?BNAle9evseZmQoPbqjDZn9BNil3eWbIgiyyFcQzusUq06bi4UgJ7DwhVBItR?=
 =?us-ascii?Q?2OMgciy8nrgEgmcmV1JN8uG403fC8LEt/DpjE1WVr63rCoROMrLSZuTwGj6M?=
 =?us-ascii?Q?/rAvBF5Jt/oyI/714NgR0naFJZQcvLpK1slXYXR46h5RfIqTEh+CTff6QgC8?=
 =?us-ascii?Q?+Wag6R2NmMx+j5lhVUSYNPJhbobKLgVGc2jvsweiarkd2KLgfBP5fa5kqRYx?=
 =?us-ascii?Q?QNXRtOY9CZoM0QkCSOHgYomJ+tnmKgfEOrkDItApMJJrwRSbMWNAkX+BnjWY?=
 =?us-ascii?Q?bbi5mKcfoR+48gdERD2pmlWxZnaA+9IV6qftOZjfxVhVrJeL/sGbf25LOrkk?=
 =?us-ascii?Q?4WQvJ34e4aavexB26sIy+ch0Xk9uSWtonb8wDRX1YmReovZR4Y8Ql8bBE+4j?=
 =?us-ascii?Q?aNmyl26v2ebbNen1azsEZqez0YdiseJa57xY/G06a+IFMU3igPLVOz/3m3Rh?=
 =?us-ascii?Q?XKMVoPDaGyxlMT6Fq/DIkKK12MID5Dc+Ih36wntnIo5n5TozdEhn0LHuzwf3?=
 =?us-ascii?Q?3jjVBAcRHmOoQ6kGf+khuQOpYdEKA2OeE/0sF53P0vV5mLfAeyqkY+CAfKR1?=
 =?us-ascii?Q?nlfpZYYOectPtZMiinHQIf1YU1GT+OklU4vwChd4te/oPdS51AzVmkn8o6Zf?=
 =?us-ascii?Q?UNAQ67ML4dt3oVwavGUeFOP/Q7ZMSjb70sppgXXgu68LnMPYrQqwk3/EysyY?=
 =?us-ascii?Q?g8bVZ0+V7S7yzW92vfIPH5bjxkpyhe37DhT+28ZuAXhjftzSyKgaqermDJ7M?=
 =?us-ascii?Q?s3zkyQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88d00e3-65e1-4139-f64c-08de22d5601d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:54:57.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yge4z7XkxIKRkNFq6D3FOIRbA+U2Kjqcf+/+Fr6XUe1th3hvyP3Q7JHCwNLa3Lr/tl23uz9bTKGnj3cldrRXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11367

Hi Vinod,

Thanks for taking a look at this patch set!

On Thu, Nov 13, 2025 at 10:16:49PM +0530, Vinod Koul wrote:
> > Link: https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: stable@vger.kernel.org
> 
> You can keep cc lines after s-o-b line after the '---' separator, that
> way it will be skipped when applying while email client will cc folks.

Yes, but keeping the CC list even when the patch is applied was the
intention, especially for stable.

> My main question was cc stable, for a binding additions, that might not
> be helpful as dts may not have these updates, so why port bindings?

There is a faction of people, whose point as a matter of fact I do
understand, is that if you make an update to the device tree, you
shouldn't be required to also update the kernel for things to continue
to work as before.

The purpose of backporting the binding addition to stable is exactly in
order for kernels such as linux-6.12.y to start supporting modified
device trees, such that one day we could roll out such modifications.
The series doesn't depend on that, but the "DT is ABI" statement has
implications in terms of kernel <-> device tree compatibility, if you
consider the fact that they can be delivered to a board through
different channels. For example, you try to ship a bootloader that
provides its own device tree to the kernel to support generic distros
which don't come with device trees prepackaged, and you have to support
2 LTS kernels with that same device tree.

