Return-Path: <stable+bounces-174046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11879B360FE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE90A2A27B2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFFC18DB2A;
	Tue, 26 Aug 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJa/Gppi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DB148850;
	Tue, 26 Aug 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213349; cv=none; b=Gd6eiYxDQNC5hKrHQwYcXd0GIFHSCY5EvDkPNbGQqMFEqShAWwCqujkYIArua8+ZJ/3EoHteqM5U2osY3fRmcrtlCBCSHq+CkeJm2Wfi3DxlMN/KIElNKZtzRmHgcIi+ax8xxUQvyQ+dqRUTozGvB0QXwu7wOPRvbd8cODmC/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213349; c=relaxed/simple;
	bh=b8Svtyxj7DiRTpryOeDLd2brAU3rdGjrKwoWpJhb8jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqChqd0u6hera1xqUIL8bWJd+uOz/AL5OJrRhgeOLETb6lvlK4WmE87k2aB8twGXvYt+Cc/nD6A3RfJlQ/MV4YOhgBdiSi5KQ5e+0srts8ZQahaCVvyWopTyruJHDS6w0HLNZUNfuWN2TsPAbM1AAW+MQgyPxk8pwTkGOCj89IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJa/Gppi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEA5C4CEF1;
	Tue, 26 Aug 2025 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213348;
	bh=b8Svtyxj7DiRTpryOeDLd2brAU3rdGjrKwoWpJhb8jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJa/GppijQUSMD/avrxbAiF3t3Z+Mz7/LnLg8DO22ZiO+TzNlTwujwFHKHatMU6Ce
	 KEe7jkoKh/qRFNdd4cW9JOUzYnNup4J65+BD/9ofmtECx/xvZcNpH4Wh2JnUqUMUUP
	 P8eoMmMD5WQtE6EVO56i2tpKe28U7NHo42xYT1U8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 314/587] btrfs: zoned: do not select metadata BG as finish target
Date: Tue, 26 Aug 2025 13:07:43 +0200
Message-ID: <20250826111000.903892543@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

commit 3a931e9b39c7ff8066657042f5f00d3b7e6ad315 upstream.

We call btrfs_zone_finish_one_bg() to zone finish one block group and make
room to activate another block group. Currently, we can choose a metadata
block group as a target. But, as we reserve an active metadata block group,
we no longer want to select a metadata block group. So, skip it in the
loop.

CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2417,7 +2417,7 @@ int btrfs_zone_finish_one_bg(struct btrf
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
+		    !(block_group->flags & BTRFS_BLOCK_GROUP_DATA) ||
 		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;



