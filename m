Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E86F108F
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 04:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbjD1CyM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Apr 2023 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjD1CyL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Apr 2023 22:54:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EDC2D4C
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 19:54:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94ef0a8546fso1518573566b.1
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682650447; x=1685242447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9mxxPAl4POq2fq0d8t6aqpR8L52uoUsixYLH2L9aFc=;
        b=gVr7G68nDrSh0Mm8XFg00vgUBfCAEBsm+kBDZ6P2d/L3Go4V19Aec1suNiJ2VDMl4a
         NC//cawahRxIQyl707Nwom4+1A1RhV2GpO/XSsIxz5nFODPCXoF0mxYmWyNW/oJNrQUG
         lEX7cDfl2BDYrMP3hbQsVenPmN2vzJMOvESpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682650447; x=1685242447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9mxxPAl4POq2fq0d8t6aqpR8L52uoUsixYLH2L9aFc=;
        b=MzZPoAgnfm7SjAeDOq8KfnUmSOPJljFXd6drC8cjRizJhtsgkQLi3zLSA45hh9av6a
         HFiDATDZ7FyjAzxXEm1zBWHkqjplnU801i61D86ezTZUhVp1xw7Rgj4UFBMIGVazE8rf
         oZIId618sLtkHyUjiy2p+MQ7m79hPhFqIKQ4jwuRKiaKP9lMWWiqtUEV+JAUCQG8O2ct
         LnoHCBaeU0Wn419U+cmz7eQLyKbACadX9ISyFyPLetZGkaLcGMCUByQstnh9DYep1hnS
         lp4KCVQrBsmtfpddcRNnUQ/1q60qOuh4giNOfZERPm7zzW2N/evaYGCaCKMzkaCL1zks
         VteQ==
X-Gm-Message-State: AC+VfDyJz3DDo2BRFst/ShKvFCDBE5H3EAVFev+OaUg/WjyGS13lnAkV
        wYi4NFb17AqC96WZZYJutPJHaZcoytRkbz/jFnadCg==
X-Google-Smtp-Source: ACHHUZ5FQ/4Zk04arM591M1Ore6TSPHGKyFODpF0+elsRJBrfaMDLxJ42CI3nWFLO8SW/z6jLabWQw==
X-Received: by 2002:a17:906:6a28:b0:93c:efaf:ba75 with SMTP id qw40-20020a1709066a2800b0093cefafba75mr3806053ejc.37.1682650447473;
        Thu, 27 Apr 2023 19:54:07 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906054900b00923f05b2931sm10444285eja.118.2023.04.27.19.54.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 19:54:05 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso13503978a12.3
        for <stable@vger.kernel.org>; Thu, 27 Apr 2023 19:54:05 -0700 (PDT)
X-Received: by 2002:a17:906:da8d:b0:94e:4586:f135 with SMTP id
 xh13-20020a170906da8d00b0094e4586f135mr3520975ejb.6.1682650445056; Thu, 27
 Apr 2023 19:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230427140959.27655-1-vbabka@suse.cz> <2023042719-stratus-pavestone-505e@gregkh>
 <3cc6e10c-f054-a30a-bf87-966098ccb7bf@suse.cz> <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
In-Reply-To: <CAHk-=wgdGzy6-3jzN6Kvtz1QxStTZBZPz1zy9i4gM9nbe5FGbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 19:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwoKFbrCGXW9uwX3SPOezLdOKstuLAju1KTi5Ryq+ZcQ@mail.gmail.com>
Message-ID: <CAHk-=whwoKFbrCGXW9uwX3SPOezLdOKstuLAju1KTi5Ryq+ZcQ@mail.gmail.com>
Subject: Re: [PATCH for v6.3 regression] mm/mremap: fix vm_pgoff in
 vma_merge() case 3
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Greg KH <greg@kroah.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, lstoakes@gmail.com,
        regressions@lists.linux.dev, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabian Vogt <fvogt@suse.com>, stable@vger.kernel.org
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

Hi Vlastimil,

On Thu, Apr 27, 2023 at 8:12=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ack. It's in my tree as commit 7e7757876f25 right now (not pushed out
> yet, will do the usual build tests and look around for other things
> pending).

Gaah. I just merged Andrew's MM tree, and while it had a lot of small
conflicts (and the ext4 ones were annoying semantic ones), the only
one that was in *confusing* code was the one introduced by this
one-liner fix.

I'm pretty sure I did the right thing, particularly given your other
patch for the mm tree, but please humor me and take a look at it?

That 'vma_merge()' function is the function from hell.

I haven't pushed out yet because it's still going through my build
tests, but it should be out soon.

                       Linus
