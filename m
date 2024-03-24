Return-Path: <stable+bounces-32012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022718895C1
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AFE2995C7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298B291B66;
	Mon, 25 Mar 2024 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWNM0D0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC66617EB7C;
	Sun, 24 Mar 2024 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324009; cv=none; b=jP7uNs6DnmiBtJhoPRUHeuWAojZbFPpLKC650LtL/Oiw1SMf1WOKCIQFl2ibKA+a0ssDyCZtixmR4jZGFKzgCJmJOGAFwqWQOybwSK/4GybBl7w7zdv6uZ30gFJ/yboEk4Tsx21CGnP3Gpe8aQmeLMD+YgpsWXMMJfyRbwFFBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324009; c=relaxed/simple;
	bh=w3wXilM/p6r1VZTb0UA83Y9zrU52YRn0KjPnNsyVecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5/XSxnTajBwDxStb4Kfw1JMTXa2wDC788ev6sxI7w4bvQkKouFYf9bblSxPhO9440cT6VJ8KC0gw8di6pRnvLwMNVrP8BpQJd4n1NcbsOKpOgwiwqES2lhtza/X5vz2/Bmk1bwRdBQTQrDsGXbWFmsiPcl4gkHNYEurouUNPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWNM0D0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1373BC433F1;
	Sun, 24 Mar 2024 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324009;
	bh=w3wXilM/p6r1VZTb0UA83Y9zrU52YRn0KjPnNsyVecQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWNM0D0ATuVIvgW+RAAea35ZOghrUCHCEG9k/AElGQ2OYFHDJsC+/Cglf7W9Wf9oB
	 uh0qcca2EBAeA+xI/7CpzgR4bSh6YNxMewqNO7xxoLZCbu//9sv8ARAhmL7cEFb9qe
	 OqjkggA8hHIty6MB8ZY0ZsCb4uWrJ1zbAYZKUNEbiIVqFPCuIv0UqxH16/LcwSnHdj
	 NuphRVTNXuX15cX4/odRlmZCnHv6c8Tyg+cCEVoiOwVRMdWudb0nHYnmekxKV27BYg
	 QiIA1y3z8kcBF3roHpkSrj/VCZNVm2e2LsLuEnUF/XW0UssbF392TbVzHKu9xUiTLf
	 wEdycJlzi5+rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 010/183] parisc/ftrace: add missing CONFIG_DYNAMIC_FTRACE check
Date: Sun, 24 Mar 2024 19:43:43 -0400
Message-ID: <20240324234638.1355609-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index b836fc61a24f4..f3a5c5e480cf0 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -80,7 +80,7 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 #endif
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#if defined(CONFIG_DYNAMIC_FTRACE) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
 int ftrace_enable_ftrace_graph_caller(void)
 {
 	return 0;
-- 
2.43.0


