Return-Path: <stable+bounces-253967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGLfD8vcEWq+rQYAu9opvQ
	(envelope-from <stable+bounces-253967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:58:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6FC5BFF1A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 18:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B94C5300FB0F
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D0431E839;
	Sat, 23 May 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxqkILx6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94431E83A
	for <stable@vger.kernel.org>; Sat, 23 May 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555458; cv=none; b=kbY1gpJ0zZcBu3qDd9butBCTE4q9UZo2h5iXSg9Z9u9fvkHZe7BtWx8Q+sX048AheiUzPpX3r3V/WNUhEFNVLNPUzFSsVyXOrHvn9+zPdbn2LO/yvkW7Uo5Gv0TE0t55Zkf4DLcQNdETk4sOHplmZiYbWsVBa4ktq86WcWqvr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555458; c=relaxed/simple;
	bh=lCl0yF0ww855jeIH3gsLh7TbeXfdKeQ8X5P5XfRSJpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cea4qgvp5HiZLm3Yu6PLO514leYrnvtPK3m1TMMalMMLfV9boekF9AoA224gIkzFhOdh76J/BCyzPSTAYTvfgerRFzanQDC+YEVokGkDPWD6Zu1rwQmmTqUpX22uRhl8nT81g+MTW1kSlnQOSfn2N68LbaAx+qLYghXiPKPssF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxqkILx6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c80170db7d6so3444126a12.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779555456; x=1780160256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhLvA3TfrJzOyIZPC1ppqWVZ5nG/suASGnYJNqiPlkY=;
        b=FxqkILx6R/DjzLgxIeX83sv7RSVulO3oY9AFm4rQQb7ww48ZQ8igzMsBWRKVFbvxK5
         xoH4oYOuKyyvohSG+z+e+3+R+qutvAjAAn5Vx8akp7yuqqJhwi64R6hqpAXxK+2t2l0K
         UiXsqwIfZvdbTOYGG7ZSMIAhOPlldhuvzAGEMy4NJdAUHpZF6JnIr8Z0RuQ5DCHcvkSG
         0n4pypYLNTTDdvZUoFl2+yvrKC104/lX019MvGnn4dsj4R3zi7LgKhck5oRrHk3jweJ5
         0t0D3lc3b1O33K6lxtM84uAsRfM03tUPZE7LHeNoCdDKYmcVae9WHdZYkDz2Jbid4A8a
         5o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555456; x=1780160256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhLvA3TfrJzOyIZPC1ppqWVZ5nG/suASGnYJNqiPlkY=;
        b=Hf8uIYNLzpe5KEnb0vcmVcGc6TJaTsxiBhm4XMBAST8dYBpf7l3urdYlZuHhVFUwqy
         zDgVTe/UBH80IKwtgkK67m8eKD747Yn5Bo/pvWH2cot/YxWaWLL2KZdf0qs4mvrfIiDu
         AMS3dkNPwGLT4TR1047qRHiMEd+wUvA8hypVb6UbX4tjoOo5MTUSmqu7xWorXK7zwx9b
         DAoWz+RanI5o8QA/4/OU/x3AKn5jqjuCME134gG3nN0C6I1GgCwQ8mb3n+u0C3G+AbNk
         72gZPcHxmJjle7xGR2Wf7faB1ICPk92ccqi3eL19keGv1fmJwUVxfAfZsaDMNIPYUc8S
         rndw==
X-Forwarded-Encrypted: i=1; AFNElJ8GHCyEL/vgS0mqeG7FKzNtgkwAQk7H8i9xG0IuXQqEKZAZWOtN1gs8ivOZxLcJEnPcib0iETw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzViTuHbmbfxSLO8Zvhl8fmEikYlFFsUGEb8YYUltqHxFabz7Pn
	ykglxR4bJo9dUqJnVI90pZnBNXJs2EWvHposGRxZ30UtYXwUWYVHLLHE
X-Gm-Gg: Acq92OFL3btCwk3Swc9ky5en9qaF7sEheQ+kmKzFeIhcso2j/RakfwTVwc17m6jGcfI
	OHy0TBnFJ1zT41ZUBtP7jMyFGPviFDF4U1m6zNvEfbPVlRyCj1+4PSmyJDCdxSXBbS7AMhUO8PD
	9x5wumF3JzV5lIC4y4USLie8HDb5mLeNW2wT6uo0PVDKaAxguimkrGtJXFBBMqc0FEryMCJvVXL
	AbgjCrEo9CR1ATnnuQgyARfTXUrqXUipd/Gw52bRJq0TXjmIwFOGTkukijt/wXg3vLghhIFRdRu
	kXEx6MZMRxbur3DwHoTcazT7eUoIm6GlM4qKUcoEnQxYr//gdlPUFEKfkwpe0Xqmm0+HMKSSRfB
	ndTQs5a2UNZK4n6PGES4sZr4PiavKtD8vANEjk8iEfFku5eX7Js/VXCsqDJQM9ijKWYVRhiIFeG
	NUHRU7nHWYAnr9kDtfxoickdwasHixYarFxZm5Vgdfbkm0TjW1iym32Wr3ESGaMmY5p8UjNj2xP
	xuX+BY4RMy4HCVfqOwyr/njBq7TngFcMdLfBWb+tPjLPwOmKivmLPlEYNn9HNrAABTzoOJmdOzY
	N623RdA8WSA=
X-Received: by 2002:a17:903:2b0c:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2beb0582ba0mr82866055ad.0.1779555456134;
        Sat, 23 May 2026 09:57:36 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm47832065ad.59.2026.05.23.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:57:35 -0700 (PDT)
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
Subject: [PATCH] drm/amdkfd: fix NULL dereference in get_queue_ids()
Date: Sat, 23 May 2026 16:56:46 +0000
Message-ID: <20260523165646.25645-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523142645.39102-1-meatuni001@gmail.com>
References: <20260523142645.39102-1-meatuni001@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253967-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C6FC5BFF1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When usr_queue_id_array is NULL and num_queues is non-zero,
get_queue_ids() returns NULL. The callers check only IS_ERR() on the
return value; since IS_ERR(NULL) == false the check passes, and
suspend_queues() calls q_array_invalidate() which immediately
dereferences NULL while iterating num_queues times.

Userspace can trigger this via kfd_ioctl_set_debug_trap() by supplying
num_queues > 0 with a zero queue_array_ptr, causing a kernel panic.

A NULL usr_queue_id_array with num_queues == 0 is a legitimate no-op
(q_array_invalidate never executes, and resume_queues already guards
all queue_ids dereferences behind a NULL check). Return ERR_PTR(-EINVAL)
only when num_queues is non-zero and the pointer is absent; both callers
already propagate IS_ERR() returns correctly to userspace.

Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process queues operation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c08ad718dbd7..8488b3a6c2ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3312,7 +3312,7 @@ static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array
 	size_t array_size;
 
 	if (!usr_queue_id_array)
-		return NULL;
+		return num_queues ? ERR_PTR(-EINVAL) : NULL;
 
 	if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &array_size))
 		return ERR_PTR(-EINVAL);
-- 
2.53.0


