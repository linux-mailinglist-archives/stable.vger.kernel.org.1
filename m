Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927F872087E
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 19:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjFBRit (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjFBRis (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 13:38:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B51BD
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 10:38:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-974638ed5c5so161325966b.1
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685727525; x=1688319525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=IKRPxJ3A0yf2tZl1cV/0w2dtc7OEvW1uj1qqlfdLfH6hbUUfGsHB0M83XAWUkuZEXI
         rWQypeGHOLw7lhGuspNtOMw+mlk1AUWdqj9drpaGt/SxaZqMXLcZmWXcx7uu71+974KQ
         YfOQSvOhd6kPyAndsrGpN35sfO/7fnRVnWxG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685727525; x=1688319525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPpIUifsrj3WhrOLcjmDKG+n28eYiyTfgghRaS6XkRs=;
        b=gLjECiBSsbiFH0NoEvBLKqyg1HqsusR99TZF+jqXNPlftUMS9glV4khaHvj2GtmVH9
         Q/dHVwMIId/PB4hM1QswZHaN6oZYssWp7TTZxEfYYuMK98+K+ecY6ByyDT8ubggwUe6k
         b64iSi0+arSU+5oJVUSYAZkSLaPNF6feXYRWHETUGEnYHBwOHiFzl/5qQzeMpvgHq402
         Pc0czf3hb09vxT+03yGMq74jRaDzwVqVRma8dS1W8sSLh9Ff9wx9pkeHViOY+b8BKEJI
         lyvzC8i2KVsDzTmYvkschDGriCz4Jbj4XXfvZuU6+qv02Z22t3vt3UuiYrcHKrYWq6zp
         SJUA==
X-Gm-Message-State: AC+VfDxcOY0cnnouXz4BTt8OHuFWFCb/7pDhiU7aea7DmquCkeutXtYq
        fKAJHun/3nAA7tXER6VNAM5LsaDVzgx7GUbkTpEiJeDv
X-Google-Smtp-Source: ACHHUZ4KKUGcHnHhdzRWMsX/1irX0SpHU8bmYJIwzU3As13iZvxW6aHRqBeuDRWHUuHIZWKoB5D4xQ==
X-Received: by 2002:a17:907:e87:b0:974:5e8b:fc28 with SMTP id ho7-20020a1709070e8700b009745e8bfc28mr2919094ejc.9.1685727525422;
        Fri, 02 Jun 2023 10:38:45 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id r6-20020a170906350600b00970f0e2dab2sm991638eja.112.2023.06.02.10.38.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 10:38:44 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so5050880a12.0
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 10:38:43 -0700 (PDT)
X-Received: by 2002:a05:6402:202e:b0:505:d16:9374 with SMTP id
 ay14-20020a056402202e00b005050d169374mr3588912edb.9.1685727523436; Fri, 02
 Jun 2023 10:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
In-Reply-To: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 13:38:26 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Message-ID: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
Subject: Re: [GIT PULL] Asymmetric keys fix for v6.4-rc5
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Fri, Jun 2, 2023 at 10:41=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> sorry for this unusual procedure of me requesting a patch to be pulled.
> I asked for several months the maintainers (David: asymmetric keys,
> Jarkko: key subsystem) to pick my patch but without any luck.

Hmm.

The patch behind that tag looks sane to me, but this is not code I am
hugely familiar with.

Who is the caller that passes in the public_key_signature data on the
stack to public_key_verify_signature()? This may well be the right
point to move it away from the stack in order to have a valid sg-list,
but even if this patch is all good, it would be nice to have the call
chain documented as part of the commit message.

> I signed the tag, but probably it would not matter, since my key is not
> among your trusted keys.

It does matter - I do pull from people even without full chains, I
just end up being a lot more careful, and I still want to see the
signature for any future reference...

DavidH, Herbert, please comment:

>   https://github.com/robertosassu/linux.git tags/asym-keys-fix-for-linus-=
v6.4-rc5

basically public_key_verify_signature() is passed that

     const struct public_key_signature *sig

as an argument, and currently does

        sg_init_table(src_sg, 2);
        sg_set_buf(&src_sg[0], sig->s, sig->s_size);
        sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);


on it which is *not* ok if the s->s and s->digest points to stack data
that ends up not dma'able because of a virtually mapped stack.

The patch re-uses the allocation it already does for the key data, and
it seems sane.

But again, this is not code I look at normally, so...

               Linus
