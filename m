Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F93730283
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbjFNO5j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjFNO5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 10:57:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B21BF3
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:57:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6668208bd4eso139269b3a.0
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686754656; x=1689346656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wUA5um2GVphzadXSrNKkIgZg21AOz4viT4wCMpNKHHg=;
        b=oWBf/JqIzgCZqMN8GtjQ4FASTsu9vqNDaX9SzQdX+xqoh3PXIYVu2gUGUiEMEbwis6
         GRw9NXvn29y684CRtiCAFX9B7rZJUnj/CIEtbH0x/N2o1hNeVuxrsrjaYm3y6f9sIZnE
         mgCy4lG5mo1P/oK7KPeCQ21ir/KIZnzHfQqZi0vM48ycctzbH8DADWnTZF/+/5WTggwM
         PZitw+FMN+EYHmhyFCD/LvimtFmcmbuUBDyWcAVC0nD/z3R/+2WpZ93gdEhlscFLQ3FZ
         QNI5VSi4N0zhgJSJqtpdeDZ/X5hntjItdSIwQ3XW6vKQtA3HAWuRS45aDpuSnEYlEzw5
         QqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686754656; x=1689346656;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUA5um2GVphzadXSrNKkIgZg21AOz4viT4wCMpNKHHg=;
        b=AEpnvx3awwZK4d5Z/QQbNN8229bYDpIGNa03K/K5Bn0K3kZVjeJXLV+k9vkFoIKZqp
         erESFky+HMyu5i8IQI5diE0rx81s4qE+Vs+UTwY1MHeWIMNU2hZG/6dt65v69H7mOGi3
         tVgjxmnK7pgqQV/MpHw+Mf25T/f/KVo85G51TppyEwJEYBgl4CIXzWl50l6HnTVnZqLu
         oEm6a42PHniW599fV4ArQL/lcCi4jBKutTDIvxjSIaFRoZSYWE110+UhOdJAeJXs6uFo
         FjElqLWnvKk4i7PXoSB8YWf0Yg9flrkkLgl3I4pzdLjuD0Dcta9EfHAQTWFdlkq81dRS
         RhFQ==
X-Gm-Message-State: AC+VfDwjLZ3Qpc850gppkI7zfhkBQaDrfXFhHAlp+SEWK7VLYFYt8Oyt
        /FgerTB2GIaYbdnh/GNpa5Sx2HLVAUs+RJaNRbYzUA==
X-Google-Smtp-Source: ACHHUZ4fKE0whKJSBJMbQ3iMDaitY05oobYrsR56whwqVHqCc0jaeapboVRY6TEdxBUIKlF9XOrd2A==
X-Received: by 2002:a05:6a00:853:b0:662:c48b:47e2 with SMTP id q19-20020a056a00085300b00662c48b47e2mr2779981pfk.19.1686754656564;
        Wed, 14 Jun 2023 07:57:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b0064d413ca7desm10776926pfi.171.2023.06.14.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:57:35 -0700 (PDT)
Message-ID: <6489d55f.620a0220.14d9a.591c@mx.google.com>
Date:   Wed, 14 Jun 2023 07:57:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3.8
Subject: stable/linux-6.3.y baseline: 119 runs, 2 regressions (v6.3.8)
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

stable/linux-6.3.y baseline: 119 runs, 2 regressions (v6.3.8)

Regressions Summary
-------------------

platform              | arch | lab           | compiler | defconfig        =
  | regressions
----------------------+------+---------------+----------+------------------=
--+------------
at91-sama5d4_xplained | arm  | lab-baylibre  | gcc-10   | multi_v7_defconfi=
g | 1          =

qemu_mips-malta       | mips | lab-collabora | gcc-10   | malta_defconfig  =
  | 1          =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.3.y/kernel/=
v6.3.8/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.3.y
  Describe: v6.3.8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      f2427f9a3730e9a1a11b69f6b767f7f2fad87523 =



Test Regressions
---------------- =



platform              | arch | lab           | compiler | defconfig        =
  | regressions
----------------------+------+---------------+----------+------------------=
--+------------
at91-sama5d4_xplained | arm  | lab-baylibre  | gcc-10   | multi_v7_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a027eed341ca0b30614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.8/arm/=
multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.8/arm/=
multi_v7_defconfig/gcc-10/lab-baylibre/baseline-at91-sama5d4_xplained.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6489a027eed341ca0b306=
150
        new failure (last pass: v6.3.7) =

 =



platform              | arch | lab           | compiler | defconfig        =
  | regressions
----------------------+------+---------------+----------+------------------=
--+------------
qemu_mips-malta       | mips | lab-collabora | gcc-10   | malta_defconfig  =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/64899e246eb4be688d306133

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.8/mips=
/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.8/mips=
/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64899e246eb4be688d306=
134
        new failure (last pass: v6.3.7) =

 =20
