Return-Path: <stable+bounces-170218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF78B2A297
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AA374E2E96
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32D2C235F;
	Mon, 18 Aug 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJAtwb7/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95D27E074;
	Mon, 18 Aug 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521919; cv=none; b=JKEPF5cGOhaxP2/NbBi/Y5M1VWW/gwZxuix6AAvlRKVEWRXkVsJxexk/oq5nvA1U3NHWSS6P81KKCVl3mEwp0TNoG2/wZOR5OqFbg4YulCcIgHyFbB91WTCSDdw8+aRCWHKSbBztzBI8aXSidluMWfqOBYx2GK2LhPp2oGGfLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521919; c=relaxed/simple;
	bh=KO4It1dNM823dXG+9zrX+vvIJ1bEps0aJX85X8vI3TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaEQXIsDobqcJZebWck6ZOryBayt+UUOQBmDeM/m+zTXvN3DoqeZAMV2ALX8MJYHVLCbZvXGsKO0jxjWuCTokxXqjX5Vd33TsrvLWrPrjMixLJMEjF3bnNglTou7MvgrCHjyjQZoitpDEpoXy+j6fPq0/0oDGg/QGJkrwQLnZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJAtwb7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46098C116C6;
	Mon, 18 Aug 2025 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521919;
	bh=KO4It1dNM823dXG+9zrX+vvIJ1bEps0aJX85X8vI3TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJAtwb7/lHHrDC4nJhcv4CFYHXCppD2d1a6istQlyhzO19wn4ep1jTC6XKrkqLUvP
	 yqqqDqVdj5UYDZtF5yxYhYCWCLQGFsEfDbpRIfpSQo6hPxVpea9QKD4bMJzJ80v5X0
	 UvT8EXjkcrn7ons27Fv7zMYXAvmECNXMrUqNy6Ns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 162/444] selftests: netfilter: Enable CONFIG_INET_SCTP_DIAG
Date: Mon, 18 Aug 2025 14:43:08 +0200
Message-ID: <20250818124454.972611789@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit ba71a6e58b38aa6f86865d4e18579cb014903692 ]

The config snippet specifies CONFIG_SCTP_DIAG. This was never an option.

Replace CONFIG_SCTP_DIAG with the intended CONFIG_INET_SCTP_DIAG.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/netfilter/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 43d8b500d391..8cc6036f97dc 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -91,4 +91,4 @@ CONFIG_XFRM_STATISTICS=y
 CONFIG_NET_PKTGEN=m
 CONFIG_TUN=m
 CONFIG_INET_DIAG=m
-CONFIG_SCTP_DIAG=m
+CONFIG_INET_SCTP_DIAG=m
-- 
2.39.5




