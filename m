Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E979EE63
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 18:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjIMQhL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 12:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjIMQhK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 12:37:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EADF19A7
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 09:37:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8D9C433C8;
        Wed, 13 Sep 2023 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694623026;
        bh=ZUzCVDRO233cOPqahiYDRH8AFpKEb0l/coqCJ0rZahA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCvHAGPxmp92D3mGmYCa3BZjhh03UK1RVJNutwFqDwYdogW4RtWaeKIFpy5db3dlX
         PTOrgYcE0H3KuiD+27y/j0sFmwNY9RydspD1hz7ayqqr/Alg9yph7uJSsR0x7C/vH8
         6DrgDTkDZY0UX53bZUh9NUVQ8w21XWio/MCBy3dY=
Date:   Wed, 13 Sep 2023 18:31:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Regression with raid1 in stable 5.15.132-rc1 and 6.1.53-rc1
Message-ID: <2023091310-safari-snazzy-158c@gregkh>
References: <CAMGffEmtW+95Hsmf-6sZmS76Mpdt+R6uYQKtjbLup+iX96eVfg@mail.gmail.com>
 <2023091241-ecology-greyhound-4e24@gregkh>
 <CAMGffEkSQ-d4sHL3tvDvEsf7TE4Bn7yWUraTqw374Leor1CS2Q@mail.gmail.com>
 <CAMGffEmKy0-Ov2DQ=o+GFgWOdSZ9CaQkK985q9ZiZDnhXr3rFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEmKy0-Ov2DQ=o+GFgWOdSZ9CaQkK985q9ZiZDnhXr3rFw@mail.gmail.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 03:40:12PM +0200, Jinpu Wang wrote:
> On Tue, Sep 12, 2023 at 3:53 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 2:08 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 01:46:29PM +0200, Jinpu Wang wrote:
> > > > Hi Greg and Stable folks.
> > > >
> > > > We've noticed regression in raid1 due to following commits:
> > > > 79dabfd00a2b ("md/raid1: hold the barrier until handle_read_error() finishes")
> > > > caeed0b9f1ce ("md/raid1: free the r1bio before waiting for blocked rdev")
> > >
> > > I'll drop them from all queues, but can you test 6.6-rc1 to be sure that
> > > all is ok there?
> > Sure, I will test 6.6-rc1.
> I run same tests on 6.6-rc1, and can't reproduce the problem.

So is 6.1-rc just missing something else?  Or are these commits not
needed at all for older kernels (and hence the Fixes: tag lies?)

thanks,

greg k-h
