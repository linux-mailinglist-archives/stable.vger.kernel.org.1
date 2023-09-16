Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40C7A2FC1
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbjIPLl5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbjIPLlm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:41:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F9CC9
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:41:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B976C433C9;
        Sat, 16 Sep 2023 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864495;
        bh=gVgH+ZGSVNC0Q1+KP/e3ynmqQl9xDc6CPJs+OmaDlT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpGXYZ+BiJ2wCeVpMOkVtSuDKd6RJuUt6zPqBQWjy3pkvV1N5ZRkHQcLjcMpv4SiK
         wWFypGrjs/HedueSenlo3sTYQfwMH6xFrNd6rPAr1rwiC0sb88lCOlfe8spfUpN3qL
         DdYav/9oHjMP3FSyBRckKUKULtCVYPcZof+ksgOQ=
Date:   Sat, 16 Sep 2023 13:41:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: wild pointer access in rsvp classifer in the Linux kernel <= v6.2
Message-ID: <2023091612-fretful-premium-b38d@gregkh>
References: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
 <2023090826-rabid-cabdriver-37d8@gregkh>
 <ZP/SOqa0M3RvrVEF@westworld>
 <2023091320-chemist-dragonish-6874@gregkh>
 <ZQJOAAu0QvKGjDXC@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQJOAAu0QvKGjDXC@westworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 05:04:16PM -0700, Kyle Zeng wrote:
> On Wed, Sep 13, 2023 at 10:12:55AM +0200, Greg KH wrote:
> > On Mon, Sep 11, 2023 at 07:51:38PM -0700, Kyle Zeng wrote:
> > > On Fri, Sep 08, 2023 at 07:17:12AM +0100, Greg KH wrote:
> > > > Great, can you use 'git bisect' to track down the commit that fiexes
> > > > this so we can add it to the stable trees?
> > > Sorry for the late reply. I think the fix was to completely retire the
> > > rsvp classifier and the commit is:
> > > 
> > > 265b4da82dbf5df04bee5a5d46b7474b1aaf326a (net/sched: Retire rsvp classifier)
> > 
> > Great, so if we apply this change, all will work properly again?  How
> > far back should this be backported to?
> > 
> > thanks,
> > 
> > greg k-h
> 
> > Great, so if we apply this change, all will work properly again?
> Yes, after applying the patch (which is to retire the rsvp classifier),
> it is no longer possible to trigger the crash.
> However, you might want to decide whether it is OK to retire the
> classifier in stable releases.
> 
> > How far back should this be backported to?
> I tested all the stable releases today, namely, v6.1.y, v5.15.y,
> v5.10.y, v5.4.y, v4.19.y, and v4.14.y. They are all affected by this
> bug. I think the best approach is to apply the patch to all the stable
> trees.

Great, can you provide backported patches to those trees so that we can
queue this up for them?

thanks,

greg k-h
