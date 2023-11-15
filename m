Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995E67ECEEC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjKOTpI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjKOTpH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:45:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A5A12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:45:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA0CC433C7;
        Wed, 15 Nov 2023 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077502;
        bh=bWVlrabkBliTMLkywmk9T/Yl2KipYYlDZ/gseu9iQJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lt/AhRvLutlolmAswrl0WTZuQ8Ap98kE1RjRS5cW002CzfOiQNi+DEj5eJc8MfDfX
         QZ5lr9GC0sHWjbxycP8SlociUatcsI4rNZ5Bb+LnUzXAvxZV9c5tG/3BKWukIh+is9
         5077s7kUX1JeL0nMh2PnrqMWV430YxC7h3/bx0zA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 342/603] crypto: ccp - Fix some unfused tests
Date:   Wed, 15 Nov 2023 14:14:47 -0500
Message-ID: <20231115191637.186915601@linuxfoundation.org>
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

[ Upstream commit 7b3c2348d314a18f6ed84bab67023ae5d1ec6b1e ]

Some of the tests for unfused parts referenced a named member parameter,
but when the test suite was switched to call a python ctypes library they
weren't updated.  Adjust them to refer to the first argument of the
process_param() call and set the data type of the signature appropriately.

Fixes: 15f8aa7bb3e5 ("crypto: ccp - Add unit tests for dynamic boost control")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/crypto/ccp/test_dbc.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index a28a1f94c1d2f..79de3638a01ab 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -33,8 +33,8 @@ def system_is_secured() -> bool:
 class DynamicBoostControlTest(unittest.TestCase):
     def __init__(self, data) -> None:
         self.d = None
-        self.signature = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
-        self.uid = "1111111111111111"
+        self.signature = b"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"
+        self.uid = b"1111111111111111"
         super().__init__(data)
 
     def setUp(self) -> None:
@@ -192,12 +192,12 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         # SOC power
         soc_power_max = process_param(self.d, PARAM_GET_SOC_PWR_MAX, self.signature)
         soc_power_min = process_param(self.d, PARAM_GET_SOC_PWR_MIN, self.signature)
-        self.assertGreater(soc_power_max.parameter, soc_power_min.parameter)
+        self.assertGreater(soc_power_max[0], soc_power_min[0])
 
         # fmax
         fmax_max = process_param(self.d, PARAM_GET_FMAX_MAX, self.signature)
         fmax_min = process_param(self.d, PARAM_GET_FMAX_MIN, self.signature)
-        self.assertGreater(fmax_max.parameter, fmax_min.parameter)
+        self.assertGreater(fmax_max[0], fmax_min[0])
 
         # cap values
         keys = {
@@ -208,7 +208,7 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         }
         for k in keys:
             result = process_param(self.d, keys[k], self.signature)
-            self.assertGreater(result.parameter, 0)
+            self.assertGreater(result[0], 0)
 
     def test_get_invalid_param(self) -> None:
         """fetch an invalid parameter"""
@@ -226,17 +226,17 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         original = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
 
         # set the fmax
-        target = original.parameter - 100
+        target = original[0] - 100
         process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, target)
         time.sleep(SET_DELAY)
         new = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
-        self.assertEqual(new.parameter, target)
+        self.assertEqual(new[0], target)
 
         # revert back to current
-        process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, original.parameter)
+        process_param(self.d, PARAM_SET_FMAX_CAP, self.signature, original[0])
         time.sleep(SET_DELAY)
         cur = process_param(self.d, PARAM_GET_FMAX_CAP, self.signature)
-        self.assertEqual(cur.parameter, original.parameter)
+        self.assertEqual(cur[0], original[0])
 
     def test_set_power_cap(self) -> None:
         """get/set power cap limit"""
@@ -244,17 +244,17 @@ class TestUnFusedSystem(DynamicBoostControlTest):
         original = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
 
         # set the fmax
-        target = original.parameter - 10
+        target = original[0] - 10
         process_param(self.d, PARAM_SET_PWR_CAP, self.signature, target)
         time.sleep(SET_DELAY)
         new = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
-        self.assertEqual(new.parameter, target)
+        self.assertEqual(new[0], target)
 
         # revert back to current
-        process_param(self.d, PARAM_SET_PWR_CAP, self.signature, original.parameter)
+        process_param(self.d, PARAM_SET_PWR_CAP, self.signature, original[0])
         time.sleep(SET_DELAY)
         cur = process_param(self.d, PARAM_GET_PWR_CAP, self.signature)
-        self.assertEqual(cur.parameter, original.parameter)
+        self.assertEqual(cur[0], original[0])
 
     def test_set_3d_graphics_mode(self) -> None:
         """set/get 3d graphics mode"""
-- 
2.42.0



