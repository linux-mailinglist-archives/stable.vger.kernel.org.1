Return-Path: <stable+bounces-141171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39727AAB11E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F9F4E42C3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87DE2C086F;
	Tue,  6 May 2025 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH+Yy7EC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495782C0334;
	Mon,  5 May 2025 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485365; cv=none; b=Js0sOMCeQanYsNXcq2IAUH/tXNSP7jy0pTlCQXc24zppVawgEmy12MgK6I7tjz8AW8fnFHfDlZ+ddKv7lPpQ9/N9nPbTMrogH/X6Bnuk30HYG/wHzkNluzwsZfteK6coXermJ8MF/UY2Zmt6LSbqgOMb8QDeYmBmYM9dI6/aksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485365; c=relaxed/simple;
	bh=LJeuIAC8mQZ7hTP80xxR3vsciw8at9tec+ZC3y33u2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+gVHk2/4KDplNsT421Dlo89JZQoyrBFyWDbm8sFXCi5giDZ0MTIwS/hd96ynlhWSCZjlA8GBv6LMKG4+ORPVUKwYwQmsoPPHzgpqI3bGCewXUZCpuBjhZzGVujTpC63JJ5x2QZlZBD1oliL2/PFacd92AqS0+2haUrH+hSWDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH+Yy7EC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EE3C4CEE4;
	Mon,  5 May 2025 22:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485365;
	bh=LJeuIAC8mQZ7hTP80xxR3vsciw8at9tec+ZC3y33u2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TH+Yy7ECVaOiRxtCsq1/OwWOXLGtOCP/97u8FXsM7IJVRURXAOBAYfKrrgUA261qP
	 E9GVncEVXS7fe1ynIg/5/RPJ0DvdqpzPkC4XdEx3bzD7rs6QIaa3Ze/zhIfSKSo6SM
	 WxKxqTbG04qMeA0Km1ScvxcwnBJo4WzpQjf4/WtJgJ18mj0ygtiuJvVvZpEpjntCGY
	 Y7MJ2REXfYQYDxjCskuyHXjZ6PJ8dqD7kOZcgp66fWh1XDjLz/MWXb/n/j/dyj8Zif
	 3qaYPsMehxYa/dbISZaOhLPZCrhWveiKTB85K3JINMxZwWm6p6iFP+xjSLkhGSL57W
	 Jp1GKjFcUk1Rg==
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
Subject: [PATCH AUTOSEL 6.12 291/486] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  5 May 2025 18:36:07 -0400
Message-Id: <20250505223922.2682012-291-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 4d87da56c56a0..762ede0278990 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1898,8 +1898,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1929,7 +1929,8 @@ static ssize_t pktgen_thread_write(struct file *file,
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


