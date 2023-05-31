Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36433717873
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjEaHl3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjEaHl2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 03:41:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B274C0
        for <stable@vger.kernel.org>; Wed, 31 May 2023 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685518886; x=1717054886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=01VuOJHSKrzhPjUg5FY6DIIXJezQ9jha7JZRnVaHrcI=;
  b=BnC2W1fspqFVBsWRcF/boY/1DT4tj7XFq4/hna7Dv17xg01RWgS0+aMP
   vIP/+niZlCqqkFyIrhCKLZzoN97vYd1GY/2eQd+NRsffqd8cD1L5clURP
   RXKfCgLlS0b2QGeBH6dqJQmMOAnyxAYKPBwsc9U6JBGn1YfnhDBMN8K1e
   e/OQ0SoGv94kz/8jAW62WG9I6YJK158ZB3zVaBfYffQz3qvLMPRuuxhVE
   1dYBxRqijxksonShTWBxUhuttCwmeydbMREK0NSwkP0hPNuAa5hLLkCw+
   ZDeT9ZuvfCfF8+wTP1dU8M37xxHMB83bui7ec1Uuq+DJoxt5dGmU2b62Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420929959"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="420929959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="771900738"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="771900738"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 May 2023 00:41:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4ACBD589; Wed, 31 May 2023 10:41:13 +0300 (EEST)
Date:   Wed, 31 May 2023 10:41:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     beld zhang <beldzhang@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: 6.1.30: thunderbolt: Clear registers properly when auto clear
 isn't in use cause call trace after resume
Message-ID: <20230531074113.GI45886@black.fi.intel.com>
References: <CAG7aomXv2KV9es2RiGwguesRnUTda-XzmeE42m0=GdpJ2qMOcg@mail.gmail.com>
 <ZHKW5NeabmfhgLbY@debian.me>
 <261a70b7-a425-faed-8cd5-7fbf807bdef7@amd.com>
 <20230529113813.GZ45886@black.fi.intel.com>
 <e37b2f7f-d204-4204-ce72-e108975c2fe0@amd.com>
 <20230530080328.GD45886@black.fi.intel.com>
 <CAG7aomWBf2k6NzJ85Qrz4LN_N=K8O0fbd0p9VSP+jm4FsRaNkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG7aomWBf2k6NzJ85Qrz4LN_N=K8O0fbd0p9VSP+jm4FsRaNkg@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 10:38:01AM -0400, beld zhang wrote:
> On Tue, May 30, 2023 at 4:03 AM Mika Westerberg wrote:
> >
> > On Mon, May 29, 2023 at 11:12:45PM -0500, Mario Limonciello wrote:
> >
> > Thanks, submitted formal patch now here:
> >
> > https://lore.kernel.org/linux-usb/20230530075555.35239-1-mika.westerberg@linux.intel.com/
> >
> > beld zhang, can you try it and see if it works on your system? It should
> > apply on top of thunderbolt.git/fixes [1]. Thanks!
> >
> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
> 
> tested fixes branch, applied patch:
>     1) boot with mouse..............: good
>     2) remove mouse then put on.....: good
>     3) rmmod / modprobe thunderbolt.: good
>     4) suspend / resume.............: good

Thanks for testing! I took the liberty to add your tested-by to the
patch. Let me know if that's not OK.
