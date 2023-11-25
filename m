Return-Path: <stable+bounces-2658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699257F904E
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 00:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A81F20E2A
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 23:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4330315A4;
	Sat, 25 Nov 2023 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0FoqPkQc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D04F115
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 15:29:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bd33a450fdso2160967a12.0
        for <stable@vger.kernel.org>; Sat, 25 Nov 2023 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700954962; x=1701559762; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j0W/QQ7YY+qwMahYJQSQDo180nwiLRuj9mhE5cpLh8E=;
        b=0FoqPkQccdkbJXSHOKWAQb60UEkI9r+2EwNKMuiopUVF4ndPeeyLz3+FKyYXjFgg29
         X47kWO15MnscGiI1weZsE4Z5nLxLvHOBrW9GlfYcsPvFaItfqJ1twG597ZsPivT24e57
         rl21FwSOq06NLS81NSxJYtjXHr1kjl83oH7BBHlokenvoKg3+LkrCtHz5as6ZxWtr2SP
         QjcrC4ZG72sXj8StM7vKh51uka8tVnDOGXcFTQJRFO+tD238Svg93pBOEPukOddRVK34
         Ql3QzKwnxEp9S/MzBMBnaoKKFxpXvxpHf3V7M2C3FTfcb9+jZvIEtQlCAm6vxKuWq1CL
         YLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700954962; x=1701559762;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0W/QQ7YY+qwMahYJQSQDo180nwiLRuj9mhE5cpLh8E=;
        b=SRIlUraaB6PfaUHMaX4ItGqf5Bxhzvl4/W05gyGwzPQHn1l27Dvifruvd49g9UCiBS
         e263On0fhopZXBFGYekBEsVj7c6gvVJGSKd+7DZ3ripbohcttGScIVv7rAWLGcm2Md+4
         83RfaghS4lN2FOQff9euxqthWzDRFj+NlDQCJqravDmaM/YPDEGZlXanv3tOdJJNhool
         JJi2iVqfbefDbqM18vZoLNeqO5KBbKc/GSLKjWJ/yOOlg9zldVlXrYaciFiWLaIlfDr6
         ulyWyPTDwWWzFsxXWN2RLXllJLeeOxyA/sMKV9ltRUX+lA5tGiOJZTi4glHR6Y490pN+
         OAlg==
X-Gm-Message-State: AOJu0YygFEuuHgvk2bSn2rODrG31u7y9WtTpgcXtYJjwu3jehvBksl2h
	mVpZwUtLoM0Jq7SWB0a81u1z9AZs4rDtpx+VNCY=
X-Google-Smtp-Source: AGHT+IGxtDf9gE+gEjhTVaz6yY4znN9NttoXoK/MdgWwOtvFQVSX9PDaT0bTYnCPXq1Rw1oJMuLl/g==
X-Received: by 2002:a17:90a:f2d2:b0:27d:348:94a8 with SMTP id gt18-20020a17090af2d200b0027d034894a8mr7474883pjb.6.1700954962348;
        Sat, 25 Nov 2023 15:29:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001ca86a9caccsm5442793pld.228.2023.11.25.15.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 15:29:21 -0800 (PST)
Message-ID: <65628351.170a0220.60bc3.caf3@mx.google.com>
Date: Sat, 25 Nov 2023 15:29:21 -0800 (PST)
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
X-Kernelci-Kernel: v5.10.201-189-gd26c78c8f941c
Subject: stable-rc/linux-5.10.y baseline: 127 runs,
 2 regressions (v5.10.201-189-gd26c78c8f941c)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/linux-5.10.y baseline: 127 runs, 2 regressions (v5.10.201-189-gd2=
6c78c8f941c)

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
nel/v5.10.201-189-gd26c78c8f941c/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.10.y
  Describe: v5.10.201-189-gd26c78c8f941c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      d26c78c8f941c537dd7bf539fd4148257a231d8a =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-clabbe    | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65625255904ccff15c7e4ac5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gd26c78c8f941c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gd26c78c8f941c/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-=
pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65625255904ccff15c7e4ace
        failing since 45 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-25T20:00:15.342487  / # #
    2023-11-25T20:00:15.444510  export SHELL=3D/bin/sh
    2023-11-25T20:00:15.445053  #
    2023-11-25T20:00:15.548650  / # export SHELL=3D/bin/sh. /lava-445283/en=
vironment
    2023-11-25T20:00:15.549215  =

    2023-11-25T20:00:15.650209  / # . /lava-445283/environment/lava-445283/=
bin/lava-test-runner /lava-445283/1
    2023-11-25T20:00:15.651031  =

    2023-11-25T20:00:15.654196  / # /lava-445283/bin/lava-test-runner /lava=
-445283/1
    2023-11-25T20:00:15.722558  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-25T20:00:15.722844  + cd /lava-445283/<8>[   17.429718] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 445283_1.5.2.4.5> =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65625269185d55e8887e4a80

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gd26c78c8f941c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.10.y/v5.10.2=
01-189-gd26c78c8f941c/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-=
h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65625269185d55e8887e4a89
        failing since 45 days (last pass: v5.10.176-224-g10e9fd53dc59, firs=
t fail: v5.10.198)

    2023-11-25T20:07:06.262313  / # #

    2023-11-25T20:07:06.364335  export SHELL=3D/bin/sh

    2023-11-25T20:07:06.365034  #

    2023-11-25T20:07:06.466456  / # export SHELL=3D/bin/sh. /lava-12084166/=
environment

    2023-11-25T20:07:06.467165  =


    2023-11-25T20:07:06.568568  / # . /lava-12084166/environment/lava-12084=
166/bin/lava-test-runner /lava-12084166/1

    2023-11-25T20:07:06.569556  =


    2023-11-25T20:07:06.586715  / # /lava-12084166/bin/lava-test-runner /la=
va-12084166/1

    2023-11-25T20:07:06.629732  + export 'TESTRUN_ID=3D1_bootrr'

    2023-11-25T20:07:06.645904  + cd /lava-1208416<8>[   18.254226] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12084166_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

