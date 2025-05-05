Return-Path: <stable+bounces-140015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE2AAA3D8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE013AA671
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADA2F8192;
	Mon,  5 May 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSM43E5F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5172F8185;
	Mon,  5 May 2025 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483917; cv=none; b=QuAEwln9mfuscv8FRDsOT1TL3dZ+UhMpIQRbA2UZvYA5R15LmmOrFHv/LlFdLn+SW9BONCCeVMu/HVAy30gnFShVA5U/s7dKLe1d5KIl5RLhm9kzB50YmeMznFDenEhTDR9oKKjKWk9covlPGH9oY0bJgLiZmnhrWsk57eK3piU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483917; c=relaxed/simple;
	bh=poFPbZc3H47uDT6PzqoNz3D2Aw3I/1vHo1mIjYsQPlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utvu8s2gr6BYpnte6ESjhUAI8I7vUYH6W5PimocymRD78vT1g+1FV1BqrQG+z6LWu/J7eyBMbEoC1EbVOBFwV+k+s87NB16hEOMeDkRUwZoK3TC3SI4jr9WnoA3O2FscEppeuf+FDaNTeMjqSntA2T/sT63aUaaGBLt+5UGq2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSM43E5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF65C4CEE4;
	Mon,  5 May 2025 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483917;
	bh=poFPbZc3H47uDT6PzqoNz3D2Aw3I/1vHo1mIjYsQPlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSM43E5F4XxC/ZBb/uQ09b5ITsjjeIQCMCUGFdDCoglK3uYDmDnu5xt1TlnWeb8Iw
	 uZyc/+sBssJWAPRgCXK3n3RSrvx+/pqUzyjMImvMxioq4dEywPjYwTiSHnPHLdEvKA
	 e7uGOk/GygvJxQdENbG+BVdbw/m91ztoeouOErSYBJDKL7h0a1AoqiFI56OPgsGE3t
	 IohqEb1kLRQ+2cs8nX0Xe+jbDji3I4zPEDgHPCg9Agdeycidjo4mAbthj4F9DxyDes
	 0HjMo5ccZs2i03EPxFjMPhJaib2KSEkFwdEUT3u2DPZ9Qqq+jiiS/mnKRZvzFS8T31
	 fELoxUo35LNrg==
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
Subject: [PATCH AUTOSEL 6.14 268/642] net: pktgen: fix mpls maximum labels list parsing
Date: Mon,  5 May 2025 18:08:04 -0400
Message-Id: <20250505221419.2672473-268-sashal@kernel.org>
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
index 82b6a2c3c141f..6ea34c95179f4 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -898,6 +898,10 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
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
@@ -909,8 +913,6 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 			return -EFAULT;
 		i++;
 		n++;
-		if (n >= MAX_MPLS_LABELS)
-			return -E2BIG;
 	} while (c == ',');
 
 	pkt_dev->nr_labels = n;
-- 
2.39.5


