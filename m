Return-Path: <stable+bounces-6403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E573B80E42D
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 07:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97863282DFC
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF4156F4;
	Tue, 12 Dec 2023 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="odiU0mr8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912EBE
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 22:13:02 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28a5d0ebf1fso1932033a91.0
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 22:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702361581; x=1702966381; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wkheMV99zM2/ddI2UVfKBp/n3OFlbfA+0NTqR2Shw2I=;
        b=odiU0mr8f4ZuyxownjNs8cRbgCEqvLc1zYkGx9l/Y2hksJwkdDiFX1tG0bPxCew+dc
         PAtRUHMlnCIgd28E2IRyWYbPmcdMOVbnx6Ar3vHOn1SKOg0sMkty+swSD76N/0ed3BCk
         ZPpvinKLzOJ7d0WQso56axd/XrpFcGxAwzBEDwQbHRqOI1OnIrO/2StkcvErGVSnIYp5
         /8OPfV6G91zqA/kPkj0duAHR+2VUZ4f3TOJMJnig/YUITBaLhLjZDLbPjeA2mpqKcttC
         uvD+Ot2bSKv+3eklz3gNv7pIquk/8oY4Ov6tqgnOxN8UtHeAyLRJOGiyj7ba9JNHEoBX
         WRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702361581; x=1702966381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkheMV99zM2/ddI2UVfKBp/n3OFlbfA+0NTqR2Shw2I=;
        b=b+3Z7g3sga4qBAs6KcP374BEEEuBUT+cQHVK8uUxJdmBFPAUpHXZxUaHF0vl8FNr0S
         4U33p7kLkDixYcDylkQjaz6aVj0wp2dSkPI9CVmWRU9rvhGj/nViggUDC3D6LTuG772b
         w6iI1FcQPMSKoFjC0tck3CmZ8hzLK+FPu3UogsQtVxGlgnRNOejswTNgcMCMcbFJxS36
         ZumNG26gVtFkn/Zw/QrizjP/t0y1+DUiLyLkdWshIGfE+Vi1m96aukButoe1AK1zHkfj
         VNeN9dvb3MYSCkd/A5kZgYQyUqrHEBGhnCATZDSQVibPrv1bOM6O2s1+PqoXSjwslKIJ
         b91Q==
X-Gm-Message-State: AOJu0Ywof6wUIXn8+k9B9KAny2Kotm4kusY57CrmjiG95QvUBrLT5tN5
	+/4T9Fc7h7WlOvfLLDnp4KtIVS/1iqzmNVnjT7N8RA==
X-Google-Smtp-Source: AGHT+IH+r8ZSCR4qTPlte82QKiloYbz+g0EBm5SBUgIoS0VQ1jLYTeYxTjIIldyBSZz+bU5tar1LbA==
X-Received: by 2002:a17:90a:ec83:b0:286:6cd8:ef17 with SMTP id f3-20020a17090aec8300b002866cd8ef17mr8021078pjy.47.1702361581242;
        Mon, 11 Dec 2023 22:13:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a9bca00b0028abe58ff9bsm525588pjw.40.2023.12.11.22.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:13:00 -0800 (PST)
Message-ID: <6577f9ec.170a0220.6cecf.152d@mx.google.com>
Date: Mon, 11 Dec 2023 22:13:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/5.15
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.15.142-141-g2244f7059734c
Subject: stable-rc/queue/5.15 baseline: 104 runs,
 3 regressions (v5.15.142-141-g2244f7059734c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/5.15 baseline: 104 runs, 3 regressions (v5.15.142-141-g2244=
f7059734c)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F5.15/ker=
nel/v5.15.142-141-g2244f7059734c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/5.15
  Describe: v5.15.142-141-g2244f7059734c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      2244f7059734cf86b4882d73b7953fbaa3e59712 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6577c529000f383553e134ce

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-141-g2244f7059734c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-141-g2244f7059734c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-=
ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577c529000f383553e134d7
        failing since 19 days (last pass: v5.15.114-13-g095e387c3889, first=
 fail: v5.15.139-172-gb60494a37c0c)

    2023-12-12T02:35:09.851242  / # #

    2023-12-12T02:35:09.951789  export SHELL=3D/bin/sh

    2023-12-12T02:35:09.951928  #

    2023-12-12T02:35:10.052409  / # export SHELL=3D/bin/sh. /lava-12247959/=
environment

    2023-12-12T02:35:10.052537  =


    2023-12-12T02:35:10.153108  / # . /lava-12247959/environment/lava-12247=
959/bin/lava-test-runner /lava-12247959/1

    2023-12-12T02:35:10.153295  =


    2023-12-12T02:35:10.164853  / # /lava-12247959/bin/lava-test-runner /la=
va-12247959/1

    2023-12-12T02:35:10.208448  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T02:35:10.223941  + cd /lav<8>[   15.995187] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12247959_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6577c51b4b7548311ee13501

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-141-g2244f7059734c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-141-g2244f7059734c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577c51b4b7548311ee1350a
        failing since 19 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-12T02:27:30.921491  / # #
    2023-12-12T02:27:31.023124  export SHELL=3D/bin/sh
    2023-12-12T02:27:31.023723  #
    2023-12-12T02:27:31.124722  / # export SHELL=3D/bin/sh. /lava-447655/en=
vironment
    2023-12-12T02:27:31.125314  =

    2023-12-12T02:27:31.226471  / # . /lava-447655/environment/lava-447655/=
bin/lava-test-runner /lava-447655/1
    2023-12-12T02:27:31.227439  =

    2023-12-12T02:27:31.231717  / # /lava-447655/bin/lava-test-runner /lava=
-447655/1
    2023-12-12T02:27:31.263721  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-12T02:27:31.299755  + cd /lava-447655/<8>[   16.550204] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 447655_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6577c53d2f1b961501e13489

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-141-g2244f7059734c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-5.15/v5.15.142=
-141-g2244f7059734c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6=
-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6577c53d2f1b961501e13492
        failing since 19 days (last pass: v5.15.105-206-g4548859116b8, firs=
t fail: v5.15.139-172-gb60494a37c0c)

    2023-12-12T02:35:25.169569  / # #

    2023-12-12T02:35:25.271796  export SHELL=3D/bin/sh

    2023-12-12T02:35:25.272601  #

    2023-12-12T02:35:25.373992  / # export SHELL=3D/bin/sh. /lava-12247965/=
environment

    2023-12-12T02:35:25.374679  =


    2023-12-12T02:35:25.476158  / # . /lava-12247965/environment/lava-12247=
965/bin/lava-test-runner /lava-12247965/1

    2023-12-12T02:35:25.477394  =


    2023-12-12T02:35:25.494257  / # /lava-12247965/bin/lava-test-runner /la=
va-12247965/1

    2023-12-12T02:35:25.552974  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T02:35:25.553489  + cd /lava-1224796<8>[   16.830389] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12247965_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

