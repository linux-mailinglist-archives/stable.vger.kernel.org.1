Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36DD701630
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjEMKej (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 06:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjEMKei (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 06:34:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B313FE72
        for <stable@vger.kernel.org>; Sat, 13 May 2023 03:34:37 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F21D81EC0104;
        Sat, 13 May 2023 12:34:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683974076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WowZQ+mj9yrT6F5FE6WOBTRT1Ye15jsqbpYewV4qwr8=;
        b=h2F4JR+bWGXyY3viT2ZhzPUEDuVWo6mDuIlVMUgcEs/sXbY0JQwSTLfqjiOjJl/gEKVsNp
        QKWyBXwvB7nklc2mLmY0ntf7g1puqOMqSZt1Tz7a8pVMbav+SKYAkCToKf1VaShGtkMikg
        nYFrTt2Tdiv2kbb738yMp0FZWH1ZfPk=
Date:   Sat, 13 May 2023 12:34:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     gregkh@linuxfoundation.org
Cc:     stable@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/retbleed: Fix return thunk alignment"
 failed to apply to 5.10-stable tree
Message-ID: <20230513103432.GDZF9nuPNuUn8hxKNX@fat_crate.local>
References: <2023051308-reflected-pessimism-42d1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023051308-reflected-pessimism-42d1@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 13, 2023 at 05:17:08PM +0900, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Same situation as 5.15 - see my reply there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
