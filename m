Return-Path: <stable+bounces-166720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EBBB1C9A8
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C677A6283A1
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541A289808;
	Wed,  6 Aug 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvmMwAET"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD902AF1D
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497211; cv=none; b=YSu79jNbaoQvQD0QN5m/6CdnqW7AN6tCh5gDWWkvZLQkmQ/c2XoHgrXJqHkNrE/Tq4+kWtawKh9czAUFZ+0XqF6grmh5CAi+rvexL6NRX4tRCvYBuZknS21rhBBKWRjzkH8Sj/1SGbW4O1LkDvrv8hbieLPr2+I1w9mXQXUVDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497211; c=relaxed/simple;
	bh=NBtHxujEKJsoZdz/OFslqaryO21ur6DaXqpBFqh7DYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otI0mAOLoRP5/zIc3/8nR2z8jTk4zam9AM8cwmjWhJMr1ZWCBbVaTIw7OdirSXKzAI4g9uNOuiicLLshEsMJIHSSppOq/22Zbw44yNRJCBdwSgp6cY4shy9woNdLJMH9+ES1SjQaR8aGFWfYL76JHcfivhbaWPqLtdkUxipO8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SvmMwAET; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ed9a17f22so205644a91.0
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497209; x=1755102009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJB2R0wv5YsujI0mMXuSQDKQGvX/BViCaq7ruPt4fjE=;
        b=SvmMwAET6GVtgDODg3dQVMXkuMcTCe5O5muzFugDTElo6lD9F2fMiInvsy9whZicVw
         W6YtqwEYx43sm5paDDgLW+ExFM4Nw0BgUcDbSJyNS+r0pv4Kkpt6NgHCS8MTlOJ1uorW
         OpoLWlhEq5lmkgc6g8PLgoNDxHg9v8ZNbitixfG9et+yGWiFHq4NNz0L1QLNkjchvT94
         4OVBM1hFo3HtgE8wHYbca9jKtVi84eMlAQ83TVucaub53sqpVY7HBj8cCM5S55tcBByL
         Qn/zgugja0YmaCVkemF4QsHBFuIDptV+ZyQuE0hvsRTpXpqRANML0sh58AZPFr1Zpvis
         HI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497209; x=1755102009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJB2R0wv5YsujI0mMXuSQDKQGvX/BViCaq7ruPt4fjE=;
        b=XvoECGnnqoKckeTZwbCrXhsWNW0M/GNjchIUlUYGpAu7nj+BESacH6d+68Ka+zOyMt
         0y+192FYRJrizfL0n+rA/B2bmqmQiGhr3fcl5F+1VnKQnQxsg2wEDQXUG5J0UMZxROGA
         Eq4yy+XhsKHWV+PJ9UBx2d/CLYNqX5BbOP0c6zqdomqSwx4IATp8tuAJ22MR/pzfe6Nn
         0djlpFgb4lGhTkQspwpEitE1doP+7HFYqVq9BM/WhZgNl+gMwpbjv4J77eQHpBmYeTqN
         yWj8I28YVRbbf8LXfnylKgSHKzRfsGMF6JNb+FYQHxAaDzPj+79WUKQdtJnYR2sgx/HB
         TJlw==
X-Gm-Message-State: AOJu0YxxAZiRJGjMP+chfDNcqOv2FbTRYMQck4r89fpOMySHGpSQSSuE
	PVGm9+1pnQ3XEjE3UZTqRRCNgym64UALcSbAnE5w1h7j848OM0DnPwxZiTQDNerIFSLCkPEXDrc
	QL/f6mjHIn2RzBaUkTau6VbYakdBX214gPpBwliJP1afndMdIrEWhW8Sll2/E5OuRggsHKjXkfF
	pPPSJxVTaGt/AMMLxTN9iYP95iQspnbaHwQ26Zu1dNHYSLFSvgI2Dt
X-Google-Smtp-Source: AGHT+IG5foUskB/EKx0yM9lcZHkyHGT+1/1P9RjY5o5Kj1sB13I9UEWsjlYvlQTFFacPr1uzRiH5CA3GsvQ2cOw=
X-Received: from pjyt9.prod.google.com ([2002:a17:90a:e509:b0:31c:2fe4:33b7])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5185:b0:311:df4b:4b94 with SMTP id 98e67ed59e1d1-32166c0fb00mr4749682a91.4.1754497208918;
 Wed, 06 Aug 2025 09:20:08 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:19:57 +0000
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-2-jtoantran@google.com>
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


