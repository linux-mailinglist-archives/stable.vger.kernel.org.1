Return-Path: <stable+bounces-8306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A5F81C4CD
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 06:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E541C24EDD
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C28611B;
	Fri, 22 Dec 2023 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ZAaOLrUK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5461C126
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbb20471b0so1111889a34.1
        for <stable@vger.kernel.org>; Thu, 21 Dec 2023 21:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703224469; x=1703829269; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lsAX5uWBttEGJ1abJnIFmdQO0qHmtkrk0Gog5lWwDYA=;
        b=ZAaOLrUKAa1M4CjYvOXgtKJbbFlZDMlpcsGKHQoJspRXuhxPbC/1UrwDHN4MwGZuws
         Rxiq/tB96TBW79e2IVmVcfyU+XgwjiN0zIKs98BCoU76fj2+Uijp/dkBUw6V63gKKh9W
         czyiDwpAPsauxfvkzpYQSHtWe9/uFx3jMH4zYxPDYfeG9ehwPTMAtrKv2rXOSF/vNjoo
         1GlbBj8Bn6p22famRzrdpAtFpDxbO9RfkvcvuBg9OqCDX0E0YrkK69RzrGINJvVNtt6p
         IgIh47lMqZStrkpfiexKpkfMvOhS8B6WTTaBtUfsK5EmjEciYYJO+ylH99uv+dNXX+7E
         3/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703224469; x=1703829269;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsAX5uWBttEGJ1abJnIFmdQO0qHmtkrk0Gog5lWwDYA=;
        b=VCadPvlF9Z8z71xxtOjCReQdLWmxhEPv7MuyOor3AghsDQsFAzm31BdR8uY9T5Dge0
         YLYW1Dj4hbVOK2+t37mu5GszYZipprIRe1cWXK4bQPZf3Z15BBecE56aCF9fsFJuunKA
         0/ULwUimwKmh8R0u56LDT6xDt6VHv6XM9EpVcR9X7sJhba83k9CKBbgUiJuLeb+JZep/
         uxaKd2RsFTQ/PMyE+jpHuVYUb5BD+F8O44uynY6rWebyJ+gZWFZw6WCyzUNeX2civHe4
         mFezP8enSeaz/Hs3lxpQElm36Ik1iuKa6NQjOiYtwBy2WTrwiDfUzLSwz/OaRK7kumn9
         UXGg==
X-Gm-Message-State: AOJu0Ywzulr4pHEmIe0qSbXfFeD6YDWV33IuNJvVzJZITH5ZOidgCHgb
	NwpfqLOBg9oVlja6FJFv1xF/yBHy8AaVFdRWroHKQXPkBM0=
X-Google-Smtp-Source: AGHT+IH5QB92BwRqAG1VgfNSEMwhV92TIl4vYX34YTwNbT/tp4fPhzFJws1ErwbQMyhJb/kQW8d0Wg==
X-Received: by 2002:a05:6830:10da:b0:6db:a976:657e with SMTP id z26-20020a05683010da00b006dba976657emr808305oto.14.1703224469212;
        Thu, 21 Dec 2023 21:54:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n29-20020a056a000d5d00b006c4d47a7668sm2580245pfv.127.2023.12.21.21.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 21:54:28 -0800 (PST)
Message-ID: <65852494.050a0220.e6ae1.91eb@mx.google.com>
Date: Thu, 21 Dec 2023 21:54:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.1
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.68-112-g84f21cfd9e7ab
Subject: stable-rc/queue/6.1 baseline: 109 runs,
 3 regressions (v6.1.68-112-g84f21cfd9e7ab)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 109 runs, 3 regressions (v6.1.68-112-g84f21cf=
d9e7ab)

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


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.68-112-g84f21cfd9e7ab/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.68-112-g84f21cfd9e7ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      84f21cfd9e7aba7a43ac436342a5b10bd884849b =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6584f3b97ff6138e40e1349a

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-11=
2-g84f21cfd9e7ab/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-11=
2-g84f21cfd9e7ab/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584f3b97ff6138e40e1349f
        failing since 29 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-22T02:33:13.533519  / # #

    2023-12-22T02:33:13.634006  export SHELL=3D/bin/sh

    2023-12-22T02:33:13.634153  #

    2023-12-22T02:33:13.734610  / # export SHELL=3D/bin/sh. /lava-12346382/=
environment

    2023-12-22T02:33:13.734730  =


    2023-12-22T02:33:13.835214  / # . /lava-12346382/environment/lava-12346=
382/bin/lava-test-runner /lava-12346382/1

    2023-12-22T02:33:13.835399  =


    2023-12-22T02:33:13.847435  / # /lava-12346382/bin/lava-test-runner /la=
va-12346382/1

    2023-12-22T02:33:13.900363  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-22T02:33:13.900444  + cd /lav<8>[   19.122024] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12346382_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6584f39e17968a884ce13565

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-11=
2-g84f21cfd9e7ab/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-11=
2-g84f21cfd9e7ab/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584f39e17968a884ce1356a
        failing since 29 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-22T02:25:28.795970  / # #
    2023-12-22T02:25:28.897704  export SHELL=3D/bin/sh
    2023-12-22T02:25:28.898297  #
    2023-12-22T02:25:28.999354  / # export SHELL=3D/bin/sh. /lava-449404/en=
vironment
    2023-12-22T02:25:29.000045  =

    2023-12-22T02:25:29.101088  / # . /lava-449404/environment/lava-449404/=
bin/lava-test-runner /lava-449404/1
    2023-12-22T02:25:29.102015  =

    2023-12-22T02:25:29.105840  / # /lava-449404/bin/lava-test-runner /lava=
-449404/1
    2023-12-22T02:25:29.184847  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-22T02:25:29.185496  + cd /lava-449404/<8>[   18.536623] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 449404_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6584f3bb8efb60b0d3e13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-11=
2-g84f21cfd9e7ab/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.68-11=
2-g84f21cfd9e7ab/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6584f3bb8efb60b0d3e13489
        failing since 29 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-22T02:33:28.316571  / # #

    2023-12-22T02:33:28.417869  export SHELL=3D/bin/sh

    2023-12-22T02:33:28.418536  #

    2023-12-22T02:33:28.519857  / # export SHELL=3D/bin/sh. /lava-12346383/=
environment

    2023-12-22T02:33:28.520592  =


    2023-12-22T02:33:28.622052  / # . /lava-12346383/environment/lava-12346=
383/bin/lava-test-runner /lava-12346383/1

    2023-12-22T02:33:28.623150  =


    2023-12-22T02:33:28.664779  / # /lava-12346383/bin/lava-test-runner /la=
va-12346383/1

    2023-12-22T02:33:28.665309  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-22T02:33:28.705510  + cd /lava-1234638<8>[   19.207657] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12346383_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

