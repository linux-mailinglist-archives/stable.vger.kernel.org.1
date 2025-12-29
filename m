Return-Path: <stable+bounces-203890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC5CE77E6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2CD306324D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D786725DD1E;
	Mon, 29 Dec 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sgCRUJ/U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E15330311;
	Mon, 29 Dec 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025457; cv=none; b=p7up9PKB042G9AsbrXM7Fbqc9AOtPCmWMX/l1TuyarW/4jZXtlzDDtSTP4CGsEXGiNFyhnUvBvrJnQMLbwi48Iz62d1urAgC4+iPnkVhnE0SFS/8mttSPRvRZ+EMufkvIzogvuLTFALezUFw/4vfHFhmZajpTJPPEbrIOnUpqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025457; c=relaxed/simple;
	bh=LU8ENjP4Vy9/iJPgAtSPbrp3ng39YiRWeUEjzNHny80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUOJYFUg/kGG/NCiCKLBmP23IMZ3ZUcvjPZ85UqBkvP3ZeCUGmXp4BLTFF4gT68wMm4ljKjo/zma9NH942olfBt4fu9WR96tC5eRlLQulUCTLCAMWabZSs7v0pP2zTCMG0jLeeeGX0mlZKq91FNvtlrqgb6zyMBWeO2R/vGBCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sgCRUJ/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CDAC4CEF7;
	Mon, 29 Dec 2025 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025457;
	bh=LU8ENjP4Vy9/iJPgAtSPbrp3ng39YiRWeUEjzNHny80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgCRUJ/UFm9rzJO5Puwrt4yPYll2lU91eo+726n4Du0pJoix0UfNrC6HCWrXK+z2Q
	 tR3zdaDYVc+toXv0+QPXvHp66lznaHehPekn2qfa9CPDKB0Sf1LzD7DfZgxIAXzMe9
	 S45+49T0tYdhLQLBH70HlZsLXKxG5ATFGG5MwLC4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ingo Molnar <mingo@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 203/430] libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map
Date: Mon, 29 Dec 2025 17:10:05 +0100
Message-ID: <20251229160731.824782053@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit a0a4173631bfcfd3520192c0a61cf911d6a52c3a ]

Passing an empty map to perf_cpu_map__max triggered a SEGV. Explicitly
test for the empty map.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
Tested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/perf/cpumap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index b20a5280f2b3..2bbbe1c782b8 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -368,10 +368,12 @@ struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 		.cpu = -1
 	};
 
-	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return __perf_cpu_map__nr(map) > 0
-		? __perf_cpu_map__cpu(map, __perf_cpu_map__nr(map) - 1)
-		: result;
+	if (!map)
+		return result;
+
+	// The CPUs are always sorted and nr is always > 0 as 0 length map is
+	// encoded as NULL.
+	return __perf_cpu_map__cpu(map, __perf_cpu_map__nr(map) - 1);
 }
 
 /** Is 'b' a subset of 'a'. */
-- 
2.51.0




