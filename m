Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA77D0141
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 20:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjJSSTz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjJSSTz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 14:19:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8B11D
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 11:19:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so1837a12.1
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697739592; x=1698344392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46xcFmni0pH0uS3X/n5DvOraRiCSHfNtVuPTmaYS78M=;
        b=3y+nq1orOmxrNfkQTUfV6f3OHdgBGRlga0pJnlwq3m1PZwugkECx+mFLl6Um6DiCMR
         biD/zCuM3jfT8fiwkpodah6e4yqn6N3jk9q2W3i+NG2DfnWP31Nhaq+WyIw1thVTczv3
         WSByMz2RMzaumdd3S+Zz8H0gYebfLx1YSvIKD87nantzcM1ogEBOHYzPGRZhN6SdxDvu
         mC7rnZpuTW0GhCwIFeHpDUPNGX97+X3iz+1JVDQkfVjsnz4lViEj04W0Q/Ve1XAs2M+u
         JdzBrYLWEYEvuKq6+J8BJT02JaoyloF2EkQ4yx4I/H8CyUBOHR/L2WymtkqOsYrYt6qx
         99+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739592; x=1698344392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46xcFmni0pH0uS3X/n5DvOraRiCSHfNtVuPTmaYS78M=;
        b=FCI3qbbwdBOtyHHA+rMh2JQuyB47fcPdGl50UyBVjkqOtZB6pIfXLGPlmq3KTEzm9R
         G5I7xjKjCqf+N+179HjOSiQ6aNMYrIyeUBESDfxNRjWvwG1ROE1+abQ3ngnjrDTufhNn
         FoGDOXQIVGGXmUsZM9LHkE89rWJjBnmY3wr3NngAmXIqZSh1WA6dO7GgLbo8rIsuRkgp
         obX0JYXIcDAgJkndQCOkCroeXYDfH4N591lMtJqMcx1i2IcOAz3zmFdu7SY/o7igRM6x
         00m/XZJJKIbIrog7kL67ikoHekxqM51+zeLc0eovfUXOvY9RhtV5/aHBpAgeiv/R/POx
         i58A==
X-Gm-Message-State: AOJu0Yww69CtVEdUxAgQrWNjOvPHrubHvkG4k9FL48Nm2DR3PMkVE0yJ
        94elKZRVfky/VH/Jq3OC5w9vtQmyzgUDYkpJhd6xZFayUuwM6TnrqhAFJQ==
X-Google-Smtp-Source: AGHT+IEybhkFpRe1dj+Mc94Cm8KlrthMu91bD9pCnm3UaHzW+10ShcLQZYBl99H8BpJ0pbiL9410vfG/483PTbbz7gg=
X-Received: by 2002:a50:d49e:0:b0:53f:90a8:2794 with SMTP id
 s30-20020a50d49e000000b0053f90a82794mr10062edi.0.1697739591773; Thu, 19 Oct
 2023 11:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANP3RGdzJ7RYWkMT_zNXbg0FyPcCF4rixABvF0++OR-2gpEtow@mail.gmail.com>
 <CANP3RGe82EQhdKd_sc7kWDm2jqx1jTa-Rnj23xBSVpFvK_-T2Q@mail.gmail.com>
 <20231016082913.GB3502392@pengutronix.de> <CANP3RGfp9dNun7-gAarqXo71ay2jeLnqO6eJzmXpNKAmXYeosw@mail.gmail.com>
 <20231017042029.GA3539182@pengutronix.de> <CANP3RGfRP2yHnNgjj0eGBJ8VpANJg4dnR74aoDUm4UOBuOO8_w@mail.gmail.com>
In-Reply-To: <CANP3RGfRP2yHnNgjj0eGBJ8VpANJg4dnR74aoDUm4UOBuOO8_w@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 19 Oct 2023 11:19:33 -0700
Message-ID: <CANP3RGebp-iPBFCvQ8beRGokL_bj_Zm_Yn-v3z_MLyF+fAsd=g@mail.gmail.com>
Subject: Re: USB_NET_AX8817X dependency on AX88796B_PHY
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> I take this to mean you think that the built-in ax88772C PHY should
> work out of the box with 5.10,
> and if it doesn't then this presumably means there's something wrong
> at the usb controller level.
> (hopefully I'll get a second unit and be able to confirm this...)

Just to follow up on this.

I got my hands on a second identical adapter (the one that got the bug
filed in the first place).

It behaves (ie. fails) in exactly the same way.
ie. dmesg (on multiple devices, but only on some usb-c ports) doesn't
even show usb connect events, nothing on lsusb (of course), etc.

(The fact that both of these adapters work on exactly the same 1 of 2
usb-c ports on my lenovo thinkpad laptop is particularly weird...
you'd think those would be identical...)

I'm going to blame this on usb controller compatibility issues.

I'll have to track down someone with a usb wire sniffer and a desire
to debug this further.
