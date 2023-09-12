Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8343879C98D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjILIPg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 04:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjILIP0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 04:15:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E410C3
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 01:15:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D85C433C8;
        Tue, 12 Sep 2023 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694506521;
        bh=H+7L0I/t4we003ZgFkfZhvCJbbS8rbPE3wprlcWqQy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pg1BT/lVKzjZjlsT7YjQzd3bfSH1ZKCxY62nCgzo12PFzAJT48imtcRPjl3HHFWC5
         V4Qn0ca2z7+y8byAOamJGWaK25F2YJ5/bY8iIStqbU0TYfHZHZGf1710/S/SoBe4Y5
         F6TFXwaNhlMB62p+BT9vYDpP70OSvDXZXzEUfJyA=
Date:   Tue, 12 Sep 2023 10:15:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     stable@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 5.15 052/107] Remove DECnet support from kernel
Message-ID: <2023091210-irritably-bottle-84cd@gregkh>
References: <20230619102141.541044823@linuxfoundation.org>
 <20230619102143.987013167@linuxfoundation.org>
 <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
 <2023091117-unripe-ceremony-c29a@gregkh>
 <1be4b005-edfe-5faa-4907-f1e9738cc43a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be4b005-edfe-5faa-4907-f1e9738cc43a@molgen.mpg.de>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 12, 2023 at 09:47:40AM +0200, Donald Buczek wrote:
> On 9/11/23 15:54, Greg Kroah-Hartman wrote:
> > We have never guaranteed that Kconfig options will never change in
> > stable kernel releases, sorry.
> 
> I didn't want to imply that and I don't expect it.
> 
> It's just _if_ stable really gradually opens up to anything (like code
> removals, backports of new features, heuristically or AI selected
> patches, performance patches) it IMO loses its function and we could
> as well follow mainline, which, I think, is what you are recommending
> anyway.

When code is removed from stable kernel versions, it is usually for very
good reasons, like what happened here.  Sorry I can't go into details,
but you really wanted this out of your kernel, this was a bugfix :)

> We've had bad surprises with more or less every mainline releases
> while updates in a stable series could be trusted to go 99% without
> thinking. Keeping productions systems on some latest stable gave us
> the time to identifying and fix problems with newer series before
> making it the designated series for all systems. This worked well.
> 
> If the policy of stable gradually changes, that's tough luck for us. I
> wouldn't complain but it would be good to know. And maybe
> Documentation/process/stable-kernel-rules.rs should be reviewed.

If the policy changes, we will change that document, but for now, we are
backporting only bugfixes that are found through explicit tagging,
developer requests, manual patch review, and "compare this commit to
past commits that were accepted" matching which then gets manual review.

thanks,

greg k-h
