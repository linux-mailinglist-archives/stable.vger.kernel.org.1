Return-Path: <stable+bounces-216000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGdvCQ5ljmkOCAEAu9opvQ
	(envelope-from <stable+bounces-216000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:41:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1F131CD1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E87309E149
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 23:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B02C324E;
	Thu, 12 Feb 2026 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dmng3AE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478E3EBF1B;
	Thu, 12 Feb 2026 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939650; cv=none; b=uzxZ3VEeNFCJwUo27IAPpkjjVtnvvRM2Q/MBkGliASIbIr6DX6eQ1D0tOTs57FvWrI+Twj3nMMl3Q0LBhOasGL2PbFkm0siNPNrN50RgqpYyYowna4wjV6Uj3Ur7GIT7jYQoqEcmY27qYV19aYSTPMRmlWmFzJAsCFcGEGy9zS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939650; c=relaxed/simple;
	bh=+xknwzrJqwMB0PrfLpeEnB4TpPBFZ7/nhgwA87neMQY=;
	h=Date:To:From:Subject:Message-Id; b=WAa64KX2K37Cm+6imioNnz5oDFlHYl9oHjnxyoI49TbyVqPgzcmWstXgF3rZlgdT0YdY14jJACVi7rpeMiwPAG0/C1XySsHyf9sMn/vBv8Vu613MFn2gpFJu22lE0glzHfKSibFMJ0Pk7ht4SAD8T15W/PwZko1J4qq5vodv78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dmng3AE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FC6C19421;
	Thu, 12 Feb 2026 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770939650;
	bh=+xknwzrJqwMB0PrfLpeEnB4TpPBFZ7/nhgwA87neMQY=;
	h=Date:To:From:Subject:From;
	b=Dmng3AE8wTiE6Ie+GNKpXH+WhViArvDYEFvjG23I5OC10Mt1ebZ50wqBY6LuDZyG1
	 BoFN9TmaxwbS9STRy3OsYvg0dcvy5l5VoWxRQxVoVcIK3mYK1zw2W58tA6Tb3WYk0A
	 e8XGaec2oqHGHk8I9k277K+iQEQSeZb6ybwsqHs4=
Date: Thu, 12 Feb 2026 15:40:49 -0800
To: mm-commits@vger.kernel.org,tglx@kernel.org,stable@vger.kernel.org,shakeel.butt@linux.dev,ruikai@pwno.io,andrii@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] procfs-fix-possible-double-mmput-in-do_procmap_query.patch removed from -mm tree
Message-Id: <20260212234050.03FC6C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216000-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux-foundation.org:email,linux-foundation.org:dkim,appspotmail.com:email]
X-Rspamd-Queue-Id: 8EE1F131CD1
X-Rspamd-Action: no action


The quilt patch titled
     Subject: procfs: fix possible double mmput() in do_procmap_query()
has been removed from the -mm tree.  Its filename was
     procfs-fix-possible-double-mmput-in-do_procmap_query.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Andrii Nakryiko <andrii@kernel.org>
Subject: procfs: fix possible double mmput() in do_procmap_query()
Date: Tue, 10 Feb 2026 11:27:38 -0800

When user provides incorrectly sized buffer for build ID for PROCMAP_QUERY
we return with -ENAMETOOLONG error.  After recent changes this condition
happens later, after we unlocked mmap_lock/per-VMA lock and did mmput(),
so original goto out is now wrong and will double-mmput() mm_struct.  Fix
by jumping further to clean up only vm_file and name_buf.

Link: https://lkml.kernel.org/r/20260210192738.3041609-1-andrii@kernel.org
Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reported-by: Ruikai Peng <ruikai@pwno.io>
Reported-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Cc: Ruikai Peng <ruikai@pwno.io>
Closes: https://lkml.kernel.org/r/CAFD3drOJANTZPuyiqMdqpiRwOKnHwv5QgMNZghCDr-WxdiHvMg@mail.gmail.com
Closes: https://lore.kernel.org/all/698aaf3c.050a0220.3b3015.0088.GAE@google.com/T/#u
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/task_mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/proc/task_mmu.c~procfs-fix-possible-double-mmput-in-do_procmap_query
+++ a/fs/proc/task_mmu.c
@@ -780,7 +780,7 @@ static int do_procmap_query(struct mm_st
 		} else {
 			if (karg.build_id_size < build_id_sz) {
 				err = -ENAMETOOLONG;
-				goto out;
+				goto out_file;
 			}
 			karg.build_id_size = build_id_sz;
 		}
@@ -808,6 +808,7 @@ static int do_procmap_query(struct mm_st
 out:
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
+out_file:
 	if (vm_file)
 		fput(vm_file);
 	kfree(name_buf);
_

Patches currently in -mm which might be from andrii@kernel.org are



