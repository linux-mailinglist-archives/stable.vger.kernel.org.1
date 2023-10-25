Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF967D75F0
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjJYUoL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYUoL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 16:44:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E60A181
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 13:43:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b8ece0f440so169060a12.1
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698266623; x=1698871423; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BDv9nTMH77xslILNDKIE/LYp6wTEl8e8wbfyO6sqSYw=;
        b=zkJwavF0S1fFWsBq5vnXIBNwoC98yA0GRZAz5OTqdDOd6QPgcOYTFmEY5Udts45k+s
         1luAYm/Ua5P1MXQrXyhBGoP0zn96W0S/HPnkr5SJl/l9kz8h9aAdYgn8tf6HJmOkndXm
         aMPHaulPntKHdZJg71vAZmSCfafjktUQFX1aSzf2fUyli6SXavOIVgEOhkuwRQ8K+KXP
         NQrXQv2cmrG562rnLahCkqeexr5eQ088Cq1Bdv9YiCznyd8eidzVlmPLL9gOQ0T39QJt
         FWi2HH1HHkso2dKEt1GkbXALE8ukjaxyYuauNq+bhXwCHlqFGBJKl/ix2RpwE+i+KMQT
         aRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698266623; x=1698871423;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDv9nTMH77xslILNDKIE/LYp6wTEl8e8wbfyO6sqSYw=;
        b=ScqBVlSIyFcw73yJl5gRz0ifQq/WeMVLkn7E3tP86pF737T8FOlm18pqrwbCNlxzZP
         mpAZJBMcz43Et6c0ZZd2XQXRWKMxvIlAA4JdPCPyX9OycSjMej1o5xIhpakRr0kRODBD
         cq4IpS4kdAd60KdS40l0sgc553QRRj0doi1kGW9HOIir7ipHUQcepfPeIWwrk05IozHj
         V2qOdUODu/y2DH4qr91+tfiDC/THuFTIsEypqTWXw2u8nloF28RRZ1VZs4F3WAToBPds
         hgB1pvduZxoACuhegVMb99fPW6kIvHqfRiS/rdlG/utsip5b2+HHurzhzhx3sqg9ZS88
         kU4w==
X-Gm-Message-State: AOJu0YzzjUNoVi+HoS8sdzRXxgcWp4VD1/iR7nnXpRNbpnYmRZlA1UL5
        9MV0RM3LJmK7NHlJjYLL5f5OT1L2+3JRGp3eSCE=
X-Google-Smtp-Source: AGHT+IEi2zZ7D+ua3tLXGpBI47LUGM/o07wVLDIiNb9cFSQ5i6J3usgpA/ZZupI9CIDOmg0u1h9A9g==
X-Received: by 2002:a17:90b:1490:b0:27c:edd5:6137 with SMTP id js16-20020a17090b149000b0027cedd56137mr13937997pjb.25.1698266623369;
        Wed, 25 Oct 2023 13:43:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id mt5-20020a17090b230500b00274bbfc34c8sm309627pjb.16.2023.10.25.13.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:43:42 -0700 (PDT)
Message-ID: <65397dfe.170a0220.2065c.1fb7@mx.google.com>
Date:   Wed, 25 Oct 2023 13:43:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.4.259
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Tree: stable
Subject: stable/linux-5.4.y baseline: 153 runs, 2 regressions (v5.4.259)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-5.4.y baseline: 153 runs, 2 regressions (v5.4.259)

Regressions Summary
-------------------

platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | 1        =
  =

panda    | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/stable/branch/linux-5.4.y/kernel/=
v5.4.259/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-5.4.y
  Describe: v5.4.259
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      86ea40e6ad22d9d7daa54b9e8167ad1e4a8a48ee =



Test Regressions
---------------- =



platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig  | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/65394d49c8ac80869cefcf15

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.259/ar=
m/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.259/ar=
m/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65394d49c8ac80869cefcf1e
        new failure (last pass: v5.4.218)

    2023-10-25T17:15:26.648063  + <8>[   21.045318] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 3814384_1.5.2.4.1>
    2023-10-25T17:15:26.648278  set +x
    2023-10-25T17:15:26.752570  / # #
    2023-10-25T17:15:26.853605  export SHELL=3D/bin/sh
    2023-10-25T17:15:26.853922  #
    2023-10-25T17:15:26.954642  / # export SHELL=3D/bin/sh. /lava-3814384/e=
nvironment
    2023-10-25T17:15:26.954955  =

    2023-10-25T17:15:27.055692  / # . /lava-3814384/environment/lava-381438=
4/bin/lava-test-runner /lava-3814384/1
    2023-10-25T17:15:27.056224  =

    2023-10-25T17:15:27.061227  / # /lava-3814384/bin/lava-test-runner /lav=
a-3814384/1 =

    ... (12 line(s) more)  =

 =



platform | arch | lab          | compiler | defconfig           | regressio=
ns
---------+------+--------------+----------+---------------------+----------=
--
panda    | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/65394a8d7cd2f603b3efcf17

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-5.4.y/v5.4.259/ar=
m/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable/linux-5.4.y/v5.4.259/ar=
m/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65394a8d7cd2f603b3efcf20
        new failure (last pass: v5.4.218)

    2023-10-25T17:03:54.091350  <8>[   20.709594] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3814301_1.5.2.4.1>
    2023-10-25T17:03:54.102886  <6>[   20.713592] smsc95xx 3-1.1:1.0 eth0: =
register 'smsc95xx' at usb-4a064c00.ehci-1.1, smsc95xx USB 2.0 Ethernet, 02=
:03:01:8c:13:b0
    2023-10-25T17:03:54.108407  <6>[   20.728118] usbcore: registered new i=
nterface driver smsc95xx
    2023-10-25T17:03:54.217627  <3>[   20.735504] omap-abe-twl6040 sound: A=
S#
    2023-10-25T17:03:54.218477  oC: failed to init link DMIC: -517
    2023-10-25T17:03:54.218785  / # <3>[   20.743469] omap-abe-twl6040 soun=
d: devm_snd_soc_register_card() failed: -517
    2023-10-25T17:03:54.320107  #export SHELL=3D/bin/sh
    2023-10-25T17:03:54.320526  =

    2023-10-25T17:03:54.320764  / # <6>[   20.881469] [drm] Cannot find any=
 crtc or sizes
    2023-10-25T17:03:54.421686  export SHELL=3D/bin/sh. /lava-3814301/envir=
onment =

    ... (17 line(s) more)  =

 =20
