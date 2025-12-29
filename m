Return-Path: <stable+bounces-204150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E7CE851D
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 00:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D315B3011EE0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76524274B39;
	Mon, 29 Dec 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3SKtMrz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696D262FFC
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767050708; cv=none; b=Z9X6U2kyB4wi02l4D1cjEguG9FWyu+ItuADg0naRurEmop29kGQOQUeEuNhYgAR42wVN63oMOrwVIGeSc1yeL3Gpo0zJ+3hRfH+fuLZsKbm+ioMm3EZTaVdYZ/homIzsG0OvyCRtK4hy1b9nVH0QqLwz5btpQW5fJ9wQp7mLsQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767050708; c=relaxed/simple;
	bh=zTwdo6rFHuEkk/r2ZigL6O0P9I1SJZaDjErVOxlGq6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8FVNYdS77AzaT6N+Qo5ymZvCQ5FI/WBwP8nCQ6g1wrgUm5nmhPAJPtjr6kdN9MH2NNUWAy5hNFgWWZo3e19qoEpTiLhHhIGnNTCZUp1ZUFujnutn9sEPaVnroag+JVFndibKSQELRpCToucJF87acVPopEuYMA0sCR9NFcHeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3SKtMrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADD5C4CEF7;
	Mon, 29 Dec 2025 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767050706;
	bh=zTwdo6rFHuEkk/r2ZigL6O0P9I1SJZaDjErVOxlGq6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3SKtMrz0BncyOrEENq+5s3MuyTXnpO+BRLbC+kKJLgkhrcXHtziM4BEococfqVYp
	 oWyk6s7BjjptEyb1ZmWl8jX4QxgmjJ6woIChDE8+Oc86WKZ0FnctE3orXF1MFXKvVg
	 IhQyt37GjiBc5sxt/8c+uw+57ACY9EB6mCvXD2VJJtgmH39SZ755G/6xTjalqA1cKo
	 qgQDCObc9sGG8wD7KnDJB6+xhHzh0d4o0cDwpIsW4iGPmET531C+9UNbbyep6pMP81
	 kQDQQf5l5zNBYHBSRqSyJxg9/LNlyE8RdfmcBhUEpAE1+9dZjfnMYoiyzfgNBm/Ipw
	 CokUia0OiiVYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] gfs2: fix freeze error handling
Date: Mon, 29 Dec 2025 18:25:04 -0500
Message-ID: <20251229232504.1818648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122907-defense-blanching-5c39@gregkh>
References: <2025122907-defense-blanching-5c39@gregkh>
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
[ gfs2_do_thaw() only takes one param ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index aff8cdc61eff..8d90a5e48147 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -771,9 +771,7 @@ static int gfs2_freeze_super(struct super_block *sb)
 		if (!error)
 			break;  /* success */
 
-		error = gfs2_do_thaw(sdp);
-		if (error)
-			goto out;
+		(void)gfs2_do_thaw(sdp);
 
 		if (error == -EBUSY)
 			fs_err(sdp, "waiting for recovery before freeze\n");
-- 
2.51.0


