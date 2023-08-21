Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7DC782A4B
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHUNSL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjHUNSK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 09:18:10 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BFA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 06:18:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E01665C275C;
        Mon, 21 Aug 2023 09:18:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Aug 2023 09:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692623886; x=1692710286; bh=1+
        dTayqFSoxhnG6TlPFHWOAOupZKaZX5G+O7iiK542c=; b=XKehiQ4U7n0+uQxtdr
        MRQzaaJH7r+KvO545cQ0FuZF3iFqCCDrfeGozo+GJgoCJ2rQodCpBpQW+sRH4z+9
        fcF4k0duda4MzXR+GpyIH9T9ZW+7rJ2Nvbe/NXc0HZ6CNdwteEq0JYTT8q6VzcZn
        WzSR4frmkUqz9Yqx5sBDLpLTl6lrmj9aVsYP/Bluki07RaVc/BTgKuN7ADjcbWV1
        u3/4xgfuhI84EB8WwcOqvJ+wrqHuEDd6McdT7ttbGmNEJpDl2FYqcrw+tQzJu23s
        FD/+jyaBGOaMOVRO6ohUBJRqCkQEzFJpgO3siQNyPv133hWSV+NfPktaKr29DWVG
        p2vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692623886; x=1692710286; bh=1+dTayqFSoxhn
        G6TlPFHWOAOupZKaZX5G+O7iiK542c=; b=D9YnQocrnjKOWZZDXaH8h/Ebp7tB4
        ZtpjQ2ohMrJst9MBtLj++93LP4gqOKILPz/IxCeILCdV4PbisC06W5MM36kQboY7
        Dgf6TVpLsIPYxr5ToNUwi1lI9+sNBhvDl5OOoO/SEO4kh7Czoikc8utKiVNRMr9a
        Vpo+uYQOOv+kg+1grcCjQU5vgv4ETKugpFjjrdwgiMJR2OrNwuYaXJMSTlXH+IIr
        U0FJ4zUFvDye0Hv35XCk6IY7Uf2XMEYlYV6jyrlo4t7BAnA+klqUJoeYQw5pRdni
        0ARCOrNrgBjQCU7AQnUOJYR2ZmeFqsRWnckFGzPTiDD67WFrot2Ck9W0A==
X-ME-Sender: <xms:DmTjZG148RTtsgHnHeuKBEvd3PKTZva0FDC2z6pkb7J4b-1xf_7_Jw>
    <xme:DmTjZJFQdK9yvTy2fP2MODf-eyrwPVOxT_vg4j85JLU19QNwCkQOWn8lMuV4R-iJp
    6tm4IagAt7Hvg>
X-ME-Received: <xmr:DmTjZO7r9C8Dj_gn8SFeBRj-isfl5m3V0HOpJWZxNhj34VvcDs1-4v-8b4mzCBfUl8uxdU4UlEWD30eLjrZE2ci67mP3u0pkd16kcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduledgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleeite
    evieefteelfeehveegvdetveehgffhvdejffdvleevhfffgeffffejlefgnecuffhomhgr
    ihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:DmTjZH20i58VZIOn1W9lzr83oEL_cffsmRsK-XHCAJ3wgxFOi_6nQw>
    <xmx:DmTjZJHrI3iCAPEOTUxDma_oRw8Ig17BYzRrIBNXz1qPkMb3NFbbyg>
    <xmx:DmTjZA8vgtXsZWpZU-BoLl4l8l6oqL1arFvqFFxIJ4cyssAfVxl-Tg>
    <xmx:DmTjZOR5sKNdMnPQU-LgANQORgTP69OGWdhxjjhazIpE5eFtt44gBQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Aug 2023 09:18:06 -0400 (EDT)
Date:   Mon, 21 Aug 2023 15:18:02 +0200
From:   Greg KH <greg@kroah.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [6.1.y] Assertion with 7xxx dGPUs
Message-ID: <2023082156-renderer-flinch-5260@gregkh>
References: <d73a3a25-0186-4f07-b7b2-684edd179892@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d73a3a25-0186-4f07-b7b2-684edd179892@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 10:32:39AM -0500, Limonciello, Mario wrote:
> Hi,
> 
> In addition to the hang fix patches recently this other patch is needed for
> helping a case that ASSERT() catches.
> 
> 74fa4c81aadf ("drm/amd/display: Implement workaround for writing to
> OTG_PIXEL_RATE_DIV register")
> 
> Can you please take this to stable 6.1.y too?
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2466

Now queued up, thanks.

greg k-h
