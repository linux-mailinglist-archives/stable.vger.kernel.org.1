Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6374A7EB0C2
	for <lists+stable@lfdr.de>; Tue, 14 Nov 2023 14:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjKNNV5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 14 Nov 2023 08:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjKNNV4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 14 Nov 2023 08:21:56 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F41AD
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 05:21:53 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da41acaea52so5737948276.3
        for <stable@vger.kernel.org>; Tue, 14 Nov 2023 05:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699968112; x=1700572912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BeJ22vqMxUogoMw/G3OvqPi0ZGBXIP/Uhk54+KkFXs=;
        b=TKK5+0hBcgjtgvC9WweXjd9ZpN6mzgcqylASHW5yBUnKOQgk0GbOHRD/l70y/XcEmH
         liSG5saSsnYIp/hqH/gK96QsR1N5/xFQ+yCa2/yLNENdc5cBIU0Ap9/nH6aCy/vzxkBd
         Y8CrOVkURhsLhDPze2898zBPE7JqLYExP+KUTMW3iNddetipiOE1t4dwgRX6StEdztdq
         rAM+bRGJF1aDZWvvGPAri6IgAHXeVGwkEmEmKqCgR2QliSKwC88SvQzyLV1E/uRVOfJE
         OKQZKlrjwN3WUpRyjL2ci/tr692m6B8K4zNAhHz1GPUmWXZP+TctrrqlM3ipWm1/QgBp
         i+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699968112; x=1700572912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BeJ22vqMxUogoMw/G3OvqPi0ZGBXIP/Uhk54+KkFXs=;
        b=FE+zJZ6VKHA+BG8E15lAmk6+wlnuwTEhMLtGgo7K05Cm1mA7iJf2Si4YneI9HVe69g
         RHrEDpkMHBn3HOtD54eN4Ay1s95t9WheU4F62l+0Cm888WKy2gmnunXDZYMpyV80Iyhc
         /rIPY2X1iKYJ5GYlaDlFpbUmvZ2Jjxj6dQ1Rin3B5bGXHJMNp6FWRI2uI8R81nEsicsR
         EcaN37+fCooJzfGq35steJ+vmNAv/VROknpm0EBnsf9DbmQiyZZXcH376/9SyRFdrscj
         5qJCNNGeiJxjHt7yj3vdEatNFnEnpbL2m7wPajL+YLr2zd6hNKLxRv/jvLw+T10n8twf
         yEdQ==
X-Gm-Message-State: AOJu0YyJjVy2+4eBNBe+r3G6AKg6qKJJj7bYEnWpqBQllSUKi6RjEu1a
        67brBKqmaL/obQea86xbKaLiGa0B1+qusk5AEgM5Ww==
X-Google-Smtp-Source: AGHT+IEC+FO5ylFXSYKgv3HSp4wJLdFuKkqOYkdrsHBgrdaa8AXrmqj63uQCDeIPHCFOfaSdTOggDS/bkVYrK6nehh0=
X-Received: by 2002:a25:ac21:0:b0:d84:da24:96de with SMTP id
 w33-20020a25ac21000000b00d84da2496demr9377607ybi.33.1699968112256; Tue, 14
 Nov 2023 05:21:52 -0800 (PST)
MIME-Version: 1.0
References: <20231114085258.2378-1-quic_aiquny@quicinc.com>
In-Reply-To: <20231114085258.2378-1-quic_aiquny@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:21:41 +0100
Message-ID: <CACRpkdYgyASV6ttW=AeAWSh3oiFDk9_Q1WV00=7yTxtuhpdXEg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: avoid reload of p state in interation
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Maria,

thanks for your patch!

On Tue, Nov 14, 2023 at 9:54=E2=80=AFAM Maria Yu <quic_aiquny@quicinc.com> =
wrote:

> When in the list_for_each_entry interation, reload of p->state->settings
> with a local setting from old_state will makes the list interation in a
> infite loop.
>
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>

This makes sense in a way, since this is a compiler-dependent problem,
can you state in the commit message which compiler and architecture
you see this on?

If it is a regression, should this also be queued for stable? (I guess so?)

Yours,
Linus Walleij
