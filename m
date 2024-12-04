Return-Path: <stable+bounces-98335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737529E403C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338EE28370C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223D20CCE4;
	Wed,  4 Dec 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZa4LS1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC820D4E9;
	Wed,  4 Dec 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331469; cv=none; b=nCXN6Z8nH2/zfvU1UJdm89gN2OtDUsGbySKATxJoLLUFSHb5K1ns5ft5r8OMpnggg0AROHAWd5ibkFOkBDlsEHAYTq81kdNyma0nIn48uge6AFSD+UH2yJYZhBCzRm/579rm6D9wv1o6NVokXfBvbk7C6HZ/0InHfLYMEXHWOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331469; c=relaxed/simple;
	bh=06pVRQZvF7Hv8LSrodVzxmE+a9EeBGCKKwPeWagF/ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI+dKw0yLGuu6kaB7kDkKL0GtShfsU/USZvuSawc+2TQng89xpGpLsM2u98g8OKwl1n47NSK1RtlrgEvH39tNiLjdBWBomFCkqjcQJbf6M3BCZiToAbP1ILvBxALDekx5s/k5aaTuiURc2zVoFqMBniXLgzNoZmtRoqbq16C/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZa4LS1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3D4C4CECD;
	Wed,  4 Dec 2024 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331469;
	bh=06pVRQZvF7Hv8LSrodVzxmE+a9EeBGCKKwPeWagF/ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZa4LS1pYpOPXocCCKDkFa/95MeXhtTnLR0/jtU/SKhrHBQXdhYXzMW2YsrqWDbHT
	 0N8Pl6VQAhKqiMJc0gtKD/0BwvKOG6s7IeMjCqcHXsQ0AN8Y2Hd+Yrl9I3o6lC+GTe
	 cASPfiOf7Qr9HMvmumKxgOJMG4q9po73rvGkWgBgwMQrJTjGAE4COszD25/E+d1JD5
	 qHqOxFGB+3Zj5z9W0VSMbETv8Xkw5x2yu6kzSEn6rBT7O0v2x8n9d8qjDJ1liEXF/m
	 nF79FwUsrWWcTO0K2UiJT4a94+qXBjzmdHEP9YmHiAuFXCH4HQDwe9Z26WxqRKMFtH
	 xCK6k1QujtFhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/36] rtla: Fix consistency in getopt_long for timerlat_hist
Date: Wed,  4 Dec 2024 10:45:18 -0500
Message-ID: <20241204154626.2211476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit cfb1ea216c1656a4112becbc4bf757891933b902 ]

Commit e9a4062e1527 ("rtla: Add --trace-buffer-size option") adds a new
long option to rtla utilities, but among all affected files,
timerlat_hist misses a trailing `:` in the corresponding short option
inside the getopt string (e.g. `\3:`). This patch propagates the `:`.

Although this change is not functionally required, it improves
consistency and slightly reduces the likelihood a future change would
introduce a problem.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Link: https://lore.kernel.org/20240926143417.54039-1-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67a..1f9137c592f45 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -778,7 +778,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
-- 
2.43.0


