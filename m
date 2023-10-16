Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54CD7CACA1
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJPO5T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjJPO5T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:57:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA0CAB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:57:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36098C433C7;
        Mon, 16 Oct 2023 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468237;
        bh=FT4ee56z2WRbANIU6kVLEBkfG61EHJSnlQOZvKfRuBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duxJGBhVqeBnG/qNyq94I6AipRZRr3FhyoE2wkMxYCABdOP/8y6fOPQC4qTaIq2/v
         DHvwawv45kQODb+XcRw6Ir8qdZpOoB0985+85HXfoIv//An+pb+mkxy288ShAr9JH7
         IjZAa7Wo03Jp6CoB/w12oerCSM4Ul24E04M1JhA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 188/191] ovl: fix regression in parsing of mount options with escaped comma
Date:   Mon, 16 Oct 2023 10:42:53 +0200
Message-ID: <20231016084019.759657519@linuxfoundation.org>
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

[ Upstream commit c34706acf40b43dd31f67c92c5a95d39666a1eb3 ]

Ever since commit 91c77947133f ("ovl: allow filenames with comma"), the
following example was legit overlayfs mount options:

  mount -t overlay overlay -o 'lowerdir=/tmp/a\,b/lower' /mnt

The conversion to new mount api moved to using the common helper
generic_parse_monolithic() and discarded the specialized ovl_next_opt()
option separator.

Bring back ovl_next_opt() and use vfs_parse_monolithic_sep() to fix the
regression.

Reported-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Closes: https://lore.kernel.org/r/8da307fb-9318-cf78-8a27-ba5c5a0aef6d@alum.mit.edu/
Fixes: 1784fbc2ed9c ("ovl: port to new mount api")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/params.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index c69d97aef2cf9..c0f70af422d6c 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -120,6 +120,34 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
 	{}
 };
 
+static char *ovl_next_opt(char **s)
+{
+	char *sbegin = *s;
+	char *p;
+
+	if (sbegin == NULL)
+		return NULL;
+
+	for (p = sbegin; *p; p++) {
+		if (*p == '\\') {
+			p++;
+			if (!*p)
+				break;
+		} else if (*p == ',') {
+			*p = '\0';
+			*s = p + 1;
+			return sbegin;
+		}
+	}
+	*s = NULL;
+	return sbegin;
+}
+
+static int ovl_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, ovl_next_opt);
+}
+
 static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 {
 	ssize_t nr_layers = 1, nr_colons = 0;
@@ -596,6 +624,7 @@ static int ovl_reconfigure(struct fs_context *fc)
 }
 
 static const struct fs_context_operations ovl_context_ops = {
+	.parse_monolithic = ovl_parse_monolithic,
 	.parse_param = ovl_parse_param,
 	.get_tree    = ovl_get_tree,
 	.reconfigure = ovl_reconfigure,
-- 
2.40.1



