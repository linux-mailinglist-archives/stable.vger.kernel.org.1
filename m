Return-Path: <stable+bounces-112377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A72A28C66
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC9B168901
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F931459EA;
	Wed,  5 Feb 2025 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CIY50Kuw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E189139D1B;
	Wed,  5 Feb 2025 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763368; cv=none; b=mrDVNMXRLqdcGVOmVW4klyPHhnxGuKIdDpPhPPfTFEYKPnvXL+eHkyjloySXzE9jD5Fsv08hcWP/K3drktkul3yOWJn838SC4nuO0BOXFrZI371QPtwm28A7aeCP7rNM/P/FE5yUSTpMfaoDAmEAG9f2m8Iig1sD9Zs9l8NB7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763368; c=relaxed/simple;
	bh=DnX5RO9OwZ20Gr10pSKcO9oO4gvEmbF3vMO9AHKt20g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVv2ckLQtnzNBk/ClaD7Y/zFTknYvAJypek4vCi5H0mJDFQoIAE7X2+tj35ID+SywmvWjuus0hq6uTzDQggwYBCi2sFxb31tR+HIkjCX5MCYWnFuYOqiRyzwAnUmUL788LSbN2JivbtXj1gkID+kiE6dH8PTvm/P/XngOBjr9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIY50Kuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA876C4CED1;
	Wed,  5 Feb 2025 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763368;
	bh=DnX5RO9OwZ20Gr10pSKcO9oO4gvEmbF3vMO9AHKt20g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIY50KuwdKVlKkGBLC4ZU+RuV7QzrIQkn2MyOx/k6HRRZvtdYyFa9W7iLfk+pGELW
	 y3S3lOU991y6B8fGpNoDtAqUyEiugpK96VMj7wo1GP3qiB0dHi98uyskP8n78g9OGI
	 q1tnJ4ckQLgcAuqL0e7AKjTOhELkJfRTNlogPKHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 004/590] dlm: fix srcu_read_lock() return type to int
Date: Wed,  5 Feb 2025 14:35:59 +0100
Message-ID: <20250205134455.398648812@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 57cdd1a1cf1464199678f9338049b63fb5d5b41c ]

The return type of srcu_read_lock() is int and not bool. Whereas we
using the ret variable only to evaluate a bool type of
dlm_lowcomms_con_has_addr() to check if an address is already being set.

Fixes: 6f0b0b5d7ae7 ("fs: dlm: remove dlm_node_addrs lookup list")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lowcomms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index cb3a10b041c27..f2d88a3581695 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -462,7 +462,8 @@ static bool dlm_lowcomms_con_has_addr(const struct connection *con,
 int dlm_lowcomms_addr(int nodeid, struct sockaddr_storage *addr)
 {
 	struct connection *con;
-	bool ret, idx;
+	bool ret;
+	int idx;
 
 	idx = srcu_read_lock(&connections_srcu);
 	con = nodeid2con(nodeid, GFP_NOFS);
-- 
2.39.5




