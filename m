Return-Path: <stable+bounces-31559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199AF889785
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5081F3855A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9E36ACC2;
	Mon, 25 Mar 2024 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMu/h/Wo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1991448FA;
	Sun, 24 Mar 2024 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321964; cv=none; b=BBYWt+a6blGqBal7fko0iRoJfXFRO91idw5WiUuKxWEPwCC2VKuC52JY7B0dKct6x3C40+g9LIabI9dtKZrRuziZ6ZxUH+OsuBPNV1d+0TRJNSPZjvrRsrw3nXssEP7LoxpHxe/hTuuDYyvkt4i9YCWPq6vVEZ3sOFEM+XfHXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321964; c=relaxed/simple;
	bh=PbeCPPqUTj8zu2JIOMJODjSU9380VXX4VQ800iYqnmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNq1U3WmKRtK+fpZbsURKV9tf66xr1maAk1kIyAvofkBC4JcLoHx1q/DdvoUMa77Vqrmyy3XU1NPCQ8zVFAWzcdoOa9BoCrUNrD5XPuoIBsROc0vBovos+9ZOLNmqEO8batfLu1CW6p2CmVOyR3cQR9YOOpsXYppXWi6eXPqT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMu/h/Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9280C433C7;
	Sun, 24 Mar 2024 23:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321964;
	bh=PbeCPPqUTj8zu2JIOMJODjSU9380VXX4VQ800iYqnmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMu/h/WoJKZ5p58uWczYckBJUFI/NdcmiOwTl4tMNBzNTi14I5zHEMCs6ydKYCgNE
	 inj0I7GtNdwzSXnE2FvKFqYem5seTE8wb2ulWuQC8OyJIWkGZEDECCFxXJAprr8vpC
	 OxWhPMkKe1CB4L4Vk4NDF/jRaJ65oRH8odFM1iV87EWRQoIBguKCkZ4SwO3vA/o+de
	 sHbX/iQKxogoDqt5MdXBmpQmsrwW27yGrdOg39GU3SHIYHIQcwdacxfwPXzzIItJZ0
	 BeZjbH1NcxDMHkR4aBzwibM+88Ugw8m3E6TcTGBiz8UQ6O1QuwikcY8QB2gf8t3Vq7
	 VxBIpMEVfmrDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 036/451] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Sun, 24 Mar 2024 19:05:12 -0400
Message-ID: <20240324231207.1351418-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 250f5402e636a5cec9e0e95df252c3d54307210f ]

Fixes a bug revealed by -Wmissing-prototypes when
CONFIG_FUNCTION_GRAPH_TRACER is enabled but not CONFIG_DYNAMIC_FTRACE:

 arch/parisc/kernel/ftrace.c:82:5: error: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Werror=missing-prototypes]
    82 | int ftrace_enable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/parisc/kernel/ftrace.c:88:5: error: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Werror=missing-prototypes]
    88 | int ftrace_disable_ftrace_graph_caller(void)
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 4d392e4ed3584..ac7253891d5ed 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -78,7 +78,7 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	static_key_enable(&ftrace_graph_enable.key);
-- 
2.43.0


