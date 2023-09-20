Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65057A7A1F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjITLK2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjITLK1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2DC2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C6BC433C7;
        Wed, 20 Sep 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695208221;
        bh=axlIbwpzk1dAc0vdLkmQDevQtESq+bT6HrbCuQY8LUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwnWW+VpQXFtHUgvaYnwVn380NPZCRD0wn9aHgz8KKSCM3oyudl7wwOz77TKcM8yo
         SMrXX9PRZDqAeLNVXqqdlSKi/jbucrsFcnq/UDyFwnsU4Y9c8wxpbiHg6h3fE7gzKh
         cVswC9imDRPVUwTLKu36LZ8Hf9aezFbtopeZB8tc=
Date:   Wed, 20 Sep 2023 13:10:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: wild pointer access in rsvp classifer in the Linux kernel <= v6.2
Message-ID: <2023092011-frustrate-staple-ed0b@gregkh>
References: <CADW8OBtkAf+nGokhD9zCFcmiebL1SM8bJp_oo=pE02BknG9qnQ@mail.gmail.com>
 <2023090826-rabid-cabdriver-37d8@gregkh>
 <ZP/SOqa0M3RvrVEF@westworld>
 <2023091320-chemist-dragonish-6874@gregkh>
 <ZQJOAAu0QvKGjDXC@westworld>
 <2023091612-fretful-premium-b38d@gregkh>
 <ZQpYloCDyc8+4Iwp@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQpYloCDyc8+4Iwp@westworld>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 19, 2023 at 07:27:34PM -0700, Kyle Zeng wrote:
> On Sat, Sep 16, 2023 at 01:41:33PM +0200, Greg KH wrote:
> > On Wed, Sep 13, 2023 at 05:04:16PM -0700, Kyle Zeng wrote:
> > > On Wed, Sep 13, 2023 at 10:12:55AM +0200, Greg KH wrote:
> > > > On Mon, Sep 11, 2023 at 07:51:38PM -0700, Kyle Zeng wrote:
> > > > > On Fri, Sep 08, 2023 at 07:17:12AM +0100, Greg KH wrote:
> > > > > > Great, can you use 'git bisect' to track down the commit that fiexes
> > > > > > this so we can add it to the stable trees?
> > > > > Sorry for the late reply. I think the fix was to completely retire the
> > > > > rsvp classifier and the commit is:
> > > > > 
> > > > > 265b4da82dbf5df04bee5a5d46b7474b1aaf326a (net/sched: Retire rsvp classifier)
> > > > 
> > > > Great, so if we apply this change, all will work properly again?  How
> > > > far back should this be backported to?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > > Great, so if we apply this change, all will work properly again?
> > > Yes, after applying the patch (which is to retire the rsvp classifier),
> > > it is no longer possible to trigger the crash.
> > > However, you might want to decide whether it is OK to retire the
> > > classifier in stable releases.
> > > 
> > > > How far back should this be backported to?
> > > I tested all the stable releases today, namely, v6.1.y, v5.15.y,
> > > v5.10.y, v5.4.y, v4.19.y, and v4.14.y. They are all affected by this
> > > bug. I think the best approach is to apply the patch to all the stable
> > > trees.
> > 
> > Great, can you provide backported patches to those trees so that we can
> > queue this up for them?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I backported the patch to all the mentioned affected versions and I used
> my poc code to make sure that the crash is no longer triggerable after
> applying the patch.
> 
> The patches are sent separately with [PATCH <version>] tags.

All now queued up, thanks for the backports.

greg k-h
