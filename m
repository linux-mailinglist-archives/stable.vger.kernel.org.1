Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F877613E8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjGYLPH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjGYLOu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED311FCA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C71F161656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EA5C433C8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690283628;
        bh=psEGZe6Qjo2C2pk/40ITsJhO8BgHfRUSLkDwEcC+Xys=;
        h=From:Date:Subject:To:From;
        b=EhDhlxa9akZ0IErWWc6aAx8pSGtCIH8J6jiZEBUT59S+AygIwEo7wlja+wsVeG3lG
         MmD8UwqBed53o53vL+u3nunFBqIzJ9088r3aZ4Bf+g/AGffnD5RPX0Gd7Y57eO75QU
         UhnbaBWi9IxsvO4Q4owxYDng+MybmF0n9ISPUkiJo9cSeoqTB/ykU2ci+Evfyxur99
         1qn5QIYG72hsXs4tyIjvaf4y/OUyX/VW5cbdD8CmXLI3Zc2QsYvtcRTrayHkFyyRax
         pbV3+yoZyHIi7JVy0vfsU0wTGdgwAMSM/lc5bZQtU/unpdcluSjSrEAksy1O5yscIC
         p0NYRywMpIoyw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b9a2033978so6546581fa.0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:48 -0700 (PDT)
X-Gm-Message-State: ABy/qLYHlJX5FnMBz8yMwvZVvUvzh2l3G7jIS9T90Na3KQi9fds8S1XV
        BX6XnrzrfiwaZxe3WCT6dMkvpcCPxo3kF2fRhTE=
X-Google-Smtp-Source: APBJJlHTYE6jNCnlv4MUWDGZXVjU0xYNfuS+BmkFQfxUHGF+00BejQRKJRSnmwwwY4s50yua2lwLkb/1Vr89a0E9cdw=
X-Received: by 2002:a2e:9906:0:b0:2b6:ded8:6fc1 with SMTP id
 v6-20020a2e9906000000b002b6ded86fc1mr8404840lji.25.1690283626178; Tue, 25 Jul
 2023 04:13:46 -0700 (PDT)
MIME-Version: 1.0
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Jul 2023 13:13:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
Message-ID: <CAMj1kXHQkgRCt=W0FbZZ9qLVCaWisFhv9wJtYONjA3cEPdXMRQ@mail.gmail.com>
Subject: backport request
To:     "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please backport commit

commit 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Tue Aug 2 11:00:16 2022 +0200

    efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory

to all active stable trees all the way back to v5.15. I will provide a
separate backport for v5.10, and possibly a [much] larger set of
backports for v5.4 for EFI boot support.

Thanks,
Ard.
