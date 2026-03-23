Return-Path: <stable+bounces-228482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MlaKhhNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 394EB2F4643
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69A23303BD24
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D103AB295;
	Mon, 23 Mar 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="soq/gTmK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E6199FAB;
	Mon, 23 Mar 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275250; cv=none; b=m99G8JTIyAv+FLiiTTTiWh4GVoT2VPkFrCQNR/ii/R0apzQUbO4ZJdH4H8xO+Yty8QcV1ghGSBiV72UGzZwcWBo6Dz98jhL6qC4+NAaH4WQIpoEKDQ5wKvHOH5X0bnAPCB6R6VpTfhV6M3Y2knHOB5Vn+B0bcbUksy6S/KQyCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275250; c=relaxed/simple;
	bh=I8Gy9BvLqVFL8v+jImBLEHV6V0hEdZJn76nKFuRbcjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2oQ4GywSCUkrYVCfXOcSb/IUue+DLWj9rFs9JJ2rIvn/zHTnBpjC+A+q4UnsULAO7b7OPxcu03lcvlgDygG8nksFJFEgKULskm0f+CbRdfVLSwLuR/Vh4sRmtQg1ffrzyeyvtUJa8ScvjKgpNBynwnW7+Bmi2BG13WPMDdpwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=soq/gTmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE04C4CEF7;
	Mon, 23 Mar 2026 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275250;
	bh=I8Gy9BvLqVFL8v+jImBLEHV6V0hEdZJn76nKFuRbcjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soq/gTmKNzy54BS1LMV6fHMu0uexNE+3iD1Be8Jp7UO07jbcZSyTpFjAfeaCHj/3z
	 UWE4ixRL3FExT/cxxBNHZFSagmv1X+uma5Ssgo639KuRhAPmHjg5GVtOtlfHtJvvA4
	 Pw8IukjDzvzd2FmmItXq41zo7iDTp09llAcSU+VA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	Boris Burkov <boris@bur.io>,
	Sun YangKai <sunk67188@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 028/460] btrfs: hold space_info->lock when clearing periodic reclaim ready
Date: Mon, 23 Mar 2026 14:40:24 +0100
Message-ID: <20260323134527.386944397@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228482-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,meta.com,bur.io,gmail.com,suse.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 394EB2F4643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sun YangKai <sunk67188@gmail.com>

[ Upstream commit b8883b61f2fc50dcf22938cbed40fec05020552f ]

btrfs_set_periodic_reclaim_ready() requires space_info->lock to be held,
as enforced by lockdep_assert_held(). However, btrfs_reclaim_sweep() was
calling it after do_reclaim_sweep() returns, at which point
space_info->lock is no longer held.

Fix this by explicitly acquiring space_info->lock before clearing the
periodic reclaim ready flag in btrfs_reclaim_sweep().

Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/linux-btrfs/20260208182556.891815-1-clm@meta.com/
Fixes: 19eff93dc738 ("btrfs: fix periodic reclaim condition")
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/space-info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index af19f7a3e74a4..ada19b3288611 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2128,8 +2128,11 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 		if (!btrfs_should_periodic_reclaim(space_info))
 			continue;
 		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
-			if (do_reclaim_sweep(space_info, raid))
+			if (do_reclaim_sweep(space_info, raid)) {
+				spin_lock(&space_info->lock);
 				btrfs_set_periodic_reclaim_ready(space_info, false);
+				spin_unlock(&space_info->lock);
+			}
 		}
 	}
 }
-- 
2.51.0




