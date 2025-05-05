Return-Path: <stable+bounces-140997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1466AAAFDC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828A64C36DF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67968302A68;
	Mon,  5 May 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCWr69KP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D07393E8D;
	Mon,  5 May 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487194; cv=none; b=WrIGO4l1SsnANQpu+qsc4E8UsJomt/dWPLErjGBeaHyPu12WX3/NInE+PVU0vuEbWFNYX/yzYpfewd2kTmKXad5qbw8arhyNOHNJFyaYQMaDeMsvjcRpf2BFGlnJiu2jY/dkZXpEwpvNAfSK+cxs+/gcEoH+bwrObNaYc5NuBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487194; c=relaxed/simple;
	bh=ndMWoE6q7fLIy7AS4H7lryARQIYRXZJWzFV6c0gNmC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KabhTJhjhl9iv6TcCAxnGHITOGmbnEZQRWIYqfnca001Ao9ER8Kbg34ORh8Z74SxX8V2rJNEjL2MSgjBUX/C7+3aFIMhpmNXix9+Bnjfbcuba9qOWmXgOcEvdXZhtzzBoukakChAN9TtlBW6Xz2wKsUl4rYdxylOdAOSQB765cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCWr69KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CECC4CEE4;
	Mon,  5 May 2025 23:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487193;
	bh=ndMWoE6q7fLIy7AS4H7lryARQIYRXZJWzFV6c0gNmC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCWr69KP+zanXGfXYIq4MyM6yWDVuDuhRu8gyMwN0Bh+HbdzL6rxmpuUMIyPao2L8
	 vADCfF31zzg7MkXdrgkX99d2xyLIU7M9P90qyAF9y0dPF8oihqDKPYCofnjZRxDYPD
	 Gbv5NET/Q3VksCwUMOvXNqR/ho+h/X3BgcihrwIcWalyggShALl3cMoFdWgmhWimq/
	 +5uGVPNfiG6hdi7KmSSYHaadWkqatfhHl1u/ir2gK2xTu6PoXDcJpT4kerTqyLlxiS
	 ArPMU/1VHCXxeopzgvqu6Pl4vGGf8NY60v3zC+oXJJ6pcD62vWRlVIAXgc9P1k2fHH
	 gnfE8nJ1o81PA==
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
Subject: [PATCH AUTOSEL 5.10 050/114] net: pktgen: fix mpls maximum labels list parsing
Date: Mon,  5 May 2025 19:17:13 -0400
Message-Id: <20250505231817.2697367-50-sashal@kernel.org>
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
index c1e3d3bea1286..c2b3c454eddd9 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -805,6 +805,10 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
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
@@ -816,8 +820,6 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 			return -EFAULT;
 		i++;
 		n++;
-		if (n >= MAX_MPLS_LABELS)
-			return -E2BIG;
 	} while (c == ',');
 
 	pkt_dev->nr_labels = n;
-- 
2.39.5


