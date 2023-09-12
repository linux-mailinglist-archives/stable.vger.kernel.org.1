Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5779CFC2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjILLWw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjILLWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 07:22:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640F19AA
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 04:21:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD86C433C9;
        Tue, 12 Sep 2023 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694517710;
        bh=rDNhs8IIZFblk4tqY9ZIGBZz5ZaRMqU0dw+oixXR9II=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NafjlIddPs9lvc/OX4iFYHRYA7TDs86u+cyXh1+dLzr6NeQmMRv/5EBZXTovtTCNT
         fNgenbC/e3tlfPLg1X16O1x05toQqw3fbkOOlEFQQt3dhDxVNDcecY7ffV9nudYM/P
         WEF240jF4B1ihU9MDTMMTyv7/KO9mAIk6xiwro+8=
Date:   Tue, 12 Sep 2023 13:21:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     asml.silence@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: break iopolling on signal"
 failed to apply to 5.4-stable tree
Message-ID: <2023091225-coral-outpost-51e6@gregkh>
References: <2023090939-bunkmate-clutch-4fc1@gregkh>
 <0dd1d0f7-1114-4fea-bc50-250a33ce7200@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd1d0f7-1114-4fea-bc50-250a33ce7200@kernel.dk>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 08:49:08AM -0600, Jens Axboe wrote:
> On 9/9/23 6:52 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> This isn't needed for the 5.4-stable tree.

Ah, thanks for letting me know, the "Fixes:" tag pointed at a commit in
5.1, which is what triggered this email.

greg k-h
