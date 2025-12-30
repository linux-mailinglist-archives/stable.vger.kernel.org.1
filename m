Return-Path: <stable+bounces-204219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D2CE9CEB
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354203016CCA
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840122258C;
	Tue, 30 Dec 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU1Sri4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519C23C4F4
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767102130; cv=none; b=MhYXuc6E503TvRII5v+ai2gVsOfGyShW8T9+mVR5QclQDZzRDg6dLI+1RvKPsjAKrNlNN+IYVaiIzuQz7nxpHkVuBmXlETKK5VeZw1/RNDnAwG84UKyQ4j5mPl9DpN3FNkfSBa492XUFqasHWrqv/AukYgGZQhUX4j4+7F2AuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767102130; c=relaxed/simple;
	bh=PGbcrtxVEFaTUEg/sG4CZwz6iF2e/8hwjetHIw+qMh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbDfJxdxpwFtrqEmf5bXHh+drBsy1W5WsXGyspnkrBSL80jIC/ayuls721rTkPqC4TgB0nR8JH4/V0RwlTLIWFTc7mXwjDOxivasM/+4DbOXPUPKBvlY9h33aSWuQ/+nK8TZCkj31lpfJcZEv0vyLyj8+sWCOLgNw+XNYg1tzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU1Sri4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83381C116C6;
	Tue, 30 Dec 2025 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767102129;
	bh=PGbcrtxVEFaTUEg/sG4CZwz6iF2e/8hwjetHIw+qMh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aU1Sri4Pm8JdSEfSZhCEpPBZV3XIwBgjubiqoZUSkwdltHJ95FmHnL1xkyk5RnIPN
	 Rb+UPXnc1VTBtfyhW+e359MhzgN766NLYAPXCPaqVe2yN4fTTLLS2cpvrzN9e24gIp
	 JnLE8IgiAdN5bWg7VXopGXIPM8wUB6CcCUP+9sp+S6tl+ZoDjYGt87NuTbGBCp9QAb
	 TJIHG6QQuh9lsEm3yMfFTKZPrMENo795K6SRkMWLVJb1SyX047KiFFcu5GD41aVwmQ
	 uy+07nI0HqTUTztgGLQCNGr36Gpn4cNeWpAjwwCvYIaLePPWFVo0KvFyKBRIrKTutR
	 jS8yIX9/fr5Ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: ignore unknown endpoint flags
Date: Tue, 30 Dec 2025 08:42:06 -0500
Message-ID: <20251230134206.2207988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122922-cedar-reapply-f9d1@gregkh>
References: <2025122922-cedar-reapply-f9d1@gregkh>
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
[ GENMASK(5, 0) => GENMASK(4, 0) + context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 00d622121673..926d5de5fd21 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -88,6 +88,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
+#define MPTCP_PM_ADDR_FLAGS_MASK			GENMASK(4, 0)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8dbe826555d2..9f25cfd96f98 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1435,7 +1435,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	}
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+			       MPTCP_PM_ADDR_FLAGS_MASK;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
-- 
2.51.0


