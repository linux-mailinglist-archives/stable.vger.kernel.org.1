Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6043774E18C
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 00:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGJWqm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 18:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGJWqk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 18:46:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB4CE40
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 15:46:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so7892087e87.0
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689029195; x=1691621195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kc719wFeXIBZhxeGvf3Y+MTcIYRnee7N32RFrCgfHE=;
        b=DriSoHTaq8DDYG2ENp0wwmb3Z5QUSPyxY5SrE6+6Z51k9KtqcUJjP47DLF6CY71G5V
         jkjmQQu/2D6Jc9CNxE/lIpI4HgIbPOBnMVY/iD0+0CZ9Ti3XBt2bZQKhEtQq8xU5QJn9
         FaqtQvrTXHosqcXJk7njxc7ttpsNynZT3EWpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689029195; x=1691621195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kc719wFeXIBZhxeGvf3Y+MTcIYRnee7N32RFrCgfHE=;
        b=TWXeXkIinvOlW7loOCcviRfTJifT7J3fhnwkcoIxddLlwb1OCu52hGGm31P/DP8Gv0
         eHfL8fyaUD8M7gqwHHWLWE6zLGtFlB1CW9XtrKZmxT0JEOmTJUX6E38XM9/LWKrjIzOX
         9LqJr9LcG10GMNFCMeYRnJ9t+xbfZ4s+0h2DJb9aRAA409lJ+95CzcvrEBv/OvAtGKFC
         Z5y40WYs4rMN6TF8/2t1eC2ij0Qafzi3oKcsUiXVhacTGOe5Pj9hXwofvugtOEhx/2Uc
         yMU74EcrZ75lxrYSrUoC8NY30/t2b02gWntUtok5rU9qXyT2VbGSdIQLgAlvAgkru5rH
         Tsyg==
X-Gm-Message-State: ABy/qLYJwqz6hnztH72QFIhUjHdn33LPaCoNu3/6sm2W+Wvdwu2PlRWn
        s70C6XkjWcHN1ysWteMAiWhx9YfQfcBiselVyDU=
X-Google-Smtp-Source: APBJJlGIaWHHRA8rJWPqLe0t+z46ladGhRE80PNHBQ3M0TklZlbHFpYU2UOQmi81QBgrfIr90JD6nA==
X-Received: by 2002:a05:6512:b8e:b0:4f9:a542:91c with SMTP id b14-20020a0565120b8e00b004f9a542091cmr14222695lfv.3.1689029194041;
        Mon, 10 Jul 2023 15:46:34 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id u7-20020aa7d0c7000000b0051a2d2f82fdsm275470edo.6.2023.07.10.15.46.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 15:46:33 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98de21518fbso657920466b.0
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 15:46:33 -0700 (PDT)
X-Received: by 2002:a17:906:242:b0:993:ce6c:685c with SMTP id
 2-20020a170906024200b00993ce6c685cmr14230852ejl.18.1689029192682; Mon, 10 Jul
 2023 15:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230702195057.1787686-1-sashal@kernel.org>
In-Reply-To: <20230702195057.1787686-1-sashal@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 10 Jul 2023 15:46:21 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMZ_ZnJfpsY-8ZRByiox8HCSZeY08MvGSpznLYBtVR1bw@mail.gmail.com>
Message-ID: <CA+ASDXMZ_ZnJfpsY-8ZRByiox8HCSZeY08MvGSpznLYBtVR1bw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.4 01/12] platform/chrome: cros_ec: Report EC
 panic as uevent
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rob Barnes <robbarnes@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Jul 2, 2023 at 12:51=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Rob Barnes <robbarnes@google.com>
>
> [ Upstream commit 2cbf475a04b2ae3d722bbe41742e5d874a027fc3 ]
>
> Create a uevent when an EC panic is detected. This will allow udev rules
> to trigger when a panic occurs. For example, a udev rule could be added t=
o
> capture an EC coredump. This approach avoids the need to stuff all the
> processing into the driver.
>
> Signed-off-by: Rob Barnes <robbarnes@google.com>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Link: https://lore.kernel.org/r/20230509232624.3120347-1-robbarnes@google=
.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 3 +++
>  1 file changed, 3 insertions(+)

What sorcery determined this was a valid for-linux-stable patch? It's
a new feature, and definitely not a for-stable candidate. Please
remove this from the queue.

Brian
