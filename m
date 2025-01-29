Return-Path: <stable+bounces-111150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D701CA21E68
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD573A8BFE
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEE1DFE0C;
	Wed, 29 Jan 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLSMzRuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7CB3C38;
	Wed, 29 Jan 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159324; cv=none; b=nDBZHJFPHeBoCfCLVR3AdRVX3Rf30AkgTf4yYAa4hEPOHYF2TnZ4DZphA+ZX5h4Bc+NCMLD8BXFk5IX8gCQEKblvrznPIeSSKUv/PS6p3K2nDYSK1CF3OSAnoj0tI/x8ELJMJk2GrLTsA781TIe372e0hlkLun4oXAX49AMvpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159324; c=relaxed/simple;
	bh=8Pewjumr59BfpIyDUhEf+teBjecSIpo4g2FVBg5b5aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6BFqjgsr8jiiJUk/LuawyRwGSJ00KGsimM5nFtQhJzGVSLs/dDg+tiOA0IXOBdXIXpJryYsSsXVTE1J1fmo5UoKj9s3P7MQ+GI+AZfwGgVme+VUWBIPPXTCTTWIXOcN40Bk1t6uZ3o1nyWZoyC5M2c5NZ4DahOCRfugxFlVdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLSMzRuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B6EC4CED1;
	Wed, 29 Jan 2025 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159324;
	bh=8Pewjumr59BfpIyDUhEf+teBjecSIpo4g2FVBg5b5aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLSMzRuSU6nSbm0ilcogOIO0ocaPilFu6pJdhW2wpEUhVqGVZvJ0PjygmngWv425T
	 q1YM/pACIUG9rLDh2xJTaYYKAxem6gkTc5NfeH/EfKMmUZhi3dTfUvbAmCMwljbfZC
	 kgW9rZg/P+Y0KcmetOR84UV04xChW02w/z9mMWcui1QKhDq44YyTODKSlXrw/ZSn6E
	 JXZDnNR9nD7GYjIszWPGx51EvwG7DRyEhENuHC1Iyebl6wW7LnWLloc0jDu0ImmKlE
	 JlOGC/JlczCtXHauROE4RrJPDCOkp1aBnXpNuNFoqtnMeNfgwKfqE7Yr0dXdZ3WZo1
	 Ow3h+pbhEvr+g==
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
Subject: [PATCH AUTOSEL 6.1 3/4] rtla/timerlat_hist: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:58:12 -0500
Message-Id: <20250129125813.1272819-3-sashal@kernel.org>
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
index ed08295bfa12c..2dd271102c0da 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -785,6 +785,14 @@ static struct osnoise_tool
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


