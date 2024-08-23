Return-Path: <stable+bounces-69925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0FF95C2F3
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 03:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE36E1C223DE
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 01:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3631BDD0;
	Fri, 23 Aug 2024 01:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mvqd39yN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0B171C2
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 01:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377607; cv=none; b=iyNpCn1fgeU8Mwj0Z2VfLVEqJWK0Rd55ifNGs9G8mw+x69qydL/PXxfYhuRfmvS6n8fiXVNdpz/Apm64ogwYso0Bdcwl6nYdq0UaWXhVQsjjKLaGEdriX+lmwce/wLnQmITRL0piLPBn6kOmorNzrVL/mO1t01Ut14hC7q0v7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377607; c=relaxed/simple;
	bh=sGl2nL6mq3MynEP9qoi7xkphD3I99W2n1NgVTRy6SXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dzu9k2WAyGLLyDYvHLvCnuYeN5Y6TGZKDDOLVOzRPhy5ieNmqvjMZajnnP7s3cHQWyf7Hg7PMR4JfYnUwgSBNvgW5mUSttxpAh5YAiLQytSTldwqYCGcWPuX1tmuhA/aIh3orNdk3oIDZRTLiUPBm4NmC1YD2psN1r4w+dFl6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mvqd39yN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718706cf8aso677387f8f.3
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 18:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724377602; x=1724982402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sh2/784i7y6ih3W1qXtxCpk2D8g/ZXKSQt7qq695bYg=;
        b=Mvqd39yNxVMa9etvhhkC1cUvWjE3u2ap9noWLuuF7vp1W9bCdftDZuIeGC4GNrMXzY
         fi2ZCzBTJME8KXAoOrUydWGrr+EHhMvuE5EHn6pRO4Be9YjvX1I8aQnjdnDIhvkoNwbP
         FVnCLQ1010J1COXWeYwzQ4hD016TeXgCWvvv++NGLDkSImSRzEkkMI3bTfIs6oEhr+SS
         DiXRE3taAi1VhbRUbt12LXDxkZnkp9Rneb045XV2veroa6MO1fYZnStyMvZ1rhnD6BsZ
         86hQEj8lQYv83mdT82QnzInSsXilZ+205js9t/uhXVp0Z73ruLbfeYrKQOQQ93cA1Yot
         V2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724377602; x=1724982402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sh2/784i7y6ih3W1qXtxCpk2D8g/ZXKSQt7qq695bYg=;
        b=werCnM/7BsAxIxmdF0JL1R3wIngZLLz0FMy8GL11+VNVY9SIbtgu/s12Ek7VZa0N9k
         Ff+VsPLICNz88xR4lHAHmWuB+r+gy4UgZDpb9YnhnKU6kULMOvv7U1BD+AhVjYteAved
         gvwoYbZLU0xI020vYkmO3G/Q1618+aUe/XndaPhxmRGmdTokivU8wo7gja+Naa+Vn7jc
         phoSh83Eh4D6oVpIfg763jFmiMuyjy+VoI8Q26v/rIDBAjJmyD57yOnhu94DCv7ODAdY
         AGbMmK61mBvpYddF2eu1FmoLxojvTNLT5Z+uXwHMDmvSzxi35JwEP66pdYUJU2z4B3gR
         Fukg==
X-Gm-Message-State: AOJu0YwSSqMoD6aiVNyyLkgnnuZ6ZFhwkIhw8nvkiPFkJbumIYRQj8Gy
	NgsQNeR3/5CsXEnJXiS4dZbwqD2u0urzC+d0Tmv0BICSCYrf03Qo2qtBcVEdBSL+BF3DyIJ5sxz
	ErDQ=
X-Google-Smtp-Source: AGHT+IF7CyDabRkMdoNMuAnD2PW4KlZA09KkyuQsdjJy5JrfXQJbkF1i2OMKkT5iHdDF8mZqXFiDdg==
X-Received: by 2002:adf:e3c1:0:b0:368:669c:3bd3 with SMTP id ffacd0b85a97d-373118c84fbmr317594f8f.48.1724377602318;
        Thu, 22 Aug 2024 18:46:42 -0700 (PDT)
Received: from localhost (27-51-129-77.adsl.fetnet.net. [27.51.129.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7144401ac8fsm378324b3a.19.2024.08.22.18.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:46:41 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.10 1/2] bpf: Fix a kernel verifier crash in stacksafe()
Date: Fri, 23 Aug 2024 09:46:30 +0800
Message-ID: <20240823014631.114866-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit bed2eb964c70b780fb55925892a74f26cb590b25 ]

Daniel Hodges reported a kernel verifier crash when playing with sched-ext.
Further investigation shows that the crash is due to invalid memory access
in stacksafe(). More specifically, it is the following code:

    if (exact != NOT_EXACT &&
        old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
        cur->stack[spi].slot_type[i % BPF_REG_SIZE])
            return false;

The 'i' iterates old->allocated_stack.
If cur->allocated_stack < old->allocated_stack the out-of-bound
access will happen.

To fix the issue add 'i >= cur->allocated_stack' check such that if
the condition is true, stacksafe() should fail. Otherwise,
cur->stack[spi].slot_type[i % BPF_REG_SIZE] memory access is legal.

Fixes: 2793a8b015f7 ("bpf: exact states comparison for iterator convergence checks")
Cc: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Daniel Hodges <hodgesd@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20240812214847.213612-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
I see this patch itself was already picked up[1] by Sasha. This thread
additional includes the associated selftest that was sent in the same
series (not entirely sure if backporting selftest goes against the
stable backporting rule though).

1: https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/queue-6.10/bpf-fix-a-kernel-verifier-crash-in-stacksafe.patch?id=e1b8b4a2ab5985f048c5e4ba7575deaa7bb65df7
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a8845cc299fe..521bd7efae03 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16881,8 +16881,9 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		spi = i / BPF_REG_SIZE;
 
 		if (exact != NOT_EXACT &&
-		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
-		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
+		    (i >= cur->allocated_stack ||
+		     old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
+		     cur->stack[spi].slot_type[i % BPF_REG_SIZE]))
 			return false;
 
 		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
-- 
2.46.0


