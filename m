Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFE7255D9
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbjFGHgj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbjFGHf7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 03:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4A21FC3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 00:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A692863B9B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 07:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9182C43445;
        Wed,  7 Jun 2023 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686123355;
        bh=9g0Jjoc7PTlSsE7VFQXEqDvnZpk/XhSqHRiArSG1Di0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8m2NfYHfwqdrsmCHnr+YFrrDJs1SwO56W1JOLQsMpzAce1uLokjeEamE6AiGGZwi
         6MHZPIlhS9wVZkljiOVzddR8RQU8XVVVFokha66ikG8eJGx38v53AnErZTOTn8g2P4
         xcklZq63pzHAkuWDEIIdCFjhAPwhkK1qjprOhw1A=
Date:   Wed, 7 Jun 2023 09:35:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        stable@vger.kernel.org
Subject: Re: [PATCH dlm/next] fs: dlm: fix nfs async lock callback handling
Message-ID: <2023060744-raft-gizzard-ad1d@gregkh>
References: <20230606215626.327239-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606215626.327239-1-aahringo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 05:56:26PM -0400, Alexander Aring wrote:
> This patch is fixing the current the callback handling if it's a nfs
> async lock request signaled if fl_lmops is set.
> 
> When using `stress-ng --fcntl 32` on the kernel log there are several
> messages like:
> 
> [11185.123533] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 000000007d13afae
> [11185.127135] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 00000000a6046fa0
> [11185.142668] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000002dd10f4d fl 000000001d13dfa5
> 
> The commit 40595cdc93ed ("nfs: block notification on fs with its
> own ->lock") using only trylocks in an asynchronous polling behaviour. The
> behaviour before was however differently by evaluating F_SETLKW or F_SETLK
> and evaluating FL_SLEEP which was the case before commit 40595cdc93ed
> ("nfs: block notification on fs with its own ->lock"). This behaviour
> seems to be broken before. This patch will fix the behaviour for the
> special nfs case before commit 40595cdc93ed ("nfs: block notification on
> fs with its own ->lock").
> 
> There is still a TODO of solving the case when an nfs locking request
> got interrupted.
> 
> Fixes: 40595cdc93ed ("nfs: block notification on fs with its own ->lock")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/plock.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
