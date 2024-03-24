Return-Path: <stable+bounces-31854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62469889587
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941961C2FAB6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC12853DA;
	Mon, 25 Mar 2024 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwa3zTRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613727A82F;
	Sun, 24 Mar 2024 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323491; cv=none; b=PZvU4n5XoVQA+7Bl3X+qAhxS53w3vBmD3UabBObycSJ3qkKopBOtCTgUUPWR5oFDWAw9JwXNx8i1YudKJg/i2w6qHQ9qiZ6NZF3/6hoNKRATlz8jVo4HQeKsQKjs9ue5RDJkAEXvXPWJ9GAnfjvH0yS20JdT89yrMEZblSIxCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323491; c=relaxed/simple;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU2x47vpUMKkCeZIjZJBDSOr2ceiBwNjEkLaO/+KPR2yHoIqkBbMbBIJkZENe2UYs6DROiQonP1pFHi0xZvAmALs/eH9ca4uBrneeON8WV62AhxBTtdpkJw4Fr9kq9s/XGqFDx6RqG8am9s6aMcsg+JV/xGxIAcPpW/XVvZhZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwa3zTRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3A3C43394;
	Sun, 24 Mar 2024 23:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323490;
	bh=ch4msB6QbAfyxOHVuIwLakn8UTa3SdoazWxzYOmU5xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwa3zTRJvf5w/J2k9+F+12KZbkW4nqhbduJH2cBuK+r9YeqzJ4lXpjO6Q/QGa1Bfu
	 0OJ7/8UfwJqi5FSRsu9UNN6RywI2LOhfwBGr7Qsgr7pHnL8QdcdEP7kxE7KzjJFioL
	 Snh1V0pDoE4vSM/ELgPPUzwmeHe/znJbG3DOLkJnI1Oy0Hjcf19MhwE/VuGqUAegHW
	 R4NaOufCg52uW5nPGEOvPwTrVL0Lm9dX7x0xowM9SymoGZh69HJCin9SIDbCMgg7Xu
	 0crGqB2SdGNCNFw2nwKWtx5L0fNVS60hA5cEszgMLZ3Bb1u8TTKZ/STW7M8val2+IH
	 Gy55+aO43wzuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 196/317] perf thread_map: Free strlist on normal path in thread_map__new_by_tid_str()
Date: Sun, 24 Mar 2024 19:32:56 -0400
Message-ID: <20240324233458.1352854-197-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 1eb3d924e3c0b8c27388b0583a989d757866efb6 ]

slist needs to be freed in both error path and normal path in
thread_map__new_by_tid_str().

Fixes: b52956c961be3a04 ("perf tools: Allow multiple threads or processes in record, stat, top")
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240206083228.172607-6-yangjihong1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/thread_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c9bfe4696943b..cee7fc3b5bb0c 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -279,13 +279,13 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
 		threads->nr = ntasks;
 	}
 out:
+	strlist__delete(slist);
 	if (threads)
 		refcount_set(&threads->refcnt, 1);
 	return threads;
 
 out_free_threads:
 	zfree(&threads);
-	strlist__delete(slist);
 	goto out;
 }
 
-- 
2.43.0


