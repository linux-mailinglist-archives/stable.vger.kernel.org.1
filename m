Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481A275C3F5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGUKCd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjGUKCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 06:02:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71971715
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689933750; x=1721469750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L39xNoLTuiFqWrU9U5/rPXL0nELBWgjHwigd09/msqU=;
  b=WhYwGe9jP1F/53lZmIiUngM4C8sxWKkzSIlupbkhL6bd+/1qr266kfhN
   iiRIRIvfmNRwz525vtXq7QoIzNEqE3gEG5qPtFwte6bLI6iLpJDgMRr15
   exqB42BYjZQlYjRpaOUzoBa2ALmAnGko62fVYBVqMAiEQvp8l8zH8AhFu
   37Vpzh4USdPbpUNx/q4/xNPTVWJx6ow15hz3d8xBHV9hOmrwf0EH41ffU
   7fS0mqqYi3JLZWTfIhmc/i50P+haTA54ziIoXVNPadiqzUZ7VdRDlrJT6
   GUG5PGvdKoKA39xpxWWKHaC5ZklvlUU0c32s7MkUlyhPmc+XybPcM1G4J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346579804"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346579804"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838488706"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838488706"
Received: from hbockhor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.54.104])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:02:23 -0700
Date:   Fri, 21 Jul 2023 12:02:20 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     "Krzysztofik, Janusz" <janusz.krzysztofik@intel.com>
Cc:     "Cavitt, Jonathan" <jonathan.cavitt@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        "Das, Nirmoy" <nirmoy.das@intel.com>,
        "Hajda, Andrzej" <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        dri-evel <dri-devel@lists.freedesktop.org>
Subject: Re: [v7,2/9] drm/i915: Add the has_aux_ccs device property
Message-ID: <ZLpXrADgrQjybo0/@ashyti-mobl2.lan>
References: <20230720210737.761400-3-andi.shyti@linux.intel.com>
 <2423957.jE0xQCEvom@jkrzyszt-mobl2.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2423957.jE0xQCEvom@jkrzyszt-mobl2.ger.corp.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Janusz,

On Fri, Jul 21, 2023 at 09:25:03AM +0000, Krzysztofik, Janusz wrote:
> Hi Andy,
> 
> On Thursday, 20 July 2023 23:07:30 CEST Andi Shyti wrote:
> > We always assumed that a device might either have AUX or FLAT
> > CCS, but this is an approximation that is not always true 
> 
> If there exists a device that can have CCSs that fall into either none or both 
> of those categories then I think we should have that device or two listed here 
> as an example, regardless of deducible from the change or not.  Or if there 
> are no such devices so far, but we are going to introduce some, then I think 
> we should provide that information here.

true! I will improve the commit log.

[...]

> > --- a/drivers/gpu/drm/i915/i915_pci.c
> > +++ b/drivers/gpu/drm/i915/i915_pci.c
> > @@ -643,7 +643,8 @@ static const struct intel_device_info jsl_info = {
> >  	TGL_CACHELEVEL, \
> >  	.has_global_mocs = 1, \
> >  	.has_pxp = 1, \
> > -	.max_pat_index = 3
> > +	.max_pat_index = 3, \
> > +	.has_aux_ccs = 1
> 
> NIT: Can we please have the last element also followed by comma, like in other 
>      places (e.g. see below)?  That will simplify future patches.
> 
> Other than that, LGTM.

As Andrzej and Matt suggested I will take another approach, i.e.
adding a helper function that tells whether the aux invalidation
is necessary or not.

Thanks,
Andi
