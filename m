Return-Path: <stable+bounces-133715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95292A92701
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B971906A26
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316A31DB148;
	Thu, 17 Apr 2025 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFOKJdfx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395D25525D;
	Thu, 17 Apr 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913923; cv=none; b=f8rDjeFz4BIavUaWSvOGbVnJaJDUsU431UC+f7LcLzM2vpJ4j19ObgDgXnCkGyfAqLMSCITa5E3BrJbCl4uYj0DzWuQOi0uIhDORgXTpnzao1mgKPHJZTWxN35n6ZK7d370lNcJQxEPSuctCmBOMq7itiEDmCJsaBxx5tUoCog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913923; c=relaxed/simple;
	bh=5OIxwAY3zOz5jK872fm2CJrRte698Nx7kXewpQZwmKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keKyRo/8VKg6RUnlBlSz2pSCmauAHXtR4tg/Kmx/QO6JyRnpLPGvCQs7va14hDnjCLmGVyooDtA8L9PoLZaFJ3bzK3ABKePufdskhyeHMfUvgOiOjl+owQmoaCpFz7WcTgtz6DxHAbn9AeeDe5jKrAf3dBZ3V5YMSGHIYxSvGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFOKJdfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACA6C4CEE7;
	Thu, 17 Apr 2025 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913922;
	bh=5OIxwAY3zOz5jK872fm2CJrRte698Nx7kXewpQZwmKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFOKJdfxamWob1GVWqThEqhLAljOMyah+/ewuA5GbAyakkE/meWSrvvomQSo6Pall
	 bRQdYMn+JKDwUHwR25obKfpP/vz/rG5DG503tOw0/plHERnH3B+7pGTu6fhSgCckBX
	 OvaTEvBsq1HN94EzObuJp9cWcK6ZyT/RniW4FaoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 045/414] pm: cpupower: bench: Prevent NULL dereference on malloc failure
Date: Thu, 17 Apr 2025 19:46:43 +0200
Message-ID: <20250417175113.227009551@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

[ Upstream commit 208baa3ec9043a664d9acfb8174b332e6b17fb69 ]

If malloc returns NULL due to low memory, 'config' pointer can be NULL.
Add a check to prevent NULL dereference.

Link: https://lore.kernel.org/r/20250219122715.3892223-1-quic_zhonhan@quicinc.com
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/bench/parse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 080678d9d74e2..bd67c758b33ac 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -121,6 +121,10 @@ FILE *prepare_output(const char *dirname)
 struct config *prepare_default_config()
 {
 	struct config *config = malloc(sizeof(struct config));
+	if (!config) {
+		perror("malloc");
+		return NULL;
+	}
 
 	dprintf("loading defaults\n");
 
-- 
2.39.5




