Return-Path: <stable+bounces-179478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDFCB560DC
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DB8A06FA2
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C812ECD22;
	Sat, 13 Sep 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfcEzQD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41293194124
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767160; cv=none; b=ZlyZD/+nJwXOlWH/UvI7Ak5YkmcHBxDFzcCrcWG8AT2wmgDkpmfoYzSCPzZrxYI2Kc3/fI8xPcfQoaKuuJX3P2SvOdGA+2nmGWKKi8+2F6UpV1AEK0Tb7NP21pQHlhXtOYG4Lu/rqPFJtI2Xuth8kJfuZntxTkOe2kT3VLQKxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767160; c=relaxed/simple;
	bh=27K5PyIRRZEppdn66B8GYUNOj3w77ZNWZZ5ujRPMFjQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CClyaF00wgstLLWYxNiLSLzcHvAOoHKuSasGa8PpGvTdG8de5mrpjA4Nkct0da3trvlfjgu/GaLQ8CqKgmDeOFj2HoHFkkrIY4sgs6e/5JOEud7UCPp3pVX0X6F3dEimEKqs1AjBL2CIXkxsE4czlv4v9oY+UvTSIAL/WoKYGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfcEzQD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDBBC4CEEB;
	Sat, 13 Sep 2025 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757767160;
	bh=27K5PyIRRZEppdn66B8GYUNOj3w77ZNWZZ5ujRPMFjQ=;
	h=Subject:To:Cc:From:Date:From;
	b=hfcEzQD8+eewGn/FDK9qjTYmys65qfCvkBY+0QISpCTaLCoVyIZQ62OqyAP/33WyQ
	 h8KcAdpmTDXNG7j1VIzsaG/Mp5J1FayV2hoO21PjJrpmvQ+F974uFG9r8P3czJouxJ
	 KIsfl1Ty7nMfrhlMzpB2pLt15+1OS+JV9lH/vtWc=
Subject: FAILED: patch "[PATCH] mm/damon/lru_sort: avoid divide-by-zero in" failed to apply to 6.6-stable tree
To: yanquanmin1@huawei.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org,wangkefeng.wang@huawei.com,zuoze1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:39:17 +0200
Message-ID: <2025091317-snowsuit-earthen-6ad7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 711f19dfd783ffb37ca4324388b9c4cb87e71363
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091317-snowsuit-earthen-6ad7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 711f19dfd783ffb37ca4324388b9c4cb87e71363 Mon Sep 17 00:00:00 2001
From: Quanmin Yan <yanquanmin1@huawei.com>
Date: Wed, 27 Aug 2025 19:58:57 +0800
Subject: [PATCH] mm/damon/lru_sort: avoid divide-by-zero in
 damon_lru_sort_apply_parameters()

Patch series "mm/damon: avoid divide-by-zero in DAMON module's parameters
application".

DAMON's RECLAIM and LRU_SORT modules perform no validation on
user-configured parameters during application, which may lead to
division-by-zero errors.

Avoid the divide-by-zero by adding validation checks when DAMON modules
attempt to apply the parameters.


This patch (of 2):

During the calculation of 'hot_thres' and 'cold_thres', either
'sample_interval' or 'aggr_interval' is used as the divisor, which may
lead to division-by-zero errors.  Fix it by directly returning -EINVAL
when such a case occurs.  Additionally, since 'aggr_interval' is already
required to be set no smaller than 'sample_interval' in damon_set_attrs(),
only the case where 'sample_interval' is zero needs to be checked.

Link: https://lkml.kernel.org/r/20250827115858.1186261-2-yanquanmin1@huawei.com
Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: ze zuo <zuoze1@huawei.com>
Cc: <stable@vger.kernel.org>	[6.0+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 151a9de5ad8b..b5a5ed16a7a5 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -198,6 +198,11 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_lru_sort_mon_attrs.sample_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		goto out;


