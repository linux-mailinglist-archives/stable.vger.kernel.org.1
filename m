Return-Path: <stable+bounces-66328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B8E94DE61
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 22:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4ABFB21B9D
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526D13D523;
	Sat, 10 Aug 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsqvoY2Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C23200A3;
	Sat, 10 Aug 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320057; cv=none; b=Ev08Jvb1mmhRcjxlHoL+nbrgk6odp3nRk/MViJGfKEqE3psEND6/jT90+5iql6zHGjIeA0A4BCEDrFXivJXtqDRrir4Hd2si2fWCmggMF6NBssaR/eGEBdcV9RNQ5E7V7aS6ysL+2k2/ogwGsDz3dsp5jrKBGed0L5WTS6O1+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320057; c=relaxed/simple;
	bh=fjM7Ja8K79kwkQ2MC6WZl8VEdzyTtr5c7wks7Z7H1jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzI6EUJKgr0Vi6gBuwSa0+w5sq2yHqBpuBuxkQz1tX/zXOplfANrBXpmojvud58RbgaD+U/RwwAl7JXE7zxd7q4ejQKS57cFDIPIViYLKOQxk9F8jqRzzBrNZ/CoLXWY3QU70hJ05Zvf4MqvrKMkDiBYnhYk5gjXO0SvElTaqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsqvoY2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A309C4AF0C;
	Sat, 10 Aug 2024 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320057;
	bh=fjM7Ja8K79kwkQ2MC6WZl8VEdzyTtr5c7wks7Z7H1jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsqvoY2YvfN3xaILraIy1FmVbfteZ3zeIHWDQ/FBHaz7F8J00lkDgQ4BN0alX+eCO
	 EPxBy/f0+wNtJCLNjhz8WB4I3NtDcUzf5xtlyu4HTJslKgU1fspMND3IRealn5g3EV
	 y7zKT/6DT9v6m8LNqLwa+yzznjSbi3cfyiYCNkMqj+aLvepIFWDBdChL7kMa/VuZjq
	 cvtkm8Y1AbOnFq26VU06e6afDbHlGgH0LC1OGZGTs4OjD8ooZuDC6dsvl5CY8wGDqr
	 fdvPQqTTQhRu6lsxYhaktM5YgmXUnwRAnzBycSnctcIaiwHfaH33E70pJtyxWxwbuU
	 35w71opAmIT9w==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Chuck Lever <chuck.lever@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 07/18] NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
Date: Sat, 10 Aug 2024 15:59:58 -0400
Message-ID: <20240810200009.9882-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 5ec39944f874e1ecc09f624a70dfaa8ac3bf9d08 ]

In function ‘export_stats_init’,
    inlined from ‘svc_export_alloc’ at fs/nfsd/export.c:866:6:
fs/nfsd/export.c:337:16: warning: ‘nfsd_percpu_counters_init’ accessing 40 bytes in a region of size 0 [-Wstringop-overflow=]
  337 |         return nfsd_percpu_counters_init(&stats->counter, EXP_STATS_COUNTERS_NUM);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/nfsd/export.c:337:16: note: referencing argument 1 of type ‘struct percpu_counter[0]’
fs/nfsd/stats.h: In function ‘svc_export_alloc’:
fs/nfsd/stats.h:40:5: note: in a call to function ‘nfsd_percpu_counters_init’
   40 | int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 93483ac5fec6 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/stats.c | 2 +-
 fs/nfsd/stats.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 777e24e5da33..1fe6488a1cf9 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -74,7 +74,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 
 DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
 {
 	int i, err = 0;
 
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 9b43dc3d9991..c3abe1830da5 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -36,9 +36,9 @@ extern struct nfsd_stats	nfsdstats;
 
 extern struct svc_stat		nfsd_svcstats;
 
-int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
-void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
+int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
+void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
 int nfsd_stat_init(void);
 void nfsd_stat_shutdown(void);
 
-- 
2.45.1


