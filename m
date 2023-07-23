Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD875E40C
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGWRfO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWRfN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 13:35:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A83E5F
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 10:35:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b89cfb4571so29176855ad.3
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690133712; x=1690738512;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HK2pV6k08QvzAHjZWJL6DCZtiJZ4FI48KqLH+xnxvOw=;
        b=DEKhe27GnZzg5KAQo2cjK2l42EQWSugRm5DIx7+cr3474hZbf8g79MVnkcHA4UM51e
         KoZyBEsk9qF9RJkanpnEE0vwDFdol8Qu1P3oLM3E4rKTtTtG69y0q80LXsq5pHCUNNgL
         0XDKLtaOrPlg6VyNNHVHVlhudYxzZzope4qUuROt9JWybI6qIEk5+jIszhok4D4GM/9x
         ma4GjBWKSeB6YwxbTE6pkpbE+qpRnuozh6UnBNUUdPQtvcwhncVEIApOiMElUTdmprIm
         vJYTfiJYgWkRBVylbwgIMnAYfhEoWChGlCZVm3ujkgFwHX/2aUQtBt+LGwJVZ3JOY0r8
         UdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690133712; x=1690738512;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HK2pV6k08QvzAHjZWJL6DCZtiJZ4FI48KqLH+xnxvOw=;
        b=M+uNqV5+tWkDa7m0Z5R8XcWwBJ+MhNR22RSO/CNb903jSQ1/GBPnSEC2okCUFSCJM+
         chZBcSxwtuupez3ZvkSV9KjyqmX/A4sTyXwyR5yLRvyqAEd8qyNJJ6jFdO36WLBuB/FN
         aVAGLYhsgwvazRRiN2FtU3B4q6Hn3V0WuGiTcgg+habmbjD5Ppi8dAXrqEIE7ShJ3jXR
         EcxwaqPqumnqfw7XZffkxGwIMJ/rktaO0gSZmHbfGYe8y1szoYdiyEswoyrzzbhPtmSz
         wRDxn7OasMTYRRFjd5aq7KkqsTIR/chQGP5m3zQg8aRilwX9UP2YYDydBKOaaPsTo0kM
         +uZQ==
X-Gm-Message-State: ABy/qLZx9obTDphcLEiyiCLPdeN12UApaYoqPVnGIhWNouuRqXqWQ7Zv
        RoBtUAkzNPbWU/HwT8SqXb74Tx0VVlQQvCCG810=
X-Google-Smtp-Source: APBJJlE8NS5k2rzVKAJE8ZfLUJoQS2PLbfEuqvzCZiR1JRYesW2f+d340P2my3UNn8KJAXyzq9JWMQ==
X-Received: by 2002:a17:902:e5c5:b0:1b9:c205:a876 with SMTP id u5-20020a170902e5c500b001b9c205a876mr9468364plf.29.1690133711717;
        Sun, 23 Jul 2023 10:35:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170903049600b001bb54b6c4e4sm7138818plb.147.2023.07.23.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 10:35:11 -0700 (PDT)
Message-ID: <64bd64cf.170a0220.4dd45.c53e@mx.google.com>
Date:   Sun, 23 Jul 2023 10:35:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.121-29-g391f6b7e3028e
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.15.y build: 1 build: 0 failed,
 1 passed (v5.15.121-29-g391f6b7e3028e)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y build: 1 build: 0 failed, 1 passed (v5.15.121-29-g39=
1f6b7e3028e)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.15.=
y/kernel/v5.15.121-29-g391f6b7e3028e/

Tree: stable-rc
Branch: linux-5.15.y
Git Describe: v5.15.121-29-g391f6b7e3028e
Git Commit: 391f6b7e3028e9d7d796e39901cc16db4689074d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 1 unique architecture

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---
For more info write to <info@kernelci.org>
