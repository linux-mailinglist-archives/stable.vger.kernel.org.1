Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41A47ECEE5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjKOTpD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbjKOTpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9395119F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B3CC433C7;
        Wed, 15 Nov 2023 19:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077498;
        bh=//GGuPJ9NbNVHfTqhXt98DAVzwfCCHNEYIv9UHwSJ9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kk0bIk7tuylOCTjtaWgi/Eu142u01eT0TOoJeD0lgiIGFmXg+4O3vr7cd2FYRQp9o
         N2uNE8/heiPY2znJyJfKk96UJkRDpkMBI6uX9Xua5dS6/Iiw6PSnEQ5Jvyq2i13MVW
         3AHrtOGpHnljtdSPBUdvwuiV7xWzbnCSbJtHvznk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 339/603] crypto: ccp - Fix ioctl unit tests
Date:   Wed, 15 Nov 2023 14:14:44 -0500
Message-ID: <20231115191636.989706957@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 7f71c3e033824e1da237916a1885e3c0699f86b2 ]

A local environment change was importing ioctl_opt which is required
for ioctl tests to pass.  Add the missing import for it.

Fixes: 15f8aa7bb3e5 ("crypto: ccp - Add unit tests for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/crypto/ccp/test_dbc.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index 998bb3e3cd040..a28a1f94c1d2f 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -4,6 +4,12 @@ import unittest
 import os
 import time
 import glob
+import fcntl
+try:
+    import ioctl_opt as ioctl
+except ImportError:
+    ioctl = None
+    pass
 from dbc import *
 
 # Artificial delay between set commands
@@ -64,13 +70,16 @@ class TestInvalidIoctls(DynamicBoostControlTest):
     def setUp(self) -> None:
         if not os.path.exists(DEVICE_NODE):
             self.skipTest("system is unsupported")
+        if not ioctl:
+            self.skipTest("unable to test IOCTLs without ioctl_opt")
+
         return super().setUp()
 
     def test_invalid_nonce_ioctl(self) -> None:
         """tries to call get_nonce ioctl with invalid data structures"""
 
         # 0x1 (get nonce), and invalid data
-        INVALID1 = IOWR(ord("D"), 0x01, invalid_param)
+        INVALID1 = ioctl.IOWR(ord("D"), 0x01, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID1, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -79,7 +88,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
         """tries to call set_uid ioctl with invalid data structures"""
 
         # 0x2 (set uid), and invalid data
-        INVALID2 = IOW(ord("D"), 0x02, invalid_param)
+        INVALID2 = ioctl.IOW(ord("D"), 0x02, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID2, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -88,7 +97,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
         """tries to call set_uid ioctl with invalid data structures"""
 
         # 0x2 as RW (set uid), and invalid data
-        INVALID3 = IOWR(ord("D"), 0x02, invalid_param)
+        INVALID3 = ioctl.IOWR(ord("D"), 0x02, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID3, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -96,7 +105,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
     def test_invalid_param_ioctl(self) -> None:
         """tries to call param ioctl with invalid data structures"""
         # 0x3 (param), and invalid data
-        INVALID4 = IOWR(ord("D"), 0x03, invalid_param)
+        INVALID4 = ioctl.IOWR(ord("D"), 0x03, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID4, self.data, True)
         self.assertEqual(error.exception.errno, 22)
@@ -104,7 +113,7 @@ class TestInvalidIoctls(DynamicBoostControlTest):
     def test_invalid_call_ioctl(self) -> None:
         """tries to call the DBC ioctl with invalid data structures"""
         # 0x4, and invalid data
-        INVALID5 = IOWR(ord("D"), 0x04, invalid_param)
+        INVALID5 = ioctl.IOWR(ord("D"), 0x04, invalid_param)
         with self.assertRaises(OSError) as error:
             fcntl.ioctl(self.d, INVALID5, self.data, True)
         self.assertEqual(error.exception.errno, 22)
-- 
2.42.0



