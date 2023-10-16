Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78D67CA0AA
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJPHfV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjJPHfT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 03:35:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D7E3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 00:35:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60653C433C7;
        Mon, 16 Oct 2023 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697441717;
        bh=rBvbK8SntgcV8ZylM2WDwipgBWwfVRHRYQW9iMdt++c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpCpFX2Dsy7v+WUaCQjKKTfj0VNcaxNcvNtZ7p+7hIl5VzigFFG+Np3wlPF/LKsxb
         XduJCEAdiTa39cNV+vtUI+yGr++9o5d5P6DQvbKJC2QdRiGBVE6OsJUe6DIA8b+0J0
         y2JiMelNKfM8JJJ6ZifB9j8pSwaPDf8CgPMoxLE4=
Date:   Mon, 16 Oct 2023 09:35:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: Forgotten stable marking
Message-ID: <2023101607-celery-rants-81e3@gregkh>
References: <CAHk-=wh-ivh+tqpw3gPjDe5kPC_CNa0xYr12d20GwtvFF8xcYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-ivh+tqpw3gPjDe5kPC_CNa0xYr12d20GwtvFF8xcYQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 12:31:38PM -0700, Linus Torvalds wrote:
> Bah, I just noticed that the recent revert should have been marked for
> stable for 6.5, but I pushed it out and it's too late now.
> 
> It may be that you end up auto-flagging reverts the same way you do
> for "Fixes:" tags, so maybe it would end up on your radar, but just to
> make sure, I thought I'd mention the commit here explicitly:
> 
>   fbe1bf1e5ff1 Revert "x86/smp: Put CPUs into INIT on shutdown if possible"
> 
> just so that it doesn't get missed.

Thanks, I've queued it up now.

greg k-h
