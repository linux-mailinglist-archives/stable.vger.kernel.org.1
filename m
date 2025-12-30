Return-Path: <stable+bounces-204220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B69CE9D00
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B553017F1A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FCD1C3C1F;
	Tue, 30 Dec 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h765cRJb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFF4594A
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767102524; cv=none; b=TEUYvWN+ZzgL94m8rNYNhFACNnKGr9arJ8UgtJH2eFHHpz5UQtk82YSn10QgNF4dWSu1H5qbk9dHtRwKrZezBdzYCRShjCKmY9F+how43+TA566mhau3kvivxsz30YREv3fM1K9txPajat9cBuPLaOz9ALh8jArqh7ZRSh6SilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767102524; c=relaxed/simple;
	bh=dH4w0loHnUpvQv1n9imvXJRxKFdQQO7nODi4ZvyHc9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciJIxh2R9LuxnYxButovY8Nmt1TwLzt1V2M+J56emIyDyUd/FvC5Kdu4cieNyk1dNO2ZutwVoUS9an4Rlr2l7i8N+FP20v6DTByUtdfENwf01gHtlca/zO41/oGn1HErLDoR3MjaOmZh0T9FqszeBbZ/Y3L3+75SgMyfBQ0P7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h765cRJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E88C4CEFB;
	Tue, 30 Dec 2025 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767102524;
	bh=dH4w0loHnUpvQv1n9imvXJRxKFdQQO7nODi4ZvyHc9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h765cRJby8Rbo2ct9DUXSMWY/WduII8i6C3eLKdjSihpmFXQPgutoNTOTmbrRV63H
	 1jxVgF2AW3AlLQc56WxIx5u1osZTf2hlBuBRNoi7R9pqV0cJpoD2q50j4kIvyVNXTy
	 UGU0PfcLoV8N6+Xk3bmCDmQrFTJGuhvjrvBiiYdx4bOxtsHF9FLxWmy8ABN5AfkBwl
	 neelDxnPEhjb6dKUO/Pu8N+ux92MRGlcVOf4X+jfz/WNPlOt+XNnRtTCp0Lo8Ommen
	 DYz5Y8FPevA60xWDwo2geokhyRbHZW5c8D/Gk2OcS8aSnXYUhGbqW4oqsrhoRooXWS
	 qAs9mwydTOLiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: ignore unknown endpoint flags
Date: Tue, 30 Dec 2025 08:48:42 -0500
Message-ID: <20251230134842.2212007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122923-underhand-chalice-083b@gregkh>
References: <2025122923-underhand-chalice-083b@gregkh>
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
index dacc7af2ea1e..dfb98963f761 100644
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
index 146d290322a2..cc58536bbf26 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1424,7 +1424,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	}
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+			       MPTCP_PM_ADDR_FLAGS_MASK;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
-- 
2.51.0


