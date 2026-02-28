Return-Path: <stable+bounces-220840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA4nGVRZo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:08:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C61C8CDE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AEDD31E8AD4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749E64182CC;
	Sat, 28 Feb 2026 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK0qNJUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641F4182C9;
	Sat, 28 Feb 2026 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300727; cv=none; b=c/A53rixDOMWL63mRzy/3kkoRrOsV569zQWSPNaGO46nAlJ4FYYxxiFg7zvrv0TArZ0vDfWDy60KOw/9u1IaY/T47yn7V60dI1XJN7EDSJPveCxPxj7emYq2uH9aTcEj7Y7iXgdn3VXCKHeJx6HSWtnqPb3fJMKeq+VdWqSMj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300727; c=relaxed/simple;
	bh=YtJ83uoawKQ7DjuY7+NET7ElXZ6UcnKZpJ0Fl0lpTgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj84dw/LQmKo84+qHFRmUQv0VU6CFrcaaeuukEQ9zXpJUJ2A0RBHDKomnj5AsxZxm1VC+aciGzOo8bHx1TFp+zpOcRfggvD1V2H5zBs2CaqcwjTIAxinwSVKy3agG9peyEoHoG9QMZ3SVdzGze2nwjTcPmqwRsai7vi7cuLLt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK0qNJUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5602EC19425;
	Sat, 28 Feb 2026 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300727;
	bh=YtJ83uoawKQ7DjuY7+NET7ElXZ6UcnKZpJ0Fl0lpTgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pK0qNJUtoLRuqqtCVANEh+WairZI9/UxW6Tzb2i0VJADicOwAm3luX8C7xBrS/EEK
	 TaY2U04WIZdGtUcHIwfUCwmd/AFL1eMssD6U7sLNmqpPlnQqBllZ9tHQ1G7nYO+oF1
	 7MOijnD9gZIkl8lIgcaTIGvCFMzfRYzPHJMLpk9nOX2j+i1pDP+uvBxF+2wIJW0bUU
	 gq5rMVbBzWb8tg0e2hQk5+MAWu98n/cFpEfcu26LXQFbSmYIYof4YubFFfFIxaMdUj
	 RD1PCGqyWfvVaSqKq/6KkQ+AffPY8MjQ3uZiWWTlbSyw8gJIhEiHiPd5cOuM37nJ9L
	 h/+DKkeUSZOGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Bart van Assche <bvanassche@acm.org>,
	Daniel Borkman <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Jason A. Donenfeld" <jason@zx2c4.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kees Cook <kees@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 761/844] kcsan, compiler_types: avoid duplicate type issues in BPF Type Format
Date: Sat, 28 Feb 2026 12:31:14 -0500
Message-ID: <20260228173244.1509663-762-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.ibm.com,google.com,linux.dev,kernel.org,gmail.com,acm.org,iogearbox.net,zytor.com,zx2c4.com,linux.microsoft.com,infradead.org,fomichev.me,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-220840-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D36C61C8CDE
X-Rspamd-Action: no action

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 9dc052234da736f7749f19ab6936342ec7dbe3ac ]

Enabling KCSAN is causing a large number of duplicate types in BTF for
core kernel structs like task_struct [1].  This is due to the definition
in include/linux/compiler_types.h

`#ifdef __SANITIZE_THREAD__
...
`#define __data_racy volatile
..
`#else
...
`#define __data_racy
...
`#endif

Because some objects in the kernel are compiled without KCSAN flags
(KCSAN_SANITIZE) we sometimes get the empty __data_racy annotation for
objects; as a result we get multiple conflicting representations of the
associated structs in DWARF, and these lead to multiple instances of core
kernel types in BTF since they cannot be deduplicated due to the
additional modifier in some instances.

Moving the __data_racy definition under CONFIG_KCSAN avoids this problem,
since the volatile modifier will be present for both KCSAN and
KCSAN_SANITIZE objects in a CONFIG_KCSAN=y kernel.

Link: https://lkml.kernel.org/r/20260116091730.324322-1-alan.maguire@oracle.com
Fixes: 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Suggested-by: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bart van Assche <bvanassche@acm.org>
Cc: Daniel Borkman <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Kees Cook <kees@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler_types.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d3318a3c25777..86111a189a874 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -303,6 +303,22 @@ struct ftrace_likely_data {
 # define __no_kasan_or_inline __always_inline
 #endif
 
+#ifdef CONFIG_KCSAN
+/*
+ * Type qualifier to mark variables where all data-racy accesses should be
+ * ignored by KCSAN. Note, the implementation simply marks these variables as
+ * volatile, since KCSAN will treat such accesses as "marked".
+ *
+ * Defined here because defining __data_racy as volatile for KCSAN objects only
+ * causes problems in BPF Type Format (BTF) generation since struct members
+ * of core kernel data structs will be volatile in some objects and not in
+ * others.  Instead define it globally for KCSAN kernels.
+ */
+# define __data_racy volatile
+#else
+# define __data_racy
+#endif
+
 #ifdef __SANITIZE_THREAD__
 /*
  * Clang still emits instrumentation for __tsan_func_{entry,exit}() and builtin
@@ -314,16 +330,9 @@ struct ftrace_likely_data {
  * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
  */
 # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
-/*
- * Type qualifier to mark variables where all data-racy accesses should be
- * ignored by KCSAN. Note, the implementation simply marks these variables as
- * volatile, since KCSAN will treat such accesses as "marked".
- */
-# define __data_racy volatile
 # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
 #else
 # define __no_kcsan
-# define __data_racy
 #endif
 
 #ifdef __SANITIZE_MEMORY__
-- 
2.51.0


