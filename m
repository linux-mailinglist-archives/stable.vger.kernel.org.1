Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6727D7C48
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 07:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJZFfY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 01:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZFfX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 01:35:23 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA0E12A
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 22:35:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cd566d8dfso204851cf.0
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698298521; x=1698903321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SNwqL9uBNOocRtfcI4WCu7LgRyHeUqmggRpLJrTQbA=;
        b=dF8AI/8C7nMB3AkMLawACREhIcKtWBw+P+wxNGFjM5H590d8YtuzPZaDCqSS/mWcF7
         95/7MiJ5Re3frJGxinxjjmKKxKZtxbQcktfQpyFHhkbBbYOYwBXWDB/KP36R7LNoPHcZ
         URlJnjeFfK+/+mIwrQcr2WT0puIk4XX1FxDhm3kNAJ/hOoePP0qyj0+SpWh3KpqF6HyA
         olkcWINttSeEAHl4xV+sY36aYAP7slhrWL3EyADnCS7PjGuX26i0EiNJdU1Rf70ubIOk
         aqjYOVUg0Cer7LS1VWqnNkcGwfp5FUrp+iaU7D1kPJwq27C6LJc33URbbmPc3XhpFRNg
         PKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298521; x=1698903321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SNwqL9uBNOocRtfcI4WCu7LgRyHeUqmggRpLJrTQbA=;
        b=iteEmQ7pmT9/mOLpeOFGVFVPCc5ug41t0B8MNUrIPJlJyo/ZBT/23ce8LLn/6Y17Sp
         3ewuUAM7dRxOfjRYTnt/g+JR6Prz6bnEshCnsGC52AwrRWTMKMkvdtRp3RWF3pyAsTIu
         xsoXHiQZtmcqEF00GcM1xRxOG3v0ALpdODvyhQx/wosBkAJ/HexXtYCX+wefUGyjSoAX
         E8mNGx7TZ1Ouiyp7Mk2waz0WPBZ/VPvwRkQt0xXGbeHPTO7WP3okv3KMwhojp4y6YhH4
         eh9+BAkGCHP20dF3E0i68qVOjdSgYIRqAnZFK0bpp3ZxLBzWtY6lykhY4M8LMs3LsSjq
         xswA==
X-Gm-Message-State: AOJu0YymDXDJYOUBAN94Frl5GGoR7PXmHEBj99STRZ2I+h+bPa3rv9DL
        27G5cEzGXdrFtPFKKgvVN2Y20+Q/OqZ+T85iMJ7+fv/apoa9Dd0NZSLWtQ==
X-Google-Smtp-Source: AGHT+IFjQWw9/rfKoFj/9Kj2dJrdIzzaC4vNi4Vi5GlKzW6tfRkrBDWGUlCY8d/IiEyXwhxSyfM16sU50tKw7OiUALw=
X-Received: by 2002:ac8:7cbc:0:b0:410:9d31:68cd with SMTP id
 z28-20020ac87cbc000000b004109d3168cdmr386865qtv.27.1698298520922; Wed, 25 Oct
 2023 22:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231026015728.1601280-1-jsperbeck@google.com> <2023102618-tributary-knapsack-8d8a@gregkh>
In-Reply-To: <2023102618-tributary-knapsack-8d8a@gregkh>
From:   John Sperbeck <jsperbeck@google.com>
Date:   Wed, 25 Oct 2023 22:35:08 -0700
Message-ID: <CAFNjLiWtmsticUCB+_D_MMqXCtH=RGr4f1avNYhtk+_CVGgsDg@mail.gmail.com>
Subject: Re: [PATCH] objtool/x86: add missing embedded_insn check
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bp@alien8.de, jpoimboe@kernel.org, patches@lists.linux.dev,
        peterz@infradead.org, stable@vger.kernel.org
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

On Wed, Oct 25, 2023 at 10:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Oct 26, 2023 at 01:57:28AM +0000, John Sperbeck wrote:
> > When dbf460087755 ("objtool/x86: Fixup frame-pointer vs rethunk")
> > was backported to some stable branches, the check for dest->embedded_in=
sn
> > in is_special_call() was missed.  Add it back in.
> >
> > Signed-off-by: John Sperbeck <jsperbeck@google.com>
> > ---
> >
> >
> > I think 6.1.y, 5.15.y, and 5.10.y are the LTS branches missing the
> > bit of code that this patch re-adds.
>
> Did you test this and find it solved anything for you?  Your changelog
> is pretty sparse :(
>
> thanks,
>
> greg k-h

I wasn't sure what to write for the comment.  The original backported
commit said that it prevented this objtool warning:

    vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without
frame pointer save/setup

But because of the missing piece, the warning still appears.  That is,
the backport had no effect at all.

With this patch, the message really is gone in my builds.  Shall I
resend my patch with an updated comment?

I also wasn't sure whether a Fixes annotation was appropriate, and
which commit to reference, if so.
