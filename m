Return-Path: <stable+bounces-81188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D04991D59
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175BC1F21C86
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D485170A01;
	Sun,  6 Oct 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hVkXOBlB"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAC41C79
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728204296; cv=fail; b=gtyAAWcrF4rA8iKp8aamaCu5TOyMr3T4BgYhoYC8t0eNfL4NpXzW3KVcFrLFnoTjHEovwec1vnTHyCbJycUsv4/LaOoNcxu+aDIpUhLiTusR1r1XQyg5Zd5VFEWkK8BGkWOqHRhX0188nV3TYUKcZ9NCxLnSnGansreVdIHrzLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728204296; c=relaxed/simple;
	bh=34jQG7VACAef7PCyjTGiX+cmSH1TCjd9pCTFKak38ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GRqnjcwWjfb3MXbXYrw9YcQE3wGghxEWlrLFC1e+sr/cdYUoioh6O3t1pRptVg/ykGmNN954mF4X11z8McaUk9dEyso7bjJnWCdqeeg1S87jmSHAcHdp36ns3HUAkfiO9G+TEyhNubZiHmT2V029YSJDTkJmu97+Yl5pZUKWdjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hVkXOBlB; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTWUJzkU+aubhaNwp5NpUCGddDfGLdbnDslL4yBtfUDUvLsNCRMTtsJ9ASTxgXU2TDI7i4XVxtzUyDXujOt4auZQGdHNInufb+w+KDVG9z+toUhjiEzNFrx8FOauWf9abKBZCOGBPFFppDKBjRkrZj3G90gVkas6Hje7YX/auuaxuJP0gbfIDvYBLqSC8nni+dGkURtBfo7WdKhUPvT1U/q52h6l1E/WM/gEHxkmp8kXsFgRH9SXPuVwmc9dUWtL8x1FBzFZY9sRRIFPM7/QGRi5RNAy7u/q/xMT5MYloK/ifsNHRSmm5YsnC/mfJ+D2xkKZlxDDhMicxtDhFxe2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OA45DfrdrIl1l60G1J4qsfoK1LX6Cbv2LTaDRY1c6vg=;
 b=XFiXakO6B0lqScb+ySY7tdL+ZTZCMkIlVek3ioXbQsvTBlozfXeEHOBo6RJWLaRheV8UwZHhHxStbmM/A+4jqqydnDtlynK180Frz/75Quqmso2/R1WjADZqtT6I88L7amJ9vWDk58eStf4I7rHYYcZbF1DCjqAadZRCIL5CjtUcuZM5cBwO8Fi+37NfpbUDFQ3hfRnme+0pI3pIXNfVySdWXL3PpKPiax/Xom4UV02uDqXD3spu2WenJawtUk+t7zKe7PZ/kjJP1y1aUSiX1pp+XyOu0Cyf/bE8uzpS1S46T/JRF914r3PjwwPuOaBJgk7gEHKuZVvswJcRNhYtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA45DfrdrIl1l60G1J4qsfoK1LX6Cbv2LTaDRY1c6vg=;
 b=hVkXOBlBb88DrwVqTtlHjPTcFvVCHeMqIQRyKesqxZ1HQLCqaLHWKyy2XmYXLPyxwBlA6Qpvap+R9v9AfyvHPN8+NP/lL2rK3v3MdSiGoshLsW/7hmDvv8AzVxGH86RRadmPI8UTQd89xcXF1sSSDTmLoZ46X4Rc/OXGhlr0R6gb9DUwmmTFmELn8mk0c9dOqT2Pq6OVYY2Zteq3OCXrc8vqkjkQEIhfDbUk99or/1D8rnMk0NK4u9uGTAf6oR3X2G3N7InyYSCAokmouQdFjHnxa4VHP4NFRn9rlA9CweZCa6qU/d8S5L0lfK3W1XULjwTWZncJ4tbRNHBsuc8eFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.20; Sun, 6 Oct 2024 08:44:52 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8026.017; Sun, 6 Oct 2024
 08:44:52 +0000
Date: Sun, 6 Oct 2024 11:44:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, gregkh@linuxfoundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, jiri@nvidia.com,
	stable@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, sashal@kernel.org, vkarri@nvidia.com
Subject: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering a
 devlink instance
Message-ID: <ZwJN-jZ82HpfF9PL@shredder.mtl.com>
References: <20241001112035.973187-1-idosch@nvidia.com>
 <2024100135-siren-vocalist-0299@gregkh>
 <Zvv7X7HgcQuFIVF1@shredder.lan>
 <20241001153953.4de43308@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001153953.4de43308@kernel.org>
X-ClientProxiedBy: LO2P265CA0393.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::21) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: acdc44c4-9c71-4e29-e429-08dce5e324d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8p/pzLrFQfvrGZzr4OXD+BmFs1QaOpiv3FCqBwRD5vr3/4rxeoUJE9WevpoS?=
 =?us-ascii?Q?gK+ik10xhPtDCR5X8+euFGxkE/U/dk7PJHbhQ0YXJuHTObLKynt4BKByQVqr?=
 =?us-ascii?Q?71YOo+IAT4m5N8P9YD8gIRaJuGvodx3bjCF4Rimza9AUES6g7NBJB1B0IDJH?=
 =?us-ascii?Q?sU+ZCQRuR9c7ppV96dPyAOcYI0OoJSDIEseIuJF/jADPrKmRVmeWe4g1G9ke?=
 =?us-ascii?Q?ZdJUv+MK98NQvvIEGNyv3/7M1KxmXWDOfxlaOrCeLJxYmMtHHNbwb5txptfq?=
 =?us-ascii?Q?Rxqj1irRO3Cqb++6NS7vPb9h2MmqmVWQ114QkgE/3lPekWm1RgQnAKes1CHO?=
 =?us-ascii?Q?ToSOwh19FbUWEY6aRljIM3+EpHLbQSkimi/215vAfDtVfhHtVE1P2UjAnjzZ?=
 =?us-ascii?Q?vsPGNcy7kMDPFy+HZ62nEebVlY11wWS8X7dhiviv9dEu/DyiM18hXUV7Kk7W?=
 =?us-ascii?Q?BHtCS/LP3eEB4OpHHI4cKB31y0FnxAaVHTcCnqD0aj/ObrLTCkOgozgX8+TU?=
 =?us-ascii?Q?KbVA5hYt009hlMTOT8keyatPsbpqpF2CxOktOgqiyOApD83MjWE3rkZ+WJhD?=
 =?us-ascii?Q?+9DevvCQjcuCTE+IKWGr5tDENw19/2obYybfilCQFhrLCCulQru5dNvYRkkR?=
 =?us-ascii?Q?/KTMHx8jgGHkbDBW9OCoVtR2SdrUTg5bVA1Lhufex0s+j4GpVJyN07QbG/sY?=
 =?us-ascii?Q?1GzcoZ1jooNR0lO30nbLEWK4PxYbntBcIeI/FLAQoqyHQ2L5TG+EpRln4zwG?=
 =?us-ascii?Q?yj/AIhQZYER6C3ncG5QiqthBagOzwTZChnoLiPxewy8lnZjw//9pNSoOIGtN?=
 =?us-ascii?Q?6QBhGc7eshYXImY+oB0VEtlUvjnT3jqTNrvlkqhW5XfxDBJ4PqGB4BtQ5y9a?=
 =?us-ascii?Q?BUqvTK23yNX5lx0hPJA099GG182Q9yWXX168KqkzkJ6dzoMbtd93/VaZ6C00?=
 =?us-ascii?Q?KZzlso8evZArMDmq6dxTI2UFrury9Ooj2UvSxTFlPBiY9h1opdnjOMkqcgZ0?=
 =?us-ascii?Q?4itWEXfGTzzEJjKbHKnpd43N4xRgohtRVXeXrHzcEWukTNubRpWRgPTSxFVG?=
 =?us-ascii?Q?dGGpS4EkIbChWYRhPiETY1ZABPGsS9qKm0OXGt2uvJcTJs4bzMB+lyR8W6ag?=
 =?us-ascii?Q?DRJ59iHp8apCQpfCIHVvGOTRP684/xEjXRA3IRgjPN2jGHHSvMzEnuOgUtCg?=
 =?us-ascii?Q?7c4p1E8Mf2z47QBAg/FsQktjVwv00EYxNyNwXLCj4hpPuIWa3UxAVwEm7wvF?=
 =?us-ascii?Q?v83rA0O+KgYaDPefGgD1rbq/80R+ZzjWdRK27Zvt1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kpLropT9Kq9Ku7VnbT7s+/bo4+t8QAKHABPn0Sc01D7Kgmat7E+BMcB+L/Qs?=
 =?us-ascii?Q?kBLBZaNhgMyF7zzgRB8b4BF5AVeSj/L96o+9u0LV/ueihnBfzRbakaOxboPa?=
 =?us-ascii?Q?0397Q02JxRM7HUlX+beaC4C0J4OUlJU8Y1mtBsWrOA04ebNedifDGQ5qOklt?=
 =?us-ascii?Q?Zy0Sjpu1zhh4HFyqai9fnFQVXUoW27YO15buMX5UsFcmNj1+8VEVFUFzZA+s?=
 =?us-ascii?Q?DrBlxHMRV/OLvwKPnu4Tre6GBJXLA9Z/NMzQeiDtcrKXnY1DCQ8csUkbHG4i?=
 =?us-ascii?Q?o/rLCwx46IYOybvjGvi3w/PIMFkcgphu8t4aYETbFlt7lHUJEK29VCNenr5x?=
 =?us-ascii?Q?HVf+R/qv2EVvubL0ipv1++XuX8UxWEoK6EeLPqEoY7i6N5XvyxQslePskwMz?=
 =?us-ascii?Q?ymfgIE1aO8bAyeW9hfh8Gws3Eia3oFTfr30wiNwRLGkQmKxBtmlG9mF/Vx0Z?=
 =?us-ascii?Q?2+ZNPK66dI++6AazrcAb0Xn4t6UAZ8lD1UTpQWQ5FY2F1avYHUHQQb6SBiwr?=
 =?us-ascii?Q?+nIvyw7Z/aAEAMEukxATOgFT6uCg8PPncOxKFzKSYIPu062fIRJ8KpwNAPph?=
 =?us-ascii?Q?jT9AhqJ7TgYkbgAESkJCbPkK8ECF+aQUXZssDtvn1NIv7M6VyYdvww66hu/x?=
 =?us-ascii?Q?L8E68rhSuKMfYz2WmnaH2+xTNPhDknicyX3+T1k2jMNCxlYqw8JxQZpttaZ2?=
 =?us-ascii?Q?LGRWWNNmlX/N62pHMBJQhlSlAHYreF/oN4sXqFgcmmQeVqNqKqpjzEsqjC69?=
 =?us-ascii?Q?AVaSQMgC7eW5ZfYUtrE6NeVCktzDGSWeN7LFAgwMlhmBvaVAj9RQ9ZFyB8fp?=
 =?us-ascii?Q?uUy30QbDXaPd+HUFR3CA3j/+gQJ4Kg0KsfNI4pAer39Jff1FqZhEW9UytsWQ?=
 =?us-ascii?Q?ghFq5G4cZ96k+tN172B/4VA7qm5xKh1Oip/CSIuWB0OKUGgVA1u4ZQvDa54E?=
 =?us-ascii?Q?RI6aRAfMDZrcGoIj5XhQI5FkDAEveR40XLxUKVNhSGKz28/f0eep0htzc3IC?=
 =?us-ascii?Q?LuTgFEV56mhK3aBvUg5Do5UkGYpDq+AcBL8JeEWAJXEYAdj/enBQ8Keekc1k?=
 =?us-ascii?Q?wJzqfOIY8nsMA8QHbNb5Rot3rMfZ6+eTU4IAjMeJDgmoWU0LDGzfUMz/pSe0?=
 =?us-ascii?Q?J55ceTRSDowzVszp+djQKvfCXi/hy4WO9eV7jGfmYb5upOu1RVl/0Y8YiPDW?=
 =?us-ascii?Q?m0YUbMatF3ZZtWo8afRQLyXyDlCpsQ1z95bEpJ/zgf2IcYxgpyfX/TY8AJAw?=
 =?us-ascii?Q?nRvWIXIlbK9PtsT/wLKRF927gfSTiO5qb760n38KZTn3TX8Oy2U6RKFyBsJh?=
 =?us-ascii?Q?IytnAK3aj+LRTEVYUKYZGtWkWX3JMT9BtB9XqKlFioecclxtyXIBRmBmkg7k?=
 =?us-ascii?Q?SeCyz3L8vIKaw4/EsDl6ehFjfrp9XIR/wpCL+h/4hDp2nUuxTW9upYVHPs14?=
 =?us-ascii?Q?I8YnjX8TQgvRcOHMErPcGAqqsF91UtkobQwxNCADtn4n/jlGGf/Ca2uLSTpI?=
 =?us-ascii?Q?Q7wb031D8G3ROUSh4q/2Z4eIQD/hOitIvX46SkeklVIelITl0xUhIN0FGuYA?=
 =?us-ascii?Q?r/wyrHKf4J5wFiCf1KlZzu6e2uOcIeqZU952rPV9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdc44c4-9c71-4e29-e429-08dce5e324d4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 08:44:52.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43/wPNZKq9JyidM5b/qwtUM9mvKizgLCy3p72FHBkHC0ay/UMpetBUDLx2Mfv/5ZODYGyefDhrLxiE6mulbPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

On Tue, Oct 01, 2024 at 03:39:53PM -0700, Jakub Kicinski wrote:
> On Tue, 1 Oct 2024 16:38:39 +0300 Ido Schimmel wrote:
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
> > 
> > Jakub / Jiri, what is your preference here? This patch or cherry picking
> > a lot of code from 6.3?
> 
> No preference here. The fix as posted looks correct. The backport of
> the upstream commit should be correct too (I don't see any
> incompatibilities) but as you said the code has moved and got exposed
> via a header, so the diff will look quite different.
> 
> I think Greg would still prefer to use the bastardized upstream commit
> in such cases.

Greg, if I augment the commit message with the necessary information,
would you be willing to take this patch instead of a much larger patch?

