Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B317C9B90
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjJOUiW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 16:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOUiV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 16:38:21 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2461AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 13:38:19 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-777506ccc6cso162693285a.3
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697402299; x=1698007099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjESx8kZrRkYQsihGYYxFxBRexDaHO2/8CRgk23TiSs=;
        b=A5YnqS/tb46nqlHyoQnNA1bpcgxR8ofHZdkH8pJm1PvDBkQcuDzxDYnQgqGBAL4PAe
         agX7gcyf6nGsLKCcRACKFs2QO2hQz9/VtooEZhmzOG9mG45CG5szYCHirocYmUc8e1c3
         W9tGDQUyjIjueIJdSr+mSvKoYYb0MjsDD8Vo5wwFTLZ9YnnRQ0WtIySrvD6BpTUDOdh0
         dY9mdn/ccT5Eihz6PzbBw/m+8n8tSpara99h6vh8Zz0gu5aIj5Q4bNFFFZj1cAKN3wBq
         auPNOORKwC+Ptxih2c/iUXbBenKI6vvW9QBibh1F6rFrx0Bsb321V0Q76HizqoKRCleh
         35ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697402299; x=1698007099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjESx8kZrRkYQsihGYYxFxBRexDaHO2/8CRgk23TiSs=;
        b=hcdM6THi0nh9o6I7d636Wqx45PhixUeydV8sqJ6a5TIuHQvuiS7qv3l/8PSPX3u5cx
         0/BuM9uj9H1CHxG6CkSw7MhJyIiXEfVR/fug2a5TkD5l7BdapWMWhhbgUodN9oXEwJKW
         BTCE6la2PoOUzxQ3s1WhgQriK39cjqNgrWGjMdOr2AYOeb/3+lR5AI2CGyVpE3m5lk8R
         M9YMmyQzVJF3t33CyXOjw/By1oVhcjZJylGuZo5etzmVDbpjsrRe5AkUKASA6ESfAs/P
         ILueX1vhTsNsuZkFglm/LsaDzNlc5URu0ammrTT27U4JXXULOlWgmVNJCxHqxA879HeN
         3YlQ==
X-Gm-Message-State: AOJu0YypEDxryVUEDSCQc/f59H4P1lEe9e7Nu/UiYhiSMddI7b9t3+vF
        3qFMBK1JKY7/9hOtHWxxrktiWTngfDdKLIK/SbjaKqpd5TOMeA==
X-Google-Smtp-Source: AGHT+IFJpVkvC/EFSzUuX6VpT61Exz9BEd42Xn94boaL/rhPc8NF8fxxMD0n1N4uTwppRhw61/MV4ar9L98rZpI6inY=
X-Received: by 2002:a05:620a:44d0:b0:775:d42e:3e6f with SMTP id
 y16-20020a05620a44d000b00775d42e3e6fmr39727660qkp.65.1697402298661; Sun, 15
 Oct 2023 13:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <2023101544-ensnare-grain-3f88@gregkh>
In-Reply-To: <2023101544-ensnare-grain-3f88@gregkh>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 15 Oct 2023 23:38:07 +0300
Message-ID: <CAOQ4uxgzO1Sdki-AeJqsOST-XU09+CEcq3g1qYcWQkooMgTwjw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ovl: fix regression in showing lowerdir
 mount option" failed to apply to 6.5-stable tree
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 8:57=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.5-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.5.y
> git checkout FETCH_HEAD
> git cherry-pick -x 32db510708507f6133f496ff385cbd841d8f9098
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101544-=
ensnare-grain-3f88@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
>
> Possible dependencies:

Please apply this dependency (from 6.6-rc5):

a535116d8033 ("ovl: make use of ->layers safe in rcu pathwalk")

Thanks,
Amir.
