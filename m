Return-Path: <stable+bounces-270934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DFM7Oa6VRmquZAsAu9opvQ
	(envelope-from <stable+bounces-270934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:45:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A787A6FA7E8
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:45:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CWVEsI22;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270934-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270934-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCEC03021766
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8433D4F0;
	Thu,  2 Jul 2026 16:37:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E730C158;
	Thu,  2 Jul 2026 16:37:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010234; cv=none; b=Poy4MHkL+NgKXGptbD8Zro0JAq22Q59SDNCxjL88eZhhp+SeY9oZ93z4GUMFMscBi0UPMLjRzd4WKlkJr0dUJzLJCLhNhQ72BtMY9S1uyVVB+cSsqkSntgrLiHPEOVkx0p0MKrvsemopwNC9o7KVxHYA9ORpMe9keTt4wDu5e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010234; c=relaxed/simple;
	bh=HjF2YA3ruRDhrgRLSkpwcecbnTugqBBByZg+23/pbec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4gGUs/4qXWlyk+uvQxlB1HYJY82AxRm18Ltn8VkqJb8mgCXgmAFdVrbH2I0cMp4e3KZmpHB6W1UcKlEWkPKrMhzSk2Q93qvoPFW59IDRcQvsjxVbHS9Xrmz4QZDBqK9HgoOvA9H8tLgOC+fuzgUNuXkwVmtbwpc7Dw4NcZDOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWVEsI22; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568C11F000E9;
	Thu,  2 Jul 2026 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010232;
	bh=8BN2U6lYqbM2gI2uwbyJvdQKKC5FOIA4DluuVElgIQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CWVEsI22WTWLgTz1GrFMSViK/WRKfuyKGgN4l0oI83QGypMYzVmzHXomr2Ca9yLzK
	 KIWytOcxRdfMnmZUQnfKdhs8mQmRLmRyEov8nlbRfDYUJmNLHqCLufJRYsnwTFMU/L
	 qiZHnKw1kMin7Ypervvjpwck1CpImlmWHntpuAw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Hwang <leon.hwang@linux.dev>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 032/204] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
Date: Thu,  2 Jul 2026 18:18:09 +0200
Message-ID: <20260702155119.332572679@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.dev,gmail.com,kernel.org,suse.com];
	TAGGED_FROM(0.00)[bounces-270934-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:leon.hwang@linux.dev,m:varunrmallya@gmail.com,m:ast@kernel.org,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A787A6FA7E8

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varun R Mallya <varunrmallya@gmail.com>

commit c7cab53f9d5273f0cf2a26bdf178c4e074bdfb50 upstream.

Add a selftest to ensure that kprobe_multi programs cannot be attached
using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Link: https://lore.kernel.org/r/20260408190137.101418-3-varunrmallya@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++++++++-
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 +++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 960c9323d1e0f5..4183c2c057a304 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "kprobe_multi_override.skel.h"
 #include "kprobe_multi_session.skel.h"
 #include "kprobe_multi_session_cookie.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -216,7 +217,9 @@ static void test_attach_api_syms(void)
 static void test_attach_api_fails(void)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	struct kprobe_multi *skel = NULL;
+	struct kprobe_multi_sleepable *sl_skel = NULL;
 	struct bpf_link *link = NULL;
 	unsigned long long addrs[2];
 	const char *syms[2] = {
@@ -224,7 +227,7 @@ static void test_attach_api_fails(void)
 		"bpf_fentry_test2",
 	};
 	__u64 cookies[2];
-	int saved_error;
+	int saved_error, err;
 
 	addrs[0] = ksym_get_addr("bpf_fentry_test1");
 	addrs[1] = ksym_get_addr("bpf_fentry_test2");
@@ -323,9 +326,39 @@ static void test_attach_api_fails(void)
 	if (!ASSERT_EQ(saved_error, -E2BIG, "fail_6_error"))
 		goto cleanup;
 
+	/* fail_9 - sleepable kprobe multi should not attach */
+	sl_skel = kprobe_multi_sleepable__open();
+	if (!ASSERT_OK_PTR(sl_skel, "sleep_skel_open"))
+		goto cleanup;
+
+	sl_skel->bss->user_ptr = sl_skel;
+
+	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
+		goto cleanup;
+
+	err = kprobe_multi_sleepable__load(sl_skel);
+	if (!ASSERT_OK(err, "sleep_skel_load"))
+		goto cleanup;
+
+	link = bpf_program__attach_kprobe_multi_opts(sl_skel->progs.handle_kprobe_multi_sleepable,
+						     "bpf_fentry_test1", NULL);
+	saved_error = -errno;
+
+	if (!ASSERT_ERR_PTR(link, "fail_9"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_9_error"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(sl_skel->progs.fentry), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
 cleanup:
 	bpf_link__destroy(link);
 	kprobe_multi__destroy(skel);
+	kprobe_multi_sleepable__destroy(sl_skel);
 }
 
 static void test_session_skel_api(void)
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
new file mode 100644
index 00000000000000..932e1d9c72e2d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+void *user_ptr = 0;
+
+SEC("kprobe.multi")
+int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
+{
+	int a, err;
+
+	err = bpf_copy_from_user(&a, sizeof(a), user_ptr);
+	barrier_var(a);
+	return err;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0




