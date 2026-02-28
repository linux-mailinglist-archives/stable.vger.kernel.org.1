Return-Path: <stable+bounces-220092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDYSC+8no2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8631C4F9F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2967D30F9932
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4334D910;
	Sat, 28 Feb 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4AkRx5X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EA34D4FE;
	Sat, 28 Feb 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299989; cv=none; b=c2LfKbn5MPD6aeUpOlzVg19814BGmWDA9/ll+4o0n74Rh/IXTxWiUjEquTcHhlCJBPREGXrcS7HqEt88mDFTcucsG+pFI5RRAZORNbEwvuEig1ShZqM+pWR3xaHGlzl0ieskJagr7tZXFH8EVbrWsz3f5eN7nrrmi6pGncFIDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299989; c=relaxed/simple;
	bh=Xgz+rL+ffqb5LBvI8GygPcblHAni9QFWHkSQbiyyDrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzExQ57h6F/oMOjNqFsMemjUVRT0/y/SAHzQdNV4PK8qFKtwl3VQCZwuoos65IH8hHfKhT1Dw+mjrA2AP3p7yDPnpiKqN4PKFF26XetYaupiOyAFl+IZ3tZEI4hVc+M+hF4oEpAihQMbqZlhuyLShj/3y/qbvs8Rh1cergYIPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4AkRx5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDA3C116D0;
	Sat, 28 Feb 2026 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299988;
	bh=Xgz+rL+ffqb5LBvI8GygPcblHAni9QFWHkSQbiyyDrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4AkRx5XVU0DU7/PIrXwhV3ly+tCeLbZFOWpw9eOqz7mBNLIdtpqxOoh9uNS+Fg+B
	 +HKWUMA/PEBEjjj7gmo7rRLZ55j+4uIebmpTgV8ZF4LjpMdZ3aOa49Cm/B6jIX1YfI
	 cfa0KrpGX83PQOVqHhgnFhwGDV+s90yvyV6f/veQPdhgPZU4I7zNSHCCAQMwX3KBBv
	 jvyH4n0Neh2y+yxdrtXpuvy6TtwwkJH04owJQ9hdfx+Khu3QuVIfb7d6DEpl7+93nh
	 eGB4CtgbM+/5qsamr3J/+q9Pdql+JxzMlcSTRjMm0n4BSoF4C33PdQqxp3gzaLCDR8
	 s9Gu09CM0x8Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	kernel test robot <oliver.sang@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 014/844] perf tests kallsyms: Fix missed map__put()
Date: Sat, 28 Feb 2026 12:18:47 -0500
Message-ID: <20260228173244.1509663-15-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220092-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linaro.org:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB8631C4F9F
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit a58807adbed5f532efb231e5490767f284f237c0 ]

Issue was caught by leak sanitizer and the test robot.

Fixes: 34e271ae55382fbd ("perf test: Add kallsyms split test")
Reported-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Closes: https://lore.kernel.org/oe-lkp/202512101502.f3819cd3-lkp@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/kallsyms-split.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsyms-split.c
index bbbc66957e5d0..117ed3b70f630 100644
--- a/tools/perf/tests/kallsyms-split.c
+++ b/tools/perf/tests/kallsyms-split.c
@@ -148,6 +148,7 @@ static int test__kallsyms_split(struct test_suite *test __maybe_unused,
 	ret = TEST_OK;
 
 out:
+	map__put(map);
 	remove_proc_dir(0);
 	machine__exit(&m);
 	return ret;
-- 
2.51.0


