Return-Path: <stable+bounces-77844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB3B987BDF
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B25285514
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCB21B1D57;
	Thu, 26 Sep 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whs6EGrU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC201B1D49
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393819; cv=none; b=GbkMJv/FHrc8dmigge9dDiMe66LE5bfnksy9IDMDYybqAxGm4MAAz6aCD9l7CBRupWCIMj0j4el2ZoNQKiTq464brVi8MXKgVwaAYBtSRqQuNofspdOdTbuCmJuLXmN45WpBnro1lrPOzY3GcXmLOh9ZFJxQlwwL/9mboVNnIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393819; c=relaxed/simple;
	bh=EK1jt0N1ISBUiSzxxb/b63Lp+lEQ5URD6w3YPi8ETT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTrTJhMFaRdAxuyWxdQhIesEF1MLOtZSPddSLEenJ4SAadq1mcx5fEB895Z7L22UteUoRHsNSqnTtEf95Fc56oJyKaZdPPIdootB3g8tfAblcb6xOAaRPisZ5cDwbhzcCITyP6fwtSYSZ18GWuxXkfKZt3ZFb8t353hKAGn+YjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whs6EGrU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7db1762d70fso1354232a12.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393817; x=1727998617; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HNhAhWvm1MisOKIZYtkplxC3gTJbPu471ll8TGSkhoo=;
        b=whs6EGrUKLZHNqOZClE4KAWBaozeSR7USpHLGLP1zQfTC0iY6PACyBwii1BJ/MSI0o
         XHQvSx7+JPcQ3cj7UVRj1pWPx5WidtvGVRwjb8823a5u9D3gMykAFhJIVfwfnPBMHi/6
         Pm3FtjDQ/MeT728vT+RtdKpBMBXnkPa+omOunObWLXOdh5oT8UEDJCFiyJlHfgTJ1vC1
         /Ony9TT9/eKhlfEG9xZ5fCfDvE5Kh+g4zK0oBkUkTgtlv9Ugo/2sIYy43nxq7S/Y/K4k
         j5SxLqOpV5NDHsI4F6tnJcAd15eClX1L/nL1OkhvLKZj/NDzQhUzsfebBTL5eL5Y2VEw
         7hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393817; x=1727998617;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNhAhWvm1MisOKIZYtkplxC3gTJbPu471ll8TGSkhoo=;
        b=DUM5wwVzozyk2waDYMkYDE8TitIH3P6BiDAacRopoPRsinLyEjUk48GFV7Q0rkztjF
         tyM3l8sGOGgAr1dKHS44dBjNEslnHbv6icL4XYY2pbUw9GUlU8ypU7axkyYkuZp8XJq0
         YB/rosYOYGN6hK1I6srsZ+oIruMOwgAa7CmcStYTZlrNBGslzObQ/uB21gBibAjlX3cV
         p1tES1Plu4IPDH1tswmKlKfPSDC1hoJin/ZnkDoXmGnpKRrMM5EyIG14xayHQVJBtVv+
         oielqm84eYQjjhO1bUE05mDgJuvc5noqM1NXy8gZ92x1CA98mfOjWK/PQmvyLJuyjTVh
         riHA==
X-Forwarded-Encrypted: i=1; AJvYcCVoznY1f6tJ6FQ4R4N9oPDIemeWV3kaY5xWTJ/4YRqGMfW5obLIGWcuQYBms6M377k+4TJXdkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6BUdPxxOyFcjDWkvFnJ6IFIKpWP9D0gqPt8AV8vo0MpJu70n
	bf2TdB4HdLyJoeaNwyf7ORkjJy9sAibcFeiJ3X0iWS0+EGaYofYSelVv9PyxxHpa0kuxpFaxCR4
	yXlxYDAyJLw==
X-Google-Smtp-Source: AGHT+IHogi2NYhlB88Zx5YMI9IkUgPts/VYD2XkJfldtiwLdPBf7GTsk4ODNwXYWR/Ftc+YN37qKN8VHqQuc5w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:fd05:b0:205:656a:efe8 with SMTP
 id d9443c01a7336-20b37b618b7mr80015ad.8.1727393816360; Thu, 26 Sep 2024
 16:36:56 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:18 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-8-cmllamas@google.com>
Subject: [PATCH v2 7/8] binder: fix memleak of proc->delivered_freeze
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If a freeze notification is cleared with BC_CLEAR_FREEZE_NOTIFICATION
before calling binder_freeze_notification_done(), then it is detached
from its reference (e.g. ref->freeze) but the work remains queued in
proc->delivered_freeze. This leads to a memory leak when the process
exits as any pending entries in proc->delivered_freeze are not freed:

  unreferenced object 0xffff38e8cfa36180 (size 64):
    comm "binder-util", pid 655, jiffies 4294936641
    hex dump (first 32 bytes):
      b8 e9 9e c8 e8 38 ff ff b8 e9 9e c8 e8 38 ff ff  .....8.......8..
      0b 00 00 00 00 00 00 00 3c 1f 4b 00 00 00 00 00  ........<.K.....
    backtrace (crc 95983b32):
      [<000000000d0582cf>] kmemleak_alloc+0x34/0x40
      [<000000009c99a513>] __kmalloc_cache_noprof+0x208/0x280
      [<00000000313b1704>] binder_thread_write+0xdec/0x439c
      [<000000000cbd33bb>] binder_ioctl+0x1b68/0x22cc
      [<000000002bbedeeb>] __arm64_sys_ioctl+0x124/0x190
      [<00000000b439adee>] invoke_syscall+0x6c/0x254
      [<00000000173558fc>] el0_svc_common.constprop.0+0xac/0x230
      [<0000000084f72311>] do_el0_svc+0x40/0x58
      [<000000008b872457>] el0_svc+0x38/0x78
      [<00000000ee778653>] el0t_64_sync_handler+0x120/0x12c
      [<00000000a8ec61bf>] el0t_64_sync+0x190/0x194

This patch fixes the leak by ensuring that any pending entries in
proc->delivered_freeze are freed during binder_deferred_release().

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 415fc9759249..7c09b5e38e32 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5155,6 +5155,16 @@ static void binder_release_work(struct binder_proc *proc,
 		} break;
 		case BINDER_WORK_NODE:
 			break;
+		case BINDER_WORK_CLEAR_FREEZE_NOTIFICATION: {
+			struct binder_ref_freeze *freeze;
+
+			freeze = container_of(w, struct binder_ref_freeze, work);
+			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
+				     "undelivered freeze notification, %016llx\n",
+				     (u64)freeze->cookie);
+			kfree(freeze);
+			binder_stats_deleted(BINDER_STAT_FREEZE);
+		} break;
 		default:
 			pr_err("unexpected work type, %d, not freed\n",
 			       wtype);
@@ -6273,6 +6283,7 @@ static void binder_deferred_release(struct binder_proc *proc)
 
 	binder_release_work(proc, &proc->todo);
 	binder_release_work(proc, &proc->delivered_death);
+	binder_release_work(proc, &proc->delivered_freeze);
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
 		     "%s: %d threads %d, nodes %d (ref %d), refs %d, active transactions %d\n",
-- 
2.46.1.824.gd892dcdcdd-goog


