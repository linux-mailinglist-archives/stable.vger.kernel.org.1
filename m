Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E47D1185
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbjJTOZ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377541AbjJTOZZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 10:25:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896CD5F
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 07:25:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7265C433CC;
        Fri, 20 Oct 2023 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697811923;
        bh=wldg2zwOkncbKRJtGFBFpmkGBwcFXywZnG13CG3zHhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJ/3joCf+5FMJaprCbr89oaXtaFok28cVqNP3CRzEhEVviVmSBnfJEbf9nyriexnS
         kyIo8D2DFuBycYxVqzbD0Folujn5QAbqFEUqMSbxuUnEi4CIGcomqNtXAcZAdshQS4
         oL+F3/lLdsPNrI1aA6ZpIXh3qpjnRQeYFi0xTIBA=
Date:   Fri, 20 Oct 2023 16:25:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jesse Hathaway <jesse@mbuki-mvuki.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        giuseppe@scrivano.org
Subject: Re: [PATCH] attr: block mode changes of symlinks
Message-ID: <2023102034-atlas-obligate-46bb@gregkh>
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
 <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
 <38bf9c2b-25e2-498e-ae50-362792219e50@leemhuis.info>
 <20231020-allgegenwart-torbogen-33dc58e9a7aa@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020-allgegenwart-torbogen-33dc58e9a7aa@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 20, 2023 at 01:01:44PM +0200, Christian Brauner wrote:
> The other option to consider would be to revert the backport of the attr
> changes to stable kernels. I'm not sure what Greg's stance on this is
> but given that crun versions in -testing already include that fix that
> means all future Debian releases will already have a fixed crun version.

I will be glad to revert a change in a stable tree that is also reverted
in Linus's tree, but to just "delay" a change getting into the tree,
that's not ok (either the change is good or not.)

thanks,

greg k-h
