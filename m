Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015B7BD284
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 06:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbjJIEV2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 00:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbjJIEV1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 00:21:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F792AB
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696825286; x=1728361286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hSyHaIOtipSdO3RufcZS3JHwYvi5uJUgn0JarH+X8ME=;
  b=E88qUNOdoU3FwrSHzQanNoENBmXVvQL6BYdR5Bv26pBTjs6nA8Mva7zQ
   HhAAl/PQ+5L6328DjjS657J9w7mHKOfMFKVXbx3RJB+Lcrxo+pqcVdzw4
   FcNoOZ7EginupoS9gzJ0g5higMmL+KTSlwG9WBHlpJOrmXp8Jv95y3QUh
   z34nA+H7H7AtNERRoPkm7pxbf+hGh0Lgpbckn0XrxJlzgIXqpgOLLDpo8
   yBumnn3C3eKT+yvc3C2ZOw3rZet2Wkd7jUXDJLoMvzdc2QrOU7L3eulgK
   h4QebqHcv7wLnXLYCn0mrLtb1TjR/5Bxo1h6Lap8VY0Bf4gU4j37sVBRA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386905645"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="386905645"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 21:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="1084190063"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="1084190063"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 21:21:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 21:21:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 21:21:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 21:21:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 21:21:24 -0700
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 04:21:22 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 04:21:22 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted
 variable
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted
 variable
Thread-Index: AQHZ9bsAp8C2Cs6Lz0+lChpHUhki4bBA46Gg
Date:   Mon, 9 Oct 2023 04:21:22 +0000
Message-ID: <BL0PR11MB3122C60AEC8E31945A549473BDCEA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
In-Reply-To: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SN7PR11MB7091:EE_
x-ms-office365-filtering-correlation-id: cb321d3e-0074-42ee-9ca0-08dbc87f31e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGZIdv5vFAT7O/0ncIuD+63IDhuLBw68cZeEUViEt4OEkk9Y11iGDrR93zBL0KZAmmEaa+5nSGrn4E5D8zxgvUw45prtSY7tJoLIAXYLjc5RDukF9C8B/Rh+waIqlA2y2xCVva57eXblyrfoulbdzbvaYct1flzf922JiepjVeXMmoUr7VIPUCay+y6cYpoNQW3LRkb0D37SVhH4UI9xNsDEYMaIgYTxrLabkHwVu8L4nrZ0XLEM1hFa2CLBvdYeFZ2dF5YrtYor+f3c0aDXJfedbUnMKQc0nLW7nZ4DSWtNvp8J9rcbBdY+0m0fk7DHf3ToehJlOqbWIXr5YLIDv7gXcFDhrELEiEvK6u4JEASJ0QXiTKj7glievUe1aO+di2AEjrZBgiN8mxu4lt5f5WRBnbmqu0Nz4XOz4+01/dqHOPG+rvlVc2MvcfHtrmKW1dvZg3nasXefZASgb3UTTE/f1RCJxzG6TzzssDlIZX26Vi2bnBM0hRNE540YPTF3PsdV+QjOONPi8CoaMuRnv4muWEyU9gzcqVHPF8SCgUyNVzoZSBIHwbo0rxz5jSrkfcP8pKBezqaEpgtxexfCmfPuzHaxwmob8NP3MlfIKp5XgNaYlwCnQIl2M/N9QGhi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(38100700002)(38070700005)(82960400001)(86362001)(33656002)(55016003)(2906002)(9686003)(478600001)(41300700001)(52536014)(8936002)(5660300002)(4326008)(8676002)(7696005)(71200400001)(53546011)(6506007)(83380400001)(107886003)(66556008)(66476007)(316002)(64756008)(76116006)(54906003)(66446008)(110136005)(66946007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vQrRk9iqbFQpMy55j47799321gX7qAAgSYFkj4FbsJ/ak7l98VrOH7rR/tEh?=
 =?us-ascii?Q?RJKLktGq1b7rgUJp8Lp61YZXSpcwU9UEa2ZarR9ekC03FfPyaMCygYEZtA4P?=
 =?us-ascii?Q?okjkrEziTRwBgvF+D8VjrDD0xtHCiVf6U/H51ra5ahuIdI/VYwXUi2GjIxKG?=
 =?us-ascii?Q?DSAfNkqs1CxIIhD8W6U/M7fEx+/DoUJNzgB32HbYAS253QAPD6SaxYRNjO6j?=
 =?us-ascii?Q?8jqaBG8U67gumX4g9x5gkM/LGbp6ILP39uzysj/uVNEqKFdK9pVCsNvyCdyF?=
 =?us-ascii?Q?oIRjuZugRKmoOYdYH93h9Zqs0fa1OxvgmYhO/J302L4tJiTwU3PsDE5Z0pB7?=
 =?us-ascii?Q?bvyfBlHleYtOuYL4QsJJv3tDTxi6OgsvF9RBXpsfUMS7VCUFUW6DyYRfMrvV?=
 =?us-ascii?Q?x/oUSJ7cBCz+7Np4AgTb5JPAlcz0rK6KAdQcxk0reItrNFR3nxpeptX1CgT5?=
 =?us-ascii?Q?UgsALep5o4iwnCBs/m5lGUmcYqEu2WKN84TeWojSikt+2T2kV57MMcUA7DRZ?=
 =?us-ascii?Q?tY896hMxh6vKrVvU3+NZJv/5VZVkPSOpEHPbuDeYZNEIhhusaiVDN3IfhbJU?=
 =?us-ascii?Q?70v0vYPUhhBqSXvSmTW+aH9CaFQSAN5KwQdHfiPirlu6uNNEXP6qLXVwy+yB?=
 =?us-ascii?Q?3ltuRDkxSLqBbS1F8kU/NExcCXs2OG1vo4QdPBlbiqiFRD8ZwvcquZNOTWJ9?=
 =?us-ascii?Q?dKf30UxInX+BZADZ7bRa/3hU+BrY6i7bF8Be0qZ1/Hcdj3gDQgRJ74HIUUvN?=
 =?us-ascii?Q?q5HtNCA4vBf+lVsqt/uy4oktffPQwZJgEKW0xKYxNYd1NMwvRpyeCLnx+6CL?=
 =?us-ascii?Q?2LowXmau7ADypQtvzsv5DcUISwv+Rmj4dei7WS4QED9dCpaDHLZCLJgp2nPv?=
 =?us-ascii?Q?46EZcfKjx/eq0G9F+0ZPpdvh1m623EoRmWDPMNsTEemXBXwWyzhUCUzB0JzB?=
 =?us-ascii?Q?f/dkEtvRIn5ZpVzjzS9Qek7k6y+mqzIR3LLWlC2QJfdMZECmT76dncaTox6Z?=
 =?us-ascii?Q?rVAWWqca3x66Cnsa8Aoxc93BSJDkIDHU2oAH6WfZ8MCuieGSFBh0lP2J1ntZ?=
 =?us-ascii?Q?2f+5s7kUSbWxxP5oSPMxZSlHBVqfmzbTx4+YXmmA6TB8wjhWMt/9yfHao3C7?=
 =?us-ascii?Q?uvq4EqsWtmbKl3GotY10LUTov4DyRMGTZ051bbB9o78ko5VjYeEzAdLrj18B?=
 =?us-ascii?Q?mbUa+9gExB4yAtnUR+Z9yvKUU85DC6xCInxb8rHMQCiyDEHdHYA1EPcoNEMn?=
 =?us-ascii?Q?8iWALwPIueG5te+7zehTQcdrlWjanxZS3cOiaxQebyQC0k7sPyWuzY4Y+RRz?=
 =?us-ascii?Q?phSGJz+G8eHCIU8zoMIHS+PEJ5BRnQOo1Wby9a3w7pffEDGZPrcGq7amNYc8?=
 =?us-ascii?Q?31yK0bCkxLTZTanJL/ZhS67SYu70ZnzqglNBQFzkJ9Chnf4lC0SMzMz5a4m7?=
 =?us-ascii?Q?OvpUheo5M2BfNIg3oeKXJOufSzYzZKtBRLar3UkLVMc3Vii1+kNVjytFAvLX?=
 =?us-ascii?Q?JxcNZYDrai0Nt5fktNOFNoxb7tX9HWMXBT1pwEVEmU0aPZsycvGvNGS1ScYp?=
 =?us-ascii?Q?dC9oG6g2XB6nA7oG2hZXaRX1+KaA6shh+6Y9jCWhPk8mMZf49l78Tx2khDdN?=
 =?us-ascii?Q?l77sbtuy14RCUNeQiTjKmLs=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJZC8DQGayY9+QNlGcwSNeaJr3KzwBnooggAREkkLXsb2SQYSzvYQpcTaL5zl2+QCpzsiaxsGl/n6dz+Fyftp8YUv96FBHPpE/HrcQ0eItz5bwa3XxprA6KfKbpusPknEqnIVTdMipCr8bQbxjzrBBk+8V5D+SyacYBvg8T+MeSd8u/Yq6HimtNHvslrtwqAruQW6CLLP2LDe/Jl1Q5ub+oj8g3viJ2xX86bayZ/L2/NB6kZ0mjsOs9diOdiDhvu6xRe02/t1LBYEvwrCKaQH505UDPtjr9etvX4vg1FEXRYcUtVcb/n9PhMoYke+39YfQPhOc8lM9xgdsNVyKbKmg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2/u2E3EGjJkGDhzMR9lc+1uYGRu1N4c9bG3zVhJqn0=;
 b=cc3KIu/y91/D3r5G0uKn7nvxKq+FgSdvCiNTajlJA8XlQOvZvC/+fmDYHVpqY3l9PhS63acGHaeXLOdfYcsyHVz6fKQNb3W8nsd7sHo7PPuoVn68N42rrxVhhxA9THJAdYk3K8RlprE33e8aD8y1KNoIB303qAvIe429XjuArt10Q264r94QWtVXIBz4aJ3G3gviC59uQa0nb6hOevIigkb2VYE94doyOQDqNDnHH3GyT3OedONCJxRsxHyRUEv8iHkhTY+h7fpd56Z9qK3Zx3o8yGdnN845+ZM5oJsfPM3RyV8eZ1mA1THnjm3GpGJxt8ChzhWB1g++tifovIDumA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BL0PR11MB3122.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: cb321d3e-0074-42ee-9ca0-08dbc87f31e5
x-ms-exchange-crosstenant-originalarrivaltime: 09 Oct 2023 04:21:22.6062 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: /zku+g+3guVSw3C3lxSZWAbaf2kTtrszhRdFYsoUBUWBY2ddYcCSP9EDSdpm/71XlRtHnQbijQbw1ynd2Vdvl4gwx5XUywT/Y4v4N00T0TSpMGY8tSVK7HYJ4+/QH+Gt
x-ms-exchange-transport-crosstenantheadersstamped: SN7PR11MB7091
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Tuesday, October 3, 2023 11:01 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com=
>; stable@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.co=
m>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted varia=
ble
>
> Since the introduction of the ice driver the code has been
> double-shifting the RSS enabling field, because the define already has
> shifts in it and can't have the regular pattern of "a << shiftval &
> mask" applied.
>
> Most places in the code got it right, but one line was still wrong. Fix
> this one location for easy backports to stable. An in-progress patch
> fixes the defines to "standard" and will be applied as part of the
> regular -next process sometime after this one.
>
> Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

