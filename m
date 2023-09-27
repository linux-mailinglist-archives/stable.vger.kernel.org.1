Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654EE7AFA9A
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 08:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjI0GEN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 02:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjI0GDn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 02:03:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01B11F
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 23:03:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328EAC433C9;
        Wed, 27 Sep 2023 06:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695794606;
        bh=TV3XZfWCNDl2xx7JI8kOnGDlx6BojC6FLH7aX8nHAvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0oYLn0j9bP2SscXIk7NoU0msPhFEl0Q0McndcRdl0S4t/OAtOdrfGdp0O4mia2T7a
         Qj8Le1dOSAIrHCdrAAeBUc9AX5cHQMbsTYoO4cBn8N8afqbhB03ukie5ijo3lXIqWO
         NrDhInpihlFaMuBMKGJCd95mh+h3lp2sI5xhlexE=
Date:   Wed, 27 Sep 2023 08:03:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shaoying Xu <shaoyi@amazon.com>
Cc:     markovicbudimir@gmail.com, stable@vger.kernel.org,
        jhs@mojatatu.com, kuba@kernel.org
Subject: Re: [PATCH 4.14] net/sched: sch_hfsc: Ensure inner classes have fsc
 curve
Message-ID: <2023092711-fiber-saddling-3586@gregkh>
References: <20230920175145.23384-1-shaoyi@amazon.com>
 <20230927032152.10448-1-shaoyi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927032152.10448-1-shaoyi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 27, 2023 at 03:21:52AM +0000, Shaoying Xu wrote:
> Hi Budimir, Greg,
> 
> Sorry to bother again with this patch but it fixes the CVE-2023-4623 and has also been backported to all stable kernels other than v4.14 so I wonder is there a reason to skip v4.14? I removed the NL_SET_ERR_MSG call because extack is not added to hfsc_change_class in 4.14 and hope to get some confirmation if it can be applied to 4.14 tree. 
> 
> Thanks,
> Shaoying
> 
> < On 2023-09-20, 10:52 AM, "Xu, Shaoying" <shaoyi@amazon.com <mailto:shaoyi@amazon.com>> wrote:

You sent this less than a week ago (by a few hours).  Please relax and
be patient for it to be processed, ESPECIALLY for such an older and
slow-moving kernel like 4.14, there should not be any real rush here,
right?

thanks,

greg k-h
