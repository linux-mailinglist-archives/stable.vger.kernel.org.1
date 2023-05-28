Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B5713878
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE1Hnl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjE1Hnk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30079BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE42F61228
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE0EC433EF;
        Sun, 28 May 2023 07:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685259818;
        bh=ajstUZWduzNwxTkrzkhFLpn3JdR3ttgR+9Y7aTF5F3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMKS9Rfbvch3VG4iQkxkZl7+RGGstOZ+3bpguUUzdqZ/LcaxE5aY8XZdZGtOcuTHH
         wuMM2GQ/gltICOonjB7cybzED73911m5ruTB86BzvASruI/t7MNYnMm0hF1IaSXsgv
         A7wJDj9TNPZVCFXwMHqJG8b5s5c5B3NKjaSfC1uw=
Date:   Sun, 28 May 2023 08:43:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: Backport request: parisc: Fix flush_dcache_page() for usage from
 irq context
Message-ID: <2023052829-itinerary-swiftly-c605@gregkh>
References: <ZHEhvXD7LsPaytEF@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHEhvXD7LsPaytEF@p100>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 26, 2023 at 11:16:45PM +0200, Helge Deller wrote:
> Dear stable kernel team,
> 
> could you please add the patch below to all stable kernels
> from v4.19 up to 5.15.
> 
> It's a manual backport of upstream commit 61e150fb310729c98227a5edf6e4a3619edc3702,
> which doesn't applies cleanly otherwise.

Now queued up, thanks.

greg k-h
