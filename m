Return-Path: <stable+bounces-238592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1R+REeqR42nSIgEAu9opvQ
	(envelope-from <stable+bounces-238592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 16:15:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A584214D8
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F18830269FF
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4038757A;
	Sat, 18 Apr 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdjIOTme"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB638756B
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521697; cv=none; b=H7Hnel3xMI/cp2IyUY5FphldBJtJy/UWPM+4ZRmkMrl3nsY+pqHBRBwhf4TwMHNweT2OQkYHLnLqvrsN9EaRs6otkyn2hKbaj9wsycJlQOTQdRqyJ4ONt5dG2r26KXL+ymvgWhltmFbEHGeyfwme+I3AjSF5BAufgBxncKoU5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521697; c=relaxed/simple;
	bh=0vtjriV52OS0LoUh9dRcGhTFFLQzBz/Qdx+0KfnsHN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWimZMmVfGlkAwogYqxemvo7G6Kpaez5WVjYYz6vMHWM2VdefEIXd5hq2LXKQoYJwvRe6f4eSZK/s3QvRZpvhPpTDTNorlCyIdhrR46H1XXgFF8bX1FPtcmuSJ5mfBCnvfrD3TNqmizdm41n5s6l/+sDWaixUk/qIZVhZtL5jDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdjIOTme; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36143b0dbdbso869824a91.2
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521695; x=1777126495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmK+FaYBx8F8lD/RxIKvrljDvHgFNEYIgLZCmJZ8B00=;
        b=RdjIOTmeyWUGooS2XfdO+PIoMhg24CjgwGrN8fqA+aR7zNpGrMwx4oINawsLFzLlvr
         h1ezg58JySsMO7fliFQbe48fBqEiH2dNMfRgwVC8OPhMb0CTChAiptOXliuHV6mck74k
         CnkL9p2+S9F4Zqt1r/8RkEt1IxRqWqk5oqIs9sNbDlbCv1Y2tcggfT6A+8oLtSCfl1x5
         DKWDDCCbwe5tM+WMFmFr/iYkWHTfl7ZqMg3CXhE71BY9xy7BdlUl18tFqaDigGxAdt+6
         fjIiFX4oXB2sfyVwybc1DBfw1dDpftqd6FtevV1P9GUmuVPD8qpEi5TdCmb58enlibH2
         1cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521695; x=1777126495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmK+FaYBx8F8lD/RxIKvrljDvHgFNEYIgLZCmJZ8B00=;
        b=eOjxWz41sZLZy8kksPrZmzSIC5qBrfsKBlyT1bOU45MxWDZTFlg5SII1rQaDtVJI+R
         fkCsb4otKueb72yDgkjYmoCaHqQWO0uRk2y5puqyGDjA64b2M2tTPeUjFOCt+2yKbval
         FAFVo4OlNP9t1C3jjMB3nHa+GZRbvOxLJQNBXr06GEuEhkPs8I2xHebZg1OzJ6LaOJcd
         Didvsm3jE4MD1utolwhMORjhhMFF5yre1tsK/G02qOqNacb+OOJNYRbZjm6U/U+CvTKD
         z3SxQAfVYp8ILBLeruHcTaACJ/0+XXz1llz7GVsyXZ/9XIZbNMwWKcP3XH2H7QLdf9zB
         9Xyg==
X-Forwarded-Encrypted: i=1; AFNElJ8icZcn/V96mAkiRmQujETwo5sd7yT6/1RGh3/r2yXm0wxpukp6cv0lLGaTL8xpy6gpa9+NB/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19OAzlRUaFuqW/7DsKXRLbs2iQDvFRWpv6ZuXmwYq9QESuD/h
	r+zPtJHVAaEF00R5LI4hmtYihLLL7cEpUuHeQcr8dmfk8fncgQksAzued0ODEA==
X-Gm-Gg: AeBDieu7/wDEBCtArvS7aaj28QZJMqQcydYg3NqDF6e4PiLgsojK4QsZk43frw65gW/
	a/8a6COT5dN8QX2PWDXDU5h641ga0ohFwZVSa2Bha7Tg2YV39QEL9FS0NCoonaq4/u1OC2hKLGZ
	L3laEN3wV5HQ+mo6JjWS3w6M5hIWZavmeiXVPHvz9B217lHsAPwnqlNuzcw9+k8mx8aUKdYxAbG
	x49TlqMRsmtSkfNZo/lKkGPsvOpvbGB3w0uPCrztyr8CcWfFcyxvgA21Ojs6TVRmXtMFVDWhXSu
	kUDmpTQEhXjqbV8jn1PoFJ++2pzLRayRiCOjLzXtIAc8XFDi/lLar3oN7lS//KRLCXhEogN9UmQ
	it7YEio87AFJTbfJROdZyGHmFjCV+iwbQtXKrgt0zqFc+ZEzOD4m9j4M55q19XYezCncUbbqehr
	rxcniYtxDJ19qP5efQSrpmPGA7sheOUBjlN7yGGJuasfA=
X-Received: by 2002:a17:90a:f94f:b0:35f:c5cd:cc5 with SMTP id 98e67ed59e1d1-36140498686mr7739972a91.24.1776521695534;
        Sat, 18 Apr 2026 07:14:55 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3ba16sm53389995ad.75.2026.04.18.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:14:54 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org
Cc: longman@redhat.com,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] lockdep: fix NULL pointer dereference in __lock_set_class()
Date: Sat, 18 Apr 2026 22:14:50 +0800
Message-Id: <20260418141450.1499057-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238592-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gxxa03070307@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: B8A584214D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xiang Gao <gaoxiang17@xiaomi.com>

register_lock_class() can return NULL on failure (e.g., exceeding
MAX_LOCKDEP_KEYS or lock_keys_in_use overflow). __lock_set_class()
uses the return value directly in pointer arithmetic without a NULL
check:

  class = register_lock_class(lock, subclass, 0);
  hlock->class_idx = class - lock_classes;

If class is NULL, this computes a garbage negative offset that corrupts
hlock->class_idx (a bitfield). Any subsequent hlock_class() call on
this hlock returns a garbage pointer, leading to memory corruption or
a crash.

The other call site in __lock_acquire() (line 5112) already handles
this correctly with an explicit NULL check. Add the same guard here.

Fixes: 64aa348edc61 ("lockdep: lock_set_subclass - reset a held lock's subclass")
Cc: stable@vger.kernel.org
Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 kernel/locking/lockdep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d4c5bab5af8..e0de81114824 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5437,6 +5437,8 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 			      lock->wait_type_outer,
 			      lock->lock_type);
 	class = register_lock_class(lock, subclass, 0);
+	if (!class)
+		return 0;
 	hlock->class_idx = class - lock_classes;
 
 	curr->lockdep_depth = i;
-- 
2.34.1


