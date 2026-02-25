Return-Path: <stable+bounces-218518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDEoG7hSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1456118F4CF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E780306F00C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1FC23D7CF;
	Wed, 25 Feb 2026 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UARMOuoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045518B0A;
	Wed, 25 Feb 2026 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983353; cv=none; b=Bn2yNPl2SILk3DJ756XAX/lGUXtVi3ujiBExSstE5bzvrWGjP0LLfb2o6Z/7/zOvKqXYkl4MsW560EQ2GPLVncQsVOthC/0HNHM8T9WkUlT0/fimSugxWBIK6OIJk2bYOztjBtF7uwmDUP/QgPhvw5MGSP6Vl+ixxM6q7efq6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983353; c=relaxed/simple;
	bh=vHCROGLlUjxZwidZMgl1UBtNKTDpBiMyksrmDNlc348=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaEQCmAuOHUmS13piSL97aN6pLmDBX3AH8LUWms8WHnaOIZfebKVfWqhLD5bhBroOrhXjt6WhP5Uo1UubeMofNz84SonblrVbISf3XMzd7+pR2RaOeZ0nHCtXuz+N1eg9ljse2xswDu4DsBxbw222odo8flwRYAYjI524mkV7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UARMOuoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F710C116D0;
	Wed, 25 Feb 2026 01:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983353;
	bh=vHCROGLlUjxZwidZMgl1UBtNKTDpBiMyksrmDNlc348=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UARMOuoNpfXJ1eyeCU1jJZv16Qg2E5wm1ZRB4LynkzLCO/fxlUARHuFNWPW60lUXw
	 5y+CnDnqjCp2QBWHNvMdDpvWn1utT6t0dMJMrdAaas0Xq5opuTTzB2GtjwUUkuJCgM
	 YoukOcuQzElv4tYoJrq7D5JdakrKRmNEwnVoDpZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Cagle <john.cagle@hammerspace.com>,
	Allen Lu <allen.lu@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Mike Snitzer <snitzer@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 478/781] NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
Date: Tue, 24 Feb 2026 17:19:47 -0800
Message-ID: <20260225012411.538570224@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218518-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: 1456118F4CF
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@hammerspace.com>

[ Upstream commit 67435d2d8a33a75f9647724952cb1b18279d2e95 ]

LOCALIO is an NFS loopback mount optimization that avoids using the
network for READ, WRITE and COMMIT if the NFS client and server are
determined to be on the same system. But because LOCALIO is still
fundamentally "just NFS loopback mount" it is susceptible to recursion
deadlock via direct reclaim, e.g.: NFS LOCALIO down to XFS and then
back into NFS via nfs_writepages.

Fix LOCALIO's potential for direct reclaim deadlock by ensuring that
all its page cache allocations are done from GFP_NOFS context.

Thanks to Ben Coddington for pointing out commit ad22c7a043c2 ("xfs:
prevent stack overflows from page cache allocation").

Reported-by: John Cagle <john.cagle@hammerspace.com>
Tested-by: Allen Lu <allen.lu@hammerspace.com>
Suggested-by: Benjamin Coddington <bcodding@hammerspace.com>
Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 00bbac6c9fe40..84f53f27a9089 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -291,6 +291,18 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
 
+/*
+ * Ensure all page cache allocations are done from GFP_NOFS context to
+ * prevent direct reclaim recursion back into NFS via nfs_writepages.
+ */
+static void
+nfs_local_mapping_set_gfp_nofs_context(struct address_space *m)
+{
+	gfp_t gfp_mask = mapping_gfp_mask(m);
+
+	mapping_set_gfp_mask(m, (gfp_mask & ~(__GFP_FS)));
+}
+
 static void
 nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
 {
@@ -315,6 +327,7 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		return NULL;
 	}
 
+	nfs_local_mapping_set_gfp_nofs_context(file->f_mapping);
 	init_sync_kiocb(&iocb->kiocb, file);
 
 	iocb->hdr = hdr;
@@ -1004,6 +1017,8 @@ nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
 			end = LLONG_MAX;
 	}
 
+	nfs_local_mapping_set_gfp_nofs_context(filp->f_mapping);
+
 	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
 	return vfs_fsync_range(filp, start, end, 0);
 }
-- 
2.51.0




