Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E475E40B
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjGWRac (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 13:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGWRab (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 13:30:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04931B3
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 10:30:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6862842a028so1967954b3a.0
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690133430; x=1690738230;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gSigQ3RYDVlcwVQZ5/X7PfmqFpEpiL+2gs5b5ja53dg=;
        b=1Psu4vwLKiaioAMv+Cq3TG0fVHbK67uqoMx/EfbmiQnVqbGJLCcNaoOdEbsKfYREPG
         nJUVLz3njZ1xu/2l9OSfXHKdjqdwf06si5z3oUmTamTKZuQMRMi85tWrFHNDP328lsCS
         qiowGQzH/FmkdWmNWqzENkpGWVOXrztIT6dIqRpR3zsOZN7+eGb0XsaM8jZqytpp1wB+
         Re2CYf+yeMeoBUyjwVuKUWWKAFQOBY8UJN+TNb3RXBvahlLjb4c/zLBruAsTShzl9+q/
         cn5icewqskc793YGQywrbkxdJVPralroIfYdyVoVYCIc4fYqVoURpe6OnX6pV1lk5iXX
         pmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690133430; x=1690738230;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSigQ3RYDVlcwVQZ5/X7PfmqFpEpiL+2gs5b5ja53dg=;
        b=CSMsM6ZuxL09RK44m+xQogDDB6696Ki20Z67/wbTkkns4kVAINDL1pY35imzimPX4f
         Yu1cn5W8nLurpYWd/0HUbI/Ye0rEgi1rhISHlHsM5oz4uCTVQzQBTd3pxtsmo0FilyV2
         2KR0Fn6ZTe/O4en3/wMK50K9lVAm1IHi4L3XAEHIopcdN+UfZAa3TftFMfMo4PMulScK
         OKbszdL4w/Qg1U2TI9CGLKsE9ix8DY4ifdLRDwF9N8BOYxh4uK4I2GthtuK7PAUce9bY
         QcQtgaDwonJ6o5oUeM6XbR4Qb9fx7wNbV2vxpQQGA3akWojxdqvG69Sneovg1ncKpcoS
         XeAg==
X-Gm-Message-State: ABy/qLY3uMfIb/DqggM46PHe83r2O3nEtqJUwUkIz0lV3NYIlbWtYnsX
        +rsocBNEwxJKir/uX9zc2oR4IfhStlBduM//Cj0=
X-Google-Smtp-Source: APBJJlFjXWj+IO3+cMINEnEpplZ2RbYwSsi8ydBWq1kQCOSCYglpDuvM/vBo0hzL7QXureX1l1apdw==
X-Received: by 2002:a17:90a:bc92:b0:267:f9c4:c0a8 with SMTP id x18-20020a17090abc9200b00267f9c4c0a8mr3251670pjr.4.1690133429780;
        Sun, 23 Jul 2023 10:30:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902d51100b001ac741dfd29sm7107380plg.295.2023.07.23.10.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 10:30:29 -0700 (PDT)
Message-ID: <64bd63b5.170a0220.7c028.c754@mx.google.com>
Date:   Sun, 23 Jul 2023 10:30:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.40-51-g8866318d3d938
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 1 build: 0 failed,
 1 passed (v6.1.40-51-g8866318d3d938)
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

stable-rc/linux-6.1.y build: 1 build: 0 failed, 1 passed (v6.1.40-51-g88663=
18d3d938)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.40-51-g8866318d3d938/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.40-51-g8866318d3d938
Git Commit: 8866318d3d9385b1aa14ca02ab8417dfb7c11161
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
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
