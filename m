Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009EC7D7440
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYT3c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjJYT3b (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 15:29:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C4192
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 12:29:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9e072472bso298745ad.2
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698262167; x=1698866967; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfBnF4iCwD4a9N5emuP2x9Adl70UQOvyoMN5BUKfLU8=;
        b=v8xgzEuOwLhXZWQPVZUq5+c3BkUWwceYsoulqcY21IjYkNV46/+Q7qholY4oNQ51d1
         xjDwYHLz1NpsKhCD0pTo6gsuK6iUaZnm4H7gv/c8mGLta3I7hWh1JO/bwxVlXRgHmOei
         knJB5mXQVS2rLkPm6QUaD5LvwZPZ819wyGVfP1J1WG3gCtz4HZyhXygvjgRF8a4xt4YI
         87ow4FjL560OqjBuQut2STLh8zN2dDVE40bk1bLUdb9UK1Y5Rh2RS/E1u5nbAfbZKZip
         i7anuyvqoV7He6Z0LS4uR66Hl/ta5ZHyKX7/gyb3mrybhIiIhlypm6TPMyYyfTJLdi6z
         iTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262167; x=1698866967;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfBnF4iCwD4a9N5emuP2x9Adl70UQOvyoMN5BUKfLU8=;
        b=pA7L2y+2wOn9px+w6unnAOk2TAGMqvazBmBFC1unCPLlBzJPQC41VDNJkDV6t7F3NT
         ajEOyznd5cjMAcNHrwVXx3DhOJcJqQ0vjBF/b143R4d05xZUGrjTXumCYw9RCCD/mj5L
         gTr1S0xUPziohOaSJyvFOv4rzV6gedwxXALi8brzb8BairBkfruJPwj8JrcVHbrfMpIX
         Wi70IGQNKcbosFfCbacSKGOtQRQ2l5JBLKAQVCWZwOQGDq42p2S/Qr+NQplcVjLhxgW+
         cfG2rBhUmPBcycqwx6TmnKghi0oiXSLMyx6ovgLXwH2yOraqBMYp6vGC29ALcXBpfoeC
         i1WA==
X-Gm-Message-State: AOJu0YxojLfYmVpOHFR4wyS1tqThwVu5NJBNDQT7ToOd0UlD4avlejqv
        EP8rqJLSDKzzgiyDjmhX31XPCjMY4+sX9wEHb4Y=
X-Google-Smtp-Source: AGHT+IG0fweszR+L4lFFjDOeOekMSVHz9kUTKFRybUXWDt19vYknMJoVSUALc6ze/dqmG5taH5rZgw==
X-Received: by 2002:a17:902:ecc6:b0:1c9:cc41:76e4 with SMTP id a6-20020a170902ecc600b001c9cc4176e4mr14303293plh.10.1698262166867;
        Wed, 25 Oct 2023 12:29:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw7-20020a170903044700b001c736b0037fsm9597934plb.231.2023.10.25.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:29:26 -0700 (PDT)
Message-ID: <65396c96.170a0220.fb8b8.0ade@mx.google.com>
Date:   Wed, 25 Oct 2023 12:29:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.60
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Tree: stable
Subject: stable/linux-6.1.y baseline: 169 runs, 2 regressions (v6.1.60)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable/linux-6.1.y baseline: 169 runs, 2 regressions (v6.1.60)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.1.y/kernel/=
v6.1.60/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.1.y
  Describe: v6.1.60
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      32c9cdbe383c153af23cfa1df0a352b97ab3df7a =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/65393a8cc4bb93a73fefcf1f

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable/linux-6.1.y/v6.1.60/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.1.y/v6.1.60/arm=
64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65393a8cc4bb93a73fefcf26
        new failure (last pass: v6.1.59)

    2023-10-25T15:55:42.539365  / # #
    2023-10-25T15:55:42.641336  export SHELL=3D/bin/sh
    2023-10-25T15:55:42.641668  #
    2023-10-25T15:55:42.742405  / # export SHELL=3D/bin/sh. /lava-388657/en=
vironment
    2023-10-25T15:55:42.743182  =

    2023-10-25T15:55:42.844427  / # . /lava-388657/environment/lava-388657/=
bin/lava-test-runner /lava-388657/1
    2023-10-25T15:55:42.845580  =

    2023-10-25T15:55:42.851322  / # /lava-388657/bin/lava-test-runner /lava=
-388657/1
    2023-10-25T15:55:42.916339  + export 'TESTRUN_ID=3D1_bootrr'
    2023-10-25T15:55:42.916749  + cd /lava-388657/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/653=
93a8cc4bb93a73fefcf36
        new failure (last pass: v6.1.59)

    2023-10-25T15:55:45.287082  /lava-388657/1/../bin/lava-test-case
    2023-10-25T15:55:45.287443  <8>[   17.006305] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-10-25T15:55:45.287681  /lava-388657/1/../bin/lava-test-case   =

 =20
