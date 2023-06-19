Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B1A73524E
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjFSKdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFSKdY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FFC6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D279C60B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB2C433C8;
        Mon, 19 Jun 2023 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170802;
        bh=7E2zN5wOxQMVNkWEJ3ZmsKlKUOT5ZHnKm+Nl0rmX0JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GibAisl/oTOUSdavoWyyw/97jcQJuoTsmb4YNoYkZbnQcZqdx13LEglgWBNkMQYI1
         jU1HvCh+eSHeRBeqijt/a4ohuf1GIKltw7IPxZiIeDmIZ3Rl2uRKSWZADQAEuU9d1w
         pcAtUoRA33AyF5N1FVOeDBbQB8lGNtvpcsJ99nDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 015/187] selftests: gpio: gpio-sim: Fix BUG: test FAILED due to recent change
Date:   Mon, 19 Jun 2023 12:27:13 +0200
Message-ID: <20230619102158.337393995@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ Upstream commit 976d3c6778e99390c6d854d140b746d12ea18a51 ]

According to Mirsad the gpio-sim.sh test appears to FAIL in a wrong way
due to missing initialisation of shell variables:

 4.2. Bias settings work correctly
 cat: /sys/devices/platform/gpio-sim.0/gpiochip18/sim_gpio0/value: No such file or directory
 ./gpio-sim.sh: line 393: test: =: unary operator expected
 bias setting does not work
 GPIO gpio-sim test FAIL

After this change the test passed:

 4.2. Bias settings work correctly
 GPIO gpio-sim test PASS

His testing environment is AlmaLinux 8.7 on Lenovo desktop box with
the latest Linux kernel based on v6.2:

  Linux 6.2.0-mglru-kmlk-andy-09238-gd2980d8d8265 x86_64

Suggested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/gpio/gpio-sim.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index 9f539d454ee4d..fa2ce2b9dd5fc 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -389,6 +389,9 @@ create_chip chip
 create_bank chip bank
 set_num_lines chip bank 8
 enable_chip chip
+DEVNAME=`configfs_dev_name chip`
+CHIPNAME=`configfs_chip_name chip bank`
+SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
 test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
 remove_chip chip
-- 
2.39.2



