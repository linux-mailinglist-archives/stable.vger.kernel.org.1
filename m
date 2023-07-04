Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D05746650
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 02:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGDAEv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 20:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDAEv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 20:04:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4A187
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 17:04:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666edfc50deso3155539b3a.0
        for <stable@vger.kernel.org>; Mon, 03 Jul 2023 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688429089; x=1691021089;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oQccMd/qKx1yMTgQ6n6vjf+g41S2/Z4oj7IKK1eruHQ=;
        b=C3cNHsL0as5Y1+JY9TB5viYeKMfMKafWZBQ2ozboS9g3ssAQD2G0mQ8WcD4aIdZ8Zs
         4myw3WZSqaxpZGWcNrhU1ht9MXaVGox3Cwnd8mN84HHMyMCZ08VPieh8d1mK16pDz4Jc
         KcFaQFcW5QtU0SrA3DjMqonfVnjMGo3Eei1UcMUU3bP8YdZE/h3+HtZygvFtbHF1OpLX
         F8gNRjIC6ecEQ7B+YxjzZh7jFdYUb+ZYllo6ddNiXbYsjKhSztFk7egkJRz+F9B4LQoK
         7oEOqHBsfwukw5rllpRfB+osAcT3sPCkUnAlAmqmNm/PNhPMD+qvYrQO6BLbZ4eEGVOW
         w6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688429089; x=1691021089;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQccMd/qKx1yMTgQ6n6vjf+g41S2/Z4oj7IKK1eruHQ=;
        b=Yq1K/NQDr0ZzKdDmjBJXYK3LwcEXH/GwzsXyar9N4MHohqcRfA2oIxOtZyO1vgwfaJ
         FfmudyeM4dq/5fwggLztLn22oqPTAw+FOYks9cDW2cQwLOYYG8xvQkIfdN55cgclaP7+
         AZRHK6lRbBnYIHsItIEA3ahM4hPrSvfn52Y6GIAnQ/61/kTL/yb/nu94hI5PFppJdWof
         3ILQNgPMYh/7BhX045YpRXZNvtBR4rh1A9bjhJsgjV4GSa2AnXTHrL0QEBtEk/nSrpIQ
         1/b6VZdAeZNGlLksN0OXiTFAVOTFnAdfxQFc78FIHwEZEY4YfHHbkj/Tf5ouZ0x/HpJw
         C3Sw==
X-Gm-Message-State: AC+VfDw0BVOamOtTZPt5zhqkQsWL3sksNjIl2r3eoe8hR+f1cEnHFbjy
        hYlTCaWy0q051LHWGw7TEU/NzAh9JA4QXxI4FiB/mg==
X-Google-Smtp-Source: ACHHUZ708TkQQsf6I81NOLEMF5/rqQR/h63J4/Enq5Rvb6OVP6lUEKj0GS0p/gtVHVyjEw8i0mVKUA==
X-Received: by 2002:a05:6a00:1ca0:b0:67c:db:c2f4 with SMTP id y32-20020a056a001ca000b0067c00dbc2f4mr22456373pfw.4.1688429089397;
        Mon, 03 Jul 2023 17:04:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j5-20020a62b605000000b00640f51801e6sm14469601pff.159.2023.07.03.17.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 17:04:48 -0700 (PDT)
Message-ID: <64a36220.620a0220.9e813.c64b@mx.google.com>
Date:   Mon, 03 Jul 2023 17:04:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.3.11-14-gec916e7bb7e9
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.3.y
Subject: stable-rc/linux-6.3.y baseline: 113 runs,
 1 regressions (v6.3.11-14-gec916e7bb7e9)
To:     stable@vger.kernel.org, kernel-build-reports@lists.linaro.org,
        kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

stable-rc/linux-6.3.y baseline: 113 runs, 1 regressions (v6.3.11-14-gec916e=
7bb7e9)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/stable-rc/branch/linux-6.3.y/kern=
el/v6.3.11-14-gec916e7bb7e9/plan/baseline/

  Test:     baseline
  Tree:     stable-rc
  Branch:   linux-6.3.y
  Describe: v6.3.11-14-gec916e7bb7e9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
  SHA:      ec916e7bb7e9c20ced0d1fbf4caf972af2cecec9 =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig           | regressi=
ons
----------+------+--------------+----------+---------------------+---------=
---
beagle-xm | arm  | lab-baylibre | gcc-10   | omap2plus_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64a32d8fc6e6a09116bb2af7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
14-gec916e7bb7e9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.txt
  HTML log:    https://storage.kernelci.org//stable-rc/linux-6.3.y/v6.3.11-=
14-gec916e7bb7e9/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-beagl=
e-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64a32d8fc6e6a09116bb2=
af8
        failing since 3 days (last pass: v6.3.10-31-ge236789dc329, first fa=
il: v6.3.10-33-g45e606c9f23d) =

 =20
