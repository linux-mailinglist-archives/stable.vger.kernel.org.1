Return-Path: <stable+bounces-224180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIUADRL/r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 307AF24A88D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33BF1302B45E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F5386C02;
	Tue, 10 Mar 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxjpZg6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A73806B8;
	Tue, 10 Mar 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141636; cv=none; b=CmlR7uv5ExruddQkw6OOGI+kMAivEiC+qsqNX/xjjgdQu59RqGbSkWWPM0z0pXRyDQ4sjdRMqMM+HfD5VgdEp+7SmYiS4cqZJaqLetTe1Puyo6Daj0dDAFUlkJ+3D+X6VREHXvhqPu9hAotr60hxoU1g27FOPf789u6QOZvTphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141636; c=relaxed/simple;
	bh=7llWn5eM3DAtNUSSYnqzzAhrVtUca7G0zQBLrLb69ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK5J5hBq5/YeRoKWLSmOg35p3C1AO8ZR/WcxTZdcQ+rH/+I+zcf+907Ro1HE0eauv4x5iWvuoBaIrtvIF7PEt8lEJt+/E0L5nfWMsowxu2bcfqGovf/RKoaUdhgmyeBGoJQ58Dqm9OFDXU8EOxW2g0daB82pVhRHR2w8dl5eqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxjpZg6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E7CC2BCAF;
	Tue, 10 Mar 2026 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141636;
	bh=7llWn5eM3DAtNUSSYnqzzAhrVtUca7G0zQBLrLb69ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxjpZg6BqSSbQL3NIep2IeXtLC63o7b6eRHzNV0zqxyIH+SFegY2TlrZvmwqlZ/s4
	 ZdUZzGWUPm6bQn1eUieY7T+s+sg4jDvuNw+t54FodDSlzFAPrB4IsxvxSydqrG6YZG
	 Fj3rwpjh41xpkOEntLkWxYOZLC5mfg762ci5mwFedp7NKTzXjexaA2ISowYTE/fgz0
	 LlZxtaSHP3PmFbkFJzGD9OM6pOjm+vMYBFsJMttg5MOPAF8ujvNhQQ4nZtLW5pUZ5l
	 hNn9QnWLvbBhc2ncfnHuP5j/bAW0QChgyypze848sDsUMfxic6I6e+LBXt8TSwf4Cu
	 g2n1wi9FuaRMA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Haocheng Yu <yuhaocheng035@gmail.com>,
	kernel test robot <lkp@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 001/314] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Tue, 10 Mar 2026 07:14:20 -0400
Message-ID: <3bea029b3ba1ccefc533605e9d145fcd52d11615.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 307AF24A88D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,infradead.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224180-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,msgid.link:url,infradead.org:email,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Haocheng Yu <yuhaocheng035@gmail.com>

commit 77de62ad3de3967818c3dbe656b7336ebee461d2 upstream.

Syzkaller reported a refcount_t: addition on 0; use-after-free warning
in perf_mmap.

The issue is caused by a race condition between a failing mmap() setup
and a concurrent mmap() on a dependent event (e.g., using output
redirection).

In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
event->rb with the mmap_mutex held. The mutex is then released to
perform map_range().

If map_range() fails, perf_mmap_close() is called to clean up.
However, since the mutex was dropped, another thread attaching to
this event (via inherited events or output redirection) can acquire
the mutex, observe the valid event->rb pointer, and attempt to
increment its reference count. If the cleanup path has already
dropped the reference count to zero, this results in a
use-after-free or refcount saturation warning.

Fix this by extending the scope of mmap_mutex to cover the
map_range() call. This ensures that the ring buffer initialization
and mapping (or cleanup on failure) happens atomically effectively,
preventing other threads from accessing a half-initialized or
dying ring buffer.

Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260202162057.7237-1-yuhaocheng035@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c34b927e5ece3..6889a6bd8a395 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7187,28 +7187,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			ret = perf_mmap_aux(vma, event, nr_pages);
 		if (ret)
 			return ret;
-	}
 
-	/*
-	 * Since pinned accounting is per vm we cannot allow fork() to copy our
-	 * vma.
-	 */
-	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &perf_mmap_vmops;
+		/*
+		 * Since pinned accounting is per vm we cannot allow fork() to copy our
+		 * vma.
+		 */
+		vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
+		vma->vm_ops = &perf_mmap_vmops;
 
-	mapped = get_mapped(event, event_mapped);
-	if (mapped)
-		mapped(event, vma->vm_mm);
+		mapped = get_mapped(event, event_mapped);
+		if (mapped)
+			mapped(event, vma->vm_mm);
 
-	/*
-	 * Try to map it into the page table. On fail, invoke
-	 * perf_mmap_close() to undo the above, as the callsite expects
-	 * full cleanup in this case and therefore does not invoke
-	 * vmops::close().
-	 */
-	ret = map_range(event->rb, vma);
-	if (ret)
-		perf_mmap_close(vma);
+		/*
+		 * Try to map it into the page table. On fail, invoke
+		 * perf_mmap_close() to undo the above, as the callsite expects
+		 * full cleanup in this case and therefore does not invoke
+		 * vmops::close().
+		 */
+		ret = map_range(event->rb, vma);
+		if (ret)
+			perf_mmap_close(vma);
+	}
 
 	return ret;
 }
-- 
2.51.0


