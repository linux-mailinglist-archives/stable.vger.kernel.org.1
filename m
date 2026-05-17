Return-Path: <stable+bounces-249075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKiVFzGgCWqLiQQAu9opvQ
	(envelope-from <stable+bounces-249075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:02:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D65609FE
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7A343002935
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B934EF11;
	Sun, 17 May 2026 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/F2fvRh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC015695
	for <stable@vger.kernel.org>; Sun, 17 May 2026 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779015723; cv=none; b=ryo0gSTs7eRE8CQ6AnS+HUTP3szF5K7kV+PfY+wWIqntlKQRcmxZaex7So/6pf+9nEM+f6MKeqN+ykPe1R+QpSSa6xuSgfExufuu2jW8+wDsLnfUf5tMyIC2ZB9/kWtvXFzxYpg6YtbOF6+T42CvglHqfUW9xjvyKiv28jd+VhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779015723; c=relaxed/simple;
	bh=eTdb565plt91PEiNuS67rwBcXAWzhTaoy3yOCPulguo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G8jCVbSI/amrT24rtGntceQuk0aL/+IMg32lJ7lX7XlbayogJmu9wsZ7zGJaNE3ULq/bFNNpaXZlFjGJF1LIf+houqGlt/yImx+YiPBi0mCduqDxfrw2XLfwxayCNU3/qL19LKdVTB+Sc4rCplJLySQ4h4aXDjYH+poKXfsZpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/F2fvRh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd21ffaca79so302644066b.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779015721; x=1779620521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAI1tCItT+prsS3BUZu8zZivM7G/QxPMste08XbQ9aE=;
        b=G/F2fvRhrSzMnWwhJUpXDJwhkAhmqWPZQwgUjbd1hJ0qnjwPKJwLhbAI+WNp29VNp8
         DSi9TVBGl1ukiMGaHpgMtu3U5rj+Plb1k4WVa03R1ii1lAf+NBCLOrtQNbzljnbMGqdY
         ZU1AnXKInTX0W75szopAv9RVyLek00Duc2q2PxfQ5yVcA9++6RdFCLxhkHbhfIHSoRp6
         +SSNAeo5cqEENnaARJEz3tgqJwx/rCj3Mtep37/K/ZUwnpOZT6NrYoo6P766r9wa2knr
         inWxqHWqoIacwne2ZswlIYiKe2BZAhHjF9MKESeji7AmcfdLYYd/vBk82r6kEcVjporL
         qPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779015721; x=1779620521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAI1tCItT+prsS3BUZu8zZivM7G/QxPMste08XbQ9aE=;
        b=lmrWZk9bai8JTUzuqL4w5maYHXN7TkTPKdR7ChOxXlCkNrb34DOYY5ahn6/eobMKtm
         mn9G9K+/OUy+aAsCPYaMvJpJqkcs4rSdG4Hl7fUDdlTlWkVz14gI02aSEqgdEFiEIVAL
         GY/SHi2Mnl2zZaSEOWADCgGBTo799uKxrg8qWq6OEOZzzzRJCT5BAoZtA/i8VoHwK8et
         qfF5+i63PwdOmgaHr34a6QOHreeX0ByeB/v27+c2Bqyvz4N3pYt1DR0h+9zQk6DzGWcp
         O/TRuvPtLKVIjYl3muR3VGOsxZUdyAnfLkQ6hOPucMGF/WVOjnBK45HXRlsUMWbFe6sa
         WlUA==
X-Forwarded-Encrypted: i=1; AFNElJ8k7oSAIL3CN6E9t/qWqjkCYTRddQQsRZ6CZWRpqczNRQJsO3+GCmHBTs7sgJQ+RYHlr5JnziY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySoD98aNHpkUfGzqtLQ84oe7VWBIOlZHF1mSy4FfLcH5JR9Cs
	gITcczASH1/a2BFB4/+tRbHh6TMJTSbhKW3bx6MkE7WATiYtWcO49LtJ
X-Gm-Gg: Acq92OEKCm4hda76ow0LGOLcliGFLT8t2khMdoSZKTdqIT5rQ/TEhDvKW+Ls+h1yUuf
	u3pvqa4DccvLDllhMr8vI9Inq1T0yZeu/CjezP8zw6zNF0aBLZ9CEyJQftPRDu/5nHpUaiOp5oz
	uaYHevopvsPf/zSGgEEGHyNH1sbVyRLrRaE8DFJLtJJJRJvDSXF5qikPv7GsRBHGBMLVBcpbvw4
	8qERMMeQJarsZIOusGWWRkr/7ExAlWfRQ6HlkBV8f3cOMSepunMp2nJWTEIzZ2zgWuKTTy38LiL
	RZsqYorqwNwNGFjz2cuiAjUYW+zQ5RTowh+3bH+STgQzca3EJLo5WeLTGlrls4rXwyhCfviyGif
	dO7WjDTMjO1smxLAgGWg3Ei0v+esn8ZGj0wfvOFL9TntXREDYaenHc1vpNTfrQIma+BPmn1ddrN
	l9dDJBuLt1ew5EB8gjtB25VDvSrptlqw==
X-Received: by 2002:a17:907:e144:10b0:bac:6585:b02b with SMTP id a640c23a62f3a-bd51538cabfmr387224366b.9.1779015720519;
        Sun, 17 May 2026 04:02:00 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c2a68dsm449437866b.18.2026.05.17.04.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:02:00 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ftrace: fix race in __modify_ftrace_direct() between tmp_ops registration and direct_functions update
Date: Sun, 17 May 2026 14:01:53 +0300
Message-ID: <20260517110155.21706-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A7D65609FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249075-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capyenglishlite@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

In __modify_ftrace_direct(), register_ftrace_function_nolock() makes
tmp_ops visible in ftrace_ops_list before entry->direct is updated
under ftrace_lock. During this window any CPU entering the traced
function calls call_direct_funcs(), reads the old address from
direct_functions via RCU, and jumps to it via
arch_ftrace_set_direct_caller(). If the caller freed or invalidated
the old trampoline before calling modify_ftrace_direct(), this is a
use-after-free in executable code context.

The race window:

  CPU 0 (__modify_ftrace_direct)       CPU 1 (executing traced func)
  ──────────────────────────────       ──────────────────────────────
  register_ftrace_function_nolock()
    -> tmp_ops visible in ops_list
                                        call_direct_funcs()
                                          ftrace_find_rec_direct() -> old_addr
                                          arch_ftrace_set_direct_caller(old_addr)
                                          jump to old_addr  <- UAF if freed
  mutex_lock(&ftrace_lock)
  entry->direct = addr   <- too late
  mutex_unlock(&ftrace_lock)

Fix: update entry->direct under ftrace_lock BEFORE registering tmp_ops.
Any CPU that observes tmp_ops in ftrace_ops_list after this point will
already see the new address when it calls ftrace_find_rec_direct().
Add smp_wmb() between the store and the registration to ensure the
write is visible on weakly-ordered architectures before tmp_ops
becomes observable via ftrace_ops_list.

On error from register_ftrace_function_nolock(), restore entry->direct
to old_addr since tmp_ops never became visible to other CPUs.

This affects all callers of __modify_ftrace_direct(), including:
  - modify_ftrace_direct() used by kernel modules and live patching
  - modify_ftrace_direct_nolock() used by BPF trampolines
    (kernel/bpf/trampoline.c) reachable with CAP_BPF + CAP_PERFMON

Fixes: 0567d6809440 ("ftrace: Add modify_ftrace_direct()")
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
---
 kernel/trace/ftrace.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a1b2c3d4e5f6..b7c8d9e0f1a2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5950,6 +5950,7 @@ static int __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	struct ftrace_func_entry *entry;
 	struct ftrace_ops tmp_ops;
+	unsigned long old_addr;
 	int err;
 
 	lockdep_assert_held(&direct_mutex);
@@ -5960,22 +5961,36 @@ static int __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	if (!entry)
 		return -ENODEV;
 
-	/*
-	 * tmp_ops is registered into ftrace_ops_list here, making it
-	 * visible to all CPUs executing the traced function. However,
-	 * entry->direct is not updated until after this call returns,
-	 * leaving a window where CPUs read the stale (possibly freed)
-	 * direct call address via ftrace_find_rec_direct().
-	 */
-	err = register_ftrace_function_nolock(&tmp_ops);
-	if (err)
-		return err;
-
+	/* Save old address in case we need to roll back on error. */
+	old_addr = entry->direct;
+
+	/*
+	 * Update entry->direct BEFORE registering tmp_ops into
+	 * ftrace_ops_list. This closes the race window where a CPU
+	 * executing the traced function could read the old (potentially
+	 * freed) direct call address between tmp_ops becoming visible
+	 * and entry->direct being updated.
+	 *
+	 * Any CPU that observes tmp_ops in ftrace_ops_list after the
+	 * smp_wmb() below is guaranteed to see the new address when
+	 * it calls ftrace_find_rec_direct().
+	 */
 	mutex_lock(&ftrace_lock);
 	entry->direct = addr;
 	mutex_unlock(&ftrace_lock);
 
+	/*
+	 * Ensure entry->direct store is ordered before tmp_ops
+	 * becomes visible via ftrace_ops_list on weakly-ordered archs.
+	 */
+	smp_wmb();
+
+	err = register_ftrace_function_nolock(&tmp_ops);
+	if (err) {
+		/* tmp_ops never became visible; safe to restore old_addr. */
+		mutex_lock(&ftrace_lock);
+		entry->direct = old_addr;
+		mutex_unlock(&ftrace_lock);
+		return err;
+	}
+
 	/*
 	 * Now that tmp_ops is registered and entry->direct is updated,
 	 * unregister the original ops and clean up.
-- 
2.39.0

