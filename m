Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B074675D438
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjGUTTR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGUTTI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:19:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C37E3AAA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:18:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3df1ee4a3so1391502b6e.3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689967136; x=1690571936;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YnaW2N2yVrnTEe6hUMIRb9wxbXeaqtFKVL+sKMepVVU=;
        b=Tg5u0BLZTshmn4SR/nZtP5n5w83+nI6Yyjr3TQuPvzHPbQq1xd68LemVPkUHseQhKN
         ytgjguXlibhhOsRkRi4t4GO8TAFZfjJ9Hez4QKeVjn8ETMBV3VmQp//vLMLsf61byRJ6
         suiC3ZCUrd96BAt6yBNhkJd0Rfd/CD9MKwxdUmzlK5q4y78AFXV65WNry6/WXlRQrRYi
         m/kt9oFMvh2X3dz2k9uw/fzYAs3X6uSNikWsDHcNJFMkQgbu6MPX0AjPT5Ip7ELVTK4Q
         aQXQUGxvrCM/C/CmoTF3pUXlMjmy4UuAYjW8Qe8JQ2iHf+UMcXX+RXufIBbR9YqaJ8ZV
         pE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967136; x=1690571936;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnaW2N2yVrnTEe6hUMIRb9wxbXeaqtFKVL+sKMepVVU=;
        b=VlgEQAV5lJPILOZhYs4q98o0eEcGqNJCHUiqrxwOuz3NrdiEa1i21XEB7oY3YgGjU1
         sZizj6xjA+D+w4v24Zbe9dD3iqVsvzdTElDTTJL3yB7TFq6frfQYHHhG3G/DeLmBdKkI
         tFXV7UyD1M9+JLHj/GdENECSShWnUdaHgtMF0TbXmOJY22nwosyoEQvIjmeTX9GgYLBh
         rG0K8o1XMDucxtgoxsAimm6Tfd/xuaQgRsP3K1zH5SAV3yEhVmU+gUQdk0MAOnMHYb1d
         zQBvi8SP/f6Cuu4r51ercmuS8rlqgr8eL6IFVQt4KJ1O4m94LPAVS96zTJNC2J3vzFEo
         yBbg==
X-Gm-Message-State: ABy/qLbIwjnHXERJlsnwp5wNNjUdU0q+K9+hzmiOa4AYNpfgx74IMz/i
        /RzOWZ6yHU+CUjmv0wu9iwdUcCv0c6uF9k27lns=
X-Google-Smtp-Source: APBJJlHIvSqqL647O54LebWnK2blKLQixgwhMESDVaxTHWTzp3hcYJI7oN9nGmKbuu4NYZVzZJBgBQ==
X-Received: by 2002:a05:6358:723:b0:139:55de:329 with SMTP id e35-20020a056358072300b0013955de0329mr711614rwj.27.1689967135954;
        Fri, 21 Jul 2023 12:18:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x27-20020a656abb000000b0054f9936accesm3179345pgu.55.2023.07.21.12.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:18:55 -0700 (PDT)
Message-ID: <64bada1f.650a0220.4dfc3.5f2c@mx.google.com>
Date:   Fri, 21 Jul 2023 12:18:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Kernel: v5.10.186-441-g2f0e20469d5f
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.10.y build: 2 builds: 0 failed, 2 passed,
 1 warning (v5.10.186-441-g2f0e20469d5f)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.10.y build: 2 builds: 0 failed, 2 passed, 1 warning (v5.1=
0.186-441-g2f0e20469d5f)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.10.=
y/kernel/v5.10.186-441-g2f0e20469d5f/

Tree: stable-rc
Branch: linux-5.10.y
Git Describe: v5.10.186-441-g2f0e20469d5f
Git Commit: 2f0e20469d5f1c35ef084c4c84db0fd7bbfb0d2d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 2 unique architectures

Warnings Detected:

arc:

arm:
    vexpress_defconfig (gcc-10): 1 warning


Warnings summary:

    1    fs/ext4/ioctl.c:634:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    fs/ext4/ioctl.c:634:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---
For more info write to <info@kernelci.org>
