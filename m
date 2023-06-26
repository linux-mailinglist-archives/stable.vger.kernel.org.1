Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9992C73E8BA
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFZS3A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjFZS2q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:28:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812212969
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D63860F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166ACC433C8;
        Mon, 26 Jun 2023 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804086;
        bh=cGw9QHCVuDwSqJtvv4C0gVXI19jHMBQvtscjn1aNeiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IdtVpo5xsndz3WsPqZwWX7RwYKg9+znXbzGJFzkgfgO44RICg1MKDYPD+zKCpVvDX
         pLwbOp+ks4cYNP/mC1+oD+xIK3+oosH4sAI9CEs5vLD6YlzG2pdfIgnPGe+m+ETzdk
         H0iUKJyTrNnsT8j3vbIhktMpLZFB3XRlynWgGEng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>,
        Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH 6.1 036/170] selftests/mount_setattr: fix redefine struct mount_attr build error
Date:   Mon, 26 Jun 2023 20:10:05 +0200
Message-ID: <20230626180802.169046876@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>

commit d8e45bf1aed2e5fddd8985b5bb1aaf774a97aba8 upstream.

Fix the following build error due to redefining struct mount_attr by
removing duplicate define from mount_setattr_test.c

gcc -g -isystem .../tools/testing/selftests/../../../usr/include -Wall -O2 -pthread     mount_setattr_test.c  -o .../tools/testing/selftests/mount_setattr/mount_setattr_test
mount_setattr_test.c:107:8: error: redefinition of ‘struct mount_attr’
  107 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
                 from mount_setattr_test.c:10:
.../usr/include/linux/mount.h:129:8: note: originally defined here
  129 | struct mount_attr {
      |        ^~~~~~~~~~
make: *** [../lib.mk:145: .../tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: Hardik Garg <hargar@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -104,13 +104,6 @@
 	#else
 		#define __NR_mount_setattr 442
 	#endif
-
-struct mount_attr {
-	__u64 attr_set;
-	__u64 attr_clr;
-	__u64 propagation;
-	__u64 userns_fd;
-};
 #endif
 
 #ifndef __NR_open_tree


