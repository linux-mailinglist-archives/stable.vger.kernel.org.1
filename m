Return-Path: <stable+bounces-25623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDE86D47C
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 21:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9062D2845A4
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754C1504E3;
	Thu, 29 Feb 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2FhXb62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E9144045;
	Thu, 29 Feb 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239072; cv=none; b=KoYZK2+0UWKBsjTVVUcZVbHmyb9RUyA+GyO2TJPkLhDuXDlMeIlBpzyu7r4ksfeqKtkT2f/axzonJhzK2EcI+0iaz/40PpHup8W33vZwlglQ9SHP3HdufN4G0tYvCd0/wdNC2Bd06f6qg6Eb0cRuv5jqpUrU4sDVdR22UjAfvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239072; c=relaxed/simple;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrWjw9FtSURAUkCPtoslD8ETIjEbjaKpGYSPpwaK3jHcpqIo4DM+sirZkZd1/MRo+k+r9rt7J7UCzjgAqxqbknmnV1Eq6oSSCoYhxHmoCX7JzJbvrQdOgxcM385pZr36VBm+9PmWBt5OnbvIZYCqCaBXild4aYStxKhxSaqjkc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2FhXb62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6713C433C7;
	Thu, 29 Feb 2024 20:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239072;
	bh=DM56fWUpnYs8NKGcPFxbzDsx0rC5E5rIw5nd28XokT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2FhXb62zAy6zwZw8AL3F7o4rkPHZlqnJ83Jlf9NGdIC0wb+DCOLQbAeyk14xa0iz
	 CRlIeDzJoR8oIr0da8dBGxYIC97PEFiMb8DJ76xvpvxIfc78tOzWZ3of85d6eOEUG8
	 5EIsbQlyNSFPJp/SdvjrWMtu68jr1ifHAITT+qmbyDmCvLTaHIY+VcPhlmN3vF7CxM
	 wZq+OoG5cnI9heHj1Dfljh+O6Ww3TR0h/2xWpJKLL41X8+QAcsDjbBESjzFAwqaAve
	 6VpheV6fzFki3wRBFxCe9h4ls0auCfQOmdz0Soa8wjw9fZ+VkD+a9HkVllOsGEl66B
	 IIDhB2cG7pNlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	James.Bottomley@HansenPartnership.com,
	linux-trace-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 11/24] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Thu, 29 Feb 2024 15:36:51 -0500
Message-ID: <20240229203729.2860356-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index d1defb9ede70c..621a4b386ae4f 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -78,7 +78,7 @@ asmlinkage void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	static_key_enable(&ftrace_graph_enable.key);
-- 
2.43.0


