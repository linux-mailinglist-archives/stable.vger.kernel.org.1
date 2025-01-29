Return-Path: <stable+bounces-111147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9FA21E66
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99D216917A
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0481DF743;
	Wed, 29 Jan 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5Ufr5me"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875E13BAE4;
	Wed, 29 Jan 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159311; cv=none; b=Nqrzfp+CE97MhO/MHRnpCJauAXvh+HCg8ZUvPUyGEUV1yYTCVJ3M2hRyGlscJvDgHvCeoA6mJOCMHNcRZC9knI6XQ/st65Kk0+PHvSVN7u9nBmRzJfLxEz9i4VeDtUSPHkLLOXwvVPQxBnhSMFfcR1M9dkQIbyueWQ7Lc2ztk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159311; c=relaxed/simple;
	bh=I/33bp2iWwifC/Th5cOISPirBOCXqRqDCNQNDm1TXQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Smwix1Ye5JQj3IQFxt0TGso+0qmvVB4yywD9Pu8NGsit5OutEqLbU15ryCPKL3hFRtwf8g40scTSNu3An3ufsC27736gxR9Zc7NjiFB75wMhXshRmQ64T1oF9WsM3K0/J91omTMzRMr9jcCXlWW8fRti5P10D2wpIuSNACXzBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5Ufr5me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B5C4CED1;
	Wed, 29 Jan 2025 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159310;
	bh=I/33bp2iWwifC/Th5cOISPirBOCXqRqDCNQNDm1TXQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5Ufr5medy6dtKHdD50CEwhy+nJFhv3KJKmsFB2NxvgACrgWORDngqgAFCqP1G2u+
	 RHnCGPURxyLexMcmUfQZWabGeCTTnpujqhADNaBKrZoqLZmm2r1s+ZU9CIfH7EUOKz
	 JDgcYLmIjAAB8BJBjrF4B3uYlPipoT/q/7IWbnNTyIlSyNrr7+7s731o1ZjnMSNr0H
	 n/uQhsujnbr0RovXc5RlJtQseFUZMCiPVfm8Np0bTQcEcOmipTjByhPhUdrzZU38tg
	 Ha4LDvWHcpN+z1FFdGPul/CcFBFCvEqqZyuEB/IyyiMg4JcVqWRBN2mvVFmDqgyvud
	 RkMnGNUPxYvOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	ezulian@redhat.com,
	costa.shul@redhat.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 4/4] rtla/timerlat_top: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:57:57 -0500
Message-Id: <20250129125757.1272713-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125757.1272713-1-sashal@kernel.org>
References: <20250129125757.1272713-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit 80967b354a76b360943af384c10d807d98bea5c4 ]

If either SIGINT is received twice, or after a SIGALRM (that is, after
timerlat was supposed to stop), abort processing events currently left
in the tracefs buffer and exit immediately.

This allows the user to exit rtla without waiting for processing all
events, should that take longer than wanted, at the cost of not
processing all samples.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250116144931.649593-6-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 0915092057f85..b0c1c3735173d 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -727,6 +727,14 @@ static struct osnoise_tool
 static int stop_tracing;
 static void stop_top(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(top_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
 }
 
-- 
2.39.5


