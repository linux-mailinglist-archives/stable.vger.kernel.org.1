Return-Path: <stable+bounces-127134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFFDA768AA
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258837A2187
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2621C192;
	Mon, 31 Mar 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDY6Hbny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7821C18C;
	Mon, 31 Mar 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431860; cv=none; b=miyZ1tK3WodvmLwgPtfMw6Tppz61tPIX4fF7t07h4y8wMIcwFCNMMuvqlyQ8W3lxqp+9MxRObEBP1G10SaVgqfB/yeIfLTAiq230ZiROHVZHoaKv5ris8HJkIZpftczPEsc/gBIuckAKkDRqzga1Gqsn8ljbKnczf0cinBNnnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431860; c=relaxed/simple;
	bh=EBUZ7/lyZdvglHul0hI2jt6KLmQWNLkkH/t966Me0jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdbW4t787WGMwxq5zf92Mj1pgtt37d8PLXL4T0D5LubXqQLhbU9XRjxXVDiJ71PqqRCti4fztd0cYrwkBeNaEmOAFdPI1DIODT7yMNsvFBQxlwA0GcN/HjnZgX24rr5JK8n7ivFZKeDNLTckj0C09AyUUd8Z3Jzv83bv7tyhfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDY6Hbny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737FDC4CEE9;
	Mon, 31 Mar 2025 14:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431859;
	bh=EBUZ7/lyZdvglHul0hI2jt6KLmQWNLkkH/t966Me0jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDY6HbnyXjQoLmyZkPm2+mfwJkco58naAILC2MDsbzt8IB2BnM4aEJpsbbW2pduBX
	 21ZMwTJ8AfcHxqWxb4J7ZATNPL9Ss8xlSIT6z8KTcIqhBGaXRwXFQ0WzhJooNcl7YR
	 qGTkMfmkHWaKjJZWOOnytMB9nEJJQidfqAiQnOvIdAOBU2pmxXrQijAP2h3RlKjWc5
	 buNtXfsalOzE9fNZ8KnBaBnHY2Y4qZuWHlPgDjjlHc4euscoADPu8ZEzY6Wv6h1B37
	 fX/r6H2BUykYWFiXVOKYgFCpCLlrH3VLQkFPZQwSamjuQE5hV+VNpo6+FOHS7r3zRu
	 TBRL+UCzQyprg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 4/5] xen/mcelog: Add __nonstring annotations for unterminated strings
Date: Mon, 31 Mar 2025 10:37:25 -0400
Message-Id: <20250331143728.1686696-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143728.1686696-1-sashal@kernel.org>
References: <20250331143728.1686696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 1c3dfc7c6b0f551fdca3f7c1f1e4c73be8adb17d ]

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Kees Cook <kees@kernel.org>
Acked-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250310222234.work.473-kees@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/xen/interface/xen-mca.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 73a4ea714d937..5db6116cd042c 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -365,7 +365,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
-- 
2.39.5


