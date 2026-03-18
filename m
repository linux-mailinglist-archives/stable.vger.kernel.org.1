Return-Path: <stable+bounces-227025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NN2BzCOumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:36:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D932BAE8B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B44563062218
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927F3BED04;
	Wed, 18 Mar 2026 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjEMaCRP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E23939AF
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773833502; cv=none; b=cK+keVZx4ZBnJ+1f3Gv2fmoSAYwfCAIrsIJ0vBfnx2INFOh5T5QgjTye+pn1ibJ/9+U0cfd83YXpA7mUE7lpSExWc1GemU4+Wj+nC6EOkFLYb+XnvfSLDbVJMl4+WgKwx/PdI3jGrqCwgvS2N+BazKOSkHBTym8sEoQuU3ENQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773833502; c=relaxed/simple;
	bh=MLzekHue3ap7klvEGSohWT262WOq/FUTJNppGRVA5vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4VX2ozYAA+jhCExm6/QwCRVuA6aD0j1bzjBpYlMXNpEm9xQ/1QKJDyV6U+oA5qgdhuEq958kZHQ1mn2Mmb1BB2RcqVMJhGRWgD+JCK2X/3jxLGUmZ2KmIPAPayKufV3d8u6lQGjBIqqIrBatgPN3DQbWIbQiPkj32gIPN5D474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjEMaCRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC22C19421;
	Wed, 18 Mar 2026 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773833502;
	bh=MLzekHue3ap7klvEGSohWT262WOq/FUTJNppGRVA5vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjEMaCRPIXRNF+19MmBSlXUEjS47MNiUl/VphR9bV2s6jFiCs6H/0UovHO/QbLD2m
	 0hAEHPT+epodNhg9joOnS4urBiXhglEyNb0kihUDre4suVpnoSIngsYHeDMfniCl+j
	 wzYQLvAcTKFEv+owRLVeD69Lm3azBzvtuTrcRcxtmLFPYAHGH7YiD4eRa58I4K2B/c
	 MJgI52z+jw9nksZaHUkMLi+CmpkbYAUzQq4ponS6TocObuYvuC6380FC5Cbv+zv5Ar
	 zzPo1MzwFLncmgHZtEY03zzq7j+2trY2XIVcs7al4au1BXE+4P6J8ZbYXeaKHalcVk
	 A6zC4vWIy9FPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iomap: reject delalloc mappings during writeback
Date: Wed, 18 Mar 2026 07:31:39 -0400
Message-ID: <20260318113139.627346-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031714-renderer-twiddling-44fe@gregkh>
References: <2026031714-renderer-twiddling-44fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227025-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,lst.de:email]
X-Rspamd-Queue-Id: 92D932BAE8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit d320f160aa5ff36cdf83c645cca52b615e866e32 ]

Filesystems should never provide a delayed allocation mapping to
writeback; they're supposed to allocate the space before replying.
This can lead to weird IO errors and crashes in the block layer if the
filesystem is being malicious, or if it hadn't set iomap->dev because
it's a delalloc mapping.

Fix this by failing writeback on delalloc mappings.  Currently no
filesystems actually misbehave in this manner, but we ought to be
stricter about things like that.

Cc: stable@vger.kernel.org # v5.5
Fixes: 598ecfbaa742ac ("iomap: lift the xfs writeback code to iomap")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Link: https://patch.msgid.link/20260302173002.GL13829@frogsfrogsfrogs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Different error handling structure ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87a4f5a2ded0e..ee22d4ff74a95 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1320,10 +1320,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		error = wpc->ops->map_blocks(wpc, inode, file_offset);
 		if (error)
 			break;
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
-			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
+		if (WARN_ON_ONCE(wpc->iomap.type != IOMAP_UNWRITTEN &&
+				 wpc->iomap.type != IOMAP_MAPPED)) {
+			error = -EIO;
+			break;
+		}
 		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
 				 &submit_list);
 		count++;
-- 
2.51.0


