Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED250716CC0
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 20:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjE3SpJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 14:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjE3SpI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 14:45:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C1C9
        for <stable@vger.kernel.org>; Tue, 30 May 2023 11:45:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3491609fso3518467b3a.3
        for <stable@vger.kernel.org>; Tue, 30 May 2023 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685472306; x=1688064306;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LQxSBcpoTcUrMwl8I5y104GnkxObTVedecKsvBNekJc=;
        b=Z0tLE6AtqDYKeUPgqm/rpFO6vLBsdR1F/MSSj+BKitgBQHCsbJoSuasKOaDXADzMPB
         /bBzLo+EBienBU0DvrKvsBE6zBOj2OLqGX0vLmc1zknKqGdNuIXSdOphrno1/tRLpFfG
         aOQbMXFDH92fnteBsuRl+gtzM+FbOKXoQ8kN6RzM+4kvj8F7DlH5b9F1HS4hamXMSbQI
         Lrib7MjbANs3BkwCjuCYPiwlJozQODgwgWLyR7m4DPJVGDrMPD35R8vrpTb0C9cnfctV
         kJ1aznv8H9KRHayl7gsPEdE4/l47B451MJXYsVb1c6q6hsRCb3G3ug6VSSTCmAZGMwac
         LMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472306; x=1688064306;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQxSBcpoTcUrMwl8I5y104GnkxObTVedecKsvBNekJc=;
        b=OkSbPtIBryb3O/5w0C8q6+Cu8Tjs1FQNd/NoQqG8a7H+hCuiPt606ym2cw4YCL/UaX
         ol168r+mKFoAOeXa2qS7fcXCav0L7MwIPE0HhO5zJLC0JjR/vAkEu2tw4pzT47C9k4zS
         GuY/gdqDwOFDSFqvsoF6mYy7gVZPvHB0GafyY3TraHhQxKCxwSeHu8FEDEeMnXXvAqbQ
         HTwzlwJ0w4D/Z/97Rmk9UR87ymTQkeZqZ42Sf+31Z65DcH2iwsA1bb+LR0Hah1ldPl5L
         IOYavEyeCdvBF/XYpOlPWpzR+W3s0jW2mwJ1aII71GcEXVt7RXiMqDGcbd7nuT11gHWw
         Il+w==
X-Gm-Message-State: AC+VfDzFzx9KrFuFJ6bAVCon+t5udAf4AzKbVCVilR1Ze1Xd1YXBl9s6
        6x80xeTRySyyUgJISVvk885h2+PsAb6oyCqXpnWHvQ==
X-Google-Smtp-Source: ACHHUZ71NM69TJ/nrMTIxO8nzPoTmt7IZHXFpmc8jwp8ussaNA20BPIWVBG5xBKNnpkwX1wkS5v1ag==
X-Received: by 2002:a05:6a00:1401:b0:64f:764e:bbd9 with SMTP id l1-20020a056a00140100b0064f764ebbd9mr3458655pfu.3.1685472306625;
        Tue, 30 May 2023 11:45:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bn9-20020a056a00324900b006468222af91sm1969566pfb.48.2023.05.30.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:45:05 -0700 (PDT)
Message-ID: <64764431.050a0220.2925f.4b1e@mx.google.com>
Date:   Tue, 30 May 2023 11:45:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.3.y
X-Kernelci-Tree: stable
X-Kernelci-Kernel: v6.3.5
X-Kernelci-Report-Type: test
Subject: stable/linux-6.3.y baseline: 127 runs, 1 regressions (v6.3.5)
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

stable/linux-6.3.y baseline: 127 runs, 1 regressions (v6.3.5)

Regressions Summary
-------------------

platform        | arch | lab           | compiler | defconfig       | regre=
ssions
----------------+------+---------------+----------+-----------------+------=
------
qemu_mips-malta | mips | lab-collabora | gcc-10   | malta_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/stable/branch/linux-6.3.y/kernel/=
v6.3.5/plan/baseline/

  Test:     baseline
  Tree:     stable
  Branch:   linux-6.3.y
  Describe: v6.3.5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
  SHA:      c297019eca71ec5236ffe916eb37091de041bf23 =



Test Regressions
---------------- =



platform        | arch | lab           | compiler | defconfig       | regre=
ssions
----------------+------+---------------+----------+-----------------+------=
------
qemu_mips-malta | mips | lab-collabora | gcc-10   | malta_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/64760c50190bd297ef2e85f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: malta_defconfig
  Compiler:    gcc-10 (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//stable/linux-6.3.y/v6.3.5/mips=
/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.txt
  HTML log:    https://storage.kernelci.org//stable/linux-6.3.y/v6.3.5/mips=
/malta_defconfig/gcc-10/lab-collabora/baseline-qemu_mips-malta.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/mipsel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64760c50190bd297ef2e8=
5f3
        new failure (last pass: v6.3.4) =

 =20
