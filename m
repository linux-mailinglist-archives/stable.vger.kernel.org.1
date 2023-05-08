Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650096FA196
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjEHHwj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjEHHwg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 03:52:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B22D1BCB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683532355; x=1715068355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H59T48HubJcZLL28fVuMybDmonk8Vtv0L0g2FF7M96c=;
  b=V3KlNkXbmMhcYLIqUyWBOrGEdzPb88PBleJJLvpbF4Ld3oCa1uP5lScg
   sZt91+hz4aepijhZrp3Cc/9FAL4VZujRJaZR+cBLArCMBUoIPjK0qOLgJ
   2Moevv+6AYZUPt2pQu8pd2dWMZuHrHqzSyFzX+Z3Cx6/XdzPQ+0mV7c/B
   HJsV5DTBXGMatZbFEAYL2W55nTxD6Tu7D+QjHhwJy8IvJItglamp8qEf9
   fEm8csFRNB6snqgfTldU05NW9Cd4IQ/+HACCxg3yGRVzU929N4ZpJV3XW
   mF8uIlVg1af38F5uoGCoQgInFtz8wvtGr71wQqJm3smuFgZQ8bG7TWl6k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="412841315"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="412841315"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="698434893"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="698434893"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2023 00:52:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 00:52:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 00:52:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 00:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXC+sLTuJqr+/flyaCTrdCntgAw7me/PlbhC1uxs+pr0clRI1rkoCH9X73uNVHhEBhFFoUAJykFImgvIGNVQgO5A1G0eZi3Idci9TuX8J/jdASoBRiSYvW05Ze+5cj38d6Z2OISR71kfufY5kJPbt/vblUSKMx06NM7DHTUgXu1HHQM58uNYk81O7Y5O/2Jukcm0Tfj7ZCcFPq8O2Y7cG89M1jLKKCxow5XVK/Qi2lZ5dbylJ1cCF5bWHzGtai+pWmo6d+Kyfau5fmzJVWbC1vacvNnLsa19vVTZkd+N4EbMFFNB8YbLibZncGjMx77ND/FvlspFp+7F++bMiYniww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAlgDHB1vi6mLKt8G59nauIB3N63jMrGD+BZRQODFb0=;
 b=RUIYGwXseq98h8YfYMeHrpAQY67oFUg8dvj23iwSbD9HyQLn/8RtuThSN4AMIeFyc0eLqbO0fsQf+UUHhh+9McasDm5cDKNpI+/B9MbKsnAsyV4WwNgaaoyVWynuKULdWnSm2I17AhLZIJ1kUchu2f2f6eqx2YfgWZI7INe9YaymFA/ywzH4eFpipEMkUg/SF8L5FwMn5jM/QiH7kDOY0N9eb6uwEjJZMRo3J3K2avsSZTBsxpR9drTlghcc+m+VIDL2X3aO8oQ2DmWVPQjPD3UOJYZl2IFK2xVsKoCMdv0m5RkK53Tr9KwIBng97bRLCS7UPv/abmrFu4mjFRGmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5518.namprd11.prod.outlook.com (2603:10b6:5:39a::8) by
 BL1PR11MB5336.namprd11.prod.outlook.com (2603:10b6:208:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Mon, 8 May 2023 07:52:11 +0000
Received: from DM4PR11MB5518.namprd11.prod.outlook.com
 ([fe80::3124:6fbf:e20a:f14a]) by DM4PR11MB5518.namprd11.prod.outlook.com
 ([fe80::3124:6fbf:e20a:f14a%2]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:52:10 +0000
From:   "Rai, Anjali" <anjali.rai@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Gandhi, Jinen" <jinen.gandhi@intel.com>,
        "Qin, Kailun" <kailun.qin@intel.com>
Subject: RE: Regression Issue
Thread-Topic: Regression Issue
Thread-Index: AdmBflVc4Ic7nWyeSlqpAyBHS0vdoQAAg7EAAAAQuLA=
Date:   Mon, 8 May 2023 07:52:10 +0000
Message-ID: <DM4PR11MB55188D8CAB2EBB47E44404359A719@DM4PR11MB5518.namprd11.prod.outlook.com>
References: <DM4PR11MB55183E4B87078E0F496386029A719@DM4PR11MB5518.namprd11.prod.outlook.com>
 <2023050851-trapper-preshow-2e4c@gregkh>
In-Reply-To: <2023050851-trapper-preshow-2e4c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5518:EE_|BL1PR11MB5336:EE_
x-ms-office365-filtering-correlation-id: fe32b2c4-6e57-4251-f1e0-08db4f992134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m7aaP/2QWWl04FXfWdDfsgG/3BFUN3Pr2/9AlY+qeQAPEa3J/JdCcnCfVZn2yKd+xCbuSWoCRiU/KVycHRk1Y0n8XjYbzN/mNOvnpFVVOMfWVpAAvRAriwJExv0obLAZO9Gu2CfrMZXngRtGTVS7fMSpiu7/4o8Kqr+4+ryqEcM+x/u5xeOzWZ1P3KYziB/h+lzXcI8EV4oeMSLEj6O34A6PjGOU0uG2N/KfJlqRG6Syw/7jFLtF3KoAwHjOxDAOq89H17HVXvHXJ3oHqi2iFVwkDQHM5oo498HRxbfTsBOicwokp2WVQiSv6ZJYFMslP8niTB3d5nYuj5vwqEyhACM1Esd+OSx1E8j6dOmob153vH7s9PqBrnMVSA0Rl2ZQ+k+DSkfQDCllpJQt215pTKfY1JKCm3AoPbz2JE7yD2A13jKCn5EVgFwtVvuVN2clBCs3towFWexiCQHl2ZRacq69Yu+AOlfCPdDuKHuyEryRMamHB8ROhaOw9YcOiB6mv8tur5pKPLwaGhiNy+xfOaZd3FfOj73mFm7QKXAwC9Y9yYpEWOZH35gz3Xx/kRhZR7BkY1lSXQhFL3nzB2KEyBnRwCrgX5o7plJabmd3TaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(6506007)(53546011)(9686003)(26005)(107886003)(7696005)(966005)(83380400001)(3480700007)(55016003)(38100700002)(33656002)(122000001)(86362001)(38070700005)(82960400001)(186003)(41300700001)(110136005)(478600001)(2906002)(54906003)(5660300002)(64756008)(66446008)(66476007)(66556008)(4326008)(316002)(8936002)(8676002)(7116003)(66946007)(52536014)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iuw6qbqhIn6iCn9K87s0xNG1xcWgRKt9uG2d6UySPllJgtowTbxGnRHAGWLs?=
 =?us-ascii?Q?JF1eo4FJBwglB74yuz6mxquheaHD8v5YxzOv8qrb3hcJbYcYqbDZ5lkU0Hvr?=
 =?us-ascii?Q?D4mK/v4K203FDcQmeQu9/Y469w2PYo+lz7rO3ah02KswoUlc1cMeOhNWu/6S?=
 =?us-ascii?Q?4aGXUUTIzkfSL4D2J49epHCT6D88gKxjyVzsRi2cGkfnFCTWTikAku6p1VK9?=
 =?us-ascii?Q?KISBAYbpqrlNyITv762yHOEhS+vfJEEP7hE7yJLCiJ2yZ2ysU8quNiM7oAg+?=
 =?us-ascii?Q?conUp/1yOteXNVD8SDILBFAP18kCY1K8G+9yUHLNszq4vpEyaleOjzOYFzeQ?=
 =?us-ascii?Q?azM+RVJLLUhbIX++VQLUMgKydCtCG9U6W8Kjg0pB8506uORcN/GS9doRNGAd?=
 =?us-ascii?Q?1qEv1grRbPgl0Iv3PLB43JTaYXyNstMlPWcPrKRCbLRICCgmsZ3BrQmNHqy9?=
 =?us-ascii?Q?DYmpz4SNdwJG/2uGFeLhWHkyviWX6I7RsasbLKuql7sJ5VGFfD3rewzu6C0J?=
 =?us-ascii?Q?lagZdXUSf0/3EgHJ5o0Puhqet/OhuUvwxbz6CsZKuYrY3fLFPD0o0aRNqc/k?=
 =?us-ascii?Q?FzMXeuB5e+9BfqAPBjfsN5OY0wePNV/NjLTiO9gKjyP9Clpr5JybM3YPCBFf?=
 =?us-ascii?Q?sCmrZ2D8DSSpGluSuWrG7ZtOHpoPTrh62TqrL1oMkb05p9ejqkup+1Eyju7Y?=
 =?us-ascii?Q?tsxJf1iNHpP78rdDm9aBQss0ZSeghhDiyDTgfHGLsg3LGPNG3+jxM+OieNhw?=
 =?us-ascii?Q?PX7GwGmDOPor2Bf8fqrN2GTSP+kY0BusF3pYbL4td8Ymziu97zJMWUYSU8/2?=
 =?us-ascii?Q?Q0gS6oRWxA6WTA8UxCRq/Or46HT6dFb7jDgc/uaWpJ/vToOrsq4HskbepP0A?=
 =?us-ascii?Q?y0AJ1qMtKy0VdC/qFvUVn7BR9pr8Z5nkgWhEpdS7TgH8fE3Ogu3mat2rvKjk?=
 =?us-ascii?Q?mWBmW2AgqFDdoafQJRxz+VVsVINaAOp3gdscPmd8rFa1F4tLVZfg2e8O7v4T?=
 =?us-ascii?Q?hQJSYMjsX5xIHYeQDlgSwVoO+kBGIp/WT8hVL2Gl6OWOIEi8NMRJsrFO1V4A?=
 =?us-ascii?Q?L8cxQyq6BJxvmdxD5TzqmmQn59M3OlQcZWcIaD6ovBGUXStWh/F9vq3x0e/K?=
 =?us-ascii?Q?ys9U2gZwOAndylBwT6fNkpv9mDbMMqPQLBMGidJpUd5x6XxBh0fUTV/ihDpD?=
 =?us-ascii?Q?v/XNQNo7/2QeEzB2DPTtn1/m0OO9c85zUCvieQqgk+DoiEQsAJ7xJ/s1BDXc?=
 =?us-ascii?Q?npUhLy0LsTxE/DaVO6ynIDqVcbOxE5FivviqC4P3yppM/ITXeH0k8dJxc5JW?=
 =?us-ascii?Q?4gWQW+uZRHtTB373ecahwFN5Q/GXbTJndCiCknoRAeReYKB+EAjA1Kd5JyBC?=
 =?us-ascii?Q?8rXDdBobO7Q4x1Tl+hqkwLQcCXIcEqqRz81fHHF75pc8GwD+fe1nLFHxFcJ+?=
 =?us-ascii?Q?a3cPrKxX7M6AcromcYfojpAcrMl+u8MVfdegrms7qQFuxIX7ZMhqVx13haVc?=
 =?us-ascii?Q?9koE6qQIrESBBDW7CTwCtvb3VyWM+rCaJPehjfI1RdRGxFNApidepx8b2WCu?=
 =?us-ascii?Q?dYeMug+LqjXY6uiFdF2Thgz+Iz9ODVwDmayfLCq8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe32b2c4-6e57-4251-f1e0-08db4f992134
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 07:52:10.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DN7k2eCRiO3NQVynEUT5GER5oh1x9agdAo7C58qbj2nN84Dga9Z8VbmT6yf+7lm0iA2/vAw24dCoIy/LLN+/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Adding the authors of commit.

I am part of Gramine OpenSource Project, I don't know someone from Intel Ne=
tworking developers team, if you know someone, please feel free to add them=
.

Building completely linux source code and trying with different commits, I =
will not be able to do it today, I can check that may be tomorrow or day af=
ter.=20


-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Monday, May 8, 2023 1:11 PM
To: Rai, Anjali <anjali.rai@intel.com>
Cc: regressions@lists.linux.dev; stable@vger.kernel.org; Gandhi, Jinen <jin=
en.gandhi@intel.com>; Qin, Kailun <kailun.qin@intel.com>
Subject: Re: Regression Issue

On Mon, May 08, 2023 at 07:33:58AM +0000, Rai, Anjali wrote:
> Hi
>=20
> We have one test which test the functionality of "using the same=20
> loopback address and port for both IPV6 and IPV4", The test should=20
> result in EADDRINUSE for binding IPv4 to same port, but it was=20
> successful
>=20
> Test Description:
> The test creates sockets for both IPv4 and IPv6, and forces IPV6 to=20
> listen for both IPV4 and IPV6 connections; this in turn makes binding=20
> another (IPV4) socket on the same port meaningless and results in=20
> -EADDRINUSE
>=20
> Our systems had Kernel v6.0.9 and the test was successfully executing, we=
 recently upgraded our systems to v6.2, and we saw this as a failure. The s=
ystems which are not upgraded, there it is still passing.
>=20
> We don't exactly at which point this test broke, but our assumption is=20
> https://github.com/torvalds/linux/commit/28044fc1d4953b07acec0da4d2fc4
> 784c57ea6fb

Is there a specific reason you did not add cc: for the authors of that comm=
it?

> Can you please check on your end whether this is an actual regression of =
a feature request.

If you revert that commit, does it resolve the issue?  Have you worked with=
 the Intel networking developers to help debug this further?

thanks,

greg k-h
