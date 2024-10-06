Return-Path: <stable+bounces-81189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E10991D60
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5BB1C20EA3
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BF150990;
	Sun,  6 Oct 2024 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qr/hXtlR"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F3A31
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728204723; cv=fail; b=kN68zm9VWG0gnaaGz8I8oUOaq0E7TqpPbvB/aVWRsVAVhK3OGdVoMHIuUEmeGalncovcLDykyfizXZHgDKSfb67LBEjWFe4e3XwDsheXCRQH964+Phwutw4uKc148V31k2gH7LPIwYTHLKit7E+j0D2aUarG5Iyw8IluuGFs9vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728204723; c=relaxed/simple;
	bh=Sc912Wb/O9E6purL+IbMSo+pFBouYxyyj8uTRnPuM9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rkOW5rY9liZvxoEDM2ZwrB+iJ9wKRH0fxMH+JosFhthtRnCiNb7DWcLXXqILD40GmLamdpAbEucN7RcBxdCxUq5WTiaq7KR+D+NjYwDzlZtsP4n3VKvQHAU5XJToPdpOb3a70asEycniy38Ne77XvRnpQBxpbSrj3yNDi4PTOSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qr/hXtlR; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1R0XYdjQwTfPpwJOzpxChdofxn8IOPy3u2ynKKrMcVO6103Q3MNiMASGAWb4b5sIOPDQSbd8j+AYfmlAiBgdD1BHawYgWaZGJ5/MEXymbT1k5gbqt5TvqhRUZdU+MZAWwUCqZuElbhiboYg4mXt4lauitVeAhBTxObuEUAyrqN6eT+U/BwjWCkCFbVsM2xww9bUyR00Uc+u1S1hSKi0vz2Yqwts76nMSPgrj2YtfhrY+1YIruP0OETMBSGd2HljZYVpytMbXKNgaQhvYhPtb+sevY4kzm0WjRt0S50183cQCY1ZD5l/1/dLxE2FC3AEHh8O1xMElZ0aA8+iG7j3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=px3DW3O07ANbdoJkhi/ElYkA/jEg5GYCTL2JPeBAjfM=;
 b=MjTy2LQwE7LeI3Kh2i45/Rf1EDs1kE2KgBPojRwEqNcWh8LveBKXgE+8pRwFsrqNfAcTtMCuwmYo7C1Fx8oiw/uDEad2WZC8Pj/NDOhZQh3BxpCOD2kv2U+gfdPcSKjGr79lYvCTyXBxdOF6g6uGMfAVajKqTjvOT49PP75XYtR/4doMmhOshL2zsoxM0twypOEGjjU2FXlJzpdHwhj6cxUCaiKQbvTV5orHNzAM5WyNkS42GnNzzCzmiY5cJBZUuV8ZjRbkAqPa3asjYNfJzqI2h2UQS7bbO3qvUYImfF0xUuLOKXCuHabGsieQNmV93Q7l0rNuOdhYdCCMObXPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px3DW3O07ANbdoJkhi/ElYkA/jEg5GYCTL2JPeBAjfM=;
 b=qr/hXtlRDT+Cz2hDLc/Y44RHCcPlrzUgK1xvz6cygJ2ahG90F+DX+KGtW9YnAGCHpy7FvXocDbVzh0Tcr3DWCuGLqysOHnOl4LfCC4tFkRqU6s7jhCyAjcAXF4kb02ViHJWE7egyju13RxgChagVhIHCUz7PrJeCNLYAtHnvmvKSdMRTfUj9rk3Wjy6s3TrrspJbc+iTMsH2hXrZlzQg6f1HNWvUZZM6eEN5s1Gy4kV8FciyPp/NjxqA4jyHUPEVRyKczf51h8XFFMt+ggVBzUWSpf4qdCRatyuDuT1c/jmGvAhSAxSkYZFx55s0uGw33nwF/mxqLVcJ0StMjwpN5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.20; Sun, 6 Oct 2024 08:51:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8026.017; Sun, 6 Oct 2024
 08:51:56 +0000
Date: Sun, 6 Oct 2024 11:51:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
	jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com,
	sashal@kernel.org, stable@vger.kernel.org, vkarri@nvidia.com,
	dvyukov@google.com
Subject: Re: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering
 a devlink instance
Message-ID: <ZwJPot2x-bO4cdWM@shredder.mtl.com>
References: <Zvv7X7HgcQuFIVF1@shredder.lan>
 <20241001164759.469719-1-nogikh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001164759.469719-1-nogikh@google.com>
X-ClientProxiedBy: LO4P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb7f762-4b2a-4184-13df-08dce5e421e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?34uRGyJMhf7SKokmarc6xB2Y0ikWPkfkIXfGnHTDjN7E6HnjLOdyhA51fhh9?=
 =?us-ascii?Q?2lZHmX6BznTjMW4GmXJgckp2DKvdAADiLwyxmKg/hFmbLlNMyDx1JOKuVnC9?=
 =?us-ascii?Q?BLg/nZUmeGCvIMqB7Gc7epGIr32+YhK0z+YRinelGz1jxt3uCkRIU8ruifng?=
 =?us-ascii?Q?PvxuKJRxbEAF7BE5gDAScGh8YFb1E4B+BTY47ON69y/hdZJ1FAkfzBPZFK73?=
 =?us-ascii?Q?TUpqaZQpsg6E2wsgYUnQ6I+NucdTH9gIHlkQ7pF1T7b0QFdH4CrQa/Iw4o3I?=
 =?us-ascii?Q?4pcD5f54Tnn+TWTnx0R7N1+2XiUJFFKk4Z0HLkWsk5EfSt8rhPMaoG+pltPa?=
 =?us-ascii?Q?TBPE27+66OtizEdVNt0SAUNDPBO2YCQineWqBF28zH+WNLN4gXzIQElpOJir?=
 =?us-ascii?Q?cI3UXJ/BkQ3dVLEQ4lrtC5EqN3AZKA0KyE/2j1JRmtgvXNewh1NwQt7MyXuj?=
 =?us-ascii?Q?hvDcD5pARpS9IgFL4msBx34Lkgn3IZMPf7a4xT2tjplQSYkQOLf+/slRoj2t?=
 =?us-ascii?Q?zYX8VYmcdD4uUiQJcimpOjKW5ikyRwLBs8HDgG5nme+nFF6VGT5fuph6ExMF?=
 =?us-ascii?Q?AEcMfbWw05kXWsqMYVpIxuGCB7JJbdsJnStN830kUCkD+bPoYgJyFfZoRcsC?=
 =?us-ascii?Q?IxkgPNzDcTXWOkF4TQco8Ycheha6s0s6UT1rJZTt3v0FHJjUu+IXjmbmcgc+?=
 =?us-ascii?Q?2FJWqiqCtjsmmw9LinzQwnnidxeK7OAjy26PM6Q45VyOLPdyLLslke9YIk/w?=
 =?us-ascii?Q?WSQ2VhTkoyEMZuzffqUxNgQfEF4FfbPOLMwl2wi0/yPb1MtNWDE2oKIzFjEn?=
 =?us-ascii?Q?7Tsyh389xiQKyf2Pc/8JByGhyyXpWRFPmLcBdhRYXeWxMPC1/MhYjt3m/hV0?=
 =?us-ascii?Q?UXqZ2Fpk2qMobzYol/FHmJ5MILaWcJCNjVVfEIn7aZyMGc78fYlLbeN4xE5v?=
 =?us-ascii?Q?AaaPP4T0io6VJpamnL3sbGfGM7RF3m9G2RdrvvLj7IsDx/X6fAepLOdKhTOV?=
 =?us-ascii?Q?iVsPebfCazEEhOtaYhSWAW5z1OLRBhf851quwgZ0qwhmSybiYPOvxP2km/9f?=
 =?us-ascii?Q?u/hLNyAEQKZeEwP1wiJXCne3L6qEr20tLy5C6Xhm3yFT088v4WNHFZIFzmNR?=
 =?us-ascii?Q?55aX2qZHkAC2/QV4/6mDVk5SW9t++a22myWJ9A3D2oImooJewJreNaNW7yTQ?=
 =?us-ascii?Q?QTLuuwzIzDqYTmtfLQqeyfqoDjqLt3gZ914h2NrB/kVDxUm9UdYqsVmWgbuz?=
 =?us-ascii?Q?eqm25iC1KNlGhOKx2rhkP1ftFgbUBRSASjsouHWYdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8RgpVhZ+qyt7Yo1jRznVza7Dk+ztE6a/mNiHb4Pk+yDyt/4m4Md9N+OeO4+s?=
 =?us-ascii?Q?1Rtr5Nn3tD3fWYaaYigNithDiZFrwIYZYxeWCWG/2NsMtYRZUvQhFOTH73Rr?=
 =?us-ascii?Q?YqUv4GCaVyC8SfmEk4J8HQiXC83uxTasxx3iCswFL7sSwy6wXPkANgBkw4wO?=
 =?us-ascii?Q?gsZYi3AD2KqnqUvVlQo++0FnOMvSIvLoutdIkFKn3f3EbKIc4claAPLPpSe3?=
 =?us-ascii?Q?a8ffuyzb65FaDxoIN6m86YPssMn+K/zFQERnMtATO9/FqqYekL2cwDUW5ksT?=
 =?us-ascii?Q?+R3q7L03ZxuM4oXRJ8mAoMllx5qHi0K3cyMgBfdBF6EdrfoHb8dD3YmZhVmS?=
 =?us-ascii?Q?Tj9l3MIEtzlveJlSl87LnRPQl03xOaG8CIaPWotGgj067SZRAlZUxpytZsTn?=
 =?us-ascii?Q?KV2tHg4KHkPdwFX1HgwyAgz+Y1G5+j/kEvUfb8cuhASYUCPzhx31q1h0cqU4?=
 =?us-ascii?Q?wt2Y5BK35IAr02wZEfzqfI6DFULje57B2KZQ4WVrz3NATF1w9LNwW7k/LYA7?=
 =?us-ascii?Q?j5oSQKKEFQuVgrhgafx81vfpDlqPMGnrogIhxSfq1nanV+YINSM9VNwahaBE?=
 =?us-ascii?Q?r7zbY8Xmj62cg2gkF25Elb0Mx475puxHQIdmEc4LRyCN4zkGPcaQZNPrHpiJ?=
 =?us-ascii?Q?rzOa+vFkHeWS4UXT19EcT+eImo80wvh8sx1N19bh6x6S6HGbyychWEVkaZXB?=
 =?us-ascii?Q?Fb1IQYlIxNOtwcN9NXpbdBzHw3zuv1rv7z/XCpntgczj8aMjXOyIR8+zvPt1?=
 =?us-ascii?Q?+gAcaBrffTEocdPT7wWGlPfWPdTu2z9p7EyOYO4mPuauCoA8lrsHImGrZUXW?=
 =?us-ascii?Q?3hTWgLqV1rLfmQ14x8FmuzinD5rVYNO/+AgX2RLNs60xd2JIEOoz6mb4SUzL?=
 =?us-ascii?Q?4mcPYdS1o9GIUWwv/R3NoF0GXVwF/KUVR8qqB8pUtEgWowExtHZh6osc7N7G?=
 =?us-ascii?Q?FD/oiV3kElwhnBkPLduQK6bSSeox1heYEqcw/yDwPbU7cQauVO1QddSXPJyn?=
 =?us-ascii?Q?0kTwO6PLDt7E+kE7lLZXGtUs172nhLoGr/QrBCY8FKGKpemp03x0dObOaJLa?=
 =?us-ascii?Q?8gQvD5PaHwUioNSWYbJ6tnZHfEJSkXmlIvqmSX4teqLiIgNDqp+MXFun3cy8?=
 =?us-ascii?Q?OkAqFYzsfXTN0jAyZyT8P1j4E8SGd5OVgjZS3YewGJC6t/4uI5+O18SL/FT4?=
 =?us-ascii?Q?FWx4t7MDegf4EtKWeF9rqyaOHSMPlhjOLFmb9PnBP2olFdgGKIg1zCRgJdmb?=
 =?us-ascii?Q?bJDrXWJakNoK8CxwMizWYu8nY+vgRLPNtGkzh+qqXG1QwIDayDhbt/ExG1qI?=
 =?us-ascii?Q?31+i0BlZrG875EyqTwSoYSM+LuZvbb9GfH6Mt1QGlBsPaOGfOP6PDpsGAL6j?=
 =?us-ascii?Q?NZNq3gUt+6SJMB1RwH1IVPpicH2adqmC7s8MiLTIfO7ADdKdxY/XS8AdDNwc?=
 =?us-ascii?Q?IpFg7pOfLbb7aDsBXJ2HTdVhSVezCgYggaevT/YQwjSSZF70/Oi/16UhF0gS?=
 =?us-ascii?Q?gxg/CZ+BGxpXN4PJl9f3YdUamFx57gJ6V0rzBJZsAs0ofJIeWTz8a4TuocXU?=
 =?us-ascii?Q?Kznj5bPbsMRZldykR2+gyexipXUaFePJOnk0pUaz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb7f762-4b2a-4184-13df-08dce5e421e9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 08:51:56.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olsYnyhCYXB+v/W/xDaF6j8RbXZniIjH94AHV1eyNIqDHGdePu83k9KaQdztZYDb/MEwXZj87NeRQ8kntNjH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

On Tue, Oct 01, 2024 at 06:47:59PM +0200, Aleksandr Nogikh wrote:
> Hi Ido,
> 
> On Tue, 1 Oct 2024 16:38:39 +0300, Ido Schimmel wrote:
> > 
> > On Tue, Oct 01, 2024 at 02:11:27PM +0200, Greg KH wrote:
> > > On Tue, Oct 01, 2024 at 02:20:35PM +0300, Ido Schimmel wrote:
> > > > I read the stable rules and I am not providing an "upstream commit ID"
> > > > since the code in upstream has been reworked, making this fix
> > > > irrelevant. The only affected stable kernel is 6.1.y.
> > > 
> > > You need to document the heck out of why this is only relevant for this
> > > one specific kernel branch IN the changelog text, so that we understand
> > > what is going on, AND you need to get acks from the relevant maintainers
> > > of this area of the kernel to accept something that is not in Linus's
> > > tree.
> > > 
> > > But first of, why?  Why not just take the upstrema commits instead?
> > 
> > There were a lot of changes as part of the 6.3 cycle to completely
> > rework the semantics of the devlink instance reference count. As part of
> > these changes, commit d77278196441 ("devlink: bump the instance index
> > directly when iterating") inadvertently fixed the bug mentioned in this
> > patch. This commit cannot be applied to 6.1.y as-is because a prior
> > commit (also in 6.3) moved the code to a different file (leftover.c ->
> > core.c). There might be more dependencies that I'm currently unaware of.
> > 
> > The alternative, proposed in this patch, is to provide a minimal and
> > contained fix for the bug introduced in upstream commit c2368b19807a
> > ("net: devlink: introduce "unregistering" mark and use it during
> > devlinks iteration") as part of the 6.0 cycle.
> > 
> > The above explains why the patch is only relevant to 6.1.y.
> 
> Thanks for bringing up this topic!
> 
> For what it's worth, syzbot would also greatly benefit from your fix:
> https://github.com/google/syzkaller/issues/5328
> 
> I've built a kernel locally with your changes, run syzkaller against it,
> and I can confirm that the kernel no longer crashes due to devlink.

Good to know :)

I hope this patch can be accepted as-is instead of a much larger patch.
Will copy you on the next version.

Thanks for testing!

