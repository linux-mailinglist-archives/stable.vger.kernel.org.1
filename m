Return-Path: <stable+bounces-111146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA77A21E63
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1FB188769E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BC1DF251;
	Wed, 29 Jan 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeQauGaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F113BAE4;
	Wed, 29 Jan 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159307; cv=none; b=PO7QzhYy1Ns3z/XzD5GEbIBLW+u+cLZS5T14W7Hs9taxWUwbaWTXILWE9PPi+OwHIDMNl6VCstEZLb1oBB5R+wnHaCxLJYDz0GltM/oHwN+WRd/ISgmYDUUxoF9L9NPVjcIlWrzho8Y4OkQYuLEZ7dDkoWaV7flt2lhjY/xQn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159307; c=relaxed/simple;
	bh=0BHtpPhxjlNMUimiiqfjV9bDKuxDr8m3f1IP9b66l8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIA9I4pzXG6+xeXIWfOLCjvYB7AeBZaTO9p07VyMRtEQ+7cISoIc3duxO4OB/ZOcDKVGBmzf80SJYL2lWX4qvoxijQ0qshkfFNWN+195wLQ67kBJwA+ILSPF5J9/eUomrI8QOiW3b7C4PnvJ3RuO8pssV2lGOm8v5vpLnOGK70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeQauGaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17BAC4CED3;
	Wed, 29 Jan 2025 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159307;
	bh=0BHtpPhxjlNMUimiiqfjV9bDKuxDr8m3f1IP9b66l8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeQauGaIwxXjJIyYmyo1AD96Fxd8bXnAhaL+bPnbS048CGkmg17lHkKyB2IIIpXLE
	 F7Q3yeUvZMtePUYnqd269Tf9HgYU8m1UEdwAt19zbj1vvSMJ9Kdwry3NgsDBTMaryW
	 z4Ew4l181Xh4oAWUF/gHBHH5POqOWOypkd6vcEFpXUCfvdVy1WV03b/c8+xRQcX7vD
	 75nWBTENht4h4IyoRrtSalR3iy2f8nlIv9OP+6EyOl7cxOu1O3G7JRPWUklxX1amU7
	 cXIynG0y5Bx/96EklN7hMpbnJ1OGsXQzfs3I0f7DVwkZyi3iHbw1WB2GUhatc15UEn
	 lGAMPlrExpo5g==
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
Subject: [PATCH AUTOSEL 6.6 3/4] rtla/timerlat_hist: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:57:56 -0500
Message-Id: <20250129125757.1272713-3-sashal@kernel.org>
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
index 667f12f2d67f6..d13e6be3ad197 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -948,6 +948,14 @@ static struct osnoise_tool
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


