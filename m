Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC0374F8CC
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGKUMK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGKUMJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F7136
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D37EE615EB
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 20:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F43C433C8;
        Tue, 11 Jul 2023 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689106327;
        bh=okdFDcaccCCnOuY1kf1usQpoCD7VYHpoKRiND4eMIgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4EuJNc/aEedVtl2Tdiy/cEBxPcAYBINeUdHxMNB4kTWex47+osboI38e/hJNe6Yy
         ovcubggLM0YNVrIW2wH9aKm1Z1PIqX4y1T5O/wCxaQjHeJ2Yr4ZwCut3YwtBwvKq9H
         JnFJrjMGSQ0H6pw7OfrLQ3j0f+9QdiNN0SpeRE7s=
Date:   Tue, 11 Jul 2023 22:12:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Regression in 6.1.35 / 6.3.9
Message-ID: <2023071157-shower-dropout-242d@gregkh>
References: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
 <2023062808-mangy-vineyard-4f66@gregkh>
 <ZKLT2NnJu3aA0pqt@eldamar.lan>
 <4e04459c-3ff7-3945-b34f-dde687fad4be@amd.com>
 <ZKMcL6bG4RlnvHbi@eldamar.lan>
 <bcbd0e64-dd21-7d0e-7bcc-b700fe0674e3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcbd0e64-dd21-7d0e-7bcc-b700fe0674e3@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 07, 2023 at 11:45:57AM -0500, Limonciello, Mario wrote:
> On 7/3/2023 14:06, Salvatore Bonaccorso wrote:
> > Hi Mario,
> > 
> > On Mon, Jul 03, 2023 at 12:43:06PM -0500, Mario Limonciello wrote:
> > > On 7/3/23 08:57, Salvatore Bonaccorso wrote:
> > > > Hi Mario,
> > > > 
> > > > On Wed, Jun 28, 2023 at 08:16:25PM +0200, Greg KH wrote:
> > > > > On Wed, Jun 28, 2023 at 05:56:01PM +0000, Limonciello, Mario wrote:
> > > > > > [Public]
> > > > > > 
> > > > > > Hi,
> > > > > >    A regression was reported in 6.4-rc6 that monitor resolutions are no longer present for anything but native resolution on eDP panels.  This specific change backported into stable at 6.1.35 and 6.3.9:
> > > > > > e749dd10e5f29 ("drm/amd/display: edp do not add non-edid timings")
> > > > > > 
> > > > > > After discussing it with the original author, they submitted a revert commit for review:
> > > > > > https://patchwork.freedesktop.org/patch/544273/
> > > > > > 
> > > > > > I suggested the revert also CC stable, and I expect this will go up in 6.5-rc1, but given the timing of the merge window and the original issue hit the stable trees, can we revert it sooner in the stable
> > > > > > trees to avoid exposing the regression to more people?
> > > > > 
> > > > > As the submitted patch had the wrong git id, it might be good to be able
> > > > > to take a real one?  I can take it once it shows up in linux-next if
> > > > > it's really going to be going into 6.5, but I need a stable git id for
> > > > > it.
> > > > 
> > > > Do you know, did that felt trough the cracks or is it still planned to
> > > > do the revert?
> > > > 
> > > > Regards,
> > > > Salvatore
> > > 
> > > Hi,
> > > 
> > > It's part of the PR that was sent for 6.5-rc1 [1]. Unfortunately it's not
> > > yet merged AFAICT to drm-next yet nor Linus' tree.
> > > 
> > > d6149086b45e [2] is the specific commit ID.
> > > 
> > > [1] https://patchwork.freedesktop.org/patch/545125/
> > > [2] https://gitlab.freedesktop.org/agd5f/linux/-/commit/d6149086b45e150c170beaa4546495fd1880724c
> > 
> > Ack, thanks!
> > 
> > Regards,
> > Salvatore
> 
> The revert is in Linus' tree as of this morning.  Greg, can you take this
> back now?
> 
> d6149086b45e1 ("Revert "drm/amd/display: edp do not add non-edid timings"")

Now queued up, thanks.

greg k-h
