Return-Path: <stable+bounces-220100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOzAB6Ioo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A31681C504A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7C8D3129B11
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957E4611C5;
	Sat, 28 Feb 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff8zy+Yr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81E450902;
	Sat, 28 Feb 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300005; cv=none; b=ascej5Etsqs9kBPrjMmw9AASeSQPzo9E4/Z67eY53YdutFbuWfuuwheqOR/V4JB+IQaXuf53ENAt120VWndtwGzDKGmyC+RP9IslndcKE/aNZil8dw7TG1rq9nbVlx/Ipp3WuRouF4FClXscMnL6W/INrSXIBqqlAjn7ZOw08yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300005; c=relaxed/simple;
	bh=z/kL/bJWc08kyBG3h3vrZ//IIQRb6+jQdKuzcY2PTKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6RkQtBNwa2gWMrxDD18w+zMCdPCUgz2WHzQiaBlmzPU/zJJEJX11bWOoAFqs2UtHvm3wLA846wDG4HAZT8P3aGXYx1n/O0LK1nVIneNdKDu3Rwu9QG8KurhFvr8lipF/724EZfxgJ6cg2fwcFodiqt+ic5CguW50k1+hiE+/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff8zy+Yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4512AC19425;
	Sat, 28 Feb 2026 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300005;
	bh=z/kL/bJWc08kyBG3h3vrZ//IIQRb6+jQdKuzcY2PTKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ff8zy+YrMR+vuJkecCOCZhao97aPV9/qCtj8b71N7fWMrLSNEnbpHMDqfRLufUkFY
	 hdejQ8NDO33wE5esv/iN7D+HARDlqjNtxNtKknMCd6j1ouXCT1cZCfFtKq6/aIjMIi
	 BR9BWTvDm/AZYDLPoATNMhsjdvICoInViz9mlpGkAMql2NjmjLPW23mElwVV1PiQwE
	 756K3c4hSyC2hMbv4TyGXSn/68fo6MIuIY/RSmzyHdoz/hueBtPH3qfWrKu8VF5VbR
	 WFBs0yrFr136m6F6HNt512kY25g9V8qJp6z0iR17prdW+juEhfpsZOzu6sA6kSjjQ0
	 Lhurniv6dbK2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Ian Rogers <irogers@google.com>,
	Jan Polensky <japo@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 022/844] perf test: Fix test perf evlist for z/VM s390x
Date: Sat, 28 Feb 2026 12:18:55 -0500
Message-ID: <20260228173244.1509663-23-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220100-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A31681C504A
X-Rspamd-Action: no action

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 008603bda19b29687edce533e4c09acff68c1077 ]

Perf test case 'perf evlist tests' fails on z/VM machines on s390.

The failure is causes by event cycles. This event is not available
on virtualized machines like z/VM on s390.

Change to software event cpu-clock to fix this.

    Output before:
      # ./perf test 78
      79: perf evlist tests              : FAILED!
      #

    Output after:
      # ./perf test 78
      79: perf evlist tests              : Ok
      #

Fixes: b04d2b9199129f4f ("perf test: Fix test case perf evlist tests for s390x")
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Jan Polensky <japo@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/evlist.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/evlist.sh
index 5632be3917109..8a22f4171c07c 100755
--- a/tools/perf/tests/shell/evlist.sh
+++ b/tools/perf/tests/shell/evlist.sh
@@ -21,13 +21,13 @@ trap trap_cleanup EXIT TERM INT
 
 test_evlist_simple() {
 	echo "Simple evlist test"
-	if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null
+	if ! perf record -e cpu-clock -o "${perfdata}" true 2> /dev/null
 	then
 		echo "Simple evlist [Failed record]"
 		err=1
 		return
 	fi
-	if ! perf evlist -i "${perfdata}" | grep -q "cycles"
+	if ! perf evlist -i "${perfdata}" | grep -q "cpu-clock"
 	then
 		echo "Simple evlist [Failed to list event]"
 		err=1
-- 
2.51.0


