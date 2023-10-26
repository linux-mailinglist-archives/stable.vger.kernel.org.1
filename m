Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15B7D8715
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjJZQzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjJZQzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 12:55:37 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A71187
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 09:55:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7c7262d5eso8814747b3.1
        for <stable@vger.kernel.org>; Thu, 26 Oct 2023 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698339335; x=1698944135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYYr9jMJ2V9M7XS/9+HHih8eXTUxgWOr4GXFFSjebJY=;
        b=yotIMnmBwRU8hN1N0WEZHC4RbijY4OrWT6YAQHfnDYiRhpn0IqXaVCEYcQW7V8DKZK
         eKL/6u62ha5II8v4zzp0Rirkpd4dfiklLfMwAMPP0qw+NBwP0jBisr7q5gzJemL0Wdn0
         Z7wiCeb2aDAgmTr4u346jvswWjDLIalqDHWwueoBeNVWwNiw+6qMeXDvTN5Gr00bRzFW
         HvEw8dbhsuNjyjr0/1JwGPRoUUubZ+IF4P6NUhYHwV++vrlDyBloe+R6EXTF+7cJmR10
         Jw4riRw3Qt+LRHX2kR5SQfRXw1yoBy1kToQkP9rMSBQLXUqcLrtImNKNiMXn54aoZBjO
         Wo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698339335; x=1698944135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYYr9jMJ2V9M7XS/9+HHih8eXTUxgWOr4GXFFSjebJY=;
        b=fRlfo4Y0OR74Svc70aujUBiX9bQYSvdxf3yJqZa8pNoI6UbxmFPjekZls+8JTdfYF/
         HqkPQtLJsOycTq80kuh4r/QPhqI6HwGhFv2YYHtmincz/tXUDuQcNpS3mfClScfY/HP6
         GQVgOsSzT+v0jqsSAQtsYbSpf4TbpVcyiPiuh708yGB0FHCcctYkZg56/8NmENVMHSfw
         VLJMqxac4PTMUM12UYWA/+dn9XnmXiqca/J+uqo0rZwlGElH+V2AmWOIAgDKlEdMJWSM
         7tU8877GhsWsUfN6Is1oYBpvZ7x7njnx8T/uXMhWGb6GUPYkLCRjZIrp+olEfBVbx3YJ
         7V8Q==
X-Gm-Message-State: AOJu0Yx1WtyBpTQdCmBle+JhY4C2S+VkXPckqZdiesEUKtX3wNxubM4T
        vyk2j4sK3hFofVx0sxQ7SqQZ4YQHCav3j79ip8IYLg==
X-Google-Smtp-Source: AGHT+IHGGDcwYV85wbnLf8ZIn7oNuQOX5jFXTYAVL01wXZlutkg2aQNVxXZm7drjpkZ/4gb9MkcInX7CMBO5pwCTD2Q=
X-Received: by 2002:a81:9209:0:b0:5a7:b464:ff1a with SMTP id
 j9-20020a819209000000b005a7b464ff1amr20779809ywg.6.1698339334461; Thu, 26 Oct
 2023 09:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231026164114.2488682-1-hannes@cmpxchg.org> <CAMw=ZnQ56cm4Txgy5EhGYvR+Jt4s-KVgoA9_65HKWVMOXp7a9A@mail.gmail.com>
In-Reply-To: <CAMw=ZnQ56cm4Txgy5EhGYvR+Jt4s-KVgoA9_65HKWVMOXp7a9A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Oct 2023 09:55:23 -0700
Message-ID: <CAJuCfpFJgzRE5jcg0dKi9J+1e1cJxRPeSW56A4G-fV44zivT_Q@mail.gmail.com>
Subject: Re: [PATCH] sched: psi: fix unprivileged polling against cgroups
To:     Luca Boccassi <bluca@debian.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Thu, Oct 26, 2023 at 9:49=E2=80=AFAM Luca Boccassi <bluca@debian.org> wr=
ote:
>
> On Thu, 26 Oct 2023 at 17:41, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > 519fabc7aaba ("psi: remove 500ms min window size limitation for
> > triggers") breaks unprivileged psi polling on cgroups.
> >
> > Historically, we had a privilege check for polling in the open() of a
> > pressure file in /proc, but were erroneously missing it for the open()
> > of cgroup pressure files.
> >
> > When unprivileged polling was introduced in d82caa273565 ("sched/psi:
> > Allow unprivileged polling of N*2s period"), it needed to filter
> > privileges depending on the exact polling parameters, and as such
> > moved the CAP_SYS_RESOURCE check from the proc open() callback to
> > psi_trigger_create(). Both the proc files as well as cgroup files go
> > through this during write(). This implicitly added the missing check
> > for privileges required for HT polling for cgroups.
> >
> > When 519fabc7aaba ("psi: remove 500ms min window size limitation for
> > triggers") followed right after to remove further restrictions on the
> > RT polling window, it incorrectly assumed the cgroup privilege check
> > was still missing and added it to the cgroup open(), mirroring what we
> > used to do for proc files in the past.
> >
> > As a result, unprivileged poll requests that would be supported now
> > get rejected when opening the cgroup pressure file for writing.

Ah, I see the problem. In our discussion
https://lore.kernel.org/all/ZADj4YX4uftK%2FFrh@cmpxchg.org/ we decided
to have the check in open() to fail early but we never considered
unprivileged processes which only poll and never create any triggers.
Makes sense.

> >
> > Remove the cgroup open() check. psi_trigger_create() handles it.
> >
> > Fixes: 519fabc7aaba ("psi: remove 500ms min window size limitation for =
triggers")
> > Cc: stable@vger.kernel.org # 6.5+
> > Reported-by: Luca Boccassi <bluca@debian.org>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Luca Boccassi <bluca@debian.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Thank you very much for the quick fix - this was reported originally
> on the systemd bug tracker by Daniel Black (I do not have an email
> address):
>
> https://github.com/systemd/systemd/issues/29723
>
> It is very important for systemd services to be able to do this
> without capabilities, as using capabilities means in turn user
> namespaces cannot be used (PrivateUsers=3Dyes in systemd parlance).
>
> Kind regards,
> Luca Boccassi
