Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C61D713D8C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjE1T0i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjE1T0h (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:26:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EF107
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B25DC61C4A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2C7C433D2;
        Sun, 28 May 2023 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301989;
        bh=9YiUokAwzvfOZddzUNJbmXxT+pnMi4TLKierQzPtqSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RkFeDfT8Lmu2hRCqI6O7UUoFT3mka7bq2JSDO7GbmHJFgysVWJjxx+Dy9UzvO+JUz
         0n9lHS2PuFmIxMS8YbUrtzsy8ZRryG5ZPDzchPdLnTa5BrKGhas2iUEU9QL3eu8wMc
         By/bR5Z6yNOK7+gjbqjC9RtJhQE6JhA2+c3pS8sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 116/161] lib/string_helpers: Introduce string_upper() and string_lower() helpers
Date:   Sun, 28 May 2023 20:10:40 +0100
Message-Id: <20230528190840.749134525@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

[ Upstream commit 58eeba0bdb52afe5c18ce2a760ca9fe2901943e9 ]

Provide the helpers for string conversions to upper and lower cases.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 3c0f4f09c063 ("usb: gadget: u_ether: Fix host MAC address case")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/string_helpers.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index c289551322342..86f150c2a6b66 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_STRING_HELPERS_H_
 #define _LINUX_STRING_HELPERS_H_
 
+#include <linux/ctype.h>
 #include <linux/types.h>
 
 struct file;
@@ -75,6 +76,20 @@ static inline int string_escape_str_any_np(const char *src, char *dst,
 	return string_escape_str(src, dst, sz, ESCAPE_ANY_NP, only);
 }
 
+static inline void string_upper(char *dst, const char *src)
+{
+	do {
+		*dst++ = toupper(*src);
+	} while (*src++);
+}
+
+static inline void string_lower(char *dst, const char *src)
+{
+	do {
+		*dst++ = tolower(*src);
+	} while (*src++);
+}
+
 char *kstrdup_quotable(const char *src, gfp_t gfp);
 char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
 char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
-- 
2.39.2



