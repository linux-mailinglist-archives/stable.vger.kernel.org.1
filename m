Return-Path: <stable+bounces-140246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F8AAA690
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA86166B10
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99707329437;
	Mon,  5 May 2025 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i312R2lx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD62918C4;
	Mon,  5 May 2025 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484493; cv=none; b=lVjhjUx/enmr7l8gwQ3xoV7s/NQJTivo0/6uLpMOIT+c30gmlabr8oyzEHHuujcO/NIYk8wZ0Q6u/Qt4/HrdVapcGN461Bql/a6YVtQHTRXLGd1+DqnfEn1bl9N7SrFc/47aFrtp+zqpnYZJglSTcYWlMmSJA3eXAlWwSSJPAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484493; c=relaxed/simple;
	bh=pycTl0WXJpjeJiLYbQCYWyh+olDVkiJRC+srfOeyQKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2Ynj2Th5kdANDv0jEBbW43ONBPFaxW3gWIk2sLyWplLcke44I/mBWfxuigdPdxV6pg7DzPtJeKhVZ0Alfj/YXHhLShm8Rf9OmRwdsoqFWInQw+DOKQyPz7NqD6EzNjDFCkqdE9H0pEMntcAsi/0bvWUzAIxy9xcqGi3+ZExxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i312R2lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEC5C4CEF1;
	Mon,  5 May 2025 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484491;
	bh=pycTl0WXJpjeJiLYbQCYWyh+olDVkiJRC+srfOeyQKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i312R2lxW5RAQscI3Wgw1weTmTt+t34LNOtzPnhpg/gGEZfGYM+0RgWkYanLZ/S82
	 nRBIwtDCxavnZyLDAONA0jFy+D8nQ+56FeTYYscX9ulQp9zcD2NFHmPG2b4bCuhJ6i
	 VRlsh5lbwUANIikubUMveYBIImfTXPrIDB3e473DRr0H1B+Bis/5BsmQdqP5J+bL53
	 IVTYFiakWyIUo3X40j80R14yd4Z/2plVxGm/YBHliGwv2iji/A/amPBxkSXvIUcDDE
	 sgw4niIXD/zh+RvvVxM3UXpfvvNpZENpLPK0ExLddcDqS8vhBviTv/5z6vahcdmJ6U
	 UVugOXDkTc8MQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 498/642] mptcp: pm: userspace: flags: clearer msg if no remote addr
Date: Mon,  5 May 2025 18:11:54 -0400
Message-Id: <20250505221419.2672473-498-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 58b21309f97b08b6b9814d1ee1419249eba9ef08 ]

Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
MP_PRIO signals from userspace PMs"), it was mandatory to specify the
remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
check done later one.

In theory, this attribute can be optional, but it sounds better to be
precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if there
are multiple subflows attached to the same local ID. This can be relaxed
later on if there is a need to act on multiple subflows with one
command.

For the moment, the check to see if attr_rem is NULL can be removed,
because mptcp_pm_parse_entry() will do this check as well, no need to do
that differently here.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 940ca94c88634..cd220742d2493 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -583,11 +583,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
+	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	if (ret < 0)
+		goto set_flags_err;
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
-- 
2.39.5


