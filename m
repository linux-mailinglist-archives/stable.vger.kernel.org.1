Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7E789B9F
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 09:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjH0HBd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 03:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjH0HBK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 03:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC22120
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 00:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C592A61C17
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 07:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17BAC433C8;
        Sun, 27 Aug 2023 07:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693119667;
        bh=7mIOv0bCZXxnIhOi/jDLloZ9MvTqH7Lef/NfEqK8tdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jm55Nok1bTtrh4qpySsd0NK1DV4Gqh8l5leCiHApzaJX5TeZVxb0IfqHU3Qo06+ks
         xuvumaNbrCNFiOW1BpKDtAZQXT1lcF5PVdYl7UPrrh1xDmGXKufs54N5LgMD/T+0GH
         ZV4rcRjeAoOyGZiKRh8BuFgXagmyeAkEhXmueCuc=
Date:   Sun, 27 Aug 2023 09:01:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH v6.1] hwmon: (aquacomputer_d5next) Add selective 200ms
 delay after sending ctrl report
Message-ID: <2023082753-suggest-heroism-3212@gregkh>
References: <2023081222-chummy-aqueduct-85c2@gregkh>
 <20230824141500.1813549-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824141500.1813549-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 24, 2023 at 04:15:00PM +0200, Aleksa Savic wrote:
> commit 56b930dcd88c2adc261410501c402c790980bdb5 upstream.
> 
> Add a 200ms delay after sending a ctrl report to Quadro,
> Octo, D5 Next and Aquaero to give them enough time to
> process the request and save the data to memory. Otherwise,
> under heavier userspace loads where multiple sysfs entries
> are usually set in quick succession, a new ctrl report could
> be requested from the device while it's still processing the
> previous one and fail with -EPIPE. The delay is only applied
> if two ctrl report operations are near each other in time.
> 
> Reported by a user on Github [1] and tested by both of us.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
> 
> Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
> This is a backport of the upstream commit to v6.1. No functional
> changes, except that Aquaero support first appeared in
> v6.3, so that part of the original is not included here.
> ---
>  drivers/hwmon/aquacomputer_d5next.c | 36 ++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h
