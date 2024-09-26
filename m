Return-Path: <stable+bounces-77839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924E987BD5
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9953D1C230E9
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDFF1B140D;
	Thu, 26 Sep 2024 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUL+hnIr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD81B07DB
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393806; cv=none; b=eWiVSIr02yzb0RGVEdrdR7z7m0+C1RS6O2LftyFIX80sCzH3ITebB0DNxa5uMI6W8YPoWp7mcTz23JZUN6p4yc2JHze0o0nx89SgpFx9hnB64fj/tNv7yVNEXx4Xgrb3LmoAj2bYvSPearfJeLbmEmv/vYpSXTsghO+OCh+/Hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393806; c=relaxed/simple;
	bh=7FyUqJVHhQqpZW0CqMpH9Qq1tVINFN2+YcmflhlTmno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daHWzulIwnC0i9hke9IzqrbQewI26AHxuypcWdtHMiGwbnppT4NzvZBBkUKG3fl3NkWN6PDdzaLU0VtpoKDmsaeCdMijX+ZSRNotQn+lAggxzjvP8bq8x1nKR01A0zQFhI0ap5npWv5CBSa+C41TbpcYOCvh8f4rs2/xFqw1a8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUL+hnIr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e248f1fe4cso4587947b3.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393804; x=1727998604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJEBs7A1+JGk0JKuqMbaxRVWJzcNV2YxZn6IZoz3lzk=;
        b=aUL+hnIrFQVHEvDA/MeshsreT321qdbS0p+t/NEMbTCX3M/dxYq8kx5BbCHiV+Zirj
         uwr3o78MgIwbf+VbfinCoNF9VN3HK1mbxyv180X02teu/7LEdX2TNeViMsqO/Tal1zw0
         hA8nJmvjnUq+y48/jaoPOnxSSRO0X4c4w1aY8k2nr2y8tHFa5lXnIGh0Lj+HrYaRRxd9
         IGY3MNNVli6ZU4SIZ1mzthf7HLFCTYOQyAQA2R5+gVRODEyEU1K9IwtEuJn0Lan7glGx
         Kt2i9Q8dYdHKQ6HiyySBLCKcp7sdnMjPRLcmzchM5dCqv1OCjquXgciesXDDMqgXKTfH
         GOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393804; x=1727998604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJEBs7A1+JGk0JKuqMbaxRVWJzcNV2YxZn6IZoz3lzk=;
        b=lO1zQIHHdq7bZcfKUxGRa3X62LBQI6M9WwSl+LtGUKQ00Fr3jjHmKy0eO1OE8uv+pa
         HcFu1JI9NI4pwJEzuREPYCI2F90iA20uglmixdpotn3oh63NwP9NYAyM1mpePy+S1ZPy
         nJs6Df4IYKPCi81mPS1S3wbX9vSPavY1sGKOWXvxICzXnzwyk9h7oUKcgNA5mMfqQKP+
         y7DjUf/LwtzYybwJAhENcgGzli9G1mIrXamYY0zOmaVSRoAVphfmlqAPZ6dWdeHdr8Up
         tXB1jpaEsT8nU69bOLhBiYuxIiyrgff0Tg2maAbiG81+FMyNa76/cNSMYOd72VLH/dpV
         gDdA==
X-Forwarded-Encrypted: i=1; AJvYcCXe/toApy4ZWDWI/zI1l69RxZj9IA4v4anuX6bkFWa5KSl2BhbrHb81OzcKJUIvA3M9OqMMM4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU690u74ul0bUnltP3iIr31E87M0llBmJv4S8H0n+THgx5Tn0C
	751usqF42j+dQPT3XcN2HzXvYBOh3CGvMmcYfW59FisgCXBdSR5u94EOFQRS/5j17ZyCpEGYq2H
	q7BtcXwlX/A==
X-Google-Smtp-Source: AGHT+IFsraml/P/gNT7SI20gRH7oG97Mja+iK2QbTY5JPt6BRHSPbRGhh5M8KkbOrPJYtkeleDtBe004VqcSWw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:884:0:b0:e11:584c:76e2 with SMTP id
 3f1490d57ef6-e2604b1a4d8mr1146276.2.1727393804070; Thu, 26 Sep 2024 16:36:44
 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:13 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-3-cmllamas@google.com>
Subject: [PATCH v2 2/8] binder: fix OOB in binder_add_freeze_work()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

In binder_add_freeze_work() we iterate over the proc->nodes with the
proc->inner_lock held. However, this lock is temporarily dropped to
acquire the node->lock first (lock nesting order). This can race with
binder_deferred_release() which removes the nodes from the proc->nodes
rbtree and adds them into binder_dead_nodes list. This leads to a broken
iteration in binder_add_freeze_work() as rb_next() will use data from
binder_dead_nodes, triggering an out-of-bounds access:

  ==================================================================
  BUG: KASAN: global-out-of-bounds in rb_next+0xfc/0x124
  Read of size 8 at addr ffffcb84285f7170 by task freeze/660

  CPU: 8 UID: 0 PID: 660 Comm: freeze Not tainted 6.11.0-07343-ga727812a8d45 #18
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   rb_next+0xfc/0x124
   binder_add_freeze_work+0x344/0x534
   binder_ioctl+0x1e70/0x25ac
   __arm64_sys_ioctl+0x124/0x190

  The buggy address belongs to the variable:
   binder_dead_nodes+0x10/0x40
  [...]
  ==================================================================

This is possible because proc->nodes (rbtree) and binder_dead_nodes
(list) share entries in binder_node through a union:

	struct binder_node {
	[...]
		union {
			struct rb_node rb_node;
			struct hlist_node dead_node;
		};

Fix the race by checking that the proc is still alive. If not, simply
break out of the iteration.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4d90203ea048..8bca2de6fa24 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5593,6 +5593,8 @@ static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
 		prev = node;
 		binder_node_unlock(node);
 		binder_inner_proc_lock(proc);
+		if (proc->is_dead)
+			break;
 	}
 	binder_inner_proc_unlock(proc);
 	if (prev)
-- 
2.46.1.824.gd892dcdcdd-goog


