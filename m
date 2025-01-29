Return-Path: <stable+bounces-111151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26774A21E73
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC7D1889A81
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B41DAC9C;
	Wed, 29 Jan 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQM96mWX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8461DA0E0;
	Wed, 29 Jan 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159329; cv=none; b=LIHi2XawUy03FvjaNcvK7Nltz7PvanMeU7ShO/TyMnSnMTLX20nRXBSCBOgDLBzgkGHJsAoZ0owuEMmG3wmUWUGRZjeg8OsKgAG86SPLGYoAe/JURsejs3ZiYl3qJuyX5zapK6GzmikovXH3zl9pZRyjg3Pvjm+2rPJCFu93A6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159329; c=relaxed/simple;
	bh=+Q/Crg32bWPcKNj2xMMqbD8kjWLhmMc8n+YdCNGtM4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1wjkVfhe8jFmlCx/819sz/PQTnPNuDcn7o1XYBiVz9PkUNDVUDYHsbhyoTKsQ5lz8fDqsFnKwcCGbaZGhmSlPku6vVyVTrJ7Optwi71qaD/E2xrk1P69CcZ3ncwl59QDEPyGWz5EDUokqxBZu4afX4IuGsmcokEvQXQCyJrMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQM96mWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097C9C4CED3;
	Wed, 29 Jan 2025 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159329;
	bh=+Q/Crg32bWPcKNj2xMMqbD8kjWLhmMc8n+YdCNGtM4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQM96mWX7Lz0y9zIuSPhpd8QWOiUQHRCj63JdbfFBk6clfpFRQRs1ziE3uub7ohOg
	 gVeIcbL77Gx8ys7iCNE1XGhuY9daj33GV78y7OBGczk/Xd7kGb05Yk2vpBHhrXWq7V
	 KncEPcxCRB4ECjQ1QHqnfUVn5LhTplxV+JLnroRdpmFfZu1+9X4c/zeqn4+N5ZW3t5
	 ALeHKOUro5980mYXuVzqillTI4mV1ikcCcQf4O9vbxNIm6fXUxWtKcHK+8itFmtE89
	 PUpfqG8CL48UXKUEbH5ra7O/rD3moU7yrMcumr7jNZUV/W0bTgcdEItMGogUhwtGRj
	 GNJhT8sWLFN5w==
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
Subject: [PATCH AUTOSEL 6.1 4/4] rtla/timerlat_top: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:58:13 -0500
Message-Id: <20250129125813.1272819-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125813.1272819-1-sashal@kernel.org>
References: <20250129125813.1272819-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 8fc0f6aa19dad..ee4400aac285a 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -577,6 +577,14 @@ static struct osnoise_tool
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


