Return-Path: <stable+bounces-111142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2CA21E58
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B271889B91
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA821DE2C4;
	Wed, 29 Jan 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmAlVMkH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83DA1ACEC8;
	Wed, 29 Jan 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159291; cv=none; b=sCHx3YTx7o7fuGmMIWeacU4+iOl9ymmXzFw33qrf4PveLVqe5X8Xjsytcub1HPew5xPH+FxKIc4BpCroa0PRF0MNMVFpKH5sYVO6gHw3ktdMuHCxzCqqMmjyxkMCO/x6TLTOj9aWkBBd9cN3mkqa+P+t4rUCbHakhRX6rN+/wDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159291; c=relaxed/simple;
	bh=5HLZ+P6en7fP3zUufaWbpWWpPSsEEui365dvJogZ8oY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQQXMZBsObTGXbCc3l1KKWSspr59/szidx9aqp0K77j2kPiaRNWvmarsZHZD1zPQCSQMYd+jUOVGT9CigR+nx4SQb8IFwO2wbjcddrn+n+LLzzIr0G6Lg2IU43Uskn+xhV6xeC6UpAAQnQZbJlmBzmcWPgrKcDAUKT/MnXeduWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmAlVMkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEBFC4CED3;
	Wed, 29 Jan 2025 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159291;
	bh=5HLZ+P6en7fP3zUufaWbpWWpPSsEEui365dvJogZ8oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmAlVMkH2aC3afaWcQ25HJPYyoW1f1oMGEcQaHNmVdLXWfbZn0YpPf3dK/UVrcEgO
	 X1fq38KNjCM9/Bstj3P3OCJUkgaGkl3Z8fw5cWk2EDZrNG1TsakI7AI6c5+KPLourU
	 Jx01l4+4/znmhgEzoKPKWeH6COP7OvdcNh9Q/acgboril9qdhYAYvJvGu9vxK9nZlH
	 qoLHPPwa5kMtY9L2+xcXn0QvlH8sh6z121XG8UufrJdSLRTTKDy7Rz8/lQWiJftbvi
	 T7jfJ3TR19llIC5FT/9MTAvq/CvxkVjiRG9GsEbRVhBg9Mqw8YIh0gc/S7KBZ5p8iV
	 CHnwMWMMzwhdA==
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
Subject: [PATCH AUTOSEL 6.12 3/4] rtla/timerlat_hist: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:57:40 -0500
Message-Id: <20250129125741.1272609-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129125741.1272609-1-sashal@kernel.org>
References: <20250129125741.1272609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 2cc3ffcbc983d..8dc33e1e6aed2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1139,6 +1139,14 @@ static struct osnoise_tool
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


