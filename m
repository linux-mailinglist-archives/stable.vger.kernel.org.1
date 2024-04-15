Return-Path: <stable+bounces-39773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B28A54AA
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2841F22B60
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D25679E2;
	Mon, 15 Apr 2024 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaKGt2t5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64261D52B;
	Mon, 15 Apr 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191770; cv=none; b=ajxfodOcgcNO27+rw1W396vC2q/7ZHrUHpDhzri5nAvQxY0dGe3cseHarLIlky1tFr2drVCY+N34N9UfuQ3nlxpAUh7vyqwFwWSVh+/efMhMQBSdLob0eXmghHpBX7gA0ijO5Ag24ggVbY87QMf8BFjSxV5TMVks2PX8cjRNnjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191770; c=relaxed/simple;
	bh=RAASu0oTSd6E6WUXyGGQsk0IfYJyRtYBU3ZR93L2E0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KE3N41vJz1aYJ4ATcT3p61jwkcyPOyKsXAHg+Gv83KhvuMSaDV0OPmPN06keOFYNlhDtfzbRtxfYf6nPjNECXXJlUZrHNNCAKpiJFzkPMo+3NDQhVyAfc95fKubVKPJQIQh4507y4FVH4lN5AOMfn/OWq53ekEKQG6dPa1UAw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaKGt2t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8BDC113CC;
	Mon, 15 Apr 2024 14:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191769;
	bh=RAASu0oTSd6E6WUXyGGQsk0IfYJyRtYBU3ZR93L2E0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaKGt2t5pQaHcX0Ar2UXYXwnu+7zbNlgk+9H+L6rv3QJkc92j5LmRQZSjmWC4zq4E
	 H9qMOVPTLs9pMSzu/axk4FnxD0hA+hXG4IHeRCb8xgB+OFuWz6SZ93RQcSOCJGiDHp
	 tdzxI7G0qxx5tqxkRT6W8RmCBGaHrslH0yq2L17Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 079/122] btrfs: qgroup: correctly model root qgroup rsv in convert
Date: Mon, 15 Apr 2024 16:20:44 +0200
Message-ID: <20240415141955.746944420@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit 141fb8cd206ace23c02cd2791c6da52c1d77d42a upstream.

We use add_root_meta_rsv and sub_root_meta_rsv to track prealloc and
pertrans reservations for subvolumes when quotas are enabled. The
convert function does not properly increment pertrans after decrementing
prealloc, so the count is not accurate.

Note: we check that the fs is not read-only to mirror the logic in
qgroup_convert_meta, which checks that before adding to the pertrans rsv.

Fixes: 8287475a2055 ("btrfs: qgroup: Use root::qgroup_meta_rsv_* to record qgroup meta reserved space")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/qgroup.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4162,6 +4162,8 @@ void btrfs_qgroup_convert_reserved_meta(
 				      BTRFS_QGROUP_RSV_META_PREALLOC);
 	trace_qgroup_meta_convert(root, num_bytes);
 	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
+	if (!sb_rdonly(fs_info->sb))
+		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
 }
 
 /*



