Return-Path: <stable+bounces-265317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DjGBDiqIMWpjlwUAu9opvQ
	(envelope-from <stable+bounces-265317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:30:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD8693337
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:30:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="TA8/VGB9";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265317-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265317-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66957309B7A8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92333A70E;
	Tue, 16 Jun 2026 17:23:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844647A0D7;
	Tue, 16 Jun 2026 17:23:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630592; cv=none; b=W1kgGu7nZTplqylanotpAKsKVoz/PBTlbl/k7Y8CPezAiqAYA5QU2FgFWswKUe1VC3+wmJCHRlKCIg9YSI8dIEQLGfk2y8sUepOpRVss/YJc1xCP+sIzxQknOv0tutm5FKRjN+0SjqyB98po5EkmVi1ws5YuKmw6pkoc8G69NFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630592; c=relaxed/simple;
	bh=dz4W9qfm9Rxt2VYTzlTwaUJ/deEfk1Yc/w0tiHBIgCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo9k7Z6JUxItD4ks6aLPlNNiO91bY4wdkdGxK+P5DBhNaND7p6EUTNwPlXnHE6Ey3AUOaw83fCmduRYGqLsDtfWFJ5bIqnQtY/GIcW6Z18JlUPJfDLci7u7jzcFygVv3AuZKRgerpX75CHi3jtqopylPgPiVsCk0HCXb2f58Sw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TA8/VGB9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3342A1F000E9;
	Tue, 16 Jun 2026 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630590;
	bh=ZmZ2aUJSuJeUBfAhSpPSHAbmcutHrNmJiFzu2tmMgQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TA8/VGB9d6dnm62jT1zYiAaZ2+UfXeZQhxIuGRIHO5TswEnXse6A5rE7+L8K5v6/C
	 X/xSCTtkpXHPlNQG25w6nLtNVZCCITqs0vI0X18Q0znLvKaSfwwRErFF5151YlBt71
	 tLLr2NOG8aOimWxUDv4KTKxPd83jhI39lg00vLTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/522] Revert "selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()"
Date: Tue, 16 Jun 2026 20:23:24 +0530
Message-ID: <20260616145128.451168149@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265317-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:paul.chaignon@gmail.com,m:shung-hsi.yu@suse.com,m:sashal@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84BD8693337

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Chaignon <paul.chaignon@gmail.com>

This reverts commit 45108a7b4866 ("selftests/bpf: Add tests for _opts
variants of bpf_*_get_fd_by_id()"). As explained in the previous patch,
it introduces a new selftest for a feature that doesn't exist in 6.1. It
was backported as a stable-dep of a1914d146622 ("selftests/bpf:
Workaround strict bpf_lsm return value check"), also reverted in the
previous patch.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 -
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c | 87 -------------------
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c | 36 --------
 3 files changed, 124 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index beef1232a47aeb..0fb03b8047d535 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -76,4 +76,3 @@ lookup_key                               # JIT does not support calling kernel f
 verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
 kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
 deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
-libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
deleted file mode 100644
index 25e5dfa9c315ce..00000000000000
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
- *
- * Author: Roberto Sassu <roberto.sassu@huawei.com>
- */
-
-#include <test_progs.h>
-
-#include "test_libbpf_get_fd_by_id_opts.skel.h"
-
-void test_libbpf_get_fd_by_id_opts(void)
-{
-	struct test_libbpf_get_fd_by_id_opts *skel;
-	struct bpf_map_info info_m = {};
-	__u32 len = sizeof(info_m), value;
-	int ret, zero = 0, fd = -1;
-	LIBBPF_OPTS(bpf_get_fd_by_id_opts, fd_opts_rdonly,
-		.open_flags = BPF_F_RDONLY,
-	);
-
-	skel = test_libbpf_get_fd_by_id_opts__open_and_load();
-	if (!ASSERT_OK_PTR(skel,
-			   "test_libbpf_get_fd_by_id_opts__open_and_load"))
-		return;
-
-	ret = test_libbpf_get_fd_by_id_opts__attach(skel);
-	if (!ASSERT_OK(ret, "test_libbpf_get_fd_by_id_opts__attach"))
-		goto close_prog;
-
-	ret = bpf_obj_get_info_by_fd(bpf_map__fd(skel->maps.data_input),
-				     &info_m, &len);
-	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd"))
-		goto close_prog;
-
-	fd = bpf_map_get_fd_by_id(info_m.id);
-	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id"))
-		goto close_prog;
-
-	fd = bpf_map_get_fd_by_id_opts(info_m.id, NULL);
-	if (!ASSERT_LT(fd, 0, "bpf_map_get_fd_by_id_opts"))
-		goto close_prog;
-
-	fd = bpf_map_get_fd_by_id_opts(info_m.id, &fd_opts_rdonly);
-	if (!ASSERT_GE(fd, 0, "bpf_map_get_fd_by_id_opts"))
-		goto close_prog;
-
-	/* Map lookup should work with read-only fd. */
-	ret = bpf_map_lookup_elem(fd, &zero, &value);
-	if (!ASSERT_OK(ret, "bpf_map_lookup_elem"))
-		goto close_prog;
-
-	if (!ASSERT_EQ(value, 0, "map value mismatch"))
-		goto close_prog;
-
-	/* Map update should not work with read-only fd. */
-	ret = bpf_map_update_elem(fd, &zero, &len, BPF_ANY);
-	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem"))
-		goto close_prog;
-
-	/* Map update should work with read-write fd. */
-	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.data_input), &zero,
-				  &len, BPF_ANY);
-	if (!ASSERT_OK(ret, "bpf_map_update_elem"))
-		goto close_prog;
-
-	/* Prog get fd with opts set should not work (no kernel support). */
-	ret = bpf_prog_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	if (!ASSERT_EQ(ret, -EINVAL, "bpf_prog_get_fd_by_id_opts"))
-		goto close_prog;
-
-	/* Link get fd with opts set should not work (no kernel support). */
-	ret = bpf_link_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
-		goto close_prog;
-
-	/* BTF get fd with opts set should not work (no kernel support). */
-	ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
-
-close_prog:
-	if (fd >= 0)
-		close(fd);
-
-	test_libbpf_get_fd_by_id_opts__destroy(skel);
-}
diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
deleted file mode 100644
index f5ac5f3e89196f..00000000000000
--- a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
- *
- * Author: Roberto Sassu <roberto.sassu@huawei.com>
- */
-
-#include "vmlinux.h"
-#include <errno.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-/* From include/linux/mm.h. */
-#define FMODE_WRITE	0x2
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u32);
-} data_input SEC(".maps");
-
-char _license[] SEC("license") = "GPL";
-
-SEC("lsm/bpf_map")
-int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
-{
-	if (map != (struct bpf_map *)&data_input)
-		return 0;
-
-	if (fmode & FMODE_WRITE)
-		return -EACCES;
-
-	return 0;
-}
-- 
2.53.0




