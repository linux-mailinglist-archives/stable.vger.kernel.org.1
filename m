Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFEB700633
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbjELLCJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbjELLCG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 07:02:06 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 04:02:05 PDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D22B106E7
        for <stable@vger.kernel.org>; Fri, 12 May 2023 04:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683888954; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Aw1M/UbYyytpcMpiQxQzWfWNSArV/QO8rGWfMOd2Wy8n8aujh4ZdVnPnQuC97BaHEl
    m2EVGUZUhrLJepfBqQAEQDMJmdv/VHpwf0Ctv/yCLRkJQIxOVYb5+CAEcVnCKb2lLAfG
    Cfxp0yNGDDqFJX5JtkUZRqq7KpUGCD8W+YaB7cYiaBGwRjjlwz2EUf2ty8OguEYptCJY
    Le9CzXOXxbfoDWZqDwfn5vShdn1twZecqOefnL8KUr5BYSlM/Gb9JbB4bYNqrUqrYMCZ
    RNEiTI+jNxAUX0KxBbwm+yulImsM8Ji0Kh6d9B8Ws6Z/85RnkKvt1GDYMQKVRM9aIWwM
    RF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683888954;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IcnC9fQoMISibPV6bWeUYZDoYQ3HREw+uIToY4kSiuI=;
    b=VY0rMiVBuRsrU9CwBUEiIDZCcMQMPCON0BNynoiCvGqUQifuSUO0O+07amI3MEodsu
    C3yzQYvrm/d7cHsuXN9M4caIJ6ovXGsWF4Di0b/fQxbYuWXCR9c6l26RqlASVyO+36wY
    Eb4fbijilY7dvJyLE7Fn1hRb8t/UOlRh18wue5tE6kvt++oCvlK87E5trgwBOtBqxdf1
    nOSxEuBgqk8Ib3+IOOpD1hooKNRvc7cyZK3iCRGnC9ViZAjOitDmNDBUcfKKsY1S20Ah
    bzINHVTm/eClAiPKcLTpEV9I0/kJykt2BncIATTFa/xU7FEUjoaX5ipgvDX41L7Uh5bh
    ABNQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683888953;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IcnC9fQoMISibPV6bWeUYZDoYQ3HREw+uIToY4kSiuI=;
    b=gguczXTCu2J8Sezn9hZ7yxNZXT6l3A8tWGtb42MNf8uJV59p8DtLxmYk+Ig+Fu4zkJ
    Q21emEE0/RNpEoLnkQtTTHZ3H+QVbqrEt6pdOXwodnd5XpCqZRVcAG15NwyP8yScHQBS
    0YwZX5r8CghLCLtFKDGVlIHPtSSHZ6Hetdfcoz7kfIYq3DQopwxghCo7AsERcb/94se1
    X9hqQ0DK/96gBlc7rcmmrH5WS+cpvduUWTPwSBdboso5LYbhf07Xj7bTRi0FeCAHs10o
    bh3m21zTNTUieNO8mEfkmMOOzdZNWkhQeJvvqAEIdbEfZgqUxY5UdhdqX7i26qKKJajM
    PStA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683888953;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IcnC9fQoMISibPV6bWeUYZDoYQ3HREw+uIToY4kSiuI=;
    b=qImzTiCB12p3WnxeMcNXHT/YJItRgBWRxrLefPfzG3u8cJhx0dE5k2rYSuu5j8wqB1
    zc4gKSxLJWvZLm3WKECQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piL1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4CAtruum
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 12 May 2023 12:55:53 +0200 (CEST)
Date:   Fri, 12 May 2023 12:55:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org,
        francesco.dolcini@toradex.com, liu.ming50@gmail.com,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: USB gadget regression on v6.4-rc1 and v6.1.28
Message-ID: <ZF4bMptC3Lf2Hnee@gerhold.net>
References: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 12, 2023 at 11:07:10AM +0200, Francesco Dolcini wrote:
> Hello all,
> I recently did have a regression on v6.4rc1, and it seems that the same
> exact issue is now happening also on v6.1.28.
> 
> I was not able yet to bisect it (yet), but what is happening is that
> libusbgx[1] that we use to configure a USB NCM gadget interface[2][3] just
> hang completely at boot.
> 
> This is happening with multiple ARM32 and ARM64 i.MX SOC (i.MX6, i.MX7,
> i.MX8MM).
> 
> The logs is something like that
> 
> ```
> [*     �F] A start job is running for Load def…t schema g1.schema (6s / no limit)
> M[K[**    �F] A start job is running for Load def…t schema g1.schema (7s / no limit)
> M[K[***   �F] A start job is running for Load def…t schema g1.schema (8s / no limit)
> M[K[ ***  �F] A start job is running for Load def…t schema g1.schema (8s / no limit)
> ```
> 
> I will try to bisect this and provide more useful feedback ASAP, I
> decided to not wait for it and just send this email in case someone has
> some insight on what is going on.
> 

I noticed a similar problem on the Qualcomm MSM8916 SoC (chipidea USB
driver) and reverting commit 0db213ea8eed ("usb: gadget: udc: core:
Invoke usb_gadget_connect only when started") fixes it for me. The
follow-up commit a3afbf5cc887 ("usb: gadget: udc: core: Prevent
redundant calls to pullup") must be reverted first to avoid conflicts.
These two were also backported into 6.1.28.

I didn't have time to investigate it further yet. With these patches it
just hangs forever when setting up the USB gadget.

Stephan
