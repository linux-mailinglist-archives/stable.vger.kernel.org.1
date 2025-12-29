Return-Path: <stable+bounces-204144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 235CFCE84A4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C533E301176E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 22:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92092571DA;
	Mon, 29 Dec 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlcwaBMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D48230BDB
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767047616; cv=none; b=uiqk4y28UZ2+092BOKf7WqPScBbGm2JR6EytZMbqgYkpKgHpUnLrl9xDCFTfiSWLw0w/FEwfobOkrqH8OamBgdTejc00mQ2E3tZEfhPx0/2Q+w39RCXFEAUM+rjWXv7UOkRMlXCZyxBNPxazk4io7ljKmNKry8NUTkwPxPqDRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767047616; c=relaxed/simple;
	bh=GnvrUItZZbF0rg/sdBloipa6N5Xw1C2PnXy/XWW9Lz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACCamcOkKE+8ADnWzxVu0WoCJoT/6hS6Foiq7ujZ035vrlRr4PgUyqEybzjZ5fsHT60+g0ZW9+rstNvFoOtfH95UCkvSDc2Y35y1degRZYEJXKVGP05+f4rZL7eiqfSw3ZDdG4/xkjv0RJv6+5erk8Bm7m3tlvnf5wZp0hXLcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlcwaBMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73917C4CEF7;
	Mon, 29 Dec 2025 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767047616;
	bh=GnvrUItZZbF0rg/sdBloipa6N5Xw1C2PnXy/XWW9Lz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlcwaBMnXDspR6j3PdGVU5bgEfsK9L+taBuSmAa+w3RX7H8K7a8Z9omdDFWg+GSs7
	 zQWOPDdhwnyo8ESoyq7AQlN9wj2JHuD5ugbzJaHuSOzOb4J+xUrGC76LN1ICZhwmke
	 8vUJeRsX6CEtL7FWqDnNEA+onhjym8fKb78gxTTXmE+T35F2TL1Bud0f9VJiUB3ZNg
	 ZmTim3cv9/jl/ERHB/AoNX+6sLM1Ee49ZKJelB/cLBuqTRnERpb+9/JO0/DUo/lwKK
	 oTggV5TFGISG1hwKuN23WITc48vTL/hinuDlRN8bEzSn5yc3VFLabxg8nzeyVkcWRs
	 rUp7+GvUZOyQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] gfs2: fix freeze error handling
Date: Mon, 29 Dec 2025 17:33:32 -0500
Message-ID: <20251229223332.1744624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122906-preshow-nearest-b359@gregkh>
References: <2025122906-preshow-nearest-b359@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>

[ Upstream commit 4cfc7d5a4a01d2133b278cdbb1371fba1b419174 ]

After commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic"),
the freeze error handling is broken because gfs2_do_thaw()
overwrites the 'error' variable, causing incorrect processing
of the original freeze error.

Fix this by calling gfs2_do_thaw() when gfs2_lock_fs_check_clean()
fails but ignoring its return value to preserve the original
freeze error for proper reporting.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b77b4a4815a9 ("gfs2: Rework freeze / thaw logic")
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
[ gfs2_do_thaw() only takes 2 params ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 3b1303f97a3b..e6f8be03190c 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -759,9 +759,7 @@ static int gfs2_freeze_super(struct super_block *sb, enum freeze_holder who)
 			break;
 		}
 
-		error = gfs2_do_thaw(sdp, who);
-		if (error)
-			goto out;
+		(void)gfs2_do_thaw(sdp, who);
 
 		if (error == -EBUSY)
 			fs_err(sdp, "waiting for recovery before freeze\n");
-- 
2.51.0


