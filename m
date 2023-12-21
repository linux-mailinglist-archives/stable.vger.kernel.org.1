Return-Path: <stable+bounces-8222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CF81AE60
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 06:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557281F247A8
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D89474;
	Thu, 21 Dec 2023 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="JFHYI2Cw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B499467
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbb2403fa2so306099a34.2
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 21:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703136635; x=1703741435; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+MtcJg6N0kTzIBbhV1f+6Yn3vPH+mCb1gO0wXXoY5cU=;
        b=JFHYI2Cws+R2trW8C0WCzqW7IRiwc83H6j5i4ndJVE/fMxlsttllRc3OT5enOmAwSf
         qixa0f5yhr6VFzf2i3TcDKMul4oDppdh9aLqF/FDcKEs6ACBG1vdBpeUY478CgWJhKUy
         S8kgXFY8w72wCpKDVQbNo9xYI+miNeTcuxebn+iPrIL2/OnXEdU4l9kufQtCk+OAM741
         zg9Aj48TxqBzrdh/Wjy2O+lKbTBP2OTreBcVoii9+O+Of5hkK6gttEdZpP6LLeIZHEAC
         +rc/RIGuACcQjfVaHjqlWsC2OVvC6TpWqouwZKD3z/5j9tMv2AlRoMXlEbdWM8IPaYsS
         ER5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703136635; x=1703741435;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MtcJg6N0kTzIBbhV1f+6Yn3vPH+mCb1gO0wXXoY5cU=;
        b=w8WeYOnHWfhBy2FGkl/7r9yHKWx3ojFLMzAMC4nOYh5HjR/pU6UWiSuwPnUUW/e1c4
         9QqkD4c6lNC79bYwJ4yTfJqkD+F4YTLYTVAvWpYv2Wz/BbysLJJRshgzfkuhjargKyOF
         SHULMqyLGc3wO1PBOb8JdPbGaCCMmXIKzSwFP/EU3i48k1ltC4PtmKbqrw+Rhkc1UjI5
         sRESlb5rK94v8jYJJ7QJ409Dvw0L8IM0PkgoVdf78pOJTf5/NKczwNegqhhjFHWfjdkB
         Z8uD3l4/B8mougl9vo7GR+Sg5kDBloSTbhHQLBzn6k18zhDNumPqweSKqGyyS450Bw6d
         A5yA==
X-Gm-Message-State: AOJu0YyJlHCyboj2m62FhlvSUTYnBq4GnYOiem0Cjbe7UNCi61wZJNEH
	xdrEUVm37JwhudtTG68uFRkNx3Kw4o2ZOJPY85Q=
X-Google-Smtp-Source: AGHT+IH1jpARX0rL3ftu4deaUu6RMLhVt/d2b5XuqpuzoTHOiI7J2sqPlyI+ywiFtZMfdUdbHQ9Tsw==
X-Received: by 2002:a9d:7a89:0:b0:6d9:d817:c1a with SMTP id l9-20020a9d7a89000000b006d9d8170c1amr21303942otn.46.1703136635653;
        Wed, 20 Dec 2023 21:30:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id it27-20020a056a00459b00b006d96d9cb87dsm553927pfb.51.2023.12.20.21.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 21:30:34 -0800 (PST)
Message-ID: <6583cd7a.050a0220.fc40d.1e2c@mx.google.com>
Date: Wed, 20 Dec 2023 21:30:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: queue/6.6
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.6.7-166-g4a769d77505ba
Subject: stable-rc/queue/6.6 baseline: 109 runs,
 4 regressions (v6.6.7-166-g4a769d77505ba)
To: stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

stable-rc/queue/6.6 baseline: 109 runs, 4 regressions (v6.6.7-166-g4a769d77=
505ba)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig                  | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 1          =

r8a779m1-ulcb                | arm64 | lab-collabora   | gcc-10   | defconf=
ig                  | 1          =

sun50i-h6-orangepi-one-plus  | arm64 | lab-clabbe      | gcc-10   | defconf=
ig                  | 1          =


  Details:  https://kernelci.org/test/job/stable-rc/branch/queue%2F6.6/kern=
el/v6.6.7-166-g4a769d77505ba/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   queue/6.6
  Describe: v6.6.7-166-g4a769d77505ba
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      4a769d77505ba10cb662d41046158b31131e144f =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
imx8mm-innocomm-wb15-evk     | arm64 | lab-pengutronix | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/658399d5a6a46cb0d0e13505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-inno=
comm-wb15-evk.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-inno=
comm-wb15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/658399d5a6a46cb0d0e13=
506
        new failure (last pass: v6.6.7-166-g323633885756) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora   | gcc-10   | defconf=
ig+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65839a7c8fd4fb502ae1349f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/basel=
ine-mt8183-kukui-jacuzzi-juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65839a7c8fd4fb502ae13=
4a0
        new failure (last pass: v6.6.7-166-g6a5518dcff6f) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
r8a779m1-ulcb                | arm64 | lab-collabora   | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65839ad5b9b2c18fd5e135a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb=
.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65839ad5b9b2c18fd5e13=
5a8
        new failure (last pass: v6.6.7-166-g323633885756) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig                  | regressions
-----------------------------+-------+-----------------+----------+--------=
--------------------+------------
sun50i-h6-orangepi-one-plus  | arm64 | lab-clabbe      | gcc-10   | defconf=
ig                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65839acc76c482bde1e1354c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-orange=
pi-one-plus.txt
  HTML log:    https://storage.kernelci.org//stable-rc/queue-6.6/v6.6.7-166=
-g4a769d77505ba/arm64/defconfig/gcc-10/lab-clabbe/baseline-sun50i-h6-orange=
pi-one-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65839acc76c482bde1e13=
54d
        new failure (last pass: v6.6.7-166-g323633885756) =

 =20

