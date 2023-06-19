Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5D735492
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjFSK5Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjFSK44 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0DF2686
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BBFA60A05
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A9C433C8;
        Mon, 19 Jun 2023 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172100;
        bh=PwwsNaULNkh6X2ZrNOC4GconFN3+nu1WjyxpO2ZtWow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrJVIJbA0OYLtOQy8U88WB+Bmk/4EzRAGnyA9FyDOXzuHk4N2iH0Z/wmog0QQNgnv
         QNUYONXvXTzXrIHpo4AV8KDQ6loZqz3Qa5nsolNlmpKLm5lTcj/yQlB3Yrvbx/eqhf
         bct7ZnIoqw3ZyGWxXgcGMqnOD3A256BL1QyN9Dc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 01/89] lib: cleanup kstrto*() usage
Date:   Mon, 19 Jun 2023 12:29:49 +0200
Message-ID: <20230619102138.345102019@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 506dfc9906e5cbf453bbcd5eb627689435583558 ]

Use proper conversion functions.  kstrto*() variants exist for all
standard types.

Link: https://lkml.kernel.org/r/20201122123410.GB92364@localhost.localdomain
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 4acfe3dfde68 ("test_firmware: prevent race conditions by a correct implementation of locking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c |  9 +++------
 lib/test_kmod.c     | 26 ++++++++++----------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 581ee3fcdd5c2..3edbc17d92db5 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -371,18 +371,15 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
 
 static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
+	u8 val;
 	int ret;
-	long new;
 
-	ret = kstrtol(buf, 10, &new);
+	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new > U8_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_fw_mutex);
-	*(u8 *)cfg = new;
+	*(u8 *)cfg = val;
 	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index c637f6b5053a9..c282728de3af0 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -877,20 +877,17 @@ static int test_dev_config_update_uint_sync(struct kmod_test_device *test_dev,
 					    int (*test_sync)(struct kmod_test_device *test_dev))
 {
 	int ret;
-	unsigned long new;
+	unsigned int val;
 	unsigned int old_val;
 
-	ret = kstrtoul(buf, 10, &new);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new > UINT_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_dev->config_mutex);
 
 	old_val = *config;
-	*(unsigned int *)config = new;
+	*(unsigned int *)config = val;
 
 	ret = test_sync(test_dev);
 	if (ret) {
@@ -914,18 +911,18 @@ static int test_dev_config_update_uint_range(struct kmod_test_device *test_dev,
 					     unsigned int min,
 					     unsigned int max)
 {
+	unsigned int val;
 	int ret;
-	unsigned long new;
 
-	ret = kstrtoul(buf, 10, &new);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new < min || new > max)
+	if (val < min || val > max)
 		return -EINVAL;
 
 	mutex_lock(&test_dev->config_mutex);
-	*config = new;
+	*config = val;
 	mutex_unlock(&test_dev->config_mutex);
 
 	/* Always return full write size even if we didn't consume all */
@@ -936,18 +933,15 @@ static int test_dev_config_update_int(struct kmod_test_device *test_dev,
 				      const char *buf, size_t size,
 				      int *config)
 {
+	int val;
 	int ret;
-	long new;
 
-	ret = kstrtol(buf, 10, &new);
+	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new < INT_MIN || new > INT_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_dev->config_mutex);
-	*config = new;
+	*config = val;
 	mutex_unlock(&test_dev->config_mutex);
 	/* Always return full write size even if we didn't consume all */
 	return size;
-- 
2.39.2



