Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAC7DF40C
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 14:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbjKBNkn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376627AbjKBNkm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 09:40:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA459189
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 06:40:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc5b6d6228so7055805ad.2
        for <stable@vger.kernel.org>; Thu, 02 Nov 2023 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698932432; x=1699537232; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8IagN0Im27zRqghw1Qp6sNoItODPR9vOrG1OJ5xUZCQ=;
        b=jV7isopBHhqfzZBpAIT8Ek9+iLzozDx5LefMCATU3JMsdU1pfulJRUBevSZYUPFbdo
         5pjNmOt6wM4Mgr6ap3dFjbfesyDbEfYj00pFNjDpZcsScbND5hZUHaOWC9DMs4DgVGr3
         qc3m9tOOB1ayJi0wszM9c1CKEhLVc3grpmA2ssMdpngJsc8yp86NW6QmbHnbUTkgHXyU
         Ps9/vgH8PKqnmFfU2DMB0tB9Xs1cn4eJST2q12eX8QUcou1Vnf68GQ0ImHCT18hWNBjV
         CQQABUcR3abf9Eka2Iot0rIqwL9j6cREuovOkDhaLjsKeQM9WO4isvchZq+dUoHemj4E
         1Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932432; x=1699537232;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IagN0Im27zRqghw1Qp6sNoItODPR9vOrG1OJ5xUZCQ=;
        b=sQr/OlF3KEt2Nf7dmIviDEkBCGTeamSBSTydFMYbWGQJArhCP/5+pU2NGUAoRhxBrr
         DYG+OLq668r+LmjjkQB/xXdqfiQskq+xYYpU9ckgFij7lO/VL84OlAcl11s2y64JJGzB
         o2vlGidLOz4zQkzXb6+uzRjRgJT5UiWDm9FdQM1oi1txLH9YrjDSqhdpkN16gI4596Uk
         Ow+pw1mc5LVLtqGfskHZvwKErKmOioLl/gM2TPJoWph7KNZzQejCKn9KaF91iNwL76bW
         nVUXc7RzG/PX2Bvf+AllDvZXO/OT9Y4ghujNMrce2J0Vetmzuy9rYw4ZuamManXXLTyH
         LluA==
X-Gm-Message-State: AOJu0YwfYTmtclH2FdrkMoHazJHPnXnYxJ5gBVQtdpmFexcXOncKFAUn
        k9KNzwJQ5nwaBqDmcOjwjUHa/aU6uk4MXbXGUJ5IGw==
X-Google-Smtp-Source: AGHT+IHBhvush5mH2tBfd4LIqDnmfTXbdmI/UGDzF+8e5yqtv/obMxnVm1dkoP/Qn58peupjt9gjHg==
X-Received: by 2002:a17:903:245:b0:1ca:e05a:93a2 with SMTP id j5-20020a170903024500b001cae05a93a2mr18641844plh.32.1698932431864;
        Thu, 02 Nov 2023 06:40:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b001c73eace0fesm3130954plb.157.2023.11.02.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:40:31 -0700 (PDT)
Message-ID: <6543a6cf.170a0220.bcc82.8a30@mx.google.com>
Date:   Thu, 02 Nov 2023 06:40:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.199
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
Subject: stable-rc/linux-5.10.y baseline: 174 runs, 3 regressions (v5.10.199)
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

stable-rc/linux-5.10.y baseline: 174 runs, 3 regressions (v5.10.199)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.199/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.199
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      cb49f0e441ce7db63ef67ccfa9d9562c22f5d6c3 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
panda              | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/653966117a9004113aefcefe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653966117a9004113aefcf07
        failing since 0 day (last pass: v5.10.148-5-gac0fb49345ee, first fa=
il: v5.10.198-200-ge31b6513c43d)

    2023-10-25T19:01:21.459095  <8>[   24.783966] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3814643_1.5.2.4.1>
    2023-10-25T19:01:21.565768  / # #
    2023-10-25T19:01:21.666861  export SHELL=3D/bin/sh
    2023-10-25T19:01:21.667200  #
    2023-10-25T19:01:21.767958  / # export SHELL=3D/bin/sh. /lava-3814643/e=
nvironment
    2023-10-25T19:01:21.768318  =

    2023-10-25T19:01:21.869091  / # . /lava-3814643/environment/lava-381464=
3/bin/lava-test-runner /lava-3814643/1
    2023-10-25T19:01:21.869654  =

    2023-10-25T19:01:21.874614  / # /lava-3814643/bin/lava-test-runner /lav=
a-3814643/1
    2023-10-25T19:01:21.932745  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/653962e622637550e2efcf28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653962e622637550e2efcf31
        failing since 22 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-02T10:00:34.248330  / # #
    2023-11-02T10:00:34.349671  export SHELL=3D/bin/sh
    2023-11-02T10:00:34.350161  #
    2023-11-02T10:00:34.451157  / # export SHELL=3D/bin/sh. /lava-442319/en=
vironment
    2023-11-02T10:00:34.451694  =

    2023-11-02T10:00:34.552596  / # . /lava-442319/environment/lava-442319/=
bin/lava-test-runner /lava-442319/1
    2023-11-02T10:00:34.553320  =

    2023-11-02T10:00:34.560041  / # /lava-442319/bin/lava-test-runner /lava=
-442319/1
    2023-11-02T10:00:34.627584  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-02T10:00:34.627891  + cd /lava-442319/<8>[   17.436788] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 442319_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/653962e322637550e2efcf0e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.1=
99/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653962e322637550e2efcf17
        failing since 22 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-02T10:05:22.054298  / # #

    2023-11-02T10:05:22.156613  export SHELL=3D/bin/sh

    2023-11-02T10:05:22.156873  #

    2023-11-02T10:05:22.257361  / # export SHELL=3D/bin/sh. /lava-11929168/=
environment

    2023-11-02T10:05:22.257517  =


    2023-11-02T10:05:22.358036  / # . /lava-11929168/environment/lava-11929=
168/bin/lava-test-runner /lava-11929168/1

    2023-11-02T10:05:22.358281  =


    2023-11-02T10:05:22.360978  / # /lava-11929168/bin/lava-test-runner /la=
va-11929168/1

    2023-11-02T10:05:22.430405  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-02T10:05:22.430867  + cd /lava-1192916<8>[   18.110746] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11929168_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20
