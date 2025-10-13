Return-Path: <stable+bounces-185414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7961BD4BF1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0CA18A663C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D7314D21;
	Mon, 13 Oct 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xIJHQFtW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A853093BD;
	Mon, 13 Oct 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370225; cv=none; b=kBoJNeQX0qaNnqM0MeKklYgAv9Hg11C3AIvNKnZp/3lu5I06cyD8siHXSrZcmXaCkL5FXv6bEwdgolryu3rrc4bxlqjsRgIulvl6XtRFzy0GHPz6khAUmR9jygPnSiYoLfUh453JfLwzstI6Eb+9O9he/AKQuekywLlo3ITTX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370225; c=relaxed/simple;
	bh=+GtBaimpyWdO+Luo2DFerA2hm4WtavtmjuiP9JRVOlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDEFI2TRc58eXymm9fkewjP5U3GUjJ/DBqY2CGHU4yIuQbfVt1QZ/r0KImtKhETaO5pEUCiW5a7UHFkqSGH7LBSqzoRXZfXKWF1c3glXtWyQ3J69ObJgDLQ0RVBKFNFRqwLVIV+D7xfmH60CHDaHcGSiUwZMW7Mvba4z0ggy3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xIJHQFtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAD4C116D0;
	Mon, 13 Oct 2025 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760370225;
	bh=+GtBaimpyWdO+Luo2DFerA2hm4WtavtmjuiP9JRVOlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xIJHQFtWLHm3ro1WkJI0jNJqlHEchyiy9PvwPcbJtNKLgAat554z6Dabe1nHTNpN0
	 DEwnrB15fmARShWBn2+BT6FDJ/Nt1/z3wuTwkr5OQr3nRew8Y7uVrlxDfOmzlY3OAX
	 FI08btWknVwGUXHZgHQFyjm24IhV7LMf5HjLM1OE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 490/563] selftests/bpf: Fix realloc size in bpf_get_addrs
Date: Mon, 13 Oct 2025 16:45:51 +0200
Message-ID: <20251013144429.043646842@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 0c342bfc9949dffeaa83ebdde3b4b0ce59009348 ]

We will segfault once we call realloc in bpf_get_addrs due to
wrong size argument.

Fixes: 6302bdeb91df ("selftests/bpf: Add a kprobe_multi subtest to use addrs instead of syms")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f3..03f223333aa4a 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -712,7 +712,7 @@ int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel)
 
 		if (cnt == max_cnt) {
 			max_cnt += inc_cnt;
-			tmp_addrs = realloc(addrs, max_cnt);
+			tmp_addrs = realloc(addrs, max_cnt * sizeof(long));
 			if (!tmp_addrs) {
 				err = -ENOMEM;
 				goto error;
-- 
2.51.0




