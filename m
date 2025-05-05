Return-Path: <stable+bounces-140857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A345AAAF69
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B7D18804F3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8282FA81B;
	Mon,  5 May 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHk553EC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8D381DFF;
	Mon,  5 May 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486573; cv=none; b=OJvs3n5ECR49ahWxSDyvYWG/9TBw9CzVfGgYPfqw3GlmfrxrjUXYtqKfuFlF4EjC128KKfpmdomqnQPOaCjbivO7ulmlMD7PTxhBfe5j78zGIllIVIZMyMUwPyCNIOvZXVBO6a2VVKDzHnZiGxIfTFVIKw5Z7hZHB2Hru2ih3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486573; c=relaxed/simple;
	bh=9Ao0lyszCTdu7CtDdxkS94uR+f7ANY5Q+ewj5xaNuHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mb1FeNyhLP3lcaUt2JZha/uWbz0IgMgWdZ7kVQgOCRpz09Q0wzU5QHttE/bI+FdheC0DFiw+ZTrAMSY0JtgyR4jNVA6jr8UlRX7YqAYPAWawqCHPePf1F2PyGV0np4etvKrqdXkV9rfEqBvR1Uk+aHoBBsRjK+5QxpP5sWNYQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHk553EC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5DBC4CEED;
	Mon,  5 May 2025 23:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486571;
	bh=9Ao0lyszCTdu7CtDdxkS94uR+f7ANY5Q+ewj5xaNuHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHk553ECoVeKviXU2jZn8KGdeaffTCJtmcD/lYQxAokMqhxCZO8k23yy+Vnrm/h1F
	 j29eufcGZQ0527oNloPXPb3m++MmQU4+UnFJfmLigQijoI1eiTDWP+oOSIfKCC1FYU
	 Qko/R8zod1tOqelO8Plg8lvulaupGb/IQP3Wo3hH9+XJsnPMadc5Sgohtv8tmNo5oc
	 cE4lo822wvQE27SreZLwoBoyntX7EtjxLfUCqFBlsZVvYZvmLEiqvRzIUW7W7fY6Ic
	 15ZuA1Efy46d03qOWVrSBgH0sTjD7Y+8iRcuHnrNh4AwDDISKLtzqSsILZ38eKkzra
	 AUuFbLZXovfzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 096/212] net: pktgen: fix mpls maximum labels list parsing
Date: Mon,  5 May 2025 19:04:28 -0400
Message-Id: <20250505230624.2692522-96-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 2b15a0693f70d1e8119743ee89edbfb1271b3ea8 ]

Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS entries (instead
of up to MAX_MPLS_LABELS - 1).

Addresses the following:

	$ echo "mpls 00000f00,00000f01,00000f02,00000f03,00000f04,00000f05,00000f06,00000f07,00000f08,00000f09,00000f0a,00000f0b,00000f0c,00000f0d,00000f0e,00000f0f" > /proc/net/pktgen/lo\@0
	-bash: echo: write error: Argument list too long

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index a2fb951996b85..5917820f92c3d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -897,6 +897,10 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 	pkt_dev->nr_labels = 0;
 	do {
 		__u32 tmp;
+
+		if (n >= MAX_MPLS_LABELS)
+			return -E2BIG;
+
 		len = hex32_arg(&buffer[i], 8, &tmp);
 		if (len <= 0)
 			return len;
@@ -908,8 +912,6 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 			return -EFAULT;
 		i++;
 		n++;
-		if (n >= MAX_MPLS_LABELS)
-			return -E2BIG;
 	} while (c == ',');
 
 	pkt_dev->nr_labels = n;
-- 
2.39.5


