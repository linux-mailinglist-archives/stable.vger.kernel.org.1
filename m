Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184227D7C1E
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 07:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJZFRz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 01:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFRy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 01:17:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36CDB9
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 22:17:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8992C433C8;
        Thu, 26 Oct 2023 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698297472;
        bh=r2IaXUF+UQ+XDNNS6LRjYU6FNr2RaEz0oGoSm7EdDig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiZUJnVg3R/wxJhayrvCwFjjVPhPxMldpVJg+TAE4++fCJ0OiiHlGAp3Oza0jtE7I
         KtKxeo3df3W5V4K7tMSCeCRJCedLTquIK/QmFOjP50FpGh7D2BnywHP02zNR3GERtw
         hh/kws3zwlDOnUGeE5y5S8e5Q4/ZE4tTq+u0mNqk=
Date:   Thu, 26 Oct 2023 07:17:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     bp@alien8.de, jpoimboe@kernel.org, patches@lists.linux.dev,
        peterz@infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] objtool/x86: add missing embedded_insn check
Message-ID: <2023102618-tributary-knapsack-8d8a@gregkh>
References: <20231026015728.1601280-1-jsperbeck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026015728.1601280-1-jsperbeck@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 26, 2023 at 01:57:28AM +0000, John Sperbeck wrote:
> When dbf460087755 ("objtool/x86: Fixup frame-pointer vs rethunk")
> was backported to some stable branches, the check for dest->embedded_insn
> in is_special_call() was missed.  Add it back in.
> 
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
> 
> 
> I think 6.1.y, 5.15.y, and 5.10.y are the LTS branches missing the
> bit of code that this patch re-adds.

Did you test this and find it solved anything for you?  Your changelog
is pretty sparse :(

thanks,

greg k-h
