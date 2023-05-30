Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB24B71551E
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 07:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjE3FnN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjE3Fmu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 01:42:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58054AB
        for <stable@vger.kernel.org>; Mon, 29 May 2023 22:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425310; x=1716961310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPj4Z7sd1o1bKz89No0hETgI2Zw/3nGYeLlMfAEwpKs=;
  b=TmMMe843njamdtmfJ0//3Xvj4t4RjAa90FbYn9wSOTpNLNJ2kfzpjqQN
   Ce69V6zYTJrc1p2qNiW17RyUB93Rlu0b+kjr4dxZ0xFIY8UxGOMjXHC7u
   r3URMHnso2KTI3nrpr0w0sv9KFDRFoiafp+QGr91AsCKLygDw9aHNiPAE
   5qJC+xY+5C8KafGDLtlB/+L9/l/k4j6Vn0+VSsSQ/e6IINpEbOiU4R4CA
   NWeJpDNc2lMkyRudSWbzv9k83CqdPysgDGSjb7+qzd2dyJB+gnryz3v9r
   Gs3L7vb840IZxZLCeeai2X84Aty1vW0ampsyvOehTDDp4VcqqD9W/Z0xA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="352322955"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="352322955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700478394"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="700478394"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 May 2023 22:41:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C3F904BA; Tue, 30 May 2023 08:41:26 +0300 (EEST)
Date:   Tue, 30 May 2023 08:41:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     beld zhang <beldzhang@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Message-ID: <20230530054126.GA45886@black.fi.intel.com>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
 <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <20230529113813.GZ45886@black.fi.intel.com>
 <CAG7aomVpsyOktPFNAURYF9o32CnZST=49BPBRDRH2w7raLbQ7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG7aomVpsyOktPFNAURYF9o32CnZST=49BPBRDRH2w7raLbQ7g@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Mon, May 29, 2023 at 02:40:26PM -0400, beld zhang wrote:
> both
> # rmmod thunderbolt
> # modprobe thunderbolt
> makes many crash logs on my hardware.
> 
> try to patch this to 6.1.30 and 6.4-rc4 but are all failed.

You mean patching fails or the patch does not solve the issue at hand?

I managed to boot my test system today and with the patch I don't see
the issue anymore.

> how about continue this on the kernel bugzilla, and post a patch here
> after it is resolved as Greg said ?

Sure works for me.
