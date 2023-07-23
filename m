Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15C75E467
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGWTKD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGWTKB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 15:10:01 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0172B10F5
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 12:09:25 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bb5c259b44so362923fac.1
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690139360; x=1690744160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DHb5wC3Gi/tZy6VY9Igt/r/q9oog7sAzGvPvDM01WL4=;
        b=Poy75hprVxAAoLHBiGjaZiB0IawqACNI701CyEKV0Gi9GwhROGzkUIGrMDU9wyAyz9
         tGIpeUdRp6Newlyjjqpwn8sq400R907NjzMVJwmBWLaAI5a8YAZ6ZQONQrvdxo6tqHDq
         bbmmoDh0PyHc7CXUhs75L4I4HJT/ihKx20SO9HZCermsrZ8cgePl9EWv+dnhV/Egko4J
         O8UoYdUU8VddvnwUXNONoRUELBBphjHCGGH/d9z3QbKUTUxUlmntvb8/3J44f54JfG25
         IYzW8VWe+ghglssOYqX5lmwcNJ0Ftr48bHhOQabEKs3cvBnUCvrmJM3CLK61CwIhCYsJ
         nVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139360; x=1690744160;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHb5wC3Gi/tZy6VY9Igt/r/q9oog7sAzGvPvDM01WL4=;
        b=B/++9lAxPn7asoSdkoWEsRF9vwfHH6K2PzJYUkg6O/38dChgjvc/Gvi7jBb4EPYU/A
         L+RUMt4dH3GpcGbTRg49aQ1LZa4OK7FFaO6BRMXJrjagIEZRFy/UfZWVY6sbf0GsTUNh
         sfM4htsTpipFCyY8JuW8QTvlf/kUs9Z3RM3GbH/pb0LpAAdCxn/birTmEig+aeS4ZfWo
         +cUW6qCQFajgX8K5cEicJlAePUy/VI0jML6Ew2Uxf1honK/M+7KGaVkWbY2gVpJ8XCOp
         07qSZ2WDbWw3rM8GMZ4bugZEOWNJ7N9S9XM1xUF9AkduSknCYk8/4ZVkgcM5StLJuNXO
         64wQ==
X-Gm-Message-State: ABy/qLYJl+FUPwOOdII58wQyGWnqGkx7msCsmhz4j+Z6IfYt25e7K4/1
        aFtGI0HevqzFZtbb4bXe8KEnujdj1qysx9YTcNw=
X-Google-Smtp-Source: APBJJlG28VJ3N/pBdCsImESxoWTHnXyMVCmJ348PGLVFzZ2vqvyAEcfnCm+QsCeDNGbWHXESW16aKg==
X-Received: by 2002:a05:6870:a909:b0:1b7:8d3a:61ff with SMTP id eq9-20020a056870a90900b001b78d3a61ffmr9007201oab.58.1690139360278;
        Sun, 23 Jul 2023 12:09:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ey3-20020a056a0038c300b0064398fe3451sm6208905pfb.217.2023.07.23.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:09:19 -0700 (PDT)
Message-ID: <64bd7adf.050a0220.2d3f9.a91f@mx.google.com>
Date:   Sun, 23 Jul 2023 12:09:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-5.4.y
X-Kernelci-Kernel: v5.4.249-285-gd74fb12845b76
X-Kernelci-Report-Type: build
Subject: stable-rc/linux-5.4.y build: 1 build: 0 failed,
 1 passed (v5.4.249-285-gd74fb12845b76)
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

stable-rc/linux-5.4.y build: 1 build: 0 failed, 1 passed (v5.4.249-285-gd74=
fb12845b76)

Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-5.4.y=
/kernel/v5.4.249-285-gd74fb12845b76/

Tree: stable-rc
Branch: linux-5.4.y
Git Describe: v5.4.249-285-gd74fb12845b76
Git Commit: d74fb12845b76b4fac9a88483faa739a2dc294e7
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git
Built: 1 unique architecture

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---
For more info write to <info@kernelci.org>
