Return-Path: <stable+bounces-80212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5DE98DC74
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8167B269EA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D01D150A;
	Wed,  2 Oct 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k++ohhYn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF591D0DF7;
	Wed,  2 Oct 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879711; cv=none; b=FS6yg274nimt2lTf2eknohAavIvpfI/6Ny9JsVpQKTEBd9N7wJCVOtfioxGFnnRvfKXVOQAGA/R3ZX5/++R37ayVN7P63efJ50ocxDpM0v4uBJFjdgVJMaVF2hnUy/uEUpEHhWdf0dyxqeIcxsQC4mw03nxz8uFZcz0fIkCjsqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879711; c=relaxed/simple;
	bh=iNc0j/d0Vf5a19I5iLT0qSRhDpLhnXLs0mZD/2bMzW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzLRBBaAx+p04/1YTyVR1OXtoQc743VthG8JtJ7CPnkErKrg0o5rFQW7ltmKJbl8mPhynsZupN8ALXmkencei9wfTzIq6hdX3NhJwEQLFrpZw2nlSA3BNuHmMC7gUg7YkiMqvRtNHtB38IXOaDcOdGnK9Sz8v4a+R2zkj65gE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k++ohhYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0620DC4CEC5;
	Wed,  2 Oct 2024 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879711;
	bh=iNc0j/d0Vf5a19I5iLT0qSRhDpLhnXLs0mZD/2bMzW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k++ohhYnIpEMimyXo3FelZuW3DFo1+1NMvh/1X0GnuvpyluQqFzACO/a2uSpvW/Lh
	 7RFFlCBhhiatA2PaFsiHyNAvp/k1umi49CbflUw00RUWK49pwAv5Ht8SyZA0bU7tUY
	 +EifmDQ7fVNFZvtEwN2nuKDQKjQqZOIJ/9mnAYiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 213/538] selftests/bpf: Fix arg parsing in veristat, test_progs
Date: Wed,  2 Oct 2024 14:57:32 +0200
Message-ID: <20241002125800.665362856@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Ambardar <tony.ambardar@gmail.com>

[ Upstream commit 03bfcda1fbc37ef34aa21d2b9e09138335afc6ee ]

Current code parses arguments with strtok_r() using a construct like

    char *state = NULL;
    while ((next = strtok_r(state ? NULL : input, ",", &state))) {
        ...
    }

where logic assumes the 'state' var can distinguish between first and
subsequent strtok_r() calls, and adjusts parameters accordingly. However,
'state' is strictly internal context for strtok_r() and no such assumptions
are supported in the man page. Moreover, the exact behaviour of 'state'
depends on the libc implementation, making the above code fragile.

Indeed, invoking "./test_progs -t <test_name>" on mips64el/musl will hang,
with the above code in an infinite loop.

Similarly, we see strange behaviour running 'veristat' on mips64el/musl:

    $ ./veristat -e file,prog,verdict,insns -C two-ok add-failure
    Can't specify more than 9 stats

Rewrite code using a counter to distinguish between strtok_r() calls.

Fixes: 61ddff373ffa ("selftests/bpf: Improve by-name subtest selection logic in prog_tests")
Fixes: 394169b079b5 ("selftests/bpf: add comparison mode to veristat")
Fixes: c8bc5e050976 ("selftests/bpf: Add veristat tool for mass-verifying BPF object files")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/392d8bf5559f85fa37926c1494e62312ef252c3d.1722244708.git.tony.ambardar@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/testing_helpers.c | 4 ++--
 tools/testing/selftests/bpf/veristat.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 8d994884c7b44..6acffe0426f01 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -220,13 +220,13 @@ int parse_test_list(const char *s,
 		    bool is_glob_pattern)
 {
 	char *input, *state = NULL, *test_spec;
-	int err = 0;
+	int err = 0, cnt = 0;
 
 	input = strdup(s);
 	if (!input)
 		return -ENOMEM;
 
-	while ((test_spec = strtok_r(state ? NULL : input, ",", &state))) {
+	while ((test_spec = strtok_r(cnt++ ? NULL : input, ",", &state))) {
 		err = insert_test(set, test_spec, is_glob_pattern);
 		if (err)
 			break;
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 0ad98b6a8e6ef..611b5a0a6f7e3 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -753,13 +753,13 @@ static int parse_stat(const char *stat_name, struct stat_specs *specs)
 static int parse_stats(const char *stats_str, struct stat_specs *specs)
 {
 	char *input, *state = NULL, *next;
-	int err;
+	int err, cnt = 0;
 
 	input = strdup(stats_str);
 	if (!input)
 		return -ENOMEM;
 
-	while ((next = strtok_r(state ? NULL : input, ",", &state))) {
+	while ((next = strtok_r(cnt++ ? NULL : input, ",", &state))) {
 		err = parse_stat(next, specs);
 		if (err)
 			return err;
@@ -1444,7 +1444,7 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 	while (fgets(line, sizeof(line), f)) {
 		char *input = line, *state = NULL, *next;
 		struct verif_stats *st = NULL;
-		int col = 0;
+		int col = 0, cnt = 0;
 
 		if (!header) {
 			void *tmp;
@@ -1462,7 +1462,7 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 			*stat_cntp += 1;
 		}
 
-		while ((next = strtok_r(state ? NULL : input, ",\n", &state))) {
+		while ((next = strtok_r(cnt++ ? NULL : input, ",\n", &state))) {
 			if (header) {
 				/* for the first line, set up spec stats */
 				err = parse_stat(next, specs);
-- 
2.43.0




