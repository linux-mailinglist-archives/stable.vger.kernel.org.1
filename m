Return-Path: <stable+bounces-3584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1627FFEBB
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2811C2816AB
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 22:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2FD5B217;
	Thu, 30 Nov 2023 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="VvO4NaAL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD07139
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:48:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cdfee14c24so12218b3a.2
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701384539; x=1701989339; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TXSq0Qb0tu/s5+dSktx2ftUC9+Z/CAlVB+e+CW27KTA=;
        b=VvO4NaALefC3iN8eWx97pfwZ2jPLZ8V983a6oWUh/R0QngiDlG+gsrlfSUopy108OC
         t8CWaz533pZLX8McF8EE84hVj1ORGYELipvi6g6JgUKVyE2lFIL3ChsgrgWXJ5XeFDse
         OpDEYie0k5OcMCMOk7YI5AyLo+0RQWx9RMWNDmLXopAHvdIWYosXDWiXlUB2/8S7oS4l
         svTIUtIVN2cLBuStVkZvMFBd1qEB3MFhW2r1TTCOw+6g47eU0JvAeJz44dvYMh/Z5LTa
         FDRgH1PXu3R5reEXQvTrj7+r6H0uw0wJUVKmZ6bm5NpUbTq02N9MMfb6JEWIWLlXug6R
         wXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701384539; x=1701989339;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXSq0Qb0tu/s5+dSktx2ftUC9+Z/CAlVB+e+CW27KTA=;
        b=i3jihJ8JXW/guhbVumiO/8obkDdvHs8O1ORE+1DdMmsnJ/rKU9lHQtGqR+9Jg3+LnZ
         EAXvHiSlkqDoGpy9WykOCACA6VcNw8nD+/OIHOxAONMDzR49OjxWsOAFU9W7JXW8p3hv
         xBmwWcNi7BdsHwX4eZcAaPj1ZlrwKXBATK/OWr1lJYIREbMZ2A3JNqcrFBOOxB0NXAzE
         +1QRTUeliI5Ysdtd6Sdvj95alJH61MZpdc+nuj9silvVcfilNoWgsIXYWTkX/sWFxI1Y
         vDWVt5bbWo7DWo/8NKplEFYdVp/wEhGj/LW3vbmnVmdW9Gl2azTr0ambpvxk1XXRB+7t
         KFWg==
X-Gm-Message-State: AOJu0YxlvU1o8B+Q5Ih5Hmqc5heHZ0og3zctLN34dg/fHFVsdGSNB5jO
	yj2DAZCFw88Y6IkMJwJPVjUsRXCWdELdCqZLKS+TbQ==
X-Google-Smtp-Source: AGHT+IE3+7c3cgeJuqv46JbSV1aDIvV7s3kIv4sTsMIwd8G8O4Iph1kMSerMSMeJTWvj1BlyGpoVyQ==
X-Received: by 2002:a05:6a20:1455:b0:18c:a8fe:42f3 with SMTP id a21-20020a056a20145500b0018ca8fe42f3mr15456289pzi.19.1701384538827;
        Thu, 30 Nov 2023 14:48:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c5-20020aa78c05000000b006cd985a9d56sm1716083pfd.186.2023.11.30.14.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:48:58 -0800 (PST)
Message-ID: <6569115a.a70a0220.48926.5ba6@mx.google.com>
Date: Thu, 30 Nov 2023 14:48:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.10.202-71-ga7f0dd50ec8cc
Subject: stable-rc/linux-5.10.y baseline: 142 runs,
 2 regressions (v5.10.202-71-ga7f0dd50ec8cc)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 142 runs, 2 regressions (v5.10.202-71-ga7f=
0dd50ec8cc)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.10.y/ker=
nel/v5.10.202-71-ga7f0dd50ec8cc/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.202-71-ga7f0dd50ec8cc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      a7f0dd50ec8cc1a1943490b06399a1831d960d7d =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6568e044f9558889eb7e4afb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-71-ga7f0dd50ec8cc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-71-ga7f0dd50ec8cc/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-p=
ine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568e044f9558889eb7e4b04
        failing since 50 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-30T19:19:23.051415  <8>[   17.008827] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 445972_1.5.2.4.1>
    2023-11-30T19:19:23.156486  / # #
    2023-11-30T19:19:23.258083  export SHELL=3D/bin/sh
    2023-11-30T19:19:23.258667  #
    2023-11-30T19:19:23.359638  / # export SHELL=3D/bin/sh. /lava-445972/en=
vironment
    2023-11-30T19:19:23.360233  =

    2023-11-30T19:19:23.461255  / # . /lava-445972/environment/lava-445972/=
bin/lava-test-runner /lava-445972/1
    2023-11-30T19:19:23.462150  =

    2023-11-30T19:19:23.466571  / # /lava-445972/bin/lava-test-runner /lava=
-445972/1
    2023-11-30T19:19:23.533654  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6568e04766b02084fa7e4a89

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-71-ga7f0dd50ec8cc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
02-71-ga7f0dd50ec8cc/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h=
6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6568e04766b02084fa7e4a92
        failing since 50 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-30T19:25:51.600573  / # #

    2023-11-30T19:25:51.702764  export SHELL=3D/bin/sh

    2023-11-30T19:25:51.703469  #

    2023-11-30T19:25:51.804803  / # export SHELL=3D/bin/sh. /lava-12139795/=
environment

    2023-11-30T19:25:51.805517  =


    2023-11-30T19:25:51.906884  / # . /lava-12139795/environment/lava-12139=
795/bin/lava-test-runner /lava-12139795/1

    2023-11-30T19:25:51.907979  =


    2023-11-30T19:25:51.910026  / # /lava-12139795/bin/lava-test-runner /la=
va-12139795/1

    2023-11-30T19:25:51.953729  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-30T19:25:51.984052  + cd /lava-1213979<8>[   18.196881] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12139795_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

