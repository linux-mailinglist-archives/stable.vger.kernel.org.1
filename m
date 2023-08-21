Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83613782677
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjHUJpt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 05:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHUJps (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 05:45:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BF6B1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 02:45:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bcc331f942so4098331fa.0
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692611145; x=1693215945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXrzJekWebthka+oRqCLeF2NbSrhuQVkBUewP5jY82E=;
        b=ESUb5mt0pif/4/0ee8nGER4MumOqtbcKsk+y/YK4wWg8rNq/6Zbv3q014Tziv2SdtD
         bl4s+RTSBPMXAVKEk4dpGwJpXvQTm78uZhPftx22qdsF1BO2fsTH1wJDTICNmn44dR3E
         qHdtXJWXl9wfr/khAudxPtn+qzgp3nLtV2yef0DJq87C248AxvFQFbEZY8JcZ/tuSXUd
         Rl1ioo6qaEWI8UnzblQhGiqi0YzCxjAoJqeNEhvb0hshxyFdF8Fzm5ZXQjcSlqAHnUZE
         CraRLCsZbpTVPJ9XnwjPe8jFAD0fyadOmSP3As8MJxZ4wUmGwVWklXMQQWNmtwLOmvof
         tTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692611145; x=1693215945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXrzJekWebthka+oRqCLeF2NbSrhuQVkBUewP5jY82E=;
        b=MESEHdUG12ydVBrMGNEc1S2FCMZ3XN7oeztD51NQ4qTYI6nkZfve3HdQ+X4eZTZqK4
         7qwskYWQA/6hkRmpPrnMze/p8NoYWyCpmS9qrD8J5U6uY19W6jiEwXPkBOokYBT1vBy1
         T/OGGbqu4lu559UNXXpEToeWsF0DhTDmW/xfLhF8GP3r7jOjkuJeqD6TYTMRC1teT4eH
         ZBS0AJ95SWgOAu+vRs2Q91bEz8xG5jE4UqwhxINeP2jPTGxlvx4eGPEd2NatkLOxgcKh
         V/FaolIv8hLV0P6gyWCMfm2832dimFmTJJCFgiAn9etlZ4lCTpCgTClAzOiR8JvwKlru
         7xeA==
X-Gm-Message-State: AOJu0YyJxi+FIfPgDeBmfo5c8nZOVNYn5cnmFv3u4CYPvCjrM4E2Z0sj
        rMsEfRuzvCl0Zc1dgJmAWQWOQuFL18yhya4jOBA=
X-Google-Smtp-Source: AGHT+IEdM8QVeDFGwcQueS2atSsLxX9mr+uYi4bw6KPAiR9wR139TNuB4GQX211qP2ZEPWfyDqoPhuzw+80uqhQH6Zw=
X-Received: by 2002:a2e:9915:0:b0:2b6:d0c1:7cd0 with SMTP id
 v21-20020a2e9915000000b002b6d0c17cd0mr1993359lji.22.1692611145029; Mon, 21
 Aug 2023 02:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+prNOpqd2Tk1tiBAa9MT6ZPxB5gj9ftxOhaZ-u1WEay9H-oHQ@mail.gmail.com>
 <20230815053132.GB22301@1wt.eu> <CA+prNOrUVWM9-vozUZyW49-m=qFWZR3JAtikZb4T1EimV0ZCDw@mail.gmail.com>
 <CAHk-=wgDbr7dw0GP4zEkPu5X2mME3YH9t0+cP8Avs3m0KZxbCQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgDbr7dw0GP4zEkPu5X2mME3YH9t0+cP8Avs3m0KZxbCQ@mail.gmail.com>
From:   Xuancong Wang <xuancong84@gmail.com>
Date:   Mon, 21 Aug 2023 17:45:38 +0800
Message-ID: <CA+prNOpbbiLEDrvVLZ_9AHpyJPV8z3ge1aRX58ri2PPTjDJGGw@mail.gmail.com>
Subject: Re: A small bug in file access control that all have neglected
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, security@kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thanks Torvalds for your clear-cut answer, I really appreciate that.

On another hand, I would like to suggest that Linux files should have
an additional permission bit to be granted arbitrary attributes
access, especially for the atime, ctime and mtime. The reason is
because in production data pipeline, we often need multiple people to
get/set the same file's modification times arbitrarily (e.g., set an
output file's mtime according to the input file for incremental
processing), and this process is managed by several people. So now, we
have to run our data processing pipeline as root which is risky and
undesirable.

This can be implemented either:
- as a single bit in file attributes along with the 7777 (i.e., setUID
bit, setGID bit, sticky bit, user-3-bits, group-3-bits,
others-3-bits), I would call it group-attribute-bit to allow users in
the same group to modify its timestamp arbitrarily.
or
- as an extra bit in user/group/other, so that it become 7FFF (it is
nice to have 4-bits for user/group/other, because 4 bits make up for
one hexadecimal digit=F0=9F=98=81)

Thank you very much for your consideration!

Cheers,
Xuancong


On Tue, Aug 15, 2023 at 2:29=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Tue, 15 Aug 2023 at 06:11, Xuancong Wang <xuancong84@gmail.com> wrote:
> >
> > Yes, by "full access", I mean `chmod 777`. You can easily reproduce
> > this bug on any Linux machine by typing the following commands:
>
> This is how things are supposed to work. The 0777 permissions mean
> that you can read, write and execute the file. They do not mean that
> you own the file.
>
> As a non-owner, you can set the access and modification times  the
> same way you could by just reading and writing to the file. So if you
> set mtime, you have to set ctime ("change time") too.
>
> To actually change times arbitrarily and with other patterns, you need
> to actually own the file.
>
>              Linus
