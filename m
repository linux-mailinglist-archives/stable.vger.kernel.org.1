Return-Path: <stable+bounces-182959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E80BB0EFE
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 17:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CCF19C2104
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 15:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C92765CA;
	Wed,  1 Oct 2025 15:00:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD1274B2B;
	Wed,  1 Oct 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330839; cv=none; b=qII56hyguR64DcHbTDcCXuWGS99Za4rDJt3EQp6wwSrkY6VcoWwMUQO27Dd5fTJLHC3uKIyeYsoDb4edWCHX47CBAH/bj69Ur3+XhrCBOtJr7uRX5/iHuX0+FgTD/7J23H9WBmMuG7kFhDOp+DrkIYAmKsElNulb7O15PfF763Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330839; c=relaxed/simple;
	bh=lgPpTuB3gcB4yBO91fExEFcoqC51GI9wHSTCGPHZhSE=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=WqE1tljYLwnZfl4bavlqsBkFiarV5A7Ch9vh0+/XEONzSwHa+xOlpemalCE7k4qPeyREHrvE41iOMi9LV/8kjUxSf6Zn+UFO5Ue6/Vg541EmbcNNVY6xRLXB9qOLTIU/aLR59S4Zri56nLxM2SlhMrA6kc2SSfguQOSmvGWFRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ccJ5G4dFvz5BNRd;
	Wed, 01 Oct 2025 23:00:34 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 591F0NDx015186;
	Wed, 1 Oct 2025 23:00:23 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 1 Oct 2025 23:00:27 +0800 (CST)
Date: Wed, 1 Oct 2025 23:00:27 +0800 (CST)
X-Zmail-TransId: 2af968dd420b417-08211
X-Mailer: Zmail v1.0
Message-ID: <20251001230027125gluddf7-yGz-nXN3gvN6z@zte.com.cn>
In-Reply-To: <202510012256278259zrhgATlLA2C510DMD3qI@zte.com.cn>
References: 202510012256278259zrhgATlLA2C510DMD3qI@zte.com.cn
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <david@redhat.com>
Cc: <chengming.zhou@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <tujinjiang@huawei.com>, <shr@devkernel.io>, <xu.xin16@zte.com.cn>,
        <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMi8yXSBtbS9rc206IGZpeCBleGVjL2ZvcmsgaW5oZXJpdGFuY2Ugc3VwcG9ydCBmb3IgcHJjdGw=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 591F0NDx015186
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 01 Oct 2025 23:00:34 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68DD4212.000/4ccJ5G4dFvz5BNRd

From: xu xin <xu.xin16@zte.com.cn>

Background
==========
The commit d7597f59d1d33 ("mm: add new api to enable ksm per process") introduce
MMF_VM_MERGE_ANY for mm->flags, and allow user to set it by prctl() so that the
process's VMAs are forcely scanned by ksmd. Sequently, the commit 3c6f33b7273a
("mm/ksm: support fork/exec for prctl") support inheritsingMMF_VM_MERGE_ANY flag
when a task calls execve(). Lastly, The commit 3a9e567ca45fb
("mm/ksm: fix ksm exec support for prctl") fixed the issue that ksmd doesn't scan
the mm_struct with MMF_VM_MERGE_ANY by adding the mm_slot to ksm_mm_head
in __bprm_mm_init().

Problem
=======
In some extreme scenarios, however, this inheritance of MMF_VM_MERGE_ANY during
exec/fork can fail. For example, when the scanning frequency of ksmd is tuned
extremely high, a process carrying MMF_VM_MERGE_ANY may still fail to pass it to
the newly exec'd process. This happens because ksm_execve() is executed too early
in the do_execve flow (prematurely adding the new mm_struct to the ksm_mm_slot list).

As a result, before do_execve completes, ksmd may have already performed a scan and
found that this new mm_struct has no VM_MERGEABLE VMAs, thus clearing its
MMF_VM_MERGE_ANY flag. Consequently, when the new program executes, the flag
MMF_VM_MERGE_ANY inheritance fails!

Reproduce
========
Prepare ksm-utils in the prerequisite PATCH, and simply do as follows

echo 1 > /sys/kernel/mm/ksm/run;
echo 2000 > /sys/kernel/mm/ksm/pages_to_scan;
echo 0 > /sys/kernel/mm/ksm/sleep_millisecs;
ksm-set -s on [NEW_PROGRAM_BIN] &
ksm-get -a -e

you can see like this:
Pid         Comm                Merging_pages  Ksm_zero_pages    Ksm_profit     Ksm_mergeable     Ksm_merge_any
206         NEW_PROGRAM_BIN     7680           0                 30965760       yes               no

Note:
If the first time don't reproduce the issue, pkill NEW_PROGRAM_BIN and try run it
again. Usually, we can reproduce it in 5 times.

Root reason
===========
The commit d7597f59d1d33 ("mm: add new api to enable ksm per process") clear the
flag MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE VMAs.

Solution
========
Remove the action of clearing MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE VMAs.
because perhaps their mm_struct has just been added to ksm_mm_slot list, and its
process has not yet officially started running or has not yet performed mmap/brk to
allocate anonymous VMAS.

Fixes: 3c6f33b7273a ("mm/ksm: support fork/exec for prctl")
Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process")
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: stable@vger.kernel.org
Cc: Stefan Roesch <shr@devkernel.io>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
---
 mm/ksm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 04019a15b25d..17c7ed7df700 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2617,8 +2617,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		spin_unlock(&ksm_mmlist_lock);

 		mm_slot_free(mm_slot_cache, mm_slot);
+		/*
+		 * Only clear MMF_VM_MERGEABLE. We must not clear
+		 * MMF_VM_MERGE_ANY, because for those MMF_VM_MERGE_ANY process,
+		 * perhaps their mm_struct has just been added to ksm_mm_slot
+		 * list, and its process has not yet officially started running
+		 * or has not yet performed mmap/brk to allocate anonymous VMAS.
+		 */
 		mm_flags_clear(MMF_VM_MERGEABLE, mm);
-		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
-- 
2.25.

