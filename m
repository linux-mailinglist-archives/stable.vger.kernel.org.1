Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D17E8086
	for <lists+stable@lfdr.de>; Fri, 10 Nov 2023 19:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbjKJSNE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 10 Nov 2023 13:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345801AbjKJSL0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 10 Nov 2023 13:11:26 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F873A21B
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 07:03:28 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso2270542276.2
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699628607; x=1700233407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI+FAc5jUx2iUB/tuWRLdQMnq28TFVaG5me1J01BIf8=;
        b=y9V1NKpKF4d5L3P/DBn4TVIqL66A+IEcNHDf/ocQ9H7cZY8zPVSmvoe8tvcgcNI9iR
         V4mzFKc7bCNSAiFuMPJGTUH3vz0OUfuJTWqL6WDtjrDUBqo0Ysg6EOQw0TCFhQc1AJSx
         9SXmEEP8+wXWAxODqQOTD0L6lSMW+5YkNkCGGz5mxX6YgGV66N72Y61Z/hfBQmOTVsBH
         1SWt95Sr2aSYvszKNB6Vn0MrSmtN/WvBAY2yr/vUHPMVdvht5qU3jK2GM6X9Sr7B1DCq
         cG7cLDVNHb0iWNtXWhRHSI5FAkCK1LrneCA8rW1Sps4SeXtwhGH56uoV/KRy3BQtfBjl
         yEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699628607; x=1700233407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI+FAc5jUx2iUB/tuWRLdQMnq28TFVaG5me1J01BIf8=;
        b=Vm6xYpjlWLitjvkPV2lvAKF5RTBhZI7hzX55mKw+BE7bD13mZocLCIwUI/mKDQoBJ4
         ITlWrfXO2CmoFMZZGeMj6OrppZtuCnhKBC3x65+HtrdZv1gBHRXIj16bZaOMGtYlcsc/
         rANrINUznj1DELZMKLSixiCWKy/pgpMC9HCJyGECHsfkx2/b/RWxazlnZmx37PNQ5V+7
         3yXc+WuMgejBEPTsh3zKpE+hS5+OArr1HvX1H7TU3E/tFE+D3zgBAQcZKos2mSFK78a5
         U/BcT5DJn4hJ5XIKMWqA0dFJpo2/oE0sq75i/6ASspaPUjORpWf8VfziQxnUOfPXBaTA
         AGvw==
X-Gm-Message-State: AOJu0YzZoIft5Yi/6ioITR5X0r1wLljdCa3G7jMcTZ5q7jm1Ota3BwC4
        wF/5em/JLQgqTpiZL+nsXD0Ap1AIJ4sMsnWFHHsNJw==
X-Google-Smtp-Source: AGHT+IEQr+nD2hM97g1wEMewiNYcV+P/h9wqI2rtiaJOKCE6z3RIk8Z4M5U5zFWunLk3FdUgIGa/re/G/hYUqKHqlxQ=
X-Received: by 2002:a25:dccf:0:b0:d81:6151:2031 with SMTP id
 y198-20020a25dccf000000b00d8161512031mr7684797ybe.61.1699628607664; Fri, 10
 Nov 2023 07:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20231110093039.190076-1-robert.marko@sartura.hr>
In-Reply-To: <20231110093039.190076-1-robert.marko@sartura.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Nov 2023 16:03:15 +0100
Message-ID: <CACRpkdZ3UU=Zo7aqaYqZENHmEmy+hYMDNCFMw5hikMDKG1Skfg@mail.gmail.com>
Subject: Re: [PATCH] Revert "i2c: pxa: move to generic GPIO recovery"
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        wsa@kernel.org, codrin.ciubotariu@microchip.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 10, 2023 at 10:30=E2=80=AFAM Robert Marko <robert.marko@sartura=
.hr> wrote:

> This reverts commit 0b01392c18b9993a584f36ace1d61118772ad0ca.
>
> Conversion of PXA to generic I2C recovery, makes the I2C bus completely
> lock up if recovery pinctrl is present in the DT and I2C recovery is
> enabled.
>
> So, until the generic I2C recovery can also work with PXA lets revert
> to have working I2C and I2C recovery again.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: stable@vger.kernel.org # 5.11+

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
