Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088EB7DB471
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 08:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjJ3Hg6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 03:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3Hg5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 03:36:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675E4B7
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 00:36:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so2816459f8f.2
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698651414; x=1699256214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTWIqNEdZPt84GdZ0kCbJ0/cGxU84NhsQwnSSMFolJA=;
        b=Z3JXxI9APeIfmVJYybJC2dwDTp3nbkFQr+YwfdALc/jW91CWq8wzP9VuGAmyiXYybh
         1xyTGnJv9/btsS+P9mXNq1pk7Bc2EcqB5XUugw8KKaM835AUHz1mexkpViB0vJvgafBH
         3Bi38vZ3yuoY1i7IRTXa+Xf//9sNAOKKex6SNeZ7ARNpjtQ0/z+51IpfU6+vLVtn6m/C
         /N8XjgZTS/mEu9YR3QQhddp3u2Q7wqM8Y8zU3/2rFKV+oKg0KAo8dKidTM72VPacfY9T
         qXR/FSLnQKDQsJNArz6rhs294aCcGDXQpPCF6zud0CaoD7A3edgQS1u8PcekXWGBTEF6
         CqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651414; x=1699256214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTWIqNEdZPt84GdZ0kCbJ0/cGxU84NhsQwnSSMFolJA=;
        b=O3M70xiC3bsrfOrdi79+WPmrm8KTyH2sz5hjuWvzTOSvl2Oz+Fnl2u0kAsRKy8fiVd
         QNt7Mpt5H8oTgZCcogoiLVudIAKC2YaxXvyIMQviLgddPFSHK/ApcISvo+9GLCfGKkhf
         G74DUOI8hejFjPHRLoEUngo9eviccjQKSkexX3mhFDLjsISixIXwuKNeTT5YrIdhf/DE
         tit1QI60DTcCff6Vk+FV60D4wU8ct+mPWgDWOqda3gXBYfO+8cVnrghUXwrju1pg5qKl
         TLal00Cag6gZEK2PucpBj048wpJVGxFkFSzPO11qM9eb+yHskC3U1rov6Hvg6fQjcsIP
         zAKw==
X-Gm-Message-State: AOJu0YyaJN04uZGgM+HHHfu3wdVr/Vw6jwrH+qXQo5URQ5+g08gjVt9b
        9iHkKTkf2tNp1d8ydeVOkh0=
X-Google-Smtp-Source: AGHT+IELvQpIoAEpiHv2yBnEb57E/tYO8xR6n8jwgWxeLHI4mn9eofU42hY4Vc5BxxDOmhTGtjlSBQ==
X-Received: by 2002:adf:d1ed:0:b0:32f:810e:8a3f with SMTP id g13-20020adfd1ed000000b0032f810e8a3fmr3377250wrd.14.1698651413643;
        Mon, 30 Oct 2023 00:36:53 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id e14-20020a056000120e00b0032415213a6fsm7539581wrx.87.2023.10.30.00.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 00:36:53 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 6feb2f75;
        Mon, 30 Oct 2023 07:36:52 +0000 (UTC)
Date:   Mon, 30 Oct 2023 08:36:52 +0100
From:   David Lazar <dlazar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
Message-ID: <ZT9dFNuzff54RIzg@localhost>
References: <ZT6idniuWk88GxOm@localhost>
 <2023103019-evict-brutishly-5c7e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023103019-evict-brutishly-5c7e@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 30 Oct 2023, Greg KH wrote:
> On Sun, Oct 29, 2023 at 07:20:38PM +0100, David Lazar wrote:
> > commit 3bde7ec13c971445faade32172cb0b4370b841d9 upstream.
> 
> What stable kernel(s) are you wanting this applied to?

My apologies, I hadn't realized the surrounding code had been refactored
so recently.  The patch doesn't seem to apply cleanly to any stable
branches, so it's best to drop it for now.  I'll prepare separate
patches for 6.5.y and 6.1.y, as older kernels are missing the quirk
implementation.

Sorry for the noise.

-=[david]=-
