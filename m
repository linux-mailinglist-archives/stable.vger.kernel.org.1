Return-Path: <stable+bounces-221529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P3RAA2mo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:35:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF11CDB64
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA5E30602CF
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC8259C80;
	Sun,  1 Mar 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8kL9KDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06892287268;
	Sun,  1 Mar 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328492; cv=none; b=OsoWBwMyGeYkXkCv5ja6ztscnVeABU5dssW9gBXEnP4er0dDC1lTVURfNx4t9Xi3cOk2vg1ID/kBHsscNs7zQExpJ2lUgPML7thef2fDCzedZRSiaJpJHJQ9X0N2L6vqrOpuJ2PICMcPI6kwBV3f4C5tBum8AnlCMfcO5wsgqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328492; c=relaxed/simple;
	bh=o/Fw6B01kqff8lSvyL61UH1WMKk+X8WsXw058oOJm3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQAusaLSKktFWQhFFEEp3UhSiiH/uIc3rB7hs7WRg29uLA/O8Sd8tu/IzZ61yU7Ep0q2qiu3jySxbLbSCm9WI0YTKWv1o/Vkw6CHdaMGBockF2CZmOrfkPHBSBfn4fG5zipsE8Kpv/oIK+TazgF+qqAmAfXXE/W6rbzC6VllzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8kL9KDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551B5C19421;
	Sun,  1 Mar 2026 01:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328491;
	bh=o/Fw6B01kqff8lSvyL61UH1WMKk+X8WsXw058oOJm3M=;
	h=From:To:Cc:Subject:Date:From;
	b=r8kL9KDr2H0eh0szQ+Vdip7jGMcmj86Y33OZCDssj+LVglqiVAntBAPQZz1hXA1fY
	 veL5IhbcjDtz4JK7HSVTjlPBNX5sCjmAUxA/XTN2HzFWuzwAhTO0vg/yqMrXD+2D5v
	 jD6H7MM9kDDS0Ql8ohVMtdZKF9QE4CMx1yoPCt/ThhMyCeGbjoqMIiJVEc2zLBlfd4
	 404C7ujIUNk0dMcICKk+DmXneBeXIald6MtqllofLg0C4uz24bqhkZUgc3X/SQq2T7
	 emUHmI/+WdQ8rrB8V3xq/RqQc7VCYpLFeJTIXjMoApWLXMsIVNrm8nifE84ydgD7Gj
	 1zSdn0leM0aNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cfsworks@gmail.com
Cc: Sam Edwards <CFSworks@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: FAILED: Patch "ceph: fix write storm on fscrypted files" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:09 -0500
Message-ID: <20260301012810.1685872-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-221529-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63EF11CDB64
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cac190c7674fea71620d754ffcdaaeed7c551dbc Mon Sep 17 00:00:00 2001
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 25 Jan 2026 18:30:53 -0800
Subject: [PATCH] ceph: fix write storm on fscrypted files

CephFS stores file data across multiple RADOS objects. An object is the
atomic unit of storage, so the writeback code must clean only folios
that belong to the same object with each OSD request.

CephFS also supports RAID0-style striping of file contents: if enabled,
each object stores multiple unbroken "stripe units" covering different
portions of the file; if disabled, a "stripe unit" is simply the whole
object. The stripe unit is (usually) reported as the inode's block size.

Though the writeback logic could, in principle, lock all dirty folios
belonging to the same object, its current design is to lock only a
single stripe unit at a time. Ever since this code was first written,
it has determined this size by checking the inode's block size.
However, the relatively-new fscrypt support needed to reduce the block
size for encrypted inodes to the crypto block size (see 'fixes' commit),
which causes an unnecessarily high number of write operations (~1024x as
many, with 4MiB objects) and correspondingly degraded performance.

Fix this (and clarify intent) by using i_layout.stripe_unit directly in
ceph_define_write_size() so that encrypted inodes are written back with
the same number of operations as if they were unencrypted.

This patch depends on the preceding commit ("ceph: do not propagate page
array emplacement errors as batch errors") for correctness. While it
applies cleanly on its own, applying it alone will introduce a
regression. This dependency is only relevant for kernels where
ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method") has
been applied; stable kernels without that commit are unaffected.

Cc: stable@vger.kernel.org
Fixes: 94af0470924c ("ceph: add some fscrypt guardrails")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3cfe3df6e6a22..c6c853748942b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1000,7 +1000,8 @@ unsigned int ceph_define_write_size(struct address_space *mapping)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	unsigned int wsize = i_blocksize(inode);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	unsigned int wsize = ci->i_layout.stripe_unit;
 
 	if (fsc->mount_options->wsize < wsize)
 		wsize = fsc->mount_options->wsize;
-- 
2.51.0





