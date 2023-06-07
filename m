Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF2726194
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjFGNnl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjFGNnl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 09:43:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F481993
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 06:43:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so33470135e9.0
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686145418; x=1688737418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECUPgTh4S75PbWzTfD97t/Bz+CcbzuB43qUb6+l5WGU=;
        b=Qbc+YhlfNpusMLUnSxKQ1Rm9hwA65e2VrHHeOHHDuKG6bJlVW5fWaZVea6y3EH98XP
         R7z6NloLJKLmTH4sGo4ModV+Wiz7H/briZX7M/o4Mc4F1+APhLhElqfiCn8CohCfZoL+
         TvMe6wgwGJrRQl1Ugp3viGaIdNXF/XSRBOUrMdE3TeBO1NPtNcd8wDZYfm7xKa1tzuNV
         gx6DBJNzNn2wR7uqsAir01HBcL0imdwnGVRNKF+pMWkUg1dWVi/kpiBX0L01q7E5Qma8
         7XqKfTgthYBnZJegky7tlE7PP7z4815CumE8dc26Id7TQCVXj9+jDoUJ7J0Rav+BGJgg
         e9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145418; x=1688737418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECUPgTh4S75PbWzTfD97t/Bz+CcbzuB43qUb6+l5WGU=;
        b=YxfgGLi4XscVcxTebUWa08ogINVzvzDLZ4AwsbnmN9d2fikXttPTb7pk/7lEXbUas+
         36nHREvFL6Ru5RDbV6k+DfhVBXgD1WENA7igGeAsWRrFX7FpLDa1ah70dvr7kn6ql5T9
         7Vk86TCA6xsEA8iDCGwIV4bF/Th1i630CensOTj/FQQyX+QOJFsH2zpI6G4WpxcnZPyc
         5SzAD6a9+mZ5MiWfAaEO/V2XbBqSb0+XQZpwE7vLjmUNO5WTJI7ijHGFNQz7qHbSyCET
         FBPkm0vdBqej4C/YsOPPLTGTXhn+CBnWjMoT+csyJJ3LimPDyqRXba1o5SS9WTneSpAd
         0obQ==
X-Gm-Message-State: AC+VfDwrheVc9F7qRRLjeyrhyFA9aKRsxcVV8819MO+HPhchf4u2xc4g
        1RwDJwAYEdMoLrRI1sBsrXF+TMrD+yk/LI2tnkvTWQ==
X-Google-Smtp-Source: ACHHUZ6DC+xBZTdSH/GctmG07t6l+KfRE4eQUytnNCtk33wrZeduFpYWJhlbtmOUAvKsFkOr2KIHYg==
X-Received: by 2002:a7b:c4d5:0:b0:3f6:7af:8fe7 with SMTP id g21-20020a7bc4d5000000b003f607af8fe7mr4448394wmk.10.1686145417646;
        Wed, 07 Jun 2023 06:43:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f7e717c770sm2201284wmc.23.2023.06.07.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:43:37 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] selftests: mptcp: diag: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 15:43:14 +0200
Message-Id: <20230607134314.2611661-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2023060714-residence-cloud-7288@gregkh>
References: <2023060714-residence-cloud-7288@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1544; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=nAxUDgG7iRhGl1V+OjhQ8dZib3Z5ma2nN3EWauxIvwM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkgIlya3W5GZDK+CpbGmuREmEQ4nEt4auT6umVC
 1YZb5qgW1qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZICJcgAKCRD2t4JPQmmg
 c8o2EADt7HZ8z33qwwlAoo5uZqvVFPOh2W69iYvRUmsQfVGqNucf/XonVCHZMBGUJewBzULB7/g
 MCUdER+2TlirmjnE1y15xghrycD91XC/jxRo4k+0tW7A/bM1GuCkOAAiC3491/A/SxNZyxZuNI6
 Ny+TscuUnttbD7s5qKMRGuGUlxUBPPHqGhzrtkn+8dxHMIU6Rdz8oVyk0PE8SIDILL/ui1rxfCX
 k4nMPgsMdWhZmHTGTjjeTfODi9CAXumck57PP47nof98x7nFdJPE/TOhQmXZeiV0FmXX9C8FxoW
 UabtwLpbeb0KV8SWMmq0OJfePgS3Q7PwjSlXGlNjkxNrnVWUUkEQ34NUnDvSrMqykryy/iW9c/D
 gXyg8fqE+ENifitrfwCt4nTV+9LcUq2aB525DmWHZMPTuZw5RRlct+fw+wOmrH/WB9icaiIurjJ
 QCE1Zz07zvHHVEaCNJ8jJJ5IZns4gEzqnorVA1L3yRvo2UCxRkkWTHIeu20I5qHLfjHQmV2wfZb
 ncGgC2c67OO7MS0N0fMlGzXmNUqIj7eQUw7/ccZVJxg9YqCE4pNzhNsFaG40btbiWqYIrk01RJ0
 3UJudjLRKAQuSfHQsR7xcQ6q/0uzuYl6bMujC2AetSa3yPdUCu1tjW5cuGCwEvSrT/3Lvxlb6fd CvoZsl68gmvse9Q==
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

commit 46565acdd29facbf418a11e4a3791b3c8967308d upstream.

  Backport note: a simple conflict with 787eb1e4df93 ("selftests: mptcp:
  uniform 'rndh' variable") where a new line was added for something
  else in the same context.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 515859a5168b..dd730a35bd12 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
@@ -25,6 +27,8 @@ cleanup()
 	ip netns del $ns
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
-- 
2.39.2

