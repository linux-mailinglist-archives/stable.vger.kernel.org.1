Return-Path: <stable+bounces-141069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF3AAB071
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEBCC7A78D4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B53BCB41;
	Mon,  5 May 2025 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y++DsvZX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDF3BC8EB;
	Mon,  5 May 2025 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487374; cv=none; b=DBFa2NafcTZg7tfftiX0I++qMkUixIO8xcF10CqHzYYEJHPN2hDJ8olbj+SUK+vTtBfSdVcp29jx+vDmYfcaar1N09YxHmIR6qhbEEqCSsNsYKjzAo+TRIA7YqagBcmpjieOVCnR77SUpl0BCvOZv4v5hk9IrBQN1sUevRDUPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487374; c=relaxed/simple;
	bh=nkV0XuP2UmH+YAEtwRszRvh/4U5zUqzdGszDws1FZOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dloRZpk/FwufoAU5+9Ty1Bq/X6NVvpBhxmcqehJ16O4coyxzQCr2IA8P1ZU2VTlSUZJn3bIO5w/e86pSu90P6K9ngyfKjh9Z/3k87IAznjehSUuk1kaW8Zxj3cWThxR+n36l29ugqRuYvcjJ7yUMokIoSb2OrCbsPU89mO4sCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y++DsvZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F36C4CEEE;
	Mon,  5 May 2025 23:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487374;
	bh=nkV0XuP2UmH+YAEtwRszRvh/4U5zUqzdGszDws1FZOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y++DsvZXaeISGXG1UN6E1F1iVGSvt378Vx26a9QR3mBQQkXyv0fg3sVSlWHcQsemS
	 xtahFJrjB6WFq75x2aPhLwqWz68DXbGBhu+guvg9k/FljYpgwfkU6jRRL2PZfiyJti
	 ExWLelTEsNXmmU0ETVcY05RdyFXEBjaaCdgchdRT845DDapQuq8as6cRKdjU+bnrvA
	 cOf6SWa86EzXkPet+eAWT/vGdYWpacmzmKHx6gtjRIOMoQk4Zof8TgxjLoH1AG9UJP
	 ZxVG1uyEjwCA7lzbd98vdRN3KCE8PJGgYQtImDDt7Gh4NKXjpSqd38V9uu/0oxdqjw
	 TZu1X0Tt2TnZg==
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
Subject: [PATCH AUTOSEL 5.4 36/79] net: pktgen: fix mpls maximum labels list parsing
Date: Mon,  5 May 2025 19:21:08 -0400
Message-Id: <20250505232151.2698893-36-sashal@kernel.org>
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
index 5e9bd9d80b393..e7cde4f097908 100644
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


