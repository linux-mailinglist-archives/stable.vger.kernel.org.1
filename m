Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580CA7EC904
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjKOQx7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 11:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKOQx7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 11:53:59 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8D11D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 08:53:56 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso6119287b3a.3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700067235; x=1700672035; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=POQbmg90ikP6IKLm6atW8M8gOgX0fm9xAwMjLXs2FJM=;
        b=0RlgWIDjVIpxMOKp0tXzR3gSldyDWZ51NCbbiBFHfE+fJdMXt6/EWK2BOeV2VF5/cp
         VhZGnNwUymZNSExOjlqkctKo4m9WDbf8NsvCWZgdAhDQmttjJn7k6rZcIXAvup5GMx71
         PPbb4beVcD0LZlFkClNBR1BKGJdTewCpfamv2lU+ykqP2mWTWHE7qrhs3HIsENanXlQ/
         dcK2k3UJce4GwPr3AgaDRNdxxgzKWf5q8nBQ39Vpchc4Q63X1gyAHCFqzbsLqzpvUhTN
         eEsb+TmZdj1Ds29lNQ1Dc3w2hfqUloBE4My7UscqvLCCHHbBHsiNzVtbiJfj9WxGfCKy
         eorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067235; x=1700672035;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POQbmg90ikP6IKLm6atW8M8gOgX0fm9xAwMjLXs2FJM=;
        b=eUX7zb+eR+ZxCfq0+WVB2y95ZwyL4CiQoHNDF/rj3SxOICAtWZi//ZO5M/JLzLFWyc
         Qv2VNGZhYRTF2mq+Wl5pZHQfM7L/Lsx+pftNTjGhuNR/NXdDj+Xam2FRwSoMD/BnKmVH
         Jv6mFdRDFyDPsOJ2eFY3ONtYtZXvnVzcHzvN1KNbGOskDXmFd2AOvUmvOBqyTwaAkxF9
         i4qovRMDDE8ZxQpLkmm/yRmEItLuk4Fe80vK6grcIIU5yUH1sx3zI5nPVsMyHA9MyXTE
         wMxP0Kjm7IwFa9m0oYVqBOsP/8m62OZwDD1sBOmkxblLs/SVUxyF3tkrv4h9p3Juf07x
         IgxA==
X-Gm-Message-State: AOJu0YwapBfVqEwxR94tyEKosGMWgrRhjaD6ciXTi6CSzewU/BpYJRah
        JDkrRMfpDpjNR6bLZgCvURuPz005WQP2oXTED0Dahg==
X-Google-Smtp-Source: AGHT+IFrk+bOIiIu1IjhEpigToyTpfIWA4ESC0jsYzOI5UjJB9mnweVI2S+x9HzyDkAB8f0RLiCE8g==
X-Received: by 2002:a05:6a20:f39c:b0:187:1015:bf88 with SMTP id qr28-20020a056a20f39c00b001871015bf88mr5305878pzb.29.1700067235013;
        Wed, 15 Nov 2023 08:53:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k20-20020a635614000000b005b9288d51f0sm1396331pgb.48.2023.11.15.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:53:54 -0800 (PST)
Message-ID: <6554f7a2.630a0220.22f9f8.3ea8@mx.google.com>
Date:   Wed, 15 Nov 2023 08:53:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.15.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Kernel: v5.15.138-267-g01a21bc264b6
Subject: stable-rc/linux-5.15.y baseline: 115 runs,
 2 regressions (v5.15.138-267-g01a21bc264b6)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-5.15.y baseline: 115 runs, 2 regressions (v5.15.138-267-g01=
a21bc264b6)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-5.15.y/ker=
nel/v5.15.138-267-g01a21bc264b6/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-5.15.y
  Describe: v5.15.138-267-g01a21bc264b6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      01a21bc264b6e32a434dc3b9d5823d6cb5c6018d =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/6554c5f9a211b05dbe7e4aa6

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
38-267-g01a21bc264b6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-5.15.y/v5.15.1=
38-267-g01a21bc264b6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pi=
tx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6554c5f9a211b05dbe7e4aad
        new failure (last pass: v5.15.138)

    2023-11-15T13:21:44.047132  / # #
    2023-11-15T13:21:44.149269  export SHELL=3D/bin/sh
    2023-11-15T13:21:44.149959  #
    2023-11-15T13:21:44.251428  / # export SHELL=3D/bin/sh. /lava-395553/en=
vironment
    2023-11-15T13:21:44.252123  =

    2023-11-15T13:21:44.353624  / # . /lava-395553/environment/lava-395553/=
bin/lava-test-runner /lava-395553/1
    2023-11-15T13:21:44.354789  =

    2023-11-15T13:21:44.358546  / # /lava-395553/bin/lava-test-runner /lava=
-395553/1
    2023-11-15T13:21:44.420700  + export 'TESTRUN_ID=3D1_bootrr'
    2023-11-15T13:21:44.421127  + cd /l<8>[   12.158793] <LAVA_SIGNAL_START=
RUN 1_bootrr 395553_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/655=
4c5f9a211b05dbe7e4abd
        new failure (last pass: v5.15.138)

    2023-11-15T13:21:46.749689  /lava-395553/1/../bin/lava-test-case
    2023-11-15T13:21:46.750141  <8>[   14.580631] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-11-15T13:21:46.750499  /lava-395553/1/../bin/lava-test-case   =

 =20
