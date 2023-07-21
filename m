Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692D475BCF3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 05:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGUDuK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 23:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGUDuH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 23:50:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6F272E
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 20:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3573F60F0C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 03:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7B0C433B6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 03:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689911404;
        bh=dK1gbCddzpzxW2NCCjKUrIvdE9phBT/kAZmvWnS5Kx4=;
        h=From:Date:Subject:To:Cc:From;
        b=hmF3WLdrYQugV657yISrW5nd/IzRVNylbS6nGYOsQdr5mPqaoxaYMl3cmf0dH5c67
         EPdYrcfm7WnTbLRkQvF+lF4CPpxkpP3OtWzmRZSrwrKEtXqPDCV3jFP7UoFgewlw+V
         MmN/nwvJAx04UELWfBj3iq9Xb0+CWWGi0b0xB68nSA6JCew+OavnWAUb6m9tZOVIY8
         ex72llU9HMxG40+Ea5gMZt9d4R8lq/9DjonVk2Npo3k1X4rfmjLHI54/Y/5dG2MTIp
         aBRG7NO9M4JdoiGWvVOul9ByI7tKQk7ncMsVCPG4hDWO/2AFdfF1xDjVNHatTbzw7/
         0Nr1U8J8Yh5Kw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5636426c1b3so973556eaf.1
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 20:50:04 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ+NblvLnBaLRn8Tuxy+21u6/nzZioSCu4Uljid9wWeCGcZM3/+
        zuTdYEB06AhPkpxJ3A1J1fz1AyZp6B0cZk951Mk=
X-Google-Smtp-Source: APBJJlHc89QzYr8RsVhFUZ1DPbSYDVKKl5GhXQiuYOBPZcGn0WcdflDouu9NuhDBYzLF+IPnuujuXrz5pr/+CdaXQ0U=
X-Received: by 2002:a4a:ea24:0:b0:566:fd47:eb5 with SMTP id
 y4-20020a4aea24000000b00566fd470eb5mr785263ood.0.1689911403831; Thu, 20 Jul
 2023 20:50:03 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 12:49:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNwjRYQDCD3=VoddnFmhxruzGpyppHr+2ZF3SgqDme-w@mail.gmail.com>
Message-ID: <CAK7LNAQNwjRYQDCD3=VoddnFmhxruzGpyppHr+2ZF3SgqDme-w@mail.gmail.com>
Subject: linux-stable regression: please backport 8ae071fc216a
To:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg, Sasha,


Please backport 8ae071fc216a ("kbuild: make modules_install copy
modules.builtin(.modinfo)")
with this tag:
Stable-dep-of: 4243afdb9326 ("kbuild: builddeb: always make
modules_install, to install modules.builtin*")



Recently, we back-ported 4243afdb9326, which depends on 8ae071fc216a


Without the proper dependency, there was a regression report
for Debian package builds with CONFIG_MODULES=n.

https://bugzilla.kernel.org/show_bug.cgi?id=217689#regzbot


-- 
Best Regards
Masahiro Yamada
