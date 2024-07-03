Return-Path: <stable+bounces-57264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71528925E52
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4806DB26B13
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3C194C6A;
	Wed,  3 Jul 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQ71c01S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00D194A6F;
	Wed,  3 Jul 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004354; cv=none; b=TW6bxUyw8WaqLCt0o31w1o3cFTYEpLOJhVWdF8+VnSJBUh1tPzPDlN21y6rytFxaKFvbYMEVQfXoPF63QTNfYDsZlrdHOi2tCqhQtqsv/d4a8BmHEPhMgpq5wSF4a5Tu48RykJ57VPUzNMndmH5FaTst73CQ3Dxu4o6sbi8aOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004354; c=relaxed/simple;
	bh=KxIXb5F2vcDpAlkeBYm3nvowampcyNG9r9jAD7rGBh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnvIQ7AG/WZ1W9phIj7BAoPh3zbdmfOUaRB4uJDembAaCL6HfbYNBqWP6nl2FjzKt50wHd9AmDwJB0BFbgqVHSfYSKrzzbYg+baVoz6N5I6TB377vEaVqXR4ZWNFSpYRKW6hzi+UQC/inZGPv1CncDHV7BEMFmRmqSjLPQMr9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQ71c01S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF08C4AF0B;
	Wed,  3 Jul 2024 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004354;
	bh=KxIXb5F2vcDpAlkeBYm3nvowampcyNG9r9jAD7rGBh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ71c01SzkxtEkus0qLomnGjAPaFsctO7/F9QXoYNL/J90ixXks1DiD0WLY7EJNS+
	 AtB1WQB+Hi6LEKLtjCkW1YeISVk5FuPCX/ar4JXXH8mygPslyL42QwziXxD6iJJDTo
	 rZtry953pwdUSwoGcjXcvKNsNtRld/1eeWwL0dCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangyu Hua <hbh25y@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 015/290] net: sched: sch_multiq: fix possible OOB write in multiq_tune()
Date: Wed,  3 Jul 2024 12:36:36 +0200
Message-ID: <20240703102904.767697672@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangyu Hua <hbh25y@gmail.com>

[ Upstream commit affc18fdc694190ca7575b9a86632a73b9fe043d ]

q->bands will be assigned to qopt->bands to execute subsequent code logic
after kmalloc. So the old q->bands should not be used in kmalloc.
Otherwise, an out-of-bounds write will occur.

Fixes: c2999f7fb05b ("net: sched: multiq: don't call qdisc_put() while holding tree lock")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Acked-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_multiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 1c6dbcfa89b87..77fd7be3a9cd1 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -185,7 +185,7 @@ static int multiq_tune(struct Qdisc *sch, struct nlattr *opt,
 
 	qopt->bands = qdisc_dev(sch)->real_num_tx_queues;
 
-	removed = kmalloc(sizeof(*removed) * (q->max_bands - q->bands),
+	removed = kmalloc(sizeof(*removed) * (q->max_bands - qopt->bands),
 			  GFP_KERNEL);
 	if (!removed)
 		return -ENOMEM;
-- 
2.43.0




