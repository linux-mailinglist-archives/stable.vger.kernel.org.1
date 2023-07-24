Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4475EF13
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjGXJ0W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGXJ0V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 05:26:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9AFF3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 02:26:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso31653685ad.2
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690190779; x=1690795579;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tBVC6jDW+p+cFneQJjBBNvCXU3CbDq4PSJIn9GT2ciY=;
        b=dFuzZEdwyoQLcMGtYCyyMdqcreVjDrZXME9PDojUsOc2m1JGMLoSQqW8kBmBU3oC9Y
         w6u/JBwIHU1NELEy+7OkPk80CUa/FIMLvclur9eqg206gxH5ZRo2apGECRr8IumRQRc9
         7fTo/axLlbYRHilqpzwFBYzgX7yy0FIFFZsEw05OIC7cFlMfqWlVTKygJxkToJoCcs8/
         X9TevB+nK8L2sAKIKqpvJXRUV6VV98YQKtz0q9XOjK0vExxwW+l0xjjbipqbwPKbwY3u
         LSPlqF/CWYI9Hcb9HGyYsxNY2tplHFx/3LlTgPBffARoyqySWoAsKfb1XJYYBOv2ZK3I
         TDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190779; x=1690795579;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBVC6jDW+p+cFneQJjBBNvCXU3CbDq4PSJIn9GT2ciY=;
        b=KQSECcEf7J52t0nIIO0ZOr5UxXXz3LH7BX+oEEqeWFl7AqVVeNHqUKobfQjDJ//eOJ
         CQ8xdNiHJiXMfRF7DAp0D0RYRCnZHuvFILyfxCjmRSXtVFiKaeHAJoUIaT6auyjVjOXX
         jUtKJahUhLQWIlhlohtRg+0bmA5/SZgfThz9zyS8ezM36NM+h3cl7p91fc6ZL5jHuFpX
         sf6MgMKeMF5MQETzV4CDni2iSbenQ1ius0OZaFUVoWciWGUcrH6zBPCO7CyO/eHHdTOb
         Supx5HJ4raG5mvSw8Eg7e+erdiRSNoSnqUgQsC5jFtol7tfi4g+lfrj9vuZjlXut0TyV
         1eoA==
X-Gm-Message-State: ABy/qLbPaniE1jQR7ezr44xqWiF1YBYVpIJtz2Bek5pujUWT6vQxDbpB
        ffu4G8IPITZjwde3hBo364jawB8oUUOCd8gae4GO7Q==
X-Google-Smtp-Source: APBJJlEeu0jwBhEe1HshUHsTQ044wY+gZZ+RZIqfAQbsUxcDHHySfmIVLCk0Tj8W3uRLJL0nBSP8lA==
X-Received: by 2002:a17:902:d505:b0:1b6:76ee:190b with SMTP id b5-20020a170902d50500b001b676ee190bmr11890976plg.35.1690190779708;
        Mon, 24 Jul 2023 02:26:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001b8013ed362sm8392463pld.96.2023.07.24.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:26:18 -0700 (PDT)
Message-ID: <64be43ba.170a0220.48779.e9b2@mx.google.com>
Date:   Mon, 24 Jul 2023 02:26:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.19.y
X-Kernelci-Kernel: v4.19.288-219-g690c38297b4b9
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-4.19.y build: 2 builds: 0 failed, 2 passed,
 6 warnings (v4.19.288-219-g690c38297b4b9)
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

stable-rc/linux-4.19.y build: 2 builds: 0 failed, 2 passed, 6 warnings (v4.=
19.288-219-g690c38297b4b9)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.19.=
y/kernel/v4.19.288-219-g690c38297b4b9/

Tree: stable-rc
Branch: linux-4.19.y
Git Describe: v4.19.288-219-g690c38297b4b9
Git Commit: 690c38297b4b9c17176226953c3c7ce9d4e938bb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 2 unique architectures

Warnings Detected:

mips:
    32r2el_defconfig (gcc-10): 1 warning

x86_64:
    x86_64_defconfig (gcc-10): 5 warnings


Warnings summary:

    2    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=
=99 from =E2=80=98struct super_block *=E2=80=99 makes integer from pointer =
without a cast [-Wint-conversion]
    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    1    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x6a: return with modified stack frame
    1    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.c=
onstprop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 s=
ection mismatches

Warnings:
    fs/ext4/ioctl.c:583:7: warning: assignment to =E2=80=98int=E2=80=99 fro=
m =E2=80=98struct super_block *=E2=80=99 makes integer from pointer without=
 a cast [-Wint-conversion]
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x6a: return with modified stack frame
    drivers/gpu/drm/drm_edid.o: warning: objtool: validate_displayid.constp=
rop.0()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
