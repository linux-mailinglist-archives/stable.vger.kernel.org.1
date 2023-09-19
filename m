Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8581E7A6494
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjISNP5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjISNP4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 09:15:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392AEC
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 06:15:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so90314981fa.3
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695129349; x=1695734149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YflXYglgF2ghb+juzkAUfuvNFkVuPP1IFeMvX6P+9A=;
        b=Juzbteth6d6koy19UxP2bY5ZvJCKMa6cxNNBR6PEDuMNxYt1ylxD1daD+NAoXwzJ9l
         lanz4+yS5XU7RmHk+0iZW897MKg5tkPM0cwpUIy/jtRnvWUUr0JF4ylgyz9tRwtjXoUN
         sfLNmQ/TPKQMw9E7//pXkeF/Rw/EB3yznkQdUeg3g8OFUNUODkNDQlpUuWj/Ya2mG0wg
         BL5skGTQk8yoDNku2HiB/px0fh5kZd98V5hFMmSqSJzNZfxBzx7pkhp17qoRHQAN23Dp
         hiUYmKrlmno7gFkEdd36yAkm1qA+WM6e7Spj3kJb8NdkfjxY1dgQmwBVN2b6F515cvDl
         ElbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129349; x=1695734149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YflXYglgF2ghb+juzkAUfuvNFkVuPP1IFeMvX6P+9A=;
        b=LbEoWYpbsqBR5QBuUfRrVWGOUeVnjxVfcGegPu0iXKt+2vEwrBfMUG0pgOiPQ6rmXq
         LdqqGq0zwO5v6ySzIpnWA3C0yEc1ZLilMaMAjZSxf+JAlVmZxRlZkvt//NVbY/HFi2g2
         MzZbvwmPB1ZkgqHnHWmsPJHPkQm2oL4tH0kbBC9ZTdyprWPhjluXYvql6EtJxmWZUK9D
         gfmLbWMeoh4ELnkT1u3ovTygkIeiYHlk1A508H/JaIAyFKlGGl9c70AmhCjs3Zyjm9eC
         jHMJJBbTX+KW0QCNsR4UCYQACbNMM8vMvrsgEHIK5KlFe7V+PJZTNDgGMDVDK4XRI7yR
         sIqg==
X-Gm-Message-State: AOJu0Yxmv5Kt4C/4nTXpQ9aeza83RH/YLqRSpyQ9PWVvE7QawlBxVZOH
        8pQKVwsyAs+XBSYvKVisNtLnZSYqW1R4D7QFq7JxAA==
X-Google-Smtp-Source: AGHT+IE0EuipW9qvFPgLGR9UFGOCTZUcbzOmYvUOgGwWrx+zoDKlqdfvJp7pY8jS/j8A6jnf/le1WKTA2bsfi1/QYUI=
X-Received: by 2002:a05:651c:2106:b0:2c0:a99:68dd with SMTP id
 a6-20020a05651c210600b002c00a9968ddmr6413574ljq.4.1695129349487; Tue, 19 Sep
 2023 06:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230919081808.1096542-1-max.kellermann@ionos.com> <20230919-verweben-signieren-5c69a314440c@brauner>
In-Reply-To: <20230919-verweben-signieren-5c69a314440c@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 15:15:38 +0200
Message-ID: <CAKPOu+-rxm38_sMPv0gasOYvtefd8PJeSWR2Rk_N-mEYDmPqFA@mail.gmail.com>
Subject: Re: [PATCH] fs/posix_acl: apply umask if superblock disables ACL support
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Have you verified that commit ac6800e279a2 ("fs: Add missing umask strip
> in vfs_tmpfile") doesn't already fix this?

No, I havn't - I submitted this patch already several years ago, but
it was never merged, and since then, I've been carrying this patch
around in all kernels I ever used. While doing some other kernel work
this week, I decided to resubmit it, because I thought it's a security
vulnerability to ignore the umask. But thanks, it's a good hint, I'll
check that 2022 commit.
