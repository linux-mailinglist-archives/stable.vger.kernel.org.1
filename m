Return-Path: <stable+bounces-41503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C268B33B5
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 11:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA243283598
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01F13D89D;
	Fri, 26 Apr 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeM70k8k"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390E25605
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122989; cv=none; b=mX5bnZwQjdpg/LRHPZUb7tIP0oYCn8yd9cg5l85jsYHn0F6SzOS21CWh6xpcJsny2VpNxNrb8f65UfQRQsUJLRFqrfbgrqT/avVTRBV2+AcdyW4baJkWvjBr7mREFrTxRxXgWDNTxyftWI9uLYcHX1xIdGQ8CCh7nlOFHWFKV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122989; c=relaxed/simple;
	bh=KYiwra/dNC5/3zOT8JFwQmtny5RJSHuyKSiO/oZAH7A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=msvopNNkWR6QahuZLUEz4ondIw7yTEuSV4cWFyXoXveHSxL2VEZXTi2VKDUdfceJS1jUcs5n0luufq0Z++9Q5bI0XEnBIN37j0Me1edZ1Qh2Vk2F72rOQfVeJKAbANapJS9Ms24URrSobG9abw6cSL29IW1Cn7JuI5uRdVM4ydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeM70k8k; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-618891b439eso31112677b3.3
        for <stable@vger.kernel.org>; Fri, 26 Apr 2024 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714122987; x=1714727787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z4qUs0z4i6uPaM7muqfM7PcNVWD6PVFe9hqtGEfhGec=;
        b=JeM70k8kudIFXTSs07NJXycbeI8i+87s/gecq5BVay7gdiljRgzr6Itl9Vp5OEKM+m
         EpiC+H5cTDSSL4JlDYNOqoKTvcFx+zP9tP2A9ap3qDof7l7ubGQe2WlI6pRWU0R3nnDI
         +oSPeVM+xTYZ7LL5HpSGKKXFNVaE0wMGKw1VAXy6l2dgEYEZVXdntLWUIkrc+DROwLIi
         EzlHH8P2kfqr7f4AVBIQxsxvFtofIKR9lmDWGQ4IxUK8EyJpwhNntQDnyW7Z3pMeMcbd
         tRGWDEmlxR+deTSPwETHB9657tzB/tRyzvFCe9FPe0kwN/4NvKeZjYf7F+lzeZHJtH0D
         xaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122987; x=1714727787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4qUs0z4i6uPaM7muqfM7PcNVWD6PVFe9hqtGEfhGec=;
        b=GGhYQJI1P4ZXtTds8RugwNEy+QI0OAGt7G0C1q34jmPTq7RxyYOaIWOS0Kz2Ivmg7N
         F0XRPn3KvHvGTDJMtBX0PbpDQBQN1Qeysih9KNU1lwsUIg8z2x18YU7J/F3ke6aeQ1pm
         0crRKIEWjvmgZTGZl79kkSxvWF0Fox/Nc6YIiulhpaUaZwwEoWnlDPC0lWkil9U3uOlR
         LMUBpjT3JNbtjJ9BUOegT+vLCXJFiNXHAnUVGFooJUB/ZQw68HLXZXtfnvtt+Ff/LdqR
         U8keJcw5fEsd3+R9hnF5W5D4y6oSJNZIuNA0siDH1X4Zs8jg6BSc2fkF/jApI7Vc9baT
         qlxw==
X-Forwarded-Encrypted: i=1; AJvYcCV9KP1M0KWm5jqVyjffiiRblD5llGIY+sKtvknbAbWB8JVBqW9hoZGsAHnf+Puhe4uPE2FH+Mf7QQl6KAcOdVMjUb8/M6tv
X-Gm-Message-State: AOJu0Yxyb/bL8gfRaswUKXYZHAjD/IXUX3mtMlhnyM4LA9HYsakojmK0
	IYy0zrb1aOLh/yEK2FEt4Sv7b4v8DUlmbOXmunmsolqaI3RoBU5SQFV2h9JGEWPjFsf/yOsk0Qb
	TxA==
X-Google-Smtp-Source: AGHT+IFih6RbniRf/KkucHRhzDsd/1150aNGtsDTV/xrr69hergLJgqCOsMEVtTenXe2UnAmr7OHlHAwNUs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8a7d:cf77:4cb2:f97f])
 (user=glider job=sendgmr) by 2002:a05:6902:1247:b0:dc6:44d4:bee0 with SMTP id
 t7-20020a056902124700b00dc644d4bee0mr202369ybu.7.1714122987146; Fri, 26 Apr
 2024 02:16:27 -0700 (PDT)
Date: Fri, 26 Apr 2024 11:16:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426091622.3846771-1-glider@google.com>
Subject: [PATCH v2] kmsan: compiler_types: declare __no_sanitize_or_inline
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, akpm@linux-foundation.org, 
	ojeda@kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It turned out that KMSAN instruments READ_ONCE_NOCHECK(), resulting in
false positive reports, because __no_sanitize_or_inline enforced inlining.

Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__,
so that it does not __always_inline the annotated function.

Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Link: https://lkml.kernel.org/r/000000000000826ac1061675b0e3@google.com
Fixes: 5de0ce85f5a4 ("kmsan: mark noinstr as __no_sanitize_memory")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 0caf354cb94b5..a6a28952836cb 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -278,6 +278,17 @@ struct ftrace_likely_data {
 # define __no_kcsan
 #endif
 
+#ifdef __SANITIZE_MEMORY__
+/*
+ * Similarly to KASAN and KCSAN, KMSAN loses function attributes of inlined
+ * functions, therefore disabling KMSAN checks also requires disabling inlining.
+ *
+ * __no_sanitize_or_inline effectively prevents KMSAN from reporting errors
+ * within the function and marks all its outputs as initialized.
+ */
+# define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused
+#endif
+
 #ifndef __no_sanitize_or_inline
 #define __no_sanitize_or_inline __always_inline
 #endif
-- 
2.44.0.769.g3c40516874-goog


