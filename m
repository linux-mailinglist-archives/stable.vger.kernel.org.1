Return-Path: <stable+bounces-256488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOvSIdcRGWpKqAgAu9opvQ
	(envelope-from <stable+bounces-256488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:11:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F25FCEBF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03157310F04C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DC9370AFD;
	Fri, 29 May 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+dDLNWr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7737104F;
	Fri, 29 May 2026 04:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780027710; cv=none; b=LqobiD91wPVBoSyalSULXLr1RRULCax1f2s/XMbcpw9RfEJVJSGsDxlNNbHN1uzW8yVb8SvTzvnQLPADV4/hM6NgRwGG/mGxdoMz8d8/BClWnxRh2rUss8e+JqLNw80OrrgdwXZgV5931k7FCoT8zzsqIVI3a03N95vfEqvg3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780027710; c=relaxed/simple;
	bh=W+1ed1POYEYXocMYLIh//BHHT1AnQx8Rms33BNREGGU=;
	h=Date:To:From:Subject:Message-Id; b=ZASy6fNTX1kUpNBbwm41v3PWd8s4QxXkmLYnfwtvhDW/bAS/AFtTz6H+rU4eQHd/DItFXMiXlRe5s5po2ggzma0mSANKyTlN8tRjIuuHlzX/nKzZiOTW2SrT9AmXUwBB0M9TlFJGiVUn2PFy8zr5DkWzbaxAJov05wYUSkAGzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+dDLNWr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ED41F00898;
	Fri, 29 May 2026 04:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780027709;
	bh=hpvyJGOqCFS/9zoaPs2cJEzwyT4eoP/BflHLE+pK5Io=;
	h=Date:To:From:Subject;
	b=c+dDLNWrM6bum/Yl+orH9ij+EbpuYeRXWm21UaHg1zmOvEQ0sA/xq/U+ZpaNzFc6B
	 Olan9IA5AI7JX9KeWeliiqUzTFRfX6txYqeIU3z3yALJ+JzWc++nsNaNxMHwCcsEhI
	 PenJFvMqOvx3NITOiufN8ASZiZXP8jAXjba/GPPk=
Date: Thu, 28 May 2026 21:08:28 -0700
To: mm-commits@vger.kernel.org,youngjun.park@lge.com,stable@vger.kernel.org,shikemeng@huaweicloud.com,nphamcs@gmail.com,kerayhuang@tencent.com,kasong@tencent.com,flyingpeng@tencent.com,chrisl@kernel.org,baoquan.he@linux.dev,baohua@kernel.org,albinwyang@tencent.com,huangzjsmile@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-swap-add-cond_resched-in-swap_reclaim_full_clusters-to-prevent-softlockup.patch removed from -mm tree
Message-Id: <20260529040829.01ED41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256488-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux-foundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,lge.com,huaweicloud.com,gmail.com,tencent.com,kernel.org,linux.dev,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-0.806];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:email,linux-foundation.org:dkim,tencent.com:email,lge.com:email]
X-Rspamd-Queue-Id: 011F25FCEBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/swap: add cond_resched() in swap_reclaim_full_clusters to prevent softlockup
has been removed from the -mm tree.  Its filename was
     mm-swap-add-cond_resched-in-swap_reclaim_full_clusters-to-prevent-softlockup.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Zijiang Huang <huangzjsmile@gmail.com>
Subject: mm/swap: add cond_resched() in swap_reclaim_full_clusters to prevent softlockup
Date: Wed, 6 May 2026 21:09:19 +0800

We hit a real softlockup in an internal stress test environment.  The
workload was LTP memory/swap stress on a large arm64 machine, with 320
CPUs, about 1TB memory and an 8.6GB swap device.  The system was under
heavy load and the swap device had a large number of full clusters.  The
softlockup was triggered during a stress test after about 3 days.

So, add periodic cond_resched() calls during large full_clusters
reclaim operations to prevent softlockup issues.

Detailed call trace as follow:

PID: 3817773  TASK: ffff0883bb28b780  CPU: 48   COMMAND: "kworker/48:7"
   #0 [ffff800080183d10] __crash_kexec at ffffa4c1361e5de4
   #1 [ffff800080183d90] panic at ffffa4c1360d5e9c
   #2 [ffff800080183e20] watchdog_timer_fn at ffffa4c136231fa8
   ...
  #16 [ffff8000c4ad3cb0] swap_cache_del_folio at ffffa4c1363e1614
  #17 [ffff8000c4ad3ce0] __try_to_reclaim_swap at ffffa4c1363e4bfc
  #18 [ffff8000c4ad3d40] swap_reclaim_full_clusters at ffffa4c1363e5474
  #19 [ffff8000c4ad3da0] swap_reclaim_work at ffffa4c1363e550c
  #20 [ffff8000c4ad3dc0] process_one_work at ffffa4c136102edc
  #21 [ffff8000c4ad3e10] worker_thread at ffffa4c136103398
  #22 [ffff8000c4ad3e70] kthread at ffffa4c13610d95c

Link: https://lore.kernel.org/20260506130919.2298807-1-kerayhuang@tencent.com
Fixes: 5168a68eb78f ("mm, swap: avoid over reclaim of full clusters")
Signed-off-by: Zijiang Huang <kerayhuang@tencent.com>
Reviewed-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Hao Peng <flyingpeng@tencent.com>
Reviewed-by: albinwyang <albinwyang@tencent.com>
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Acked-by: Chris Li <chrisl@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Youngjun Park <youngjun.park@lge.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/swapfile.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/swapfile.c~mm-swap-add-cond_resched-in-swap_reclaim_full_clusters-to-prevent-softlockup
+++ a/mm/swapfile.c
@@ -1054,6 +1054,7 @@ static void swap_reclaim_full_clusters(s
 		swap_cluster_unlock(ci);
 		if (to_scan <= 0)
 			break;
+		cond_resched();
 	}
 }
 
_

Patches currently in -mm which might be from huangzjsmile@gmail.com are



