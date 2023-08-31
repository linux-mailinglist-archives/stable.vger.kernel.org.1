Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489E278ED17
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 14:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjHaMap (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjHaMao (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 08:30:44 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49856CFE
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 05:30:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 62C683200947;
        Thu, 31 Aug 2023 08:30:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 31 Aug 2023 08:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1693485036; x=1693571436; bh=CZ
        SHpCdCrWUmzUhXLCV/7Z9xEpYO/q0yMVlnOMG0qo0=; b=bggezqeTwhtt5+FB2W
        lxxIqxjggt1tGg0vwy9nEBcA/YLfAb28FFL7B1EWNvwH8KAKRCAzu8S9vjZEEBqG
        +SOIboVBc2/3U9DSNrMCgurvDotRfQmhSy5Co+A975DcTdgySomdlJxRweB1ky8S
        S+F6BsTvLoRh9TdfymxarWCFh0eZG8TXkzXasdN+bP5T0XFI9kDJ6dH9xsGyI9ag
        O0Vsvb2JwIV1alHfRAEaRTnfqXRqsc+zJbGOmZboTbouPC5o+w6dW/mtv+HbpeO0
        Ld76sXyaaeqEaKnoAnb0l89QX7YXH6naQT906hdhFfM+g/wD147mHSvCognzZtWO
        9qzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693485036; x=1693571436; bh=CZSHpCdCrWUmz
        UhXLCV/7Z9xEpYO/q0yMVlnOMG0qo0=; b=ezIGk1e1QKqftSUaTARGsFWWt+dZF
        KhJPiTHtKP2JqxzfWn5tTTtwmkJI1b3T4PYVHjxXmPEqqg94hTTcH897bUHUl33x
        f8nka60Fs2vmUgqFIg0OIGMRqenJBvNg7IGCEviXMPLoUiRLAU4PLBkMNFfwPyBc
        WmwiEcBn0e4Ig8wRnjeBboavxwsnzjqjtWLbxIjPVDibCi8nOOleYm8qBgmkCg6k
        9RDKplFHR50Rc+MlQ9kQr2NTPFTrRAQUP9rmFz7tYO0zdGyNNulnA/Xs0bkyAlXW
        N8k0m7gwhaLjNLwzsTQdfw0BLHdaqxAjHBKFZpbC+2W7cZUUmy1v4MD5g==
X-ME-Sender: <xms:7IfwZP5nWGWFfKN38blNiLHpUkhzxHzpO7Lct1OTgspQb6mc3Ftevg>
    <xme:7IfwZE6XMP5b17bNIKiUIvDGVqBrkabSTYIpIi4-iiP_XeI7wxs-rmxulTUj3uzgN
    LHbtt3a4A9K_A>
X-ME-Received: <xmr:7IfwZGfY6PlIyYZZnAD2kDAzBMF0V2AOQYPfO6fRMKKXemaKeLa-E_S9ZupRHaom-GsgMkmy38q6k2m0pNuBOASSJhCzT25DTPrmbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:7IfwZAIaaLBGFjoxx-C1SM4XIIvWwhUz9gEhWpyBUaxvwErz6FBzYg>
    <xmx:7IfwZDKjzJXPyo7TLvVLvjvubcbMYwI5-N3j62ebu9IcL-9xuiP9TQ>
    <xmx:7IfwZJwEv_Gr0HljyTZKgFnwlisgP2uAIJTB25GDOxUdHlZNSD8e_A>
    <xmx:7IfwZAGL77ubm9ThPqXobDhwhs6JJf1cFEKq8oMzNvSwVczRIH2NnQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 08:30:36 -0400 (EDT)
Date:   Thu, 31 Aug 2023 14:30:32 +0200
From:   Greg KH <greg@kroah.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Joakim.Tjernlund@infinera.com
Subject: Re: [PATCH 6.4.y/6.1.y] thunderbolt: Fix a backport error for
 display flickering issue
Message-ID: <2023083127-stubble-skimpily-64c3@gregkh>
References: <20230831113421.158244-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831113421.158244-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 31, 2023 at 06:34:21AM -0500, Mario Limonciello wrote:
> A mistake was made when backporting commit 583893a66d73 ("thunderbolt: Fix
> Thunderbolt 3 display flickering issue on 2nd hot plug onwards") in missing
> the `if` block.  Add it back in.
> 
> Reported-by: Joakim.Tjernlund@infinera.com
> Closes: https://lore.kernel.org/stable/28b5d0accce90bedf2f75d65290c5a1302225f0f.camel@infinera.com/
> Fixes: 06614ca4f18e ("thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/thunderbolt/tmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
> index d9544600b386..49146f97bb16 100644
> --- a/drivers/thunderbolt/tmu.c
> +++ b/drivers/thunderbolt/tmu.c
> @@ -416,6 +416,7 @@ int tb_switch_tmu_disable(struct tb_switch *sw)
>  		 * mode.
>  		 */
>  		ret = tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
> +		if (ret)
>  			return ret;
>  
>  		tb_port_tmu_time_sync_disable(up);
> -- 
> 2.34.1
> 

Thanks, now queued up.

greg k-h
