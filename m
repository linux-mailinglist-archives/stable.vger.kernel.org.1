Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46807779E1F
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjHLIPk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 04:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjHLIPj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 04:15:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ACE171F
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 01:15:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B42F75C00A6;
        Sat, 12 Aug 2023 04:15:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 12 Aug 2023 04:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691828140; x=1691914540; bh=9y
        BMNf7nhE/bzUBjpgN5qrfqf1ASxvgSqxioam3tso8=; b=IxjTpdcGaGIeq+aSnv
        C6lNsu2xPGVnNreGZW2CM+EQNu8v4CT4CXCzEZjPZ7NYzUnsoEI6LbBovB/TRUVS
        zfBpTVWismTDvzE4JmVL8pE3/BY20xSBks2dnN/fU7QWk3hMfyT6XV/rF9qc5V0F
        21KGwdMz8+x3jAjuMkBwBcp0oCTdjIs1hyVwioeTIYzJSQvPVy0P1UcI2n5hnP6h
        uJ3OMvXX3Dw49HlAfn2AYqNTlUZA3rOygFF4sRkkyMfs+l2e5e4racjsiNk9K4xJ
        Y7ef88PCo3HQYGf1KY/4saVunmxYf1TPB6cMZTDMq/nfjtwyAkiDw0zJ7wPRipTE
        KHyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691828140; x=1691914540; bh=9yBMNf7nhE/bz
        UBjpgN5qrfqf1ASxvgSqxioam3tso8=; b=aZVIP3uNaTF3T61dXOREANVbHG8gy
        yL3NO+sZbaIFg+nHCpCf3fbp7mm4Ux/Esp26uPE3DC7npvfg0ReDUHkDU1Dv7KD1
        WnaN0kIZxfxITytmjJ26pguYPX4y+mYBbvQAM7tGSVxtpdtz4jc/T4LYPuDIAHpH
        ea32R+7Di/AHpVReSTywlmUE0BuUFQ/JUR+ZeaNAQs23aTVqdfSq4F5/EeGkZqq7
        YSW05CNMmygIDJfLWMva0eZ+NNDIKD/tk94+L9wnJXQeuPZHzVhoXWSwA/c7+mEO
        ApnLQalPA8k9/ELeJxVJqC9AOlFEUs4K+cvClzzZHENDXwKxgy+9f93dw==
X-ME-Sender: <xms:rD_XZNj_sK0OP_hEq-uzVj2aF4j2psGgWH49SQ-hw7dV_IXgmoW5TA>
    <xme:rD_XZCAbT20lpFyc42uG7wY-b-XRU4xXWvWR_KKwb6JRmQGQBFidRQ-yDoH18U1yH
    KdXQE_E2sSH1A>
X-ME-Received: <xmr:rD_XZNGk7VUW4r0gqfyULk7C3PVDz4IchGWg1M0WBMd6vhjGv_yaGVD_qdnwkWCpaqaOYyxTveKc5TIZknw99a2nmbzK2kf7qtdYLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleeite
    evieefteelfeehveegvdetveehgffhvdejffdvleevhfffgeffffejlefgnecuffhomhgr
    ihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:rD_XZCRf0otBdEqEu4Gabh4sxofgD3eFEv99Fwt9ROZpcFW6u_o4MA>
    <xmx:rD_XZKyegLNoR2hourMaOem6CRhcPu8EhjmPbjpHlvZRS-V1wQnQhQ>
    <xmx:rD_XZI6zyOsnrKKMIcGes_NkphUPIKN1YC4dB28IgTdKvECtjpwBoA>
    <xmx:rD_XZF9VyIWXAH4mBd0hguIFI9vC3DaBc3FUSU23I-Q17Sia1EjUNg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Aug 2023 04:15:40 -0400 (EDT)
Date:   Sat, 12 Aug 2023 10:15:28 +0200
From:   Greg KH <greg@kroah.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y 0/4] Solve abrupt shutdowns from momentarily
 fluctuations
Message-ID: <2023081220-conjuror-backfield-aa8f@gregkh>
References: <20230811164031.24687-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811164031.24687-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 11, 2023 at 11:40:27AM -0500, Mario Limonciello wrote:
> Users have been reporting that momentary fluctuations can trigger a
> shutdown.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1267
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2779
> 
> This behavior has been fixed in kernel 6.5, and this series brings
> the solution to the LTS kernel.

All now queued up, thanks.

greg k-h
