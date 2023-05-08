Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE616FB6C1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEHTbn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 15:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHTbm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 15:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A6D59C1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 12:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46795617ED
        for <stable@vger.kernel.org>; Mon,  8 May 2023 19:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57451C433EF;
        Mon,  8 May 2023 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683574299;
        bh=ExRISVDr1K/0HWPIFK891BNriyNmHm2JbnQTSgzT60g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ih6hkwv0imCLFPVdHSzwIBVhby/5mKzhMHy8QZv1VyQa5W6CxnBa96892V3z5YHvY
         oc3ROMyRwG47Uc7ZoS0zHTTnGIRf88APg2U6QFdL9W1D5e5LXAypeC1VYkyAJ26WL1
         fovlEbcZ2a8YMkrSVlAEIvOXUb3Njh3uaCjlgRXthxyZhP6eJUhPTD5+EgJMAnaQcV
         VAIrosQHUEGNeCFWzkqImGTsNYVUoMz36jxcCZPeIbH0MTzeodRTbOr7aQS1LmmyT0
         RlB+YYBzj2DYzW/u6K6zkoVbQ/ctsMLgwVsg9ptN8oEjUgRVXDziKcLa1ALqpZk7+L
         T0sV3380glgRg==
Date:   Mon, 8 May 2023 12:31:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Rai, Anjali" <anjali.rai@intel.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Gandhi, Jinen" <jinen.gandhi@intel.com>,
        "Qin, Kailun" <kailun.qin@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Regression Issue
Message-ID: <20230508123138.41b5dc48@kernel.org>
In-Reply-To: <DM4PR11MB5518B5489BB5F01988D22CE99A719@DM4PR11MB5518.namprd11.prod.outlook.com>
References: <DM4PR11MB55183E4B87078E0F496386029A719@DM4PR11MB5518.namprd11.prod.outlook.com>
        <2023050851-trapper-preshow-2e4c@gregkh>
        <DM4PR11MB55188D8CAB2EBB47E44404359A719@DM4PR11MB5518.namprd11.prod.outlook.com>
        <DM4PR11MB5518B5489BB5F01988D22CE99A719@DM4PR11MB5518.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 8 May 2023 08:27:49 +0000 Rai, Anjali wrote:
> On Mon, May 08, 2023 at 07:33:58AM +0000, Rai, Anjali wrote:
>>> > We have one test which test the functionality of "using the same 
>>> > loopback address and port for both IPV6 and IPV4", The test should 
>>> > result in EADDRINUSE for binding IPv4 to same port, but it was 
>>> > successful
>>> > 
>>> > Test Description:
>>> > The test creates sockets for both IPv4 and IPv6, and forces IPV6 to 
>>> > listen for both IPV4 and IPV6 connections; this in turn makes binding 
>>> > another (IPV4) socket on the same port meaningless and results in 
>>> > -EADDRINUSE
>>> > 
>>> > Our systems had Kernel v6.0.9 and the test was successfully executing, we recently upgraded our systems to v6.2, and we saw this as a failure. The systems which are not upgraded, there it is still passing.
>>> > 
>>> > We don't exactly at which point this test broke, but our assumption is
>>> > https://github.com/torvalds/linux/commit/28044fc1d4953b07acec0da4d2fc4
>>> > 784c57ea6fb  
>>> 
>>> Is there a specific reason you did not add cc: for the authors of that commit?
>>> 
>>> > Can you please check on your end whether this is an actual regression of a feature request.  
>>>
>>> If you revert that commit, does it resolve the issue?  Have you worked with the Intel networking developers to help debug this further?

> > I am part of Gramine OpenSource Project, I don't know someone from
> > Intel Networking developers team, if you know someone, please feel
> > free to add them.
> > 
> > Building completely linux source code and trying with different
> > commits, I will not be able to do it today, I can check that may be
> > tomorrow or day after. 
>
> The C code was passing earlier, and output was " test completed
> successfully" but now with v6.2 it is failing and returning
> "bind(ipv4) was successful even though there is no IPV6_V6ONLY on
> same port\n"

Adding the mailing list and the experts. Cleaning up the quoting,
please don't top post going forward.

Kuniyuki, have we seen this before?
