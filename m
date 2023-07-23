Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714A475E3E8
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGWQpV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWQpS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 12:45:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4309EA
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 09:45:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-267ffa7e441so646132a91.1
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690130717; x=1690735517;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gCrJ08qcPjsFh9FI3+YtwllSUMCh05sBNN6+wyG9DK4=;
        b=PVtUeVAQzviiKRrvSuOQU6ka5slJRCvUpX9TMYRD+vMKeSihncMqbzE89IvjuZIQDi
         40p9kLkMkrOoK+FRQCsidFzmUTy+deV7HZOkRSFRQaqmZpgjQCZjTmPn98njvY94f98O
         Luale8MdzwC2FQnps9buKa/dQAhn4D0J1VCjqKdo5IgpTPos614+jDESsZqVN2Sml03H
         wTZgonrJ7myNJ/VSz02yNHLCVT+jEsz0Iw45HYjbMmJtJULK6vOHB6/tdYUld4Dha2eT
         FHe5hyyN58/5N+z92lv4HMDI032n/BJYqhQ2QONt8KUR2FfuJPlf2hbVxKCkPcvsb7Ta
         wJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690130717; x=1690735517;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCrJ08qcPjsFh9FI3+YtwllSUMCh05sBNN6+wyG9DK4=;
        b=G5zb3uZiBP2PKxrf7tZ7ddNv9sn0Wnbx3r494HFjEEQjP0iDg5xFyG7oTq9MjcQNlW
         NFHhmdpvdaTpkHVpfjDX1qYQRcj+5KanTJts3SRGLY2R1EasOEEXgfmUbVycvdVFbbwp
         Ze0Mc5nMUNCa2k1czRtdwrWKmnABl9upKH906uSnru9BvrlKt4hILnQtUQvPHwFllGf0
         5rP4qZKPrlvROvT6COZjb4RLLazCQWH9zMO1Dvp9+DprYOgK6EkM2j53sxc80B6NMQtm
         c1s9vFVGzWUkChpQzFQc1TXxOedXBm78m3RZ/pzwdLh6jQN5/DmrrzmaO8x2ZSxAWXBx
         GSYA==
X-Gm-Message-State: ABy/qLbAzhROb1JAPT9jmkKEI8Rf8QMRIuQlHVbMmD/MGUQeOKRZuUfi
        sXWOxGzWa3Awv2CPd9vHoEZgCC73mTd3pWxZE24=
X-Google-Smtp-Source: APBJJlFfwPfsZmsh6bq5UfbuEff6SaAUu6+QN+TyDx2k9JHMptHdU+jXzxbTh83HQqw8jMihweXKDA==
X-Received: by 2002:a17:90a:e213:b0:261:685:95b6 with SMTP id a19-20020a17090ae21300b00261068595b6mr7927126pjz.13.1690130716785;
        Sun, 23 Jul 2023 09:45:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090aa38100b00263f5ac814esm6743709pjp.38.2023.07.23.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:45:15 -0700 (PDT)
Message-ID: <64bd591b.170a0220.c0546.c10b@mx.google.com>
Date:   Sun, 23 Jul 2023 09:45:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Kernel: v5.15.121
X-Kernelci-Report-Type: build
Subject: stable/linux-5.15.y build: 9 builds: 0 failed, 9 passed (v5.15.121)
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

stable/linux-5.15.y build: 9 builds: 0 failed, 9 passed (v5.15.121)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.15.y/k=
ernel/v5.15.121/

Tree: stable
Branch: linux-5.15.y
Git Describe: v5.15.121
Git Commit: cdd3cdb682f4939aa1adeff025b97e75a9a0f5b3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
Built: 1 unique architecture

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
colibri_pxa270_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings=
, 0 section mismatches

---------------------------------------------------------------------------=
-----
h3600_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
h5000_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
milbeaut_m10v_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings,=
 0 section mismatches

---------------------------------------------------------------------------=
-----
mini2440_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
mps2_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
simpad_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
zeus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---
For more info write to <info@kernelci.org>
