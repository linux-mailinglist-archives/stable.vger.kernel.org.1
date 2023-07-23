Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61775E24A
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGWOGy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGWOGy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:06:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB52A12B
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:06:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so2235945ad.1
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690121211; x=1690726011;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/z6SXHielA2i6fiAa6TWNgMAq5blz/tSPiWT/mrgkL4=;
        b=leqj8kBd2chMEM13dgnuiyZ+ayEF5JQT/MInaDMPxpi8FcQHJhX5oM1sVQdXAmTyf2
         kdKx3rZiCyxcjqc9ccvhYXdn4elhGq6AelMFeZI6yMKat0kBP3Geo7PkCNGtUOAJK3jM
         g5jJPqWLxEECtT//+pdJggmPYUJ8+no8Kmr3b0TzURrDkqxSDB7vEAQUBLu/eHGNiqsg
         9QjvJMPr7Jwyg+EERvoCaxzD35lHHtGPxfEwJX9tmRGHEIiAsOKtt9SHWydTN52M8LRX
         6GkL1BQ1E66cumfWnema4PuFjRSUKGBXTXZHT3Xz7RZ/EyrJPwea8ylJsQ2jrG1Y/mr6
         JLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121211; x=1690726011;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z6SXHielA2i6fiAa6TWNgMAq5blz/tSPiWT/mrgkL4=;
        b=N1bWlWw4jcciLjSWFZIKB78kgk/wkn/oIz6UR49w8QZKmSB8Lqi8lf/aNTFIxguvjA
         N7ylGe3rqD7B8rtu6JXPtoXvNOWgCsRSc0OlNb2BTeuPx02a/yqcbmWkp4nkduKAA7zC
         X2GTVXj8ZQFfQ7OkBxiM7VelXpTo7GSfyNVat+nQug4IjWdnySE9LBkV/1/kBrbFxZFd
         KCCa5sX4ZZkwXU4ZpGnNjiCGg15BkHBnf41VkBXeB87xsXpj7bEvB2TyH3gJf+xn6FSp
         g2leDcIJMJYTkypScXVHxvwRtQ6M66i/3VEokxOCG/AM8pVgakGOdx+NStGqaGTrlw1T
         EYXA==
X-Gm-Message-State: ABy/qLb4BS/nsBcwW4t9joyTPOfju318t42IJCRyg6m7+Hl34fnnJUV9
        GNlztN3+x73vxFDokybcWjbOmo9EFhLSBXwmt+U=
X-Google-Smtp-Source: APBJJlGVdoDuc1wvdu49ZAhU3GD5G5LF5xUZ8MTEYbwGflQNy84XeWeXZFOx8KJC09riRX0SHN2o+g==
X-Received: by 2002:a17:902:dac9:b0:1b7:ffb9:ea85 with SMTP id q9-20020a170902dac900b001b7ffb9ea85mr9789695plx.29.1690121210810;
        Sun, 23 Jul 2023 07:06:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709027d9400b001a5fccab02dsm6913152plm.177.2023.07.23.07.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:06:50 -0700 (PDT)
Message-ID: <64bd33fa.170a0220.4869c.bff3@mx.google.com>
Date:   Sun, 23 Jul 2023 07:06:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-6.1.y
X-Kernelci-Kernel: v6.1.40
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-6.1.y build: 2 builds: 0 failed, 2 passed (v6.1.40)
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

stable-rc/linux-6.1.y build: 2 builds: 0 failed, 2 passed (v6.1.40)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-6.1.y=
/kernel/v6.1.40/

Tree: stable-rc
Branch: linux-6.1.y
Git Describe: v6.1.40
Git Commit: 75389113731bb629fa5e971baf58e422414c8d23
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 2 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
rv32_defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---
For more info write to <info@kernelci.org>
