Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF77B20FE
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjI1PUo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjI1PUo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 11:20:44 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE2E5
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 08:20:40 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65b0216b067so42883256d6.1
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695914440; x=1696519240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AETJrlvFJ0cIdb5tq1g9p7AMJQG7QgUXqW2J3LTW7GM=;
        b=SDAEt/5oQvcGQcX7jyxV2xwYlUeqWI8WRqO3avzg4GP04CDmhs1/6VYNU82Cu7ns2+
         RUt5mr8vVdTSFLZS5HYBOatbL6XweKzj9+QU/cHDLzzsMvSoFl9EIPkC7OHmMyuSFG5+
         pFd6iGfUiIkNH2pNG+A6E2dHyecuUagg4n0YeWVKU4l+9ZTafbMsHLbRVEEz0LpN5dQ5
         e5+cMnnlXWQYA3AbIYqX82/m0mcNbNMw+HwbENEQwah20Gw9MIFqxENZEpi9bs3s8RX9
         +Rp+UAtwnBl1HBiJ/bU3KbZalpcZX6KQ+qXOvrhv3wFFcyxjPFAOpLo3sE+XOKx47Fk1
         A0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914440; x=1696519240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AETJrlvFJ0cIdb5tq1g9p7AMJQG7QgUXqW2J3LTW7GM=;
        b=Y50DxDKF6SBfN2nrSiKnG1Ex/l0tzRhMosU2KvLXATccgfGRMv52N0gRQrYdcJHeRx
         82evvQQ9HLAVtef8Zg6v6Lk9z1y5MNWJRvBpHk+FNMNI3S0CQmk7zFzuf9/wjWFoPFaE
         oSGSKBmgUSZUF4vvrSSifDo/xa0bZhNYczvwibXJEV/SvkxrOuMlHT8XQfDk5f6ZcIaf
         vLkIkucQ8AR5InWTg957StCsJGnHlPdZWc2GMnA5xSUtmq0LLmEjV7UNkMC0eyroKnim
         IgXz5R3rTupsZWgz/AOa4pJt2+ilqPfprPwLwuuvq5cVzTCuZahPb2pTGR1WHmCp3ubO
         WVbQ==
X-Gm-Message-State: AOJu0YzRIcMr3dLH3YhmpxqCwnoSqdCjOHxeOrPLnBpVIf9BEqofLMgW
        pn3doYBEj6sbR+8sL9aTzTNI8VRvIe4LGliCAGTM788Xa0olFQ==
X-Google-Smtp-Source: AGHT+IGBzt2VnTIFh/akvUGAGezV0EEpqe6DzZVnHJCqNHU31whUJvU8YnPWWJvzlzMFV8jyNaATUg8e0xzrjKUq72E=
X-Received: by 2002:a0c:ab10:0:b0:648:190c:bdd5 with SMTP id
 h16-20020a0cab10000000b00648190cbdd5mr1387953qvb.9.1695914439717; Thu, 28 Sep
 2023 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACW2H-5W6KE6UJ8HwD6r9pOx4Ow_W6ACZyg9LpTykjU6tHHB3g@mail.gmail.com>
 <9c208dd856b82a4012370b201c08b2d73a6c130e.camel@kernel.org> <CACW2H-7-KyYrAcnO+QKBV9fs4mGfzOpKvAutbj6hkq7D0m+EzQ@mail.gmail.com>
In-Reply-To: <CACW2H-7-KyYrAcnO+QKBV9fs4mGfzOpKvAutbj6hkq7D0m+EzQ@mail.gmail.com>
From:   Simon Kaegi <simon.kaegi@gmail.com>
Date:   Thu, 28 Sep 2023 11:20:28 -0400
Message-ID: <CACW2H-4ABAXpPrUVAE=THOpJNzED_CkcBgysCw6PtVM2vGSd+Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Ah... I see it's already in 6.1.55 -- tested that and confirmed we're all g=
ood.
Thanks.
-Simon

On Thu, Sep 28, 2023 at 10:43=E2=80=AFAM Simon Kaegi <simon.kaegi@gmail.com=
> wrote:
>
> Thanks Jeff. I've confirmed that Ondrej's patch fixes the issue we
> were having. Definitely would be great to get this in 6.1.x. soon.
> -Simon
>
> On Wed, Sep 27, 2023 at 4:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Wed, 2023-09-27 at 15:55 -0400, Simon Kaegi wrote:
> > > #regzbot introduced v6.1.52..v6.1.53
> > > #regzbot introduced: ed134f284b4ed85a70d5f760ed0686e3cd555f9b
> > >
> > > We hit this regression when updating our guest vm kernel from 6.1.52 =
to
> > > 6.1.53 -- bisecting this problem was introduced
> > > in ed134f284b4ed85a70d5f760ed0686e3cd555f9b -- vfs, security: Fix aut=
omount
> > > superblock LSM init problem, preventing NFS sb sharing --
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm=
it/?h=3Dv6.1.53&id=3Ded134f284b4ed85a70d5f760ed0686e3cd555f9b
> > >
> > > We're getting an EINVAL in `selinux_set_mnt_opts` in
> > > `security/selinux/hooks.c` when mounting a folder in a guest VM where
> > > selinux is disabled. We're mounting from another folder that we suspe=
ct has
> > > selinux labels set from the host. The EINVAL is getting set in the
> > > following block...
> > > ```
> > > if (!selinux_initialized(&selinux_state)) {
> > >         if (!opts) {
> > >                 /* Defer initialization until selinux_complete_init,
> > >                         after the initial policy is loaded and the se=
curity
> > >                         server is ready to handle calls. */
> > >                 goto out;
> > >         }
> > >         rc =3D -EINVAL;
> > >         pr_warn("SELinux: Unable to set superblock options "
> > >                 "before the security server is initialized\n");
> > >         goto out;
> > > }
> > > ```
> > > We can reproduce 100% of the time but don't currently have a simple
> > > reproducer as the problem was found in our build service which uses
> > > kata-containers (with cloud-hypervisor and rootfs mounted via virtio-=
blk).
> > >
> > > We have not checked the mainline as we currently are tied to 6.1.x.
> > >
> > > -Simon
> >
> > This sounds very similar to the bug that Ondrej fixed here:
> >
> >     https://lore.kernel.org/selinux/20230911142358.883728-1-omosnace@re=
dhat.com/
> >
> > You may want to try that patch and see if it helps.
> > --
> > Jeff Layton <jlayton@kernel.org>
