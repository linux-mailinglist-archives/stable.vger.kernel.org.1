Return-Path: <stable+bounces-3669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4544801186
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D73D281BAE
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D94E1B4;
	Fri,  1 Dec 2023 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DM4YkdGp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F1ED48
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 09:22:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d04d286b5cso8931315ad.0
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451367; x=1702056167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VC2uJLzEqyfXA07DP6aRcEwY5WDZYJjFpRfi6yvMkTY=;
        b=DM4YkdGpaS+Q4/yBF4UQ7iF6WTlEMj4+z4R6cDBPMZOrlBrBkCtTGniUQ6rSvNfH7z
         kp3iOVYyXQuoieP7RCz6lXojvaRY0OBSIzC9oZV/Q/GIa0H6EOBJCHR6XF3NHflK8i/C
         X54aVeJ20Uib0ooDcDRg4LMEIkyK1DxW/ApZmB0t1zHrli6lDWMIexG1wpQ4KFZlDab4
         JR3vHbveX2MhCQ933OEBI7BlEVI8RVLJuvsfW5I/GOtOXn2FZP68uLw9u1LMpcYP6GxM
         ct0aimurUfOBHvxNy4ZUHVcAuD5Q8JueDR7AEB+gZ0k8L86jBdX18ORkkQzn+JAsGinY
         ElTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451367; x=1702056167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VC2uJLzEqyfXA07DP6aRcEwY5WDZYJjFpRfi6yvMkTY=;
        b=g3wuc1BPo9PAy8ebFZKMCmcZ/iEHysF0fUIveV2WUCX+RpxBMPWPJ978B0z4805BEO
         qUq4vAgRhrMmTYTDNeMuttGQT4EA6FbHCgX2PoLRGfHYboSfhwI7lmoJAHNaWLW2AAxg
         p0keclvLuAyYfoPDOsOW5aT1D7dFfLxUnD6Mxu4pXNOmQ+unh0rdfPZLozgs9Tl4egUe
         8dHtFMNZct6k3ipVnhTP84rWPZYUH43hhe/Grf55Vwwnmo1+rbiof6LJsboHnuObp1Rg
         KRvv0QLa+G/zB4QkDVt0Bmy37qd69hV9KdwEDavGB2WFOIFhJ7Sm5Xjba7NG45Igk7o5
         tS4g==
X-Gm-Message-State: AOJu0Ywya34G6qQy/zJqDis6JzZD8aZgSIQX+nQNZ2xf31UAq+2g71sH
	X2FsXfbosr2lXyygp4oMaPsL7kbl35hRwQ==
X-Google-Smtp-Source: AGHT+IEkcV1p6eqdu0bez7LWIawyKVoI1FER2wUkLTAiVsOWMewcldTbRdmYDL1RqOrJrrmFZZ1q2xec/67Bmg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:8644:b0:1d0:3090:957d with SMTP
 id y4-20020a170902864400b001d03090957dmr668283plt.11.1701451366752; Fri, 01
 Dec 2023 09:22:46 -0800 (PST)
Date: Fri,  1 Dec 2023 17:21:35 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-7-cmllamas@google.com>
Subject: [PATCH v2 06/28] binder: fix trivial typo of binder_free_buf_locked()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix minor misspelling of the function in the comment section.

No functional changes in this patch.

Cc: stable@vger.kernel.org
Fixes: 0f966cba95c7 ("binder: add flag to clear buffer on txn complete")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 9b5c4d446efa..a124d2743c69 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -704,7 +704,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	/*
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
-	 * binder_alloc_free_buf_locked(). However, that could
+	 * binder_free_buf_locked(). However, that could
 	 * increase contention for the alloc mutex if clear_on_free
 	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.
-- 
2.43.0.rc2.451.g8631bc7472-goog


