Return-Path: <stable+bounces-112457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE8A28CC7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FB63A38AB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB05149C7B;
	Wed,  5 Feb 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2BmY7EZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06677FC0B;
	Wed,  5 Feb 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763633; cv=none; b=c85q/j1kQZQcKcjPnUFpP/sfpC2Zh+jI47XM4IhnK3u70A+mQF81YeZ5BG4uSGUN1YNJPyHpNea6T3PCY8Q6iBmzmRbRvXkjbitRISgV1fyI3do5eGuVrO2Rl3HbuROB5uuJDDKjktPfqyWll0aa9gLMvsIzLG7lWp5ni+qrZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763633; c=relaxed/simple;
	bh=cgLfk44nvmtOPfIPka9OLBHvt8e4eeAn1ROCT+L3RpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVYU1yPkyUWWK74xcd/R46Mh4fyBTJz7rBAreP8biIUZQJekgbdA20JmHE590NPWMDO6vDyVz3clrC90UElKgDKMRdt6Le0lw1FHuaMs8B1HdBV0NIRGFrApbb1rAM3X/anpY4Kv4raoEllJNH2kOQc5Rdlad9VpNk3PePHQcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2BmY7EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66939C4CED1;
	Wed,  5 Feb 2025 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763632;
	bh=cgLfk44nvmtOPfIPka9OLBHvt8e4eeAn1ROCT+L3RpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2BmY7EZ4iUR2cxWacmFYYMBvvi69EZ8UOrb7+4ehKEPB0a+CRA+mYBxB1W+QpbzJ
	 5K7o61tUrlUPI6YbpHzuV+aGvSne+y6Cc58tjMDaKzBeaOF6lM9T5aDZnweqB7hBbj
	 ZBXou/wrj6cKIGPJGR0OyroPnjo6O6FdnufFME9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 004/623] dlm: fix srcu_read_lock() return type to int
Date: Wed,  5 Feb 2025 14:35:46 +0100
Message-ID: <20250205134456.398206794@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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
index df40c3fd10702..d28141829c051 100644
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




