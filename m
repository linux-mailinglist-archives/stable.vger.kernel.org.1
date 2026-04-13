Return-Path: <stable+bounces-236351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G7iEGQZ3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:27:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5E23EEF5D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36678313E850
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E822E8B9B;
	Mon, 13 Apr 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WGwJhm8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F22E11B9;
	Mon, 13 Apr 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096681; cv=none; b=sLoKJZtyoywn2P/8Q+VUDZoTbTSCfId9CetydQhPAJup1SDWamDKWui8gcOuHSvuETOO8XwlA4qHcauXIjuSTL9aQH3paLY7st6b+Ex0iNIDPXYceaQa9iPY+KDkAc7tJIShdqA+hI7CYtL518jaqEL3kaZUgrgs3JfxlvZR3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096681; c=relaxed/simple;
	bh=WTskjp22NB9z6bsbqpBgV+tw97LBo7iQrAUs3YtKm94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPNjNDCmbC+lxOT53lX8VmFhEreDMDTI/va6j6C6z74QcgkqVnqL9irbmc8YlMcPcE7gUQY0w7i7+PV0XnFuzTCgBvbU2kwR07D99TbOwQIZJU/dRawoIvUhATUbJPu4P5s9Bhp31BUgyiTHMq2o7MVhGQkszd6ahu8EzECJFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WGwJhm8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F56EC2BCAF;
	Mon, 13 Apr 2026 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096681;
	bh=WTskjp22NB9z6bsbqpBgV+tw97LBo7iQrAUs3YtKm94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGwJhm8pVMb/iPe8dg13AonU664ApwhTsmxGEZpFNJ+W9MskCQEFbBLCUuc0R2xdW
	 FiI0coCw46/2OqzZrgvji86awnnu1adP8g52ateSb0kCm6T8lNhCpRV+g4JY5GfLjf
	 +EYvZa/QHbTrjo8tCON/tUcj9F5N/+9vqIiypzxw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 14/70] btrfs: make wait_on_extent_buffer_writeback() static inline
Date: Mon, 13 Apr 2026 18:00:09 +0200
Message-ID: <20260413155728.719886288@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236351-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,wdc.com:email]
X-Rspamd-Queue-Id: DA5E23EEF5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

[ Upstream commit 075adeeb9204359e8232aeccf8b3c350ff6d9ff4 ]

The simple helper can be inlined, no need for the separate function.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 316fb1b3169e ("btrfs: fix incorrect return value after changing leaf in lookup_extent_data_ref()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 6 ------
 fs/btrfs/extent_io.h | 7 ++++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2e8dc928621cb..3bcb368c4127e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1671,12 +1671,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	return ret;
 }
 
-void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
-{
-	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
-		       TASK_UNINTERRUPTIBLE);
-}
-
 /*
  * Lock extent buffer status and pages for writeback.
  *
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c63ccfb9fc37c..e22c4abefb9b4 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -266,7 +266,12 @@ void free_extent_buffer_stale(struct extent_buffer *eb);
 #define WAIT_PAGE_LOCK	2
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			     const struct btrfs_tree_parent_check *parent_check);
-void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
+static inline void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
+{
+	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
+		       TASK_UNINTERRUPTIBLE);
+}
+
 void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level);
 void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
-- 
2.53.0




