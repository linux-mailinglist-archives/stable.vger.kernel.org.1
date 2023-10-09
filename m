Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377057BD882
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345655AbjJIK2i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345538AbjJIK2i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 06:28:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23579C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 03:28:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F396DC433C7;
        Mon,  9 Oct 2023 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696847316;
        bh=SY0Kiej4H60gYmIaks4CHhioJpH+i0hrcojJUW6tBgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzQeMk6SIUwY1l5hpS4YL5tkUgKrFKUdaj+kixPF551g4fgu2ZcYz7CODHAA95WAh
         KXqib+kv4pXzXYin+wPd3vmz6W7jqrSBez4Yv5hpfT9X9kLMlJLWDJRDD69UeWVmDZ
         4GiWVAMTI/xWUd+aNhpPudnhnPVz2b5dUtydtHuo=
Date:   Mon, 9 Oct 2023 12:28:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     dave@parisc-linux.org, dave.anglin@bell.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] parisc: Restore __ldcw_align for PA-RISC
 2.0 processors" failed to apply to 6.1-stable tree
Message-ID: <2023100927-clasp-posture-9d6c@gregkh>
References: <2023100802-occupant-unsalted-d02b@gregkh>
 <ZSJgW3xJ1xj0RwhB@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSJgW3xJ1xj0RwhB@p100>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 08, 2023 at 09:55:07AM +0200, Helge Deller wrote:
> * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>:
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Hi Greg,
> 
> below is the manually adjusted patch which applies cleanly to kernel
> 4.14-stable and up to kernel 6.1-stable.
> (commit 914988e099fc658436fbd7b8f240160c352b6552 upstream.)

Now queued up, thanks.

greg k-h
