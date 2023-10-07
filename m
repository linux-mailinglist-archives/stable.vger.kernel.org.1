Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894F7BC734
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 13:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjJGLgB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjJGLf7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 07:35:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69214C2
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 04:35:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DF0C433C8;
        Sat,  7 Oct 2023 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696678556;
        bh=Q3XmHutWYUhNi5pXcdXKxvHsXPGDWSck1cmQ7VlUFkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJcNTmRQpIRem+TM4+Y4M8dhNoxTIvRcwXdRd44YZdUZuuCotm/qYzEE8TsPvxgsK
         mOBBS//swcXfRmjIBUe9jJnngTB0Z27xK6ArnlCPcNLTbqckBcHS8idgQsxlbFj1sk
         pKfg8ppt5WBhWOGrr8XsE4Ve8gU8wWDs82RB0szs=
Date:   Sat, 7 Oct 2023 13:35:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     geert+renesas@glider.be, hare@suse.de, martin.petersen@oracle.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ata: libata-scsi: Disable scsi device"
 failed to apply to 6.5-stable tree
Message-ID: <2023100726-puppy-gutter-23af@gregkh>
References: <2023100421-numbness-pulsate-f83d@gregkh>
 <b779686d-07e6-50fb-5d94-80ebd5c9b13c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b779686d-07e6-50fb-5d94-80ebd5c9b13c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 05, 2023 at 08:50:27AM +0900, Damien Le Moal wrote:
> On 10/4/23 23:58, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.5-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x aa3998dbeb3abce63653b7f6d4542e7dcd022590
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100421-numbness-pulsate-f83d@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
> > 
> > Possible dependencies:
> 
> commit 3cc2ffe5c16dc65dfac354bc5b5bc98d3b397567

Ok, but that commit does not apply to 6.5.y either :(

Can you send a working set of backports for 6.5.y if you want to see
this change there?

thanks,

greg k-h
