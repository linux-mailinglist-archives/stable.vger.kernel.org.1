Return-Path: <stable+bounces-246427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GPrHvFvA2qI5wEAu9opvQ
	(envelope-from <stable+bounces-246427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:22:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB5852771B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D15E632034F8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78191343D9D;
	Tue, 12 May 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3ghane6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7443EDE55;
	Tue, 12 May 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609200; cv=none; b=cUsFVzOZioWopDpB7czX4py9N2UGddKJcxFGvdGsmNC/YMEguMvMnPfvLBvwc+gN69uOcgzI7S0JrrOoc7hyWXIj+jNoyyXt8s5Eopl6uJsnpmMmcV6MEZXyioNI+njd9agZnhlRp0UwG0edlSM42Iz2VbBcvDx0yB6WgQNuUvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609200; c=relaxed/simple;
	bh=gSlcBN/8L9kqV9B9ShjacLpnAf7sEdf5Flxmf9E36PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEFkhYlVZf/2Bs2k/jUwRMNeMB8+tHjBtM9RAdJAwI9sq8M9djReXloxHTIpDN1kOpKzyFbjyzWfeHLNbBCzVXKOAGQ9m0ZmC7jRLp+KrJg6T7Deami69SiYq8A2UnJLk0eKDZ2pBv+zGBI2yukNLF7BCcno6XyS3uN/9p1ApmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3ghane6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06F6C2BCB0;
	Tue, 12 May 2026 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609200;
	bh=gSlcBN/8L9kqV9B9ShjacLpnAf7sEdf5Flxmf9E36PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3ghane6e3iFPj0U3Z38yNT+yIwu92mVdmbCdd6oFugyeSaK+BcNZ7n0bnh5/ypGr
	 bPPEtDUZVB9VIrzd1zq9zplfeKnlk7XCyXJ/2QhdSsGO70enyVXoXFqI84cQv6KhZ6
	 oxgRb2r3EEl3yEaER6r3fStOE1kz/aVAGhZ61rGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 7.0 102/307] selftests/rseq: Dont run tests with runner scripts outside of the scripts
Date: Tue, 12 May 2026 19:38:17 +0200
Message-ID: <20260512173942.278083420@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCB5852771B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246427-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,librseq.so:url,run_syscall_errors_test.sh:url]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

commit cb48828f06afa232cc330f0f4d6be101067810b3 upstream.

The rseq selftests include two runner scripts run_param_test.sh and
run_syscall_errors_test.sh which set up the environment for test binaries
and run them with various parameters. Currently we list these test binaries
in TEST_GEN_PROGS but this results in the kselftest framework running them
directly as well as via the runners, resulting in duplication and spurious
failures when the environment is not correctly set up (eg, if glibc tries
to use rseq).

Move the binaries the runners invoke to TEST_GEN_PROGS_EXTENDED, binaries
listed there are built but not run by the framework.  The param_test
benchmarks are not moved since they are not run by run_param_test.sh.

Fixes: 830969e7821a ("selftests/rseq: Implement time slice extension test")

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260423-selftests-rseq-use-runner-v1-1-e13a133754c1@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 4ef90823b652..0d1947c0d623 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -14,12 +14,15 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
-		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
-		syscall_errors_test slice_test
+TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test \
+		 param_test_benchmark param_test_mm_cid_benchmark slice_test
 
-TEST_GEN_PROGS_EXTENDED = librseq.so
+TEST_GEN_PROGS_EXTENDED = librseq.so \
+	param_test \
+	param_test_compare_twice \
+	param_test_mm_cid \
+	param_test_mm_cid_compare_twice \
+	syscall_errors_test
 
 TEST_PROGS = run_param_test.sh run_syscall_errors_test.sh
 
-- 
2.54.0




