Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED8E7264DD
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 17:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjFGPlC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjFGPk6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 11:40:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9553A83
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 08:40:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso32518105e9.3
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686152455; x=1688744455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHmfMqEg5O0zrn9WqxbGp0dkGF5vLf/uuBTBN6307N4=;
        b=OV0aW3jy1CYMDQE9yTgTZTwGyEFvPhVRoTbl8bdum2St1rciPnVuRCztLZVMHWOgSU
         oK2ZrelP4ZM9xC4FO41KnvAvqCOyKFJ0EQPgqCulD3UNxvPXsUJ9v5Qw2CiAv2KlvY0A
         AMUuzN6LeRXFUBMHQuk23Bz209GLIaDFyBtx0O0ez0x5oLod2O4lqkcCCFpTq0CawpVM
         DJwFiMS8L+SFe+gQ6wqaWvPxFNEnv0UI0GLfpkSely6RML3457RRoZCXyuiBjw0fhujs
         Fmm5JhtQLjLP1l+wvghTSNyu4tf8zCnipDl7NbJpQBa2+1ZCH5n2hAEAby2v/RzwSJ7l
         ioVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152455; x=1688744455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHmfMqEg5O0zrn9WqxbGp0dkGF5vLf/uuBTBN6307N4=;
        b=PJXizUuvOlus6HfZiJzg+6OTMkOHt6f7YTik0/AbWJCekqH/oXKGDFA39gKJunsgJJ
         fo26BUQgRZpUo+C2YaXx2KROL0BKP31+croQVxzmeoM4QaUkDnYr/KPYtbQrZa2frFkk
         VxVYwoA4r6YNwB/yNj9JF28Eo9rK+GNhBWavsTYaS/y+QLVYr88rXx0e5j7+5eyg7/FR
         rIt+Apnr3u1E5WDozn1Fjq+4QJKfgOqHMdxCi+TVB79MlsZzWafAGZ6IMSM/qGfbGKT6
         Y8BjDI0NGPnjfsCWn123vVjlgK5BJBqTTuwa9zk9Q9uZisdZj8zG/znGB1f7W0RgLFsd
         A7nQ==
X-Gm-Message-State: AC+VfDyZuUN6nt8SKuRx27LODkuGutKjjWHwH+t8PWExHsBeDamX9NAo
        dBx2U1jNHQB7EjhqX+FVhoq512M+XpHb9XuCdsG3zQ==
X-Google-Smtp-Source: ACHHUZ4oBFO4gv8hFgZYgs8i6U98h3lRQ15akYHzeCjQK+Ffc809V9TT9bxAJ42x7/N9LrZmTJIaKg==
X-Received: by 2002:a7b:c3ce:0:b0:3f7:e65f:7af2 with SMTP id t14-20020a7bc3ce000000b003f7e65f7af2mr4773705wmj.39.1686152454777;
        Wed, 07 Jun 2023 08:40:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bcbd3000000b003f7310a3ffasm2562293wmi.2.2023.06.07.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:40:54 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] selftests: mptcp: join: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 17:40:35 +0200
Message-Id: <20230607154035.2686901-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060734-humility-stifle-f748@gregkh>
References: <2023060734-humility-stifle-f748@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=tXqe4pn41rLXa8yj4/Q9fwkiRzdo2D4ZE2z8Tm/HrVU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgKTzcA2I/Yqvj9AwtWtzFTd8jpef8OQaJWo0o
 xPCiW5LlNqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICk8wAKCRD2t4JPQmmg
 c35VD/9gRCXxVVv0YaKFRe0f6jbalnH/C9gwgPBMr4hXD4IuERybSCJSWPvMTJIhBqGwi4juX6o
 icZfdQHmvfDpl2ALgul4aMbkprXNsNu5Qo9HwjWPUFi09D3rjixU499lMUr2Yi8t5Fjl506HwoR
 egrWqMSo0+ffMGrh97aXKleoaYhANSwaaUIJmPLVhS025c9d6oJklShuwxskjww0lUh/LQVoqj0
 qk0RIPNA9lJP/GwgCyu+XW8Ow03RO544mfFmC4aIGMGo7HbE26+b+8SIKCSWyqh9euyKN6VixqY
 bWIG89rnzskDi+L2GXCX8Ilrn95iAzK7yI+KSdmvPXYBBAic4EV50KvEzcyuHod2aW4E+KW/yZg
 8sEV+AWDwlBGwNSqaapse0RlOtsiEWpjZmuzwQiMVBgMxdRm2kB4JTwr90cGGrQBJK47SqO1Vc/
 2VE/F3vXp4BqGsfV8Pj44xACUUsCS54kcWlb/XvCH6G77rzj0sN+SqDZ23VYtM2n1JTI0DLoJFz
 mzlaGtYPIunIwWH2H39suW5vMYzmJn1n1Jm6EuFJbMvnFFDeRxstqm85koh+3bAKJzV37Y37Gsb
 hPQvY7XQqRgmO1+0794a5yZK57GvtFgS2A1DX2LMx5LOGpP4ErPJM1Mw/kny1YVXK7H+8VPyopO Pc+2sHsouawfXWg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 715c78a82e00f848f99ef76e6f6b89216ccba268 upstream.

  Backport note: a simple conflict with 87154755d90e ("selftests: mptcp:
  join: check for tools only if needed") where the context attached to
  the new line we want to add has been moved to a dedicated function.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 96a090e7f47e..7330e32bb9ab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sinfail=""
@@ -161,6 +163,8 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

