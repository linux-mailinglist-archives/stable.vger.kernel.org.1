Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5076B96A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjHAQIG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjHAQH6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 12:07:58 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0086AA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:07:56 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63cf69f3c22so39959326d6.3
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690906076; x=1691510876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k92ZHvqcMDEEn2PMICpqw+YFYats7fBIresqkxLI9s=;
        b=sS66kgoJddsynyo1UV0ieyYMcA9voQhStth5bDRPXBk1MVejV3/iWWy1kxQL4qY3Y0
         Az2pHu5ZUsfqKYrZeia5MvMsEuQ9WhHRyqHg216RJG/m+4OTPZs9v6vrj9RQcw8tI7V3
         FJQMp97WGOpc46OvCU+2JLcfbBcEkRO7KA3VKNdLvWeD7jSfWcD+NHkCq+kQ6GCRsq48
         /hIDK4hr9MAxULLomYvIdTGsbRCtaIBo5Ycm7SNRR+s8WdKVrKD4nqJxpRxeXSNnOv6P
         35zJ4H4mJd+HUTBdmKNqSoQi1KBUEwYp69UZoCuCJSHWjHRBKok4L+lCxXfTWkQxlSRQ
         V4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906076; x=1691510876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/k92ZHvqcMDEEn2PMICpqw+YFYats7fBIresqkxLI9s=;
        b=lkV+xwC8wFLaowmmFzaKtytDXlYos1uaqFtwKLjItAdRHnPwWbOu36RUGeXwqmOHEv
         NtBMqIsCf7oA5LFTP90saDcpHqm0DfmWP26Fj4oWmihRkqlhnjR4UbLVQPPelIw6MGzU
         Hwtz3sQ8OKH9z0w4r/A2g0xkkItObdoTB2uuv8NColewxo6BlbnwLC1oFTq+5mlGWZc9
         Ch96jFTjyj7OODgPJfl/PtsnGHQFvP0M0ZPzMGUsMPB5hJoQH/Nr6ELnT+HstNeLGfda
         IE54J97Gp4pLUF77z6LbhBsITABEVuaAJUWqyqiuo/lhs7PGC6zNV17GVFd6Wl03rGIT
         DySA==
X-Gm-Message-State: ABy/qLbKg9HtKhu2EecsGjlvdpQAQUNk9SR0kKkPaRYbCehNJPUfDUlc
        LVkEiX2CQTb5gqypTxu2JMlngCwi1em3/FzL9z3uiQ==
X-Google-Smtp-Source: APBJJlFCv8rnnQQkeN4DoY3CihEHr2mytwUwbh3PC3qFHxKRFc2KTxnhyrho6l5eJYWtCxApzjcmyUd/sNqmjVPj354=
X-Received: by 2002:a05:6214:311:b0:63c:f979:b810 with SMTP id
 i17-20020a056214031100b0063cf979b810mr14002062qvu.46.1690906075647; Tue, 01
 Aug 2023 09:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230801050714.28974-1-ebiggers@kernel.org>
In-Reply-To: <20230801050714.28974-1-ebiggers@kernel.org>
From:   Victor Hsieh <victorhsieh@google.com>
Date:   Tue, 1 Aug 2023 09:07:44 -0700
Message-ID: <CAFCauYMrQf4TJJ+8atPrsihDa9+nKb5zn-rCKqB3081d8ZvZoA@mail.gmail.com>
Subject: Re: [PATCH] fsverity: skip PKCS#7 parser when keyring is empty
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fsverity@lists.linux.dev, keyrings@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Should the whole use of "d" be moved into the else block?


On Mon, Jul 31, 2023 at 10:09=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> If an fsverity builtin signature is given for a file but the
> ".fs-verity" keyring is empty, there's no real reason to run the PKCS#7
> parser.  Skip this to avoid the PKCS#7 attack surface when builtin
> signature support is configured into the kernel but is not being used.
>
> This is a hardening improvement, not a fix per se, but I've added
> Fixes and Cc stable to get it out to more users.
>
> Fixes: 432434c9f8e1 ("fs-verity: support builtin file signatures")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/signature.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index b95acae64eac6..f6668d92d8151 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -70,10 +70,26 @@ int fsverity_verify_signature(const struct fsverity_i=
nfo *vi,
>         d->digest_size =3D cpu_to_le16(hash_alg->digest_size);
>         memcpy(d->digest, vi->file_digest, hash_alg->digest_size);
>
> -       err =3D verify_pkcs7_signature(d, sizeof(*d) + hash_alg->digest_s=
ize,
> -                                    signature, sig_size, fsverity_keyrin=
g,
> -                                    VERIFYING_UNSPECIFIED_SIGNATURE,
> -                                    NULL, NULL);
> +       if (fsverity_keyring->keys.nr_leaves_on_tree =3D=3D 0) {
> +               /*
> +                * The ".fs-verity" keyring is empty, due to builtin sign=
atures
> +                * being supported by the kernel but not actually being u=
sed.
> +                * In this case, verify_pkcs7_signature() would always re=
turn an
> +                * error, usually ENOKEY.  It could also be EBADMSG if th=
e
> +                * PKCS#7 is malformed, but that isn't very important to
> +                * distinguish.  So, just skip to ENOKEY to avoid the att=
ack
> +                * surface of the PKCS#7 parser, which would otherwise be
> +                * reachable by any task able to execute FS_IOC_ENABLE_VE=
RITY.
> +                */
> +               err =3D -ENOKEY;
> +       } else {
> +               err =3D verify_pkcs7_signature(d,
> +                                            sizeof(*d) + hash_alg->diges=
t_size,
> +                                            signature, sig_size,
> +                                            fsverity_keyring,
> +                                            VERIFYING_UNSPECIFIED_SIGNAT=
URE,
> +                                            NULL, NULL);
> +       }
>         kfree(d);
>
>         if (err) {
>
> base-commit: 456ae5fe9b448f44ebe98b391a3bae9c75df465e
> --
> 2.41.0
>
