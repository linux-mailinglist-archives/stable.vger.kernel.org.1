Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ACD713641
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjE0Tkx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjE0Tkw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 15:40:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD2D8
        for <stable@vger.kernel.org>; Sat, 27 May 2023 12:40:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f818c48fbso358041866b.0
        for <stable@vger.kernel.org>; Sat, 27 May 2023 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685216448; x=1687808448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JcPeHx5b/Toh4k4OiN1qju08d1gnox4XXe9rs4ZJHI=;
        b=WV0V2HZRXvi6BC0+lTY1BFaRQoiJFNQYSdc4KILwvNyBeP8uw5lKnOvQx1QHvIc4OF
         n3xE50kzkEPyfrRRGHNNncBMFmN4FzRFF/9qj4EBh/pe+7C7D8nSAZGZ/GCpUMAdxwDR
         4lq0klEbbUb4nQIqdCeJdYo5iEu1wdOoiehfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685216448; x=1687808448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JcPeHx5b/Toh4k4OiN1qju08d1gnox4XXe9rs4ZJHI=;
        b=fsnlL9A8Zj7V63QXFn7TuWQ9CvufDWdqDBOl4jUI5MquWK1L13PRmOuWQnJy7m0Gzf
         lrLF8WaAmV3xENZGvXWLVnQ5sV/hFuBVLErSFnEtpzu9N/wjs+1vVAAxNxozIUoYRUZR
         Wygd/eOpSDyWnkHPdAEYLcimGenC8SgAg2ilg+CfJqTWSbDgD7VAyOBF74LQpZBBcLmH
         D8GTx3gFfsm4Ly5aQXJXQctnnCyyIvZk9N7KW1PQWEzCZhE+m+P5K3alL0ueGB5kmw+h
         +HmEpgR4nskZWof9kgMo0tJtiqi0X+kYFA8z3tnZgd8FC5puUgLyil8kj74umIYLDIFH
         vo6A==
X-Gm-Message-State: AC+VfDycJFdXdWhxC2x3Sz/q1btuaYBFXTOxzeCLLkv8G3Pujk2yihqm
        n/nxsSaGo9W61yAokJgup9zCcpYazjh0xNquaUoAyaml
X-Google-Smtp-Source: ACHHUZ5TzFxaLPcKieWXfuR6FE/7wNCxqTHeBeRkZ+xbb4bGIYs2OKQ02s5Oo1Cq5unVr8D0WLGoqw==
X-Received: by 2002:a17:906:9b88:b0:969:f677:11c8 with SMTP id dd8-20020a1709069b8800b00969f67711c8mr6301593ejc.45.1685216447734;
        Sat, 27 May 2023 12:40:47 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id qu2-20020a170907110200b00947ed087a2csm3721354ejb.154.2023.05.27.12.40.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 12:40:46 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9700219be87so355379166b.1
        for <stable@vger.kernel.org>; Sat, 27 May 2023 12:40:45 -0700 (PDT)
X-Received: by 2002:a17:907:36cd:b0:953:37eb:7727 with SMTP id
 bj13-20020a17090736cd00b0095337eb7727mr6716027ejc.43.1685216445655; Sat, 27
 May 2023 12:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <efd6f2d4-547c-1378-1faa-53c044dbd297@gmail.com>
 <CAG8fp8SaHi0X-tZHnji_93wBADp1_=brjauWCVXuLaG7iP0p=A@mail.gmail.com>
 <CAG8fp8QXoEkndCzyaYZmg6+ZrszKOfh_YSi0o2_weV7y1_xYkQ@mail.gmail.com>
 <CAMj1kXGjkKK-oHm64Y9P-AbYQWd9jnEdsNucRbY_-7mgJ_4yAA@mail.gmail.com>
 <CAG8fp8ReYLaNYO9LYE1WeeSDg1pO1hz3f-8_WPZkLVWbzzyCvg@mail.gmail.com> <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
In-Reply-To: <CAMj1kXEGTJufrrcrqjjKqeR-FN+nLsbzx8xGgO+gPfc2YPsy2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 May 2023 12:40:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com>
Message-ID: <CAHk-=whKJoDVuUNhf3U7gPXKu4EeZRv-iwwhL0prQ=U3n8PHiw@mail.gmail.com>
Subject: Re: mix of ACPICA regression and EFISTUB regression (Was: kernel >=
 v6.2 no longer boots on Apple's Virtualization.framework (x86_64); likely to
 be related to ACPICA)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Akihiro Suda <suda.kyoto@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux x86 <x86@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux ACPICA <acpica-devel@lists.linuxfoundation.org>,
        Linux Stable <stable@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 27, 2023 at 11:42=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> Yes, that makes the most sense. If the existing virtual machine BIOS
> has a hardcoded check that the EFI stub version is 1.0 even if it does
> not boot via EFI to begin with, I don't see how we can reasonably
> treat this as a regression that needs fixing on the Linux side.

Well, we consider firmware issues to be the same as any hardware
issue. If firmware has a bug that requires us to do things certain
ways, that's really no different from hardware that requires some
insane init sequence.

So why not just say that LINUX_EFISTUB_MINOR_VERSION should be 0, and
just add the comment that versioning doesn't work?

I'm not sure why this was tied into always enabling the initrd command
line loader.

Numbered version checks are a fundamentally broken and stupid concept
anyway. Don't do them. Just leave it at zero, and maybe some day there
is a sane model that actually has a bitfield of capabilities and
requirements.

              Linus
