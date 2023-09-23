Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062237AC37C
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjIWQK0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjIWQK0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 12:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885992
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 09:10:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628C4C433C7;
        Sat, 23 Sep 2023 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695485418;
        bh=BWTTgEfn5uky8+Y7kn4tVruCzhEK9kG71fFGrXDYlgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdIKRv5zcVOancQXrAXfxVVJAagRWL7GAgAbcN3ET4owjjdUG49ru2xc1entn0Wh8
         nOarVbxernEMrQ/tmmPXSSl60iqkRooyCW99/MN5i3VFzAcH9KLJmNTrnP+OMpX0tH
         ywBU9pXH+FIzxjPPQhaWQ5eGfZ904DmIMsj/s9OQ=
Date:   Sat, 23 Sep 2023 18:10:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Stephen Zhang <starzhangzsd@gmail.com>, stable@vger.kernel.org,
        Shida Zhang <zhangshida@kylinos.cn>, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: fix rec_len verify error
Message-ID: <2023092314-cartel-percolate-eee7@gregkh>
References: <2023092055-disband-unveiling-f6cc@gregkh>
 <20230922025458.2169511-1-zhangshida@kylinos.cn>
 <2023092205-ending-subzero-9778@gregkh>
 <CANubcdVYCFS=UAKX6sfe=jpZCtipDBrxi_O4=RpsAr1LY4Z1BQ@mail.gmail.com>
 <ZQ76gdIz80G8Svt-@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ76gdIz80G8Svt-@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 23, 2023 at 10:47:29AM -0400, Theodore Ts'o wrote:
> On Sat, Sep 23, 2023 at 05:41:19PM +0800, Stephen Zhang wrote:
> > Apologies for this confusion. It appears that the '--subject-prefix' option
> > of the 'git send-email' command does not work with the local patch file.
> 
> Stephen,
> 
> The --subject-prefix option applies to "git format-patch" when the
> local patch file is generated, as opposed to "git send-email".  So my
> general workflow is to run "rm -rf /tmp/p ; git format-patch -o /tmp/p
> ..."  and then examine the files in /tmp/p, and then if they look
> good, run "git send-email /tmp/p/*".
> 
> I suspect it will be easier for Greg if you were to simply regenerate
> the patches with the proper subject prefix, and then resend them,
> since he has automation tools that can handle parsing the subject
> line, which scripts can do much more easily than to disentangling the
> "In-Reply-To" header to identify e-mail chains, and then parsing
> human/natural language to figure out which git tree the patches should
> be applied to.  :-)

Just a hint, I can usually NOT see the In-Reply-To headers at all, as
the email it was in response to is long gone from my system.

Which is why, the description of how to fix up a patch for the stable
tree that has failed to apply there, tells you how to do this in a way
that will show the proper version number.

If only anyone would actually read the emails we sent with the helpful
text, here's one example for a DRM patch that failed to apply:

	To reproduce the conflict and resubmit, you may use the following commands:

	git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
	git checkout FETCH_HEAD
	git cherry-pick -x ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a
	# <resolve conflicts, build, test, etc.>
	git commit -s
	git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023092029-banter-truth-cf72@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

thanks,

greg k-h
