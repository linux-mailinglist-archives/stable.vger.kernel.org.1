Return-Path: <stable+bounces-240642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNKyA1RX62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:43:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5550D45DED4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B591300DD78
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2BE3BE64B;
	Fri, 24 Apr 2026 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yYzwHNkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6CC3BE645;
	Fri, 24 Apr 2026 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030989; cv=none; b=IJO5vADu1NoHnYILxEJJCqXQCd0WlGoxG0D4CYhTkRno6exQVxvrAhZ1+akBDpEnGOK1Nn5dfrDSvMpfwB6pQzTkNpl3NMATihB4t3eI2JXrEC8t7Sh6xlZ9AWolK1Ew9j9ssXAjAHaYICsUi4AjsBMWLOM/srkauF56ZJtGbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030989; c=relaxed/simple;
	bh=LcR73gTJiiSLRSf1qU0i/mJyF0H/6GpJyGY1baW7ECg=;
	h=Date:To:From:Subject:Message-Id; b=ZHpLCo6spEWuZnd2v0sKoFGy4QKfF5fmhXHaHVemZV/tyJoU5TaeD4WLrDM5yZF/3l0LsvGh+80mwIFL3REigJnJhIWvHXGwDvc0AHfP+TgISXdNd06zXTlpPZN7dB/RBGIYhrfz6jdqIC2kwXcRHVNXDeQ8yq15grql7RDMgP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yYzwHNkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA1EC19425;
	Fri, 24 Apr 2026 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777030989;
	bh=LcR73gTJiiSLRSf1qU0i/mJyF0H/6GpJyGY1baW7ECg=;
	h=Date:To:From:Subject:From;
	b=yYzwHNkJrPd/AbrfVHN8cvA/mmwWDVP4N+YV0kV5dqbOAdlWBG+21prpb65EbH6LO
	 fd7ISd/w4gmmYHT17h/BdORtmE+QbJbOpItYrkkJVUVxFtrOU/R7Q0pmDpSShNc1fA
	 skmLrYrxkz7HD/K5Uda4rLBpKVH6EnyPv/AOnRio=
Date: Fri, 24 Apr 2026 04:43:08 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,tristan@talencesecurity.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-use-kzalloc-for-quota-recovery-bitmap-allocation.patch added to mm-nonmm-unstable branch
Message-Id: <20260424114309.2CA1EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 5550D45DED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240642-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn,talencesecurity.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch titled
     Subject: ocfs2: use kzalloc for quota recovery bitmap allocation
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     ocfs2-use-kzalloc-for-quota-recovery-bitmap-allocation.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-use-kzalloc-for-quota-recovery-bitmap-allocation.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Tristan Madani <tristan@talencesecurity.com>
Subject: ocfs2: use kzalloc for quota recovery bitmap allocation
Date: Sat, 18 Apr 2026 13:10:48 +0000

ocfs2 quota recovery allocates a bitmap buffer with kmalloc and does not
fully initialize it.  This can lead to use of uninitialized bits during
quota recovery from a corrupted filesystem image.

Use kzalloc instead to ensure the bitmap is zero-initialized.

Link: https://lore.kernel.org/20260418131048.1052507-1-tristmd@gmail.com
Reported-by: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/quota_local.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ocfs2/quota_local.c~ocfs2-use-kzalloc-for-quota-recovery-bitmap-allocation
+++ a/fs/ocfs2/quota_local.c
@@ -302,7 +302,7 @@ static int ocfs2_add_recovery_chunk(stru
 	if (!rc)
 		return -ENOMEM;
 	rc->rc_chunk = chunk;
-	rc->rc_bitmap = kmalloc(sb->s_blocksize, GFP_NOFS);
+	rc->rc_bitmap = kzalloc(sb->s_blocksize, GFP_NOFS);
 	if (!rc->rc_bitmap) {
 		kfree(rc);
 		return -ENOMEM;
_

Patches currently in -mm which might be from tristan@talencesecurity.com are

ocfs2-use-kzalloc-for-quota-recovery-bitmap-allocation.patch


