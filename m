Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5456754F61
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjGPPVw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPPVv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:21:51 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BABFA8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:21:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 796485C0065;
        Sun, 16 Jul 2023 11:21:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 16 Jul 2023 11:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689520910; x=1689607310; bh=NX
        dd+jq43nAjQRGnzeAoCpmDkc7kWMV9KQkb2mkletk=; b=KZjB8TLSpkW9D669tT
        pkrGNDepqJwHjXYhCj1FaX+Zg7CJCcAWN974YFAXfLfu6IEyUcoaL5Lae0mtcd55
        ZqunBEsIb3HrC5r+EbRsl5RaTcbjNHkumv7itlg3qK9ooWeKYIxgE7Oc/u9q81JT
        klo85XWcmICI2US+JG3np6KKnEgQr3sa+8E26amqrzbn+SuN/qKgacMcUF45ZwXW
        xN2kvNZGDgIjC+3oHbQp24WjSGhPQ3VEOjA8zAyUHX8mjhD+Fu53M+oh/UALJheR
        PJ4s2mFfX6BNDZ0ljLEo0VFz8L5AJ7Ol7Mv4FBEU/R0hLBP2DuW/4zu6OiL+8ZJs
        uVXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689520910; x=1689607310; bh=NXdd+jq43nAjQ
        RGnzeAoCpmDkc7kWMV9KQkb2mkletk=; b=wZsM1LFMnVNShixgXSC2OL3zdOowg
        2u9CbH/orPrH7+RxK/kGpGjXfuJwEF99pwmosIwOLa0rppD3UsJojJkT12DTiDd8
        c1t3z3s5ZrRW4a8i3kNdTkWLuCh1K1/KvgLMnQU5/4MXpt6q49JNUo6o2z1Hsg3M
        8OvD7tBc63ybpeIxMhwUjbauoxQ3rlY+fGMI8UgkYrda9HYxMUK0rgl0E0i6pt3N
        GlI+Hhm4KZ/rh0Z/73plrL8Puua4B367xm9Yjyp0xIf/iurdBcQcobAu7m55WO7a
        ZfUY5qesMz3QmWrJBp8tOz28Tg2lrbhOzw5rg12NZ0oqIJCuDsScZ7NOg==
X-ME-Sender: <xms:Dgu0ZBD29-IQbKUNlXobAyACdkIEqLd9AFSKlqr8zgvzM80JGVYdow>
    <xme:Dgu0ZPhAXGk5mzLWoDXpV6_QZcxJjdyeC6Q8lX9Qa1QPvLLA8jordRQinBjUYBzkR
    h39iKsLd1o1qQ>
X-ME-Received: <xmr:Dgu0ZMnRpqrTVD7-1KLlNH-EOKEyjLd6BMUo7qUeExiMnTwP-tcpDSDFWZO6fJzY6QW-7MJrL0HyEroWQGMdRUjj5WHKCzuodmLpK0_bkdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Dgu0ZLxUsYHwUmauS79IZuXlUiLygebNIg0DMylRfN1in-0CiByC1A>
    <xmx:Dgu0ZGTANey63k_uKZKH6g8AERSqvUlSpAdigbSRRaoY6pXk3YH1XQ>
    <xmx:Dgu0ZOZe03LetdhO168iaiQRz8Qk_CbC7bn9tUlRubM7_L5LwRf23w>
    <xmx:Dgu0ZMPmW-jhfC1TfdOHIj4V_Dj0sRVkW-E28rRWc07z-PnGeEFsZg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 11:21:49 -0400 (EDT)
Date:   Sun, 16 Jul 2023 17:21:48 +0200
From:   Greg KH <greg@kroah.com>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5.10.y] block: add overflow checks for Amiga partition
 support
Message-ID: <2023071639-senorita-vigorous-bcd6@gregkh>
References: <2023071116-umbrella-fog-a65f@gregkh>
 <20230715232820.8735-1-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715232820.8735-1-schmitzmic@gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 16, 2023 at 11:28:20AM +1200, Michael Schmitz wrote:
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
> 
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> u64 overflow carefully to protect against overflowing sector_t.
> 
> Bail out if sector addresses overflow 32 bits on kernels without LBD
> support.
> 
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted (now resubmitted as patch 1 in this series).
> This patch adds additional error checking and warning messages.
> 
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Cc: <stable@vger.kernel.org> # 5.2
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Christoph Hellwig <hch@infradead.org>
> Link: https://lore.kernel.org/r/20230620201725.7020-4-schmitzmic@gmail.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> (cherry picked from commit b6f3f28f604ba3de4724ad82bea6adb1300c0b5f)
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> ---
> 
> Changes since 5.10-stable:
> 
> - fix merge conflicts
> ---

All now queued up, thanks.

greg k-h
