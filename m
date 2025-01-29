Return-Path: <stable+bounces-111138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CCA21E4D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A36B1888C42
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB1D192B71;
	Wed, 29 Jan 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmO4gVQW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7133C38;
	Wed, 29 Jan 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159276; cv=none; b=hOJSQPqJVZDEHdja/X1gpvWQRc+aBRR/AluYOYK8ojP19oliyxNGQ+l9MXGpIAmS3F/5GaaOtnrzvvv3TojGBpxlE7NPzt3z/HrtDH8tL3Gb1IFbx8GEOUOLw2R+57lnsnCd3wmQxqXXivEFXYPIzJwBHn3xtAfsGZ4U1XZxFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159276; c=relaxed/simple;
	bh=+KUq95fMf9+eAoRT1nh3V70duZZeTCzt7KuZ9AxvMlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlxB0hjcL9EFfoVwS+LDj+r8wIkGECXIlNfCrIYEDPcK0qyBX+G6Fkxd84aGHnVLxAQcCEbUC69YMm4XHXZrayTGETxRjtQrGH2fpRzzXa5S9o3masp5p3mi/VlHcNnpmNxGTQa4Inwz0dB8w5RjmevkOXIUCiYFaZaPKAdRYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmO4gVQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A24C4CED1;
	Wed, 29 Jan 2025 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159275;
	bh=+KUq95fMf9+eAoRT1nh3V70duZZeTCzt7KuZ9AxvMlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmO4gVQW3hddOdrhrtmZQmxJNLfjQD3N2g+KAwzbA40aiB/Ka1NW+cdoa9YonEpVm
	 PWg3xofFczJCFMtgoZyJfHVDK+IcyMTSxFMj6dXGevUMgmhJGLsRfHIddyYAAa6hyy
	 ru4biPMP1+X8wrZQ3adMP+IkiQs6iSwaOBdvbJhdEtoWS++pAKfNmuJuWVWBhmqx24
	 YTMyHRRNFaKKSyrdHJXc0mwPLRKd1fRb0nckQEG0EgVJLSz+ZGLgJswLufUi8quYO0
	 1QfItdY3BrxcTNJBI4fCe8COqK9bd0UCk8/Yvlor0P3XVw+xw9EFdocPHacGANVpxJ
	 Y7wRpgdlNIqfA==
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
	costa.shul@redhat.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 3/4] rtla/timerlat_hist: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:57:22 -0500
Message-Id: <20250129125724.1272534-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125724.1272534-1-sashal@kernel.org>
References: <20250129125724.1272534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit d6899e560366e10141189697502bc5521940c588 ]

If either SIGINT is received twice, or after a SIGALRM (that is, after
timerlat was supposed to stop), abort processing events currently left
in the tracefs buffer and exit immediately.

This allows the user to exit rtla without waiting for processing all
events, should that take longer than wanted, at the cost of not
processing all samples.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250116144931.649593-5-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4403cc4eba302..b784f32a1f4f0 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1148,6 +1148,14 @@ static struct osnoise_tool
 static int stop_tracing;
 static void stop_hist(int sig)
 {
+	if (stop_tracing) {
+		/*
+		 * Stop requested twice in a row; abort event processing and
+		 * exit immediately
+		 */
+		tracefs_iterate_stop(hist_inst->inst);
+		return;
+	}
 	stop_tracing = 1;
 }
 
-- 
2.39.5


