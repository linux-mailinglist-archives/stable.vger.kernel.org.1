Return-Path: <stable+bounces-111143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51072A21E59
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537EB3A80D7
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07451DE3D8;
	Wed, 29 Jan 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXUpQ/2p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993951DE3BE;
	Wed, 29 Jan 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738159294; cv=none; b=NfLQ8ACBtzbjx2HLVxQHhGsj+zn1Hwb2+4TzeIZA9o14GGOCzfsonKFSyMQ6NK9syaeX52cOojtTMNREDFw2rvoG3RJ61M0x84lGOvJWbtNrn8wYHW5/mcdaA1boSfV8KVaAM7wKw1dC2cac523U9wH7IREONh63V2eqcqaz6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738159294; c=relaxed/simple;
	bh=z8RD47vH3koyaqg5ia84qX4a3+4MafVg57yjxcLR9ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiNUafTL4dDmLdXOmqOR6Kqj8lcrpIYO3jeqvjMhch7OOAe32/x1gsO3xNtboO54wQ3W/NZ3OSTQ+E8CPFuu8itnujcwANUbgsKqetURSSMVp1wwC2iBz6/2XqE8vzlSiyWkyJe22c984quufJIPdi0fVqnC8Y95qioIgI9t2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXUpQ/2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE43C4CED1;
	Wed, 29 Jan 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738159294;
	bh=z8RD47vH3koyaqg5ia84qX4a3+4MafVg57yjxcLR9ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXUpQ/2pOggXDI4neO0HIyevjjUNq7mOuE5GAlvrx4Tyqdz72kxzJAZwiKIMAyMHa
	 9xzJS0h9MLg5OCpsH/E9En8yepGjAGZPJdHF2HXZz0KFZAurAIWrN9wyr0cssaStNs
	 kXpZBS0jXGf+Z/IGnnN63mn9s75TXTGZV1DMSDpWxRJKUsNaMj8WXPdqzv6almvvhD
	 KVcgAIhRFtSSd3LqjyHFQaGiJBUOJSwKFzb3GJngcCogJh3wFlnIxA9Efd5UzwNIxl
	 A+pqxi0RLiSjl7FLPNhakT4LBbDzcpYSeQ2B/Mv4c4fTomYSOY74Szrze/WtEUbf+x
	 tG4XSxnfQ2Ztw==
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
Subject: [PATCH AUTOSEL 6.12 4/4] rtla/timerlat_top: Abort event processing on second signal
Date: Wed, 29 Jan 2025 07:57:41 -0500
Message-Id: <20250129125741.1272609-4-sashal@kernel.org>
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
index ac2ff38a57ee5..175e842d7e36c 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -893,6 +893,14 @@ static struct osnoise_tool
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


