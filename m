Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F466F0288
	for <lists+stable@lfdr.de>; Thu, 27 Apr 2023 10:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbjD0I15 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbjD0I1x (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 04:27:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804D74C10
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 01:27:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A5FBF5C0218;
        Thu, 27 Apr 2023 04:27:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Apr 2023 04:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682584063; x=1682670463; bh=UJ
        KuchLp+O46D3V50IkbtAjoQVNkfogQk1pbeEVwzYE=; b=rGdBsBvnTqtVYVpVO6
        FXTJsZ5ROsYIcMArneaFv+r7yCL/QdWX6NplKHzyFMB/L4NMVbaQBD5memQlGr25
        OgOz8L+nFRrVu1KICIrVGw/gyBQron6gaUvygTNggweSq4xTFiL4AoDIiESX6v2d
        bAtVnm9wARLC2GnqlRRjsp6WONEpcciOgW+mv3tzct4m+z8Jewe6x0f6xUAqKAR2
        Jw5Yi3tdq7bip+qElna7NyZ6niyLymODoxPNhiN9KwEezAYPO2r/IjrdG/rnlKQX
        fJez/rbjMnek2oyOjmpuI/tS+N0Jv5tVCK8cjVDZIq7kAbkM6Z/WoWpVImHuHNsn
        tdWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682584063; x=1682670463; bh=UJKuchLp+O46D
        3V50IkbtAjoQVNkfogQk1pbeEVwzYE=; b=SXSzBX3rIToe7w4zSdeJkcSaN8Gq5
        PoPiC6bo8/s/oO7kcvn48VIFXoC5oL6pXcEG/V7T2YImkJxMb6FgDviNbE6J/kp7
        kMYb5n0gy8BXCwK2ffgkkF/fTp1Byq4MfFEpEaLjfC518JAp1lUSXh78T1hW8xTI
        Mk8i6zXd7clu9e6+0DYzqFOChU9bR5vM3qoQOh0PDeHTLGJ1vrS/qlLgG0FTUwCf
        FK+rqJ04o1YxZMJgcg2vFok6SsdeG+aJmqVrTZmqJ02I/+sNhWfMayr+Am7acxsm
        3XFohtX9xSzXnAknDsoAIYbCdrx0ZU7krWLmNFMQJ/lXu1lrK5ZB5UZoQ==
X-ME-Sender: <xms:_zFKZCFTbtsPCBIfjcXbobJsWLH4i217q_HYgamfJNSVn2wy7M4ong>
    <xme:_zFKZDUnCxX8Tf2duiKmOBV31wSPoKSw_N-qVw8bCuWDa371p0eBJo-8YqaKAB0Qm
    -FgJXN9IfBdbQ>
X-ME-Received: <xmr:_zFKZMKnNQ2OiStL7z7Pj2OCtiyfCkP2ktAeJmvHR16U2To7ArV53JC77POyOp5dpNvVsWsgu3K_qVBD8XkssoiUiLkuVBpi6Hl4pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:_zFKZMElTPyQma6gxER5nIltr9JrQx9fK5904OF5TKLJQDQ0ri2HDw>
    <xmx:_zFKZIU9hz4EDeekxdDCDT4HcTIMimYFuvusLZk_IyfJGYRFfItsWw>
    <xmx:_zFKZPNLXa7MUTDpTm-tAufDSFRmrkkSf70B79YGzunF1nOVC-rQJg>
    <xmx:_zFKZMoEhsH26nztAou72-4ifEnr92JhxF8nzB01gKeQX51X6x0Vng>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 04:27:42 -0400 (EDT)
Date:   Thu, 27 Apr 2023 10:27:39 +0200
From:   Greg KH <greg@kroah.com>
To:     Can Sun <cansun@arista.com>
Cc:     stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [BACKPORT PATCH 5.10.y] x86/fpu: Prevent FPU state corruption
Message-ID: <2023042721-wise-puzzle-b8cd@gregkh>
References: <20230426223508.71750-1-cansun@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426223508.71750-1-cansun@arista.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Apr 26, 2023 at 05:35:08PM -0500, Can Sun wrote:
> [ Upstream commit 59f5ede3bc0f00eb856425f636dab0c10feb06d8 ]
> 
> The FPU usage related to task FPU management is either protected by
> disabling interrupts (switch_to, return to user) or via fpregs_lock() which
> is a wrapper around local_bh_disable(). When kernel code wants to use the
> FPU then it has to check whether it is possible by calling irq_fpu_usable().
> 
> But the condition in irq_fpu_usable() is wrong. It allows FPU to be used
> when:
> 
>    !in_interrupt() || interrupted_user_mode() || interrupted_kernel_fpu_idle()
> 
> The latter is checking whether some other context already uses FPU in the
> kernel, but if that's not the case then it allows FPU to be used
> unconditionally even if the calling context interrupted a fpregs_lock()
> critical region. If that happens then the FPU state of the interrupted
> context becomes corrupted.
> 
> Allow in kernel FPU usage only when no other context has in kernel FPU
> usage and either the calling context is not hard interrupt context or the
> hard interrupt did not interrupt a local bottomhalf disabled region.
> 
> It's hard to find a proper Fixes tag as the condition was broken in one way
> or the other for a very long time and the eager/lazy FPU changes caused a
> lot of churn. Picked something remotely connected from the history.
> 
> This survived undetected for quite some time as FPU usage in interrupt
> context is rare, but the recent changes to the random code unearthed it at
> least on a kernel which had FPU debugging enabled. There is probably a
> higher rate of silent corruption as not all issues can be detected by the
> FPU debugging code. This will be addressed in a subsequent change.
> 
> Fixes: 5d2bd7009f30 ("x86, fpu: decouple non-lazy/eager fpu restore from xsave")
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Cc: stable@vger.kernel.org
> Cc: Can Sun <cansun@arista.com>

When you send on a patch that you backported, you need to also sign-off
on the change.

Please fix that up and resend.

thanks,

greg k-h
