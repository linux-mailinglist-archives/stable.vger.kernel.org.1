Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E209704822
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjEPIre convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Tue, 16 May 2023 04:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjEPIr2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 04:47:28 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB6AD
        for <stable@vger.kernel.org>; Tue, 16 May 2023 01:47:26 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-55a5a830238so127781297b3.3
        for <stable@vger.kernel.org>; Tue, 16 May 2023 01:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684226845; x=1686818845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5Fr1JqN2Ov4AHR8zy4YwIGPB2ZpmLeycQl8ETfUv/E=;
        b=NCMsV0V0SyzBQZTFD8XsDe+q0zRIVVo/nBnMdZgDlmQq6vkpUECufSE+d6CF0e6bTM
         apzqhYXWDSFjxHmgUxFXlkkxP3HIc+bDzas1/5bcHLk1KGzsSwbWVg2bav8hr8PkZQGu
         ZO9y8inJ5tvkPSFLXQJYR2ea+OnYnVMcRlSIP7UNOOKswIaCbWVECTW4awNY9qpGJoku
         bCg9tu6wAu1duGDyZJkvG71ssW8OCSRcPsz/St9lc4nREPx/tvKATpUledJWSA6tPN+/
         dH5Y3W+A1vCE65kzQwDpMQBGEbQUmB/BKbPA2h2yeFX3m/zSL+sN0RW7fvmvIeI8hYqy
         hd1A==
X-Gm-Message-State: AC+VfDyhYPfeMHItHxjP9nxHWWUpBe1MSZAIYRU0aOs+1bwQx3ZHAk2U
        c8Eb31GsGBudpDbGVdTBsd6TjvV2gmNmww==
X-Google-Smtp-Source: ACHHUZ40djfIZJsPCTUScFYB96JEAvp6KvX8usDKccClKjSQkLWPiAEKc4YaDOgh5HGCz0IhRqW1Nw==
X-Received: by 2002:a0d:dbcf:0:b0:55a:e0db:98d1 with SMTP id d198-20020a0ddbcf000000b0055ae0db98d1mr35436796ywe.41.1684226845443;
        Tue, 16 May 2023 01:47:25 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id l7-20020a0dfb07000000b00545a08184c9sm446597ywf.89.2023.05.16.01.47.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:47:24 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-55a8019379fso127966357b3.0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 01:47:24 -0700 (PDT)
X-Received: by 2002:a0d:d4c3:0:b0:55a:9d84:2e4e with SMTP id
 w186-20020a0dd4c3000000b0055a9d842e4emr32699001ywd.18.1684226844519; Tue, 16
 May 2023 01:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161707.203549282@linuxfoundation.org> <20230515161707.460071056@linuxfoundation.org>
In-Reply-To: <20230515161707.460071056@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 May 2023 10:47:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjkZ-FAKrwQkoyZRHLpyvaVYT0NvAUwaCs+30qC2VZmA@mail.gmail.com>
Message-ID: <CAMuHMdWjkZ-FAKrwQkoyZRHLpyvaVYT0NvAUwaCs+30qC2VZmA@mail.gmail.com>
Subject: Re: [PATCH 4.19 007/191] IMA: allow/fix UML builds
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On Mon, May 15, 2023 at 6:39 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> commit 644f17412f5acf01a19af9d04a921937a2bc86c6 upstream.
>
> UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
> NO_IOMEM).

0bbadafdc49d is in v5.14.
Was it backported to older versions?

>
> Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):
>
> ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
> ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
> ld: security/integrity/ima/ima_init.o: in function `ima_init':
> ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
> ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
> ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
> ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'
>
> Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
> is set, regardless of the UML Kconfig setting.
> This updates TCG_TPM from =m to =y and fixes the linker errors.
>
> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
> Cc: Stable <stable@vger.kernel.org> # v5.14+

"v5.14+"

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  security/integrity/ima/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -7,7 +7,7 @@ config IMA
>         select CRYPTO_HMAC
>         select CRYPTO_SHA1
>         select CRYPTO_HASH_INFO
> -       select TCG_TPM if HAS_IOMEM && !UML
> +       select TCG_TPM if HAS_IOMEM
>         select TCG_TIS if TCG_TPM && X86
>         select TCG_CRB if TCG_TPM && ACPI
>         select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
