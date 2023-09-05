Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C747F792E5E
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbjIETJp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbjIETJk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 15:09:40 -0400
X-Greylist: delayed 1544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 12:09:13 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5924B18C
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 12:09:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFCDC433CC;
        Tue,  5 Sep 2023 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693937324;
        bh=DsJzk6xx6CavASRR1dxStG5SMWcoSQ3cSGg9aSgEsew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJWseShIE2CRSSnEGQPhm8lnyYoee/AxQWutbrjDl/Q5jMyc8tB/zNPKECius25hF
         2jCY0NENG1CTC/r8lGG+lzMtFmEAerhu4dkFT8Hrl46e9Aq9M0j/XV3FsfdHyKNobk
         /X6CeJ4wjmtgyp8KGZRGItZqdOuxdU60H+DwJeabNuZ/1hyi2dbw/Wf00R4uDMigGu
         vVtDebVlcdyuMu4BsrnD9buyfytqGOVNy+WsEgF/0ShIDgT8FKsp5R9KA420wBR1DK
         d0eTERRe9TvmKExfQ1DJ7jVKkQLikMgfc8ukLrbscG9+nIKK8oQIy3VXIl2Yyd/AQx
         kIQwfStEgwTVA==
Date:   Tue, 5 Sep 2023 12:08:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <ZPduqCASmcNxUUep@kbusch-mbp>
References: <20230814070213.161033-1-joshi.k@samsung.com>
 <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com>
 <ZPH5Hjsqntn7tBCh@kbusch-mbp>
 <20230905051825.GA4073@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905051825.GA4073@green245>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023 at 10:48:25AM +0530, Kanchan Joshi wrote:
> On Fri, Sep 01, 2023 at 10:45:50AM -0400, Keith Busch wrote:
> > And similiar to this problem, what if the metadata is extended rather
> > than separate, and the user's buffer is too short? That will lead to the
> > same type of problem you're trying to fix here?
> 
> No.
> For extended metadata, userspace is using its own buffer. Since
> intermediate kernel buffer does not exist, I do not have a problem to
> solve.

We still use kernel memory if the user buffer is unaligned. If the user
space provides an short unaligned buffer, the device will corrupt kernel
memory.
 
> > My main concern, though, is forward and backward compatibility. Even
> > when metadata is enabled, there are IO commands that don't touch it, so
> > some tool that erroneously requested it will stop working. Or perhaps
> > some other future opcode will have some other metadata use that doesn't
> > match up exactly with how read/write/compare/append use it. As much as
> > I'd like to avoid bad user commands from crashing, these kinds of checks
> > can become problematic for maintenance.
> 
> For forward compatibility - if we have commands that need to specify
> metadata in a different way (than what is possible from this interface),
> we anyway need a new passthrough command structure.

Not sure about that. The existing struct is flexible enough to describe
any possible nvme command.

More specifically about compatibility is that this patch assumes an
"nlb" field exists inside an opaque structure at DW12 offset, and that
field defines how large the metadata buffer needs to be. Some vendor
specific or future opcode may have DW12 mean something completely
different, but still need to access metadata this patch may prevent from
working.

> Moreover, it's really about caring _only_ for cases when kernel
> allocates
> memory for metadata. And those cases are specific (i.e., when
> metadata and metalen are not zero). We don't have to think in terms of
> opcode (existing or future), no?

It looks like a little work, but I don't see why blk-integrity must use
kernel memory. Introducing an API like 'bio_integrity_map_user()' might
also address your concern, as long as the user buffer is aligned. It
sounds like we're assuming user buffers are aligned, at least.
