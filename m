Return-Path: <stable+bounces-220812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIOXGXZFo2kB/AQAu9opvQ
	(envelope-from <stable+bounces-220812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:43:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24451C74C5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB03431CE411
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B6411E3F;
	Sat, 28 Feb 2026 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/3vXYGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC1411E38;
	Sat, 28 Feb 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300697; cv=none; b=hoor61G4dc2Z5qqtwI9AZhADKTunvgqkpDKNSecC+JIviNBmibAtUAZa1wWplOdP55BVLzplCu0alqI5dnJ02iCIFXPU8zPAX/zCgB76V0rgFaOBK/vekfDcVe7jjADHCLDGRUjfW0YcF5HMrkH+RaMgX2shl4XmEx+ry8Tpyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300697; c=relaxed/simple;
	bh=8pP6ycsp0TqupfNl0Q2wbJsvX68uudcx08pR2T86QMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/xiRgkNZmpDBTg90Z4B9V3BNpPLXk45Uoeij+EAtzTXHpaKGosXnJwgUEV+MQFq6IZdGADLyUGR4WOHWiV52r1o/KPuFd0PS7CAwVbP0fpCOheU531IDjTlfl8AmONwiBM/QraTvUEd9xAUmbgYzzxJiY6x3P+JevE6XvA4JRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/3vXYGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA38DC116D0;
	Sat, 28 Feb 2026 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300697;
	bh=8pP6ycsp0TqupfNl0Q2wbJsvX68uudcx08pR2T86QMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/3vXYGDZGF3rOwSckQzeafV0ZtRYbS0PWdDfmGqv+8DDjVBx+CBJMvlvTtDPrUem
	 tbPXayqZlBmq4F9VneM6mkZme9t9rzS4Gbigg4ayLjN8FqgWtcKOKULvB+NS1QGYBy
	 v3KOX64natllCJTEmfTUmbh+b4GClLSqETOwDjlDWdOwEIaXD/FkE6dBg8wXi2b3xf
	 8UFZ9VmBI1cbiqbOIPelqZX5Zvd93P8f/MLk2/vGc/vpSyA7ZJ1UEJtxwx1XHSSgq9
	 GzGYvZ4nDgvoFLcEdn73Yf85tjndDn2bTrehZhYRPuuFoobVJYOlUcuD/1Bt53miFe
	 C49JytzwrOfAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: jinbaohong <jinbaohong@synology.com>,
	Qu Wenruo <wqu@suse.com>,
	Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 733/844] btrfs: continue trimming remaining devices on failure
Date: Sat, 28 Feb 2026 12:30:46 -0500
Message-ID: <20260228173244.1509663-734-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220812-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D24451C74C5
X-Rspamd-Action: no action

From: jinbaohong <jinbaohong@synology.com>

[ Upstream commit 912d1c6680bdb40b72b1b9204706f32b6eb842c3 ]

Commit 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle
error better") intended to make device trimming continue even if one
device fails, tracking failures and reporting them at the end. However,
it used 'break' instead of 'continue', causing the loop to exit on the
first device failure.

Fix this by replacing 'break' with 'continue'.

Fixes: 93bba24d4b5a ("btrfs: Enhance btrfs_trim_fs function to handle error better")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8bdb609f58a7e..bc0db6593f329 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6588,7 +6588,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
-			break;
+			continue;
 		}
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
-- 
2.51.0


