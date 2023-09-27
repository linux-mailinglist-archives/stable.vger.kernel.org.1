Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C625D7B0CFC
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjI0T4i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjI0T4c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 15:56:32 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5178BCCD
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 12:56:06 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65af7e20f39so51956156d6.2
        for <stable@vger.kernel.org>; Wed, 27 Sep 2023 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844565; x=1696449365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5A+e538uMQ9k/uzyhmViIJnbml3dasNee8PoGBFz6DE=;
        b=BqJDPi3nE9KrsT9B4rKadDIVer7uZPDG5+cSjP46xSzcNmFBN93qyflPy4CxhZ7y9R
         nh5DTaQ/JvDo7tBsxIjIFkBVpDOSETNBtFof1FLvVidQl7YS3JeaYlrP28KB9hxFOEgm
         S5YzEczLyTfrxIqvzv82Fk3ofIaJo+Mew0/Nk8eVhmI4Wuf8ro1DHh/UaqiqEHL3cyY/
         9tA/NpCDqhrARSJt8aek60T2T7TtfTUDUjjjCaCALqb9chzwq+bIJ9KGBIUxHkEOMdpk
         yUjwiCl5VbO+cPZfzHpQgPws9C6+jlcxysSwLtaEckz0u7X5O1KIhGBfCaDOXyEBMqyc
         u8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844565; x=1696449365;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5A+e538uMQ9k/uzyhmViIJnbml3dasNee8PoGBFz6DE=;
        b=uRaLj+rGajyY+rxwlivFVcr/sJgyfL2Wc5ihXuXwGWHr7oH5sfrfZsdNs9RYY8X57+
         CTYFefK3RC/l8rWyqBYrSP5wsy6b4oXQLEjq+c+nawL9x+t7NAdridLYxw5aF03GHEkZ
         h6Q67rQR85S2GaIePk/6iWwyYUGSvugfiHI/xYXcpPP2HsNBqvVI2OTKcofgOKV/GeZ0
         l7c/n1EhjkME4n1HFyCLU7SIGn3d1iBEAx0mXRqXadS5LzrZcW/n1sqA7OANwOT8QPiw
         dovYqjwR/r9Ia6IJB/oAsPeUzywVsuGd4h5QEusblBfYZdDd1U5Np04BYP6e1NKGRQjE
         JZ2w==
X-Gm-Message-State: AOJu0YyXiZuif1OthS8dBZVQoxKs1kCbAYNuqIInwmQW5xxHnrQ5QQHe
        Fzc/jQMZMVhllZxM35sjsfAwXq7GQay9cDzxwzLSp7AO43WfOQIh
X-Google-Smtp-Source: AGHT+IGHzPPg4FYPmcv6LpEYvSLXtkhXZXZ6WSl/my37BuK9tBvcubscOLBy5wWBmJcEfgA2qADHhdeBIf2VV86idc8=
X-Received: by 2002:a0c:e4c9:0:b0:656:34c5:13b9 with SMTP id
 g9-20020a0ce4c9000000b0065634c513b9mr3489700qvm.34.1695844564830; Wed, 27 Sep
 2023 12:56:04 -0700 (PDT)
MIME-Version: 1.0
From:   Simon Kaegi <simon.kaegi@gmail.com>
Date:   Wed, 27 Sep 2023 15:55:49 -0400
Message-ID: <CACW2H-5W6KE6UJ8HwD6r9pOx4Ow_W6ACZyg9LpTykjU6tHHB3g@mail.gmail.com>
Subject: [REGRESSION] EINVAL with mount in selinux_set_mnt_opts when mounting
 in a guest vm with selinux disabled
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, dhowells@redhat.com,
        jpiotrowski@linux.microsoft.com, jlayton@kernel.org,
        brauner@kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

#regzbot introduced v6.1.52..v6.1.53
#regzbot introduced: ed134f284b4ed85a70d5f760ed0686e3cd555f9b

We hit this regression when updating our guest vm kernel from 6.1.52 to
6.1.53 -- bisecting this problem was introduced
in ed134f284b4ed85a70d5f760ed0686e3cd555f9b -- vfs, security: Fix automount
superblock LSM init problem, preventing NFS sb sharing --
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.53&id=ed134f284b4ed85a70d5f760ed0686e3cd555f9b

We're getting an EINVAL in `selinux_set_mnt_opts` in
`security/selinux/hooks.c` when mounting a folder in a guest VM where
selinux is disabled. We're mounting from another folder that we suspect has
selinux labels set from the host. The EINVAL is getting set in the
following block...
```
if (!selinux_initialized(&selinux_state)) {
        if (!opts) {
                /* Defer initialization until selinux_complete_init,
                        after the initial policy is loaded and the security
                        server is ready to handle calls. */
                goto out;
        }
        rc = -EINVAL;
        pr_warn("SELinux: Unable to set superblock options "
                "before the security server is initialized\n");
        goto out;
}
```
We can reproduce 100% of the time but don't currently have a simple
reproducer as the problem was found in our build service which uses
kata-containers (with cloud-hypervisor and rootfs mounted via virtio-blk).

We have not checked the mainline as we currently are tied to 6.1.x.

-Simon
