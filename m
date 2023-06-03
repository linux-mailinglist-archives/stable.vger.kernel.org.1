Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B2720C79
	for <lists+stable@lfdr.de>; Sat,  3 Jun 2023 02:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbjFCACr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 20:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjFCACq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 20:02:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B71BF
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 17:02:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so3578828e87.3
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685750563; x=1688342563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIfddwJGgEUnwUCFA5IlnKSK6V7h4JvROQevxAQzNhk=;
        b=Xc3AyBTCKjaXrHR7Xn+gWHTG8qM31jMYo97046Wrqhe1Py0EkfgorGVdl7O+h8+E9L
         PaAZsESnLNkgwnMUxef6YPVRCpRivyvhVZ9fm2NvVOB11vXsyRO5P1OwgQUU1H/h8ieT
         aWMFYcJc91CVBIsodU5Pk+AT3AzlbRWZyKPhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685750563; x=1688342563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIfddwJGgEUnwUCFA5IlnKSK6V7h4JvROQevxAQzNhk=;
        b=CqgZKN7U533To2KhjuYEMy0Q7PDs4npHw9Xc7U2aTsm9tsJ0Re5r2Yj+AaNxlGxtVt
         178glzO4PO8gYR2Z+1otVJMW+iWGI9vXC4HX1FyOK4a5YUUEnpMwfm3i/J4LReOv7kBX
         pfuCdW/ijZDQkqKcCuQB+WHS5lQ48WUhckcHFT5IoFBNrcrVZGfSL1hXT92s6DcEq0H0
         DLcfkTeKFOJ3SEYFA2jv2EjKHueuWIrFroa4/3EMbuug/1enClqwGuRxN+vDmSg3miem
         idLtCmE72+Du6FTJdyruFkUBRImYtuhkTgTjcbNWH6wiar8IpcDorxSglf+jtfuHUZ6s
         vphA==
X-Gm-Message-State: AC+VfDyXHY0YtSTn++3mgereD6bAy+Mrvw4f6m51dnE+2I7QIKwTGWUq
        RbLMiHKw6PmdYOcUCKbe8Z47bgTeuRwLSwK4cjsRMQJW
X-Google-Smtp-Source: ACHHUZ7MeZXYHnBthQxpUDRFsQY33BUbtLyXq5oAyhOE5iLj0p+WCobfXsu3QG5FqIrjI9+mu0TNhw==
X-Received: by 2002:ac2:47e4:0:b0:4f1:3eca:76a0 with SMTP id b4-20020ac247e4000000b004f13eca76a0mr448129lfp.66.1685750562904;
        Fri, 02 Jun 2023 17:02:42 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id y8-20020ac255a8000000b004efee46249fsm312951lfg.243.2023.06.02.17.02.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 17:02:41 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so3578787e87.3
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 17:02:40 -0700 (PDT)
X-Received: by 2002:ac2:52ba:0:b0:4f2:7b65:baeb with SMTP id
 r26-20020ac252ba000000b004f27b65baebmr2458573lfm.53.1685750560415; Fri, 02
 Jun 2023 17:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <4d7e38ff5bbc496cb794b50e1c5c83bcd2317e69.camel@huaweicloud.com> <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
In-Reply-To: <CAHk-=wj4S0t5RnJQmF_wYwv+oMTKggwdLnrA9D1uMNKq4H4byw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 20:02:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
Message-ID: <CAHk-=wgCUzRNTg4fC8DF=UFnznK0M=mNUBDcsnLt7D4+HP2_1Q@mail.gmail.com>
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

On Fri, Jun 2, 2023 at 1:38=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The patch re-uses the allocation it already does for the key data, and
> it seems sane.

Ugh. I had to check that it was ok to re-use the key buffer, but it
does seem to be the case that you can just re-use the buffer after
you've done that crypto_akcipher_set_priv/pub_key() call, and the
crypto layer has to copy it into its own data structures.

I absolutely abhor the crypto interfaces. They all seem designed for
that "external DMA engine" case that seems so horrendously pointless
and slow.  In practice so few of them are that, and we have all those
optimized routines for doing it all on the CPU - but have in the
meantime wasted all that time and effort into copying everything,
turning simple buffers into sg-bufs etc etc. The amount of indirection
and "set this state in the state machine" is just nasty, and this
seems to all be a prime example of it all. With some of it then
randomly going through some kthread too.

I still think that patch is probably fine, but was also going "maybe
the real problem is in that library helper function
(asymmetric_verify(), in this case), which takes those (sig, siglen,
digest, digestlen) arguments and turns it into a 'struct
public_key_signature' without marshalling them.

Just looking at this mess of indirection and different "helper"
functions makes me second-guess myself about where the actual
conversion should be - while also feeling like it should never have
been done as a scatter-gather entry in the first place.

Anyway, I don't feel competent to decide if that pull request is the
right fix or not.

But it clearly is *a* fix.

            Linus
