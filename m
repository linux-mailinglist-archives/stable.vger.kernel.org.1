Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034E79823C
	for <lists+stable@lfdr.de>; Fri,  8 Sep 2023 08:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjIHGRV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 8 Sep 2023 02:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjIHGRT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 8 Sep 2023 02:17:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3366A1990
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 23:17:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8284EC433C7;
        Fri,  8 Sep 2023 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694153834;
        bh=t2rWGatZXbhn9/l2xhxt3GJLAnJ9bqlKVhAwk6yaTrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0MS6aLgx6QTorqU59ACOewpvup32AxcXY7gJ+eW9rJ3OHBCDIi1CZ5SbgjNLnDjWd
         TMAbHFpJkdRhV5EQb61XQMLcjoRCLCNW7FRzTRog1CiulBpUdU6BW1hlBpW1maoal0
         txH8LyFAzrm22Zho09OuGbq1IEIOg0GfuCMjWA9Y=
Date:   Fri, 8 Sep 2023 07:17:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: wild pointer access in rsvp classifer in the Linux kernel <= v6.2
Message-ID: <2023090826-rabid-cabdriver-37d8@gregkh>
References: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 07, 2023 at 05:01:23PM -0700, Kyle Zeng wrote:
> Hi Greg,
> 
> I recently found a bug in the rsvp traffic classifier in the Linux kernel.
> This classifier is already retired in the upstream but affects stable
> releases.
> 
> The symptom of the bug is that the kernel can be tricked into accessing a
> wild pointer, thus crash the kernel.
> 
> Since it is just a crash and cannot be used for LPE, I do not want to
> trouble security@kernel.org. And since the classifier is already
> retired in the upstream, I cannot report there.

Great, can you use 'git bisect' to track down the commit that fiexes
this so we can add it to the stable trees?

thanks,

greg k-h
