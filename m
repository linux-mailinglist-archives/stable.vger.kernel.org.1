Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586047BC71C
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjJGL0y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 07:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjJGL0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 07:26:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89088B6
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 04:26:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D25C433C8;
        Sat,  7 Oct 2023 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696678012;
        bh=3uL9uXGgNY6sRe22NwY+WcND9PGCDcIix9Z/i0fyqKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xiultbh35G2psMaD7Czc3TEHCCwEa1L1rj7i2jWbfR48ouRq90OY/khRbc7a62wY/
         1GgtcZlcZW3RdaqhsQsd2lswLrjwmie1DM7BaOjrnFfZvSs/EjUWJ1cMB3Qu+GF/2a
         2f95fRcb5NnpX1/zBqm4VFFnM2A1ESLRs1Z9J384=
Date:   Sat, 7 Oct 2023 13:26:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, martin.petersen@oracle.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] scsi: sd: Do not issue commands to
 suspended disks on" failed to apply to 6.1-stable tree
Message-ID: <2023100741-crawlers-bleep-5490@gregkh>
References: <2023100438-oblivion-stowing-20c5@gregkh>
 <1cc3432d-9ce2-c627-4122-6c30b1c1ac20@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc3432d-9ce2-c627-4122-6c30b1c1ac20@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 05, 2023 at 08:33:14AM +0900, Damien Le Moal wrote:
> On 10/4/23 23:30, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 99398d2070ab03d13f90b758ad397e19a65fffb0
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100438-oblivion-stowing-20c5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > 
> > Possible dependencies:
> 
> commit 3cc2ffe5c16dc65dfac354bc5b5bc98d3b397567
> 
>     scsi: sd: Differentiate system and runtime start/stop management
> 
> is missing, which is why this backport fails. Same for 5.15 and 5.10 failures.
> We need to add that patch as well (and all the patches related to suspend/resume
> from the last rc4 libata PR).
> Should I prepare a series for the backport ?

Please do, thanks.

greg k-h
