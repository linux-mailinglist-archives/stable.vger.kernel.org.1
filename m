Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4084745485
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjGCEW7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 00:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCEW7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 00:22:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FADE193
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 21:22:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d93425853so4413659a12.1
        for <stable@vger.kernel.org>; Sun, 02 Jul 2023 21:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688358176; x=1690950176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LBv71BkedBGYMkqGKsr3uyFzGINH/oPOCalyJ1iyXF8=;
        b=DRfZ+r9wmnsJ2NsqxbykaB7AxtX+KdmCwwNJ9SkKGxD9hJPxqoEtMp9o4pbi8tb9OI
         9aFb7r0VTG2GbW4PSTX0E7PWqIz4CKaoMqzLDzJICvx/cKmPjOWDIW4Irzvu0+VMSSjv
         vLgfTwfb4Jb/TYpj6DJwBofqYVscJ1FrE7BtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688358176; x=1690950176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBv71BkedBGYMkqGKsr3uyFzGINH/oPOCalyJ1iyXF8=;
        b=IWH2TR8YljtHkN4gQ/H3SgdejFJJDbZJUQLk3Rqv4MQpd3iva9VZowi0JbhD9Ty6Bg
         QtmuSHgYTBxMr8/bRm59zluM6s8C82yQydjzFtzfU7gJXs2WFkfHygZOjxSZU1lsUu63
         lb5lD0xiFmYjUeR/yFsxUwDtN+C/13zKZ0aiA4r3sosGvwt4j/jtiBXb4zw3J/ds0edF
         FHmXybYdz6B85ml4+UoQX7JeLeXAxW/jRgjwHa3bD+RN31o8hjmIH61yFPoNzInDoZnE
         svIGn4tK3aJytrR2/5wS+RgRMT5qWFo7BnwLYdWAcJ+bbi644LVl2unYQ8w/sTpH8pCX
         xsTQ==
X-Gm-Message-State: ABy/qLZfr8OWYplu4LZZ3DzVBVxLPy4HT0TNnLlU/IO05G7X/XzrKMIX
        vFWOxJ+qrtyBB7RRcA5ou/QcWMuItNfS/ImzjHEX2sud
X-Google-Smtp-Source: APBJJlEfXvRlRd/xdaGEdTSOUPDOMk7+sDHQr1LtrU54Rh5jOKVh6j+tzXRIbnGb8YT2+VoXyRMLZw==
X-Received: by 2002:a17:906:2c16:b0:992:a0c7:8d2a with SMTP id e22-20020a1709062c1600b00992a0c78d2amr5387822ejh.54.1688358176413;
        Sun, 02 Jul 2023 21:22:56 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id lr3-20020a170906fb8300b00973f1cd586fsm11439830ejb.1.2023.07.02.21.22.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 21:22:54 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51d93425853so4413636a12.1
        for <stable@vger.kernel.org>; Sun, 02 Jul 2023 21:22:54 -0700 (PDT)
X-Received: by 2002:aa7:c711:0:b0:51d:d4c0:eea5 with SMTP id
 i17-20020aa7c711000000b0051dd4c0eea5mr5453955edq.40.1688358174441; Sun, 02
 Jul 2023 21:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh> <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de> <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com> <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
In-Reply-To: <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jul 2023 21:22:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
Message-ID: <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
Content-Type: multipart/mixed; boundary="0000000000003de76805ff8d8571"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--0000000000003de76805ff8d8571
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Jul 2023 at 20:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> I can reproduce the problem in qemu. However, I do not see a warning
> after applying your patch.

Funky, funky.

I'm assuming it's the

                                page = get_arg_page(bprm, pos, 1);
                                if (!page) {
                                        ret = -E2BIG;
                                        goto out;
                                }

in copy_strings() that causes this. Or possibly, the version in
copy_string_kernel().

Does *this* get that "pr_warn()" printout (and a stack trace once,
just for good measure)?

              Linus

--0000000000003de76805ff8d8571
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljmcud9a0>
X-Attachment-Id: f_ljmcud9a0

IG1tL2d1cC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9tbS9ndXAuYyBiL21tL2d1cC5jCmluZGV4IGVmMjk2
NDE2NzFjNy4uNjY1MjAxOTQwMDZiIDEwMDY0NAotLS0gYS9tbS9ndXAuYworKysgYi9tbS9ndXAu
YwpAQCAtMTE2OCwxMSArMTE2OCwxNSBAQCBzdGF0aWMgbG9uZyBfX2dldF91c2VyX3BhZ2VzKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tLAogCiAJCS8qIGZpcnN0IGl0ZXJhdGlvbiBvciBjcm9zcyB2bWEg
Ym91bmQgKi8KIAkJaWYgKCF2bWEgfHwgc3RhcnQgPj0gdm1hLT52bV9lbmQpIHsKLQkJCXZtYSA9
IGZpbmRfdm1hKG1tLCBzdGFydCk7CisJCQlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnByZXYgPSBO
VUxMOworCQkJdm1hID0gZmluZF92bWFfcHJldihtbSwgc3RhcnQsICZwcmV2KTsKIAkJCWlmICh2
bWEgJiYgKHN0YXJ0IDwgdm1hLT52bV9zdGFydCkpIHsKIAkJCQlXQVJOX09OX09OQ0Uodm1hLT52
bV9mbGFncyAmIFZNX0dST1dTRE9XTik7CiAJCQkJdm1hID0gTlVMTDsKIAkJCX0KKwkJCWlmICgh
dm1hICYmIHByZXYgJiYgc3RhcnQgPj0gcHJldi0+dm1fZW5kKQorCQkJCVdBUk5fT05fT05DRShw
cmV2LT52bV9mbGFncyAmIFZNX0dST1dTVVApOworCiAJCQlpZiAoIXZtYSAmJiBpbl9nYXRlX2Fy
ZWEobW0sIHN0YXJ0KSkgewogCQkJCXJldCA9IGdldF9nYXRlX3BhZ2UobW0sIHN0YXJ0ICYgUEFH
RV9NQVNLLAogCQkJCQkJZ3VwX2ZsYWdzLCAmdm1hLAo=
--0000000000003de76805ff8d8571--
