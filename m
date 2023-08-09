Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C91775439
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjHIHeg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 03:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjHIHeg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 03:34:36 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80771172A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 00:34:35 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-79acc14c09eso1777954241.1
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691566474; x=1692171274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyhg2pANKD68dgMgU9DabYU5m+ytOR6lQNIOfsZ9UzI=;
        b=g0tKX2DCyORwzEhoeazVPVOaGIy2uWwv3HedMFwoKSZJLtz+Iy7iyju0sBSoLONO7c
         jfJH4kjW/4GXCN8MaeSWer1nMtst0bZMRFfTQkdUkQxy7zAks1PABdEh+fPX/HK462dN
         bSeaFw8wGfwM9/zMCcFyo/4KoYTGD+sC95HM6Bv/zwxZDrg4ThDoMiluKVGLn8RCoeFH
         lKdqS2Wg5yf/JrhcebkljDFRPMmFLLb7RO0snqi31iEqB7j7jZM3AY930jCW7xrJkAef
         R3fyfkprNiUK9EX7QbuUtvC8Vgn5AqcGKFkk1nvis6zMrOFVzPDUPY2Eu9QXh9woBtjn
         DAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566474; x=1692171274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oyhg2pANKD68dgMgU9DabYU5m+ytOR6lQNIOfsZ9UzI=;
        b=Tgryxap1ooj+N+wn8wGa1Ppb737y+qqd4YHHDX/LwJwOOv7NFvD7eJ826UNc95YQMo
         ICiEMBILi6VHVEXj5/Llh8EFdLU3M8r867MFgqUrGdZBtTnH7KmnQFbceyMD5QIpV329
         6K4cHZMYdgxlshkPdX75wHGdoQzTMz9N22X0mCGXGXBijhazibHUrkY/EjyE+ylAd6tS
         cjgRFXMBw9fH9v41vFdJ3AsC/x3k1jLL+9q3zYDiQqfqjoHYxaxgUdXn/AJVRmYrg/RB
         kr5sJmL60buA6bpAz2SdgY9iTRN/swdNNjg6mCbzIcwqcggNBL/tIn4VrX3ZyoR4h3oI
         S3fQ==
X-Gm-Message-State: AOJu0Yz1JljhdxUL2NcA9FLYGZlx3UxeQy18odR9C6MNiQkyIGeOUXSb
        dfmkl2L/+or/w45RIow2a1dYxtdqLJi+RjNfm8ivFw==
X-Google-Smtp-Source: AGHT+IHUHomkKQLuc2ockx5qqoKtNjm8EUSuGamSC4pxg/F8ldsdG3lijuTReykUZ/A/lSn4lW2qUkjfcLC9xGb/+sg=
X-Received: by 2002:a05:6102:446:b0:447:68a0:a11a with SMTP id
 e6-20020a056102044600b0044768a0a11amr1211673vsq.2.1691566474521; Wed, 09 Aug
 2023 00:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt86w3Z+XeZjbjcOq_hvpkx=uUZS3ecH_nQGfBn9KaX3A@mail.gmail.com>
 <2023080953-boxcar-dart-6ac7@gregkh>
In-Reply-To: <2023080953-boxcar-dart-6ac7@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Aug 2023 13:04:20 +0530
Message-ID: <CA+G9fYuHmZuAscesHQsGYz_aG-6nUkCBXWuMgxem=_8Ln60-Eg@mail.gmail.com>
Subject: Re: stable-rc: 4.19: i386: build warnings / errors
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 9 Aug 2023 at 12:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 09, 2023 at 12:44:00PM +0530, Naresh Kamboju wrote:
> > LKFT build plans updated with toolchain gcc-13 and here is the report.
> >
> > While building Linux stable rc 4.19 i386 with gcc-13 failed due to
> > following warnings / errors.
>
> I'm amazed that this is all the issues you found, I gave up due to all
> of the build issues.
>
> If you care about 4.19 (and any other kernel tree) with newer compilers,
> I will gladly take patches/backports for these issues.  But to just
> report them like this isn't going to get very far as I doubt anyone who
> actually uses 4.19 will ever use gcc-13.

I totally agree with this old tree and the latest toolchains builds are not a
great combination. I will not send any reports like this in the future.

- Naresh
