Return-Path: <stable+bounces-172408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFFAB31B07
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC663B99A0
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F34B303CBE;
	Fri, 22 Aug 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUuw/Z6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276012FFDDA;
	Fri, 22 Aug 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871852; cv=none; b=kwRbJGjphiLX+jJxgLeJSHeKs2W6lMEBfUkGlM+HPK+4oh0ofqHLMki/UIFtf2z0Vd65yVERfvjuVzAa1OiKiItvayuekj23bEG+X+438jQcKJsaqNgBo18tP1zRWuSw7NRK27WYOuLZEEOkrFhyjtLPs7dCeI5wqUbXxZic1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871852; c=relaxed/simple;
	bh=a8NjoEVxY8u3DcxZyC/KDzS6E9mj06ohObDcwAeuN1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYB7sPntE/9z9jwgt7yCamWgrJLExFal086Lkb83ULbYImpIAoWODRcVoQhxiV1KwzosUzFeJjlXBNpxBjPEAVOk1WJ7ie2X006QDGIK1wqNMSxeJnBX+5TphoWEdg48ZX1yAvP3h4Kc6lJD3etR8Y2fDpqnfV62FFtUUyyWLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUuw/Z6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311ADC4CEED;
	Fri, 22 Aug 2025 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871851;
	bh=a8NjoEVxY8u3DcxZyC/KDzS6E9mj06ohObDcwAeuN1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUuw/Z6p4SRfjPGUq9SWsKyAL9VoZAmEBjFMKyUGUFScihiK3+MhTDk3by77NGxZT
	 AlNyu2W1mBGEgFdOUKQC11tmJK1gZMleqkQZY4Epk2W5lBOBh7olnZi2SVY7/Y9GQb
	 77L5hr5He1S+DNB62oNdluahJ9Az5VbX9KDC1ocnN3A8HzqVqD79OZ8V2p+iCldn16
	 Lgr6HjNmWw+MGXojV+DE0nEKQv+czgA1EV896nQzTy85Joh2/H2nRVNy078/I28Ve4
	 /BbWcbs8nBrErwRbnz4wRSuBIgzSZR5oVc427kFW0HV5k4OTa45ZSJTs4W1ysufCmU
	 po2bFuDhsuAqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 1/2] mptcp: remove duplicate sk_reset_timer call
Date: Fri, 22 Aug 2025 16:10:28 +0200
Message-ID: <20250822141026.47992-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141026.47992-4-matttbe@kernel.org>
References: <20250822141026.47992-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=matttbe@kernel.org; h=from:subject; bh=7RACEUVrw3CZHaTHCui8aPCbvv4BE86d0PiEOaNbOik=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVIVGn5yi6hu+91Bt+urTWxvlhL2Wb/CUnB6rN1FnX xH3OeHPHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNpZWZkWOil73BbMsBDtCfl W2b+tKfzl8ZVbDT/9+Wg4YTFKYKWbYwMU3fXNP+ap/5bwei6e7HMVJWTD+SPqHwwEzJ1VDy5LsS NDQA=
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
index 4f65e8abf343..46f5f960472e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -372,9 +372,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -388,6 +386,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
+reset_timer:
 	sk_reset_timer(sk, &add_entry->add_timer,
 		       jiffies + mptcp_get_add_addr_timeout(net));
 
-- 
2.50.0


