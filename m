Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0303A7B88EC
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbjJDSU7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbjJDSU7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:20:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7D98
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:20:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F5DC433C8;
        Wed,  4 Oct 2023 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443656;
        bh=hMCRyYnux5tRpLIiu4cDzdnfDopQyeSlantIUFJ9Az8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3nEftNkQG9Hb7AGlT7wFpOiCB5ZTEpaFbxhj+MjChyo8C3OHNRFYhyvH1HKbGpbX
         Y0xai8/XrYXMWyG9xp5Qsc4SJ2T11VTP1ffFr+b8ifulSpcNFM1m0J/UsTNn2Xov/s
         o0fctJ5gc7cMR7jkKHd46lvlGBXnSWiXw0AZGHoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>
Subject: [PATCH 6.1 234/259] drm/tests: Fix incorrect argument in drm_test_mm_insert_range
Date:   Wed,  4 Oct 2023 19:56:47 +0200
Message-ID: <20231004175228.109836365@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

commit 2ba157983974ae1b6aaef7d4953812020d6f1eb5 upstream.

While drm_mm test was converted form igt selftest to kunit, unexpected
value of "end" argument equal "start" was introduced to one of calls to a
function that executes the drm_test_mm_insert_range for specific start/end
pair of arguments.  As a consequence, DRM_MM_BUG_ON(end <= start) is
triggered.  Fix it by restoring the original value.

Fixes: fc8d29e298cf ("drm: selftest: convert drm_mm selftest to KUnit")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: "Maíra Canal" <mairacanal@riseup.net>
Cc: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: stable@vger.kernel.org # v6.1+
Reviewed-by: Maíra Canal <mairacanal@riseup.net>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20230911130323.7037-2-janusz.krzysztofik@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tests/drm_mm_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 186b28dc7038..05d5e7af6d25 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -939,7 +939,7 @@ static void drm_test_mm_insert_range(struct kunit *test)
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert_range(test, count, size, 0, max - 1));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert_range(test, count, size, 0, max / 2));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert_range(test, count, size,
-								    max / 2, max / 2));
+								    max / 2, max));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert_range(test, count, size,
 								    max / 4 + 1, 3 * max / 4 - 1));
 
-- 
2.42.0



