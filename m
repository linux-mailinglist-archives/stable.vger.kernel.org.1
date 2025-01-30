Return-Path: <stable+bounces-111721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B8A23287
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC4B188400C
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7761EF0B9;
	Thu, 30 Jan 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="nxB4Fvfz"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2115.outbound.protection.outlook.com [40.107.243.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8ED1EF080;
	Thu, 30 Jan 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257014; cv=fail; b=M79zXPO4vaDqEMc5llTZopL/hDmYmcO/IUONTktwL2KT+g5YaDO7tAK5d3kwKivl36a8KnXLagRbZ98HlaGBFFKMI1UonN47rj4XqauC8nSWVQ6Zp3/1fughxK6FI1nGB1JkBwNRMhrOS4yBnSlblBI7/kUofM01ij5+Dr70Nm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257014; c=relaxed/simple;
	bh=6q3adRsaL0jOV51lUlZv/PVWWBmtbs7VatmHLLfk0aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eX6hfq214c4Beqqpnt2fhskCgfaceAdZV5m8AmhKOxL8QXzfaTTP+m9GOKd2Y/yVUde2nsU5FDz+pR6cH0PvDnA/8GY0JXgKEJf//eSjcLD4NDb8Q6RsX4YtDHe07aCKvDS91PF1/meWRe8hUfokLCKNxmGz1F2DMqgVn5wuuj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=nxB4Fvfz; arc=fail smtp.client-ip=40.107.243.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1nZdDko5Js6JfsEdRZFt20FoFrqyVfRFfIxTageiJywZ6QZwTezBHOucrV2a1GTolrHFtwD4LDbvGuhL2ZtqPcTOOmA+PKdwv6ZCeijz8Tg1y5snLeOxdvyE3OVeQ9xxBb1cOBbuqbUlshHDGjftB6YYrko8Tqe2WEFuFQ4E5hikJnG8LAF/1J7xoa0u8xngijqpado9AC8btFOCrwHdYwFE2/kXIts/rm1VHxnq8vssW5tI9InD2V78Xq6Hwrol6FpPphdDHj/OFPbEIXFwpk+UxLHcqpSEcyGSiEqA5ie0JvjH9NFadWG3h4wUfaoul1fSO6X0qSa4anY9WBbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwMl3IFjxb2aGei107O+6LNOe8iF/RQyUYsnVaMSUM8=;
 b=hQqiSfVK7ZRoZnuZmgp/bRYCvJSS8wd3N+o2juSRbt3JgmFSmbE5xnPBebesq+a0kXVKhN7MnXROLFduhSRVDSWg5sby034z8B6Ds22ZvDVLjjBBlUTB6F+C0B37LiXxcFAqWl7x0Cqx9PFnT8FYt67Ow5sIe9NG+X/bYSlGCTchwZT2xPiY2TI3Yc8VrpIyCI77tgElxaEcZZScP3HXrQm8/xYO2sJOuFQZV7OT/ZzK8eC7w8nftfgCXIaBsWnK3+m+ATBMF8aFfpCjAlBSuGFLc1+ftuTKndRTzkGx0M2Mhysb+hLN/41mbQhm0g7nLF+YXO9J0yLrrg0u39EkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwMl3IFjxb2aGei107O+6LNOe8iF/RQyUYsnVaMSUM8=;
 b=nxB4FvfzBKSQIJPtfgrr542ePe2YvcM3308+pVCu9pTpnu7VweMHQ6vQqW9Hd8jAvmbUz9V3pom31k7yGjJlAz0FTKpFFLkJFFqsyWJMigBC97FJw25SI+5gUxKtvXoLPwUj2Y1RUE+s1EkIoDwYE0/GQKofeDx1rJ4J2RTOAn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by BL3PR08MB7396.namprd08.prod.outlook.com (2603:10b6:208:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 17:10:08 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 17:10:08 +0000
Date: Thu, 30 Jan 2025 17:10:01 +0000
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
Message-ID: <Z5uyacORwkWDbqYm-jkeeping@inmusicbrands.com>
References: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
 <871pwl7evv.wl-tiwai@suse.de>
 <Z5pl96d1OCF0RaCe-jkeeping@inmusicbrands.com>
 <87sep060f4.wl-tiwai@suse.de>
 <Z5tbealYSvl7S72l-jkeeping@inmusicbrands.com>
 <87o6zo5wco.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6zo5wco.wl-tiwai@suse.de>
X-ClientProxiedBy: LO2P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::17) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|BL3PR08MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da3ead8-48bb-460a-546b-08dd4150f2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FbrFgzfyc390dsVwY+5j9Q/ZBke9hWpvIz8GcV6KR2a+JRvTLfl1jFBLhSsY?=
 =?us-ascii?Q?X9pWthfVc5EMdlPFhb2fvf8JE1Tx2E5asqAf3pTx0oRXx76wbLQYmGcy8jkj?=
 =?us-ascii?Q?+TzyqzRbGFySuARG24XMp8yPiu6AKQC5twULgtyTQEGeHC/gY3y3TItHPQ4e?=
 =?us-ascii?Q?K71DbD68mRglFgYmxViEi+ZDShAkJcT+HpCfmnu4qZ0Bvor1PAkvO0A9lBQM?=
 =?us-ascii?Q?FHwQhY9EuDBQxsrNIFAPsudaXcYfEpVtyEC3H/K87n/zaunPh5AblEGAozH8?=
 =?us-ascii?Q?Vzy0MHdEYhGi2fhCN5hJ7qDptrboZYOAYpRNoqeH3RYyqmK8exOT/SeyxvWS?=
 =?us-ascii?Q?KWkSGifHSkKGbvD1wn5DHbPAjs7HkQXWdHXjUWFTjcZ7pLK+uc+CJm6WXG2M?=
 =?us-ascii?Q?1ScUgJ0IehR8RkZ/b/lGzXD0HzoeeiOZZAn2HJPpb9Qh17uwVOly6sGboe18?=
 =?us-ascii?Q?iji8+Cmtokg4GUIvVL/V5Zp59OJoF+Rf91gHIEyP8Wbm708fipwcCkPsN8UE?=
 =?us-ascii?Q?VTdcMLMFzPwhjDO1zK4DkIIoH29JJRypEKiHFV0ewuesPUOWHBwylCgpzxd5?=
 =?us-ascii?Q?aYKiBztiDsLawDh8ehkrxpMBDU62qwHAK1GBtakdxxmXDDXdI+UzArKx4xY7?=
 =?us-ascii?Q?bfgTe6WG7k5LVDTwWect/Qa2XpgpiXVvrtolScfInnPm9WCan+5OAY1tx3Bs?=
 =?us-ascii?Q?90wva77QzEMb9+4/JTJBsMykLA9Vov4Ms049G7NyORGfAUuwdrBBQPkF1lRE?=
 =?us-ascii?Q?FBVbX2kKqspSnj2KCgHT8u+y4x5G1EDjg2z1IKr9yyy1fOK1xkLN0TahvZt3?=
 =?us-ascii?Q?2k7XWpl4vXxPCqjldHxx6VDeisAa6Y8ipQe15Y+mdYKdHatwd0PjzotLi3xb?=
 =?us-ascii?Q?iR76b0+Tqzvih18+ATCPduzFWrUJF3snX3hg17v6x7XgM9gaitWUJ/wMK9JJ?=
 =?us-ascii?Q?Yca0TcGWpaSxMsPZ6idmQDVYL0jU0aRC0Et6bl+4u3aDdkeHCFRCQYzOl7hx?=
 =?us-ascii?Q?0IyaZ0a6Jj1MmYE3Iqocv6umBWQ8JGDuB0VGfrlOG34YarBYZlYidigrUg1J?=
 =?us-ascii?Q?o89bXz+OYQBWq9O7ok/KjbVgK5hqQJKKJz+dgTMi5Oql1C/4XAwAjHlJj2ME?=
 =?us-ascii?Q?8aP9Zj5YMTqOY6lepHsaEb+Ea9tDvXndqVSL+bJ1tVmUinGLyxzPPIlP7Ixy?=
 =?us-ascii?Q?crOhVTG5S8FXVjsuUpktAKKizO/x5w+opc6Yii/g4/QjsXgPh3qDgb4y1t68?=
 =?us-ascii?Q?yUollgByzE8rJc85AMiO+NZTt9aF4vt1fkWfkUxoVR4pL98BVfjRN+YyeD+n?=
 =?us-ascii?Q?PGFLlKDPenEhYw2UqDewWf73XzJtdiJpQe70Bfry/RggFUna+Ak5S+CWj8Fb?=
 =?us-ascii?Q?Dp/h8dhGZ+kYj0iFR+SLYSNIntSsZ2Jbe7e/ROZ4emzOgQAe3Mb7i1A8jaIy?=
 =?us-ascii?Q?U2eNL3I6Q8a6/j20ummCI5fUUK7y8MdT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16kw9g9Ah1K03iv+xUiRpP6gCf0Qff80l/c6jcCBAsTesUG2cHdHcXk3S0BT?=
 =?us-ascii?Q?ioLZAW+Lo1DuPYnNOENl20NydFxWYpqeBHcZFlvToL63dq0HMOhtBkCJFXIx?=
 =?us-ascii?Q?JnJ4FQMttf8JcBkJeJS7dI7bgfcOeA4O5lielRADcVu3eZjMjW6e2Ue406OD?=
 =?us-ascii?Q?TMGkRc1jeb6C+2NIxGOUeu9QaujQkPtjhImvdp29LyKP1nkergYlteAuOnX5?=
 =?us-ascii?Q?1d1G7Heo0anmxVd6Y7nv0zG800rTwdaIaivIhBnHbmvAnhUnTmFt5xxkWC46?=
 =?us-ascii?Q?iHJe0YOPc9D966tizJva0ORCYX8F+hpR4jFwMHjt36MyPacK9yP7MUJLS2pF?=
 =?us-ascii?Q?2+OzBrkLZWZ7IV7Yqdo7uuNiXLB1BiNp3ugTWvv9aQQWvggeJn43JYXPwNyv?=
 =?us-ascii?Q?afFHbkPU5MWY2vqI4FNxVXS20DmeOKEpT/ftasB8iWh/9deDb0/0Dk9hEgUJ?=
 =?us-ascii?Q?440YPO8DY763mws5/u9gICNmlsBvhS/KDSyEpaient7Si9Y4VEkkwge2cnC5?=
 =?us-ascii?Q?WZlcG4fU3jzcibo6S6saODi+VkEFyVBxtEJnprmSu9Pau2pu8P7Bq4PB7fpu?=
 =?us-ascii?Q?DZC1G69jd1f5mrbUEvSeiK8ZXYwxiPYRCW92TqipTbkGJWaIoHTzO87plz83?=
 =?us-ascii?Q?8ya6hedKE8YMFx5N11Exgy+yFCKgIozHo0caecwJJxbKDaPqPRAWJ5EqNq8w?=
 =?us-ascii?Q?vNNM5xts79rDkl0wNRmX8WscZoTJfeP4K4W6tDtgJdyiU4ZxzEhzKXcRMzgL?=
 =?us-ascii?Q?wdgzqOfjoYU9e/3gecY4LFSgQ6O/0cNOctT1w/QaXAvmFhnE1nt2WriDZ+H1?=
 =?us-ascii?Q?NvykcQYS0eniSAOX93cm63gh9vZV8RXzr1IfVyUwxIqzOZ1uWMrbtPHd2mal?=
 =?us-ascii?Q?ICy9Tb3PTeR8BP3P54fi+b/HDSW6lq6fUxHhiac3aoQkKgIB1w2DWzoAgKR1?=
 =?us-ascii?Q?eFlhODjCjnuZZqO9kqW6e/25h/aSfDL6fUwp7g0tcAY8BtyW+xjCeF17x1hQ?=
 =?us-ascii?Q?vlKu5SYyn70EnfeKZJvBe/OkLnQoRap7LnFtUaxcJVLikTxupzT5QjYgGZlI?=
 =?us-ascii?Q?jrO09xLTatKYEdf90ET5XFkI4aZ6+ibUDCdWsSl5GbVIjSx/wPEiGqVKz+tT?=
 =?us-ascii?Q?JZjcgBA/BpTNSJHu8L8/6W5CUA8osM6EdWVFZSH1SnBQRSMwTjldetq9LsNQ?=
 =?us-ascii?Q?c4vymcITABav118XIoWZ6dI8BOIZzLXSHDt+XVcN6LJLvGtQacezT6wHry5q?=
 =?us-ascii?Q?L5yX6kFfZURX/sb2DTU+6K50kjzztZncnZN3nA7gzpFqIPgam1Ai9YtTRHAU?=
 =?us-ascii?Q?kHpsWLu9stJRWfO1qqw6/lV91P6EioTs/Z+W70b2hXloWrZ2iLC98vDyx5vQ?=
 =?us-ascii?Q?No+kY3DttZydy7z089eMyqOHHgjbIb6ad7dVt5IilZJd2NRovdQy5VLB2vf8?=
 =?us-ascii?Q?jJJKcwZrmjsighZaofY+xXOKjJ6H/4Ak9bFqrrPeAAz4X9OrLhhi2uDzaKeO?=
 =?us-ascii?Q?wzuj+3gRxoBAcYoU4A+2RPeD5OaM/pPca8UzK/ykWnn3o550zxt0daVOII7R?=
 =?us-ascii?Q?Z+r766UCA1FYOtYGO8w80jUZaS1+36fbpBLpuLYe8VHp1YwrM9nOe8UBwuj1?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da3ead8-48bb-460a-546b-08dd4150f2a6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 17:10:08.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrPDYhXDedfi8fJsZDGw9e/y4t1t3gEi64o7nRe9ZKVqpdJJOf3M+8r5h/t8DwEbvwdwXKlQEJU9tZSpKzXLMvk+9njACFMdgLjs3/RiItE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7396

On Thu, Jan 30, 2025 at 01:17:59PM +0100, Takashi Iwai wrote:
> On Thu, 30 Jan 2025 11:59:05 +0100,
> John Keeping wrote:
> > 
> > On Thu, Jan 30, 2025 at 11:50:07AM +0100, Takashi Iwai wrote:
> > > On Wed, 29 Jan 2025 18:31:35 +0100,
> > > John Keeping wrote:
> > > > 
> > > > On Wed, Jan 29, 2025 at 05:40:04PM +0100, Takashi Iwai wrote:
> > > > > On Wed, 29 Jan 2025 17:05:19 +0100,
> > > > > John Keeping wrote:
> > > > > > 
> > > > > > In the two loops before setting the MIDIStreaming descriptors,
> > > > > > ms_in_desc.baAssocJackID[] has entries written for "in_ports" values and
> > > > > > ms_out_desc.baAssocJackID[] has entries written for "out_ports" values.
> > > > > > But the counts and lengths are set the other way round in the
> > > > > > descriptors.
> > > > > > 
> > > > > > Fix the descriptors so that the bNumEmbMIDIJack values and the
> > > > > > descriptor lengths match the number of entries populated in the trailing
> > > > > > arrays.
> > > > > 
> > > > > Are you sure that it's a correct change?
> > > > > 
> > > > > IIUC, the in_ports and out_ports parameters are for external IN and
> > > > > OUT jacks, where an external OUT jack is connected to an embedded IN
> > > > > jack, and an external IN jack is connected to an embedded OUT jack.
> > > > 
> > > > I think it depends how the in_ports and out_ports values in configfs are
> > > > interpreted.  However, the case where in_ports != out_ports has been
> > > > broken since these files were added!
> > > > 
> > > > Without this change, setting in_ports=4 out_ports=2 we end up with:
> > > > 
> > > >       Endpoint Descriptor:
> > > >         [...]
> > > >         bEndpointAddress     0x01  EP 1 OUT
> > > >         [...]
> > > >         MIDIStreaming Endpoint Descriptor:
> > > >           bLength                 8
> > > >           bDescriptorType        37
> > > >           bDescriptorSubtype      1 (Invalid)
> > > >           bNumEmbMIDIJack         4
> > > >           baAssocJackID( 0)       9
> > > >           baAssocJackID( 1)      11
> > > >           baAssocJackID( 2)       9
> > > >           baAssocJackID( 3)       0
> > > >       Endpoint Descriptor:
> > > >         [...]
> > > >         bEndpointAddress     0x81  EP 1 IN
> > > >         [...]
> > > >         MIDIStreaming Endpoint Descriptor:
> > > >           bLength                 6
> > > >           bDescriptorType        37
> > > >           bDescriptorSubtype      1 (Invalid)
> > > >           bNumEmbMIDIJack         2
> > > >           baAssocJackID( 0)       2
> > > >           baAssocJackID( 1)       4
> > > > 
> > > > Note that baAssocJackID values 2 and 3 on the OUT endpoint are wrong.
> > > > 
> > > > From the same config, the jack definitions are:
> > > > 
> > > > 	1:  IN  External
> > > > 	2:  OUT Embedded, source 1
> > > > 	3:  IN  External
> > > > 	4:  OUT Embedded, source 3
> > > > 	5:  IN  External
> > > > 	6:  OUT Embedded, source 5
> > > > 	7:  IN  External
> > > > 	8:  OUT Embedded, source 7
> > > > 
> > > > 	9:  IN  Embedded
> > > > 	10: OUT External, source 9
> > > > 	11: IN  Embedded
> > > > 	12: OUT External, source 11
> > > > 
> > > > So it seems that the first 2 entries in each endpoint list are correct.
> > > > For the OUT endpoint, jacks 9 and 11 are embedded IN jacks and for the
> > > > IN endpoint, jacks 2 and 4 are embedded OUT jacks.
> > > > 
> > > > The problem is that the OUT endpoint lists two extra invalid jack IDs
> > > > and the IN endpoint should list jacks 6 and 8 but does not.
> > > > 
> > > > After applying this patch, the endpoint descriptors for the same config
> > > > are:
> > > > 
> > > >       Endpoint Descriptor:
> > > >         [...]
> > > >         bEndpointAddress     0x01  EP 1 OUT
> > > >         [...]
> > > >         MIDIStreaming Endpoint Descriptor:
> > > >           bLength                 6
> > > >           bDescriptorType        37
> > > >           bDescriptorSubtype      1 (Invalid)
> > > >           bNumEmbMIDIJack         2
> > > >           baAssocJackID( 0)       9
> > > >           baAssocJackID( 1)      11
> > > >       Endpoint Descriptor:
> > > >         [...]
> > > >         bEndpointAddress     0x81  EP 1 IN
> > > >         [...]
> > > >         MIDIStreaming Endpoint Descriptor:
> > > >           bLength                 8
> > > >           bDescriptorType        37
> > > >           bDescriptorSubtype      1 (Invalid)
> > > >           bNumEmbMIDIJack         4
> > > >           baAssocJackID( 0)       2
> > > >           baAssocJackID( 1)       4
> > > >           baAssocJackID( 2)       6
> > > >           baAssocJackID( 3)       8
> > > > 
> > > > Which lists all the jack IDs where they should be.
> > > 
> > > Hmm, I don't get your point.  The embedded IN is paired with the
> > > external OUT.  That's the intended behavior, no?
> > 
> > Yes, all the endpoint assignments are correct - when they appear in the
> > lists!
> > 
> > The issue is setting bNumEmbMIDIJack and bLength in the MIDIStreaming
> > Endpoint Descriptors.  Without this patch these are set the wrong way
> > round so either some ports do not appear or there are bogus entries
> > containing uninitialized stack memory.
> 
> OK, now point taken.  The main problem here is the definition of
> in_port and out_ports aren't really clear.  If in_ports really
> corresponds to external IN jacks, then we may correct rather like:
> 
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -968,7 +968,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  		midi_function[i++] = (struct usb_descriptor_header *) out_emb;
>  
>  		/* link it to the endpoint */
> -		ms_in_desc.baAssocJackID[n] = out_emb->bJackID;
> +		ms_out_desc.baAssocJackID[n] = out_emb->bJackID;
>  	}
>  
>  	/* configure the external OUT jacks, each linked to an embedded IN jack */
> @@ -996,7 +996,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
>  		midi_function[i++] = (struct usb_descriptor_header *) out_ext;
>  
>  		/* link it to the endpoint */
> -		ms_out_desc.baAssocJackID[n] = in_emb->bJackID;
> +		ms_in_desc.baAssocJackID[n] = in_emb->bJackID;
>  	}
>  
>  	/* configure the endpoint descriptors ... */
> 
> OTOH, the current code will make the actual appearance other way
> round, likely more confusing.  So I believe your fix makes sense.

It always takes me a few minutes to get used to working in device-side
USB because IN and OUT refer to the host's view.

But I think "in_ports" and "out_ports" here are consistent with that.
"in_ports" are the ports that send MIDI into the USB host, and
"out_ports" are the ports receiving MIDI from the USB host over an OUT
endpoint.

> But it'd be helpful to extend the description a bit more to clarify
> this confusion.  I guess this confusion came from the association
> between the embedded and external jacks, and the patch corrects it.

I'll rewrite the commit message to include some more of this context and
send a v2 later today or tomorrow.


Regards,
John

> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
> > > > > > Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> > > > > > ---
> > > > > >  drivers/usb/gadget/function/f_midi.c | 8 ++++----
> > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> > > > > > index 837fcdfa3840f..6cc3d86cb4774 100644
> > > > > > --- a/drivers/usb/gadget/function/f_midi.c
> > > > > > +++ b/drivers/usb/gadget/function/f_midi.c
> > > > > > @@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
> > > > > >  	}
> > > > > >  
> > > > > >  	/* configure the endpoint descriptors ... */
> > > > > > -	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > > > > -	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
> > > > > > +	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > > > > +	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
> > > > > >  
> > > > > > -	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > > > > -	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
> > > > > > +	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > > > > +	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
> > > > > >  
> > > > > >  	/* ... and add them to the list */
> > > > > >  	endpoint_descriptor_index = i;
> > > > > > -- 
> > > > > > 2.48.1
> > > > > > 
> > > > > > 

