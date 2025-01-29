Return-Path: <stable+bounces-111204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD23A222FD
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E12F3A1574
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016A91DFDB8;
	Wed, 29 Jan 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="gll2lzlx"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2205372;
	Wed, 29 Jan 2025 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171909; cv=fail; b=JBClwksBf8sBz8uj0EXZAo2ilivkvbYaBJgIMSq9mDg6wUThLJf3Ao41t5jOMEo75Zjf8AXcrF9lLbi7Lnu4UjO8OTajaZrZFI1INI9ssfZp0CsWaM5AO5OcL72MXDH6T0NWzIs+TXhWdyJ8OVmbBryxBBH6gvW0tRe85Z1zZG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171909; c=relaxed/simple;
	bh=voHzzu+COV7ETfXmgyaxBpTopUwltDI2VoWeFVUjeBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZ8Xi4vedEhHAimGFlTUCaM/2AdcqOBz02C7Ln+hr2FpRWUKwUTsL1gCBK5klcyzTyZya7PcXwg2ilj4byMLPEZ2ULi7/Fg+D4AqEg/qDn8q57o0Xynfj8tWOPEDwHi0qUgxC9TQr9qGFmW3elBfDlg/C1lih6KFbR5laoFmlUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=gll2lzlx; arc=fail smtp.client-ip=40.107.223.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HipBGKrXFF7Whs+Sa/GLg7EL/z1wg1e8haJN1qxnvlsMV1zMcS9qxHVotZEnw72NYOe/DmhbuB72MramPUWIYAwsXJfgq+O9Q9R5FBskjp/abYE95ZU7zXPoJmQDrI1nt60JecJ8pTElqNxGQUvumh50hpk+j5YoBHNGuLjUYx8xDJ6JTYAEVBymd0RiYqTSKne1Okj9LCxOJa05babNA2Ff6nQDDvRxhnpx0y2eIQfhaQw5K5nXr1Px3RtO8lC3iHDG9vJYtktlrYNEU95rekEamBv4Tck/Q5/pN2PTUbEo/tBRxhjcv2K67uEO7amDksnF5gJCFNy/7rJo5DuQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muqdWEEM+CNpcww/bkrgd27O7O4ACpS2BWGFRjOBSJI=;
 b=JFOPXusunkrl9i1YZW5l48lPr8jHELTtMpMLmagmfKZMXD+BnZqB3M788CqFyVQT/14MHt37y8/80OqwrrvZSIBrZeYK2DCooAxC2Smk0YrgsJIq99K3LGSCB07aFA78bVoKo7yqvihbj0dKYTVYKEgXGbpUINL9VtJCRYsPFEmQaB/l4F8DEhw2KWD4/U7fRgU4F/ArY2Pvw1G0P22rNh/T9nmqcSn+dc6Fjz8DhR5SaEWg/gTZpdk0YuX8da7+G57S5/a1RB6KOSs6VeM0BuUJJ26gW7LhtEvhLxA2EyNiQ2Zkx4U4mI7DaQw5s9Ciy8PcE2CKbvMuUD46CONvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muqdWEEM+CNpcww/bkrgd27O7O4ACpS2BWGFRjOBSJI=;
 b=gll2lzlx7DFyN9wTvYpFo9YbQV3DsRsBJinK3aDwfPzZvFfwP2rFBeYRsx5CJXYQ6d0TzOgm7v3++gtZXqn2kb6vEy/fTDNU1jbhiQN7ekH3MgGkS8W8Nl1PHSsbx0Mc6pflEWgq7pZUzzVRSxE8YCVibbUs7hHbd1d25i9kpIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by CYYPR08MB8796.namprd08.prod.outlook.com (2603:10b6:930:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Wed, 29 Jan
 2025 17:31:41 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 17:31:40 +0000
Date: Wed, 29 Jan 2025 17:31:35 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Abdul Rahim <abdul.rahim@myyahoo.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: fix MIDI Streaming descriptor
 lengths
Message-ID: <Z5pl96d1OCF0RaCe-jkeeping@inmusicbrands.com>
References: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
 <871pwl7evv.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pwl7evv.wl-tiwai@suse.de>
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|CYYPR08MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5d1c0e-3fec-4aa5-042a-08dd408acaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99S62PdszawuiZwjdW4GfQoFiBP+m+fwfbKsPo1vRtMkfrfWV98g9OFR40Cu?=
 =?us-ascii?Q?m/ED12QEhTSk2b96P6EUn7ePhZNl91qC05iTedhJryPHzQYENSGKZb1bM47b?=
 =?us-ascii?Q?PyWxfAZrQOgzFe7N/hTIebYRziTvHCaN3/sKJkEJbwogDYDM2Ia9rwdnUDBz?=
 =?us-ascii?Q?ZrtRny5hGhIv2Z5HC73aeRrgJm1EHH0p/B1yWxmiTgCYLfPJrCf+n1iW0GOT?=
 =?us-ascii?Q?IJLyTnFh4afSAHbrTLvAVCwfZT+kqGovwCPOiNAYJpHWYV3oakvqdHMp4vy7?=
 =?us-ascii?Q?JosuWhmu7GjFygYfzt9wCnPafiZNlNzyFuXqXJCJfKp++F+2bjm7YoVI3vN6?=
 =?us-ascii?Q?DqfisdJnec4asQyx8M0nDbPeLvioMAqAuX0CpNWXA/sVr+mXXFlfQMdfK1qp?=
 =?us-ascii?Q?GULcZgARYpBFJ4LqofT+73LxBOpFsnb9Th7V1p0plFPEVuXUnnXcTTDqsNw2?=
 =?us-ascii?Q?n0OCwvnG4AL8RZ5M4MruuKx28ZrqTuBY8T1JqJGafQAQqsLb4lj1UjIMmnl6?=
 =?us-ascii?Q?xMhXycHv/pE54G6tRAC/l2bBeiIq/2qWKCU3g6/tOZdmm0k7HoCx9M+t5kES?=
 =?us-ascii?Q?xmYMez81/6/q9sOMKyBVz+UY8sJK6yYo0j6S3aM8XqQpW7NYcAVVOF9/StVa?=
 =?us-ascii?Q?Oj+sxyiLzHZzwfToE2k7GEKxI0nUgoJl755x5hk8NRJ8xVTFLFmTkGs0I7DQ?=
 =?us-ascii?Q?lO6JAiy7cpdYYFgjJurbPnNl+cxlbcaBUM5wCWEpU/JOmz3Z+bBvm5UKsJ1W?=
 =?us-ascii?Q?241L5+z9xjlt/G8uK8mNsPHcCjDaDrcAhMcKR+VtZDPYOiquFG7wc0IgPTGn?=
 =?us-ascii?Q?iYYle7Ry5JY20jFPtKR6CHRKU/mBv2aQDBkEMqM4/uCX9IwOkR/+QwJFbzrG?=
 =?us-ascii?Q?q3FW7FOEmz/s5NlYBV9H6hasK3YxFblOex+vfQXSVxG3G0dyHFkmbGud5I4T?=
 =?us-ascii?Q?fyD/P1fMfZzW4ZGmA8IB51X9YQv8RZqGWJORJg7XA8GzjUUh/G9b/fLdhBN4?=
 =?us-ascii?Q?rBRrMtjKEdXgGDQ7atVWVNjW7uUdlDA4FvpWVbE5bLc8a2MhVlhlA6y4nThl?=
 =?us-ascii?Q?u94Y8rMODr/Jl8yAmlTloK9TF1lihwtcfkMl3bA7HnekbAGpL/HqEyOXPC+/?=
 =?us-ascii?Q?9UXINErdsYZPZ7ODkzhm1Va9G2QlkYq2lKEdrTaKZo40+QtyOmSbO2npgk1l?=
 =?us-ascii?Q?VseVJP8Gd5RgZbsmpCJW5jrg2ov9YNwI+/Bz42lFbIxt2KCfFGRufpfNrxM6?=
 =?us-ascii?Q?+NvEut61pMQTItuWOsAXTtfU0Jq3cLYDiihyseo++aE0cfaNCC1mj11NWVkk?=
 =?us-ascii?Q?kMz4fi7Sf75EOH22F+h9xIEbh6QheqLtUcv5S182b3S9DWpvPM3CBCcgtAX+?=
 =?us-ascii?Q?KernLPZp+AzDwcx84dYa9j81pA5QFBgVluE09e6Z+bRdPHdno2AHUCv7J2Iw?=
 =?us-ascii?Q?Zwb86rbSxDPItgfG95mnSrrKSvJHWz1q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iat/AldReyeP35eP+if/ajupfxCL6n6g9/DS9Ch/IfXz4848HofG4dqOOqpx?=
 =?us-ascii?Q?m7oynJdL7/MK7SyJrAcU/V8r2Yj2/aJotW04JKpW8Fhns9csFt+nFrhxwT9G?=
 =?us-ascii?Q?m6rBSLS7ykvaqu/27Dk2M4/eMzxh8/XuVUyCC9D+RguCGhNIz1DgeVaFIGFy?=
 =?us-ascii?Q?7Za4IslyUP07SFhD8ymm9wr43f/OpTwdlQ2vSpF1Sy59+AtIaPaV2pCDuvnx?=
 =?us-ascii?Q?fysa1dD3Cq40llnUhX9HiHScj3uKnBtHi5C6zW//jcvyxrDJAKVLJS5Kc8tR?=
 =?us-ascii?Q?H6EmsR4aqYZUZOQGGjeAee40ElXV4t125PrTn9lPSi4WdHSbf+bbTYWpHJME?=
 =?us-ascii?Q?LFqcxXUXfnXlnjPPabfx38dRY+hKJArDzS0FGMZ6+UVNWg3UYfH5JOZnrhsT?=
 =?us-ascii?Q?NxkutlCg7Q3Tw53vvQ/MdVxvlV8PY7PjCWhDN+XLap9A0X3aWPxpaSnGQRGO?=
 =?us-ascii?Q?MGpnmRW+3Uhp4D4QZKSe45i7Sg6uwnmFqiKNyJt5D0HisN2cIrLQgKl+S52z?=
 =?us-ascii?Q?UN4gLUP6bJ6cvV6VtY3R7GzBuGtKVLl4CC+0NlhzEUZT6cnaidCGWPM6iQiP?=
 =?us-ascii?Q?gmKaf4OhhfYE5UJ4Bh7xWJ5HGNLuO9oRHtEP68VXdME8HJ8fplIgXPNrXwIf?=
 =?us-ascii?Q?3cS3NgT4l82qPbFS72/V5F7e7tQe5yK1AiRpgat1mM5GNmR/SY6BO/BE5H/S?=
 =?us-ascii?Q?1z3hzVS48fCd6QICUqY4Rcur+YZPVGx+7tZ7eC1kCludoygUDfXYXJjSOhzV?=
 =?us-ascii?Q?W95tzVc4J9eoi+icLYYvrjzdkDIHaNrbzpx4Kscw3nh6NNwTwwO+oSsffHCC?=
 =?us-ascii?Q?kH4W5R1V1Mh1vswTu1Vxx6STfoJv/QQNDqY04D80+otLnaDKOwcHNY3O4DNt?=
 =?us-ascii?Q?xgZGxWP6eplJFdBbz+4o2ol8hSOe0h33xXCy8aRpipI8OlpLVNqAGF4GF8mj?=
 =?us-ascii?Q?M89eWyBslwKqchTQjB4JUgTkKuFQHuukpeSK6jCLZRg/2BllKXxDxxgL5kOh?=
 =?us-ascii?Q?3+NVXNhGU53WyHVTg/wDiSjF7i9I4R786QFmFw8ppW7sGwHn9oAjR/Swj4GM?=
 =?us-ascii?Q?ZAASj23NMDyC1RddWQSLqDzNn5Byr602CMvuHIobiiPJA4g7d3u3xocWgSug?=
 =?us-ascii?Q?APnQ9Yx82+p2VVCl7eX+QStHJYs3IKXQ/3Ai0jJBiOgcKhxTWiNRsHfOX30Q?=
 =?us-ascii?Q?i43/H85MfdpEB4kEW4RKMC1wXxplUsIuPVg7lkWYPbNRl5bIB1oAQybdziXf?=
 =?us-ascii?Q?CbAYPqjG+UunQg2VucvApCuFIN9unHmQkzM+bq7SkoXpqAHTfkl6MB9kdqKs?=
 =?us-ascii?Q?2Tlm2E9Wr5ng7QjSIMHTpqeKWPBR7q7Y4rWiE/qglQHtAlja7cXqcbBPDwJr?=
 =?us-ascii?Q?16OpZGa1DE8JuCWP2n84nAlr0M6BXNKXutLInuQz33QvjGg2lpeW3HEiv/sZ?=
 =?us-ascii?Q?6cW983ejO6hsTlbSGvhFEvMGSfKAb5JZrUOcggZXage02d2bZqgScCZEEBHk?=
 =?us-ascii?Q?LlhwhmH0TgpbpVhqEjbItyMCL8cQ/XE8CNRA9nwx8TzwsT67eijMwePiG2Hh?=
 =?us-ascii?Q?wVievbtKC/Tn5A0SpuemmWqrL5LQOUVLLd0zAZ9vPkBiWcEiiO+2ESDQ3l7R?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5d1c0e-3fec-4aa5-042a-08dd408acaa7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:31:40.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuWxJ7k/uSzC64xVTveaR9PhaEm8dU/a4JYk+sEwo8ygJJldyqGMjqUXgmnyBiPYxCCFPmknyoyyJ+IgKg8T5qpR/TLYR5rZ3/iagkgWB24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR08MB8796

On Wed, Jan 29, 2025 at 05:40:04PM +0100, Takashi Iwai wrote:
> On Wed, 29 Jan 2025 17:05:19 +0100,
> John Keeping wrote:
> > 
> > In the two loops before setting the MIDIStreaming descriptors,
> > ms_in_desc.baAssocJackID[] has entries written for "in_ports" values and
> > ms_out_desc.baAssocJackID[] has entries written for "out_ports" values.
> > But the counts and lengths are set the other way round in the
> > descriptors.
> > 
> > Fix the descriptors so that the bNumEmbMIDIJack values and the
> > descriptor lengths match the number of entries populated in the trailing
> > arrays.
> 
> Are you sure that it's a correct change?
> 
> IIUC, the in_ports and out_ports parameters are for external IN and
> OUT jacks, where an external OUT jack is connected to an embedded IN
> jack, and an external IN jack is connected to an embedded OUT jack.

I think it depends how the in_ports and out_ports values in configfs are
interpreted.  However, the case where in_ports != out_ports has been
broken since these files were added!

Without this change, setting in_ports=4 out_ports=2 we end up with:

      Endpoint Descriptor:
        [...]
        bEndpointAddress     0x01  EP 1 OUT
        [...]
        MIDIStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (Invalid)
          bNumEmbMIDIJack         4
          baAssocJackID( 0)       9
          baAssocJackID( 1)      11
          baAssocJackID( 2)       9
          baAssocJackID( 3)       0
      Endpoint Descriptor:
        [...]
        bEndpointAddress     0x81  EP 1 IN
        [...]
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (Invalid)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       2
          baAssocJackID( 1)       4

Note that baAssocJackID values 2 and 3 on the OUT endpoint are wrong.

From the same config, the jack definitions are:

	1:  IN  External
	2:  OUT Embedded, source 1
	3:  IN  External
	4:  OUT Embedded, source 3
	5:  IN  External
	6:  OUT Embedded, source 5
	7:  IN  External
	8:  OUT Embedded, source 7

	9:  IN  Embedded
	10: OUT External, source 9
	11: IN  Embedded
	12: OUT External, source 11

So it seems that the first 2 entries in each endpoint list are correct.
For the OUT endpoint, jacks 9 and 11 are embedded IN jacks and for the
IN endpoint, jacks 2 and 4 are embedded OUT jacks.

The problem is that the OUT endpoint lists two extra invalid jack IDs
and the IN endpoint should list jacks 6 and 8 but does not.

After applying this patch, the endpoint descriptors for the same config
are:

      Endpoint Descriptor:
        [...]
        bEndpointAddress     0x01  EP 1 OUT
        [...]
        MIDIStreaming Endpoint Descriptor:
          bLength                 6
          bDescriptorType        37
          bDescriptorSubtype      1 (Invalid)
          bNumEmbMIDIJack         2
          baAssocJackID( 0)       9
          baAssocJackID( 1)      11
      Endpoint Descriptor:
        [...]
        bEndpointAddress     0x81  EP 1 IN
        [...]
        MIDIStreaming Endpoint Descriptor:
          bLength                 8
          bDescriptorType        37
          bDescriptorSubtype      1 (Invalid)
          bNumEmbMIDIJack         4
          baAssocJackID( 0)       2
          baAssocJackID( 1)       4
          baAssocJackID( 2)       6
          baAssocJackID( 3)       8

Which lists all the jack IDs where they should be.


Regards,
John

> > Cc: stable@vger.kernel.org
> > Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
> > Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> > ---
> >  drivers/usb/gadget/function/f_midi.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> > index 837fcdfa3840f..6cc3d86cb4774 100644
> > --- a/drivers/usb/gadget/function/f_midi.c
> > +++ b/drivers/usb/gadget/function/f_midi.c
> > @@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
> >  	}
> >  
> >  	/* configure the endpoint descriptors ... */
> > -	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > -	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
> > +	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > +	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
> >  
> > -	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > -	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
> > +	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > +	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
> >  
> >  	/* ... and add them to the list */
> >  	endpoint_descriptor_index = i;
> > -- 
> > 2.48.1
> > 
> > 

