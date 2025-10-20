Return-Path: <stable+bounces-188141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B5BF2249
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D758427371
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9026CE06;
	Mon, 20 Oct 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft2ilYGt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98688266576
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974679; cv=none; b=LP9xT8NdlYvnypBZVnEu2Qegapv9MprTq/g8biU9bEY2TKIHDpI3BJi+zlxg1Phl82oZHdfTIzHwnetLL2rCFcM0lnT16Y/Fp1nlRyUXRZb/jwEEZfMC+YJqQJ7KIaBQVHTDNzrH+JDprLA4m/6Q/adNAb48nC4J9dkaW5z0StA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974679; c=relaxed/simple;
	bh=unb2DnMMG2XdlVn6h10GAqX3fHkUc8q2LvNm5daS2tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9IdqO1hVe1KoOBK/DT0rw6ZBFUEC5f9MQxQg+oVYaQLiNfdT/L9PRUb7pR6udC4KwGGI4zttODdUa8Fxls1WrdtED36Rgm9vmmNlaD7ycdehYZwJrN/Uq0U6WqCemus5/IbxodBd6X3wW/l9zG6InoaHbtDyzIIzHsawFPWiKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft2ilYGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9B9C4CEF9;
	Mon, 20 Oct 2025 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974678;
	bh=unb2DnMMG2XdlVn6h10GAqX3fHkUc8q2LvNm5daS2tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ft2ilYGt2ILAnscuXpdYfRquX7D8GYD5yYwQ+bReYT2H/fESpU5/lmXQKlwkPyEog
	 FyB0/0vEumPCs78fjBiKW7kWt62seL+ER66UqDQmZCt6S2xzls0cjqpTcmBHZiDQwU
	 HAFK12moh3i3P/ofeyVMJs1jDyc921v1GKlVTr7P0dS187amsW6pv9bzF/HLMWLG27
	 GcAb8q0/SE69PgijWdj8+nOUseEsEorsZarxyA4Rs4/uAv3hlA0lsrGCGvCI35DBPs
	 f5CZDcqt1xNiF7FKI5DnAXY1kDvKODsnTQs4ccvyoB0nCH9mIQ9cUtWxSSuUP3hDKZ
	 zu2THutOH0bhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] padata: Reset next CPU when reorder sequence wraps around
Date: Mon, 20 Oct 2025 11:37:54 -0400
Message-ID: <20251020153754.1820697-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101650-feline-ellipse-6256@gregkh>
References: <2025101650-feline-ellipse-6256@gregkh>
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
[ relocated fix from padata_reorder() function to padata_find_next() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 93cd7704ab63e..9260ab0b39eb5 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -290,7 +290,11 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
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


