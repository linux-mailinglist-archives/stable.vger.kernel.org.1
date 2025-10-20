Return-Path: <stable+bounces-188142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1EABF224F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D89C34DA68
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49D86352;
	Mon, 20 Oct 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghuFIDao"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E503DDC5
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974756; cv=none; b=YIAerN+kGgOHCPyyuM1K6j2aFRnKMyfrJ2ldkzKABvjrBht+axlOfoRv0HLNyx/edjJiVuOf0qq4+sqfapst73EgR6X+sjc1hoSvtOfakHSHSekqWyO6TRTlln8l2NhS0xKg/gZWKQmY19O0SM5eOD21+JEnAEhVw+lBglpmiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974756; c=relaxed/simple;
	bh=GbuxPeQMwS9oGj90SYOXOii9DWOCB/BYzH4BmGZssnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryhw0wD6fHH0V1ltzLhGRtxMxbhbdRX1+0zBUjqfSnfdg3tCphX27Pyjhl5bC2GQ7Lh5L8zNZaFea5DubhEgO2+4t8GvGyVRTTP7AZziOJAQTfBlb1ZXa19TwaEVMROybhbeSlwvSo8hWM5d1xRLIrjoznJ/LX2oNSiKYVFFcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghuFIDao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4005CC4CEF9;
	Mon, 20 Oct 2025 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974754;
	bh=GbuxPeQMwS9oGj90SYOXOii9DWOCB/BYzH4BmGZssnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghuFIDao5bRaHw4TQts6ItytJlGbCdh2IM2643jFXw1h2PJicrtczAnqY0+zmIqx5
	 FgBajXH48nkIz4B6jNojcp0Marlbjx+L+rdKfpHMd1LSTQWdjJm0tb4+EdrCgRo83L
	 ze2wAG+s4RAlGzpkpxJIhiaE6tHPPRn8RDv+KDgOi+1gcet+L3hneFhkC820eX2Boi
	 UmTm9wt8GNvbyxTm0M0M5zm8BGAwCgdlMayN2rtu5G9btQDKmbkRucOWOzkjtfxM9v
	 f3/DHoFv9G5FH1q5l7DAUz/kWb1e5AaYr3nC5AhzUWGBZCMZDVuZlErCMr5Aq8WMNS
	 oqFovTVoCcGvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] padata: Reset next CPU when reorder sequence wraps around
Date: Mon, 20 Oct 2025 11:39:11 -0400
Message-ID: <20251020153911.1821042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101650-dreamless-dry-49d5@gregkh>
References: <2025101650-dreamless-dry-49d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiao Liang <shaw.leon@gmail.com>

[ Upstream commit 501302d5cee0d8e8ec2c4a5919c37e0df9abc99b ]

When seq_nr wraps around, the next reorder job with seq 0 is hashed to
the first CPU in padata_do_serial(). Correspondingly, need reset pd->cpu
to the first one when pd->processed wraps around. Otherwise, if the
number of used CPUs is not a power of 2, padata_find_next() will be
checking a wrong list, hence deadlock.

Fixes: 6fc4dbcf0276 ("padata: Replace delayed timer with immediate workqueue in padata_reorder")
Cc: <stable@vger.kernel.org>
Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[ applied fix in padata_find_next() instead of padata_reorder() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index b3f79f23060c1..d49f97abe086f 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -282,7 +282,11 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	if (remove_object) {
 		list_del_init(&padata->list);
 		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
+		/* When sequence wraps around, reset to the first CPU. */
+		if (unlikely(pd->processed == 0))
+			pd->cpu = cpumask_first(pd->cpumask.pcpu);
+		else
+			pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
 	}
 
 	spin_unlock(&reorder->lock);
-- 
2.51.0


