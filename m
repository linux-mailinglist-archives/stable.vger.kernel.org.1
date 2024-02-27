Return-Path: <stable+bounces-24585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821B869543
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988341C23642
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA713DB9B;
	Tue, 27 Feb 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QHslzIXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5113B2B4;
	Tue, 27 Feb 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042427; cv=none; b=VE7O6u9Tl519emY2G+N9n3CjiiXvKvdSNSD9nZPImei+qdyZmJnbX1IXD/uWgAKwzfbgm4VJ3SqIRgDkd0U4ykCJ/Vcsn8dDJutrWn+LqDCEZ74krIUAIwvuGMFj0Fact6pOeyOuwGWkOlbjwPA3OpruEtuGd5UH/Ax0hi0Ff8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042427; c=relaxed/simple;
	bh=FqgLIR0yvmO69ipR1r3KT0fYutcVVr0iusvn+M/QTMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSCgt5URfiHWDx9E+AlSCg4gG8T/Xckh/aZUgsB94YLR/j+aJ7Yoo2yqjolSDYMuYAVZQ8DGZTLaix+WtQppVST5HgOG4rPJzZPSpxmvSMNu/EMmh19xfoXA6KnfnByyPPgK3j+MuxyLy9Ufx8ulWZvtUtpZSMKHvMd+f3Rt4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QHslzIXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F2CC433A6;
	Tue, 27 Feb 2024 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042426;
	bh=FqgLIR0yvmO69ipR1r3KT0fYutcVVr0iusvn+M/QTMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHslzIXmuFAl6LmwHvb9klq03C6uw5CIlAp2xhCM+wAJp7TulGB8/UWZ2XcRzQwFS
	 qk2l5TPpP8FNKUS1KoK9OvEqUqUt+Fqvq7jOSl6UpzwKy5UjSbq4pDyUlwB5pONfBP
	 PRA0nDjLfSbfbeAUkvG+I+uQ9aOLPaXjKd9S7tLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 292/299] mm/zswap: invalidate duplicate entry when !zswap_enabled
Date: Tue, 27 Feb 2024 14:26:43 +0100
Message-ID: <20240227131635.068054332@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

From: Chengming Zhou <zhouchengming@bytedance.com>

commit 678e54d4bb9a4822f8ae99690ac131c5d490cdb1 upstream.

We have to invalidate any duplicate entry even when !zswap_enabled since
zswap can be disabled anytime.  If the folio store success before, then
got dirtied again but zswap disabled, we won't invalidate the old
duplicate entry in the zswap_store().  So later lru writeback may
overwrite the new data in swapfile.

Link: https://lkml.kernel.org/r/20240208023254.3873823-1-chengming.zhou@linux.dev
Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zswap.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1215,7 +1215,7 @@ bool zswap_store(struct folio *folio)
 	if (folio_test_large(folio))
 		return false;
 
-	if (!zswap_enabled || !tree)
+	if (!tree)
 		return false;
 
 	/*
@@ -1231,6 +1231,9 @@ bool zswap_store(struct folio *folio)
 	}
 	spin_unlock(&tree->lock);
 
+	if (!zswap_enabled)
+		return false;
+
 	/*
 	 * XXX: zswap reclaim does not work with cgroups yet. Without a
 	 * cgroup-aware entry LRU, we will push out entries system-wide based on



