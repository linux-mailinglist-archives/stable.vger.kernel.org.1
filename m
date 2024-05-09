Return-Path: <stable+bounces-43483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798068C09CA
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 04:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E31F22E4A
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3CF83CCF;
	Thu,  9 May 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gkCL0I1M"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BD82871
	for <stable@vger.kernel.org>; Thu,  9 May 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221823; cv=none; b=f0Vv5u/M682OpRfmREaC+2IrHNjimYgUdE1X1bsrowgWRu1zeQjWKyDOwkc//aVUwTDM0KHFzhYz8i1sO6SOEfUyw7K7MxTfjuCaIKX7UKjQAA1I9Z1Y8RHCXd1U7cb6cK3DysFR0jKZvltFi7Vf4JqzS3j/0XVam89X/a6aWz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221823; c=relaxed/simple;
	bh=MrpItYudK+D9Vlv4v/hhPerupEYvYYJFedtmRhnBdGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIgcGC+sojStGID0wlPndq1Jf1WWFEasO001TUdjVP7sVSWvDwzfJRzqN+KkHLINJZGo6m/pTUoPYFeroMOMCok+59nIpeiHZ4j/DTYjdSQ+cKIyoUidxS4OGkve5Bgilyxn6vDsIh0XcmxeiJ4NYIFSjEDP8kTOoPA10C7ZLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gkCL0I1M; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715221819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/fmQH5/9oEp8jNWunCBG5Uy6o4tvmCINI5Vzjnjjks=;
	b=gkCL0I1M+pPCDaaM9BeKFCxHxmp4b1/lkZveYojGnMokYDR7hMYMDlcKOWcCVq9l5MiPbb
	6UNoAFdh68uDeBbeY5+lzNb9IcRB4sL/QJDixNLAZYyGIOKEMYr4cztrvNbYxUC4DJfLav
	TmrEgO4GySNHTJIxsMtWGKRR8SMdZ80=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org,
	Tom Zanussi <zanussi@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 4.19.y 06/13] string.h: Add str_has_prefix() helper function
Date: Thu,  9 May 2024 10:29:24 +0800
Message-Id: <20240509022931.3513365-7-dongtai.guo@linux.dev>
In-Reply-To: <20240509022931.3513365-1-dongtai.guo@linux.dev>
References: <20240509022931.3513365-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 72921427d46bf9731a1ab7864adc64c43dfae29f upstream.

A discussion came up in the trace triggers thread about converting a
bunch of:

 strncmp(str, "const", sizeof("const") - 1)

use cases into a helper macro. It started with:

	strncmp(str, const, sizeof(const) - 1)

But then Joe Perches mentioned that if a const is not used, the
sizeof() will be the size of a pointer, which can be bad. And that
gcc will optimize strlen("const") into "sizeof("const") - 1".

Thinking about this more, a quick grep in the kernel tree found several
(thousands!) of cases that use this construct. A quick grep also
revealed that there's probably several bugs in that use case. Some are
that people forgot the "- 1" (which I found) and others could be that
the constant for the sizeof is different than the constant (although, I
haven't found any of those, but I also didn't look hard).

I figured the best thing to do is to create a helper macro and place it
into include/linux/string.h. And go around and fix all the open coded
versions of it later.

Note, gcc appears to optimize this when we make it into an always_inline
static function, which removes a lot of issues that a macro produces.

Link: http://lkml.kernel.org/r/e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com
Link: http://lkml.kernel.org/r/20181219211615.2298e781@gandalf.local.home
Link: http://lkml.kernel.org/r/CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com

Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Suggestions-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggestions-by: Joe Perches <joe@perches.com>
Suggestions-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/linux/string.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 1e0c442b941e..f85860ab7e55 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -492,4 +492,24 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns: 0 if @str does not start with @prefix
+         strlen(@prefix) if @str does start with @prefix
+ */
+static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
+{
+	size_t len = strlen(prefix);
+	return strncmp(str, prefix, len) == 0 ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.34.1


