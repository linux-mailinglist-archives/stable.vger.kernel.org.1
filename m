Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F873F303
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 05:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjF0DwA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 23:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjF0Dv4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 23:51:56 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC12F10C9
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 20:51:46 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b5d7e60015so3697009a34.0
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 20:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687837906; x=1690429906;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G+xScA7JLYGoiJlaswVC+aZukmA0ORd3515lISFOtCg=;
        b=ibYGSUUwVz/OO1U3JG0qAKsRBPC9pHEKT1B8HW45eMqAd5ybY2LjNGBFO/mVk7W9LX
         vvj5DgWv54Ussi1CESyyN9L4bk7faMgJvbp2/AU8yw2PClQb2WlpYdIbjLU/g+ImsRS4
         VhyfKvMZCHmhTQOHXKEImX/aX6Jmj26y/wM2DMSWm+BnMa81ZlZjcT6lCuHWAwizPyTw
         qdyIHdTY2G6r/fZVPuiTeUrg9ClxlOT4aMfMsOuqgI5msNAT9x1UWSLufHt4+6IKHPjN
         kfqgSv83K1xZjGQ5zxaPHX9Q+E4nA1e5BU5b7aghtsNbkHUf5Lky9MVlXtxHdaYCCwN+
         /VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687837906; x=1690429906;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+xScA7JLYGoiJlaswVC+aZukmA0ORd3515lISFOtCg=;
        b=U/VHeVdc+sDvi27Zi+LFTpW3VXaCT+zFdVv8XgPP7cDlswvgAkiLdjU8Z0y06alEqC
         in8mAzr8yyvFGNsAHfXT5e2TGgdAHnlWaQ6hUY6ukNTDLUY6C1rQV5tSfx6smMJgNJU+
         QHpMxJaxm4SCbxgNcu2TWjfyQsdm3ZUiPEvSnHvRa3N1v+IW3S0POI98ethL36gHcPnZ
         sRyhdbS1s4ftJ5VSGJlCtkw97/ylOGMFMb8d+jCa4T4hWPITYXE9PRWBsl4SYML5qEIn
         MznQy57cl1qNUtrxZE/Nmywg5vONP5PFiP5StEyisvvDXVqAZiqKo9ZQuzOEAGiRfWXs
         OI6Q==
X-Gm-Message-State: AC+VfDyl40KNHwVplrME6sTdak0L1rpM9qoye6l+DGCJxYSIl3TcGutj
        FbPKLx5vpQ2CvkhN8JTXOgM/Ocone6eKcUwtjPuwkQ==
X-Google-Smtp-Source: ACHHUZ7OetXcfwhWwwJZUwxNoH2kKIRoq2JwzDcyLZmHuzujWB3ZhOYeSiLxu7YOp/WTgKIsmTFasQ==
X-Received: by 2002:a05:6358:5b:b0:132:71e6:1f37 with SMTP id 27-20020a056358005b00b0013271e61f37mr13205232rwx.16.1687837905758;
        Mon, 26 Jun 2023 20:51:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t20-20020a656094000000b0054fd1723554sm4245016pgu.21.2023.06.26.20.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:51:45 -0700 (PDT)
Message-ID: <649a5cd1.650a0220.312ce.78c9@mx.google.com>
Date:   Mon, 26 Jun 2023 20:51:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1.35-171-g8c805fb9757e
Subject: stable-rc/linux-6.1.y build: 6 builds: 0 failed, 6 passed,
 1 error (v6.1.35-171-g8c805fb9757e)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.1.y build: 6 builds: 0 failed, 6 passed, 1 error (v6.1.35=
-171-g8c805fb9757e)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.35-171-g8c805fb9757e/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.35-171-g8c805fb9757e
Git Commit: 8c805fb9757e69c239188ee683605520ff73b913
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 3 unique architectures

Errors Detected:

arc:

arm:

mips:
    lemote2f_defconfig (gcc-10): 1 error

Errors summary:

    1    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=
=80=98-mhard-float=E2=80=99


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
ci20_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
lemote2f_defconfig (mips, gcc-10) =E2=80=94 PASS, 1 error, 0 warnings, 0 se=
ction mismatches

Errors:
    cc1: error: =E2=80=98-mloongson-mmi=E2=80=99 must be used with =E2=80=
=98-mhard-float=E2=80=99

---------------------------------------------------------------------------=
-----
neponset_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
nsimosci_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warning=
s, 0 section mismatches

---------------------------------------------------------------------------=
-----
pxa168_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
realview_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
