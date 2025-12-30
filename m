Return-Path: <stable+bounces-204205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B8CE9C49
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD8A30115DE
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F238E204583;
	Tue, 30 Dec 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8jV/50j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253B1EEA5F
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767100874; cv=none; b=GuYj/Alb6HsuO7eW+XRMclnxTxEtRyTN702XxTgx1AREHbuRyzn9a0CKvyim9u3wGku3/WlPpiBiYlOJ9QNKPsPj6JF7Jbn3Sv2oze0NG0+oBmwXoQ/ZhALhR2fgG8M/nVtG6cd7/uvFKwJv2VHv+qxxDHyRCzDjFsYquytLkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767100874; c=relaxed/simple;
	bh=zTlD67a2zRRvZej4XaDiVkkCr6Vjmnx5MzZD0QnpXEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue/LLgONCLll8YibqDe5Fl/2KAK6dkCPnI90VwK4CIwL6uohmGldC03YG7zunV2/ORDnrN8kIc2xyR//72xOCSSy7fm8JRDJnWVQx4wX/W3opx1C6mb+1izgrpUWRsIdHY2+LUzteDb8k0aDy/w/JIvVSV/AffhSPeHukFYdALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8jV/50j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD47C4CEFB;
	Tue, 30 Dec 2025 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767100873;
	bh=zTlD67a2zRRvZej4XaDiVkkCr6Vjmnx5MzZD0QnpXEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8jV/50jmcRxIm1JPSKookdBNsBV+QuucMzEz+oALSrps2AYVpDCwtdbWcU7M5H2C
	 iw7gE4tyTJSGzx0D6VxSAYaou6mz5Mbopo8p9lVrbzytPX2ilbJQJsdoJcAvTWIpfh
	 F84G0P8+Vl7OV36U+GJqkzexy7jbg/Kn3YGvQ3IGb+xwjK44A7t5cjfZ9/JFGdWsOk
	 ZRpfviWsp9EwCQxjGwmAtjq9jyL3uxNJvClXZu+3Jlx/iWk81cRkCyzLqlzhuhXVVz
	 cI95uFB9sSRv94r3mewa8VUeEG3LREmi4LnZJPgA8ELI30hPTRpMW9n3edqFOYtDhy
	 BABkmFeYJil7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: ignore unknown endpoint flags
Date: Tue, 30 Dec 2025 08:21:11 -0500
Message-ID: <20251230132111.2180152-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122921-regress-overhand-2900@gregkh>
References: <2025122921-regress-overhand-2900@gregkh>
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
index 5fd5b4cf75ca..e0fe5160d8bf 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -38,6 +38,7 @@
 #define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT                    (1 << 4)
+#define MPTCP_PM_ADDR_FLAGS_MASK		GENMASK(4, 0)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 42329ae21c46..0b4ab3c816da 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1409,7 +1409,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	}
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+			       MPTCP_PM_ADDR_FLAGS_MASK;
 
 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
-- 
2.51.0


