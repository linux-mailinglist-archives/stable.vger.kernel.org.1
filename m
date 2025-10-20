Return-Path: <stable+bounces-188143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124EBF2261
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340171895396
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C991DE3A5;
	Mon, 20 Oct 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6VsKSNq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618186352
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974800; cv=none; b=sGikG22gkZOkOE3MvsuanAlf1SdmfuUHm3koGTf3Y1WYEA7FIJT+8COJh4YdGy7PHt/IUjJisIx40Umq4iikOTscuJpAbIHKoo6PabacG4Vh4Fmzcf7roeX4aH5kpVTkbZWMpyEIeMflfOL+GtZhepMbTv+2eesWFO2zCBf/K3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974800; c=relaxed/simple;
	bh=/XAq4jJsST6dPwiqKxpDhP6WKE5JhVyYuruRqTuPzfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU+10MnGNrut65bwUqvSyWgk5a4bT3yQoMZJae2oo2D+BXg+dQJ8e3aEtDjeTwLRKXqVrrMseIUGQ1QLww3s9SMaMki4Eui8wlR64/eKSq9NQZpe7/OD+eJACCuqdas22p1FYRyQ8fpHW2UpI/EI1dnDl80UQprC+x6YA0N3DHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6VsKSNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A6CC4CEF9;
	Mon, 20 Oct 2025 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974799;
	bh=/XAq4jJsST6dPwiqKxpDhP6WKE5JhVyYuruRqTuPzfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6VsKSNqyr1/UYhb1IoORe+/cwiRSjUNorxQ/Cigc8EFf4XX5U/O5ul6lB32y+aKb
	 kUljJ/OS7QYumyNgiLxqzUERM45y9B3NcnSl/I7FDlrNEGUGrcbN1lUSruYL5x+wxa
	 6TRgjUbiyCu7bfGSIR2ILZdLSi9DIh7HfQM4EzjwEFfm5g54zZtdXCvSoUKnqNNgjq
	 3q9QKbLX49bEwmN4uBenLbW5uFD3BnrjHZT17IPtWGPla0V75OSzb2lY+/p61wdYrb
	 NKl6hIU7yyzLw+brc4tCzWQhcyP+mwx8lj/u/LFAN3fD3BAmYG7FwHU+8gpTBlIy+0
	 5y98RR5tan3Cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] padata: Reset next CPU when reorder sequence wraps around
Date: Mon, 20 Oct 2025 11:39:57 -0400
Message-ID: <20251020153957.1821339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101651-unlimited-rippling-daa6@gregkh>
References: <2025101651-unlimited-rippling-daa6@gregkh>
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
[ moved fix from padata_reorder() to padata_find_next() and adapted cpumask_next_wrap() to 4-argument signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index b443e19e64cf8..5453f57509067 100644
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


