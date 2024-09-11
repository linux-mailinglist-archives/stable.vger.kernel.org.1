Return-Path: <stable+bounces-75863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF297584F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A69B28BAD
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BE91B1D53;
	Wed, 11 Sep 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="H/6NBs0R"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A81AED3D
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071817; cv=none; b=HJM4Ajb9WV/OXX6TkRvUX/E1cjtzIBsrj1wc93recho7V3SPZLAc89CcdGiAnO3yWl0DE3OnaTkeDqyGSa4v8qJ/F8bvjvPa0enpLKRm3h2a9CPFWO66Zzs416Jvfo7PqeInmH5NA2YvUtZ9h8NZEJG7TxwXjcN89Oo3e7wj/K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071817; c=relaxed/simple;
	bh=bmnetQMbTu9hnH0bwUNDYDayE3gIdFC+cuiYFhpzl6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZB0dnqE2b+K8zCy7JTeDiM8TG8966Gkp7IZ29ZdU3OjBV2zPaTa4Ji/LWIo7xy1+znOIodiPtWoLg1O8I52dxXCp+Tk8RNenVaBdnBuAd4s4Z38TdwstpWo3EdQ1pSkcJLs0DKIczXA13jnFutdmK5s/NLtHP4d6Bkn1t7QqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=H/6NBs0R; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202409111623275cf212bb3e18658a5e
        for <stable@vger.kernel.org>;
        Wed, 11 Sep 2024 18:23:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7ZUSL9956dMTKl4lPB2nJCaF8a0We09ZgJjxtb1B5Vc=;
 b=H/6NBs0R54sg0eiFuEVwndwNsW9dIT3HjAukgPWPFCL7xIZVR1ISXkwoqwGHWd+beGa9MP
 3dq3q24r3e9vrjdZD3y4oGVwyKyU/jgN66fKyJ/NB5JWEiNS+p7NEPPeeUYXoniXXIgty0Tz
 ME3OW8jvApyseHuutT7Y5v4K7CsaZ7V3p4CYOFFgh8GxIm9GOWw7cIMIszK1bzABlvH4bwoQ
 FHr+TJy3GIXpUHpLa7Gh6b+h8iKRpgFVutDQv3zUiKu/rFFOrCQzjXjd1GQ85BrgEJAEy8Xn
 F/sZWxmwC7eXfCGmecwjcUjRSLjGiejwdTxq+71eknO87QOAT/wkMqyA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: stable@vger.kernel.org,
	asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 6.1 2/2] io_uring/io-wq: inherit cpuset of cgroup in io worker
Date: Wed, 11 Sep 2024 18:23:16 +0200
Message-Id: <20240911162316.516725-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240911162316.516725-1-felix.moessbauer@siemens.com>
References: <20240911162316.516725-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

commit 84eacf177faa605853c58e5b1c0d9544b88c16fd upstream.

The io worker threads are userland threads that just never exit to the
userland. By that, they are also assigned to a cgroup (the group of the
creating task).

When creating a new io worker, this worker should inherit the cpuset
of the cgroup.

Fixes: da64d6db3bd3 ("io_uring: One wqe per wq")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 io_uring/io-wq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index c74bcc8d2f06..04265bf8d319 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1157,6 +1157,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 {
 	int ret, node, i;
 	struct io_wq *wq;
+	cpumask_var_t allowed_mask;
 
 	if (WARN_ON_ONCE(!data->free_work || !data->do_work))
 		return ERR_PTR(-EINVAL);
@@ -1176,6 +1177,9 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	wq->do_work = data->do_work;
 
 	ret = -ENOMEM;
+	if (!alloc_cpumask_var(&allowed_mask, GFP_KERNEL))
+		goto err;
+	cpuset_cpus_allowed(current, allowed_mask);
 	for_each_node(node) {
 		struct io_wqe *wqe;
 		int alloc_node = node;
@@ -1188,7 +1192,8 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		wq->wqes[node] = wqe;
 		if (!alloc_cpumask_var(&wqe->cpu_mask, GFP_KERNEL))
 			goto err;
-		cpumask_copy(wqe->cpu_mask, cpumask_of_node(node));
+		if (!cpumask_and(wqe->cpu_mask, cpumask_of_node(node), allowed_mask))
+			cpumask_copy(wqe->cpu_mask, allowed_mask);
 		wqe->node = alloc_node;
 		wqe->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 		wqe->acct[IO_WQ_ACCT_UNBOUND].max_workers =
@@ -1222,6 +1227,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 		free_cpumask_var(wq->wqes[node]->cpu_mask);
 		kfree(wq->wqes[node]);
 	}
+	free_cpumask_var(allowed_mask);
 err_wq:
 	kfree(wq);
 	return ERR_PTR(ret);
-- 
2.39.2


