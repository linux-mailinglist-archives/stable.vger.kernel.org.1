Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F107DBF2A
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 18:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjJ3Rk1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjJ3Rk1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 13:40:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196CA9F
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 10:40:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507a55302e0so6755167e87.0
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698687621; x=1699292421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0ir2D4QCfLQnWbR8rXv+lrdC0LI67HN6g7rBTtSt0E=;
        b=NXJV8sSsllAMLgEMWhKoi37VXaPI/zzX0I/gohKQjl8rwk/6NOPsk6rorWKvRpx1EY
         0725YuMejBHp+XkhjbolRMvkXSCw3LIysfnDT6SsFZLgvxL1gugwZzoDUfQuo/vzt9wZ
         YJG4QCRFcBkwrYzgC7H8vGqbNmP0dGIj3YzQ3xwUzFSElUIzgQI125hiG9tC7yihh/h3
         14RO6mlMzcaoXiEsYeURMTTJCu2pRDZQJ849xFeq7tG6ZQidonKk+BusJii5KQggMzbK
         tFY8SJGpY0CDYyIBu2RPvVdK8kFIFj1D2ctXoWgiFUheiGUznVdERJRFnImsInnvZC8Y
         hlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687621; x=1699292421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0ir2D4QCfLQnWbR8rXv+lrdC0LI67HN6g7rBTtSt0E=;
        b=vPiTpKi8PU5eLkEvueteTk9NJ/Znc6w0TZRdDumOxn5QbysnZ3hMTwo4aPEnox5AiO
         u7bl/1F4P4aX0wdrK7YjCRlCyDKmFWo72j6GmgiRXW+pv5Qv//Caa/68R5chQ1VXWFyf
         m+m8q1GQzeTgNJQsSuXoub9TlvFAvL09Nkbdo0iuFflkYkQCTkWQhi2ezfFXSCwglvzW
         AYCWeVenSRP77Y3IovnEuZTKb1beV8XMKBvEkZHvDZ2jjzvevk19VOcNG4HnAjCWON1b
         yYT7TUWhcCDWgtmzV6mdQL3TUn/c5G3MksLph2c+/s7VxbqoU3BvTmyQrQXLGTPN1VVM
         qZyA==
X-Gm-Message-State: AOJu0Yx5rmE+ibxPgrmEsUoQ9DxYD+ittrYNFatrswsaUIkIb7wp3a9q
        v5+VEdwPThWPaGpZ1Zz8ApCt2iB1bjKsR4XSWXpZhEFlxOoDxtVkVTf2BO8S
X-Google-Smtp-Source: AGHT+IGVUD6diH5ENQ4J/fApQAHbs0bzqg4El0Q54SM7Jan2NxauyGPeedCJqSM3NOBGaw3YFoQFSWASkx8JzdIELYA=
X-Received: by 2002:a05:6512:1081:b0:507:a5e7:724 with SMTP id
 j1-20020a056512108100b00507a5e70724mr8955304lfg.38.1698687621042; Mon, 30 Oct
 2023 10:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231028192511.100001-1-andrew@lunn.ch>
In-Reply-To: <20231028192511.100001-1-andrew@lunn.ch>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 30 Oct 2023 10:40:09 -0700
Message-ID: <CAFhGd8rdziUZXH4=CxnZZKuS3X2EpTajxBgat+fvr-5RRzAekg@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: ethtool: Fix documentation of ethtool_sprintf()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev <netdev@vger.kernel.org>,
        Alexander Duyck <alexanderduyck@fb.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Oct 28, 2023 at 12:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> This function takes a pointer to a pointer, unlike sprintf() which is
> passed a plain pointer. Fix up the documentation to make this clear.
>
> Fixes: 7888fe53b706 ("ethtool: Add common function for filling out string=
s")
> Cc: Alexander Duyck <alexanderduyck@fb.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/linux/ethtool.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 62b61527bcc4..1b523fd48586 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1045,10 +1045,10 @@ static inline int ethtool_mm_frag_size_min_to_add=
(u32 val_min, u32 *val_add,
>
>  /**
>   * ethtool_sprintf - Write formatted string to ethtool string data
> - * @data: Pointer to start of string to update
> + * @data: Pointer to a pointer to the start of string to update
>   * @fmt: Format of string to write
>   *
> - * Write formatted string to data. Update data to point at start of
> + * Write formatted string to *data. Update *data to point at start of
>   * next string.
>   */
>  extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, .=
..);
> --
> 2.42.0
>

Great! Now the docs more appropriately describe the behavior. My patch [1]
for ethtool_puts() will use this same wording you've introduced.

Reviewed-by: Justin Stitt <justinstitt@google.com>

[1]: https://lore.kernel.org/all/20231027-ethtool_puts_impl-v3-0-3466ac6793=
04@google.com/

Thanks
Justin
