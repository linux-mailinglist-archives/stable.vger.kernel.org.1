Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9E6FA134
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjEHHks (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 03:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjEHHkr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 03:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13E5B96
        for <stable@vger.kernel.org>; Mon,  8 May 2023 00:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0586A62021
        for <stable@vger.kernel.org>; Mon,  8 May 2023 07:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F0C433EF;
        Mon,  8 May 2023 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683531645;
        bh=FdrIe+IdnTMkiyAKhDQac0+m0ZsjWRkv6OTYro5g5tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVs61uJ4WqDy9nYFOYBcY/N7U38uNV/rfMggXwW0q9wzbBUSnx2HeVez9vOR50Vtk
         IflfraaqaQLpYIpOrbxrWjszY1qT23J5XGXprahGNpqK0bIcTMriyIwIDiSHgJoeIm
         ZODXEmu/0cfuZKR2K2Ly0AgsJH87295+4Fe8mTmE=
Date:   Mon, 8 May 2023 09:40:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Rai, Anjali" <anjali.rai@intel.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Gandhi, Jinen" <jinen.gandhi@intel.com>,
        "Qin, Kailun" <kailun.qin@intel.com>
Subject: Re: Regression Issue
Message-ID: <2023050851-trapper-preshow-2e4c@gregkh>
References: <DM4PR11MB55183E4B87078E0F496386029A719@DM4PR11MB5518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB55183E4B87078E0F496386029A719@DM4PR11MB5518.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023 at 07:33:58AM +0000, Rai, Anjali wrote:
> Hi
> 
> We have one test which test the functionality of "using the same loopback address and port for both IPV6 and IPV4", The test should result in EADDRINUSE for binding IPv4 to same port, but it was successful
> 
> Test Description:
> The test creates sockets for both IPv4 and IPv6, and forces IPV6 to listen for both IPV4 and IPV6 connections; this in turn makes binding another (IPV4) socket on the same port meaningless and results in -EADDRINUSE
> 
> Our systems had Kernel v6.0.9 and the test was successfully executing, we recently upgraded our systems to v6.2, and we saw this as a failure. The systems which are not upgraded, there it is still passing.
> 
> We don't exactly at which point this test broke, but our assumption is https://github.com/torvalds/linux/commit/28044fc1d4953b07acec0da4d2fc4784c57ea6fb

Is there a specific reason you did not add cc: for the authors of that
commit?

> Can you please check on your end whether this is an actual regression of a feature request.

If you revert that commit, does it resolve the issue?  Have you worked
with the Intel networking developers to help debug this further?

thanks,

greg k-h
