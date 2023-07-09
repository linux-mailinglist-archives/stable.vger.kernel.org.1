Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B981674C148
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjGIG0h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 02:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjGIG0e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 02:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466DB1BF
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 23:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D466D60BA1
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 06:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AA4C433C9;
        Sun,  9 Jul 2023 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688883993;
        bh=EnHCKP0BK13Yi/iIgak4P1dYAp36N7NA3lxmY9mMduA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hb871dcXQ5jPOb/DfcnqtBJcW5RQvEJ0k8vA9GIfHxgGxOHUt15IJrecy23qH0XJG
         qnqY6qV0LtLxcSt+arVinc9lehPx3W0uapvW6Ih15qJdoejs/AGv7XaDsQsK//IVBi
         QbtjRGMgE/xYnAlsVq7Pr27POyB4gjJrAAyiVkpc=
Date:   Sun, 9 Jul 2023 08:26:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zxuiji <gb2985@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: Suggestion for extending SIGWINCH
Message-ID: <2023070923-cramp-tarnish-5b8e@gregkh>
References: <CAOZ3c1paOYY4mXuF_MMcb+12e7d4_1cXb8RxPDG5B3ty3fiwfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZ3c1paOYY4mXuF_MMcb+12e7d4_1cXb8RxPDG5B3ty3fiwfA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 08, 2023 at 06:42:57PM +0100, zxuiji wrote:
> Currently it only indicates a change in window size, I expect the
> si_code value is also 0 for this signal. The extension will be for
> mouse input and the difference will be indicated by si_code being 1,
> to avoid issues with x11 vs wayland vs etc a custom structure should
> be pointed to in the si_addr parameter. I think the custom structure
> should look something like this:
> 
> struct ttymouse
> {
>     uint button_mask;
>     int x, y, wheel;
> };

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
