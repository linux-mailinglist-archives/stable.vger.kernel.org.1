Return-Path: <stable+bounces-204225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B65CE9F29
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BECD3303805F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A7274B23;
	Tue, 30 Dec 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtbDUg+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EDD13B584
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105277; cv=none; b=fh3Hr2DSI+5SrBv7XdhAaCXUTFb1L0MRBGEBi7UuRwTueZ4q8NKHYy1p6NcjXhBGCoiWOviuvhQb2e2Br7Pezf0Hm7TqmFIL+5WT5kAXckDUwu2ECLrQp4o5tJyA/JKmgaNQSIyrqLu2aDUGn2EsYi8bH18EFVacBYc5GD7EyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105277; c=relaxed/simple;
	bh=dxFMaVUwBW044xixPye9W0MMjcYcCqZGVHpX+TUKuJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiuCurg8XSzRMrxllySnkjW/xvQ5ZADqKDpRwAmwZM9lOJTyEQ/ewpSFLhl8xWnUAVYoAtEBhadf5+/fNFQchk39Py7Ju4Jr9y5SbLtaBnxg4/RQ4R5NJj25x801D97M/QqtYY+uuLx41IsZ1ZpXccV6lAm03KbA6f9d8AFkQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtbDUg+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF6CC4CEFB;
	Tue, 30 Dec 2025 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767105277;
	bh=dxFMaVUwBW044xixPye9W0MMjcYcCqZGVHpX+TUKuJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtbDUg+SUSHdFj4ItN97+BFkNUWuv+lYpCk1XsW894k0EOO9ueJtCFXGvwOKBcYXl
	 PEcPDuRcoOiFTXN0+QCv8bztuCgv1MUEkX8bCMlAgY0aKXS+74KmA132prKuuWGI9n
	 RilnZ6nhsKGeVZvU9MGpvf7Fd7KIWHEyIAzwxOVW+yZnUjlO1WqmPXxGZX8GkyVpHS
	 Q1OHG+reg0zOViSey0psOuxlxvHnxUXcOI1EIJOH6W5MWNaiNUtvwf01HuskZxGdWl
	 jDGrzL6JkaUtcji/WWNY/C8AzziQu6evUktB96IIGRAy9hpjJh+IGkvHAdDswZYo8V
	 CUH4kigjdoyBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: pm: ignore unknown endpoint flags
Date: Tue, 30 Dec 2025 09:34:34 -0500
Message-ID: <20251230143434.2246658-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122924-retold-train-22bc@gregkh>
References: <2025122924-retold-train-22bc@gregkh>
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
[ GENMASK(5, 0) => GENMASK(2, 0) and applied fix to mptcp_pm_parse_addr() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 9762660df741..88877f63e12c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -72,6 +72,7 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
+#define MPTCP_PM_ADDR_FLAGS_MASK			GENMASK(2, 0)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 103074e39da6..b88246b8f21c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -721,7 +721,8 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 		entry->addr.id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
 
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->addr.flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->addr.flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]) &
+				    MPTCP_PM_ADDR_FLAGS_MASK;
 
 	return 0;
 }
-- 
2.51.0


