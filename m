Return-Path: <stable+bounces-253946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGkfOXW5EWpupAYAu9opvQ
	(envelope-from <stable+bounces-253946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:28:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD75BF5F4
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E2633018ACF
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FC63A758B;
	Sat, 23 May 2026 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmx0isqK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C13A71BB
	for <stable@vger.kernel.org>; Sat, 23 May 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546440; cv=none; b=dRGB/SNuanofgkYcTU6TYzmC/goB5/UeR2Yi4GeDeNtpJn7/Lf5aG9uZbJ9i89GBcOaBBbwZz/QSOjfFZ0Wn8Oa9uiu6Q+GYvKxE8198FT73fjciMc0h6/GLc9BlQk7mdTkOg3SzHUrqoTOUpLZyFlpit8F2HXLl7H0UQ5ZSIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546440; c=relaxed/simple;
	bh=D3qIhb6eGYYsATz1C0SUhXejwGUftqdytivMY0DlgC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKmSa/laTHRtS2/t86TNhbBozB73bPG6GaGMJQCW6WSoPCb0NFbRYHprbCVUdPVkrpusI5VdD0AeYim1l3n4KTR3Wq+Tl3Zosnvnt9QJa1MqfxUSPDc6ZP5CrqfT2xMbp8FfYQakCzcj554MWiJMQvjAvwskbCSniS9lA+Vwioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmx0isqK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c736261ee8dso3860082a12.1
        for <stable@vger.kernel.org>; Sat, 23 May 2026 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779546438; x=1780151238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzFTxVPO2bV5wPss4Z0njUQ82fwBRkchQ0evEohJCFc=;
        b=dmx0isqKpIqFEcwpAURxxuhUlQKjV9SNy3fNevKsNJNcBvZdBIlxBd6RjD+nfvSulQ
         MOvYraLZ9AzPV4eQ50so+cmLsA6xB7HX+IxWbaGZ+OYux5+FdwOsd8DUuNARRKGNbnW0
         elc4DN360xDHrNIh6HeoGHEzh87dj6Z3hyOy1VV814ehomZ7tf11HqHg+FDsWcHkpHpp
         X10B1x7ePwzrjm4LiyvNvH+5rN/wE6+dSOt3vO3/PbHP4iBPFDpWgNbzanig/K9ceAar
         XidkHISUzAFkoHzB/ojPuaozGFrYCXiuv8xJpGRCA0hR60Flel3aMLGwJuBLoHsjtBjR
         VSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546438; x=1780151238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzFTxVPO2bV5wPss4Z0njUQ82fwBRkchQ0evEohJCFc=;
        b=X8rhqAByyTuPVRCoRmSXS56FKEhoGqIZOzOlRyIWsoYu0ehduHv/0pXoLRXqDl6Uo2
         vDqcf2k1Ikpgw55qJLYrOfU9yrCanHFiwtVwOBdIhzvd19jCghkFV5rf/mWhWTZD1B2E
         WdZpOVs1QkvLisd2aQ6bFoqPLWill1zkD9AmPm8Qzwx7oAuEvS6r6w8KBnS3z1VV+Wjy
         +pFl0UHTdUQ7ao1B145nL/BIWMk6H6qP1aQoChw2hJ+8Npx6S/2m8WtvAq2zzl+vEnwR
         Hui0BjOpKHabvGBw9ssLDdqLU98g1Dp6NbfaXqcdqcncdcp+3zXQ/p/mQSaE5kbQ2rTq
         dAGw==
X-Forwarded-Encrypted: i=1; AFNElJ8KYi+LpEEt4Y84xmAqocwPq606fMKy731bC+vau5SanoWuwLiE/jpl3Nv2DSLaUlVNJJrP+c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGx4srjyC1oveARm0V37FfCwrksgFLnHV4v6Fc3EpsCU8vxv7r
	3ZwLGkA8rogQV8Re4SR33SdU13PgcCskeFVxaWpl+lq/lxdBOWZVwUBg
X-Gm-Gg: Acq92OGC0OsHrWMEdORDaGdqfZfQlweQlWiOaJz70GXFuNTUM+1g8wcKVBoXfGJL4Uj
	CGtVk+D/J2kVAUnDvda+44txjiX2QgtrD0vmzf3Ulo7KODeFiDxsxXkYst7KTEMvi1L7p8Lth6F
	L/glHC8yoOgSd6crsXwgwnta3rS7ytx8hkiN+5QigDzVlDTJTM8Z83Io3nOTgE4+W9q2wS7jXQ8
	s1fRrz4wMePV6ZA0CT2XC6juQThONQeEV0aZ6dgsJq4J34g33W8z/wVcQQioPO1Xc65cQdHSK9y
	ZZzttjK5LZzrz58Rvmp4EJNO0u+7ABIkoGa/vMoNIPpo9UNu3qp+zaMScmJrvvqq5IWx0tiy3xF
	cqlBV3zxTW5jO1bEdDwRRfWOx7QolWpQLDKsC/FbnBOrAPEb0FWRrAncdpPiOKGLVJZOHhLr536
	g8ZSp9iTtvMT6ceikX3A42aOeknCefLXb/c7ELXa1UTYOxcboAWEcdn3mc1UEJ6Tx2qZn8NqvnB
	Vo8riSMRwNYVRXtGwEKd93CqlUqr5pf0a69V9ozJJT9juO+e3NrbCniD4rQDXidkLHeYEciYX1n
	5XWSfVnwMIhsVEa7/54i8y7Dsw==
X-Received: by 2002:a05:6a21:32a0:b0:3b3:216b:274c with SMTP id adf61e73a8af0-3b328cc44f3mr8711006637.22.1779546438447;
        Sat, 23 May 2026 07:27:18 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe2dasm4875597b3a.19.2026.05.23.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 07:27:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Felix.Kuehling@amd.com
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] drm/amdkfd: fix integer overflow in get_queue_ids()
Date: Sat, 23 May 2026 14:26:45 +0000
Message-ID: <20260523142645.39102-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253946-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87DD75BF5F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_queue_ids() computes the allocation size as:

    size_t array_size = num_queues * sizeof(uint32_t);

num_queues is a user-controlled u32 copied directly from the ioctl
argument (args.suspend_queues.num_queues or args.resume_queues.num_queues)
via kfd_ioctl_set_debug_trap() with no prior validation or clamping.

On 32-bit kernels, size_t is 32 bits wide.  A caller supplying
num_queues = 0x40000001 causes the multiplication to silently wrap:

    0x40000001 * 4 = 0x100000004  ->  truncated to 0x4

memdup_user() then allocates only 4 bytes.  q_array_invalidate() is
called immediately after with the original num_queues value and
iterates 0x40000001 times writing KFD_DBG_QUEUE_INVALID_MASK into the
4-byte buffer, producing an unbounded heap buffer overflow.
q_array_get_index() in both callers walks the same buffer using the
same unchecked count.

Both call sites are affected:
- suspend_queues() calls get_queue_ids() unconditionally
- resume_queues() calls it only when usr_queue_id_array is non-NULL

Both callers already propagate IS_ERR() returns to userspace, so
returning ERR_PTR(-EINVAL) on overflow requires no new error handling.

The copy_to_user() calls at the tail of both functions also compute
num_queues * sizeof(uint32_t), but are only reachable after a
successful get_queue_ids() return, so they are safe once the
allocation is correctly bounded.

Fix by replacing the unchecked multiplication with check_mul_overflow().
Cast num_queues to size_t so all three arguments match the destination
type, avoiding implicit type mismatch on compilers that implement the
macro with typeof() rather than __builtin_mul_overflow() directly.
Add an explicit #include <linux/overflow.h> rather than relying on the
transitive pull through linux/slab.h.

Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process queues operation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e0a31e11f0ff..c08ad718dbd7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -25,6 +25,7 @@
 #include <linux/ratelimit.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
@@ -3308,11 +3309,14 @@ static void copy_context_work_handler(struct work_struct *work)
 
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
-	size_t array_size = num_queues * sizeof(uint32_t);
+	size_t array_size;
 
 	if (!usr_queue_id_array)
 		return NULL;
 
+	if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &array_size))
+		return ERR_PTR(-EINVAL);
+
 	return memdup_user(usr_queue_id_array, array_size);
 }
 
-- 
2.53.0


