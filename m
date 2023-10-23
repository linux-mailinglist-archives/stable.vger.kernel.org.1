Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042147D2EA2
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjJWJjK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 05:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjJWJjJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 05:39:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF156A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 02:39:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D58CC433CC;
        Mon, 23 Oct 2023 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698053947;
        bh=p7YGTNSZ7jfcmZG7mfWFAD4AANRQSt1yBoENwrqlDVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BukZTlFZFYblxaUoBbiPDhIwYIeo1601rXMLDSeAFmxI7i6pR308GF/q74FtfzkqS
         wLcz4U8z65j8QnUD7yykru0LhVfyDipPtnTJHKE8sJD+9wBjV/gKLksqq1haw1xhHY
         L84wxLR/OgZ5v2X+EVKRXM6M+puMG7Wdb6cnSQbQY3bgjHCQ3m9qLSnD1LHwOrycaA
         XJtVP7oiOx7fxoMgc+GxWD/zyFfePiO67wuz7/ydxbXPYtcCnKcmOglXbzB5Mv35Jw
         haWdcSbQArVk7ASKglWM45bwHdKkV+3BBocW66eNE1t3wfbReTt3t1CO/GCIqWp/jm
         B0ExFlmsSrPfg==
Date:   Mon, 23 Oct 2023 10:39:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5.15.y 3/3] rpmsg: Fix kfree() of static memory on
 setting driver_override
Message-ID: <20231023093903.GD8909@google.com>
References: <20231018120441.2110004-1-lee@kernel.org>
 <20231018120441.2110004-3-lee@kernel.org>
 <2023102325-untie-divisibly-8b97@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023102325-untie-divisibly-8b97@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 23 Oct 2023, Greg Kroah-Hartman wrote:

> On Wed, Oct 18, 2023 at 01:04:34PM +0100, Lee Jones wrote:
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > commit 42cd402b8fd4672b692400fe5f9eecd55d2794ac upstream.
> > 
> > The driver_override field from platform driver should not be initialized
> > from static memory (string literal) because the core later kfree() it,
> > for example when driver_override is set via sysfs.
> > 
> > Use dedicated helper to set driver_override properly.
> > 
> > Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
> > Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Link: https://lore.kernel.org/r/20220419113435.246203-13-krzysztof.kozlowski@linaro.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
> >  include/linux/rpmsg.h          |  6 ++++--
> >  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> Any specific reason why you missed the fixes for this commit as well?
> Turned out to need some more things after this :(

No reason not to.  I didn't notice them.

> Why are these needed at all for the stable kernels anyway?  It's good to
> have in the tree, but who is using manual overrides for the rpmsg driver
> in the first place?

UAF.

> I'm going to drop all of these from the stable queues now and wait for a
> fixed up set of patches with a good reason to justify their existence in
> the stable trees.

As per our SOP, I'd like to avoid spelling it out.

Ping me for details if you really want to know.

Which patches have you dropped?  Just these 3 or all branches?

-- 
Lee Jones [李琼斯]
