Return-Path: <stable+bounces-45111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4378C5DD6
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 00:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3331F216B1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F1182C90;
	Tue, 14 May 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwFFVZNp"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB01DDEE
	for <stable@vger.kernel.org>; Tue, 14 May 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726801; cv=none; b=iSanhigApCd8LxKF0dueSwqQIQ/3OEl5wVskgww1rTmUtcOO8ci2Jd1OvOh2KlUzfJWAnhAiZp+ziRuD6Mkn58ardgYM+Y9Gb61OPLlUuaSY+waztUYVKWVEdNQhcCUemNXyc/gE27zsdQXXIzaqUQWH3rYXwnQsioLxs0u8+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726801; c=relaxed/simple;
	bh=aAYVOEV+rUoRQ++ZhGlIi98s2QA8IsgUrzjBcW8dEIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ea3Z4emKUVLlPHTpBqg0ejA12CpX8o/RUWKoct9JUWpr59x8YRSUG9eUvjIm0PDv7vxLqn6us2ZV4ijvv64i9QBS8+w4zR4Nip+8q5CvxWzRoEmDDxJprPk7NmzeiPxuSAW+gE96DyeJh5MQbvFf9kYbya0Crns4Y4qlMklqoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwFFVZNp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54be7066bso10821859276.0
        for <stable@vger.kernel.org>; Tue, 14 May 2024 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715726797; x=1716331597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r09sNlqyfMtvZsX2rZ+OdLweqNYAcheUEw4dxFcOJ6w=;
        b=vwFFVZNp76KJcq26kjEH9ZGtE3rrdB1qpkQMlOv9xW5LcWNKsKexz2Mn9nqLNUp6kQ
         XpP3c7kO60VvyBcBxAe2AuQdbH9YbtgPxBgm8/oJYonq2AyMCvj5/pd5EUZQ9+YqtH4H
         H1Yte/UtGRwUaYNfIiDCpXQi6TCKe8K0uOwQOAZjno8LJMjW/mMlG7qWxlnaOpbGtU/F
         Z1fYpN8i8i/BwtiPQbaOkaaekhzLZ+q2deJ5o218HgIQUe1YREbZnGMPShVNO52/peJG
         GMkmQJDPGtNYWfgQpIrx3bw4OLpQxy0Y/nhDFJ48EhbZHYjx7tR25XoY2GB2VFDlh7kn
         r9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715726797; x=1716331597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r09sNlqyfMtvZsX2rZ+OdLweqNYAcheUEw4dxFcOJ6w=;
        b=mY5Zn19zdnxMQBM0BevjUKsnB04e/pit/qK3tX9tOFbcAuD9t7Qtfd1f2nkozvZU5G
         vRWnTtXNQWYUe5ERjAT0nVCmpSOjGzc2n7YiyOESH6d62dNrZkfgrmh8cfCrSaO2CnkG
         KYdXhXc7F03uVYPZ+vTHC0A17EN71E2C5pvizTnmvkBbBNgD2uP4e2qZgOCpJB41/4xX
         lCn2AGyAeNGc85l4GYd8+IRfENOZy6dtrPgrvVk20xhyqLKuDjOLX0kB3h2WIyi8P+m6
         lnp6URNpwm6zwJItBSyGUAZ7fg7wAkgAG8koZZir8oPYQKcYllrhHrpKqms61NprZCxK
         vaMw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGTDn2SnZmOd9jPH2fOICWUu2y1xeWzhK2LlH0MIrTZxkY/5eKvAUOhjJ1NNjN4i2/ltvzOmtZM7BwMUqFozvWeAU9m5o
X-Gm-Message-State: AOJu0Yzcsrkg26KM7AS9nJu13RxfvrQTYGaSNCEes96yJPt+KD+SXCBg
	zeqmUMgBi3rEXv/GlVOR9A/aYRTV6Tb91x3PXmeY0Psxg0s4Z3N2BPn+3J/Ug8PZpvqEtbLKGi2
	FRtUmwZ5tJw==
X-Google-Smtp-Source: AGHT+IEgwEh4FRIW62GfVaIxkCCTMMoQRrAiBVPp3ojlCpnrOENNsyILNjVksqXCK51brnnELH5RirP8hwLuww==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6902:2b0d:b0:dd9:1702:4837 with SMTP
 id 3f1490d57ef6-dee4f2c6b6dmr3521458276.3.1715726797280; Tue, 14 May 2024
 15:46:37 -0700 (PDT)
Date: Tue, 14 May 2024 22:46:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514224625.3280818-1-cmllamas@google.com>
Subject: [PATCH] locking/atomic: fix trivial typo in comment
From: Carlos Llamas <cmllamas@google.com>
To: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Carlos Llamas <cmllamas@google.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

For atomic_sub_and_test() the @i parameter is the value to subtract, not
add. Fix the kerneldoc comment accordingly.

Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/linux/atomic/atomic-instrumented.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
index debd487fe971..12b558c05384 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1349,7 +1349,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 
 /**
  * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
- * @i: int value to add
+ * @i: int value to subtract
  * @v: pointer to atomic_t
  *
  * Atomically updates @v to (@v - @i) with full ordering.
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


