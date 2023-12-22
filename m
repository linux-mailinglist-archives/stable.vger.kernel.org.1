Return-Path: <stable+bounces-8346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4C81CF6B
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 22:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6E5285BB9
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52912E82B;
	Fri, 22 Dec 2023 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9U2H+1c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163A2C1A7;
	Fri, 22 Dec 2023 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703279460; x=1734815460;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s4q1q65Ihdqu1PMCbNBd4N/n1eTc32t1XCV96bJIcr8=;
  b=B9U2H+1cAF1MziKphLqBe1HWe9MLW6hi/ObuJn73O5VErdOpWP47I5gI
   ldT5qZ3qG8R4QNAPq9bMuxqDGxvPkZ1W0nCznHfLLBXKWCWpUTmtVjR1Z
   ctUEzYfVodIFCYq76Kml/AOM6UH1kuQ+V7+Q+9K2sVcDSo5Qm2LtVb7Fy
   O35tfPTtakI8nB43v13AguEWrRKg2o4JKdHNnHPQlKBeYV/Gukulthznh
   K5pXa0kbDsQtA+sA12uGn645PGGEXkTXJmsK85cggcUmcSenGFeOghTeJ
   vzpAKNrqIoDKukwp8sU8Ltyt1h+TlrCt89eff/JUV59/uCo2d48NjkV6m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="427318858"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="427318858"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 13:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="19135419"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 13:10:59 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 13:10:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 13:10:59 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 13:10:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cme3I+qaxnY6fVvHLKuttxArYzs78WpSt0dl45/8trBQbG34cH+6izoOrD8kGSti/aWHWysgCGJiKbIWkPvsfZaigMOnbVZaaS7pSf0kDAAzH9WjKeQKT9Ch/auUuDqmlK9jUm9wZHyE7cGaa94q+A5Oebj48zQG3qgsiQOgh/JjRMoY5huQWsk11v+n7Cjiww5sHAJ35zXgDF/j2TKQX/1X3VUsiKMgB9KFldBZC+9Rp8K5Q5wgfNPXd4UlkaVUXeralhTHyk/1VzmGSnVT8ncs4NLV5MEnN2exDdELKCCEnPunRM4pM+jL3yZcyKOo0dC+QlJDX/7JwMzVPN8zAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INU6af/b17zNYJyzN9ChgpQLNrKC9T9q3uZRXyY3THA=;
 b=ZOZ4OsPTc+kT8NBuKwDFra7nfnhlkNIdeotB/hkaFv7PP/BvNitPBakIBVt7/cp1rmqzWw8p88G/dRP2JOUW4/0UTHmylXbq4SFZaW96paiKfvfNxsLYW/x7FGgyf+fJt9O7AbCSKVEEgOwjl6u6Bcf99V9TIlddFGok22RB55h64pCMe1RRawqZ9P5xyYjV3I2TUrPAVSg2RzgpZTurjZPMXpMq/psAdbMwYRmwMamgPIDoRnySOftApSPqBgbJlUdAE2FIFayfX+DwtH+hT9MBa5AVZWBVDEh/Nyc8DxxjlQr8BxUVDgI07L7NrUVQMeXwOUPXx1gWF+ZnxSVNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN6PR11MB8172.namprd11.prod.outlook.com (2603:10b6:208:478::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 21:10:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 21:10:56 +0000
Date: Fri, 22 Dec 2023 13:10:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, "Huang, Ying"
	<ying.huang@intel.com>
Subject: Re: [PATCH] cxl/port: Fix decoder initialization when nr_targets >
 interleave_ways
Message-ID: <6585fb5cbac83_90f7e2948e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170322553283.110939.32271609757456243.stgit@dwillia2-xfh.jf.intel.com>
 <ZYXtvKOfnIkGuwOe@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZYXtvKOfnIkGuwOe@aschofie-mobl2>
X-ClientProxiedBy: MW3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:303:2b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN6PR11MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: e5805d01-a80a-49bf-1de3-08dc03327cb5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hWZQtEps9QDKYGU/fvBX0q4X88vd3014l6L/HTBbyqenO/AXb/4VSx8qbuYBc2mWbpTVyMRX4u7MhY+hC9zNNNiCSfJR3jsIGMTPuVvdkaeZIHCubGvLV5LVwSogXqrVydEZeyGAz/9f7klPhfb/OUMpfXEAErg38miNJ8ilVJ/rOwqI7IPEiqLPwuOTP6VK7Xko7/dkrmHbvbSgqhtnYrIC3UfZ76+4kCdzaJ74irIHr/qHhsUEPZTF+YQTJ4ij7pkfCbZD+JcN740ATwbZyXtZWFchrQQHMgwt5ITemC2NbfKOT1crF/cY6Ym31h4mMUaD3+rctY/uq6EqFlFzP/kOAfNHhfhR8XshGeRu/p76hSBfj6GrcNKc505bYkm6pXggYhl+L5NMHD+xIuz5qyeJyjdK0cj/AX29P2e7ynptPVz0lD2IqN+UouWBG8ObjVjWyYGnsWza36zt19NeKzGo3wZresm48jc/Ws2wO4NoPh9QvBMdXQ75lFYdhw03D1k3mnGniVuuk/GdAJy3bV2EVyUtNPX9YnIX0z46g7takyVP1lIOMktjrH4Dqfb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(450100002)(8676002)(4326008)(8936002)(5660300002)(2906002)(478600001)(6666004)(6506007)(6512007)(316002)(110136005)(66946007)(66476007)(66556008)(6486002)(9686003)(41300700001)(83380400001)(38100700002)(82960400001)(26005)(86362001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqhhD6IywLcyyh1/Q/aZM3wi7TUT4RZTKhxErzqFmvOybmo8JC+myT+gwxsm?=
 =?us-ascii?Q?yNxtlhu4K69jVpv4sZ0VKcgQHB2SLb4p969aJW8g15idwo3rKNH9/4Rs8wck?=
 =?us-ascii?Q?5PyJ/gsnEYfJshXX39REF0X2fPSaZ5fvTR0gGn41SyuuPa3LBVjdNDbkiKeM?=
 =?us-ascii?Q?LADrUEwCQXMFgCOE2YlVgvf0yOHmnTt6DwLJU/g9mQh4rVJacAdyf4CjjvSp?=
 =?us-ascii?Q?2a9tvXHOmP+RziKddrhydtiDCo+G3u2U1uPamctmJA1wfvxbylCcjgitusfN?=
 =?us-ascii?Q?4GgMPVY4ni+EWWcKntOOhx4QmpiosCFtEa3axKipWDFnb/M+igNP2G8DCbXg?=
 =?us-ascii?Q?JXRLX3M0dnzPSfoEIYU2tZsTegQo+hCsRKMVkqpXER53DHsTrBMHoJeu9gme?=
 =?us-ascii?Q?MpbfSWCp9nmA3/yRooFXKno/ebaKBkfA+vdV+oiSk4e9ptzRi801shqURsIM?=
 =?us-ascii?Q?6tKbIdWQOyU2DFoU4E6tC6ZQDLCnYrVyJumx9usBUQFxFkGW01Ch5zQdRzIo?=
 =?us-ascii?Q?f7pPaxwdZvF+oCXK0/WBQVJuZ8S9g+rwmTk7P01xiJ/ZnW+JpWD6lQcbB0Om?=
 =?us-ascii?Q?gvkKfgH24iJZZys6wpVc7g7oHjqsaWJd6qX9cc6UwauQe+ZFQ2k/Gd4tnV2d?=
 =?us-ascii?Q?HS+JksIttWvDlvSMcC0vsu+yDpCWU5sAz3f3sb6Tr4YMMLYZpYJg/InmcHis?=
 =?us-ascii?Q?X8tSxETdNqLqP4dvmZ9y0pRVRt7O6Kfe+mHq8/xsLhL/srX0SnDM9/Ee+H3C?=
 =?us-ascii?Q?DLUQ809t4AOh9tKRjQiB0ZYleC+O1zWodzqcnnSfK3JVJL1T8Oz1ydvD4dQj?=
 =?us-ascii?Q?SErJZtn7OHOPsXuxFMi8PzISFeY+8wWWjOQlrzvlMxzakQjMSN0k5dG/mdhH?=
 =?us-ascii?Q?6pHvtk9Fa8Ce2FPyQ5326MF4Yc/I1LD+qjPnCDLKzeRAIgTgLYmYQbg4HUSe?=
 =?us-ascii?Q?f0sUk1yBYWw1xw+6S5z2vOF/6pqEiM66ov8Jn0uVp0G6NTm893RggOGeWeRi?=
 =?us-ascii?Q?ekTVrLFDI3r04pBaeoiwgrF/tQs+GmtSrUF2PNOv6SSNjb5v8zcztY8uLKAB?=
 =?us-ascii?Q?kEgPhMYpHIRdkB2+Ibv/nP36kHO/71fV/54bd2kITCjHpXMSZQPuNLxZxR5M?=
 =?us-ascii?Q?RpTbkanr5xh7wcqQEfwYK9cMFR0m7gWmQPa2Ud3Lg7/vznymU4vftfKt/ZPb?=
 =?us-ascii?Q?xMIXMTn0+XtALGWy4ytRP1XF2wncRtKY8UtFVE3v/Aqk1nNQEUFD+HCxwwBQ?=
 =?us-ascii?Q?SL2ILmeJTEVrE8MaqJXZCCKXHfHlB4FBbcQmpZ9vZEBo8ESD1PltiPLtToqg?=
 =?us-ascii?Q?chWt4UmMqK7TwQojC4YoB+MPRt/3hihk1vbx1Frb9PRDc/p/kDrSUnEqtW5A?=
 =?us-ascii?Q?1Le3h9vW7qH2ccktwH74XkcsV//DdjVRVU8roL/4zQyd3mtcxZvbOr3eXk52?=
 =?us-ascii?Q?acZWmJd8mN42QX7SXzULhK/rVUKtwNtM+YVCakFENOtEpIDweMgWmw0xqCDA?=
 =?us-ascii?Q?aj4o432ATX/V5Fr0E8opgMSFfVeXfqI7reFmHn96g8eXm/uCT6gKhBGXueoP?=
 =?us-ascii?Q?8FfSWQ2ZdNDcZ8yu+6R2pRuLZnfYF3x/FpY0O4yIEh5gOdeHwir1O+cOUysb?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5805d01-a80a-49bf-1de3-08dc03327cb5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 21:10:55.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykqX8fovwWZH4FAfPIHSe0fDmnLyWNts2PJlWrXS+hua4xdED9Vxxol/iAnl6E6IE9C/NEVR9DZq21kMqYeYof5q0QyIU6Yens29qbWhD3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Thu, Dec 21, 2023 at 10:12:12PM -0800, Dan Williams wrote:
> > From: Huang Ying <ying.huang@intel.com>
> > 
> > The decoder_populate_targets() helper walks all of the targets in a port
> > and makes sure they can be looked up in @target_map. Where @target_map
> > is a lookup table from target position to target id (corresponding to a
> > cxl_dport instance). However @target_map is only responsible for
> > conveying the active dport instances as conveyed by interleave_ways.
> > 
> > When nr_targets > interleave_ways it results in
> > decoder_populate_targets() walking off the end of the valid entries in
> > @target_map. Given target_map is initialized to 0 it results in the
> > dport lookup failing if position 0 is not mapped to a dport with an id
> > of 0:
> > 
> >   cxl_port port3: Failed to populate active decoder targets
> >   cxl_port port3: Failed to add decoder
> >   cxl_port port3: Failed to add decoder3.0
> >   cxl_bus_probe: cxl_port port3: probe: -6
> > 
> > This bug also highlights that when the decoder's ->targets[] array is
> > written in cxl_port_setup_targets() it is missing a hold of the
> > targets_lock to synchronize against sysfs readers of the target list. A
> > fix for that is saved for a later patch.
> > 
> > Fixes: a5c258021689 ("cxl/bus: Populate the target list at decoder create")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > [djbw: rewrite the changelog, find the Fixes: tag]
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/port.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index b7c93bb18f6e..57495cdc181f 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1644,7 +1644,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
> >  		return -EINVAL;
> >  
> >  	write_seqlock(&cxlsd->target_lock);
> > -	for (i = 0; i < cxlsd->nr_targets; i++) {
> > +	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
> >  		struct cxl_dport *dport = find_dport(port, target_map[i]);
> >  
> 
> Does this loop need to protect against interleave_ways > nr_targets?
> ie protect from walking off the target_map[nr_targets].

It's a good review question, but I think target_map[] is safe from those
shenanigans. For the CFMWS case interleave_ways == nr_targets, see the
@nr_tagets argument to cxl_root_decoder_alloc(). For the mid-level
switch decoder case it is protected by the fact that the decoder's
interleave_ways setting is sanity checked by the eiw_to_ways() call in
init_hdm_decoder(). So there's never any danger of walking off the end
of the target_map[] because that is allocated to support the
spec-defined hardware-max of CXL_DECODER_MAX_INTERLEAVE.

> There is a check for that in cxl_port_setup_targets() 
> >>   if (iw > 8 || iw > cxlsd->nr_targets) {
> >> 		dev_dbg(&cxlr->dev,
> >> 			"%s:%s:%s: ways: %d overflows targets: %d\n",

That check is for programming mid-level decoders where we find out at
run time that the interleave_ways of the region can not be satisfied by
one of the decoders in the chain, so that one is not about walking past
the end of a target list, that one is about detecting impossible region
configurations.

