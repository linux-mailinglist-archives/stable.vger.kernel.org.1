Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032A270727F
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEQTob (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEQTo0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 15:44:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E744A3
        for <stable@vger.kernel.org>; Wed, 17 May 2023 12:44:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae58e4b295so6151885ad.2
        for <stable@vger.kernel.org>; Wed, 17 May 2023 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684352658; x=1686944658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=quu0IMUuNGOzV5e9SK/jmuvfseDzsVs0rfMgsSrn7i0=;
        b=NcdRi6Ua/K7bKfsvB2Gi/ql6s15f29CDOInR581+BVN2LVVwD1v3fQZNuTIxVC0gXy
         Z9iQPGIUG11aAEvpXz/jjKIMWIb/4GXQFXOwm5XigfaiBhIH9EvxHtgvrrX2sootv18M
         FGaOtRgsfWmT19tQE6EcoIflqhJXObfPtzsPM1SGqHZBb8NfNLFMQub6V3xy+64fG1Ej
         sTAgxfOkZud3k9UPa5CwBYuyFc4lcOQJ1LZ3f8VVN7Iluw0pL3MX0cJ5IUL2zhjJmqt9
         42c0zxUNo3F5WBzT4oygOZ6Te6hOkFhyktOyUjm/cHKLCBrfXzMOagqz+gHyHnPaR16L
         Jf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352658; x=1686944658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quu0IMUuNGOzV5e9SK/jmuvfseDzsVs0rfMgsSrn7i0=;
        b=SbnTOfh+6+WI7mPH0G9YSYaM5haeBE3UN7ljcU1W9bht4EQzVqXaOJFEJ2o3GiCo/e
         siQbFKuuhjSf+yD6Uf6XwZI1JV1dNHivO2R+hiF1dDGGGetTgC8Xc2HmaJXA9szrLqLV
         Sh9UDTWws/56NNB5AEz8UGPBO7lKHjSCcWwD+mU0yGVGcEvf+epDvOum143gP8C9Ym0V
         sIKLfXKnGTe62Dn1v4jx+Dx4DcYi3kjqj2B6OceO0j9zcNUf12pUW0mKS+ue0Svaj4fP
         cNTsRwYa3PsOUBJbv/xytpJTxq4OHgmL8AYQxzCu4kg+Oax1XlzCaz/b9rXXMl5jzl/C
         Inbg==
X-Gm-Message-State: AC+VfDxUPOh507excgZxMiU1+MWpN1ShO6pvly9RGvHMuVGcQjOL+bCT
        K4JN1WINPkMu50hOEBto/ksgYyzD9YSbaiYtNbgfHQ==
X-Google-Smtp-Source: ACHHUZ4SM8PO+PShVh7fmVX3hCrttoIwifhAOeKALz7CdeBZ0VKALWoFcyUGDSCAlv3Lo4JauWjdFQ==
X-Received: by 2002:a17:903:41ca:b0:1ac:3fe0:d6ad with SMTP id u10-20020a17090341ca00b001ac3fe0d6admr50908385ple.65.1684352658136;
        Wed, 17 May 2023 12:44:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001ab016e7916sm8614671plh.234.2023.05.17.12.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:44:17 -0700 (PDT)
Message-ID: <64652e91.170a0220.a9b46.0b75@mx.google.com>
Date:   Wed, 17 May 2023 12:44:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.180
X-Kernelci-Report-Type: test
Subject: stable-rc/linux-5.10.y baseline: 161 runs, 2 regressions (v5.10.180)
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

stable-rc/linux-5.10.y baseline: 161 runs, 2 regressions (v5.10.180)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.180/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.180
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4c893ff55907c61456bcb917781c0dd687a1e123 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464fac09fcf27863c2e85fb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464fac09fcf27863c2e8600
        failing since 49 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-17T16:02:58.081826  + set +x

    2023-05-17T16:02:58.088203  <8>[   11.150917] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10357946_1.4.2.3.1>

    2023-05-17T16:02:58.193067  / # #

    2023-05-17T16:02:58.293871  export SHELL=3D/bin/sh

    2023-05-17T16:02:58.294123  #

    2023-05-17T16:02:58.394738  / # export SHELL=3D/bin/sh. /lava-10357946/=
environment

    2023-05-17T16:02:58.394987  =


    2023-05-17T16:02:58.495585  / # . /lava-10357946/environment/lava-10357=
946/bin/lava-test-runner /lava-10357946/1

    2023-05-17T16:02:58.495934  =


    2023-05-17T16:02:58.500890  / # /lava-10357946/bin/lava-test-runner /la=
va-10357946/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6464fa5c50ad3393442e860c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
80/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline-hp-=
x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6464fa5c50ad3393442e8611
        failing since 49 days (last pass: v5.10.176, first fail: v5.10.176-=
105-g18265b240021)

    2023-05-17T16:01:20.729872  + set +x<8>[   13.631892] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10357886_1.4.2.3.1>

    2023-05-17T16:01:20.729956  =


    2023-05-17T16:01:20.831536  #

    2023-05-17T16:01:20.831751  =


    2023-05-17T16:01:20.932344  / # #export SHELL=3D/bin/sh

    2023-05-17T16:01:20.932540  =


    2023-05-17T16:01:21.033070  / # export SHELL=3D/bin/sh. /lava-10357886/=
environment

    2023-05-17T16:01:21.033293  =


    2023-05-17T16:01:21.133939  / # . /lava-10357886/environment/lava-10357=
886/bin/lava-test-runner /lava-10357886/1

    2023-05-17T16:01:21.134240  =

 =

    ... (13 line(s) more)  =

 =20
