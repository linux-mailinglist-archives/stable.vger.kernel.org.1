Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F7713C7C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjE1TPa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjE1TP3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A448D2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F1E46198E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1B3C433EF;
        Sun, 28 May 2023 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301327;
        bh=2MoMWExnZSUBjyiAeqQHwxYdgC6498XHvZRNTygb2Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEdaiNRc78ouL4Nuaj58pVV+d4szn9gFpvfXJ6sEqtq9LZqODdFnH0bA2koM5gt4w
         vyiM1cY9zg6Anz+wJNrMuXSCPSbKq01NzJhcRf1Io8wh4DII0qdO3naHy6dD7v9aXE
         lD2IhCgqCwGCfzmwI1vTZPqsKXLIEKI6xbCh4jVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hardik Garg <hargar@linux.microsoft.com>,
        "Tyler Hicks (Microsoft)" <code@tyhicks.com>
Subject: [PATCH 4.14 72/86] selftests/memfd: Fix unknown type name build failure
Date:   Sun, 28 May 2023 20:10:46 +0100
Message-Id: <20230528190831.316183924@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hardik Garg <hargar@linux.microsoft.com>

Partially backport v6.3 commit 11f75a01448f ("selftests/memfd: add tests
for MFD_NOEXEC_SEAL MFD_EXEC") to fix an unknown type name build error.
In some systems, the __u64 typedef is not present due to differences in
system headers, causing compilation errors like this one:

fuse_test.c:64:8: error: unknown type name '__u64'
   64 | static __u64 mfd_assert_get_seals(int fd)

This header includes the  __u64 typedef which increases the likelihood
of successful compilation on a wider variety of systems.

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
Reviewed-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/memfd/fuse_test.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -22,6 +22,7 @@
 #include <linux/falloc.h>
 #include <linux/fcntl.h>
 #include <linux/memfd.h>
+#include <linux/types.h>
 #include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>


