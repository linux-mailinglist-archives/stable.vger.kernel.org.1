Return-Path: <stable+bounces-141704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD23AAB5D9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC9A3B2E5F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40B4A7401;
	Tue,  6 May 2025 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvgdihHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B12F8BAC;
	Mon,  5 May 2025 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487242; cv=none; b=q7luJt73eu7uGNhkt2Ju8ESxdnm0syIJjGmwtklF0tk+i7gfBxlhdoffYuW+cMMrJaJ1dOjTQ2iKzo9ZlhCuh5HDxnrqAozVC/2b9424ZAAhxLtlblVdMxvC2EilqsXe+xof7AvZEdWQ2w9IybMvuVZeEfjEoF6XwtN5RUI+5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487242; c=relaxed/simple;
	bh=YL/1WgjLI1B6LoS2/NIYGlwG7WEGAG37g1mVj7vL2kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=To/CMR6zK0SDNS5wCb3w2hAi+RzzPu9H/ElSh82KR4FVQjs0CPKstmYNlj2kdanaUxlAyYwrYic10zjBqGCf6VflGG7t5I40OO8l0rNBvC7ytPskAdmk4D2boyQG2HNlEWHXAHKtGWPq7FFRsX1yGFPg3hbc29BwnQ/4JMGllWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvgdihHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75121C4CEED;
	Mon,  5 May 2025 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487241;
	bh=YL/1WgjLI1B6LoS2/NIYGlwG7WEGAG37g1mVj7vL2kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvgdihHfuI5qUA0ZhbfyiWXXrwcFtQVcgn14rckyWU4wOFEq3zBo7+lWSABK90924
	 jedGM19JkGl09MewPEE0JMn2a9ziT6f1MiuNI9+hbGkoD/VwSWF183I2q7I0KK2+fj
	 ZR1vKGJJwsDtvP25JJt9vt8mfIo08X8oP1BxZluHulIZ6mrprSdr6tbqwBvmQKxmrc
	 5bjNbG1bwIJbRztdLmDPW499SyLEJPQfJV9V+x01xDGoWfvtXBraIcXAmrZVLvBlja
	 17DJ3wjFNtSXp0EIokoVXwMO4x1zC5BcyZvvEK2hcYQ8QzKvvDRFBRgr9awXeAraM8
	 KsqatmM4dD6xw==
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
Subject: [PATCH AUTOSEL 5.10 075/114] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  5 May 2025 19:17:38 -0400
Message-Id: <20250505231817.2697367-75-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index c2b3c454eddd9..57502e8628462 100644
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


