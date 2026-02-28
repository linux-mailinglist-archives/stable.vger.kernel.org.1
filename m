Return-Path: <stable+bounces-220185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hu4Nosto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A91C5563
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE3C530EE49B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F344C0425;
	Sat, 28 Feb 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgHiC//i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F134C0414;
	Sat, 28 Feb 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300092; cv=none; b=Oq/ww5WaxpP8ZrU8xA+0stFiRNXGxSsXmgSJfPg9oGyRQUCmfb5icnZErLiyFXotZOyO1sdl1Cgbgpmidm1Qa/Y0m1aegL1OI/ZP6+FxErUl7QVCEtarTu6a2wkhwDzweAjRBwSG6Qx5BiA+xL3KJXpciFr6zBN9gnwybOhZMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300092; c=relaxed/simple;
	bh=5OS9MRJeSPsiwJmaYcDdz4TVLeyQSuvgfYTBYkHqbjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssYT1MMn8fyInCuJZRUwkFUKVPVOVwpFKBOzA+YTk2upI+pqC8krYIPsxtaPgVPXKXMG45JBXFF5q820QaDuryyC61kEJXq1DtbUZ7klP3ynpfGSPat8j5xIkamEgxVwq/fAiNkljho4ACfoZhpd5guWmGGaW8WD8gIOZkIq4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgHiC//i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7CAC116D0;
	Sat, 28 Feb 2026 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300092;
	bh=5OS9MRJeSPsiwJmaYcDdz4TVLeyQSuvgfYTBYkHqbjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgHiC//iYb3UsGI9nuGzvQCZ/F7vlwqKRlVvfWgJDPza9x9vulA/MNy3F9lqabmcj
	 s2VN778zxhwLG1cJt2Xoq3HoEKzcvHMl/CdDHmy6NpEHmycU71qZy1U0QF4F8H2DD2
	 1/sxsZ7bLaOQm5tte2VVs4lDV4uzXK/aEJXOIVCFJ7kFjuzSsqqKmM2sMv5ivbJZE4
	 zvWeWofdjcx7HNa1AUn6BhwU2Id8VTEImK2hd9wyBtKKWDT4wkmFbCy0u/CjqO7PCQ
	 4jB3SI/7103X5h4Ej2VmTvmJHfBYB1FkSegfy4jaqnyvbabHxV47rx8rd6UUNQFzyf
	 vlfqmdy/dJexA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 107/844] bpftool: Fix dependencies for static build
Date: Sat, 28 Feb 2026 12:20:20 -0500
Message-ID: <20260228173244.1509663-108-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220185-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 990A91C5563
X-Rspamd-Action: no action

From: Ihor Solodrai <ihor.solodrai@linux.dev>

[ Upstream commit 08a7491843224f8b96518fbe70d9e48163046054 ]

When building selftests/bpf with EXTRA_LDFLAGS=-static the follwoing
error happens:

  LINK    /ws/linux/tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool
/usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-dso_dlfcn.o): in function `dlfcn_globallookup':
   [...]
/usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_expand_block':
(.text+0xc64): undefined reference to `uncompress'
/usr/bin/x86_64-linux-gnu-ld.bfd: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_compress_block':
(.text+0xce4): undefined reference to `compress'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:252: /ws/linux/tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool] Error 1
make: *** [Makefile:327: /ws/linux/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
make: *** Waiting for unfinished jobs....

This is caused by wrong order of dependencies in the Makefile. Fix it.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20260128211255.376933-1-ihor.solodrai@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 5442073a2e428..519ea5cb8ab1c 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
 endif
 endif
 
-LIBS = $(LIBBPF) -lelf -lz -lcrypto
-LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
+LIBS = $(LIBBPF) -lelf -lcrypto -lz
+LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lcrypto -lz
 
 ifeq ($(feature-libelf-zstd),1)
 LIBS += -lzstd
-- 
2.51.0


