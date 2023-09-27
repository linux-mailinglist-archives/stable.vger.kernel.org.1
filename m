Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52A57B0D47
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0UV6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 16:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0UV6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 16:21:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A538B11D
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 13:21:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6C0C433C8;
        Wed, 27 Sep 2023 20:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695846116;
        bh=Zzz4VsjLRN0k9sQiBjLgrvvrT3aJ/bCSF5TgMvK3B/o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YVyh9vF1FOGAbZAERGckWyCFZB3gNyThQVkXYAL6cBKBjHUFhgGt6AJYCeSgZWDDh
         uml9PdgJ1HZSOivof5N/zr+CzmQbAiXcB7OnLeUqb0zx0ki1ShDNdDbzl4Kb84Fj9w
         eOYNsjZNo0gY94gJndkiZlwXJk9um1/QhAjLQGO2afTl253dHenQf3OAvrUICSC7dn
         g8bp7CxpO2ee5J/7OBvILltAIp59DnaZl2Oi5Xkwbzhgg4EEoShSRZPFVLAMqEsqNq
         DKDb+pkKu1dtn8qTNh0Yu9Nmxi9oKAdF06OPy0ScfmE8b7mf+UllSQ/NhvQKaDOs6k
         kujC6craqEG6g==
Message-ID: <9c208dd856b82a4012370b201c08b2d73a6c130e.camel@kernel.org>
Subject: Re: [REGRESSION] EINVAL with mount in selinux_set_mnt_opts when
 mounting in a guest vm with selinux disabled
From:   Jeff Layton <jlayton@kernel.org>
To:     Simon Kaegi <simon.kaegi@gmail.com>, stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, dhowells@redhat.com,
        jpiotrowski@linux.microsoft.com, brauner@kernel.org,
        sashal@kernel.org
Date:   Wed, 27 Sep 2023 16:21:54 -0400
In-Reply-To: <CACW2H-5W6KE6UJ8HwD6r9pOx4Ow_W6ACZyg9LpTykjU6tHHB3g@mail.gmail.com>
References: <CACW2H-5W6KE6UJ8HwD6r9pOx4Ow_W6ACZyg9LpTykjU6tHHB3g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-09-27 at 15:55 -0400, Simon Kaegi wrote:
> #regzbot introduced v6.1.52..v6.1.53
> #regzbot introduced: ed134f284b4ed85a70d5f760ed0686e3cd555f9b
>=20
> We hit this regression when updating our guest vm kernel from 6.1.52 to
> 6.1.53 -- bisecting this problem was introduced
> in ed134f284b4ed85a70d5f760ed0686e3cd555f9b -- vfs, security: Fix automou=
nt
> superblock LSM init problem, preventing NFS sb sharing --
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dv6.1.53&id=3Ded134f284b4ed85a70d5f760ed0686e3cd555f9b
>=20
> We're getting an EINVAL in `selinux_set_mnt_opts` in
> `security/selinux/hooks.c` when mounting a folder in a guest VM where
> selinux is disabled. We're mounting from another folder that we suspect h=
as
> selinux labels set from the host. The EINVAL is getting set in the
> following block...
> ```
> if (!selinux_initialized(&selinux_state)) {
>         if (!opts) {
>                 /* Defer initialization until selinux_complete_init,
>                         after the initial policy is loaded and the securi=
ty
>                         server is ready to handle calls. */
>                 goto out;
>         }
>         rc =3D -EINVAL;
>         pr_warn("SELinux: Unable to set superblock options "
>                 "before the security server is initialized\n");
>         goto out;
> }
> ```
> We can reproduce 100% of the time but don't currently have a simple
> reproducer as the problem was found in our build service which uses
> kata-containers (with cloud-hypervisor and rootfs mounted via virtio-blk)=
.
>=20
> We have not checked the mainline as we currently are tied to 6.1.x.
>=20
> -Simon

This sounds very similar to the bug that Ondrej fixed here:

    https://lore.kernel.org/selinux/20230911142358.883728-1-omosnace@redhat=
.com/

You may want to try that patch and see if it helps.
--=20
Jeff Layton <jlayton@kernel.org>
