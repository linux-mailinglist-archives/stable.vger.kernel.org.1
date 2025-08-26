Return-Path: <stable+bounces-173436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE26B35CC8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14E87C544C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908521D3C0;
	Tue, 26 Aug 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eQ36FDYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896C20C001;
	Tue, 26 Aug 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208243; cv=none; b=VjAyAIBoK0uzxxPcWQ2EyPpYllzEc0DTt0QDsXsEMATZD6nQ09VKnXC2mSyic90ofzFTwuanf3us4cnNuRB6u5e6eKXjvpPZsKPlH4ewf5XQN71fUMtlW6JbWc2MJ1c2PoLE9OlUrc6oLoADv2EGv+rVM5AX42CbSZHHANMu7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208243; c=relaxed/simple;
	bh=tNfnOiIqCu6MSVplNwjGv3pACkYzj7RsdjJVwQLallw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSgoJtH035pFzu5BwiAyVEcyMnLl9iJqkTQV9ImCF44T4mLAXn2g+mozjkTdmPCX4QqgMARpEB6r/8W9KZ+fTDwqo8TEXIOTIFdD/bRxD0YrpSmHymXE9a1tXvURJpoJnL0OFMUxmSIhKFSnqr83NTmEHE/YrH7QF75L1b40C40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eQ36FDYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B1C4CEF1;
	Tue, 26 Aug 2025 11:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208243;
	bh=tNfnOiIqCu6MSVplNwjGv3pACkYzj7RsdjJVwQLallw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQ36FDYx78/xJBxvJlpWBwgbqqY3BwfBUc2dOUsXcB8JbxaD5cLSDgYNADsqKatw0
	 hcDw/1Jw7RPDNLZNTogvqYnlLAqh3pFD4q3LiQmu4X/87p3OuFQzMXPtPHlRdDCI80
	 n3p5EqqbXDWNnltBj3zeIhJU7jhYLBQ37npioRgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.12 035/322] btrfs: zoned: fix write time activation failure for metadata block group
Date: Tue, 26 Aug 2025 13:07:30 +0200
Message-ID: <20250826110916.214562453@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

commit 5c4b93f4c8e5c53574c1a48d66a27a2c68b414af upstream.

Since commit 13bb483d32ab ("btrfs: zoned: activate metadata block group on
write time"), we activate a metadata block group at the write time. If the
zone capacity is small enough, we can allocate the entire region before the
first write. Then, we hit the btrfs_zoned_bg_is_full() in
btrfs_zone_activate() and the activation fails.

For a data block group, we activate it at the allocation time and we should
check the fullness condition in the caller side. Add, a WARN to check the
fullness condition.

For a metadata block group, we don't need the fullness check because we
activate it at the write time. Instead, activating it once it is written
should be invalid. Catch that with a WARN too.

Fixes: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2092,10 +2092,15 @@ bool btrfs_zone_activate(struct btrfs_bl
 		goto out_unlock;
 	}
 
-	/* No space left */
-	if (btrfs_zoned_bg_is_full(block_group)) {
-		ret = false;
-		goto out_unlock;
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA) {
+		/* The caller should check if the block group is full. */
+		if (WARN_ON_ONCE(btrfs_zoned_bg_is_full(block_group))) {
+			ret = false;
+			goto out_unlock;
+		}
+	} else {
+		/* Since it is already written, it should have been active. */
+		WARN_ON_ONCE(block_group->meta_write_pointer != block_group->start);
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {



