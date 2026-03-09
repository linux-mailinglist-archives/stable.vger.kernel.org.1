Return-Path: <stable+bounces-223703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFrXFa/3rmnZKgIAu9opvQ
	(envelope-from <stable+bounces-223703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:39:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8847E23CD8F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCFE8326EAA5
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB63ED5BA;
	Mon,  9 Mar 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbHVSlmo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4D3ED5A2
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073727; cv=none; b=nTux3qILcYyRSoFhB5LcCEpnPgJQUZg/ijqv/w2J9Di7yupvxM3NTK98uZIEHK9V9mGwn4EUEuMjQ+q7M/NnZ1yafJIW1JxpNid17gh3Wl3PQ2dcrxn1gfDDC4NGZQbs/SHGvL/a4CzlhO2JE5yyKibZuKTLSUg5XA5697/4OyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073727; c=relaxed/simple;
	bh=EZI2K6uY19adL9VhfWauLED/QOlix33yoS1hsay9Vhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a458NM3MSWXyllqQZ+xaH8h1vyowWj/VC5qHeeIyAqorTlRxlpb84tluFiSYHQc/5sfth6bgCrWROw28bUxfyaUTK2S00rzauz/7JjhskRENoO6VXBcDf3oPxzDIfeCMoJumbKuODugoL2NNl6IMf/hp9L7VPmEGBddeNgIIR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbHVSlmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964FCC4CEF7;
	Mon,  9 Mar 2026 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773073726;
	bh=EZI2K6uY19adL9VhfWauLED/QOlix33yoS1hsay9Vhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbHVSlmosuwRcG9T7TrNPo8GmmiZBqW4Sjo8iAi73quUx0DwmwVieXSWDleZzSmRT
	 41YLwWY/E8eQUz8FNDPJdIqhX3ybvGZE3Ke71klDNnabSHJTVgaJEg0A9nypnmpZBO
	 h87DrBSYy8JLmoEskEMzYGmAf04NoM+boU7E6i/NIQXr9OyU41Hd9M9BnS9Lqu6CHZ
	 iDLN50Hxh/c7JsfeSOeO3GxQ+vI/Gh+MI6yjQWpUCRBQuip3V5LTTJroCKUSZxLm8N
	 RjJaseApy7EkdwPjeeuS9nXHBO9OQfpPM2A72g/b+s+kjcu+Fxuhwez7gWQEuaFQvT
	 r2sMuTzKn2QGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] selftests: mptcp: add a check for 'add_addr_accepted'
Date: Mon,  9 Mar 2026 12:28:42 -0400
Message-ID: <20260309162844.1306091-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030947-unbend-embezzle-26de@gregkh>
References: <2026030947-unbend-embezzle-26de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8847E23CD8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223703-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,msgid.link:url]
X-Rspamd-Action: no action

From: Gang Yan <yangang@kylinos.cn>

[ Upstream commit 0eee0fdf9b7b0baf698f9b426384aa9714d76a51 ]

The previous patch fixed an issue with the 'add_addr_accepted' counter.
This was not spot by the test suite.

Check this counter and 'add_addr_signal' in MPTCP Join 'delete re-add
signal' test. This should help spotting similar regressions later on.
These counters are crucial for ensuring the MPTCP path manager correctly
handles the subflow creation via 'ADD_ADDR'.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-11-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 560edd99b5f5 ("selftests: mptcp: join: check RM_ADDR not sent over same subflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c571563a42c59..e3b95a25de9cf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3921,38 +3921,45 @@ endpoint_tests()
 			$ns1 10.0.2.1 id 1 flags signal
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
 		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
+		chk_mptcp_info add_addr_signal 0 add_addr_accepted 0
 
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 
 		pm_nl_del_endpoint $ns1 99 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after re-delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
+		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
 		wait_mpj $ns2
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
+		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
 		mptcp_lib_kill_group_wait $tests_pid
 
 		kill_events_pids
-- 
2.51.0


