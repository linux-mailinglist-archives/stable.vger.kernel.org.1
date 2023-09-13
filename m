Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371AC79E128
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbjIMHut (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbjIMHus (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 03:50:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCD51989
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 00:50:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE575C433C8;
        Wed, 13 Sep 2023 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694591444;
        bh=hT9ebVVTX9pIyrwff79o+LTLmItl9r44X/ofPxV0sAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTwLaOfcoHoJ9YyynTokpF123CXmffMd2f4anSsZFrmHwH6pIn7GXBOtfy7zFqXvz
         DEfFScteRlsCxvmQJlf9pD7HxA2SVOLFKeK5m4S5xcFipYIBuq+n7DlIvjwtdls8pg
         d7my3y41Y944etg7n4fhPWIaFwMV+o9L6bkX6trU=
Date:   Wed, 13 Sep 2023 09:50:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     stable@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 5.15 052/107] Remove DECnet support from kernel
Message-ID: <2023091326-staring-joystick-9e73@gregkh>
References: <20230619102141.541044823@linuxfoundation.org>
 <20230619102143.987013167@linuxfoundation.org>
 <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
 <2023091117-unripe-ceremony-c29a@gregkh>
 <1be4b005-edfe-5faa-4907-f1e9738cc43a@molgen.mpg.de>
 <2023091210-irritably-bottle-84cd@gregkh>
 <b5a6233e-be87-0872-9ff9-bba3b9108314@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a6233e-be87-0872-9ff9-bba3b9108314@molgen.mpg.de>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 09:40:34AM +0200, Donald Buczek wrote:
> On 9/12/23 10:15 AM, Greg Kroah-Hartman wrote:
> > On Tue, Sep 12, 2023 at 09:47:40AM +0200, Donald Buczek wrote:
> >> On 9/11/23 15:54, Greg Kroah-Hartman wrote:
> >>> We have never guaranteed that Kconfig options will never change in
> >>> stable kernel releases, sorry.
> >>
> >> I didn't want to imply that and I don't expect it.
> >>
> >> It's just _if_ stable really gradually opens up to anything (like code
> >> removals, backports of new features, heuristically or AI selected
> >> patches, performance patches) it IMO loses its function and we could
> >> as well follow mainline, which, I think, is what you are recommending
> >> anyway.
> > 
> > When code is removed from stable kernel versions, it is usually for very
> > good reasons, like what happened here.  Sorry I can't go into details,
> > but you really wanted this out of your kernel, this was a bugfix :)
> 
> Thanks. I understand that this topic can not be discussed and take your word.
> 
> >> We've had bad surprises with more or less every mainline releases
> >> while updates in a stable series could be trusted to go 99% without
> >> thinking. Keeping productions systems on some latest stable gave us
> >> the time to identifying and fix problems with newer series before
> >> making it the designated series for all systems. This worked well.
> >>
> >> If the policy of stable gradually changes, that's tough luck for us. I
> >> wouldn't complain but it would be good to know. And maybe
> >> Documentation/process/stable-kernel-rules.rs should be reviewed.
> > 
> > If the policy changes, we will change that document, but for now, we are
> > backporting only bugfixes that are found through explicit tagging,
> > developer requests, manual patch review, and "compare this commit to
> > past commits that were accepted" matching which then gets manual review.
> 
> Hmmmm, okay. For an apparent counter-example, just yesterday we had to learn about 4921792e04f2125b ("drm/amdgpu: install stub fence into potential unused fence pointers") [1] the hard way [2].
> 
> [1]: https://lore.kernel.org/stable/20230724012419.2317649-13-sashal@kernel.org/t/#u
> [2]: https://gitlab.freedesktop.org/drm/amd/-/issues/2820#note_2080918

Bugs happen, testing is best, we are just human and we can never claim
nothing will ever break at any point in time.

All we can do is fix things as quick as possible, which is what we try
to do.

> Does "compare this commit to past commits that were accepted" include anything AUTOSELected?

That is what the AUTOSEL patches are, that marking is to show this is
how they were chosen.  There's a bunch of papers and presentations on
how that process works over many years if you are curious about the
details.

thanks,

greg k-h
