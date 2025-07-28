Return-Path: <stable+bounces-165003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC866B141A7
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE16173A13
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA2F278E75;
	Mon, 28 Jul 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7LvTE9J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433722561A7
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725438; cv=none; b=mB09u9INDJTBSW2F01nQmAan3+s3p9o+C59l0o4djID6QZmif9d+Q35orYrGD2GXVQ/Z5XZ+P4VcgQFUj55UJVIlcamc5GgPqfSACkrKsMjt5bMBWGhtbfZs0uE1WVvnFFs00ZQjuhZ6wNQ64H0RAvoocEw1Z8axxV+QH77iuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725438; c=relaxed/simple;
	bh=NBtHxujEKJsoZdz/OFslqaryO21ur6DaXqpBFqh7DYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G9KCqOlC8vixIeYSOOtSH7CpydB+ulHsdwnO5HMsJpyHtIMyjFKQo05mlaTfYVHqI53JUCrQfMjnvqHQ1lR5ivLcVdDODCrUgABgFRueSvb60m8CJoGMakO3IGrViiG2iTmNtm6dVjXXAHP/0TyxE6BNpuzpfLjOjrbtBDNrgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7LvTE9J; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31ecb3a3d0aso1549615a91.3
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725435; x=1754330235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJB2R0wv5YsujI0mMXuSQDKQGvX/BViCaq7ruPt4fjE=;
        b=Q7LvTE9J6B3Bb7BVWKddt7vDIoB80huwzhLMHtytJ1UdUm747FWnB8RnY0t/51Yp6e
         jgA0PC1IiColWUk0drUFtrmlcLuuJDM2TzgRmFalVbwE0t6rZx7C/wl//eVko/gVT29J
         2auI+viA+aly4qcw0WJxL9hTLoPjv7hHBhAVBR5WW6eN/T9QXe7I4UCoZ7fLmpGDkFqs
         2CiU0T2cLIxpPxfOkVo8vbDLWjfCw9eCf2bcNu1s1j6qw3vYkkVKD2n1or70saZH4ICH
         ef1p7HgeHFAArFYXrWNKhc283eX/agRBzIlZUeeForjNfdQdGggpM7vl9+1+eiYW+TGc
         ln4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725435; x=1754330235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJB2R0wv5YsujI0mMXuSQDKQGvX/BViCaq7ruPt4fjE=;
        b=FyuhhvWBJnbz9xaRlPXhC3yVfwSltSw23vuyNKwAa5slboInkQOCO9+CUXOUTwzuGB
         sLT9RzsdycOxwsUlXig7sAi9RZ8Gj2Hbsa/yCUaha05dz1j/guYyM2yJRucHDtli13Rw
         x2BaZ92VT2R40OXVBDP/RGkeb2/R6G3R6qQwNRNUzaqj7JqoOrgU4lF+RmQ6vjcu303P
         TPgznjxlGCjaral93GzX3/x20yD7ZsdH4J3aKeRAkmCkqf4vrJdcKm58nnqaeLTfEXuh
         Oy6jxGiMii3J9q3JgPQdOtTE4ZFeXDdYgFWxygFu6MO0vBpxJqrIvpUBBmaQSec05WuE
         JlBg==
X-Gm-Message-State: AOJu0YxqDOFduaJxfQFvXNh6ZIuktyvK6jzykxyKqRWHJonXVzaVLNmD
	QARf/TjPCWjtyxIxmwsbdODsdWScuSiDt9EZ24Vo5yeoCU9aXU6GbE5aPhXo8/Vn58w5jgwTAWF
	NR348u/YlTevUYdGHRuwJkSJ+SrMZ1I+iMfLShW4tGVfWv+Me3PYeyYjor8mwBc7UH/PfDnUq8g
	EhrcwuEpcZaQj4sfdP6ZFhn2Z1MY8jRVZ77QITWuKrqxujvDGiriOn
X-Google-Smtp-Source: AGHT+IHXbDZVLL84Kn5lnpU7xY+3GI308DI7QgWc7hevr+ja4w0GE1FrHRRH+gTGJL/8Pl1nUKx2URJxjeTpnpU=
X-Received: from pjqq7.prod.google.com ([2002:a17:90b:5847:b0:31c:38fb:2958])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5848:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-31e778f1a6fmr19402652a91.19.1753725435555;
 Mon, 28 Jul 2025 10:57:15 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:56:54 +0000
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-2-jtoantran@google.com>
Subject: [PATCH v2 1/7] vfs: dcache: move hashlen_hash() from callers into d_hash()
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>, 
	Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>

commit e60cc61153e61e4e38bd983492df9959e82ae4dc upstream.

Both __d_lookup_rcu() and __d_lookup_rcu_op_compare() have the full
'name_hash' value of the qstr that they want to look up, and mask it off
to just the low 32-bit hash before calling down to d_hash().

Other callers just load the 32-bit hash and pass it as the argument.

If we move the masking into d_hash() itself, it simplifies the two
callers that currently do the masking, and is a no-op for the other
cases.  It doesn't actually change the generated code since the compiler
will inline d_hash() and see that the end result is the same.

[ Technically, since the parse tree changes, the code generation may not
  be 100% the same, and for me on x86-64, this does result in gcc
  switching the operands around for one 'cmpl' instruction. So not
  necessarily the exact same code generation, but equivalent ]

However, this does encapsulate the 'd_hash()' operation more, and makes
the shift operation in particular be a "shift 32 bits right, return full
word".  Which matches the instruction semantics on both x86-64 and arm64
better, since a 32-bit shift will clear the upper bits.

That makes the next step of introducing a "shift by runtime constant"
more obvious and generates the shift with no extraneous type masking.

Cc: <stable@vger.kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jimmy Tran <jtoantran@google.com>
---
 fs/dcache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4030c010a7682..82adee104f82c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -100,9 +100,9 @@ static unsigned int d_hash_shift __read_mostly;
 
 static struct hlist_bl_head *dentry_hashtable __read_mostly;
 
-static inline struct hlist_bl_head *d_hash(unsigned int hash)
+static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
 {
-	return dentry_hashtable + (hash >> d_hash_shift);
+	return dentry_hashtable + ((u32)hashlen >> d_hash_shift);
 }
 
 #define IN_LOOKUP_SHIFT 10
@@ -2286,7 +2286,7 @@ static noinline struct dentry *__d_lookup_rcu_op_compare(
 	unsigned *seqp)
 {
 	u64 hashlen = name->hash_len;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
+	struct hlist_bl_head *b = d_hash(hashlen);
 	struct hlist_bl_node *node;
 	struct dentry *dentry;
 
@@ -2353,7 +2353,7 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 {
 	u64 hashlen = name->hash_len;
 	const unsigned char *str = name->name;
-	struct hlist_bl_head *b = d_hash(hashlen_hash(hashlen));
+	struct hlist_bl_head *b = d_hash(hashlen);
 	struct hlist_bl_node *node;
 	struct dentry *dentry;
 
-- 
2.50.1.470.g6ba607880d-goog


