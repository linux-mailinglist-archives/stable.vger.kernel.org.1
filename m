Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1178A224
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 23:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjH0V6X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjH0V5x (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 17:57:53 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E39124
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 14:57:48 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34cc8e8cbd4so8108215ab.0
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693173467; x=1693778267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMLyT+uZwYb4Deta17XMTPAVJ7dCE9N9HyBB8/EDtN8=;
        b=wBMOSUUs9xF3PVGUmoVRyMRXL8VFPR6zsl0Eff0da4ImM8InJzsyvNwJMLypNeAwEK
         23kWGuVo/y2LG0dVyyiNG0wrMYXevKy5YOtIBBOvf40XDwao6TNKIZhRlmWsOrz5zoA4
         bRbdFrx79sNawzdu1ZCLfcvCKVHDONZL35o/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693173467; x=1693778267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMLyT+uZwYb4Deta17XMTPAVJ7dCE9N9HyBB8/EDtN8=;
        b=UZvpfqyXlhGdRrIx75ZXBSbtohwMv0SCiUNff6xz/AqCPC1BkysoWEJXpC90AYWJXk
         OIDRpcsteJKJZ8PdOuwB5DmYEJ2CsU+wyaEAXv11/5ZCCJeoujqzHRXeyP+UqGKQlx7f
         ENFVUOFJsL2q7JEeCVT7dxp654+WqD2iuR7KBBjXuVTATmMxeRHHQGukokkCTteMm0MM
         EaCk9Gko6IgN8VKQCTbKqKDcm0N4rk9M8TH+kHfcHOYBpoMrzE+2AFsDWNH3FyrhUqG9
         nQsTn/WL+7FvQ9sEYl/itG295we+p9/9IBGoZ1S0sNfB1HkIG/qjdE03mszDAb7QGvdu
         DLxw==
X-Gm-Message-State: AOJu0YxmigL7Fh8BI50oEVWuZ/rxO8au8cvPZBy7z0zXakbXYArOG7VU
        xJUOjqH27BrtJ64CN8zbuFT/K3WEar74GgeyjZA=
X-Google-Smtp-Source: AGHT+IEEjxh4GT5vEG0rUWZyQ66spPnr+ZYJKNPTafYEmf0NGvM7lZHG6N9E0BM7FIIVhHSidzxkwA==
X-Received: by 2002:a05:6e02:12e2:b0:34c:ecc8:98e0 with SMTP id l2-20020a056e0212e200b0034cecc898e0mr4228111iln.11.1693173467084;
        Sun, 27 Aug 2023 14:57:47 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id bp7-20020a056e02348700b0034ce78e2450sm1304854ilb.39.2023.08.27.14.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 14:57:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.15 1/2] torture: Avoid torture-test reboot loops
Date:   Sun, 27 Aug 2023 21:57:39 +0000
Message-ID: <20230827215741.246948-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 10f84c2cfb5045e37d78cb5d4c8e8321e06ae18f ]

Currently, the various torture tests sometimes react to an early-boot
bug by rebooting.  This is almost always counterproductive, needlessly
consuming CPU time and bloating the console log.  This commit therefore
adds the "-no-reboot" argument to qemu so that reboot requests will
cause qemu to exit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index f4c8055dbf7a..c57be9563214 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -9,9 +9,10 @@
 #
 # Usage: kvm-test-1-run.sh config resdir seconds qemu-args boot_args_in
 #
-# qemu-args defaults to "-enable-kvm -nographic", along with arguments
-#			specifying the number of CPUs and other options
-#			generated from the underlying CPU architecture.
+# qemu-args defaults to "-enable-kvm -nographic -no-reboot", along with
+#			arguments specifying the number of CPUs and
+#			other options generated from the underlying
+#			CPU architecture.
 # boot_args_in defaults to value returned by the per_version_boot_params
 #			shell function.
 #
@@ -141,7 +142,7 @@ then
 fi
 
 # Generate -smp qemu argument.
-qemu_args="-enable-kvm -nographic $qemu_args"
+qemu_args="-enable-kvm -nographic -no-reboot $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
 cpu_count=`configfrag_boot_cpus "$boot_args_in" "$config_template" "$cpu_count"`
 if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
-- 
2.42.0.rc1.204.g551eb34607-goog

