Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51BD6FA23B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjEHI2C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjEHI2A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 04:28:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C352695
        for <stable@vger.kernel.org>; Mon,  8 May 2023 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534473; x=1715070473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jQh1I7gurgbkxeh/IXozwN0DIiUvoNb7M3dUCBO0Q+Y=;
  b=cHErynbyCUwm88ksmmEKRHvaBa1SvwJBXXIi+dFfrH9fs4PmtLiLfPvn
   J/1Sk/v4ImddUweSFoOKfuXX8FJeK29quUgs48SW+nCbCDMpB9i4XqhlR
   9ofrjWs9ZmmcLHmF07XHH2qgKO4q3m5UJTo4SMUqeGxFXqfpZv8ENeZAy
   p6rssMbw4WZReq5gbfvapI2ybHqekHxUS5StgidgNiBJKeTBnxl9v4Eyx
   ukl7LeuIJn8dms8OYHMu2QMcS+mA0Bw79uD0RrJBAtzml4nNJYUfKXHlR
   vPAgO1tFaxmzhh+R/HAd1YaEWpBIqMGLxC26dNsdWT53ny+IFQ7NvwwUb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="377679838"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="377679838"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="698445764"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="698445764"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2023 01:27:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 01:27:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 01:27:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 01:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWZjMxUKxWFMGfUJ1WumKDtzg8Qsr/1imOukbR+ssBMG/k2ZDtpSco6HIS93HLW5BoLvBlg6Er89p0/6dT4YHKn5LM+o2Vm5wD324tLbDPVkymB7Bc6YrkFnBwCdMtBtwwIkgM51VR599qTH+50EE9R0FyA9Dbp/gcmc3IDegMVNcWiVmX+9CqwoY67NhANq2PIE5qV31Yo0/He1jz0+M5meFi5GleYdXfp09FM8Movi1BTbT5CJOZ6i7pGHD44+b5cwaxtEHj2NYAiJYK1VFl8eAuoCiloKRTmfWfOUGWqxIUUz4lVTHICnNPU0gPIq0rlgX5r4u/MGqPINrA3+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVSPhOtNgB6LxVuBghUaYbWSxShbPhcwWW7yv/Q8134=;
 b=X/R+t6xOQh2AQJ66floSavVCECc4LSDifFdtPL79z3gNocbQoO316zJKmY5H3qjTZ8zQCMeBHiB0bKcM3nPewAEBErKcW62mNe98b41KfkSmDoIY1YzlKcfC/DchzKK0DvtomaP5DyXi0WDM1DZBtcS4h6pNosPRVPekWAntTUf0/DfBbCwHEnVnRkw4HvckfZSZWjQ465Kj0BZrMzuZ6ag8qQ6u+gFyW+6oSWH4utXFz6BOLhDxwVobsavi/mkj+JVe7glJ2Zoaq6PSm2TKdoZnVwpNCsTujFYb5E7nQU33O2ROsip1WydtVXn5q2KV9fhDRPu24RqYM4EsR2KwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5518.namprd11.prod.outlook.com (2603:10b6:5:39a::8) by
 DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.31; Mon, 8 May 2023 08:27:49 +0000
Received: from DM4PR11MB5518.namprd11.prod.outlook.com
 ([fe80::3124:6fbf:e20a:f14a]) by DM4PR11MB5518.namprd11.prod.outlook.com
 ([fe80::3124:6fbf:e20a:f14a%2]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:27:49 +0000
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
Thread-Index: AdmBflVc4Ic7nWyeSlqpAyBHS0vdoQAAg7EAAAAQuLAAAXPEEA==
Date:   Mon, 8 May 2023 08:27:49 +0000
Message-ID: <DM4PR11MB5518B5489BB5F01988D22CE99A719@DM4PR11MB5518.namprd11.prod.outlook.com>
References: <DM4PR11MB55183E4B87078E0F496386029A719@DM4PR11MB5518.namprd11.prod.outlook.com>
 <2023050851-trapper-preshow-2e4c@gregkh>
 <DM4PR11MB55188D8CAB2EBB47E44404359A719@DM4PR11MB5518.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB55188D8CAB2EBB47E44404359A719@DM4PR11MB5518.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5518:EE_|DM4PR11MB7183:EE_
x-ms-office365-filtering-correlation-id: dd2b3aff-ec94-43f5-31f7-08db4f9e1bfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V5Ong4sZKMftZcesPUCfqVq3ZCM04ypRwPXfkvNBJXI0vwL4/wSmHjBFsy8KpGQMXOmrGJzO9aQV/adlia2Fj6qSeaLk6zJX0sznSbUFzzEl6cRva0Ahc0u6RyNb6ytG3d/bg0egMc9LH5iGX5l7EO+IuKWbDOyA5oLCSLdCjTCGbk7gne0ZGhBv7T23lqET5f9doGHiYquV/LwCNEENECNbVdNEQ5ncny1odS4xGzm2ARXzikf5NFJoDDz9wgcQ2bk8lt9qqPYMqxPKAjjRSVfoscqnO+sy5N3BL0uWz9L6qJZuomRWdNfpeXhFqMvXGfEaoMNkhd50+I1lcypnTn9J3tTa7FPlV5m9diCpmscUEO8GqFSG+qARrGv2+T72bT84e1ZnPoQagtJdieyziSujh8xD40izLv4DktBFq06PCaw3qH5zhR3F+qJCSuiMlcZLyhrDAlouUPOU9u3OYZVPmM+JybUSTZ8IT/B6Zy/w2oUaRt46vC77kjFWvJ/B7KbmxDSGYo0Y9bp5n6fIXCKe6iHHjiQ0jJnjDnWwPte5g9jXSpgOB+TEy3p7t9e/pwEE9Qpo5wJIAyE2ikrXRrhwlDOaeU9koCAyMzgmMcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(2906002)(54906003)(52536014)(478600001)(8936002)(8676002)(316002)(41300700001)(71200400001)(110136005)(2940100002)(4326008)(66556008)(66476007)(66446008)(5660300002)(64756008)(66946007)(76116006)(7116003)(966005)(53546011)(9686003)(26005)(6506007)(107886003)(186003)(82960400001)(7696005)(55016003)(83380400001)(3480700007)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P2t5YCCiV4QkaNhLT/lO+cpSxlh+ILddaw23rNUNLhtNRzW7rXC9lVdfkp2p?=
 =?us-ascii?Q?kPhib855cIHgk3CSPX7dq3vxvLPpZo1PKBLMtvjpY3J0x2RVFn0ApfOyDFk8?=
 =?us-ascii?Q?+82I3PqtRMNklw+VD5yJqzH2Rx42C8FcgkF5GutGeXPHAvl5gY0vg7PYiO1E?=
 =?us-ascii?Q?U4gm182StUxFj+irALeBgeNOjLljoBkYWrjAcogkrHmbfTf0E58Fe0nxhlWx?=
 =?us-ascii?Q?lXVQLQziok86TXecPcW12h9UMmvpOB2wUhG0/SOotaIl+de7AOgK7fjskY24?=
 =?us-ascii?Q?if36eh/FJemIEr8Tg8hxfviOirQvHlpzwdhBgHaUTrgZaul2BP6LvuxGbcEB?=
 =?us-ascii?Q?TFm13Qb43yHSaG+fp1D8PyAao29eWTCK8fPmrNS6XrawE4b+r4tt4jL3mq8l?=
 =?us-ascii?Q?36aD/4x6A3tGy2JHDM3TZ798UXEupjXCHJt/EPzAKkXwQD/FwXT5vmjgqad3?=
 =?us-ascii?Q?GRlMuF9zD30nMInvdzioQ0o0SGnLxNHCkleOkHLqyn4OS4IuXUo1/akJW8Dc?=
 =?us-ascii?Q?z9cckZ8QsZYsb9/OoZTgUTPozvT7glOXQI6OUk9izF2Y99kLRf6+tyfX5wKn?=
 =?us-ascii?Q?2V3Ov17xeWJeeFevM+K/05lho+jDAIbK/6xo8uDmk+uLSuFqhbqK8TRSTBlr?=
 =?us-ascii?Q?dCtGnXFBj0KFg6FFBNNDDfrpNJPYY2w0vimMebTVCdH0GB5+hv8TLwL8+pYq?=
 =?us-ascii?Q?5QnmNIdUKUPd4sKwKZ4NT4/7PG2A1ju1jd0r7mRvS19aZFvyRrCuM1CHU3yQ?=
 =?us-ascii?Q?HTE/lCl4ogSHYfuaByWRJocqtRhjB2+8swYUw1LddmBuJyjlrzjyV+1IkV58?=
 =?us-ascii?Q?pE0g+nSC3eErV9Q12iTO+IMPNJqgJCjrta2A5neRFsUus+SGTF7wauuvnJrZ?=
 =?us-ascii?Q?GXzfUAlqQJb8DD1xj4hpdV8Gt94F3T4KV5DoY+heUD3CIuqMqB8StU8W0Eb+?=
 =?us-ascii?Q?Ft+rnumrWAbSGa4DT2R3fk4R9LMXCAquETzIqIolkuPFQOu7fQu7xS4Altqj?=
 =?us-ascii?Q?YZSaXKoIp5AOAI0858pil2NxmFzU5APRkXvyVhYydL/+s9l81+TbMGgQHyvN?=
 =?us-ascii?Q?x9W/F0AC3lA2towE2TuOdXdUh4pZ2AkwQrUjJERyx9AEw/r0o0DkCY9SxkSQ?=
 =?us-ascii?Q?AiEW2ei++bbxFgtAyr1XIXZ1bo/Tj21OyJtddSqIZH2/gU0XunlaenpF59LX?=
 =?us-ascii?Q?bNJgCZiljMMym8KspA0C4zSMvotoL1HjVze09jDolR/ylX2pCXqnv7dNMnAd?=
 =?us-ascii?Q?Ulw8znM+SJ7vqqyi62bDTj/ZwDiLTF8JJoQH7qH7B0mpfqKYcUvNZhA1j1T3?=
 =?us-ascii?Q?c8wXnY/z6Abd+HvwudKfA/JC/yOUUwsp69orPa6hgqDyDzpeCcWCOQxwMr+5?=
 =?us-ascii?Q?qUnMop35f2sNhPeoeO+okRHQi/ki7MGxhoO1RbpjC1ZKz7manZKriPSjSjgP?=
 =?us-ascii?Q?snyCMFU1kV68DMcBUkJxsuHmCSqJigKyjTrYtlbUNctOTH5CNuL9UUU5D/fG?=
 =?us-ascii?Q?sv++4OacZEBdna4OSHyPvXen+XzFksJXGKmHIiK6DyV61WOlwW6zypSBAjGl?=
 =?us-ascii?Q?hPMJW/HjndXmHsaCovwnIrUCZL1OIkueBG6+66T/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b3aff-ec94-43f5-31f7-08db4f9e1bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 08:27:49.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKGirpbQZDkcmQx096h93ZSmWRH7ClxKPhzrp37kiq6RDrc79BTyQPQPzz6u2OdbZplpe8tco+AqcbWWaMyTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Ciao,

The C code was passing earlier, and output was " test completed successfull=
y" but now with v6.2 it is failing and returning "bind(ipv4) was successful=
 even though there is no IPV6_V6ONLY on same port\n"

-----Original Message-----
From: Rai, Anjali=20
Sent: Monday, May 8, 2023 1:22 PM
To: Greg KH <gregkh@linuxfoundation.org>; joannelkoong@gmail.com; kuba@kern=
el.org
Cc: regressions@lists.linux.dev; stable@vger.kernel.org; Gandhi, Jinen <jin=
en.gandhi@intel.com>; Qin, Kailun <kailun.qin@intel.com>
Subject: RE: Regression Issue

Adding the authors of commit.

I am part of Gramine OpenSource Project, I don't know someone from Intel Ne=
tworking developers team, if you know someone, please feel free to add them=
.

Building completely linux source code and trying with different commits, I =
will not be able to do it today, I can check that may be tomorrow or day af=
ter.=20


-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>
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
> We don't exactly at which point this test broke, but our assumption is
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
