Return-Path: <stable+bounces-10540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBD482B6CA
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 22:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C388B1C24154
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1D58202;
	Thu, 11 Jan 2024 21:44:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291058136
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T9yqy5L4Cz9sbM;
	Thu, 11 Jan 2024 22:44:46 +0100 (CET)
From: Markus Boehme <markubo@amazon.com>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Markus Boehme <markubo@amazon.com>
Subject: [PATCH 5.15 1/2] kallsyms: Make module_kallsyms_on_each_symbol generally available
Date: Thu, 11 Jan 2024 22:43:53 +0100
Message-Id: <20240111214354.369299-2-markubo@amazon.com>
In-Reply-To: <20240111214354.369299-1-markubo@amazon.com>
References: <20240111214354.369299-1-markubo@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: on6r5jzks5193do39ioeow7qoxgypzsf
X-MBO-RS-ID: 650a9c2ec41d721d75b

From: Jiri Olsa <jolsa@kernel.org>

commit 73feb8d5fa3b755bb51077c0aabfb6aa556fd498 upstream.

Making module_kallsyms_on_each_symbol generally available, so it
can be used outside CONFIG_LIVEPATCH option in following changes.

Rather than adding another ifdef option let's make the function
generally available (when CONFIG_KALLSYMS and CONFIG_MODULES
options are defined).

Cc: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20221025134148.3300700-2-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at modules as well")
Signed-off-by: Markus Boehme <markubo@amazon.com>
---
 include/linux/module.h | 9 +++++++++
 kernel/module.c        | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..701c150485b2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -867,8 +867,17 @@ static inline bool module_sig_ok(struct module *module)
 }
 #endif	/* CONFIG_MODULE_SIG */
 
+#if defined(CONFIG_MODULES) && defined(CONFIG_KALLSYMS)
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data);
+#else
+static inline int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
+						 struct module *, unsigned long),
+						 void *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module.c b/kernel/module.c
index 3c90840133c0..ba9f2bb57889 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4482,7 +4482,6 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 	return ret;
 }
 
-#ifdef CONFIG_LIVEPATCH
 int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 					     struct module *, unsigned long),
 				   void *data)
@@ -4514,7 +4513,6 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 	mutex_unlock(&module_mutex);
 	return ret;
 }
-#endif /* CONFIG_LIVEPATCH */
 #endif /* CONFIG_KALLSYMS */
 
 static void cfi_init(struct module *mod)
-- 
2.40.1


