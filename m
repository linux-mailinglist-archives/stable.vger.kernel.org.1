Return-Path: <stable+bounces-2016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170237F8268
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489C61C233C2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2233CFD;
	Fri, 24 Nov 2023 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkoanasS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14E2C87B;
	Fri, 24 Nov 2023 19:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74203C433C7;
	Fri, 24 Nov 2023 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852839;
	bh=tpRtB8VnbUob+oqr5nigCfuf6dQ9GM+tL9fP5xtcJ5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkoanasSV/NTLuORRU9uwjx7lsGcS1F31f6bHw3W0Ea49NBcM2PaqmvUfgFyJ6Kv5
	 za2fDvzEL/gZQV5zdmgpYBrwGN/dRb0moWYsTiyVr+yAZN27QK3hYV4OXCHnvoFlb7
	 /EhzWKZVVTAjsln63TsodSOz5PE47MwUQgW2XQCU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.10 119/193] btrfs: dont arbitrarily slow down delalloc if were committing
Date: Fri, 24 Nov 2023 17:54:06 +0000
Message-ID: <20231124171952.001940658@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit 11aeb97b45ad2e0040cbb2a589bc403152526345 upstream.

We have a random schedule_timeout() if the current transaction is
committing, which seems to be a holdover from the original delalloc
reservation code.

Remove this, we have the proper flushing stuff, we shouldn't be hoping
for random timing things to make everything work.  This just induces
latency for no reason.

CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/delalloc-space.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -307,9 +307,6 @@ int btrfs_delalloc_reserve_metadata(stru
 	} else {
 		if (current->journal_info)
 			flush = BTRFS_RESERVE_FLUSH_LIMIT;
-
-		if (btrfs_transaction_in_commit(fs_info))
-			schedule_timeout(1);
 	}
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);



