Return-Path: <stable+bounces-188145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D291BF22BE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1942E3A98AF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F70254848;
	Mon, 20 Oct 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrY25NUL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E986352
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974894; cv=none; b=ZWaoP9ISrtFSJwKvY+3UTHCLJaLI4ddgWynefOQpD1l8Rrj1ayG73ITcNfoRdLtZA1M1nt+3E6sSFLRGjkSUir2dijrf3oQ1AzhJ0cb47Tt7CtVWIL0hbHlUlt339XPXePvicitOpXSGIELHoXr3NSqpQbT9WV53vASFYIY/K0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974894; c=relaxed/simple;
	bh=472B7Su6xh59A1f1Yr4wYTxlruKi5N3VqXuNR1AFTUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlzPjhXN4+F8Yc/IVyqX2Fluf8XeSONajghhgayY8CR17LDQ6wQwc2Q7Qj8pGPb/Vk/wlQZknHeIkVZ4sjt+mo/sfs6n1cw/l3fRlIaJjnk/bUemT3CTeuQyxtIbLYoyu3Si/q3m2PpsXuQeZVoGrOdeAckZa2mAKzeGIHS/Qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrY25NUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8200C4CEF9;
	Mon, 20 Oct 2025 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760974894;
	bh=472B7Su6xh59A1f1Yr4wYTxlruKi5N3VqXuNR1AFTUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrY25NULSZUdVaQ4fVf7QaKdNFg3KY3XdS7kirbUISdTw/Ci1RCoSAYKef89YNZMu
	 fyRi/KVaeqwHRlLCZgrLeilreL4XeWqUbNq2vYThwCIuIT+t6c9VpTOtBq6bhNVRhD
	 AViV2d4LUrSZ6UZmYoAAb7v7RnQMJn/nhZolUXSuvnycIzZZD+wcZMJVX3xS1PbeSW
	 Pl/WJL97V42HlgQ5KwRpQeksvDM+caxpb0qeIrOfS+00r1Vuv3y43pw9kH0RbaqzaM
	 VkUyLLZfpjTedz3MenwM5ZtH8IGrgRyVosbqVw0UmBfdSQMbFaChJ4WMY/xFqvkH2C
	 a2cTIhoAhXX6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] padata: Reset next CPU when reorder sequence wraps around
Date: Mon, 20 Oct 2025 11:41:31 -0400
Message-ID: <20251020154131.1822336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101651-kerosene-quartered-684e@gregkh>
References: <2025101651-kerosene-quartered-684e@gregkh>
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
[ moved from padata_reorder() to padata_find_next() function ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 47aebcda65d5d..409d242284397 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -204,7 +204,11 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 		list_del_init(&padata->list);
 		atomic_dec(&pd->reorder_objects);
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


