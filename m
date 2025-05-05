Return-Path: <stable+bounces-140119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBECAAA54B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0721F1893B13
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AE230D797;
	Mon,  5 May 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFaUOsuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2A30D78E;
	Mon,  5 May 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484144; cv=none; b=j6ODY/i8akEWvXzR9Ob4qZZ2Jlt6WjOrrtFqyMEN9qeEjD2BwRhmJMm1Pcq32P54HcBrRHD9isB9LahgjbUHHRgicfpvtOaplv+8CSXJbdUhXxCBKvQnaWZ4NSoJLxJqrrWsUegNtvCv4oLgYvKfcyqIEELRbywD7D37EusU7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484144; c=relaxed/simple;
	bh=SL4q6ZmGWXG1kWzRO0ojp/SQ74mz3CEbXOhcDOCDYEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+hRL6s32hki19/zv6cjImbilAl9FjcnUeQdq0qGcjg51BhULHxlJC33xPWRQ5dU1yABvPc0hXCJmT1J3aqC5YDBwFPmDkOq3IladbKfscdZN2dxEbYf6goQfDf5bBFC1kwofC8Fh2Tz6xBiJIS/Ism+7yPJEBVvcSr3+Uza9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFaUOsuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CA0C4CEE4;
	Mon,  5 May 2025 22:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484144;
	bh=SL4q6ZmGWXG1kWzRO0ojp/SQ74mz3CEbXOhcDOCDYEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFaUOsuFZE2+nMMEqCwl5Z9gcPGHU76OVsDVcSYJHZWgtTr5tYZfNWVEC4hv9eegq
	 +kc+hG1hNjFzpy4II+0/Zbh52eZ2cT06M3Cq5m8tqLaGE3SfhzyiXCpbUpMRruopWT
	 BVWutWd5CZnsakgWjMcxPnRshnA/HY6XfkMQzDHxz8F9o/evRsXC5mvm/BJHa1nnRo
	 3RUG5HcDBSF/Pdb4s2GuB8YFTLvOlu6aqQ9bVJ/qn803YN4jp12S1y/pEzlvx63Avv
	 eRLK32pxtlqPh4Z7ZgaTipaetrs+TWIQ1Bb2b5r6siHVhVqwo+5GGni2vTmGfj3dVS
	 DyszhWCsmOIKw==
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
Subject: [PATCH AUTOSEL 6.14 372/642] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  5 May 2025 18:09:48 -0400
Message-Id: <20250505221419.2672473-372-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 6ea34c95179f4..d3a76e81dd886 100644
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


