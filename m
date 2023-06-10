Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D6B72AAD3
	for <lists+stable@lfdr.de>; Sat, 10 Jun 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFJKPN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 10 Jun 2023 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJKPN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Jun 2023 06:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963E358E
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 03:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16C5660F85
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 10:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FDFC433D2;
        Sat, 10 Jun 2023 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686392111;
        bh=EA17rr404PbKONcIVy4AwSpoO473W+kLBNoYZzOG7SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPQzZToT+9Wi41jk7D2ncbv/Su+L++Ms10s4FWzkYHGt5rLodKgRiT1QPAIiF4/8p
         XQQ4qKuf+3ssf/wgrwL2BEMI5j7IndNvzB+zReaGf34w9W15gBzwo2I/RXKPgP03ZQ
         oIc68vDVrs4sJfFMFg2cWKZeSXRwpbacQ6pz/UnA=
Date:   Sat, 10 Jun 2023 12:15:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     colin.i.king@gmail.com, error27@gmail.com, mcgrof@kernel.org,
        rdunlap@infradead.org, russell.h.weight@intel.com,
        shuah@kernel.org, tianfei.zhang@intel.com, tiwai@suse.de,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] test_firmware: prevent race conditions by
 a correct" failed to apply to 5.15-stable tree
Message-ID: <2023061036-wing-premium-8fc8@gregkh>
References: <2023060753-dowry-untried-a3d2@gregkh>
 <e3e80409-d3ca-7304-6234-ff7cb8bae3e9@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e80409-d3ca-7304-6234-ff7cb8bae3e9@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jun 10, 2023 at 11:35:34AM +0200, Mirsad Goran Todorovac wrote:
> On 6/7/23 14:22, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 4acfe3dfde685a5a9eaec5555351918e2d7266a1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060753-dowry-untried-a3d2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi, Mr. Greg,
> 
> Is there something wrong with the patch and do I need to resubmit?

Yes, and yes.  It does not apply, as the text here says, please follow
the above steps if you wish to have it applied to the 5.15.y kernel
tree.

thanks,

greg k-h
