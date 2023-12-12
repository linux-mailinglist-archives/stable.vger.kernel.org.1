Return-Path: <stable+bounces-6485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06880F50C
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8329F1F21792
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F737E767;
	Tue, 12 Dec 2023 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="p/tbR6pp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15691AB
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 09:58:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d331f12f45so8196995ad.2
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702403912; x=1703008712; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RsWuBSjHkHZY3M/DFP6X9AYa+P+kqfrSTogSc0biW/0=;
        b=p/tbR6ppkch4GdqUvOIFrbJdVuy4Nns3bRd+2fqRC+NHrjarN27WEuf0tNPtuLDkqO
         h4CixjQhB00AqbXAj2sqNyCjgylTZ8Gx1tgY3KZ/Y4gzakOSnaXlLrZleXnO6iWa0cuJ
         WKv+8gkGu0OVO1y3IxGZpQ38BKnMMBOqDEzrGGhX9mZy0Vtl1BiFgs+jjsozMVfnOBlW
         J/nRbFtkGzP5knW+h/9rZ9e5thBApJLaCBi3BbKHzuJgHUD6SLTz35CD5uhD29OO7AHY
         W0400JKikA//YTmBXWUaHou6f19HbOiGna6rnV/wC3aO0wHvlLtXVNs91+F2LiR/Q0tr
         e/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403912; x=1703008712;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsWuBSjHkHZY3M/DFP6X9AYa+P+kqfrSTogSc0biW/0=;
        b=eYFTeoGi7VKqblb46kswTPReHN/Uedix9I2hK6yJzHY5HpRDGssaxBgThbwP773ahp
         QVCp9b8YecnJlSFGTb9TGl2LTuRUEbtbf6Ub/khVXewL23LthZpiSWR89IXXIo/33LNF
         cWEXkZzFoKLtrDe3phitUqQqHxJ6n0vKzS64dJencUtPhGRDzdgCfrYjiYWtMGds7FsI
         pqbWg25PpQhkqCcFv2VDbolq8Jg1pDB2A10iGvcMC3+hyS+vXJSUnrsTb1YpHEB71SyJ
         AU3f8MPC2WMafXf/kxCjvPe/PM6QPjF+4xT284mcOfjM7M/nIFEB4Nu1gl1sLQ/whNM7
         2I/A==
X-Gm-Message-State: AOJu0YyZFNyJ8b4s4EwrjJZfSOJ3vVGKsSzUrKN/JdN07/YSkzSg99bE
	U1o9xoSjEq32bOsJAPHD+whhtordokoM6OZD3SWIfQ==
X-Google-Smtp-Source: AGHT+IHiGl9sI0l36RWUR8KGD4bpy2samfsWKyxkpTNYRKO8iTJFRquQ8woFf9ayA69aOeG2dy3qQA==
X-Received: by 2002:a17:902:784a:b0:1d3:3c6c:e94b with SMTP id e10-20020a170902784a00b001d33c6ce94bmr652308pln.2.1702403912178;
        Tue, 12 Dec 2023 09:58:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902d48b00b001d0c0848977sm8902131plg.49.2023.12.12.09.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:58:31 -0800 (PST)
Message-ID: <65789f47.170a0220.f8283.b075@mx.google.com>
Date: Tue, 12 Dec 2023 09:58:31 -0800 (PST)
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
X-Kernelci-Kernel: v6.1.67-194-ge8e28130acd37
Subject: stable-rc/queue/6.1 baseline: 109 runs,
 4 regressions (v6.1.67-194-ge8e28130acd37)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.1 baseline: 109 runs, 4 regressions (v6.1.67-194-ge8e2813=
0acd37)

Regressions Summary
-------------------

platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
asus-CM1400CXA-dalboz | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g+x86-board | 1          =

r8a77960-ulcb         | arm64  | lab-collabora | gcc-10   | defconfig      =
            | 1          =

sun50i-h6-pine-h64    | arm64  | lab-clabbe    | gcc-10   | defconfig      =
            | 1          =

sun50i-h6-pine-h64    | arm64  | lab-collabora | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.1/kern=
el/v6.1.67-194-ge8e28130acd37/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.1
  Describe: v6.1.67-194-ge8e28130acd37
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      e8e28130acd376914049f7ff126b248527180d14 =



Test Regressions
---------------- =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
asus-CM1400CXA-dalboz | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65786f3a6739cdcc05e13486

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/bas=
eline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/bas=
eline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65786f3a6739cdcc05e13=
487
        new failure (last pass: v6.1.67-194-g4d98cff86b0fc) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
r8a77960-ulcb         | arm64  | lab-collabora | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65786db61cf0b10876e134d1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulc=
b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65786db61cf0b10876e134da
        failing since 19 days (last pass: v6.1.31-26-gef50524405c2, first f=
ail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-12T14:34:17.212870  / # #

    2023-12-12T14:34:17.314648  export SHELL=3D/bin/sh

    2023-12-12T14:34:17.315309  #

    2023-12-12T14:34:17.416547  / # export SHELL=3D/bin/sh. /lava-12253759/=
environment

    2023-12-12T14:34:17.417255  =


    2023-12-12T14:34:17.518690  / # . /lava-12253759/environment/lava-12253=
759/bin/lava-test-runner /lava-12253759/1

    2023-12-12T14:34:17.519793  =


    2023-12-12T14:34:17.525158  / # /lava-12253759/bin/lava-test-runner /la=
va-12253759/1

    2023-12-12T14:34:17.585209  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T14:34:17.585719  + cd /lav<8>[   19.097391] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12253759_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
sun50i-h6-pine-h64    | arm64  | lab-clabbe    | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65786dafc83f2c77e4e134df

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-pine-=
h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65786dafc83f2c77e4e134e8
        failing since 19 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-12T14:26:30.715920  <8>[   18.074573] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 447744_1.5.2.4.1>
    2023-12-12T14:26:30.820243  / # #
    2023-12-12T14:26:30.921755  export SHELL=3D/bin/sh
    2023-12-12T14:26:30.922299  #
    2023-12-12T14:26:31.023222  / # export SHELL=3D/bin/sh. /lava-447744/en=
vironment
    2023-12-12T14:26:31.023769  =

    2023-12-12T14:26:31.124694  / # . /lava-447744/environment/lava-447744/=
bin/lava-test-runner /lava-447744/1
    2023-12-12T14:26:31.125528  =

    2023-12-12T14:26:31.131240  / # /lava-447744/bin/lava-test-runner /lava=
-447744/1
    2023-12-12T14:26:31.163246  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
sun50i-h6-pine-h64    | arm64  | lab-collabora | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65786db51cf0b10876e134c3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.1/v6.1.67-19=
4-ge8e28130acd37/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pi=
ne-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65786db51cf0b10876e134cc
        failing since 19 days (last pass: v6.1.22-372-g971903477e72, first =
fail: v6.1.63-176-gecc0fed1ffa4)

    2023-12-12T14:34:31.104516  / # #

    2023-12-12T14:34:31.206724  export SHELL=3D/bin/sh

    2023-12-12T14:34:31.207432  #

    2023-12-12T14:34:31.308937  / # export SHELL=3D/bin/sh. /lava-12253744/=
environment

    2023-12-12T14:34:31.309664  =


    2023-12-12T14:34:31.411173  / # . /lava-12253744/environment/lava-12253=
744/bin/lava-test-runner /lava-12253744/1

    2023-12-12T14:34:31.412375  =


    2023-12-12T14:34:31.428831  / # /lava-12253744/bin/lava-test-runner /la=
va-12253744/1

    2023-12-12T14:34:31.494839  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-12T14:34:31.495341  + cd /lava-1225374<8>[   19.156985] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12253744_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =20

