Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795A173FE92
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 16:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjF0Onl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjF0OnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 10:43:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E035A5;
        Tue, 27 Jun 2023 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687876973; x=1719412973;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VC65RKNcCGx+oLIZ/J3knQQTEoGmZA8LHqQK3iD2Gyw=;
  b=l8dpOfFzEO9aGioepsj/OcafWS+seV3u1R0jOHokI+TIN2PUrjz2m9XQ
   /6zeNdLYG5RLc70xqC4RFJOtDn7wv2W6YiT8hICJhA5n+lZtovpvXt57s
   z+ChE8nm4+iXg/IDHb+yhdmO28vAXdxhBZCXzQWwW/ZzDRIcclWQQeAbh
   VI55AvzK+0ClZfFeBO8atkeaIBDzW+fZlg7cLM+zJ1Y5Ef3JnyHiOmCmF
   iA0QfC7zCv+FuKFPG2oPLPMQdfElqnMAG+EGGDUnVL8ZYFdMJ9xcomd1h
   g730I3dEgzBt8La+DM4rJWKpD/+iaKw5w+TyZziDCXt97l6Qh/pbz96UH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427588373"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="427588373"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 07:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="693901163"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="693901163"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 07:42:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 07:41:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 07:41:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 07:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThN+HCpYQmsN8J6FU0TuYSPfmZo6L1TaSay4dZBsuljXDOkycddEVlMfXkZo9umXEyjo5bu57mF99HiZgnHApeP3jOMZCpGjCn7j6uYP89EvxTr7Ja9G8jHlf2jgcRa2a8wsA3LZmDLkOXgWzkCMPZsKgBRQSVGwa1vofoNgbvJzSGpN33GmW+jWODDhwMzyEB/gSDtxPaHVXizskObuBSg1Z5Al9qtrBy2bQ1xvm67ZAFTO9GXtP8uWCpD7syblCZecAyE87XgolRQpeTv056ZnjgVUBArBRAKlrMd4ofa4W99lNIOcjtyK2YDe4dQRVC9iQDa2tVWKQyuim6ruoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zvAX2fcfTIsxjEJ99RtjoU3kpX1IvXTAIVaV+mYvdw=;
 b=DIGGKzLeB3Xm0VhXLi5+MVB9m3mhzVFUCKdxicjel95xshgd+l6OUrD6bOlyjinNXPWT47YfEsJNOJ/eSqNsesjoS64R6J8gRigvmNrxIk+zGMFkLRAMueMGWDXYigWbIZWBmKxz+8/MT0Hr6rHT6BilGuwm9562jDRmPPB7j4jRRoDy1+a7DHkCdRNhcXbg/mxjOzcrrGKX5xfKc/haARAyetSn1zc2giNVesfg2Qirsxerp7mtLSLbJB72D+ITTEoT6wvZwwMRMGtZ7e3lqM5ue4/w9BSmYAEpKUSJeZtp2oekYPFRzP/cSPWNl9JjOO4G0ElEZ/l72C1Gi5M1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 14:41:57 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 14:41:57 +0000
Date:   Tue, 27 Jun 2023 16:41:37 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Moritz Fischer <moritzf@google.com>
CC:     Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <bryan.whitehead@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <mdf@kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
Message-ID: <ZJr1Ifp9cOlfcqbE@boxer>
References: <20230627035000.1295254-1-moritzf@google.com>
 <ZJrc5xjeHp5vYtAO@boxer>
 <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
 <CAFyOScpRDOvVrCsrwdxFstoNf1tOEnGbPSt5XDM1PKhCDyUGaw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFyOScpRDOvVrCsrwdxFstoNf1tOEnGbPSt5XDM1PKhCDyUGaw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN6PR11MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb0b7f3-9ced-4de0-566a-08db771ca86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Hroay233jeYGg1rKpaOEuK7hnjOzcQ2R6/d7UhouSDXUnDhma20QXTnk2Zy5K3A72MdAR23+qtsTpDnVCUwi9AtpRpbTGIt7XPNd2txEdUVpu/ztwf9/uEWm1tHCl1w63cBMbCKwlSZol1ndlzfPdfWe8YrBI3cjD6uQ6blMRaqzbng4KPv9GC5IPtRg75Y3YGEYF7fuF9UsquXVS7jIol5H48jCL/+PU/MTj3VOgoCBvcUPBa4f5INLIQoTGLUr1ktTnhVvLYVnRJMvgW5yB6iPg7IScispGglbsnPQ7ZUT11XnLjDTZzoIDbeoq5qJUgiThz6GxDIlzyBsshrS/1ZtBLeNUPAtPtn031lsWtxTyo8fRTUsHyV8NEGcHegDGx95bIblrRyThpw18Kmd36lwzJFx7SrKDAaYQKrFgL91JDTOrsaKZeVBZH4AJyNSeNW/3EXFirzA00SjSURZSjfn8dXtpKNzQ/lm3hA6KM+9lCzTQhflIbebI8G6H+Zs745KGkZUFrnfo28UgM8jecywsqQRhTTmWNztVaSWmMnBCaatvcPVXqnTq8qYhon2x3t/lA9o/SSkEGT8xae6SSZKnp3kfpnPNZ6/QW09ZnWRZGQsNlaPjVpjgpDL3Dn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(6506007)(44832011)(7416002)(5660300002)(6916009)(66476007)(66556008)(4326008)(316002)(66946007)(478600001)(8676002)(8936002)(2906002)(41300700001)(6486002)(33716001)(53546011)(86362001)(9686003)(186003)(6512007)(26005)(82960400001)(6666004)(38100700002)(83380400001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0RQUHdHbC9ESFE3RFd4RU9lWXUzc2RBVVllOHBXYTFub1BNVTJleENWbCtZ?=
 =?utf-8?B?ZmNYTjBJVkdiekxJaXRPZThCWXdrNTRJU016UjJuc1RHNURFdGdtM0pJM3ls?=
 =?utf-8?B?dFhGL0N2WTlIam9vOC9HNGtmWlhyV2JDVUJvZTJ3cGdiNDc3NUY1UjErY3ZF?=
 =?utf-8?B?V1U4UmJIaGtqc1paSmVLWlVYZU1OTG9uOWZIUDYzWktPR2RaK2V5YXlYZUc3?=
 =?utf-8?B?ZFNJbER0UHdLN2ZWbE9EOHplSnJucnhlRTgreTNuOUc5c2hsZnc1UWlYKzhV?=
 =?utf-8?B?WnluSzZUZ3JQSHl6UkNudUhlV1oyYlp2MENvZUdGeHRUZ3dlelJYbnVFd3RU?=
 =?utf-8?B?QUdKYTU4TDFicnVsVGVHZDhNQXJYZHRtbW9VTXUxYmZoQ2lhVThzQko1NXBq?=
 =?utf-8?B?dHRPNk9kTlp2QXA3cE50ait3cTI2dzVRRnlPUlhhYktNQ1lDMmwzSXJwbDJw?=
 =?utf-8?B?a25Pb3FVekdTc1AxSXZyY2FSWUVvYTB5WTkyQTFlS2ZxR2hYd2hxOHo2RlVk?=
 =?utf-8?B?UWswOE9iMkVzZm1pb2J5ZU44b2lLRXFzb2JidDRtam05a1g0T2FrRjR5SGlx?=
 =?utf-8?B?dFFXWnJGekJzMlJJdy9LaUF2dkRXUi9ySzB2VnpaYURZdVNLSFRoeFZvTTlq?=
 =?utf-8?B?Uk0wSnVwRUxIaXhDcnVneXlzME9BZDM5eEFyRU5sRi9KMjBKcnNYSm9YYWYv?=
 =?utf-8?B?SE9UTlBIVHJoSzM4U2N2Z3VUMkdDTmxPaUFjQlZJL3JSUEtGVlNyeVFJWm1n?=
 =?utf-8?B?L1lLVW9lb1FXN1V1ZWJndkNMYjRTVUluQll1WWpob3FLSDk4b3dHbmR1NTR0?=
 =?utf-8?B?cDhVMjdCYmZ0MVkzb2JCZUJxRnJaZWdhSnByTk1iSzFnVnVDRXA4S1V5cEdz?=
 =?utf-8?B?WkVvUmx1dFZ5cW1aa280VHIwZTdVOUozRE5GMW5TcHdZTXFaRWRucWxnU3h3?=
 =?utf-8?B?dmZTU2dPMEFtOUdHZVRSMnh4c1h4d3BLbEszbU5RTWQ2YVZwMWtMbTBNcEVk?=
 =?utf-8?B?MkNZSm1iZFREbHFWVDV3dkpOemhyL0xJNXlmSGRHM1NnNWRPS2dHWFZZOHVp?=
 =?utf-8?B?VXBDTjkzcmt3enNaN3RwanVHR2RrRk04V3VLcy9VVnFnTHYxeHpnc00rNy9C?=
 =?utf-8?B?YkEvMnBVUkhXSG9LbUpWZUdrOG53alhnYklvMmtRY1JMR25LK01MQVErSTVa?=
 =?utf-8?B?dHRZUW5zQ2lDR08zOExtdFdWUDNWNzNyUXQ1QitkQkxLNnhZS1YybTkzL3ZM?=
 =?utf-8?B?dlZiNE5zYVcveDl0WjFpd2VUTmpNQ2dRMDEwZXp4bEl1aTRhMVY5SFBkZU1z?=
 =?utf-8?B?Q1UyTmlxK3loL0NYTWFmQVZ5eTlCZ3JhRHFBSmp3YVVlRnZERUdVaHlFam5E?=
 =?utf-8?B?cVZFRkZkRWRsR2h4RXVheFZVUjdISjJrWnNFRTQraW14UHJqU2RvdlhOellG?=
 =?utf-8?B?TUhyY0g0RUp6Nzk1ZTFna0lKa1o5VkhtMTA3M3AvUVl0Z1pVNFFlUHE4QTFJ?=
 =?utf-8?B?eWNXRklNLzlNeGtYRGpVN21rRlFURmdYbjlqZmxNNjRZOW15TElaelNHMEVs?=
 =?utf-8?B?dnZNWWtqemtyeGxlWUpZNkhQdzZhQVZPb2NsZ2JLcFFRck1ZTzVCcVp0RVAw?=
 =?utf-8?B?T3dEYnc4Uk5mYldVbncrd3pHa3RjZFdudVJmUkNTcjdST1d4YlgxUVM5RmQ2?=
 =?utf-8?B?SGJoODdQWkNlRnNHeTUrSDd0V0ROelB0eUZrRndjQVYvVDhVU2g3RURrZUpt?=
 =?utf-8?B?bVh5YUNtdlpFRFA5cWtRQlhDcVRYajlPTEprYzNCakZoYVB1eTlnMkk5S1p4?=
 =?utf-8?B?QUFFdWN0OGVad2Nibytya2d1VXNJdU5GUkduaTl5S3BkdzJiZHJVd2Y1SFFJ?=
 =?utf-8?B?cGMzSlVQeTRNV2djMkpGbmdPTC9lMXpFQU5lU0JSS205UE1rdHNJV1NJeEdt?=
 =?utf-8?B?V21YcDNXZWoxWXNWOEVNRE9lQlVDTHlRaWFrWUErT3BUaGZkRThkVmtLTWxD?=
 =?utf-8?B?UFpBZVhPdnRoanhVOEFzaUVsbHhKSzU4SXNFbzNScVBBdG1hb0IwMjYycmhV?=
 =?utf-8?B?Wm52clpFdjl4Vm02M204YnErOFkxb0VCa2Y5djdjL253SjVTSkJ6QmJIVS8y?=
 =?utf-8?B?QlV0MVNBWVZ6TWk1SmFEUlEzT0UxZG53K0RXb0s1SU1ZOEVPbjdHR21TcXRi?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb0b7f3-9ced-4de0-566a-08db771ca86b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 14:41:57.2938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK6zNHyBlBlaWyAbm60LvwhrZfIdAOtGr9ByJ5o6/4JkphuS2UcC5rI/CBCoxgrka/IuvaF61hpv4Lw1zjVJIe2jxHEPtS87A8aEtN+VKaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 27, 2023 at 03:40:04PM +0200, Moritz Fischer wrote:
> Hi Andrew,
> 
> On Tue, Jun 27, 2023 at 3:07 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > +static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
> > >
> > > adapter is not used in readx_poll_timeout_atomic() call, right?
> > > can be removed.
> >
> > I thought that when i first looked at an earlier version of this
> > patch. But LAN743X_CSR_READ_OP is not what you think :-(
> 
> Yeah, it's not great / confusing. I tried to keep it the same as the
> rest of the file when fixing the bug.

Ahh bummer. Additionally from the first sight @data looked like being used
uninited, I thought I haven't got fooled here :)

Side note would be that I don't see much value in iopoll.h's macros
returning

	(cond) ? 0 : -ETIMEDOUT; \

this could be just !!cond but given the count of the callsites...probably
better to leave it as is.

> 
> I can see if I can clean it up across the file in a follow up.
> >
> >        Andrew
> 
> Do you want me to send a v4 with an updated commit message?

From my POV I don't think it's worth it...

> 
> Thanks,
> Moritz
