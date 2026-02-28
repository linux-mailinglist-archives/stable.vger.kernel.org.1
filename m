Return-Path: <stable+bounces-220097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ItuDzMoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2B1C4FCD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E516308064F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2633FE26;
	Sat, 28 Feb 2026 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMdQklAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979F33F38A;
	Sat, 28 Feb 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300002; cv=none; b=BKd0EDBItTeCUTd8GUt4KHcvXMfoNLM/5IaKUDCKs86QOP61aFrLNfKZicOee1aQJZMV6yXXQy/s533nXI9nEBNviHJySAA/drRj8SxLbVixka/mcC9MKuJm2tBX5JcySbiown8UbijlXeHbhEbNwSzYxPJyVMY/tuZbcyQzzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300002; c=relaxed/simple;
	bh=7uvaeHPoSH2tKbMUr/MemqSD7tr+E+a5e34IHw6SqrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oT1dJhlt8QEZjD9PcS7wwRCTUO/rnS8DK+rFEqfc6T/hBkX3xlFCYUSpD7tUehC7bXw+r4yMR3vYSk/+3cABtyAjYEbkqA9RPbXiNGJtEQtsyaQpkmbZBubVUXqWgTScJNfPLRHMyWb4xXJyOobltz/aOQJ8kpotLt86a5k+1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMdQklAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF80C19423;
	Sat, 28 Feb 2026 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300001;
	bh=7uvaeHPoSH2tKbMUr/MemqSD7tr+E+a5e34IHw6SqrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMdQklAIFhOKKZCtpCfgOrvPI5/wRXT7yKhRrv/zZsslg3zesU1TQo7hZS1zCWzZk
	 L9Z0ndXn+2TWgHjgV8Lx16+QoVtswnhQPsTCYU/hitLx3wNtTnxq5O3G8saJjJVnCo
	 Hvd5gBuOHcEu2Gs72RdYppQU2AJYMzuaRhUJl+rn33HhRkH0TNbOWIC7w2Aq1lzxEn
	 7VbeIqp3FNp0DiAkI9LBeIOv5BX2jbArQigqF6foQPwUmkOdK9V8zLtF8J3r7djIGC
	 OoS0oRGHJsjqe1Eu2p6VTsP+GGnxWas7R1eBj9I6oKj0fRoZnYtpIZnWHWAI4Hm9nC
	 caVmL0C0OQNqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 019/844] perf annotate: Fix memcpy size in arch__grow_instructions()
Date: Sat, 28 Feb 2026 12:18:52 -0500
Message-ID: <20260228173244.1509663-20-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,intel.com,linux.intel.com,redhat.com,linaro.org,kernel.org,arm.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220097-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,intel.com:email,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 5CD2B1C4FCD
X-Rspamd-Action: no action

From: Suchit Karunakaran <suchitkarunakaran@gmail.com>

[ Upstream commit f0d98c78f8bf73ce2a9b7793f66cda240fa9ab10 ]

The memcpy() in arch__grow_instructions() is copying the wrong number of
bytes when growing from a non-allocated table.

It should copy arch->nr_instructions * sizeof(struct ins) bytes, not
just arch->nr_instructions bytes.

This bug causes data corruption as only a partial copy of the
instruction table is made, leading to garbage data in most entries and
potential crashes

Fixes: 2a1ff812c40be982 ("perf annotate: Introduce alternative method of keeping instructions table")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 924429142631a..88706b98b9064 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -81,7 +81,7 @@ static int arch__grow_instructions(struct arch *arch)
 	if (new_instructions == NULL)
 		return -1;
 
-	memcpy(new_instructions, arch->instructions, arch->nr_instructions);
+	memcpy(new_instructions, arch->instructions, arch->nr_instructions * sizeof(struct ins));
 	goto out_update_instructions;
 }
 
-- 
2.51.0


