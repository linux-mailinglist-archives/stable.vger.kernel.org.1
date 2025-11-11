Return-Path: <stable+bounces-193366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94568C4A3EE
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 264074F8597
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718525A334;
	Tue, 11 Nov 2025 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="loUlM38f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261957262A;
	Tue, 11 Nov 2025 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823012; cv=none; b=C3PTXckcPZZ0stNyJ4lJMu1LflZ467BjpVW6j+fxiXWBcKgLdXztQ2Paq/ixtQ6VKxxJwI+rOi/PKffkZBOlyppf+K5HnI0RSTuNYdldCfa4RucyFA4G+9NznHvKrWGMICZIWLNjN4vg3HMjZ5I5+2ARlM4aTjFLbSFQ8S3uZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823012; c=relaxed/simple;
	bh=0cGhx5HAAlnaFCz9iU58MVxm3nkogs7ngUkuku9iKvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCqDw2vPKm+CxsKqyJJnSI9udHCXPL2nFOHdoaUIquLYMsuewcio+/Koxi1zBy/xY9vTbfcf5z2QAkNAgiRIUomNRnkSb5puCku/8JbYXUjAX9SAGUdPtDhJomDYNmoX5QdkbmrPRXHilriPWjJe0ltChWx0a2Y/8e3BTh5ocDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=loUlM38f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A6DC16AAE;
	Tue, 11 Nov 2025 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823012;
	bh=0cGhx5HAAlnaFCz9iU58MVxm3nkogs7ngUkuku9iKvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=loUlM38fEdNMBZfohNizpLvogw6EYm+6uAz8+8Arp/qswuwqprxvwJP8aWDvc+gTO
	 CUj9GfsEFSZTCsrc6CRHoRPLQEbbspSfvUzjboO3siA2u3975NrtG1/3M1SpHueoUU
	 0XYSXcCnGl1WGU75Pua2njs4iIqNaKG6VAzKjjfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Stellard <tstellar@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 145/565] bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21
Date: Tue, 11 Nov 2025 09:40:01 +0900
Message-ID: <20251111004530.203956973@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Stellard <tstellar@redhat.com>

[ Upstream commit 5612ea8b554375d45c14cbb0f8ea93ec5d172891 ]

This fixes the build with -Werror -Wall.

btf_dumper.c:71:31: error: variable 'finfo' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   71 |         info.func_info = ptr_to_u64(&finfo);
      |                                      ^~~~~

prog.c:2294:31: error: variable 'func_info' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
 2294 |         info.func_info = ptr_to_u64(&func_info);
      |

v2:
  - Initialize instead of using memset.

Signed-off-by: Tom Stellard <tstellar@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20250917183847.318163-1-tstellar@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 tools/bpf/bpftool/prog.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 527fe867a8fbd..93995275c7f66 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -38,7 +38,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 	__u32 info_len = sizeof(info);
 	const char *prog_name = NULL;
 	struct btf *prog_btf = NULL;
-	struct bpf_func_info finfo;
+	struct bpf_func_info finfo = {};
 	__u32 finfo_rec_size;
 	char prog_str[1024];
 	int err;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 52ffb74ae4e89..6e095a3afc046 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2207,7 +2207,7 @@ static void profile_print_readings(void)
 
 static char *profile_target_name(int tgt_fd)
 {
-	struct bpf_func_info func_info;
+	struct bpf_func_info func_info = {};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	const struct btf_type *t;
-- 
2.51.0




