Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8016FEC04
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 08:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjEKG5O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEKG46 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 02:56:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0585FD2
        for <stable@vger.kernel.org>; Wed, 10 May 2023 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683788189; x=1715324189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+hdS4csDkq7VkrhCl/EBlw9+2oXmDOYb1H9op9n551Q=;
  b=fWcyUXTlbC9iQC5KqbS5op89goq+XHDFgxg9OiwlpPB+DsD1fHOdjaoL
   i2qrkMAvRkhO4y1mDk73smhfdvbfV7t0/ALKrfSCMVg1V6CETsck4/GqR
   vKAFbuhAcUKsADj7hd8p4gwDP6BpVfJX8N2X+ORs5rmT9ZB2UrqIwsC4N
   gy/M7kE+/1KdBo+16/zrkyqrqjbufesFrXkYnn0GAj8D1c/DF9K2vsqDE
   3exnqrSi00JM3WKrikXq909sRoUJgmTrcQs+vsudz5kuXWC8+yRvdUPF5
   KDXk6kCcMFOtv46pYhIs9ldy3Is0/UGFMnmUumTgzXQ5MMAKNBmQrd+L+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="413741611"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="413741611"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 23:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843812869"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843812869"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2023 23:56:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 23:56:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 23:56:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 23:56:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 23:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGwLRbp+gnIyja/Std2Ap0s7+ABLgiWZ2ePuINU62L2skdV2Iejuv0HwtaeSvstNztSypoVj7Wzy4LEK1DVo6bgVFirsk3E9vKKCN32JnTHJEcdKwOAyxnKDs0/g4MuBHgwO9jEl7meuAhlIdrxGA1iWpF+8hQ2gdwcujDg+hgoWZ/p5PypG1g7gSESh0Slis52sAaczo707mXuMNPRwg5PH511Ak/gBgS3yum6zM7ly1f/s1V31xbvQSuyYGYZSJM9jISwyYeGrECWhFxtws3OCkE+2jAxHsCjpWiMHUQCNQnPwjhocbLrJXOC5p/JMs3eoKvcp2ZF96lNXgDpIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hdS4csDkq7VkrhCl/EBlw9+2oXmDOYb1H9op9n551Q=;
 b=KWxmiG8hH72hYr0vPKF9QPkH0BvKA2kR0C95qAO2lvYTGiJJ2igw1qNSEhAOWk51hZ73yr7dgtWgbHPM3dsjFtw4dUzkxN9f6h64GrNUa9lHMJl7sNbE8JSUw/19oLfExs/5B8iu1LI7jSC6sr0FZ8Ocit1mL1hcIn8hL335wczLrM826+XYn05k8iX79mL8a840YCn00ltWXn97jucSDePMTmqbl/kST1GLihHoMpYHcO8cbqg2TJPOWEqRf1prSLApxxbFcfLM4Z85fBg0Ev/BNWzPTmP/jhE1Lgpqs02TZ59+nFXgyAouEbuquUGtneonNqxVy7Yx+ccIE2wOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH0PR11MB7167.namprd11.prod.outlook.com (2603:10b6:510:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 06:56:05 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%3]) with mapi id 15.20.6363.030; Thu, 11 May 2023
 06:56:05 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Florian Bezdeka <florian@bezdeka.de>
CC:     "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Brouer, Jesper" <brouer@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "naamax.meir@linux.intel.com" <naamax.meir@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] igc: read before write to SRRCTL register"
 failed to apply to 6.1-stable tree
Thread-Topic: FAILED: patch "[PATCH] igc: read before write to SRRCTL
 register" failed to apply to 6.1-stable tree
Thread-Index: AQHZgK90R4Iqi5B9REqNJLUBAFYwIa9UFJsAgAAMRYCAAITTUA==
Date:   Thu, 11 May 2023 06:56:04 +0000
Message-ID: <PH0PR11MB58305CBB67488FC9D6945208D8749@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <2023050749-deskwork-snowboard-82cf@gregkh>
 <46a3afc2-4b15-cb2d-b257-15e8928b8eec@bezdeka.de>
 <2023051115-width-squeeze-319b@gregkh>
In-Reply-To: <2023051115-width-squeeze-319b@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH0PR11MB7167:EE_
x-ms-office365-filtering-correlation-id: 3aeaa875-3eee-40d2-c845-08db51ecca2d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: as/iojgSh1xhKwI5iaCbRevwASiWko+XuRVaBKRirA+/5CK2Hq68FAmJY/ch6pQ2x3+aLbEmtJFYLwV8s5s/ayuDDML33/8vOKkdxPlidtfbNOmFUGvrlIXYYeSogX3NWlthLYfoPTrVBaAIqm/CToR4l1G64qCw5NGCXdQVOG1C7JiOaqs2Is9ngG5pigi5E/PQROZoTUCaKPgwRfBqlfbJwOgBux/CrUtZ4n9cWzreXOq+yPS8LiUwkmaQMzIi5RjJ8kVNdv8uf/qUUVj4N4PsQozPs2qt8UzrqyZrLFQhx1TC2ukXlZdIOZsqcIw+MDpbWKs+2m/Q5kFKo6dv9ryMGrzGwUkkRO6oIYKcExo8Xb4sLoEv017pKb9jCCr3Dqk2GT0Tevt52zBOTCnacyNWnnj2/Q+vVPo6ungbD/oy9MExORXlrVcL2hS67GnOUEsKS1UxnzmFYtQ7BunvnUmWM/hsf3Q5d7RwpBxKVA4FckTVIIUYMbGKrKFhzpLpDqWlfzd31F6tTsd/wUKSJzxOzeV9RsS1wzIvmH7cMLqAgTcng1shOZUq3gsk7Meh7vuMP61nQBwNdBcavMDeX4uwRzHn222qFcUGKhihJNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(7696005)(76116006)(71200400001)(966005)(478600001)(110136005)(54906003)(316002)(66556008)(2906002)(33656002)(41300700001)(66446008)(55016003)(4326008)(66946007)(64756008)(8936002)(66476007)(52536014)(8676002)(82960400001)(122000001)(38100700002)(86362001)(53546011)(55236004)(38070700005)(9686003)(6506007)(26005)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iBH4K1r/gbtXADFxnl9RSEpgttwnurLGhTXr59ZhFy8y+hd52Qw8UP/lNq4P?=
 =?us-ascii?Q?nxQBW5LjwfivBBdIrERQ9ZpoLYFwrSW015ANh2MPy9GcsXUHDBrgVa1dZGXZ?=
 =?us-ascii?Q?xM0GfWMd3c022MjHEMJLdH8aWwThSpTAMAZSf2nvxakRMmyvXuoQDHwjpFz8?=
 =?us-ascii?Q?Kh+rXtc6jWtTXUwc5GIN6uL2F02gcMdga2n0/xlqvcL4/JOCYE5l8jx9h/Di?=
 =?us-ascii?Q?4bdgspnZrZbkGrfycSr7g63v4vVQC3d/0wa5KSGZ6gDrWwGuwFE7gy7Qr1ZD?=
 =?us-ascii?Q?kfWD+uOAUk+7l+VCAGa1BeRVQkW03GnH6iJidDp0oQ5VG9Dk1P2WY+SBNO5P?=
 =?us-ascii?Q?PBPrnXqYHBHIP8L+vPZr3c9LN9Z0OZUCXnfX3r34Df4zp3FoNUoknZH2Dncq?=
 =?us-ascii?Q?xg1w3gUOZUWbvJeHjQw3BqqL2/e/QLjKcvKcRpXjjsWfwfnFoPUUwfb/GI0O?=
 =?us-ascii?Q?91qGTz5DK7hVnQ3mzM94AjRZT7jHfuHxhYBx9FquEvGf2m4RohSQsgeQoPLW?=
 =?us-ascii?Q?NrcKNwcZYGLY2t9pvtluYd99hmi5NhxArPOCXJd6o6ieOpxxZiXeZCJlyR06?=
 =?us-ascii?Q?VhdcCBoMyoqf2Pg+FZLRWM9qDPLR66dvedqNELAuF5ZlJmZPVMo8oJ6CIdSm?=
 =?us-ascii?Q?1XmqSXDm5aaDifJy5tOpjGihKLy3B3ogwmBye2VStHLnwUWJGdSY49uhWB7S?=
 =?us-ascii?Q?nHjgru3z7udoqFkMJG1GbFGVJKxGKOrtTFy4bkWTzCy53BeIIyV2IM9LBpkp?=
 =?us-ascii?Q?XAFDqJBzyWn5cPpc7PM7cqgg6+CbCnzNPX6jh8UOuyX7iMpefcr2whMvUpvI?=
 =?us-ascii?Q?Crd9CTIeZZmeY3Y19VaUXzWKOiVWgA1Hwq7hnSMCLSwqNwiC/L2xKzYBdEuF?=
 =?us-ascii?Q?gki/YxGvBHB5P6xcXLgjxK/Iuj1stjefoizFXqyoBtVWN53M6odTPvnQzANv?=
 =?us-ascii?Q?HQWqOb6qe/vkNLgDf4uwzwcejY0eij79AmzODL4l/shywoldRYrAvTUU+euX?=
 =?us-ascii?Q?f8VSd0xPlIr8YDV2ZZlJ9jOpYuTTycREgvTyXAxOSVCzP1mhNS+iCmcoP5Oi?=
 =?us-ascii?Q?yQPKvctUHBvQq1Zt/O1rEqoBSUOtyE3mxMV3iObj+1SlVUtB2RPYcwtqKb/m?=
 =?us-ascii?Q?ZC0NhzZYEc2cj5aVJvvF5D/TJDTy0P8dmGxEH2mVLU0Rgdv9GowJsTA1ZQ3B?=
 =?us-ascii?Q?doWpjH3SYVg1b+NNPyyN5r63JCmTQ36N4AfGi4Y+qD006LQAuhAM/utj+TDJ?=
 =?us-ascii?Q?kx8gUn8I/dsA/4JhHNAuhJThUS1JCHHwAsckfKk9giZcp/uSwbJBozPVmgCo?=
 =?us-ascii?Q?NIjk2tJwKzBf3jo+d7VqZBtiZbc3iycxIvbkiEsyhjTPl27YpxZdWaGudoD8?=
 =?us-ascii?Q?vdUhG6GUfyjrmeiWC1sjJk6eHyu4sgyP2VMnNiNpZu0mzKIKpe7NeLQIJPPc?=
 =?us-ascii?Q?HURLemN3I+wyKGbN4UTFEa51X0Lt/lhUBdF3//5sHLplbIvkXPlSN3flJ753?=
 =?us-ascii?Q?ESxXgbM4YQAb6ZrdaLw47j/7wwpl/JwPgaaMD1gJI6ddO+3lh9JYrLUwj+9H?=
 =?us-ascii?Q?GFuuelFyfxcXx9We5cDo8SzYRBFM8woOPnGeirxBEfrMFRh1S2L43RZFQm3y?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeaa875-3eee-40d2-c845-08db51ecca2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 06:56:04.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nMbRaY74JS+DYZJp1sfYoDyi8PXiIitUCiIyqqro9Z3k0em3Ky6QVdyOu7rvzMmwh6mR3RjEYCp5pbNbMZCWdsTuWfAfEro5hGVYjWnm3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7167
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

On Thursday, May 11, 2023 6:46 AM , Greg KH <gregkh@linuxfoundation.org> wr=
ote:
>On Thu, May 11, 2023 at 12:01:36AM +0200, Florian Bezdeka wrote:
>> Hi all,
>>
>> On 07.05.23 08:44, gregkh@linuxfoundation.org wrote:
>> >
>> > The patch below does not apply to the 6.1-stable tree.
>> > If someone wants it applied there, or to any other stable or
>> > longterm tree, then please email the backport, including the
>> > original git commit id to <stable@vger.kernel.org>.
>> >
>> > To reproduce the conflict and resubmit, you may use the following comm=
ands:
>> >
>> > git fetch
>> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
>> > linux-6.1.y git checkout FETCH_HEAD git cherry-pick -x
>> > 3ce29c17dc847bf4245e16aad78a7617afa96297
>> > # <resolve conflicts, build, test, etc.> git commit -s git
>> > send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050749-
>deskwork-snowboard-82cf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>>
>> Is someone already working on that? I would love to see this patch in
>> 6.1. If no further activities are planned I might have the option/time
>> to supply a backport as well.
>
>Please supply a backport, I don't think anyone is working on it :)

Hi Florian,

I not yet got plan to backport the patch, so I am more than happy
if you could supply a backport.

Most probably the issue is due to missing "#include <linux/bitfield.h>".

Will you do it for 5.15 and 6.2 as well?

Thanks & Regards
Siang
