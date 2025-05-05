Return-Path: <stable+bounces-141406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1CAAB32F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E574C529E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D622333B;
	Tue,  6 May 2025 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nszatcDa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB42DFA24;
	Mon,  5 May 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486154; cv=none; b=JcSi+bXdt5cceRP02tNCd0Q9eSQ2kB1Xuo2Vc+vZZA4fKB07sPl15QCk5Q5z2LIO1vZzaFdTJnS0JRzyUjo3pLaEJhlt3YAc7R9GIk6kHkkoW6fvP7annShyGPojw5IBW61mjjoPW7q707GkcJJ2kyvis8WSjrr/0G38UkN416s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486154; c=relaxed/simple;
	bh=qjdLTpcbFKkuUc5WkDMurq0KdS+pBLkDJFtGtMp8IyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWbO8XwbOtRobNIHdWrutS+jw9MDYwSk6sJoudOUZ2Pj/iMP9Mzot/u30d7b0uCKN6ZqiU2oKZQIkjJr+WEJpp7KUlwY//Wspo50v6rAh1Rr4J0C0jKDtJnKasT5apPw4FvsYQwQqSVJAiAK+02/G1I00TLYdruxfeo96pN4DmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nszatcDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04942C4CEE4;
	Mon,  5 May 2025 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486154;
	bh=qjdLTpcbFKkuUc5WkDMurq0KdS+pBLkDJFtGtMp8IyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nszatcDayASR+Y73uLsP2XwOUCuVzR5jB8ccKqfJ6a5gQetDvSVM2TyJgfo6axnhG
	 KwlME7aH9XWxzDFIMphZzr36cGna/0ZndhgOc1lRnG4/YabjFSxKLxem9ZSjT2myc8
	 ZihIRm4n73QjSukE/9aKMoyyfFCIm/MJAlWs/Sus+9J4rJqrNea0lWbkcY1QJI4bnT
	 ffqkKUD6u+G4dV93vBndgZraataNpcM+HAr59S4kadoJK8/4kBqxddhXfI/3/+L9rG
	 bnw+qScVtdO9/CH2grasZsiBT8ff8QY4UZRSh8q+IaiWJlal8kUddcUWXJYYj5WcHz
	 GMeC99W/NMaWA==
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
Subject: [PATCH AUTOSEL 6.6 181/294] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  5 May 2025 18:54:41 -0400
Message-Id: <20250505225634.2688578-181-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 1decd6300f34c..6afea369ca213 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1877,8 +1877,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1908,7 +1908,8 @@ static ssize_t pktgen_thread_write(struct file *file,
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


