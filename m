Return-Path: <stable+bounces-73014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB996B9B1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382DB2850CB
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA21CF7A4;
	Wed,  4 Sep 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uohWGbCO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5D126C01;
	Wed,  4 Sep 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448237; cv=none; b=FM4rzm9r4bARanEpveX14f0ZJq3S95RD3mGBhWyAlECrKsqp+ilHULHcuJ9TalaVbpwr0IcuRn7pEvJSRK9il9nFPqQVxH4q1zvo9zTzNhDNmk+uqYdYG3r2hF6q1SrhDRBNZ14esbSPsWRMKr1R6eX+kSlgM7dNzPPO64N7hII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448237; c=relaxed/simple;
	bh=RBCC7cUoHBmu97wTma4VbvUaoCWhlOpWYCkYOJfm2A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQa+KnQ+JhKAyR/n8/KaJoyyp84XDcZ+LmHYfVd/QAZqH1crebQkKY6hqfDsB3DtU1Xc9X1+WAG2c6v8DOHBskx5AbpHJP+mtCd6VFGEWpLBlrkL0BS2PVZVYy256ZYB9tnTQA6t+UtXlrNk1y/IqfRWhAM9UbonNiDWZwZavF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uohWGbCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B1AC4CEC2;
	Wed,  4 Sep 2024 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448237;
	bh=RBCC7cUoHBmu97wTma4VbvUaoCWhlOpWYCkYOJfm2A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uohWGbCOdPaQStNzbXtmqh34++zUv1HNamXnVueW2UlyJ8OdvenJ5bLJG4/tbjRKD
	 rv/nOfUNak1OvBI87z4TzxI4G5OVJSGQ1WnMoDD2ftyNMI5LBQVkctKYRbd2dKuen7
	 aG5uHdnr6+oL/l2W7MIEge6UA/hW1ssGDNrc5wNxC/4VXv7oKUbeGp+zF8zU5/pzgX
	 Vbm5hyef54ZMlFGQ9mmqu1A0rbcJmxQXhOO/H7HeypeNg65dgvHCXoayiJeJJdNIRh
	 Yi4QynZvy05AlOyy4WDEAfqAtf9vuVmL7Z5a40/MVp9X5Nd7YB+P2J5z2VQSoy+vRH
	 A9x7Q0jNxKkPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y 1/2] mptcp: make pm_remove_addrs_and_subflows static
Date: Wed,  4 Sep 2024 13:10:15 +0200
Message-ID: <20240904111014.4091498-3-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083045-mosaic-sniff-fe02@gregkh>
References: <2024083045-mosaic-sniff-fe02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=matttbe@kernel.org; h=from:subject; bh=Hf6nOZzdQqe/85EIo+VaVSliU5rKwlQDhLlf0nvqFDc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2EAWL+zvp1QTzXf+Toem69XbjGC3EbNNmulDg MnX6HDOaYKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthAFgAKCRD2t4JPQmmg cz9iEADcXYM7vRubpbQn+oWoxJ+H5UbIFrgnIV5gRyaVCK1sdvSiV84Uhpzjawh76aFqr+lYLWY PI4lczNAxeGkh0vBFnzz/A0U12BMYkocpZdi5/LmNZ6GSL1qUuqk8SKA73bjvu90iilrJOg/Nc9 iOW13qYnJ7FP69qt3H4g/lxLJJuEGCylaMjI5AQHg/6SbgxSgTpd20XFvf4VdIfkftM9hH2ZSTe t1KEKwdrcE8EJoeG/BaIUdBFt8ycxfz6QGBrhSMSSQ+Zs4bhPNGAO4UrkPcbJptIQPJC4MaTCt0 2J5sSDE6PMOSVcPCunkuiAQAR6LBNNSIQ4Rnpp1axO0lVqS1zM/ataGJ8r6oudqvkFQtsHoigXB OoTfNfSlytSzRca0FCmvoFygNeKpghU+NoLo0omzaghDptM1Cuw/y7VL32+makt/KuKYZHhm1S2 kJJNHp27EQJ1+JpeGP8rX3H8cV80cucEoymMqI3NO+JNZKfkY0Itjs0cN64bkielSPXEBE3XsAk yE6ItKvvDjnA4nhUD/pCfBprARdJDCODHTIo0Y5uo66/yV7bspl2DYUHBsKMWdwaxZzFpY+KiIv dPiFFzfCxOiZhPrZEtLs8WL476CLUtJ7PQ1u+bC5M+nRrq3ofiZF01IOESQOrpL718miyebfbgZ kxPRUP5SQB9HslA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit e38b117d7f3b4a5d810f6d0069ad0f643e503796 upstream.

mptcp_pm_remove_addrs_and_subflows() is only used in pm_netlink.c, it's
no longer used in pm_userspace.c any more since the commit 8b1c94da1e48
("mptcp: only send RM_ADDR in nl_cmd_remove"). So this patch changes it
to a static function.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 87b5896f3f78 ("mptcp: pm: fix RM_ADDR ID for the initial subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/protocol.h   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f148610c64e4..46e61130a514 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1696,8 +1696,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list)
+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 837703405d85..9a367405c1e0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -837,8 +837,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
-- 
2.45.2


