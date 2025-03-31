Return-Path: <stable+bounces-127111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE9A76893
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5EF1890137
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035BC215F49;
	Mon, 31 Mar 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFhRV77U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359321516E;
	Mon, 31 Mar 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431788; cv=none; b=R1TZ3JsIPtlNz3mr0V5SjnYwkxHp4uJOl3+dNxE1OyqhEL24NM63qN+tweJxQVhjVhf/mlVNycPgJWDvr5Cw8QGsapvJsd5iV6U5q3ixy4IXEYZQDoJKgiHOG60+tv0jbvck4fnpu3ywsELAPMeOKnDQ5vR6WFBD89D+BHpQ6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431788; c=relaxed/simple;
	bh=xaEMZxbQp1Qr9ivAjB59KF4a/0OwWMSbOUS1BmmeD7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3TcBxRZEs1RPKq7EGuhg/Daz693xCsV5wheutXMhZW2g5RS5rG+GdK57VmTN8nkYkSW6st3hhxV326VCkbCqRWLx4zUByK813V4qwD+2Uururp9YeWK5OU+Mp7DGxeSdXtfyD0K/MbxYFV42JINa58Yty2ur3R/dXWCkEMA5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFhRV77U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EE5C4CEE3;
	Mon, 31 Mar 2025 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431788;
	bh=xaEMZxbQp1Qr9ivAjB59KF4a/0OwWMSbOUS1BmmeD7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFhRV77Umy3pgwfcAW9V7LTG+S7DKCUZpg7OcKaiiGUIDAmh0wzX9H8a5NQkGMXK8
	 UWUfPZQTFbf7kRZmGLP5I3W8X/GIbvm58kn97zERqqUqkPf4GABG3WzditNoociYt7
	 lHAv1MElEMVaFSE5J3jbPrro+xG3QNNJyE+/i8fbo/WTS62/61HUvzohd5t8kLCOcM
	 Cc8CqAhQf6TQMEZC1yZTHKCy99qX/EjU2ecnWmxodPS5GwE4QtG1a49G4ANtP0S3gA
	 pxbWiCA8uK6jii93LJcNp1JUFMIotQyZVSGDjMPnbwUKzXld0cnBMoi/ooUwFOyNJG
	 Sg8SvNg1xPhGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 7/9] xen/mcelog: Add __nonstring annotations for unterminated strings
Date: Mon, 31 Mar 2025 10:36:00 -0400
Message-Id: <20250331143605.1686243-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143605.1686243-1-sashal@kernel.org>
References: <20250331143605.1686243-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 464aa6b3a5f92..1c9afbe8cc260 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -372,7 +372,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
-- 
2.39.5


