Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BF574E2C2
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 02:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGKAqi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 20:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGKAqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 20:46:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B9A0
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 17:46:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff81be091so61838197b3.0
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 17:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689036396; x=1691628396;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JifcfTowDTwbGS8WSxmdFhcUg3CB7rN8hjjNXGdWXTY=;
        b=ABLSuVQOgJTKHnOcv4NjtzUnyAecTZfgYpi8HNIRlGlPDYg/kFsVPs3i8M16fogHBk
         tAoYCHA70ej+nKNfL6t3sOixEW3SCHb/0+knga3FbH0g0Mo0jQ45xpRuSejM1xwUilbE
         oueT1i3zJElOf6L9KK+xiJgPdxwrlTJ+LZi6j/0Nb3kDERAaypjRu/8QWgb+kkVfe9bK
         8FyO9gFtNHeLSqiMaAKmaV1nLXflJt3bwq2Fbg2cXQ2gv59NTVCQOS/7gPEQNpgsIHYU
         OAgs5FwNbrNzYW4KV17XHbnMgS+yGtNN4J71mLO+xYvbg0kWFTM8ulku0j6trYEpktsU
         rdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689036396; x=1691628396;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JifcfTowDTwbGS8WSxmdFhcUg3CB7rN8hjjNXGdWXTY=;
        b=cJf++xt6hWKdGMsXxWesOW+ROMlV95vGaff4jMUfK3NrBwne1ViOw1NniXQyKMsw/H
         h8o1P47Rt5KefxhidokNvc32GUvzY0ZZGypArTTeAgH2aI4xS5z7DhTFWucV5Z/mNOt8
         3iQ9/FkAhB3ldzMBxvfDk0H9bT1X/xY9iArjJs3ZyR8/MjZJQIpskLAAkSngXByWBIQm
         zKJ5GQAvyZ45ZiB4RL064oYGyi60q0MalhNX01nY8lu55l0yhaluOS/ikPzJ8Mhb8qYe
         GTSh8VmdHUzHrqwuRr//P4bcUJmFsXl6M1EIoETvYpUmKKj3kDkRiX5yUDYphOUKTX4B
         ePHw==
X-Gm-Message-State: ABy/qLah7trvIUe7Rpoxn+2bnkMBI3ljHtNcrpC3HYQDEd0pcPI+8zD/
        J/33JiXWsw9Rjgu50G6CHXpcex0ImjM=
X-Google-Smtp-Source: APBJJlFctd2R/kTWvcEcClx5hTEU8ZYMZJTZKHafFdCou8nNh1hjyIlXetYqrQJs1iPLl7UxU3exkt2/BIA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1bda:a130:1f53:9de])
 (user=surenb job=sendgmr) by 2002:a81:ac24:0:b0:56d:ca1:cd6c with SMTP id
 k36-20020a81ac24000000b0056d0ca1cd6cmr90273ywh.2.1689036396391; Mon, 10 Jul
 2023 17:46:36 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:46:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Message-ID: <20230711004632.579668-1-surenb@google.com>
Subject: [PATCH 6.1 1/1] mm/mmap: Fix VM_LOCKED check in do_vmi_align_munmap()
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        vegard.nossum@oracle.com, stable@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1 backport of the patch [1] uses 'next' vma instead of 'split' vma.
Fix the mistake.

[1] commit 606c812eb1d5 ("mm/mmap: Fix error path in do_vmi_align_munmap()")

Fixes: a149174ff8bb ("mm/mmap: Fix error path in do_vmi_align_munmap()")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b8af52db3bbe..1597a96b667f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2484,7 +2484,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			error = mas_store_gfp(&mas_detach, split, GFP_KERNEL);
 			if (error)
 				goto munmap_gather_failed;
-			if (next->vm_flags & VM_LOCKED)
+			if (split->vm_flags & VM_LOCKED)
 				locked_vm += vma_pages(split);
 
 			count++;
-- 
2.41.0.390.g38632f3daf-goog

