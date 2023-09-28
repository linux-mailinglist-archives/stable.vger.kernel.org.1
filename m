Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843927B1FE8
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjI1One (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 10:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjI1Ond (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 10:43:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FF4180
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 07:43:30 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7740cf93901so746868585a.2
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695912210; x=1696517010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEvAYAapqiaXm0tIJM5yoNgVHww0X7eA8eny72ES378=;
        b=bmS5wTmM5YHXht3h1dKSrLGd9fQnmYd/sDqd6s0K2WwlAYX6T0vG6YPVjcBCQb66fa
         DA+XnpFXt3gUHmwtTKH0GBkg7eES/EdUaJ/UYg1jka2ETG7o9k0DP/Hk7vtgnYa64gwK
         ogAWq9GcZ6FcxnMoVB/MvdTglTwjR+a5rdxrb8IJXerRnWUXLT+0JtRxf9zJ4YQ+cKe+
         t4GY9ZbLQn33cQ10Zwbb+wmlSmAQWTAiRQPmeu2qYH9/+nIYtEgG5BojhIoCCnfZDshL
         +jUfrfOkdRAQV9TutaLB3i00ZwpBX5vDFI4HbududHQ0llrYAy/oFhoeLwyBWZDlGcFi
         gQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912210; x=1696517010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEvAYAapqiaXm0tIJM5yoNgVHww0X7eA8eny72ES378=;
        b=W3B05KhxStehplElHQ4M02XyAu8ebeOpiOXhvuXQjNR4Otye/3O7wVp4n+s0f2y4Ce
         u35DThZTiVB253vw+io3b3luECI1Pw+05YX2JRgA9goXxfrmBjoUAqw2EPR+RDZCMSwS
         RKzfHJuUttAIltj7qSZSNJltKih1xlYclzeh837EwDr8+fjRk10eAngNk/K+kIUPoyb1
         0WuGqfBBuOQSO9BsDtUkn+v44t6DT7ETsoZtN8KW8181rq+YiNh+pSm/YL2vcfWxo2SG
         pxqZVrkBTtINFrYEls93cdF21pTC3YbC15xO4h0/x7ptR8/9o38dUoPZSsJBIhhaPtxL
         BB9Q==
X-Gm-Message-State: AOJu0YwjHbAenHwuTkJeixX675Iz7MJInvWp+GyAPpfG4UIr7lh3t9Xp
        mmOoEC7GGs44vAzKeUAJqSfS7y8Gq2h0gm+CaSi+u9emR5Icpg==
X-Google-Smtp-Source: AGHT+IG+ec8FIIBvgJDkegfTZ8Pve3+o4Pl8ogfUyDno53sg8GfpCoV7qHr3TG+xffedjcZ9vcaaXEeAkll2Yy5EAUA=
X-Received: by 2002:a0c:b384:0:b0:655:f784:9d25 with SMTP id
 t4-20020a0cb384000000b00655f7849d25mr1222960qve.59.1695912209847; Thu, 28 Sep
 2023 07:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <CACW2H-5W6KE6UJ8HwD6r9pOx4Ow_W6ACZyg9LpTykjU6tHHB3g@mail.gmail.com>
 <9c208dd856b82a4012370b201c08b2d73a6c130e.camel@kernel.org>
In-Reply-To: <9c208dd856b82a4012370b201c08b2d73a6c130e.camel@kernel.org>
From:   Simon Kaegi <simon.kaegi@gmail.com>
Date:   Thu, 28 Sep 2023 10:43:17 -0400
Message-ID: <CACW2H-7-KyYrAcnO+QKBV9fs4mGfzOpKvAutbj6hkq7D0m+EzQ@mail.gmail.com>
Subject: Re: [REGRESSION] EINVAL with mount in selinux_set_mnt_opts when
 mounting in a guest vm with selinux disabled
To:     Jeff Layton <jlayton@kernel.org>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        dhowells@redhat.com, jpiotrowski@linux.microsoft.com,
        brauner@kernel.org, sashal@kernel.org
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

Thanks Jeff. I've confirmed that Ondrej's patch fixes the issue we
were having. Definitely would be great to get this in 6.1.x. soon.
-Simon

On Wed, Sep 27, 2023 at 4:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-09-27 at 15:55 -0400, Simon Kaegi wrote:
> > #regzbot introduced v6.1.52..v6.1.53
> > #regzbot introduced: ed134f284b4ed85a70d5f760ed0686e3cd555f9b
> >
> > We hit this regression when updating our guest vm kernel from 6.1.52 to
> > 6.1.53 -- bisecting this problem was introduced
> > in ed134f284b4ed85a70d5f760ed0686e3cd555f9b -- vfs, security: Fix autom=
ount
> > superblock LSM init problem, preventing NFS sb sharing --
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.1.53&id=3Ded134f284b4ed85a70d5f760ed0686e3cd555f9b
> >
> > We're getting an EINVAL in `selinux_set_mnt_opts` in
> > `security/selinux/hooks.c` when mounting a folder in a guest VM where
> > selinux is disabled. We're mounting from another folder that we suspect=
 has
> > selinux labels set from the host. The EINVAL is getting set in the
> > following block...
> > ```
> > if (!selinux_initialized(&selinux_state)) {
> >         if (!opts) {
> >                 /* Defer initialization until selinux_complete_init,
> >                         after the initial policy is loaded and the secu=
rity
> >                         server is ready to handle calls. */
> >                 goto out;
> >         }
> >         rc =3D -EINVAL;
> >         pr_warn("SELinux: Unable to set superblock options "
> >                 "before the security server is initialized\n");
> >         goto out;
> > }
> > ```
> > We can reproduce 100% of the time but don't currently have a simple
> > reproducer as the problem was found in our build service which uses
> > kata-containers (with cloud-hypervisor and rootfs mounted via virtio-bl=
k).
> >
> > We have not checked the mainline as we currently are tied to 6.1.x.
> >
> > -Simon
>
> This sounds very similar to the bug that Ondrej fixed here:
>
>     https://lore.kernel.org/selinux/20230911142358.883728-1-omosnace@redh=
at.com/
>
> You may want to try that patch and see if it helps.
> --
> Jeff Layton <jlayton@kernel.org>
