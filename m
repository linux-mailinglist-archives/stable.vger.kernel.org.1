Return-Path: <stable+bounces-3660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D52800E77
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 16:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F09281B93
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F34A9B0;
	Fri,  1 Dec 2023 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ajueAwNN"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9C9CDD
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 07:20:41 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 12D0B20B74C1;
	Fri,  1 Dec 2023 07:20:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12D0B20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701444041;
	bh=9XS3HJjN86RyawKYLo2e9uKUd2fceieH2TdOsSxxuFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ajueAwNNc9/hfJ5I/vvoGPrC+/WqzAZxmHj6GLo/FvZjunCt56tfH4sSHsd31ZXlE
	 sLJkoBUQNwox1SFNWvo0F18LQh7+qvfo8G/0mtkM1EO6qedMXm5H0rsHTU24HFHie4
	 YjFMmRbAtZpWbZVFsicD63/Zyz1zko7KcrBrANhs=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 5.15.y v1 1/2] kallsyms: Make kallsyms_on_each_symbol generally available
Date: Fri,  1 Dec 2023 16:19:56 +0100
Message-Id: <20231201151957.682381-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201151957.682381-1-flaniel@linux.microsoft.com>
References: <20231201151957.682381-1-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

Making kallsyms_on_each_symbol generally available, so it can be
used outside CONFIG_LIVEPATCH option in following changes.

Rather than adding another ifdef option let's make the function
generally available (when CONFIG_KALLSYMS option is defined).

Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20220510122616.2652285-2-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/kallsyms.h | 7 ++++++-
 kernel/kallsyms.c        | 2 --
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index a1d6fc82d7f0..eae9f423bd64 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -74,11 +74,11 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 	return ptr;
 }
 
+#ifdef CONFIG_KALLSYMS
 int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 				      unsigned long),
 			    void *data);
 
-#ifdef CONFIG_KALLSYMS
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);
 
@@ -172,6 +172,11 @@ static inline bool kallsyms_show_value(const struct cred *cred)
 	return false;
 }
 
+static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
+					  unsigned long), void *data)
+{
+	return -EOPNOTSUPP;
+}
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..e0d9f77cf2d4 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -204,7 +204,6 @@ unsigned long kallsyms_lookup_name(const char *name)
 	return module_kallsyms_lookup_name(name);
 }
 
-#ifdef CONFIG_LIVEPATCH
 /*
  * Iterate over all symbols in vmlinux.  For symbols from modules use
  * module_kallsyms_on_each_symbol instead.
@@ -226,7 +225,6 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 	}
 	return 0;
 }
-#endif /* CONFIG_LIVEPATCH */
 
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
-- 
2.34.1


