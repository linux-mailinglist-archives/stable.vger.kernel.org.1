Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78773718462
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 16:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbjEaOLx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 10:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjEaOLc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 10:11:32 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D51BE7
        for <stable@vger.kernel.org>; Wed, 31 May 2023 07:08:16 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6af70ff2761so2819605a34.0
        for <stable@vger.kernel.org>; Wed, 31 May 2023 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685542039; x=1688134039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vEqY/E4kBl9Nf1zMfIIL6jodud4pGK1JF+jErJgfEs=;
        b=aphehvGJRQ2fRQbGRjD660QLyDUsz7GXWKa5ZG2u5SOAxJcmIOZM1clTHbU1ESbfGL
         jrKbp7iKNVuPWEL37XxAp+pyvQjbvwg4tZJ53FCx4cTAxJaLjN7HJ9mI+4XvDPVQEtlz
         d1TCECvnkcpIhiJS1aV6RchKok6BNH1l681jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542039; x=1688134039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vEqY/E4kBl9Nf1zMfIIL6jodud4pGK1JF+jErJgfEs=;
        b=DTOGfEO8h0oyMp8NFk/1vWdXokddHHFMR7MO159WyWtXLMZPX6osi7DjUm5S1mT9Gt
         pAjkjSyizW1FF8Gtm9YAo7mM7751igzPcuZWEQ+QrYRd7iowOUGPal5mx2F/yGzqyL3t
         bvFbC7efPur+7wBHUh+i/qeR35PNWBoRVHmh8AxpzRDd3FgeaWcoyveZ9m+lt3XAuPWP
         iZ0XXGBwuVsD2/17AC/xkLQrivy3oZexeFr73PlKFn/FoPwuS5UmKujFfFgsgQS81+Kp
         qewvemWxgEReUur2twuFBB2t9i8L07+ltA43rAIxL/upLJjWa6ol+v0Vrwkumio1NvOF
         UIAA==
X-Gm-Message-State: AC+VfDxZZ4wXqBEFlqJeUk5D+Nw6kwdOSBLgQoEYLNHslb92TYBM9Yxx
        4ZjRKhWxk52Pqh7W7XSPR7oz/cLu11y+8D3nQJw=
X-Google-Smtp-Source: ACHHUZ6JpKICxbAQ2wTzW/CY6Jlbp8GsugE8jBwiesTUPTcZSNSLzy/jMZEssWS1lJcM3WuwwBMQdA==
X-Received: by 2002:a17:90b:1b49:b0:255:4635:830c with SMTP id nv9-20020a17090b1b4900b002554635830cmr4440380pjb.40.1685541528912;
        Wed, 31 May 2023 06:58:48 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id z7-20020a17090a468700b00246f9725ffcsm1270201pjf.33.2023.05.31.06.58.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:58:48 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b025aaeddbso126425ad.1
        for <stable@vger.kernel.org>; Wed, 31 May 2023 06:58:47 -0700 (PDT)
X-Received: by 2002:a17:903:7cb:b0:1ab:2763:e003 with SMTP id
 ko11-20020a17090307cb00b001ab2763e003mr110372plb.17.1685541527389; Wed, 31
 May 2023 06:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230531134020.3383253-1-sashal@kernel.org> <20230531134020.3383253-12-sashal@kernel.org>
In-Reply-To: <20230531134020.3383253-12-sashal@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 May 2023 06:58:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WpsV8hZBkHVbVCSkatnkGN=oMebEGykGDvaOr+2yyikQ@mail.gmail.com>
Message-ID: <CAD=FV=WpsV8hZBkHVbVCSkatnkGN=oMebEGykGDvaOr+2yyikQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.3 12/37] irqchip/gic-v3: Disable pseudo NMIs on
 Mediatek devices w/ firmware issues
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 6:40=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Douglas Anderson <dianders@chromium.org>
>
> [ Upstream commit 44bd78dd2b8897f59b7e3963f088caadb7e4f047 ]
>
> Some Chromebooks with Mediatek SoCs have a problem where the firmware
> doesn't properly save/restore certain GICR registers. Newer
> Chromebooks should fix this issue and we may be able to do firmware
> updates for old Chromebooks. At the moment, the only known issue with
> these Chromebooks is that we can't enable "pseudo NMIs" since the
> priority register can be lost. Enabling "pseudo NMIs" on Chromebooks
> with the problematic firmware causes crashes and freezes.
>
> Let's detect devices with this problem and then disable "pseudo NMIs"
> on them. We'll detect the problem by looking for the presence of the
> "mediatek,broken-save-restore-fw" property in the GIC device tree
> node. Any devices with fixed firmware will not have this property.
>
> Our detection plan works because we never bake a Chromebook's device
> tree into firmware. Instead, device trees are always bundled with the
> kernel. We'll update the device trees of all affected Chromebooks and
> then we'll never enable "pseudo NMI" on a kernel that is bundled with
> old device trees. When a firmware update is shipped that fixes this
> issue it will know to patch the device tree to remove the property.
>
> In order to make this work, the quick detection mechanism of the GICv3
> code is extended to be able to look for properties in addition to
> looking at "compatible".
>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20230515131353.v2.2.I88dc0a0eb1d9d537de61=
604cd8994ecc55c0cac1@changeid
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/irqchip/irq-gic-common.c |  8 ++++++--
>  drivers/irqchip/irq-gic-common.h |  1 +
>  drivers/irqchip/irq-gic-v3.c     | 20 ++++++++++++++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)

Please delay picking this across all stable versions unless until you
can also get Marc's fix:

https://lore.kernel.org/r/168544149933.404.717399647227994720.tip-bot2@tip-=
bot2

-Doug
