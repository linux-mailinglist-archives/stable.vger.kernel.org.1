Return-Path: <stable+bounces-111274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CFEA22C0E
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971741889A26
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716041BEF85;
	Thu, 30 Jan 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="VTYNjSJR"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2114.outbound.protection.outlook.com [40.107.100.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0F19F120;
	Thu, 30 Jan 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234760; cv=fail; b=j3qYbiI60fyljLPUfIF9Xi4K/hRyqrgrg6ohJo8sok5dWdY+B/O6XAkl1BIfBtflFHlWM/V0T+/A3f7PXvcNNpbjYLBS/fibeQwpZSqXu17HFN1jSIHBoJ93iL7qd4Jb04uIX1C2Mz2jAGmfOnW14cA0kskU9wJFn+93Km8me34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234760; c=relaxed/simple;
	bh=21WaghgNtVo/jLDsed0Yy45y5psKX5J+79zbU5E9xXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tWua1S6SXvyBjxAWFEr0puZfJaKOyWKvw/JmUhvvZT5JPcKZcB1Ntcz2PFljsitDpdVHt5G0GgA5tdirWdSzKNyY8eR2EnHcJfidgGdmw5aCe65UOujWFCRPVc2nSnHgyPnzKIvecwhxOD+THBPJa02tdbvH52LDDMjsIZO2jUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=VTYNjSJR; arc=fail smtp.client-ip=40.107.100.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSqDCQMDL04gnGcoZW7lB/E84aFfMKR0UQt42KRwXPPpBvHjIoaeJFuE/QOUYByvCTIsLp1iNR9GuELMBmyXJ3OiOqzRms+rU5hY29GD6H1wrpDYIcfdYbKCbmPNN7mNpy5eET/vcaG/+XOvH1ZvBuyQZMxbgTvGh2c4yZyN2QNZ1x8EQcF19/0Oi9enBuCIXv3Ja9Sds2V51P96Qn7WwwV/JSbcSqHx6bYTQ3N8pDTtJ2vNH3mBb800caaFFSiIw1ZppWVKuGeGC6rT6RkTjm5C3YP0Hx2W8ve3lYgseFyJgwnDThWzxr0iYIN2VTE6nBWrCCoboT34KryKyGXWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p1zFqlnN9NY1OdEVa04W6l5YXjoFGSAqLLPRUVOjGc=;
 b=QVunXlkjvIuieKM54qd4+wAqcgbWtagBusVEC2cgs5WUS+OggRfcd8BjUVSUYstxnSasQ8blYKBFRvmXfKgGHaRYQ/9iROa7WrnrZeAjrCb4MsTem3R43xFrcLkvghhZHoNZtT8m1ntuD/jvcnImKudl3QlKFeTDWSrctA7fJFMUmTDcETzVWQu18LcW+WFsPxIvJ6qrBnM1T9q5vx27vWYDh51oxkpN2RSbH4xuTRmHLXVKBHz7mImyrTqbNde0xj2Rej61gU0EFWUsDjxxh2DLpgqqG6vanbL8B9iSyFxFy79GKa1bpTgwKWmrjj4Ag1ddoUoXKJnRunWPdpyQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p1zFqlnN9NY1OdEVa04W6l5YXjoFGSAqLLPRUVOjGc=;
 b=VTYNjSJRWuBwBpOKINib/ldGKE7D7tCRCv0fMCIM9LE74KsjbIh+mncAO3dGjtDAVUfW7KsGqobvw8crDG+jFCXYZdQHoPpJLFVCqD3Qknbe3SRQzjiB6s/ERCpnjteDyj8yzOVRcjaGtyhstWG6fOBSk2zvpsbe6ZuX4bVHmA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by SJ0PR08MB8410.namprd08.prod.outlook.com (2603:10b6:a03:4e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 10:59:11 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%3]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 10:59:11 +0000
Date: Thu, 30 Jan 2025 10:59:05 +0000
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
Message-ID: <Z5tbealYSvl7S72l-jkeeping@inmusicbrands.com>
References: <20250129160520.2485991-1-jkeeping@inmusicbrands.com>
 <871pwl7evv.wl-tiwai@suse.de>
 <Z5pl96d1OCF0RaCe-jkeeping@inmusicbrands.com>
 <87sep060f4.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sep060f4.wl-tiwai@suse.de>
X-ClientProxiedBy: PAZP264CA0022.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::9) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|SJ0PR08MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 054e95f8-90c9-4f0e-185f-08dd411d208f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y+/njFYvwha/T8T4foEKVGuydmHwyx0je4TU6LLeCwZqAgt6xNCaiDy8vD5H?=
 =?us-ascii?Q?N1WcsdhxzBTPtzoTqLsX9mSmNSiU9VF93c3opF4vvrWRCA9XkJmaBjup+Nfd?=
 =?us-ascii?Q?mGvkuSQNsxUQoNoSZGEn2yJ3K1Qpc1TNBB+Jw3RuG+eQFdAe5YwHpo8EKAZe?=
 =?us-ascii?Q?nUzz3iuTb8O3N3svRABdcxM6lgr6r4QPaeuQLIPTAHQI5EhH+nAupYudQGCy?=
 =?us-ascii?Q?GosXmxl3bPEP7SlYb2vLvNrAF73/MpVVftaokmSvkAkGJoGDuI8ANYSuV0z0?=
 =?us-ascii?Q?E3SUum4sjMARtY4bA5e/2/h2FysE+WJSzxXdZrBenT1RpO3ov8yobd3KRqtM?=
 =?us-ascii?Q?ibP4HstXDuEugHgWLk0AyOvNwEJT1Vtlfn7JAkfK4w5u1QxTgNfP/oWTlJP/?=
 =?us-ascii?Q?494AJ9970F3E3pzBAL8K09d6AcUZVEbSlLWqMoYAKkUVJaCPEHc70OuRwhOB?=
 =?us-ascii?Q?nAmhO6ZrqIbVqSy3Av8Fe57wNOaxa4F7jPrvB1Qau+8xe+3Obmh9R4IRwpkz?=
 =?us-ascii?Q?bBvkqv8QBfh4wj2EM/muo1zyW7SOoIh6TqsgiDgc5rSui4q2LAz4JsiNkMRh?=
 =?us-ascii?Q?dlgLK3xgC7LTqSOobHwnDnmg/eF41CQCQUcaS1x8Q6FZ3QUAwevLHY74UYcd?=
 =?us-ascii?Q?OupV24dVv/LmTElwAysXPQ+2k/2NTUKiSJ2XlJ0QOTVy6JzVl4c8ZitGSdiS?=
 =?us-ascii?Q?2CSJ3DGHxoH9ChPVlYtXby9F6t0cpawiTtQKcVpWz5XI+wv/yl/l5O6gBMPV?=
 =?us-ascii?Q?nP5/hM9MLsawc5gJqR+9REWRre3+8XxxihGnCJjv23CvbetiUWyoQDB9W56w?=
 =?us-ascii?Q?cgZKRKGcqUWufCHCLVk7XI9UEUDHhsVY1aP6jfbfDCHRSCVZv0Xzan6T/5DL?=
 =?us-ascii?Q?7X2mn7edbP4bdhuW3immfDXpc29CIt1fp/YetVXzgV/+QCo5apYCKs4zawBX?=
 =?us-ascii?Q?bEOzUTTtAEiuz3kSiLaBKHAR+3af9G7j9CyTiWfJW1StFbfWiVkdiXomreQy?=
 =?us-ascii?Q?m1yEw+ME7KmhsVMh8A3xz1kNNuS3FQsiU1uwTVZtlPKFAbLsHu9OsKwKJhUY?=
 =?us-ascii?Q?B/p5S7BQ+Y9wQpJDlcp6NJ3DDQC3E/P0j5YLr3zrwq5c49YVo9jx9daz/mV6?=
 =?us-ascii?Q?Ltpy7/yghWuTRyUxIJhxfJ8Ipa08rhFHI7672oN/er+np6cb4utpdd8okh0D?=
 =?us-ascii?Q?z0L7AxQFyhIwX8F9FcJiAJNk3Zk/QZJ+2wsCVbpLinxYA5wUAkSVoLNxstuh?=
 =?us-ascii?Q?pzgbF+ynEfQO+/Q4UaA2juQZ2M6tIHNBLACeEYH0gIybfe2qqzQ5jj6/QPZN?=
 =?us-ascii?Q?4yjqDOcvqXgC2TqYaA+n/kV8tBaR9D5pfo68yPxe66TWBGkL9PL56tXt8N7F?=
 =?us-ascii?Q?7JuITDjwcCNmVlgLjNcdTEFBcxF+NZKuX4wYuwb9t/mJXHT5GYUHuzfrjBKP?=
 =?us-ascii?Q?RVQxB3yqbfxqXL4quoC9NNbCpgJ5wM93?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TfR1XWl4X0V6z0NxcwKL/SubOdOOInpsj1NAC9aIelzOtV5O52wztR40Zlxb?=
 =?us-ascii?Q?M+iUrnKBI7/+IyOBXwu7lJtDM16LFPDtgmwRYd9W64u71tNyMTA/snpjyGQR?=
 =?us-ascii?Q?A8Y/xprbZU5ejW5xrcMXnfdz/8SMD310+TNTAclhKPdWZn0TNN983+ug2gk4?=
 =?us-ascii?Q?NuS0ncMdx5hCM48+vS5WrzgqUsDYKqe9VGqMX29CAZbCoWOgptcIIcYQcg8W?=
 =?us-ascii?Q?mfcWyidDwqIgrJLe7LhM6j9h6tBUTpAttmFuZm18M7xaxJVXyEoC+MadtcZk?=
 =?us-ascii?Q?7F7QE4i2kbzkM487LC4dBip1oTKHzW4cNTb/I3zYzMt5vN5VpXi54DUJq2Vu?=
 =?us-ascii?Q?Afd+OnGMzZsBrAqwB1NdQoteIkeA8DYlMfsM/HLbWx5IZ4/XoKnCSGqaXFcM?=
 =?us-ascii?Q?of6i6cAuMVXS1lvPUYiXY7N2tXLQxfbgD0A+wk1CvripzoWn3MNfgBmaFPQw?=
 =?us-ascii?Q?Ckp2KUEsed0GtXw24t77YsFPcIp6TN3ffhyNwVBx4mb9s7Gkg5pH4PuioURJ?=
 =?us-ascii?Q?+iMtdVxiEE+mbrt9lu8moNEU1OGerPX6z7PQ+jcuCYBlJTgJtt+dAa6EfB8E?=
 =?us-ascii?Q?yXj1UbeAasOBTXbwEvd8kdv6BW7aTcJrSBaOef46SwFBSSepebs3okNFMlMW?=
 =?us-ascii?Q?3421hz78SBxmXTqm5EoHSVvgDxtRf8Cnti4sl7ttHyyrAXbDtX1surr58H4W?=
 =?us-ascii?Q?q2866ZU3Xnv2W3XzkF50jO7B5kKAjgAaW0COp9Fl2jc+0w0BpAWrwxKvBs6k?=
 =?us-ascii?Q?GuxUBUHlTfhBNDj1VSQ2JtQME0nLtmNTpppbY59MgLLh4w0Q9+UhmDfPdUlD?=
 =?us-ascii?Q?uD5DSadTuwDfFMXcPFYdiAlbAbzz6pnOEbedlZvVxYEKUYU47ZlnI0EFNQsP?=
 =?us-ascii?Q?P3QvBPevR7o7ddsW+ZceMJaOp/IWI6fueYs18vJdFmyYt0dFvshqTWr+qgxc?=
 =?us-ascii?Q?onI+MN6M28Yopa/qbgYvHMnWB5diiTJAt2i5+O/5yvBsMQRbW51pTP28HByi?=
 =?us-ascii?Q?4Cd7lTyn4KjziRRNxX5JMFoPGdKSmwyTX8Tvp8UdxwEY7BOBwcTLIHuzTMse?=
 =?us-ascii?Q?2ATUszcQUGG46kw7wuJaHVsskt1wMzGS9wM0lgCnEC09GDQtYHGZe+HhHAVM?=
 =?us-ascii?Q?28H9upwyP0DYbik8cUj4UJqUHjJ/9dGGZDS6mp16g6LVp3Xa5zuthuWc7msT?=
 =?us-ascii?Q?vVhXGLNMJmjlCr2YsJPiXDBkng8Rfs+jQoLzf3v9PWEe5z9CrR+3nuDnehZ6?=
 =?us-ascii?Q?K8F0nIwVAG6tmcLDpSLBUOXZnXtbsHrvetxnc5M0+qzZgITxdSGq82eXMaGA?=
 =?us-ascii?Q?+3KDxG21LPtpBl46UQezhYB2cStrKEtCFwE7FwjBjv6Bn9jjWiASwuSFhsIf?=
 =?us-ascii?Q?SRpdrPZkPk1vYKojjqAsUvSiidxQTD7TZJRYSm9UQI+AGX4Fy0Z/k0Lsv4PD?=
 =?us-ascii?Q?Z+HffLnr+MxO1V8G71vnLISKE+q1EFxBKNxz8JVOjujImNz+0S0Js6qX6dCs?=
 =?us-ascii?Q?n4b9XDdbL6HN2mqox46vF+V4LkrsOJTCHFfhQci9ViJubKmaguucuWZ2iW0E?=
 =?us-ascii?Q?dZrKzsaleBUKx/aNUxfjT3mubdTuCE8xwUrFWvi2JyJFxbAwC1aebMfzOzdC?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054e95f8-90c9-4f0e-185f-08dd411d208f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 10:59:11.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7s3z+6kUTQXC28nNR+WE3lJWFTipLIxW4MW8ryZPlhtcdPKk7cezt/vnn1HI7CftZnRzZ6Dw2VRscQ1FNz1gESpjrP82wbbs4H7X77s33Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8410

On Thu, Jan 30, 2025 at 11:50:07AM +0100, Takashi Iwai wrote:
> On Wed, 29 Jan 2025 18:31:35 +0100,
> John Keeping wrote:
> > 
> > On Wed, Jan 29, 2025 at 05:40:04PM +0100, Takashi Iwai wrote:
> > > On Wed, 29 Jan 2025 17:05:19 +0100,
> > > John Keeping wrote:
> > > > 
> > > > In the two loops before setting the MIDIStreaming descriptors,
> > > > ms_in_desc.baAssocJackID[] has entries written for "in_ports" values and
> > > > ms_out_desc.baAssocJackID[] has entries written for "out_ports" values.
> > > > But the counts and lengths are set the other way round in the
> > > > descriptors.
> > > > 
> > > > Fix the descriptors so that the bNumEmbMIDIJack values and the
> > > > descriptor lengths match the number of entries populated in the trailing
> > > > arrays.
> > > 
> > > Are you sure that it's a correct change?
> > > 
> > > IIUC, the in_ports and out_ports parameters are for external IN and
> > > OUT jacks, where an external OUT jack is connected to an embedded IN
> > > jack, and an external IN jack is connected to an embedded OUT jack.
> > 
> > I think it depends how the in_ports and out_ports values in configfs are
> > interpreted.  However, the case where in_ports != out_ports has been
> > broken since these files were added!
> > 
> > Without this change, setting in_ports=4 out_ports=2 we end up with:
> > 
> >       Endpoint Descriptor:
> >         [...]
> >         bEndpointAddress     0x01  EP 1 OUT
> >         [...]
> >         MIDIStreaming Endpoint Descriptor:
> >           bLength                 8
> >           bDescriptorType        37
> >           bDescriptorSubtype      1 (Invalid)
> >           bNumEmbMIDIJack         4
> >           baAssocJackID( 0)       9
> >           baAssocJackID( 1)      11
> >           baAssocJackID( 2)       9
> >           baAssocJackID( 3)       0
> >       Endpoint Descriptor:
> >         [...]
> >         bEndpointAddress     0x81  EP 1 IN
> >         [...]
> >         MIDIStreaming Endpoint Descriptor:
> >           bLength                 6
> >           bDescriptorType        37
> >           bDescriptorSubtype      1 (Invalid)
> >           bNumEmbMIDIJack         2
> >           baAssocJackID( 0)       2
> >           baAssocJackID( 1)       4
> > 
> > Note that baAssocJackID values 2 and 3 on the OUT endpoint are wrong.
> > 
> > From the same config, the jack definitions are:
> > 
> > 	1:  IN  External
> > 	2:  OUT Embedded, source 1
> > 	3:  IN  External
> > 	4:  OUT Embedded, source 3
> > 	5:  IN  External
> > 	6:  OUT Embedded, source 5
> > 	7:  IN  External
> > 	8:  OUT Embedded, source 7
> > 
> > 	9:  IN  Embedded
> > 	10: OUT External, source 9
> > 	11: IN  Embedded
> > 	12: OUT External, source 11
> > 
> > So it seems that the first 2 entries in each endpoint list are correct.
> > For the OUT endpoint, jacks 9 and 11 are embedded IN jacks and for the
> > IN endpoint, jacks 2 and 4 are embedded OUT jacks.
> > 
> > The problem is that the OUT endpoint lists two extra invalid jack IDs
> > and the IN endpoint should list jacks 6 and 8 but does not.
> > 
> > After applying this patch, the endpoint descriptors for the same config
> > are:
> > 
> >       Endpoint Descriptor:
> >         [...]
> >         bEndpointAddress     0x01  EP 1 OUT
> >         [...]
> >         MIDIStreaming Endpoint Descriptor:
> >           bLength                 6
> >           bDescriptorType        37
> >           bDescriptorSubtype      1 (Invalid)
> >           bNumEmbMIDIJack         2
> >           baAssocJackID( 0)       9
> >           baAssocJackID( 1)      11
> >       Endpoint Descriptor:
> >         [...]
> >         bEndpointAddress     0x81  EP 1 IN
> >         [...]
> >         MIDIStreaming Endpoint Descriptor:
> >           bLength                 8
> >           bDescriptorType        37
> >           bDescriptorSubtype      1 (Invalid)
> >           bNumEmbMIDIJack         4
> >           baAssocJackID( 0)       2
> >           baAssocJackID( 1)       4
> >           baAssocJackID( 2)       6
> >           baAssocJackID( 3)       8
> > 
> > Which lists all the jack IDs where they should be.
> 
> Hmm, I don't get your point.  The embedded IN is paired with the
> external OUT.  That's the intended behavior, no?

Yes, all the endpoint assignments are correct - when they appear in the
lists!

The issue is setting bNumEmbMIDIJack and bLength in the MIDIStreaming
Endpoint Descriptors.  Without this patch these are set the wrong way
round so either some ports do not appear or there are bogus entries
containing uninitialized stack memory.



Regards,
John

> > > > Cc: stable@vger.kernel.org
> > > > Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
> > > > Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> > > > ---
> > > >  drivers/usb/gadget/function/f_midi.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> > > > index 837fcdfa3840f..6cc3d86cb4774 100644
> > > > --- a/drivers/usb/gadget/function/f_midi.c
> > > > +++ b/drivers/usb/gadget/function/f_midi.c
> > > > @@ -1000,11 +1000,11 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
> > > >  	}
> > > >  
> > > >  	/* configure the endpoint descriptors ... */
> > > > -	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > > -	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
> > > > +	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > > +	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
> > > >  
> > > > -	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
> > > > -	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
> > > > +	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
> > > > +	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
> > > >  
> > > >  	/* ... and add them to the list */
> > > >  	endpoint_descriptor_index = i;
> > > > -- 
> > > > 2.48.1
> > > > 
> > > > 

