Return-Path: <stable+bounces-118561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B86A3F054
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 10:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EE88615A0
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F92040AE;
	Fri, 21 Feb 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jo3+t3EH"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78102201116;
	Fri, 21 Feb 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130236; cv=fail; b=YSSbKPIHDI5zaNxl7L9FNSiqbEPb8lv5TtBZ3dqYg3Z1AqiMMOJvsm24e26cvh1OxYRBGHlDKw7oX9ZcMz/2Esq3WffCukoUwSLzM5/TWIKNZXwlUXwHvdL/Euo2ikr4HwP9MmxHmEdRGCvpsuonv4OfIMDzp/uTff2MmiegXoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130236; c=relaxed/simple;
	bh=irGgn7iyLt8W+NsmNY0dYqXHX71koqQyhgmJsJotCMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OvvYm1sS5XefGOhhXotB6IoUipEfuPwSxQCXikJev6me3ASdxCX3dJA7ZlEWt2ohZwNVo+cZ6Em513UHBpy8MKdcrh3itXwbrWKRB9/NQx7i++J5Cv2DFZDI4p6JjjA0EjKBw84ImjcmpJ3SAay1v+mNKajUbmeT7u/HD/olm+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jo3+t3EH; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTsfmsZO8snWk3cGyN5oinc/swh2i6WV4BYNHBZgi2Y96yB18Wb3I0dOC+IB/NwJfGxPBmkhjmMZJqvm9S8DLElNsN2bJ80iJQk69prCatYu6NRYxiZijrA+wDyg10OT3mgbMksEQ/u38qZviOiFsPc8JYPVMmsCDs6705pGwIt2kE+taSKyPKVziwugvLRexkYZdvMQc1nJBuaPe5OzNMf3a8FAQtoLWWS+uVWUjSsWJLBJxsvVj8vbI2NMhvtaI8WIwxGl2I4fOK6/5c2VAloDE+0HVz3nTwjaK0bTfHEmB/Th4KsSQZm638tejOy50HJ7UAVX7odFUU9WdNLZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf5/1Wb3Iei6Y+oG4pn+RYsLclaLqwCdMljrrkP3h48=;
 b=Dz+kStlVMdKC+gq26nqomyQdI/Lzq21RHnqrNP6e4+oVL1ciFZOr4YS/hlp5mmgzw9PwPmuiVLdEDbSQ3SwlBX+wrf5XYHMWtNAjXbqb+65Ghto8lfWh/WCt3aNiNHNNXs0QZTTdzH1YK3r5cROnA6pDLdGT3tHbK6gAxRmrh9PSgvXi3QU98XUV4hAquBD6KVz2LeZhT4khzKJib2Y4Xc6NedxHefnLUcxXUGhNEyCZJtedlaAZmG+w8ccFQEblY2lmRBoyebrM6X99uVv1UT5p9MVDQWSKChPntIeOjx+JYF8MYuBvC/CdQuY2H7mGSgzxf8FVFx7Jh9vx7uELUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf5/1Wb3Iei6Y+oG4pn+RYsLclaLqwCdMljrrkP3h48=;
 b=jo3+t3EHnic+6uZIwwPquBZAsEB+W3RdzXEOxuvxk4YLXDpLGmhDXr/jVk7eV2ppx7DMXBqjuBiVAZDPCE036ov8kBpQeRvI+N63JwzZK8YBvuffm6Waq8F6qg0OwVdgwYvuKKDd6sUhBlPV1mW9auOL4ainYs0QpdeoHpG79wfg5lDnv5PJ64jfxmcDuzNRAIuiE07yu7+m8FOLjRCd/PHQLyQFlNhsvgG7wedPh2CfBu7aFt1TFpA2xspWqrUraW1SxJA5etimPRCvFesPFnP3AEktT5ut3NY/biXibLD1KAuomHIyRGtVamo7qf8FLOlra3NhYIuMdlA6AvajXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 09:30:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:30:30 +0000
Date: Fri, 21 Feb 2025 11:30:27 +0200
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
Subject: Re: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Message-ID: <20250221093027.wo74lqkbycky2vu5@skbuf>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250220163226.42wlaewgfueeezj3@skbuf>
 <PAXPR04MB85108B76779CDD5C6F862A5B88C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85108B76779CDD5C6F862A5B88C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR0102CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 82385394-6895-4af1-83e2-08dd525a6207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POaxgfgxG0Q30IIokQugCl1ybngvxKLdOtyiKuekzXbjIyUgVDfeI4p4Hq2/?=
 =?us-ascii?Q?26VT+1qL3+bVmQLv2Vr9U7AitoxA98hKN27xm+hlRxEUka8a2E/4j6gpsimT?=
 =?us-ascii?Q?Bov5UbSA22XbIf4k3wNE/vTvuIPpe1z0eD+mlSvwoUhfZbGAjatutNO5V/Io?=
 =?us-ascii?Q?h5HdY9GIrAkI0PheYE4D6frbXNAzmHxNX1TvVSoa/dSPfidf4dmbiwOxsQNO?=
 =?us-ascii?Q?WGVEiBeQmPDCZxYO/K+fF7Be0T8MryZXq9cYtZCgXb3X6BMFi70pawKFLiT/?=
 =?us-ascii?Q?qHF7T3X4L9kvRXH4DHorWf11NSeXDI3+2zqRVN0B3sg8rgbigF2pgeZcA40s?=
 =?us-ascii?Q?9IoduXt0gimJGvZyWeclfIMuBEGEOYoRV8fuBFJ2qpgdp3K3byZet6J0b54i?=
 =?us-ascii?Q?T/LYCNPX7Fm25+q7wbEV8FfH96LLJpl+a9LhpUCFnA5dRmlN2QYf/zdLgTln?=
 =?us-ascii?Q?iau0KitjShYydkTbkIG3o28FGZYRvgGy/uym94sIB4SOVuWESODvMWj/zrGs?=
 =?us-ascii?Q?5CeX0O/CdBSGuRHu5qRlk0nEXxBttHRMT+Cb/ctnbMVmstUgqxsK+GqdpuZV?=
 =?us-ascii?Q?yIaQcoMNbFxjZh8TzgVzYpN1ZJ7UrmxQSH8K36c4uvbkTz3KxlvxP39QW7zh?=
 =?us-ascii?Q?oLfZ4impEGHAFfhs6/5Q1T4Lo4ENS+btJ5DUSBvbYfN4pjcNFQqrGK1ea8St?=
 =?us-ascii?Q?sxsZncCXAotn+1g7J8xB/1l4yEfWwACzC9foVkHpIwohXzBTzBba/CqRN+4Z?=
 =?us-ascii?Q?xVpWK/GEZEwhVLs9dUaX4xWk2qbfjKlrUC89nI6IB0nSwf15EvdwXBVOSBlL?=
 =?us-ascii?Q?+GErgFRX94ziC/svq5SXrufKXrbt5cDylWHvL/3L2fv6t9fNa0zKuoZvQ+64?=
 =?us-ascii?Q?4kbaML7ZO3uC+Gtq6uS8Cj8eC932lzxz29ZE9zfNqEsnpa4g74dYOMBrh8Iw?=
 =?us-ascii?Q?fq2YHIM5aPah5gj2+SSVvIS3UHHY8CwQZF4MOWFJsibwonw9hBkYj44N/DOt?=
 =?us-ascii?Q?FU2vMcvQxg/DcVSqsGz7RyoPuAcm2htvSxmtyqAYfYFcwINdwG/XQHwp3EKY?=
 =?us-ascii?Q?O2YXq4DTrb2JkSZU00bkxMDVFqDqzVu72hMyEWhv8apkPeL/TQlH4OntwM2I?=
 =?us-ascii?Q?h4YctwspFAkoW5hZ0q7MlZS0B4bt4rUbIyRbE7ojpjOaZvPrfksm062qnb5L?=
 =?us-ascii?Q?xjTIiOKheefR9111yXvV4OmstzVDzP2eVgm96Oq4f3SdSL4NsIqYvfAzs3O3?=
 =?us-ascii?Q?Lx2jSOLHAK16+vdsTCXmalwhMsu1TCm42DD8zReUWlKweZU/Lhjw8M9xyUBW?=
 =?us-ascii?Q?JyZ/M53zkPnVvTZOr4pav8FZJLjLPmMbLlN+7R3d5b5tOVPFaAhKKQQTwszv?=
 =?us-ascii?Q?usfZxjwrIcDPBiHUPdjDPEb1foTV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXUXufV9/L24320yQ7HzQymWb2RdnZk3uwa6a/6dEbby9BwPm3li1yYmH9AC?=
 =?us-ascii?Q?h0ilOiofatQu7djxIEyul0o5JQIqMpgqtx4XZ23kNdFaXMAcO1+FEVguCinn?=
 =?us-ascii?Q?M8293psu/IVNqsv/NJ34JcsXumh9NcKSER+hmN3q1fqUf/mFTAkRxHQaQDj7?=
 =?us-ascii?Q?jWnaC19FgY791sV2Lp0c9tW93z/23nfQf3WpGOlzzH+8UZyxl6zI5W7CIChq?=
 =?us-ascii?Q?rmLEhqAtGQzpsdjkugU6mvl1N5XfYVCS5kUpAdbxpgxRTZEQKvws8GDo4Fob?=
 =?us-ascii?Q?qIxgbOHVAvqaxwGJNKqvGzmYqmLHWn+U6QEAsYaHa9vnHQUYByBfQAe7KeCC?=
 =?us-ascii?Q?doUHhDbdMAFRgOhu/N0VYB+0TvpawFwYnwPwz7OwITamBrQ+0fB5lRU8fi4E?=
 =?us-ascii?Q?nrRD5r6rsFoLBr1Rk0uOTR4Omcrsp4acTPDiJaKOicK/LuQISzz17IVKlzEp?=
 =?us-ascii?Q?vqLY51BnX/XoPbHOCOPLXLixcfrH9R4XccLMjD0bWMYW0iqFcDcI4HewEL2a?=
 =?us-ascii?Q?PpkNo8t5B2aApaC3r5ZhsXgsrG0jLI/afrtlMEwo7agtXlqpexx3XUfPMIQ7?=
 =?us-ascii?Q?PnCwVYfFL2RlMUXRuNCV6JFNNyZS5aVThSV9F8ANOo8BLN6oexlL9PaMY5GX?=
 =?us-ascii?Q?/+MCHU3lkvpktCd3WfOXZPrR3SII4RC+gWOwM2xvr+r+toGABsogCb+KUo6Z?=
 =?us-ascii?Q?AZ5nnB0L3b5XWolCBJBrFT8ba5PqezoVwKFAfcs+kcZWE1Xe4agO5pTQ20eJ?=
 =?us-ascii?Q?XY0q4g2CSU7hDhjxTLcRD7GbpssFc2CEcpaYP0595fR4qBgNVcuPJNYgSrdU?=
 =?us-ascii?Q?msqByBJJTa4IF9pxxX1WiJHomgmKr2unq+muXrCBJE5585D70kmPRrgNyUvF?=
 =?us-ascii?Q?+o7vO1q75udTKh5q1ZphYzER0gibeqoQ3dhS7C8ushi0Vek1j4fztIbs2CMO?=
 =?us-ascii?Q?SRRpY56TklzNQYZxyKejfW8/pU81QVyUNGod1ErH1Ib1D+1K9N+kPzTB/fmM?=
 =?us-ascii?Q?uGedA2ZZwjri0MELOnhp2DAlSiHa5aezezcqrI+yWnSj5OVcXkvHqKsWGCLu?=
 =?us-ascii?Q?lBqyRRb9sQzd8G7Gy+EdtNhquviJPCQwaDqd/ImFITJJihmC2elgxUygoySF?=
 =?us-ascii?Q?NzazH+vgSPs0SbOvRMVCgIgS5xVmnpx8WHajrxxFsKewdtn8ZYqKLZwCEfuB?=
 =?us-ascii?Q?04FzERjFdgYKVGp+Aa8+d81Li2c0ZEf5kTfbabbKgidYRaUf9rVwIhfaJEF7?=
 =?us-ascii?Q?ZDgwRZZUiExe2uVm1A8DOTF3Bs8vAgoGMEw9y3xS9SQznsFVgl2HSg4vG9HZ?=
 =?us-ascii?Q?CNz25f3ZV+GSR33uBytud0OiS5jHB2dt8Dfl3aHRAVYVIhTLj95YQl9B7rRl?=
 =?us-ascii?Q?JQ0P+PLy/RzG82C9DjUX7C1NCDrn5ZLhSe0KmAdWc++Y8mH/ZY0Dy4tpqkiv?=
 =?us-ascii?Q?T80XnmA41wFnYOedGVw6YjkA5niTBf9OiGq+FoHbp0rLdtbbI6Ej7RtodEBR?=
 =?us-ascii?Q?71qAFsD55MOm7W9LczG+X00PyKglr4el5so74h9FDWQJfd1usbFgSyHT16mZ?=
 =?us-ascii?Q?z29M4keVoK/xDHzRLY0DMvoXh3at6V5drCAu8sEtch/fovSsSboxMWVaB3Rd?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82385394-6895-4af1-83e2-08dd525a6207
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:30:30.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0CmjF6mUMv3ZUOu5bt8IGnr5UArHvoA6UNnaD1PdrUzz8Y1Lj/O+fOJDhVj0txfEy5mqpf5zD903EG1qB1kDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787

On Fri, Feb 21, 2025 at 04:56:03AM +0200, Wei Fang wrote:
> I agree with you that we finally need a helper function to replace all the
> same code blocks, but I'd like to do that for net-next tree, because as I
> replied in patch 2, we don't need the count variable. Currently I am more
> focused on solving the problem itself rather than optimizing it. Of course
> if you think this is necessary, I can add these changes in the next version. :)

Does it cost anything extra to centralize the logic that these patches
are _already_ touching into a single function? My "unsquashed" diff
below centralizes all occurrences of that logic, but you don't need to
centralize for "net" the occurences that the bug fix patches aren't touching.

> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 6178157611db..a70e92dcbe2c 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -106,6 +106,24 @@ static void enetc_free_tx_frame(struct enetc_bdr
> > *tx_ring,
> >  	}
> >  }
> > 
> > +/**
> > + * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer TX
> > frame
> > + * @tx_ring: Pointer to the TX ring on which the buffer descriptors are located
> > + * @count: Number of TX buffer descriptors which need to be unmapped
> > + * @i: Index of the last successfully mapped TX buffer descriptor
> > + */
> > +static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
> > +{
> > +	while (count--) {
> > +		struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
> > +
> > +		enetc_free_tx_frame(tx_ring, tx_swbd);
> > +		if (i == 0)
> > +			i = tx_ring->bd_count;
> > +		i--;
> > +	}
> > +}
> > +
> >  /* Let H/W know BD ring has been updated */
> >  static void enetc_update_tx_ring_tail(struct enetc_bdr *tx_ring)
> >  {
> > @@ -399,13 +417,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> >  dma_err:
> >  	dev_err(tx_ring->dev, "DMA map error");
> > 
> > -	while (count--) {
> > -		tx_swbd = &tx_ring->tx_swbd[i];
> > -		enetc_free_tx_frame(tx_ring, tx_swbd);
> > -		if (i == 0)
> > -			i = tx_ring->bd_count;
> > -		i--;
> > -	}
> > +	enetc_unwind_tx_frame(tx_ring, count, i);
> > 
> >  	return 0;
> >  }
> > @@ -752,7 +764,6 @@ static int enetc_lso_map_data(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb,
> > 
> >  static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
> >  {
> > -	struct enetc_tx_swbd *tx_swbd;
> >  	struct enetc_lso_t lso = {0};
> >  	int err, i, count = 0;
> > 
> > @@ -776,13 +787,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> >  	return count;
> > 
> >  dma_err:
> > -	do {
> > -		tx_swbd = &tx_ring->tx_swbd[i];
> > -		enetc_free_tx_frame(tx_ring, tx_swbd);
> > -		if (i == 0)
> > -			i = tx_ring->bd_count;
> > -		i--;
> > -	} while (--count);
> > +	enetc_unwind_tx_frame(tx_ring, count, i);
> > 
> >  	return 0;
> >  }
> > @@ -877,13 +882,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb
> >  	dev_err(tx_ring->dev, "DMA map error");
> > 
> >  err_chained_bd:
> > -	while (count--) {
> > -		tx_swbd = &tx_ring->tx_swbd[i];
> > -		enetc_free_tx_frame(tx_ring, tx_swbd);
> > -		if (i == 0)
> > -			i = tx_ring->bd_count;
> > -		i--;
> > -	}
> > +	enetc_unwind_tx_frame(tx_ring, count, i);
> > 
> >  	return 0;
> >  }
> > 
> > With the definitions laid out explicitly in a kernel-doc, doesn't the
> > rest of the patch look a bit wrong? Why would you increment "count"
> 
> Sorry, I don't understand what you mean " With the definitions laid ou
> explicitly in a kernel-doc", which kernel-doc?

This kernel-doc:

/**
 * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer TX frame
 * @count: Number of TX buffer descriptors which need to be unmapped
 * @i: Index of the last successfully mapped TX buffer descriptor

The definitions of "count" and "i" are what I'm talking about. It's
clear to me that the "i" that is passed is not the index of the last
successfully mapped TX BD.

> > before enetc_map_tx_tso_data() succeeds? Why isn't the problem that "i"
> > needs to be rolled back on enetc_map_tx_tso_data() failure instead?
> 
> The root cause of this issue as you said is that "I" and "count" are not
> synchronized. Either moving count++ before enetc_map_tx_tso_data()
> or rolling back 'i' after enetc_map_tx_tso_data() fails should solve the
> issue. There is no problem with the former, it just loops one more time,
> and actually the loop does nothing.

Sorry, I don't understand "there is no problem, it just loops one more
time, actually the loop does nothing"? What do you mean, could you
explain more? Why wouldn't it be a problem, if the loop runs one more
time than TX BDs were added to the ring, that we try to unmap the DMA
buffer of a TXBD that was previously passed to hardware as part of a
previous enetc_update_tx_ring_tail()?

