Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF575E426
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 20:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGWSYk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWSYj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 14:24:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11312E64
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 11:24:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-668711086f4so2276219b3a.1
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690136678; x=1690741478;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ycyouuERwIeR4HaIm00BzGcE9hax3SSe2qob1J02fFM=;
        b=unvStDif1xsPMmRBYadVIpOplZ3yb4jEU8erP03sULJxu2jVVTzgoktVIaH/7GTBMv
         qpy9tzLugbFlX3dgLk+7YayLlEj+u9a/pfEYHPiWwk1DCRCyE6gnvKBYkc0tirfte+LZ
         zh47TLbiQJ2xFE/5Yt3pYibbHy1i1aN5V1RUTugzptqeTvUvJa8Xh4M6R+cLFye2d8Ce
         HDTH4hYaDofeU8QsT9+vPpj0ZPTSUDTSjr7KFGXG46X9cbxMZaig8fsDUN4UiSk3a5Z4
         xEyw+bovy1J7PhBQ/4C1lpqcD1k5ZOc2x0fFRfgn2nAKiTSW3les7h7e2aWRn/IpK4Q2
         Nz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690136678; x=1690741478;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycyouuERwIeR4HaIm00BzGcE9hax3SSe2qob1J02fFM=;
        b=CwTNYiV5WqttG1EE8CZ7JG2HhDeN1iaE07cQa7VOtjSG8YTGHjjRGDlyaR+75MHux1
         FJRThUO/BpLbejs3s0BBVixDv/8iYbj8CllPNn2N4E4GizVRCZzhSiEgCIw9gNvZxX9b
         iOCJdJeGm95u4VofGJfEpBtybJRnDgVqgSDWxnUXBgmGEQ06dwjAvv6SwztKupnnlIU/
         YGsOKQwnY2gj1Abo1XsflRwP0mw7liQ4lJ+Kt7AiJViblL54QCVapssq2UgjnK6BMM3M
         IH0OwURp+XL8H7d6J46LW9f1GIcIft0Aotn9aDTajTl3v5kngkui3/uuS/r4ySTdT2im
         NJpg==
X-Gm-Message-State: ABy/qLZBgdK5K7KkFNFSaY3OcglH1igSVnwxd1xis/4EV0fKLVJQfMZN
        Ry5Gyp2LMZi7Gq1zByjrJrHmzWpCyzsT1LdZiDs=
X-Google-Smtp-Source: APBJJlFys40zxyNiYN9ma5c4aELn9kCabnLJ8LDv7DICIj/f1/ECXB4vN3DCqWSjr1KsWJmEGIR33w==
X-Received: by 2002:a05:6a00:398c:b0:686:6166:3739 with SMTP id fi12-20020a056a00398c00b0068661663739mr7516110pfb.13.1690136678006;
        Sun, 23 Jul 2023 11:24:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b006815fbe3240sm6472296pfu.11.2023.07.23.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 11:24:36 -0700 (PDT)
Message-ID: <64bd7064.050a0220.99d02.b40a@mx.google.com>
Date:   Sun, 23 Jul 2023 11:24:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.288-192-g80628ee9a6264
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 2 builds: 0 failed, 2 passed,
 3 warnings (v4.19.288-192-g80628ee9a6264)
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

stable-rc/linux-4.19.y build: 2 builds: 0 failed, 2 passed, 3 warnings (v4.=
19.288-192-g80628ee9a6264)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.288-192-g80628ee9a6264/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.288-192-g80628ee9a6264
Git Commit: 80628ee9a62647977364404e68af1133c7089be1
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 2 unique architectures

Warnings Detected:

arm:
    multi_v7_defconfig (gcc-10): 1 warning

x86_64:
    tinyconfig (gcc-10): 2 warnings


Warnings summary:

    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    1    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
