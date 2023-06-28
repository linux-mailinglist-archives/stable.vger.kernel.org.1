Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93CF74162E
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjF1QT7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjF1QT6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 12:19:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2B10FD
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 09:19:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666edfc50deso61889b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 09:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687969196; x=1690561196;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fw5aTO1d9ggGqDYBxoeFXQWYj0GAegn2HiHH8abPXKI=;
        b=WHpnTDYNevMXVJt+XALh05ku2BIj5pi3JvjYk7mwTeDZMn0P25iG9L6xR9BYOHNZM4
         8CuFzL4mchHaiMd2/DwLL6Ui9k8JJR3Y8KUJ/Xi8OoIYpCJVgyttTG7yHltiNhg0nXb/
         Oa1kwAFPicxDTTVTl2FIXkN3STQd1tlH/+/c6QElZyFBB9lXlBD7Nlf+ZXRwqP2Vdv5c
         Zzy01DfjiUEu1iiU9pqqQ1VbMqX5GDecF9bVZ9SsXT7sgWHsWW9ciOhlRNaAdmJ7tiLe
         4iu65OOmOOfpR++d/TWd6DoUKVbGThE+8S7EYojo7lORWZYDSzZpeqryQTVePpjGaiCJ
         vBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969196; x=1690561196;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw5aTO1d9ggGqDYBxoeFXQWYj0GAegn2HiHH8abPXKI=;
        b=jVZNQKQ6EipeRfO4tAB0FXbnsnTg7SA1Qyr8qc3XXFbnHOFNI8Vfa8LSUCLHj1Uf/T
         Rw51CkwoWiYxq7w19GQgmd34z/oIctPbRacWrP408S96Ho4bTa8JAtYUYKlUZUwVGGtz
         01tV+7LDNrt8Z6du9gOz4AyeJoGtwASBjMUfYXdhVWh/XJmmXsnjtu1ELRxmSwbNxJdz
         coYMNpE7xqUl0kumxiYAiPoLuNa5PGZogt4OnyYG6m3TMrE/Sh3Hdo8gliBNKxQNbb9O
         5X+YCIQHWf0srpM1kBU5N7mITIzE2rnDmS+DHM0tFrYUmVbFctdqNmm8jB8IbdWxTTiR
         uw0A==
X-Gm-Message-State: AC+VfDzrpj2pzkaCE2bKR0ovuKLN5rlBQAcc68Wfp7PsxNNcqj6TlhL9
        9856SPbIr4ZyJX5RGd8Wr7R9DnuJJzQMqd74zV1v7w==
X-Google-Smtp-Source: ACHHUZ6VAy4anS9OA+hLSOtnUi+6BXM6dV9BWqPfPWIc9DyJ1e17gfa+rFr3SHzvB65z/CtaZsvgKg==
X-Received: by 2002:a05:6a00:3986:b0:67f:d5e7:4604 with SMTP id fi6-20020a056a00398600b0067fd5e74604mr2240345pfb.13.1687969196568;
        Wed, 28 Jun 2023 09:19:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f9-20020aa782c9000000b00634b91326a9sm7467651pfn.143.2023.06.28.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:19:55 -0700 (PDT)
Message-ID: <649c5dab.a70a0220.635c1.de9d@mx.google.com>
Date:   Wed, 28 Jun 2023 09:19:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Kernel: v6.3.10
Subject: stable-rc/linux-6.3.y baseline: 120 runs, 2 regressions (v6.3.10)
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

stable-rc/linux-6.3.y baseline: 120 runs, 2 regressions (v6.3.10)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

qemu_mips-malta              | mips  | lab-collabora | gcc-10   | malta_def=
config            | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.10/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      28ae0a748c161ed01e2f43018beb978c74e12a0d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/649c292ccfdae93c8fd7d66b

  Results:     164 PASS, 8 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-mt8183-kukui=
-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mtk-thermal-probed: https://kernelci.org/test/case/id/6=
49c292ccfdae93c8fd7d673
        failing since 9 days (last pass: v6.3.8-183-g3a50d9e7217ca, first f=
ail: v6.3.8-187-g6b902997c5c2b)

    2023-06-28T12:35:39.064094  /lava-10937367/1/../bin/lava-test-case

    2023-06-28T12:35:39.074990  <8>[   28.616515] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmtk-thermal-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
qemu_mips-malta              | mips  | lab-collabora | gcc-10   | malta_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/649c24a2d1c96b2749d7d60d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.10/=
mips/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/649c24a2d1c96b2749d7d=
60e
        new failure (last pass: v6.3.9) =

 =20
