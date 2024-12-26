Return-Path: <stable+bounces-106165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1AA9FCDD0
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 22:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C591160E11
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 21:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75818A6AE;
	Thu, 26 Dec 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2WZLKhh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B733E1
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735247804; cv=none; b=tL1YOCTvfYjCPJiGMYyJquQI9V3Hb/zAT+SZ9NOTOV1co34JqmcmHKJ3B1bpyq4xcxC3lXHTtuLLMqJw8jCcu0w1sNA+1ks9Hw5ekd83nZmBTg3APp4X+AigCOyBkgh45P0VPevanZn+bd5BK0gnrsZMkMb04OtqKvd3Ygki5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735247804; c=relaxed/simple;
	bh=VRwMCA2zwBkJYhRyo6JEOwDMDKc61F8Xp5wOAWP4wcA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bl8POjDU4RVPbHWPTlkl4LwvE2PecMBO/sRrBSq+ovmyay/GNeY/exEVNsc082X9kOeqQgJpqcrE2E1Qa01LJZ+0ObmQ0fv5Ix14AO0NBBT8JALDFYJswJPy6E1DjBUBQN4kT8NVVPlshGwXo/wok+M99pz0kfnQZhnGapKgA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2WZLKhh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21681a2c0d5so69690375ad.2
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735247802; x=1735852602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q6FNZCc0sjlAu9/bhUu0wi3B3hcHiZVxRsWdZ9fDpqQ=;
        b=U2WZLKhhc145jEbYIu9lN5YVv2iAYPMfC3MlYgCj0RZ9p6AVEuhkcDxncadLXhkbUl
         N9N2ooZjyDZ+bhAp9vcpy329rnQ5UlJ4mHz0Amy2cfEt/RPJZQs3RPoNDxMGIrCs6fTG
         fL8qNtTE+8Nm9EWk5fiCL63weZvTxmDzNCFXOqZYI65XeF/JoUQT/w1G7Dw5z19RYVkD
         98ysuL+J/vhqDJ3ZKkv3lAdnbBREFftC5XFbWxkfa8y3ETp7s63j7Bm5r7VLosLz/ZTS
         oPUEEUc4fZUYkW3lfm5StA3aJ8N3T7AhuIrseDIoVUH4hE1LtkTKv39d78RiiyiyDeei
         P0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735247802; x=1735852602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6FNZCc0sjlAu9/bhUu0wi3B3hcHiZVxRsWdZ9fDpqQ=;
        b=gmKEyvINIQF8C/Ls6pj5Kbw0CF+8thlGh78IrsmC9vXiuR9Y//IUbNVLX32lhQQrmL
         OKf7hu1kcCgxFnqlmn7eqmOyU+13sPIzhZCeGTvzmNw8snYf5ID31d21wQpwDqr885eB
         N0OB/eJ/M7qXsyD4sItM6HHGkdeO8v7lWVosG698qTFVZWntD5v7gMI9kYTg+qup8Xv5
         Jxz6ppLg4rkMBoZaSF9gt8uqURRQDO2j87OwgRAyuCTzkLB7Ieh8oBSl3s5xkQQ/sorw
         Y9Att35Dgw1/18SetEvSmJy74lm69gr0BCkV1SpRwEhrrUis2PNrV7LkzrPKfApZPq2r
         o2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW+acQGEW/X0rSZMYiU7KIlvvvThZEI4Jx3uaEeF4CC7lX/Mowj4gcczZwHVe4NgXEDcjpcGP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKaruHDtUuoCRQ2BSa+bX8g05hVXHDSNUg6NJ0cPneUfvQtBR
	ttOHYQWGagBT1SHTrrj03TxGIGk9dXI1ZVT+B8Z1ATkJU4lzuAkMUDAB+crT54UXj7BAV75B/93
	URQ==
X-Google-Smtp-Source: AGHT+IGsluvjCQPIRlC11GbC/0U5YyE5MLWsBDKc3jJjY6kkkDpn4HpS6bMUSx/UCZvtrYHO7zXLvRubfMA=
X-Received: from plly7.prod.google.com ([2002:a17:902:7c87:b0:219:21b2:3071])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cf:b0:216:2426:767f
 with SMTP id d9443c01a7336-219e6f25d6bmr291166905ad.49.1735247802375; Thu, 26
 Dec 2024 13:16:42 -0800 (PST)
Date: Thu, 26 Dec 2024 13:16:38 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226211639.1357704-1-surenb@google.com>
Subject: [PATCH 1/2] alloc_tag: avoid current->alloc_tag manipulations when
 profiling is disabled
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When memory allocation profiling is disabled there is no need to update
current->alloc_tag and these manipulations add unnecessary overhead. Fix
the overhead by skipping these extra updates.

Fixes: b951aaff5035 ("mm: enable page allocation tagging")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
 include/linux/alloc_tag.h | 11 ++++++++---
 lib/alloc_tag.c           |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 0bbbe537c5f9..a946e0203e6d 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -224,9 +224,14 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
 
 #define alloc_hooks_tag(_tag, _do_alloc)				\
 ({									\
-	struct alloc_tag * __maybe_unused _old = alloc_tag_save(_tag);	\
-	typeof(_do_alloc) _res = _do_alloc;				\
-	alloc_tag_restore(_tag, _old);					\
+	typeof(_do_alloc) _res;						\
+	if (mem_alloc_profiling_enabled()) {				\
+		struct alloc_tag * __maybe_unused _old;			\
+		_old = alloc_tag_save(_tag);				\
+		_res = _do_alloc;					\
+		alloc_tag_restore(_tag, _old);				\
+	} else								\
+		_res = _do_alloc;					\
 	_res;								\
 })
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 7dcebf118a3e..4c373f444eb1 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -29,6 +29,8 @@ EXPORT_SYMBOL(_shared_alloc_tag);
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
+EXPORT_SYMBOL(mem_alloc_profiling_key);
+
 DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
 
 struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };

base-commit: 431614f1580a03c1a653340c55ea76bd12a9403f
-- 
2.47.1.613.gc27f4b7a9f-goog


