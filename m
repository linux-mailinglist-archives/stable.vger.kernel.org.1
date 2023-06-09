Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C272A2D1
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 21:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjFITGg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFITGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 15:06:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2035BE
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 12:06:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977c89c47bdso372895566b.2
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 12:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686337592; x=1688929592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+ONXQdK4a1fSmqiExKhyWkPlcAP+HPrxGCh1eVdlew=;
        b=Cv68Dy34qfiDrivaElTOV8z1kkFw17nNzXJkh+M26LPyyk3hUBr9bD5nna7A8Y01cS
         PQsabNvycR8KhEwSlekBvj/zZmJCzVVl6LBg+vYjIFtAfoHPFmQqiT9WbPYUIJTBLf6g
         AXVq7ecgVB9FKw6eP7lVOa910fpgl7tHaGutk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337592; x=1688929592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+ONXQdK4a1fSmqiExKhyWkPlcAP+HPrxGCh1eVdlew=;
        b=J+AAbnlDLrVgeXfknllh2qn2BCeW6Lakx8bvr5W0/p4eA1he/LUgUGrHEt5NLiGAE5
         4neFkTNn1uWRTs308gtJ7o9wBkjw+E6eB9u5zbnHhLIsR6gFfmBwICj6hKRi0MC8JU6l
         jX5Gmm1xdpgBQ8SL89/C4k10cNg/rpcyBt91Qe4ZLTjoNHX/0U0uDsbHFSdKDaON39eG
         hkKzkPTxkiM+P7dgCgM34+oT7VyRUx5orXm3xRnrXMVBG58V2zaJN/mGPq5L11+DJxcQ
         pFANMhVI8T/P9UlCvhI1nhmzVmA9RdpIsRIBkp1jCb7ZVdcPKJD4BaDmdLGSfvquwpS6
         nuoA==
X-Gm-Message-State: AC+VfDzjV2cdvB1Q5eknLqXDKlNNy5F0mzeJcYxuEKvZR7hHj7nWt/Yh
        ty2twGJ2ZQAAvPhkibZ1pQa3u/J6AYfnVU1lLtD+anmH
X-Google-Smtp-Source: ACHHUZ7DjEmGZPip6CxXTGWc61ql5VMHwtEcS0EQvBPDYkN7T9oOOpHETBD4sNH0ZB6vfWEx3zXERg==
X-Received: by 2002:a17:907:74d:b0:978:8e8c:1bcb with SMTP id xc13-20020a170907074d00b009788e8c1bcbmr2427295ejb.43.1686337592277;
        Fri, 09 Jun 2023 12:06:32 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id gv11-20020a170906f10b00b00947ed087a2csm1617162ejb.154.2023.06.09.12.06.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 12:06:30 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-977c89c47bdso372889566b.2
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 12:06:29 -0700 (PDT)
X-Received: by 2002:a17:907:26c1:b0:978:930e:2279 with SMTP id
 bp1-20020a17090726c100b00978930e2279mr2489992ejc.52.1686337589586; Fri, 09
 Jun 2023 12:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200903.652580797@linuxfoundation.org> <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
 <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
In-Reply-To: <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Jun 2023 12:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA=HsyDFtgQnWMZP-08ddhMh1a88OZHCXf8N-iP6hFQw@mail.gmail.com>
Message-ID: <CAHk-=whA=HsyDFtgQnWMZP-08ddhMh1a88OZHCXf8N-iP6hFQw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 9, 2023 at 11:42=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> I managed to revise my bisect script sufficiently enough to get reliable
> results. It looks like the culprit is commit 503e554782c9 (" debugobject:
> Ensure pool refill (again)"); see bisect log below. Bisect on four
> different systems all have the same result. After reverting this patch,
> I do not see the problem anymore (again, confirmed on four different
> systems).

Does this happen on mainline too? It's commit 0af462f19e63 in the upstream =
tree.

It was in 6.4-rc1, and I see a clean result from you at least for
-rc2, so for some reason it sounds like upstream is ok. But I don't
really see why that would be the case...

                  Linus
