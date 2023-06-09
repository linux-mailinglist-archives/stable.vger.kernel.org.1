Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CC72A10E
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjFIRPU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFIRPS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 13:15:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5D3AA5
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 10:15:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso883848a91.1
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686330914; x=1688922914;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JZNM57Rre3814Q7ETj4nqUvwrVsq8MRNCA+Swh+fkUk=;
        b=eSQb1tUoJOf8MPGezqewf0nRc2UjoVy0Fycd1C7K4K7ppUPGfxhtAIIPQGdgNvMavi
         +4MlBdWX7TCc0NqgCcUagnUhlJZFe9WeLiLaHN9nuVtySwW7EAePsOWs6vZC+B0KcPB4
         RzLJI4oCNSGqUj3LD8fewKw5XMJeTcgMc6svSd+H/ZjGA6JvXWFF5EYNlwjlLml1zWnO
         xh5nFAGuW6LmzBpZYQD/hCWgzZT1zBQ5RKg/qiginMxKPpqgqvwcnjx5/vec1a5FEOEB
         /bVVwvAX+ACNlGW64Xuc5kzdZgjlt1Np3BswPb4UzhgtDtRWRI8FNGJvl7NEUr6CCsuQ
         fa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330914; x=1688922914;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZNM57Rre3814Q7ETj4nqUvwrVsq8MRNCA+Swh+fkUk=;
        b=ZZfkn5cJ1dspwiD/XcrkHV9VR3w2X8oN5GdlMIfN3jEEBKNNuOIu0JZro9b7oaf9mB
         L8jKV0WoiQbeoUhc8JJOkjqR36qI5JejIPwGu6FyD41vnzbLgUlUkCn0jDA+avFvHv7U
         nCGp7Rnm71+Hr+u+/ED7Fx6g56s5Y6PievI00rrOnqrw9j/IMyTUMHcx6jvzvhhlfkOt
         JiBnXcL9Wx//S9QHV0O3LPsFwVAF9ugfmOgmC07JaHQqSxGFeXcFn/4miIerPv/DcIPr
         GifkKtMzVtGm4dal+2JcsyuSHhLgSDDjhLGcJvYiT7Z8Nr+KB8JgMQRFirME8YliL6R4
         gJ3w==
X-Gm-Message-State: AC+VfDzkGpSN84rvWMqKsdHxyP0gPI86R7hhjRP5w8YQ3Q/coppig0kH
        q4nDs3qmpJlM8IQYRDduiGPGRHrmKf8JkbyBa7NIaw==
X-Google-Smtp-Source: ACHHUZ4uev+1z/wbFRuAx9gBdVdkSutyxhFyFcRZXV+zRKzKaealeS6d5VBBGhCVy/rx0MpgKVM0TQ==
X-Received: by 2002:a17:90a:8d14:b0:255:96e4:2edd with SMTP id c20-20020a17090a8d1400b0025596e42eddmr1929565pjo.9.1686330913959;
        Fri, 09 Jun 2023 10:15:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id rm4-20020a17090b3ec400b0024749e7321bsm3177827pjb.6.2023.06.09.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:15:13 -0700 (PDT)
Message-ID: <64835e21.170a0220.ce876.70e1@mx.google.com>
Date:   Fri, 09 Jun 2023 10:15:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.7
Subject: stable-rc/linux-6.3.y baseline: 170 runs, 2 regressions (v6.3.7)
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

stable-rc/linux-6.3.y baseline: 170 runs, 2 regressions (v6.3.7)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.7/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e282393f9d0cd66cee8c68a80f4936f46c449b2d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64832ce2fd118a7a3e30614d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7/a=
rm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7/a=
rm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64832ce2fd118a7a3e306=
14e
        failing since 0 day (last pass: v6.3.5-46-gb8c049753f7c, first fail=
: v6.3.5-332-g6f9b6a83bd08) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64832719deb3ca261930612e

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.7/a=
rm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui-=
jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
4832719deb3ca2619306147
        failing since 7 days (last pass: v6.3.5, first fail: v6.3.5-46-gb8c=
049753f7c)

    2023-06-09T13:20:18.192558  /lava-10658951/1/../bin/lava-test-case

    2023-06-09T13:20:18.203664  <8>[   28.543810] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
