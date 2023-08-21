Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87417830BA
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHUTCD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHUTCB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:02:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621A11BD8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:01:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9F61E5C26CB;
        Mon, 21 Aug 2023 14:44:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 21 Aug 2023 14:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692643499; x=1692729899; bh=cA
        NKj53sNWJkna6od5mok8F4xMm9Kv6AdlFZ6wwlFqE=; b=oja43mYQPxUSAH+bE3
        7dHNQvj0gxGl8dSmmoRHmyZZO3ZiCas4jbEIg4jpPq5d06fTTIUfoT+8yozi2Lvl
        SBVPvzkoHz5y+NnADosAhym5VX1RYGHnHEq+vKaTYxohP6Fe8U0hGOnL07VX/lCR
        gS0XxIVfFey/4HbzFEQxdFSF6HZ3bsK+aQHLpT4iCdv4mfEY1ggtNyKgFlStJb+n
        /0xuBINMX3tLwNSkkIj1QlfT0wY9OJke6+3O7WISYCavQg79AomQ8LtZd5PRAgBr
        yhUu7ugJG0ZXXoCNJCd7vLXe/lBVJnKBD5gWz2ZIhFYMuHew74ljg7VPIygRxj5N
        UHtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692643499; x=1692729899; bh=cANKj53sNWJkn
        a6od5mok8F4xMm9Kv6AdlFZ6wwlFqE=; b=nPCn5ma75fZ8BymIcVsjMNr18dC14
        xuoQvN5rhG1a9XTJ68JcNQGau5eBQasKccIHTwmwDmSGQsYVt14Lk/WVrUjjBPx/
        tjLeGN42MqL8ZWfSLz5tGDvFjk2ktmJSmNfUJHCp5tjUMKkfDMY7uV89o5FQkbzl
        xZ1Mxxq37ryV+ZI931+6MXPnWm9Z97a84zs6Rj9vPA39didIfA5Opt1X1rr5Uqj+
        qv5UAWyqluEi77ApEUpH7gutIPGcSl6IbKTP5mrei4H3T2CDiqBQPhD23ftBqZAm
        +ePfBxRNdSOFG+xnySVCDceHctD6f6c/MpBz+3a5Gk/LnfA04SlxJKehA==
X-ME-Sender: <xms:q7DjZNbArnQvGv42Ifp_QtBRFvfTxlQXUaxuKO07nPIHiW3moi4gXQ>
    <xme:q7DjZEZ75lBrx2SJaip0z8T2Bxrb3cLwHwrIaEGfPmfPQOAyxtElNC9xpxdMrFdqi
    -z6k9qSrdUBQw>
X-ME-Received: <xmr:q7DjZP-4y9Q4fGc1EFX6qZpvayU8SyzVy0oYPCRimk5_imKo6UYTciXu3grMcO9QgeHfr5fh1Ux2VIIF1_x2fr0nY2w2ok_JhypEsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeffve
    eghfefleeffedtiefhfefgvedvkeduudefvdelieegieeijeeuteegkefhudenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgpdhfrhgvvgguvghskhhtohhprdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhho
    rghhrdgtohhm
X-ME-Proxy: <xmx:q7DjZLpK6pQoLS4pZRZIX9-selg31iuzINtvKXlXl_j6VSQYT0A7eA>
    <xmx:q7DjZIqxoFIp90UpG4nvFouvHpFfWln7pgZAgoyj1K_rJF-y0_RHaQ>
    <xmx:q7DjZBQwDGZU_PWXvcCb2xVZ2zzqpSJmoD73F16BdyXX5-ibyKeU0g>
    <xmx:q7DjZBkIGFkuzUqUrZikbQ6RudkLNSrhmGFcz0qrduGhFKheo-9TnQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Aug 2023 14:44:59 -0400 (EDT)
Date:   Mon, 21 Aug 2023 20:44:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH 6.1.y] drm/nouveau/disp: fix use-after-free in error
 handling of nouveau_connector_create
Message-ID: <2023082147-stuck-snowplow-ff06@gregkh>
References: <2023082146-oxidation-equate-185a@gregkh>
 <20230821175918.639815-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821175918.639815-1-kherbst@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 21, 2023 at 07:59:18PM +0200, Karol Herbst wrote:
> We can't simply free the connector after calling drm_connector_init on it.
> We need to clean up the drm side first.
> 
> It might not fix all regressions from commit 2b5d1c29f6c4
> ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts"),
> but at least it fixes a memory corruption in error handling related to
> that commit.
> 
> Link: https://lore.kernel.org/lkml/20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local/
> Fixes: 95983aea8003 ("drm/nouveau/disp: add connector class")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230814144933.3956959-1-kherbst@redhat.com
> (cherry picked from commit 1b254b791d7b7dea6e8adc887fbbd51746d8bb27)
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h
