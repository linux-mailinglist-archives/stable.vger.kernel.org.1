Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24482728B99
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 01:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjFHXLT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjFHXLS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 19:11:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F7230C2
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 16:11:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-652699e72f7so984732b3a.3
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686265864; x=1688857864;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sTP0JVpf1f5b+2Xjzlr5QOXRp8Axu0c3Qz6jDYB0dp8=;
        b=a7lNeERUflhnUaD6laddV48Egfddjc0OsKgTbfkXlhaqopETQVyxs4gtCrHINMiCIC
         WRDN05z9I+8g8LREUxqcxaPtJO8OscYhl47S5XM9FSIPjQdx82E5lnzEdxVqNoyGqNKC
         O6FhueXyNt5sn1CLM1gDXZ4Yc+9r/fv2OWMnsHvO4+UkXuJA7Qm7nz4q6Ms/cRCWC1jp
         kdap3qu64Mij9Ed4MeM1UGAywcIFhXjmnKu2CfLSkocZ1wYkwk/ZHL+0jdMmClOpKBId
         qkmrBQ3LTwDV3uaV1Q7tjtWnhI0cy6j+ec/LQDsrjfSwDqmkUVwbSQaW8MnjP1pzvqua
         ++Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265864; x=1688857864;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTP0JVpf1f5b+2Xjzlr5QOXRp8Axu0c3Qz6jDYB0dp8=;
        b=lCGIO66evivNr5cglQiG+TRXHgTRvwSC6kLg4gtK3O8AwMUkqECXY3DXLwCPGKDQeK
         ZVuMefEfBKMH53BdQME9g4nZpHLqZPOEfWSbI7gIzqLdvekxHi8A3U+nIwww+lnDok72
         GT5KamTUJ2WTcqn5AUNPATecJ/PLBnIYXtaXp31+ygdZiSHGmgHDCdDIrTNOivCVoyfC
         Dud1af35miefdVxm4dXb70smN91gk4o8+6ZRoiyJ6z+15fm7Qa6XiggEB+81gwambX0P
         VZ+7h80b4tBbmgXTI6U/VCTcxjXAR0b6CLWDMuF+FmTBLQDOMOfc5N4zgYSE5T3AI9k9
         bz4g==
X-Gm-Message-State: AC+VfDzjdi2Nv8tuXGOLYYfKnGVQ9Qs2/BCTz5kmQvcPktC0yhnahqHb
        CC6msIfjveQpDfDsFsjhp8LNGxqt+dHJrBjCwcLF9Q==
X-Google-Smtp-Source: ACHHUZ7V1zyqIcxU0BlvY/A+ADbSASDs06wCGjMcRe1+37+NKwhlpyW7mUMgRVAOW0uh6NO/YyQL4w==
X-Received: by 2002:a05:6a20:431f:b0:10f:f672:6e88 with SMTP id h31-20020a056a20431f00b0010ff6726e88mr4987736pzk.4.1686265864299;
        Thu, 08 Jun 2023 16:11:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b005a8de0f4c64sm1551549pfo.82.2023.06.08.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:11:03 -0700 (PDT)
Message-ID: <64826007.a70a0220.8e070.392c@mx.google.com>
Date:   Thu, 08 Jun 2023 16:11:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.5-332-g6f9b6a83bd08
Subject: stable-rc/linux-6.3.y baseline: 175 runs,
 3 regressions (v6.3.5-332-g6f9b6a83bd08)
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

stable-rc/linux-6.3.y baseline: 175 runs, 3 regressions (v6.3.5-332-g6f9b6a=
83bd08)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91-sama5d4_xplained        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.5-332-g6f9b6a83bd08/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.5-332-g6f9b6a83bd08
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      6f9b6a83bd08fb6abac41d5a521adec785ea0e68 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
at91-sama5d4_xplained        | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/64822b2201938bde35306163

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-3=
32-g6f9b6a83bd08/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-s=
ama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-3=
32-g6f9b6a83bd08/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-s=
ama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64822b2201938bde35306=
164
        new failure (last pass: v6.3.5-46-gb8c049753f7c) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
beagle-xm                    | arm   | lab-baylibre  | gcc-10   | omap2plus=
_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/64822f7b790380318f30616c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-3=
32-g6f9b6a83bd08/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-3=
32-g6f9b6a83bd08/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64822f7b790380318f306=
16d
        new failure (last pass: v6.3.5-46-gb8c049753f7c) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64822ba155e922f3ba30623b

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-3=
32-g6f9b6a83bd08/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.5-3=
32-g6f9b6a83bd08/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
4822ba155e922f3ba30623f
        failing since 6 days (last pass: v6.3.5, first fail: v6.3.5-46-gb8c=
049753f7c)

    2023-06-08T19:27:19.743399  <8>[   27.465002] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-driver-present RESULT=3Dpass>

    2023-06-08T19:27:20.761095  /lava-10645957/1/../bin/lava-test-case

    2023-06-08T19:27:20.771425  <8>[   28.494995] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =20
