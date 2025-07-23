Return-Path: <stable+bounces-164484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA9B0F829
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0E0544160
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174051F4C87;
	Wed, 23 Jul 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIvOmiWJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B691F4628
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288337; cv=none; b=EllOYFnSCH7wWhDYzafzse6X7KWqku7CEwekXzVAgsZz5JT0Pt51aylSq/YvXsu89KKQ6QxO5wkpIMoziKVHjutMtrJOVyXk6g41xGr7mlQDXcq6crGvtqG+ZZh1JdGOy8bvs8Hvz3UT/u9A9cWlvU3fu949BQPLPyq+L6ZkaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288337; c=relaxed/simple;
	bh=puv+nrGItEZh48/tlhNXKwfw7Zk3oVZiGpAgJOtbUcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q0y6/d3L8TlkmnblRcZx/JpFUGixpAxUqnLP/691D6hSiP97bgJzj8c317KJElqUrivpLaEyDmJtFEepuY6SLomYnntOPNQeZspA7wBRBQSaaZ+UI6RKHYzBRKjLE9kEXaQcAqirMSRqfYqL4xcr2aa/GyEnb/nVwxGuQkS3S5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIvOmiWJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so114963a12.3
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753288336; x=1753893136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ynquqnom6K89ryaagK4hNXqZOrIWg3VwMvQwB0PKM8=;
        b=VIvOmiWJui3AzGuZ+hlS5QoOGkYY/YWwmAVEu4Nbc2Lu9B7f1bu4cSRdIFAgAsnwD8
         dGP98/ozs8gNybMulbvEuhn65UKuZJpaOZ1N/9Hz2MvLNGGebho6B51g4AxCXWTUdysD
         a0W0EEiBCYo6B4BY2qyw6OjyjdWrFIzxWXIXNHDdxaJA1iw6ZQMHxor/VisEqZSVhnSB
         dNNk9Mignh3Xy5Hxr1aE8elew2ca5/OAMvC5mtJFcri4DYv/sYrgWXbtqor/1kkWKh1t
         mOsoeQxxuM2hgugPCzoXKupNh+5VBjgRBD2VU++mOo3MK1EPixNV0BnMhnPE+DrnUDJF
         ZGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288336; x=1753893136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ynquqnom6K89ryaagK4hNXqZOrIWg3VwMvQwB0PKM8=;
        b=qBPgj6LKqWDsF93DVaOjnQSkcK6J9qsqjsBSN3ozdbRQ4CLDqRZvlgFvosYz7K319p
         XbHtMbWhZvTKEAGjCJNRO68ABEkAQtQ/jiwspOjj7YSWZDQ6KyJX9e8XhO1qU7BWB2FT
         sporEmQ4uLZh43o5EME1AMQ4XUTszOikrtgpd4U5nbgczAuz6VzPESd0e8dVePxkzT11
         IvT3fEPeHeh3PjflvXNAFv3kk1Q6CQSiLg7E4VeU1L8SVbGFoudf8O7ODm+EuXXEmx4P
         8c9ghM/IzjjtBUnUEFP+ZODyNP+SI4Jfy98Sp9EI08w7PKXwqfokHShQMnUiL/OLTxUO
         WT5A==
X-Gm-Message-State: AOJu0Yw6culid8fE7FMIzB0m8HMqfi1m3rIZyFZe+6gPNNKl17Wdie+T
	Suu/q7F1Svu53dQiAJWAH1utsuaRWwIMbQvly/ftUwun/V0T/LjHpDG5Q0sXbO9Tp4O8N8fFGYc
	CJqAyYMWSIxqvOltqnB5qW2AtNQuJb+e72OypdQk82+vAumHgTZP1CvTPD0dUHxqT3BtfBPGSP3
	399FDvUvIHPN24UVj+GjXLHubalDMS4m1MLv4gS4WVLzV9j3sqrOkH
X-Google-Smtp-Source: AGHT+IHsq7IsWRvsYKVmkCotx/msB2lMbNTuYzjHbHWW8noURmixwxzLrBdCHW5yu0mc+SSXmOTNqZJr40HgD80=
X-Received: from pjbsp12.prod.google.com ([2002:a17:90b:52cc:b0:312:1af5:98c9])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2747:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-31e507cda32mr4861763a91.23.1753288335607;
 Wed, 23 Jul 2025 09:32:15 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:04 +0000
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723163209.1929303-2-jtoantran@google.com>
Subject: [PATCH v1 1/6] vfs: dcache: move hashlen_hash() from callers into d_hash()
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight@aculab.com>, x86@kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Jimmy Tran <jtoantran@google.com>
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
2.50.0.727.gbf7dc18ff4-goog


