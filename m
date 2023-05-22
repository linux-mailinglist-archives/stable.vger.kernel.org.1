Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581C070C579
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 20:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjEVSpA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEVSo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 14:44:59 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A0C4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 11:44:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 40EE33200985;
        Mon, 22 May 2023 14:44:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 May 2023 14:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684781094; x=1684867494; bh=oW
        HzqSS5SWwc0AK2j+NM91Ltw2tR5Lq81u/cbtVtU1I=; b=ViTlYrw2odYbib70KE
        tcxvq/FMKdaNwB8olVcnFbygQKc8rblyNgbfVPaDqpWH+A+DE8xn8c/LYO51d9FI
        aMycytfpfiJOdPe6veJF7Daw+LlNE0VRhZxpU239A4U5wgaJXIYXN+gv588rBC+f
        lIyzC3LAh/oZAk2gx/BXVkFClhWmtr83LSXL3RFNkko5pszQk8q6ZyF2mUpZo7Vp
        xDHsk3tvl7TSP/NKN3ypWyWj6kgemXOVmL2QM0Cv8ZiLtswm9gi9PRbyTjwPicyi
        wHgquyBCIRg5CETUKf5/1pSQ7FmHZhJoHS7nI6E8AewnAKUftFXw0SyDdan2SsVt
        i9rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684781094; x=1684867494; bh=oWHzqSS5SWwc0
        AK2j+NM91Ltw2tR5Lq81u/cbtVtU1I=; b=SLvpOCGEKe1RAgHCT5xW7LSUHWWYu
        9tmAIqxV/KcF4JCyYH5UeHHfrqSk3J7o9u5CahwFsBj8GCvFO26VfpRkI/jtGY2C
        xjeF0D6W57B4vHoIK9VkznTPK5TtFwReM+7pOQS2hSwd687POcJPu4Php4LjisGb
        VRAL3Er/p9LxYE9NJXUIlIWuS65PD2FDRnfqT9ahHZzipgc20J1pFxFRl5kzQA8L
        YJIT6PCflefs/zh7O3IsIYc6rB1A5B1R1p/lAqcJyFzQEIP+TPyRlsneX7elOAXt
        CG04/qvE2BM+fI8FTAhRAoWVNfeXXm3hYdLGW1RWa82kwIH7/IHyaDa3A==
X-ME-Sender: <xms:JrhrZICU-nfE7m_sGR8svrImESJUB6feQ90YN4-6oc6ETjPeY8TuUw>
    <xme:JrhrZKhWEmVtB5sDXagzmGQ8QHA5QQwInCjCo51lnCgBwjIeZnYgu8piRjIO_B42E
    -cgDYG_J9IV1g>
X-ME-Received: <xmr:JrhrZLkt6gy-zpOLG2Zjdgl-2PrSImg1v4Gob_YA2Ng3fvVL67furPk31tRUXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:JrhrZOwZOb53X-atqVYqCgS_bKG8DeWBQlldOMfyYVgycHBacssxcA>
    <xmx:JrhrZNTVbRUWij3uiCJEUYelN3t8-cZkTOgUxkItpxaUvWyLFOTC7g>
    <xmx:JrhrZJYfN0a22f0AaA4PAPJ-xk_Havx03IbdVpwwWVS9jeZhWKO2Dw>
    <xmx:JrhrZLN_cw7lLXgaWkg21k48I_jRwl5PU3VDosQ7D1KYHPjnGN1Ytw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 14:44:54 -0400 (EDT)
Date:   Mon, 22 May 2023 19:44:52 +0100
From:   Greg KH <greg@kroah.com>
To:     "Gong, Richard" <richard.gong@amd.com>
Cc:     stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Avoid MES hangs from new MES firmware
Message-ID: <2023052246-superhero-impotency-77a3@gregkh>
References: <42f0a7f4-f53a-7fc2-6682-05ff1350f9c7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f0a7f4-f53a-7fc2-6682-05ff1350f9c7@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 15, 2023 at 02:43:38PM -0500, Gong, Richard wrote:
> Hi,
> 
> The following commits are required for the stable kernels to avoid MES
> (MicroEngine Scheduler) hangs from new MES firmware running with AMDGPU
> driver.
> 
> Commits needed for 6.1.y
> 	a462ef872fd1 "drm/amdgpu: declare firmware for new MES 11.0.4"
> 	97998b893c30 "drm/amd/amdgpu: introduce gc_*_mes_2.bin v2"
> 	8855818ce755 "drm/amdgpu: reserve the old gc_11_0_*_mes.bin"
> 
> Commits needed for 6.2.y and 6.3.y:
> 	97998b893c30 "drm/amd/amdgpu: introduce gc_*_mes_2.bin v2"
> 	8855818ce755 "drm/amdgpu: reserve the old gc_11_0_*_mes.bin"

Now queued up, thanks.

greg k-h
