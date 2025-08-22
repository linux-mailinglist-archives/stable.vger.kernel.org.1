Return-Path: <stable+bounces-172411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C6B31B0B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A37680B5D
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736092AE66;
	Fri, 22 Aug 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg0PeKCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB982D97BB;
	Fri, 22 Aug 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871877; cv=none; b=bizHLHSt8jGp5Ja9xGvBFXnaKfJr9Kh9G4HzH/j7dGvv/bGcClNaVHUgcS2PxgmgvUaqVREP4HflDBRcOAB3KCheuiD1hnW4aHfQK0p2hgPnbgUSghVj8vVwGiX9h4dCO9eZRHOZg+qFLxhvbKrG+eW4ALUXdmk319wbD+Fws08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871877; c=relaxed/simple;
	bh=qgu3i3ySf6YZE57AVL8b54jNjSeonxTOp3C/cdM28NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMEmkPPw9taniVY2RWNK2sBopbNOPBGB/cjV3DTF1SXUqgiJYAq1NfbLn+UWsHvs7Z3LptGFmKhOEeCtwKa3E79+XKzeb7LyprWG8hUvh6aMWW9DMEAApFOs8+CsLhCjb9ft7jmyWODkHaGWErexL+UZKPHtDqACDww1R6l50zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg0PeKCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF3EC113CF;
	Fri, 22 Aug 2025 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871876;
	bh=qgu3i3ySf6YZE57AVL8b54jNjSeonxTOp3C/cdM28NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sg0PeKCYnJk2oQxPsRDUIS7c1LGRvvvUf40OB6ZXrJNE8qHcQSC7UfNGV4NngMfwn
	 ePnEHJLJMdYVMN/Swxnb76PHMn094HRnOZTF+sYnGIYUYL8h2OcSR8y+wdaU2G1PZh
	 k9At5p4rDa0SosNyaJGNQYH6+qaWycrfGpPGLVN76p9ndndvXTuNZn+97U+6pab5gi
	 fRx5JsIbHAEWzSpuGY95KLIXpckfEI9ZwMvaVk8/V4Raj+8RfzLt7yKKvogUK1RRuO
	 lIFksB28AUrAyECIuOzuMIjuBgm/JxFU7SpOc8lYYmo8uXe+w3ijUbmpNx8R5aekei
	 tKxbdoHFmkxoQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/3] mptcp: remove duplicate sk_reset_timer call
Date: Fri, 22 Aug 2025 16:11:01 +0200
Message-ID: <20250822141059.48927-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141059.48927-5-matttbe@kernel.org>
References: <20250822141059.48927-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=matttbe@kernel.org; h=from:subject; bh=bXVzIBqtkjRoTUiVOcrn+zcShae8fQYgX0XQi5IZ3AY=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVJX+31cc0cEi4loUHBUQvbeWXSjd37xvYZi479fG1 1qt6h87SlkYxLgYZMUUWaTbIvNnPq/iLfHys4CZw8oEMoSBi1MAJlJ4jJFhxrGLspIFom/8zmdJ ZazPLUs1ibUvswu8pSxwxcpotfY2RoZ/7xccUj9pzukSPP+JtvFrI6W86Qeeb1Jh2rNfLWZHfCA XAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 5d13349472ac8abcbcb94407969aa0fdc2e1f1be upstream.

sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.

Simplify the code by using a 'goto' statement to eliminate the
duplication.

Note that this is not a fix, but it will help backporting the following
patch. The same "Fixes" tag has been added for this reason.

Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-4-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Before commit e4c28e3d5c09 ("mptcp: pm: move generic PM helpers to
  pm.c"), mptcp_pm_alloc_anno_list() was in pm_netlink.c. The same patch
  can be applied there without conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ffe6fdb1324..19c07033e6fa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -373,9 +373,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -389,6 +387,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
-- 
2.50.0


