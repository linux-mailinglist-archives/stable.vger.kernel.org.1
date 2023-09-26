Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C111F7AEB64
	for <lists+stable@lfdr.de>; Tue, 26 Sep 2023 13:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjIZLX2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 26 Sep 2023 07:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIZLX1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 26 Sep 2023 07:23:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67210C
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 04:23:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405524e6769so39115315e9.1
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695727398; x=1696332198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMeSzzLlxhV04SlweKcnZdB57NwdycsgJqov1wCWtTc=;
        b=OXqjNAf7W58kUJdE8jFMQbCKrd1RJAUNMUP6SIkd4Kshr8QzvJT2Y016wPq0cWxEjP
         yKaWfYqZlysH9Zq4xX2Z86AdqftZtmCoZH6DWU9DHtO5XlRAzncLi1dgEiWC5A3SHf5F
         5P88golj681nOIJABjKJ2T3PsJn3WhzsyU9RB5TutphxeZb5o2WCiSNA16FfuRaW/nFx
         +NmA9NUbjgEOAjk72I4nFTi8HHb6443TWTDcPWNiTgaAmHUz40o5/5T2gjiDOjrbJmH9
         TUwEpwi/6zL8MH2REZvruyypWFzknWfh1dsIkN0WAGnJy4baFs59aTr154kUX1D8Pqck
         Q3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727398; x=1696332198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMeSzzLlxhV04SlweKcnZdB57NwdycsgJqov1wCWtTc=;
        b=G19PF22m8XxfdFf/M6/iV1k6QYO4TY2nR7WdcIJuQSl0MdFIRuQOtRKq/iVBJflWwV
         ZTwoV3xZSKlbjhGQQhQ7yJL85pp0mYes5VSu1fG4fhPW+vwClSfI+nyHdzR3VU+y07jv
         GST2K8j2M5rw8hS2ehgYHQztXfBsRaAzTFmW5P/wBb6gswMloxhWKshMK0s0nn4b7KwQ
         QXnJbXCNuHvgRslygKjpvpYhS69b281RThYZX6zIIFCKlJsvDiHqZq8QvlqPJsoPLU7B
         wOFhZ9TAFcg0PI+5EJLSb3bVCmpv/KfkRS3ORtWZVzHfyY8uXQcoK6sU3UL+ISj/Mtfk
         /gAw==
X-Gm-Message-State: AOJu0YzF+c9oz6hqi3BkjjT5zgHs4cPx8G5NI4p9Hjc4vAB5s/92Zlu7
        HKxxjmo3DXdnmK/ZjUqE33s=
X-Google-Smtp-Source: AGHT+IEPmizr+2spNBYC/XCrjjUHvrZN8VOt/YC0yj7mg2vIymhmwjKbjw/gtnZ8KLuTWQZk/BGzgg==
X-Received: by 2002:a1c:7907:0:b0:402:f8e3:93 with SMTP id l7-20020a1c7907000000b00402f8e30093mr1848145wme.10.1695727397854;
        Tue, 26 Sep 2023 04:23:17 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fefaf299b6sm3330603wml.38.2023.09.26.04.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:23:14 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 1F994BE2DE0; Tue, 26 Sep 2023 13:23:14 +0200 (CEST)
Date:   Tue, 26 Sep 2023 13:23:14 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Paul Grandperrin <paul.grandperrin@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Wei_wang <wei_wang@realsil.com.cn>,
        Roger Tseng <rogerable@realtek.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from
 drivers/misc/cardreader breaks NVME power state, preventing system boot
Message-ID: <ZRK_Iqj1ZSjx1fZS@eldamar.lan>
References: <5DHV0S.D0F751ZF65JA1@gmail.com>
 <82469f2f-59e4-49d5-823d-344589cbb119@leemhuis.info>
 <2023091333-fiftieth-trustless-d69d@gregkh>
 <7991b5bd7fb5469c971a2984194e815f@realtek.com>
 <2023091921-unscented-renegade-6495@gregkh>
 <995632624f0e4d26b73fb934a8eeaebc@realtek.com>
 <2023092041-shopper-prozac-0640@gregkh>
 <3ddcf5fae0164fbda79081650da79600@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddcf5fae0164fbda79081650da79600@realtek.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi

[apologies if I missed some followup but was not able to find the
answer]

On Wed, Sep 20, 2023 at 08:32:17AM +0000, Ricky WU wrote:
> > On Wed, Sep 20, 2023 at 07:30:00AM +0000, Ricky WU wrote:
> > > Hi Greg k-h,
> > >
> > > This patch is our solution for this issue...
> > > And now how can I push this?
> > 
> > Submit it properly like any other patch, what is preventing that from
> > happening?
> > 
> 
> (commit 8ee39ec) some reader no longer force #CLKREQ to low when system need to enter ASPM.
> But some platform maybe not implement complete ASPM? I don't know..... it causes problems...
> 
> Like in the past Only the platform support L1ss we release the #CLKREQ.
> But new patch we move the judgment (L1ss) to probe, because we met some host will clean the config space from S3 or some power saving mode 
> And also we think just to read config space one time when the driver start is enough  

Is there a potential fix which is queued for this or would be the
safest option to unbreak the regression to revert the commit in the
stable trees temporarily?

I'm asking because in Debian we got the report at 
https://bugs.debian.org/1052063 

(and ideally to unbreak the situation for the user I would like to
include a fix in the next upload we do, but following what you as
upstream will do ideally).

Regards,
Salvatore
