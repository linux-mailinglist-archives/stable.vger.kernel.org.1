Return-Path: <stable+bounces-204223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C2CE9E08
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF4B302533D
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB0241665;
	Tue, 30 Dec 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb/Z+zqZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8711E8329
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103626; cv=none; b=cAzT9RSgJ++pBQYiejph6W09IVQOj6d10Zvyawf4xWMW1FMWrbKqrZA4CXbq3JfEjTCWAel0N1XuTbkEaGnEtg0M/yZoouWp8PyiY+3e1rqHzaAFXiLZHrYEAMiVdCuiu4xCVS/bviS6vzORBZjLZCjqDw1HhdsH/pZEglzg2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103626; c=relaxed/simple;
	bh=ikRbj7SK6FcnwniwTajjEGaE4JAzAIjQFy8gFyaBZPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrSFCzhjInK43ZrLIvQkX2SU7gzay2vYezy0e/NZGbIRVHnm+OhPB/ZyXkwlcJMhx4t/Q5PZSDiwLvseoS2jqFp6heD//eDxTkxCmgmSS9ySWUB7ymn8dhtoef2dgY+vhkwI3i7269qLJZwI2bKUmeixTmqAfOJi59/SMBE7PWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb/Z+zqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407A1C4CEFB;
	Tue, 30 Dec 2025 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767103623;
	bh=ikRbj7SK6FcnwniwTajjEGaE4JAzAIjQFy8gFyaBZPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jb/Z+zqZ8ml8qY6PA34MUA49lUf1ZEhtB3SwOSzn/4myxjIojPhIIlC9+HVi4/CA0
	 GHC9jm6WnJUlXXX9D8h0BGk1tv3pQJPCty7vqYnFBLy8VwpM9VsMG6Qrn6N+yOU56N
	 qATmgR4zX92n8rj4V9GAHpyX1g8GQaTl0bKpKG9zr10JliPYAwmP148jzqgFqb8zfg
	 4Rq8lkyz34vPLHm3gLtX2r4RCGbJtV0ljnSrCoM117xOpwE+1S4CWnnjvPREHDnFib
	 AAM2NoDDqotFZMbicvXCc+Hev7sx5z/wOd49NubZDScLMBZakwjEqGr4ISOiiKsZb2
	 UxJeYNOVXhIZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: ignore unknown endpoint flags
Date: Tue, 30 Dec 2025 09:07:01 -0500
Message-ID: <20251230140701.2226659-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122923-crunchy-grapple-39a2@gregkh>
References: <2025122923-crunchy-grapple-39a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 0ace3297a7301911e52d8195cb1006414897c859 ]

Before this patch, the kernel was saving any flags set by the userspace,
even unknown ones. This doesn't cause critical issues because the kernel
is only looking at specific ones. But on the other hand, endpoints dumps
could tell the userspace some recent flags seem to be supported on older
kernel versions.

Instead, ignore all unknown flags when parsing them. By doing that, the
userspace can continue to set unsupported flags, but it has a way to
verify what is supported by the kernel.

Note that it sounds better to continue accepting unsupported flags not
to change the behaviour, but also that eases things on the userspace
side by adding "optional" endpoint types only supported by newer kernel
versions without having to deal with the different kernel versions.

A note for the backports: there will be conflicts in mptcp.h on older
versions not having the mentioned flags, the new line should still be
added last, and the '5' needs to be adapted to have the same value as
the last entry.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251205-net-mptcp-misc-fixes-6-19-rc1-v1-1-9e4781a6c1b8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ GENMASK(5, 0) => GENMASK(3, 0) + context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 80c40194e297..f86b1475c87c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -74,6 +74,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
+#define MPTCP_PM_ADDR_FLAGS_MASK			GENMASK(3, 0)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 21ebb4cbd33b..e396adefea02 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1294,7 +1294,8 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 		entry->addr.id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+			       MPTCP_PM_ADDR_FLAGS_MASK;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-- 
2.51.0


