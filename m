Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0F7CE75F
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRTJh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjJRTJg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 15:09:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AEC119
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 12:09:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D88C433C9;
        Wed, 18 Oct 2023 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697656174;
        bh=xU19FSPNYfDa/R8eFlBcqPYEGK7ETuE98UdV2M14E7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvaDpDcOGt7IGMbj0aSnBpKh339EOtEdR7g1l9HQZIVqVf/8FfWbFdZ2I9wRd3gY9
         UEvuY7jHqMSkffUpe5WtzjMy63on9ICAQN3tV6lFIvr8kHRS7x3CqgwIRl+c7CcDtC
         JnVCpQOuSQ1iRJOh6pDE6W9nhm3D11YOIJLSLu3I=
Date:   Wed, 18 Oct 2023 21:09:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Hathaway <jesse@mbuki-mvuki.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <2023101852-mundane-reoccupy-013c@gregkh>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
 <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 18, 2023 at 01:49:44PM -0500, Jesse Hathaway wrote:
> On Wed, Oct 18, 2023 at 1:40 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > Unfortunately, this has not held up in LTSes without causing
> > > regressions, specifically in crun:
> > >
> > > Crun issue and patch
> > >  1. https://github.com/containers/crun/issues/1308
> > >  2. https://github.com/containers/crun/pull/1309
> >
> > So thre's a fix already for this, they agree that symlinks shouldn't
> > have modes, so what's the issue?
> 
> The problem is that it breaks crun in Debian stable. They have fixed the
> issue in crun, but that patch may not be backported to Debian's stable
> version. In other words the patch seems to break existing software in
> the wild.

It will be backported to Debian stable if the kernel in Debian stable
has this change in it, right?  That should be simple to get accepted.

thanks,

greg k-h
