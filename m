Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679A57D10C3
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377438AbjJTNtM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377465AbjJTNtL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 09:49:11 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817E19E
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697809750; x=1729345750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lYoVJNG/jLLF0SKjpb0a90IhMjtoQIrfsmFMAm0CwaM=;
  b=vOgj69n6EnIbOmZYB27h40wGv8outX+t4SmIV46BynGNOii2n3r/JHQS
   XbpCMYwslYHn0qDbD6UsC9s7pxhbu8dBSWbb+z73arEEQ9lfH35/wd93w
   w1rjX1leKF3TjAKe2CG/SBPMKAeAV4kS6AkKujZpo/aem82tXyUCOKmvX
   8=;
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="614588374"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 13:49:08 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id 3880040D7B;
        Fri, 20 Oct 2023 13:49:07 +0000 (UTC)
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:64021]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.46.70:2525] with esmtp (Farcaster)
 id 3c7c6292-7688-4bfd-a3df-cbf7da26f069; Fri, 20 Oct 2023 13:49:06 +0000 (UTC)
X-Farcaster-Flow-ID: 3c7c6292-7688-4bfd-a3df-cbf7da26f069
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 20 Oct 2023 13:49:06 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 20 Oct 2023 13:49:06 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Fri, 20 Oct 2023 13:49:06 +0000
Received: by dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (Postfix, from userid 23276196)
        id 1131CA3D; Fri, 20 Oct 2023 13:49:06 +0000 (UTC)
Date:   Fri, 20 Oct 2023 13:49:06 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [6.1] Please apply cc6003916ed46d7a67d91ee32de0f9138047d55f
Message-ID: <20231020134905.GB33555@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
References: <97397e8d-f447-4cf7-84a1-070989d0a7fd@amazon.com>
 <CAB=+i9SvjjUBUvPmQm_cEGo4OKXtkj72HnUXLhsGd4FTk4QzSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=+i9SvjjUBUvPmQm_cEGo4OKXtkj72HnUXLhsGd4FTk4QzSw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 11:46:36AM +0900, Hyeonggon Yoo wrote:

> On Fri, Oct 20, 2023 at 10:27 AM Luiz Capitulino <luizcap@amazon.com> wrote:
> >
> > Hi,
> >
> > As reported before[1], we found another regression in 6.1 when doing
> > performance comparisons with 5.10. This one is caused by CONFIG_DEBUG_PREEMPT
> > being enabled by default by the following upstream commit if you have the
> > right config dependencies enabled (commit is introduced in v5.16-rc1):
> >
> > """
> > commit c597bfddc9e9e8a63817252b67c3ca0e544ace26
> > Author: Frederic Weisbecker <frederic@kernel.org>
> > Date: Tue Sep 14 12:31:34 2021 +0200
> >
> > sched: Provide Kconfig support for default dynamic preempt mode
> > """
> >
> > We found up to 8% performance improvement with CONFIG_DEBUG_PREEMPT
> > disabled in different perf benchmarks (including UnixBench process
> > creation and redis). The root cause is explained in the commit log
> > below which is merged in 6.3 and applies (almost) clealy on 6.1.59.
> 
> Oh, I should've sent it to the stable. Thanks for sending it!

Thanks for doing the original fix! :)

> Yes, DEBUG_PREEMPT was unintentionally enabled after the introduction
> of PREEMPT_DYNAMIC. It was already enabled by default for PREEMPTION=y kernels
> but PREEMPT_DYNAMIC always enables PREEMPT_BUILD (and hence PREEMPTION)
> so distros that were using PREEMPT_VOLUNTARY are silently affected by that.
> 
> It looks appropriate to be backported to the stable tree (to me).
> Hmm but I think it should be backported to 5.15 too?

Yeah, I see that Greg applied it to 5.15 and 5.10 as well.

I posted it only for 6.1 because the worst case seems to happen after
c597bfddc9 where CONFIG_DEBUG_PREEMPT may be enabled automatically.
But having the fix in earlier kernels is certainly good as well.

- Luiz

> 
> > """
> > commit cc6003916ed46d7a67d91ee32de0f9138047d55f
> > Author: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Date:   Sat Jan 21 12:39:42 2023 +0900
> >
> >      lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default
> >
> >      In workloads where this_cpu operations are frequently performed,
> >      enabling DEBUG_PREEMPT may result in significant increase in
> >      runtime overhead due to frequent invocation of
> >      __this_cpu_preempt_check() function.
> >
> >      This can be demonstrated through benchmarks such as hackbench where this
> >      configuration results in a 10% reduction in performance, primarily due to
> >      the added overhead within memcg charging path.
> > """
> >
> > [1] https://lore.kernel.org/stable/010edf5a-453d-4c98-9c07-12e75d3f983c@amazon.com/
