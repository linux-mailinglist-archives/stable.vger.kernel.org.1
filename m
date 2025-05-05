Return-Path: <stable+bounces-140714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B6AAAAFF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E2C3BB519
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F93E2EE4A8;
	Mon,  5 May 2025 23:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvvwB5tv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD343867C5;
	Mon,  5 May 2025 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486041; cv=none; b=pSS1n0UcQUZ0ajOkTO4oOmTfKoj8rjP3VPv7++7p44STWItfviPgiunTWR4UQva03xCF5JHaCmdCkfxpAa+9W6Elfk2mjaCWljHPYEljha0ZRhCeM6oHgM2qZqw/hV7+fsEhxCzDm+zy2ARjI59occCuz5JJDD+f9gfMDxTq144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486041; c=relaxed/simple;
	bh=WcgOYCt13//Gm6w2smiHXIK2M2CVcg9ou1RV1ABdh/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p97pH4DhAm2jOz4a7uyLMdOAJX/5cZggya8eYNX0+xF0hLHIaFSIR1xa9/kqCUa3+j/vq2kmaaTjZjc4FTMjj9Akhkef7AS9QbCcqXwByuRYUxOZpMxhthK2ZWZQyHpAKVerI0HtkjrDusEy9wzyRPSZo5PvNqXFElw0sN4vZ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvvwB5tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DA6C4CEED;
	Mon,  5 May 2025 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486041;
	bh=WcgOYCt13//Gm6w2smiHXIK2M2CVcg9ou1RV1ABdh/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvvwB5tveUgcUu6S+zNYAVlXtlK3WHbK2uqYpmDvEwICEnkU0Ihz7Qg3tl1+SaHoh
	 9cCj8u1LvF7SM5yuVmNQOZZrI+s8s1uJQVHHmJ9CZSJBFYgOLGRIlsngqmjOkQvSf5
	 cB72M28SF2EXOgA1/+NXknEZ4MJ3tBSFnZtoq2ZIVB/PLq7nVc5iyCuz5bqQ2W4G+i
	 ikazhtro9wHaJ3yJYLtr5etCQZN3vx+32Bmvi4sJC2UQq8iHeuj7WF/qFFmqOzCXUA
	 Old525+mJZT+2JSVALO4EYvzfaJ7rWtVV9EDUqooEt9AYIwBoAIQKW4VUhGxG0rT5Y
	 rRnJBvIVwcmyA==
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
Subject: [PATCH AUTOSEL 6.6 123/294] net: pktgen: fix mpls maximum labels list parsing
Date: Mon,  5 May 2025 18:53:43 -0400
Message-Id: <20250505225634.2688578-123-sashal@kernel.org>
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
index 359e24c3f22ca..1decd6300f34c 100644
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


