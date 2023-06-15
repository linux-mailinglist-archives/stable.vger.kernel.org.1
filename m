Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7D730C10
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 02:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFOARv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 20:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjFOARq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 20:17:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6BD212B
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686788265; x=1718324265;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OeN3m2E2v0aZ1EJ/3B0HjMZrkdKjuDJmTVLpbZm3vX4=;
  b=er6gcGFbyDEj8RPu1yxomSU5/dYPzFXwCV8eBrwmI8mcqGrRs5LbBSTq
   7MIPMCRQj8LbQYIzVlJURVtpzNAcCQO96R0mN31RPU8z33ghQrblKon/q
   A5/YYowynzztAm8731VshXBkAU/D28A+zZA0LBKh2UtSl5hH0fUnGNphZ
   qeqdlgfoexaIJ4BZ1Vppxdp+6xGK/XEZ9m648dLDWtnYz33Z8aOm/tR32
   sMmol7esXP/J/6hIPL/WNnZ/s6sl/D77BbprFIvF26abeMrCetc2f1/aq
   FPni9tD4euEvswiF2B2xqbVsH15YN1+wY8RIORghn9ENwNNlUpPNOHtCI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339117996"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="339117996"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715414312"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715414312"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 17:17:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 17:17:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 17:17:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 17:17:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 17:17:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLDa82w+zRrtCHcEmnuKWHV1utAW6yvq9eJCF0wLlR+LeifkuscwQn/Tw9+6Kw8Wmcb9c3sSA2i/3c8PQx7Lpn5dgfH5OeOJlDSEb+1vaArqAWctuc/J1zzCxdEe+3h3CTY0aiRSLWQr1QtUGSIPc3zfZGpoLIkXxr9bzvWsc2oxN+wdBct4P2nz9ba7bBa5AZIMnj2HfWNc7hz/qmk/v5/haW6lzCXZeqHD4CE16cZBjk5JKrbloInog9SEof4pQoFR3JoCpcy8FN9OYMy2vijY+shg9yOJryromY+96ZYOSIZm+yVIzTFe09pX7bUdIFvcOEvSNQHb64MlJe6KbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uHUvwvRLRBVHM7Ip0wQllXgnbr2wWc5UcDwn3lY8mY=;
 b=e82/Pblzskhcf0WHqvYt4XfslwSpMpXzpaC11vrQPK3sJHkxcnGf4RX4h+TT0vPH/NWlf/umop/45WfgI7PZ7t3cjjx+7fFOZHzmZLprLtEh5SgxiCXwgTosriqk9cg/sNZ26wetkzYmN5Q7wQQPSxWqQYGTZcvHaRZ2HiKST54vsmsc5csumvNN/dbtUSpgB49ZSH9OR3uguOYtQOfGzK7MllkR3BLkogzvPVZIew/P+y9zrIkPxjbKP/V/0vNLH2W3Luw+waI3rELwx+1Z+e3htfrKrPYPiGOLKF0VaGh88rVQVub2qog3kou/IH1M78/i9HrROvQhc+lsKl0FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) by
 DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Thu, 15 Jun 2023 00:17:39 +0000
Received: from DS7PR11MB7859.namprd11.prod.outlook.com
 ([fe80::9f98:8f3c:a608:8396]) by DS7PR11MB7859.namprd11.prod.outlook.com
 ([fe80::9f98:8f3c:a608:8396%6]) with mapi id 15.20.6455.043; Thu, 15 Jun 2023
 00:17:39 +0000
Date:   Wed, 14 Jun 2023 17:17:35 -0700
From:   Matt Roper <matthew.d.roper@intel.com>
To:     Henning Schild <henning.schild@siemens.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?iso-8859-1?Q?Jos=E9?= Roberto de Souza" <jose.souza@intel.com>,
        <stable@vger.kernel.org>, <holger.philipps@siemens.com>,
        <wagner.dominik@siemens.com>,
        Clinton Taylor <Clinton.A.Taylor@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 5.10 1/2] drm/i915/dg1: Wait for pcode/uncore handshake
 at startup
Message-ID: <20230615001735.GV5433@mdroper-desk1.amr.corp.intel.com>
References: <20230602160507.2057-1-henning.schild@siemens.com>
 <20230602160507.2057-2-henning.schild@siemens.com>
 <2023060719-seminar-patrol-68d8@gregkh>
 <20230612093030.03336764@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612093030.03336764@md1za8fc.ad001.siemens.net>
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To DS7PR11MB7859.namprd11.prod.outlook.com
 (2603:10b6:8:da::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB7859:EE_|DM4PR11MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cf751d-f865-4133-89f1-08db6d35ed48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5QXoDZa2b+pZdgHVI5VnR+WLRZO5d/WMKrzJLQQHP4QOTHKeLLRlJ4nm38mcSu1Q5WpQgrg8bF53Q8EgwQN3AZHMqhK6qX79Qxca37/ugwvL4q3C3xhuVA+qaDQHvOaTT/rKpLqYFN3AejsEQwOY1PnPaL4kHMPlZr7lzWN28g/J1N/xXVzK9uaNrqB3ICotUo+ytLD5phdsOG/5rC6T+EDgMdrhQonzH245YsgzL/uAeFaxwKZzU4ui2Onihh7jvodX4AnJDJ+UVmNHpIRX7zHyVFSRVr5RDY5lddIDM8Z/r+lj6BQtoLGJSG6XBfmGXBiUGi7efIqUHDHNXBiifttf4miY28zLyQb4LRpDj314Zo4S20JXYektWiqA6b5CW8toMdJj15qhpUWGWjQzYMenBGxW/r58bSN+1XPDnkghFQeZX4jNRNOkYzrji/4ExExabIK1SmcnQTlPKmwFaDI8qVKW93SLz0BbZScDKLvQRFeP3BepA+LxyIIy+U4X419WcdA1N4WzLac3Hgnwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(8936002)(6486002)(26005)(8676002)(6512007)(41300700001)(38100700002)(478600001)(82960400001)(66946007)(6916009)(4326008)(66476007)(66556008)(1076003)(86362001)(316002)(54906003)(33656002)(6666004)(6506007)(5660300002)(83380400001)(186003)(966005)(2906002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sVXgQdE8RN9E4riMo5Kscyr7vuwAFfo3/ulkeMmADFwAdUxvD8hHIrcoVP?=
 =?iso-8859-1?Q?hJC+CPcQRtbV5KzlsiCKG2wLlxXfZJ3sBdqHuaa1FlvA/wTcoNknW5kZnm?=
 =?iso-8859-1?Q?keWBvV/QYiz/Svd+alJE6Ta159PdLhuc2NA9HIGO7uHbZGcaNb8Ce8Nv/u?=
 =?iso-8859-1?Q?48MqeFWSFoGDkv4lrfvEZ2QGS918q68b+cnvH8VKsg0TTI77kgRBzhkRsm?=
 =?iso-8859-1?Q?xdoHXbiJThv60EEyfZVuvjVUxdIOpRGSjKA6orQdlBCE5Ovhq4LjnDQBp1?=
 =?iso-8859-1?Q?g4vLMoTDEM+QD4wS/v8qikDZI2TmmZXy6Xl2ec26cSyLK1qSyHZyxQbxc/?=
 =?iso-8859-1?Q?SuI+DtqfytBU7Zk9Y4YFL3ZODUt1kCub+cG+qYAA1piJNjy3C/6DtEfDMT?=
 =?iso-8859-1?Q?oKZh7d8RLvd0xYcp2+1XPV2aSMBEo6h8xXf3Ty5bV9vr8S4Po4NvBCFpR2?=
 =?iso-8859-1?Q?0a+w9C+sNPUpF1MKRUfZhRK7bnykc0Lo85DSoPEKd0ulshvezqv57IuGXv?=
 =?iso-8859-1?Q?EUQpGhbWWfVhtmPEnML3BvikbsuFmAV+rQ6DaFFlXvUkyuxg5kAZ9kW+Jy?=
 =?iso-8859-1?Q?riKgvUnjEj+X7GBfBU1FDYO0bzoB1xnDIPPkdNQYTBNvAC1l1bxoXz3N0o?=
 =?iso-8859-1?Q?APQgJ4Y97MG8zJ1GTBpFupxVEtNyihMEwQ+WPCo4Kxr9DKvU10E4KneCOB?=
 =?iso-8859-1?Q?crW6/OgqD1OdNcrfpHp+I/BtivMubaw7YiTZJv7RqSdLj7JShMCb8ecHV2?=
 =?iso-8859-1?Q?DJlRRnPn+IAQhPiexaKo/9RdwwmEb84xSu83tDvN76sifm8ikcqhT6XLOc?=
 =?iso-8859-1?Q?Pezob+5hDaqHu3xuF5PsPLT8byESA/5KY4oOxdk5pZNX3f1azwORHVeobT?=
 =?iso-8859-1?Q?rOE9g6RNZMBs26LchKhWvTkhzVKovnrxMuJ8obHcmcSQ+3yc1tWzFdxEpB?=
 =?iso-8859-1?Q?uF4C3ohJG5uZnLnMDLsQDCM6AqDLnkJsX5HsvN3UTW7r2X7OUC7JfHRElE?=
 =?iso-8859-1?Q?VmwXE60jJ4SqX1vWeOa+TT5TWNV3veBqpvo0LVkwV9U77RnqMcBiLXGqAy?=
 =?iso-8859-1?Q?RO/JL6Kysu1CHCjaaZoyODr/3ur85rQnUMJwJcPFoe/ZV7BslrtC1WaOeh?=
 =?iso-8859-1?Q?WkNZBAT0/6/m+r+c2xgltALZwOC+QAgeRPxp09OaUy4f1rtHcemKjiF327?=
 =?iso-8859-1?Q?iGSXJ/RU1lN/9XhLX9agEQyHK30SLjhcGhU0/1HcetVEionjvbi0ilE8hS?=
 =?iso-8859-1?Q?Y/d6PjX2y/lvW/upDFh+PXhG9uBav33rJ53Cbjq4Hr6Rjlt5f6bStAcnrY?=
 =?iso-8859-1?Q?KXDjDETLdZ8R0PoZ354JtY7pshSH4uO9sQfa/6PTrqXhvFKeeDz1bUQX3E?=
 =?iso-8859-1?Q?+ws1UzKjveqtt5oKXnZjhcp1BW7nOgHDJuSUgMUbPwRKElg/vOpgPqqqNu?=
 =?iso-8859-1?Q?dPnhoV/1kpDtAHW2100QkR56NP/R3qaXsiMXQump04FGOwFOwLaP/dcfMW?=
 =?iso-8859-1?Q?SZc/n0e1F+LHwGbzyGgJ2LuJbODcVxuqQEeeTyX4PBfAQAM64kypEW5dFQ?=
 =?iso-8859-1?Q?ok8gU82L8ypI7M06M3SqZddxQ8Wz+LUsDd63n9mPRTT702tk+6nWX4khFk?=
 =?iso-8859-1?Q?qTwCoSLWGJM5SZiqu+s2lOa3sHEs0yAJKn4jz/9S+X9eDcRUNom83Tyw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cf751d-f865-4133-89f1-08db6d35ed48
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:17:38.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeuH00+f3XLQXlxy9YezVyzu1H0R+3xrTDQW88+LOLYkdufc7rzugVdEGoPE2dBCI/ANlE0rsvSIvRYu2Uugw5t9EBcFo3OB5Ov9BZLK9/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5310
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

On Mon, Jun 12, 2023 at 09:30:30AM +0200, Henning Schild wrote:
> Am Wed, 7 Jun 2023 20:09:58 +0200
> schrieb Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> 
> > On Fri, Jun 02, 2023 at 06:05:06PM +0200, Henning Schild wrote:
> > > From: Matt Roper <matthew.d.roper@intel.com>
> > > 
> > > From: Matt Roper <matthew.d.roper@intel.com>  
> > 
> > Twice?
> > 
> > > 
> > > [ Upstream commit f9c730ede7d3f40900cb493890d94d868ff2f00f ]
> > > 
> > > DG1 does some additional pcode/uncore handshaking at
> > > boot time; this handshaking must complete before various other pcode
> > > commands are effective and before general work is submitted to the
> > > GPU. We need to poll a new pcode mailbox during startup until it
> > > reports that this handshaking is complete.
> > > 
> > > The bspec doesn't give guidance on how long we may need to wait for
> > > this handshaking to complete.  For now, let's just set a really
> > > long timeout; if we still don't get a completion status by the end
> > > of that timeout, we'll just continue on and hope for the best.
> > > 
> > > v2 (Lucas): Rename macros to make clear the relation between
> > > command and result (requested by José)
> > > 
> > > Bspec: 52065
> > > Cc: Clinton Taylor <Clinton.A.Taylor@intel.com>
> > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> > > Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
> > > Link:
> > > https://patchwork.freedesktop.org/patch/msgid/20201001063917.3133475-2-lucas.demarchi@intel.com
> > >  
> > 
> > You also need to sign-off on a patch you submit for inclusion
> > anywhere, right?
> 
> I was not sure that was needed for a backport, but will add it once i
> resend. 
> 
> > Please resend this series with that added so that we can queue them
> > up.
> 
> Will do.
> 
> Matt would you agree? As i said i just googled/bisected and found this
> one and it seems to help. But you seem to say that it does not fit. I
> am guessing the patch might not be as atomic as could be, that is why
> backporting it helps.

Sorry for the slow response; I've been traveling and am just catching up
on email now.

Since you're running on a platform with integrated graphics, this patch
can't have any functional impact.  The function added in this patch only
does something on discrete GPU platforms; on all others it bails out
immediately:

        +       if (!IS_DGFX(i915))
        +               return;

The only Intel discrete devices that return true from IS_DGFX are DG1,
DG2, and PVC, none of which were supported yet on the 5.10 kernel.

The dmesg splat you pasted in your cover letter is coming from the DRAM
detection code, which is what the other patch in your series
("drm/i915/gen11+: Only load DRAM information from pcode") is dealing
with.  So I think that other patch is the only one you should need; this
pcode one isn't having any effect.


Matt

> 
> Henning
> 
> > thanks,
> > 
> > greg k-h
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
