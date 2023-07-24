Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAA75F590
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGXL75 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGXL75 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 07:59:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D98E73
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 04:59:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8c81e36c0so24724735ad.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690199993; x=1690804793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X55qGfqurl3+XzYFon6Kd/dPBcYz+Gt8vVZUhYCD/tQ=;
        b=SDBA6F00URpdW3puFO3jwwMjviozAodRBlokOloGNzrtbnpRtLLvKSQp6zJnC6ON/7
         JHI7HoB5K3AJvUCMHXSjTP61mbsPzFhzqUVr/EpTvA9l2NDFtRbqnIrs7Fh4wp6T3IXG
         m1nyoQnspezkZI2hElKLDpLPZEIM1UXo0BF7qpS2H/h9atb2qjk1RLZ+qhsut/nkOI9R
         6ZS5hpBQxzOxnTb0tXhSdnAYSw/uyLuWieWZ5UhuQXR+vZVJG2Wyk9vN869Uo1AATWq0
         FsGDx7y8XHDRgeP2X3p/qee4GyVJkjNdUPJdjMYtRpka34HXklOl1wtJVMTz1mzZwu5J
         v8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690199993; x=1690804793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X55qGfqurl3+XzYFon6Kd/dPBcYz+Gt8vVZUhYCD/tQ=;
        b=UM9REH7VdfrNlX0DqqJZqZzP8cdTzM1JY6J44Qtz22Bfw28PAHvOtpQL7GopaX5Rtp
         Pd6RAMcM84jbBTzvY9/yPpTuh739R73R79J8TEqWa/9NF+e3MD6DoJcpJ4ZWX2nRGAbv
         hxg9f1U0QA+M6ptn73QAR2rTJuJLuU4RMV0GDA8JAaXLxC7SZL9NPd5Ki4rQq7DZ84jZ
         +I0/JJpEUTlYEqV1CVMZH6AF+aj10Lye1tUQCU38hh0SFwcXvjsnrMnpRMoGDraALpvo
         XH0Nlikan0LMv6qLmGB8aZg1sQRDUY8tBFwEK8rodmvq/dWEM6NpAZruB/2C7P9TaXvM
         MdMA==
X-Gm-Message-State: ABy/qLb7TMiZbWplkGUWl5acLZ7jYmso/DfPSn3h1OKnQF+yaYD8d9ZL
        tSyIdiy/IKJaLdtPISTrGa+Ojr93zD+JdlH9DlV12jM3
X-Google-Smtp-Source: APBJJlEBKzaZkHD2EDMiP8xstIqcXAriq+CByAol7pSj6N3VImPZeJPpVrTsQKWlI5jM/zWHW8z8QA==
X-Received: by 2002:a17:902:e5ce:b0:1b8:b841:3ff2 with SMTP id u14-20020a170902e5ce00b001b8b8413ff2mr10409250plf.64.1690199993666;
        Mon, 24 Jul 2023 04:59:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001bb3dac1577sm8733360plj.95.2023.07.24.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:59:53 -0700 (PDT)
Message-ID: <64be67b9.170a0220.4d9ec.ed06@mx.google.com>
Date:   Mon, 24 Jul 2023 04:59:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.249-315-g2b5f78e632440
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.4.y build: 1 build: 0 failed, 1 passed,
 2 warnings (v5.4.249-315-g2b5f78e632440)
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

stable-rc/linux-5.4.y build: 1 build: 0 failed, 1 passed, 2 warnings (v5.4.=
249-315-g2b5f78e632440)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.249-315-g2b5f78e632440/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.249-315-g2b5f78e632440
Git Commit: 2b5f78e63244061899701db2e38e46a3a7f83be6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 1 unique architecture

Warnings Detected:

i386:
    allnoconfig (gcc-10): 2 warnings


Warnings summary:

    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section =
mismatches

Warnings:
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>
