Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799BA701633
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEMKiZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 06:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjEMKiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 06:38:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399AB10DC
        for <stable@vger.kernel.org>; Sat, 13 May 2023 03:38:23 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB8F41EC0104;
        Sat, 13 May 2023 12:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683974301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d4Y5hOiL69O1nImzk0m6UCnsyfDN3e2mM5BxcwxWWwY=;
        b=LfUgDVZoVB0EL+Xg1tykyAB4zNRAEc9sfYr4U+ey+7/iqP/L1CN4vLeikb7k0Maq5V3EN1
        64G/D1FOHI3Dh3GH/PtZRE/nLLUSehe+X60JmeRgiXi2NiLqQo2v71CFCyOUyOtfeaQAVW
        P5TwxzBNnRww17DzLDryNe/NpHArXLs=
Date:   Sat, 13 May 2023 12:38:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/retbleed: Fix return thunk alignment"
 failed to apply to 5.15-stable tree
Message-ID: <20230513103821.GEZF9onfBEuKncgUkI@fat_crate.local>
References: <2023051313-wrangle-brick-b43d@gregkh>
 <20230513102107.GCZF9kk4OdTl0z2qbW@fat_crate.local>
 <2023051353-robbing-idealness-e9ce@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023051353-robbing-idealness-e9ce@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 13, 2023 at 07:35:05PM +0900, Greg KH wrote:
> Great, thanks for looking into this, much appreciated.

Sure, np.

And I just checked the 6.x streams - yes the backport is needed there
so you taking them there is good. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
