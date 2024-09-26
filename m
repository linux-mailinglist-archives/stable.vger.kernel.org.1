Return-Path: <stable+bounces-77843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F5987BDE
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041BFB219D6
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B71B151E;
	Thu, 26 Sep 2024 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0BRapTp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDB61B150D
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393816; cv=none; b=BIkBxjUFchKSIpG4cIe39xwqiCGCsGsHgug54k4X4jNu+AWWFluaCdFlumtIE2Q7Q0mnv2GSk6Et75v4YoUBw27kqgWUKsVal7e4zY+b0i2r5W2Ak5K9drxotbuwPw0T5wYemNOerpiWhzW1BhQCZJoe8E2FXw0PUmLktDNbzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393816; c=relaxed/simple;
	bh=ae5tTSVI1o+B0gCRfKTrz5iX28d2to5YMLSbIYZCEPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dEYs/PQ/DZstiPT36NCbecCTKc2Fllubxup+BWc+9snc0kQBD019D6yyYZTOG6mUEYnf6TzEI8BxrXilHEH6SbGR/NuDmz5yX/+KYiv9fzsmo9trB4Br9AhNgrKBY2/V27zrsTulySYK1dnOepjxauQl2k1o1CEuNIY6Q31NGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0BRapTp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-206f405f453so14741385ad.1
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393814; x=1727998614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhifSB/hHpukB8XTWcNXtGxQM9EjwaxZkFwn+v4ygvg=;
        b=D0BRapTp268kBCwO17A5hxMMWNJyXB/W7DPhD+Epz7uBRPMPwkG7v1GFU7Jis1oqdv
         ml+9v+9LdAp+fT9QSYno7OZj8VMNdjsd5SVSagm7aw+4Jhu10cKOIEAmj++hNBO7WagB
         aualwKnTSoLu3iocjBKwBcShVdf0xhEUm+ZTJwV3UEsqrU6T+jUoocH3pR6rCX7AGsOj
         al3hoIepio3hZlmfG3V+1dCrSbHFY560WYe4FJGqTaCOu/yhoqDR41SlWtB7HQ6dzysH
         XBuC3HU3SXCZD+54ClQhJzlXx01h8J6WNJu6zdtmmHiatJQNwAXUteRfp+N5PA8OwJjy
         crug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393814; x=1727998614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhifSB/hHpukB8XTWcNXtGxQM9EjwaxZkFwn+v4ygvg=;
        b=oTjk+t6Aq667fvWzwvfff4fW4Fl3SSoN32B4myqMJ0UCiPOF16k5ZdZfejHvWF8h5R
         mjo+Z67A0nOjxMKzLKi9kBxsm5sUk6Qk1wHYpqCQSma9/sWjAfj6AeVu2svvsONaKB3s
         SmkiKfbBLLtLEFM1+t42mWb9VIcrKkOHdKQ/VJJdUDjR3Tm8Y4aQZd22Pa+fXXlZ/PPZ
         K4DYNPdnuyBdVsg4bh/ZJ5D+Gm2XbzrHH95W+di0CRSi48ApW2J7iZWz2f1wMyWDljiz
         H/WnT6YH6B7WjpY3UJVJe3oj9OJykaMLNV/+SpF4T/DnIh3U+gu/duP1KIpg2XVpxNPd
         2qUA==
X-Forwarded-Encrypted: i=1; AJvYcCXkt3MbfpFvv/05X20l3l2VPB7gGfVQ47wCmDpBwvd7bIydOukO98DYCLpOPMJWy+tbhfDp6ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqm2NtkSQD0C8N7Ck5HcayTWNW9mS84FNB99f3+p6UoTrflAW
	oZ8bAupyOYPwC8GARMcmYy2ATH5RXrmMzqgnv6gb6UYgG8Gd4yVZ56Cx0tnrOoCoS31ccjD1mBV
	7Oli9iURArw==
X-Google-Smtp-Source: AGHT+IGMSmcCdezkWQqFnhS5J93mwv5qL82nJp4ZmV6uOtM7S8fzgPqEPRAjYDsO1Bar2n2ZoLLnn96gSc75qA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:d4cf:b0:207:4734:2cb7 with SMTP
 id d9443c01a7336-20b367e701amr149175ad.4.1727393813724; Thu, 26 Sep 2024
 16:36:53 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:17 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-7-cmllamas@google.com>
Subject: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Alice points out that binder_request_freeze_notification() should not
return EINVAL when the relevant node is dead [1]. The node can die at
any point even if the user input is valid. Instead, allow the request
to be allocated but skip the initial notification for dead nodes. This
avoids propagating unnecessary errors back to userspace.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 73dc6cbc1681..415fc9759249 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binder_proc *proc,
 {
 	struct binder_ref_freeze *freeze;
 	struct binder_ref *ref;
-	bool is_frozen;
 
 	freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
 	if (!freeze)
@@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct binder_proc *proc,
 	}
 
 	binder_node_lock(ref->node);
-
-	if (ref->freeze || !ref->node->proc) {
-		binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFICATION %s\n",
-				  proc->pid, thread->pid,
-				  ref->freeze ? "already set" : "dead node");
+	if (ref->freeze) {
+		binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION already set\n",
+				  proc->pid, thread->pid);
 		binder_node_unlock(ref->node);
 		binder_proc_unlock(proc);
 		kfree(freeze);
 		return -EINVAL;
 	}
-	binder_inner_proc_lock(ref->node->proc);
-	is_frozen = ref->node->proc->is_frozen;
-	binder_inner_proc_unlock(ref->node->proc);
 
 	binder_stats_created(BINDER_STAT_FREEZE);
 	INIT_LIST_HEAD(&freeze->work.entry);
 	freeze->cookie = handle_cookie->cookie;
 	freeze->work.type = BINDER_WORK_FROZEN_BINDER;
-	freeze->is_frozen = is_frozen;
-
 	ref->freeze = freeze;
 
-	binder_inner_proc_lock(proc);
-	binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
-	binder_wakeup_proc_ilocked(proc);
-	binder_inner_proc_unlock(proc);
+	if (ref->node->proc) {
+		binder_inner_proc_lock(ref->node->proc);
+		freeze->is_frozen = ref->node->proc->is_frozen;
+		binder_inner_proc_unlock(ref->node->proc);
+
+		binder_inner_proc_lock(proc);
+		binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
+		binder_wakeup_proc_ilocked(proc);
+		binder_inner_proc_unlock(proc);
+	}
 
 	binder_node_unlock(ref->node);
 	binder_proc_unlock(proc);
-- 
2.46.1.824.gd892dcdcdd-goog


