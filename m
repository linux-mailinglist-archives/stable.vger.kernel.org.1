Return-Path: <stable+bounces-141078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8288CAAB06C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70FA1BA0D2A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC630EA94;
	Mon,  5 May 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbOJ7T2x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DE2FB45C;
	Mon,  5 May 2025 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487405; cv=none; b=PXnG+v1E101gdqicBSbKqNMDVsrqBuU+Ienmw2G9TQ/KAUWPwRwRMIQ5ir5caEUP2bVpP8QlZtvN7nbh/8TTsQDaDlkD91t/3ljMxW6EpLDeg4iRmVagkRf2Ti6v/6IphXcKLhyKymmcuzjjujg5C/4kvlVFpmwAhGKetYfhejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487405; c=relaxed/simple;
	bh=TLK/nw2rcYQzO6iVjYaqZj4A8EqjcfM5zZQ6+AxLI/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opGaJ7c4dT1M0l9LduPh+c3UT2oQg0IfuLGg21HmXPBkfyBd62lArPuZkhKXkz8cb/QM4NRxswvggSnk81XtKVOzYQBi0to2FHHqiM9dk8f0I7i0d+WiscRgcFSu7drMsxRDL8PLNM+K3w82Py6Ojr5bBXqkPlkUfJkbpeT6PLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbOJ7T2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A27C4CEE4;
	Mon,  5 May 2025 23:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487404;
	bh=TLK/nw2rcYQzO6iVjYaqZj4A8EqjcfM5zZQ6+AxLI/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbOJ7T2x03FT5Yn1xinxvVrTkFAlzupqeocTWv8hYJwgREJ2V1zy0xe59acJtlD0H
	 y6yZwIj1/VAeFHr/u3cQCynnigdpU4kBLPyqDIFgbsuX01DPSiTG3WgYjfbQzkR3Z7
	 vU2PFLxG1cRdHMOpPw7psgE8tObkR6sTGluJzz8BBDJzKNOyQ5Q6kxMTTlLJp8AIjz
	 GZAjBkPgTDRopHNdv0tDvc1T+GXOVicXFpC/mJ2iLJo4CGWKfXk4SHYZyOx5X4m51m
	 jNfTK2iAmelqyOfwkd0RaGuHx1pZt+u2I/ISstjh3otdTM48U5T1ciulElu0Xz/oWL
	 iJGig+ORMJQzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 51/79] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  5 May 2025 19:21:23 -0400
Message-Id: <20250505232151.2698893-51-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 425e64440ad0a2f03bdaf04be0ae53dededbaa77 ]

Honour the user given buffer size for the strn_len() calls (otherwise
strn_len() will access memory outside of the user given buffer).

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250219084527.20488-8-ps.report@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index e7cde4f097908..4fd66e6466d29 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1770,8 +1770,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1801,7 +1801,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	if (!strcmp(name, "add_device")) {
 		char f[32];
 		memset(f, 0, 32);
-		len = strn_len(&user_buffer[i], sizeof(f) - 1);
+		max = min(sizeof(f) - 1, count - i);
+		len = strn_len(&user_buffer[i], max);
 		if (len < 0) {
 			ret = len;
 			goto out;
-- 
2.39.5


