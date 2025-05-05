Return-Path: <stable+bounces-141640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C19AAB52B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C447A461471
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D53464B3;
	Tue,  6 May 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGVfpWvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275E390E3F;
	Mon,  5 May 2025 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487004; cv=none; b=cZd0GAA9H9l3jluPn0qQLPersxx2nfpdx2yvlvzDYsQuXrZ98msS3p0dghjEx0CVhnrVDrn9Z8rTM7PW1Xbu9hugA8AcMY2WVQhyUsKpFXW0p5c0l1ocvkgVjAP+H0RwA6l442h984STkQG2RkfrJ0rY77ySPERL5GTEWs1v6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487004; c=relaxed/simple;
	bh=Tw1OAR1vKnRom5Z/mLgyXztrEWHUgnnKnbtvpFmrB0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgmTCWJhLbbYfdFzZI8yZViTax18O+xl2qRChP+vqd7o6SZBTFOLzc82UmeKMOK8SogFC69P6u3sL3nof2LzRy9PzvKJywGbocSqRxR3OytNEY9IHkRlmmDq4bMfNCDFvzGyoyC/m/awaAn9YGzZauCloLHx5FrR3cDXzGaLUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGVfpWvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A59C4CEEE;
	Mon,  5 May 2025 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487002;
	bh=Tw1OAR1vKnRom5Z/mLgyXztrEWHUgnnKnbtvpFmrB0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGVfpWvywFBZvS89uKhKohHR3TfNM/W8TTD2WLAscnVXJNqLCVayMDBalDoaEd6r2
	 pxEWrLKVECfmwNOMhOYMgi4IqKXccl61uhN/eny5ooQBezZ7/OM19d0K3VTNgJeWOx
	 Htj+svcniotkRYTuou6ylXsCKdGhP7f4aTT4eXhrj7f+vnaKsFLkkdemp7lc0HH2ZQ
	 iyJUGlPyK7a4qg+/oueDB3PdHQm1afD6uCAo9xJIbaRxW8mvxrseboFmPrGmycWS8e
	 FgP/1UUvI7dLZh06g3Yl6X4lldylWc8u9/iT8GCoH7qC47KeCF9qkCOGwPRoY1rbPa
	 TK21bduEilQEw==
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
Subject: [PATCH AUTOSEL 5.15 102/153] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Mon,  5 May 2025 19:12:29 -0400
Message-Id: <20250505231320.2695319-102-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 28417fe2a7a2a..2b7b1de70cf47 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1876,8 +1876,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1907,7 +1907,8 @@ static ssize_t pktgen_thread_write(struct file *file,
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


