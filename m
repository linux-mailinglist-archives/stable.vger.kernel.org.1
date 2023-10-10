Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6187BFFE8
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjJJPCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjJJPCk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 11:02:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E66AF
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 08:02:38 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d84d883c1b6so5954179276.0
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696950158; x=1697554958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1yWK5hjBQ0wjkXfSMeS0ZutGUHPxAuWdRVh9wYUYN0=;
        b=y1Ch3xacV9UYOYbtQF/ygG09JX7W2v2g6rPSFNfYFIah2logoECmUN8/9cutPaJuWV
         kpk1ml99Eu6q6sQlYQWfOwuafIpjdptTUl80mqJvfPhRrJXa4XX+JoCiOLKTl3K3tdPW
         UWs1pPGURmYjtZVW2Xs6crLKupC9acmSYU+/q4NuAiVyOtjGjqsDbfCD0EENkFwbRsCk
         6aZzrbyvVp0wY9tDNxcgKuHtfety/Fq+EVi1b/mU2SLxAgj3bcKeXQvioqTGjGlXhb3B
         gl865YXo/828WdNM8yUv5tv6xztHg2OMN7DJYecw8IsvBmcc9Xrtiftd0sj/zbh64+1W
         JEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950158; x=1697554958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1yWK5hjBQ0wjkXfSMeS0ZutGUHPxAuWdRVh9wYUYN0=;
        b=fyud/A8ckIPED7ar6Dij5cVgrtscr5dd8xEWsAyCXBCIoh8nLrJI9dpmFxg0VPnCI0
         RwFSX2m85XxV+87pGO/GAhnDN7fPzBtgnrejr08ftfoNg5t2dmCYEMTeROn7NOxFwPeX
         Umlq4q/k7NfV+9MLixSUQINpVY5h7A0xFCQ1X4aGqH7/LrnqNxf64CL+SHLjVfcmBVCO
         iMRS6QAN96bBEugH5noep0SigesoaBWvpZL4I+P1KrIvQj4pcjuKu739BmnQDwzUjCJ1
         +lbegrpjU9a+xDdGzW6+65kAJ3goCZw+R7ae/GlQ2vT8RdxKGi/hPSb2rW5wQyKrjLsN
         R6hA==
X-Gm-Message-State: AOJu0YxNZSKEBnlt5rg4K1Mc8ZMQqyZ3SalRUK6IAuPKGxiz1OeLqxIU
        REuC1A8ZhnZGjWbmMsIiyRjYQpnlhwQmoEmFwAq6MQ==
X-Google-Smtp-Source: AGHT+IHYBpK+4fI/9nFvpGF+AWon1DhPZtC+/skjso/3+I7vMWj+ecsz05uAzVg4IRIY+AFlCmcCo7MX7O6oMEWIIdU=
X-Received: by 2002:a25:8503:0:b0:d9a:4cc0:a90c with SMTP id
 w3-20020a258503000000b00d9a4cc0a90cmr2065065ybk.15.1696950156384; Tue, 10 Oct
 2023 08:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com> <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
 <20231009080646.60ce9920@kernel.org> <da08ba06-e24c-d2c3-b9a0-8415a83ae791@mojatatu.com>
 <20231009172849.00f4a6c5@kernel.org>
In-Reply-To: <20231009172849.00f4a6c5@kernel.org>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue, 10 Oct 2023 11:02:25 -0400
Message-ID: <CAM0EoM=mnOdEgHPzbPxCAotoy4C54XyGiisrjwnO_raqVWPryw@mail.gmail.com>
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC requirement
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com,
        Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 9, 2023 at 8:28=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 9 Oct 2023 12:31:57 -0300 Pedro Tammela wrote:
> > > Herm, how did we get this far without CCing the author of the patch.
> > > Adding Budimir.
> > >
> > > Pedro, Budimir, any idea what the original bug was? There isn't much
> > > info in the commit message.
> >
> > We had a UAF with a very straight forward way to trigger it.
>
> Any details?

As in you want the sequence of commands that caused the fault posted?
Budimir, lets wait for Jakub's response before you do that. I have
those details as well of course.

> > Setting 'rt' as a parent is incorrect and the man page is explicit abou=
t
> > it as it doesn't make sense 'qdisc wise'. Being able to set it has
> > always been wrong unfortunately...
>
> Sure but unfortunately "we don't break backward compat" means
> we can't really argue. It will take us more time to debate this
> than to fix it (assuming we understand the initial problem).
>
> Frankly one can even argue whether "exploitable by root / userns"
> is more important than single user's init scripts breaking.
> The "security" issues for root are dime a dozen.

This is a tough one - as it stands right now we dont see a good way
out. It's either "exploitable by root / userns" or break uapi.
Christian - can you send your "working" scripts, simplified if
possible, and we'll take a look.

cheers,
jamal
