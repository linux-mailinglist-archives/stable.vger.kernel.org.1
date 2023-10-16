Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2537CACA0
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjJPO5R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjJPO5Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:57:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46581B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:57:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8759BC433C9;
        Mon, 16 Oct 2023 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468233;
        bh=ia6eR1h14B3P1MGCCW4M2CTPTYfe/86ukYPMbsPjJSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BiIFYW9YqTCUhq4R87FEJuwgZAjTSL+UrCV4xg9+VoHoagkjplGA24FQPz7K8/Ad
         gTigdBwG14u9eRugc9GV7Bjsk5RPfEqzZBHdOeP8CGVIsax1j4l7nz/fwc4sxjsf3M
         QkNDYse2n7ISB0x8YfRqt2Uf8YJTZRssOE+cJIGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 187/191] fs: factor out vfs_parse_monolithic_sep() helper
Date:   Mon, 16 Oct 2023 10:42:52 +0200
Message-ID: <20231016084019.736710009@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit e001d1447cd4585d7f23a44ff668ba2bc624badb ]

Factor out vfs_parse_monolithic_sep() from generic_parse_monolithic(),
so filesystems could use it with a custom option separator callback.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Stable-dep-of: c34706acf40b ("ovl: fix regression in parsing of mount options with escaped comma")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs_context.c            | 34 +++++++++++++++++++++++++++++-----
 include/linux/fs_context.h |  2 ++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a48a69caddce1..896e89acac5c2 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -192,17 +192,19 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 EXPORT_SYMBOL(vfs_parse_fs_string);
 
 /**
- * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * vfs_parse_monolithic_sep - Parse key[=val][,key[=val]]* mount data
  * @fc: The superblock configuration to fill in.
  * @data: The data to parse
+ * @sep: callback for separating next option
  *
- * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
- * called from the ->monolithic_mount_data() fs_context operation.
+ * Parse a blob of data that's in key[=val][,key[=val]]* form with a custom
+ * option separator callback.
  *
  * Returns 0 on success or the error returned by the ->parse_option() fs_context
  * operation on failure.
  */
-int generic_parse_monolithic(struct fs_context *fc, void *data)
+int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
+			     char *(*sep)(char **))
 {
 	char *options = data, *key;
 	int ret = 0;
@@ -214,7 +216,7 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 	if (ret)
 		return ret;
 
-	while ((key = strsep(&options, ",")) != NULL) {
+	while ((key = sep(&options)) != NULL) {
 		if (*key) {
 			size_t v_len = 0;
 			char *value = strchr(key, '=');
@@ -233,6 +235,28 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 
 	return ret;
 }
+EXPORT_SYMBOL(vfs_parse_monolithic_sep);
+
+static char *vfs_parse_comma_sep(char **s)
+{
+	return strsep(s, ",");
+}
+
+/**
+ * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * @fc: The superblock configuration to fill in.
+ * @data: The data to parse
+ *
+ * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
+ * called from the ->monolithic_mount_data() fs_context operation.
+ *
+ * Returns 0 on success or the error returned by the ->parse_option() fs_context
+ * operation on failure.
+ */
+int generic_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, vfs_parse_comma_sep);
+}
 EXPORT_SYMBOL(generic_parse_monolithic);
 
 /**
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index ff6341e09925b..ae556dc8e18fe 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -135,6 +135,8 @@ extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
+int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
+			     char *(*sep)(char **));
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
-- 
2.40.1



