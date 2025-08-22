Return-Path: <stable+bounces-172416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2E8B31B0F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E633A23A06
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8CB303C91;
	Fri, 22 Aug 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTEtbMcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD626301476;
	Fri, 22 Aug 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871898; cv=none; b=P+f7aIzBav5iNDEmbwro3uIY/0SjhR/u8bDLFt9b5gVGjd/xPWl4Bajs/bdVI/GiPpxkYdK5z1f1hsoaxLF09cTbizIHn381qkwI6sK0HvDqCeVENmDpkOC+2L8dyc9G7AAqFnG9ltpS2vUMT/9coyue3F07VUbgIpgC8pZVags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871898; c=relaxed/simple;
	bh=QL4GYMJbSZ6dyHAFhMKO1oa83YsyaIzDSU+abRsULds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmFkOWYwd0K+utyoHwHBC48qsVnGa8j85N2CWEsvkwd2eaJtLMeb7uk2cS/0UAhISXp6kx1X3Jo/Hn3t6/hQHaXuliPUCXaALJOZbWC5NvqtgLbS6b65sx1CVSRy8g+SJ+GJPjvBDHrectPkU3niYDDNZks1jLGOF8Nw65l1KrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTEtbMcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACF8C4CEED;
	Fri, 22 Aug 2025 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871898;
	bh=QL4GYMJbSZ6dyHAFhMKO1oa83YsyaIzDSU+abRsULds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTEtbMcnIO+tU04ZO6A31LCfDvT9swn5alWDpB5/sVIS8nqoji7HdcPeh0QhFTFfg
	 lChF6BQuBIfOLjysR2gFGy9OyxdFxFwueqfP+5SadbjaRNMkeZxk3cp5rw8MyFIDIJ
	 tME1oldJYtmDvDBnF2zbKa40uxKVxmgauA5TkwruvaxVeIGOGncAKb87DYy+LW1o+X
	 L8vmrRGPg3826/Rx7bBeWKSg6rIr8hoCMXnNc57zJ8atn7OKlB/oXZCQ+fnbRVJiyq
	 QUB4mu+OfdHvvAm+8jSSUu426tdpP9lmQFWonAHmL/ZgVQ4p9PAzjz4t6og8+Fw2n5
	 1JVkfDstsTCKw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 1/3] mptcp: remove duplicate sk_reset_timer call
Date: Fri, 22 Aug 2025 16:11:26 +0200
Message-ID: <20250822141124.49727-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141124.49727-5-matttbe@kernel.org>
References: <20250822141124.49727-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=matttbe@kernel.org; h=from:subject; bh=bfxKbZFjBnL2xMZSujES+vx02mx+j+wc/8FOKuhNaSo=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVPW/cDrfv/Rv6JqozEvWBxrLCuzlil7MKK1j/pZhy f1C7OXejlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIksecXI8E2/gjVd44LQn65P m/Pr91ZopAcViJUKuURvVv0w3a9HkuF/0u236d+4ig76FBW9VJCztOJLC52xRLa3Mzhf+p2ufQM 7AA==
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
index bb1a02e3dc3f..59d6e701d854 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -383,9 +383,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -399,6 +397,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
-- 
2.50.0


