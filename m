Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269776018F
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGXVx0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 17:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGXVx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 17:53:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C0194
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 14:53:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9c368f4b5so38177685ad.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690235604; x=1690840404;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/GVqk7k3ZlSv6/psRuJ4dI6kWUPtI0HcYJZYi3j3KWg=;
        b=W6sI29MfqvkDazRTBgJXGUlm1xZ7qvjPlCNr1SrU/gJFCBiw09Z2DFRwikT69yQKrK
         84DpuWwoBTFH1BzRrpqjCEI4FebLCm9h3FhgDE0jKa0f+PiPzDnNi+GW69OPLz1NbwfR
         mbbZ2dqPtcsE9x3B6bmHJbpjRCsM/rGX0jSjvpDdieQSFLIO3x8ZBUnTrRyEYrtvFLTe
         d8tDh6jCFKdslatfnij0CHyqcSssduCF3OWjoGjeMACi6g6avp9/1bEodOyDoqN3CVsZ
         J3CYSOrJx+E7Ha+mJD5FrN0v0va0wRm8cXkYkKR9+/dfaId387XLMGprH3VluBSlVBmn
         j03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235604; x=1690840404;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GVqk7k3ZlSv6/psRuJ4dI6kWUPtI0HcYJZYi3j3KWg=;
        b=NJwpiUcnp/W206HwPStDInTHne0LblaUJ1Y7nUHRjBcSQZFRFuJUG8ZTwdLBELgDjm
         jPkTp/VoIvJkE5zDI8ahs72hEk2HdKR1rsQFfLwEtlGBHHMHyXcAdRygfZEyCWMw2Jw3
         c8cFW3JU9qrZbvm1zHL+urzhESNcuxoEDCatb3FDleb4JvQcqLCKnL72nHVakZMrn9rC
         3LZtIKw82jnvtVNYTemcdCR4KYjRqG+5H2n3dwRggl1bRscVcA4GJfBD3bOkGf/DEZKD
         AWC66mjtPnlLVTAdnQf7XYwJhgbb/ohAZt0yXX8mwnehMdLTCuRAQHBV9XCtnyJ1GJD5
         X2TQ==
X-Gm-Message-State: ABy/qLZO1Hz8LXK8VqOh7h6H/sSS3BembzQsIKV+uFy7MxNv4nlktqmh
        i5Izvwevh5dwprbASNrlD0XiF22oVC8TFZedJm50D/Vl
X-Google-Smtp-Source: APBJJlFwDG3NDi94SfXz+oO4gzhxpveAJHoBYoIdDA94HcZ+hm3KFA+xNh0x+o3WX6kdOOIMd8PcFw==
X-Received: by 2002:a17:902:dad2:b0:1ba:fe6a:3845 with SMTP id q18-20020a170902dad200b001bafe6a3845mr707530plx.11.1690235603820;
        Mon, 24 Jul 2023 14:53:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001b9de67285dsm9480930plh.156.2023.07.24.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:53:23 -0700 (PDT)
Message-ID: <64bef2d3.170a0220.5c787.0fbe@mx.google.com>
Date:   Mon, 24 Jul 2023 14:53:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.250
X-Kernelci-Report-Type: build
Subject: stable/linux-5.4.y build: 1 build: 0 failed, 1 passed,
 2 warnings (v5.4.250)
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

stable/linux-5.4.y build: 1 build: 0 failed, 1 passed, 2 warnings (v5.4.250)

Full Build Summary: https://kernelci.org/build/stable/branch/linux-5.4.y/ke=
rnel/v5.4.250/

Tree: stable
Branch: linux-5.4.y
Git Describe: v5.4.250
Git Commit: 27745d94abe1036a3423cb8577b665c01725e321
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e.git
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
