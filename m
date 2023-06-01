Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A973471F03E
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFARFz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 13:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjFARFy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 13:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2D3E5B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 10:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7FAC64800
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 17:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C46C433EF;
        Thu,  1 Jun 2023 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685639132;
        bh=OM4m100qrqBkXQ4IEWPCQXAOaEzcwDXfKHJHaN8hDJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUMcksZKzgbv+shjrmx7dzNmRzfLbNT6q391/Lt8RHctF+l10zErmloz0o+GtevhN
         piPODyQ7aHO99/jozrDVJvSzDfiCmNyJxEAcVbuHW3oWiEBmoyyiEZzPNmD+uZrvdK
         NCweqCJGfft1TMFIUDrULp6ik5eLy77BnyfDOH8E=
Date:   Thu, 1 Jun 2023 18:05:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     Paul Moore <paul@paul-moore.com>, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: Possible build time regression affecting stable kernels
Message-ID: <2023060120-monopoly-math-3bc5@gregkh>
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
 <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com>
 <bb1e18f8-9d31-1ec7-d69a-2d1f5af31310@amazon.com>
 <CAHC9VhTFzN_Y_7HBroJnbTHL2NZEYjFy9BB3JJJBKnwv_k25dw@mail.gmail.com>
 <d2b14172-7aeb-be98-ded2-b4ce255dccaf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2b14172-7aeb-be98-ded2-b4ce255dccaf@amazon.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 11:50:16AM -0400, Luiz Capitulino wrote:
> 
> 
> On 2023-06-01 11:45, Paul Moore wrote:
> 
> > 
> > 
> > 
> > On Thu, Jun 1, 2023 at 11:03 AM Luiz Capitulino <luizcap@amazon.com> wrote:
> > > On 2023-06-01 10:27, Paul Moore wrote:
> > > > On Wed, May 31, 2023 at 10:13 PM Luiz Capitulino <luizcap@amazon.com> wrote:
> > > > > 
> > > > > Hi Paul,
> > > > > 
> > > > > A number of stable kernels recently backported this upstream commit:
> > > > > 
> > > > > """
> > > > > commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
> > > > > Author: Paul Moore <paul@paul-moore.com>
> > > > > Date:   Wed Apr 12 13:29:11 2023 -0400
> > > > > 
> > > > >        selinux: ensure av_permissions.h is built when needed
> > > > > """
> > > > > 
> > > > > We're seeing a build issue with this commit where the "crash" tool will fail
> > > > > to start, it complains that the vmlinux image and /proc/version don't match.
> > > > > 
> > > > > A minimum reproducer would be having "make" version before 4.3 and building
> > > > > the kernel with:
> > > > > 
> > > > > $ make bzImages
> > > > > $ make modules
> > > > 
> > > > ...
> > > > 
> > > > > This only happens with commit 4ce1f694eb5 applied and older "make", in my case I
> > > > > have "make" version 3.82.
> > > > > 
> > > > > If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical strings (except
> > > > > for the "Linux version" part):
> > > > 
> > > > Thanks Luiz, this is a fun one :/
> > > 
> > > It was a fun to debug TBH :-)
> > > 
> > > > Based on a quick search, it looks like the grouped target may be the
> > > > cause, especially for older (pre-4.3) versions of make.  Looking
> > > > through the rest of the kernel I don't see any other grouped targets,
> > > > and in fact the top level Makefile even mentions holding off on using
> > > > grouped targets until make v4.3 is common/required.
> > > 
> > > Exactly.
> > > 
> > > > I don't have an older userspace immediately available, would you mind
> > > > trying the fix/patch below to see if it resolves the problem on your
> > > > system?  It's a cut-n-paste so the patch may not apply directly, but
> > > > it basically just removes the '&' from the make rule, turning it into
> > > > an old-fashioned non-grouped target.
> > > 
> > > I tried the attached patch on top of latest Linus tree (ac2263b588dffd),
> > > but unfortunately I got the same issue which is puzzling. Reverting
> > > 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5 does solve the issue though.
> > 
> > I'm at a bit of a loss here ... the only thing that seems to jump out
> > is that the genheaders tool is run twice without the grouped target
> > approach, but with both runs happening at the same point in the build
> > and the second run updating both header files, I'm a bit at a loss as
> > to why this would be problematic.
> > 
> > I don't want to block on fixing the kernel build while I keep chasing
> > some esoteric build behavior so I'm just going to revert the patch
> > with a note to revisit this when we require make >= 4.3.
> > 
> > Regardless, thanks for the report and the help testing, expect a
> > patch/revert shortly ...
> 
> Thank you Paul, I really appreciate your fast response. I'd also
> appreciate if you CC me in the revert patch so that I don't loose
> track of it.

And please add a cc: stable@ to it too :)
