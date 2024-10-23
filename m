Return-Path: <stable+bounces-87915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BED9ACD3B
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918651C21224
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBE215017;
	Wed, 23 Oct 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7MN7GM0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72762215013;
	Wed, 23 Oct 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693973; cv=none; b=SaYwm7QvKV259giEbLRpQ3KvkQ/yKg8Btkcd+goI0Rn7PXqV5fsg9uENasMJASr6Q952EeWlrq3PjXs21S9p4JfmBDqabuzBnSLDB0LJlnqB80jDHdf78Pyff198AnwxvanPj6MyapRPsi2n6QQQLPlet6NOaAFwrxerrS0a40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693973; c=relaxed/simple;
	bh=01iJzfdSH5shmcZHj4nicWztDj8kW1x4F7WtvsSjWJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSsaOl4/TsAkt6EUBM4BxVjEst3UhymNP2xReZDELoj3wLSuAppZ+172bTrDCOYDSU9mu7zQD5+WnFRAlSx6tDlhKg0gQzjkIK5n9EcI1HDCdlFTo77hwUhF9cXe1/tbGANz0NlMqDK//Z4nfP2tK0pdudktP6/kco5TBWc5p98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7MN7GM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872E7C4CEE4;
	Wed, 23 Oct 2024 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693973;
	bh=01iJzfdSH5shmcZHj4nicWztDj8kW1x4F7WtvsSjWJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7MN7GM0ITXYJ6hGuX3ei4MHvLbhU5m8ykNgx7Nth/DYLYVt/zNh/mGIKc3PIwCF/
	 HoREnQRs2kivX0eLX6yWtyCOu4JGsfo84LEbduH7dWbdETBUtgoUt+NVR2icRXyigh
	 r4VFo3V9FH+KtlX7BecxFRdiioFwG3THlQU+WWM54Lz2c71xJIgL2Ab1kPkR7lcUZM
	 5vstDvKEjbHn6CgXd38YjhAm6lSVi/3SKtavDAUueKKRAGRhRpKcRC9CX8fjZP5bmF
	 Rl7Ye1B93BbdpRsaDL09kilE3kG1jr6TOQ/99H66z+/jik6S/BPDYVOoqV9jcbjSzZ
	 ewNfEX70Je4xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	2639161967 <2639161967@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	chentao@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 10/10] powerpc/powernv: Free name on error in opal_event_init()
Date: Wed, 23 Oct 2024 10:32:31 -0400
Message-ID: <20241023143235.2982363-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143235.2982363-1-sashal@kernel.org>
References: <20241023143235.2982363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit cf8989d20d64ad702a6210c11a0347ebf3852aa7 ]

In opal_event_init() if request_irq() fails name is not freed, leading
to a memory leak. The code only runs at boot time, there's no way for a
user to trigger it, so there's no security impact.

Fix the leak by freeing name in the error path.

Reported-by: 2639161967 <2639161967@qq.com>
Closes: https://lore.kernel.org/linuxppc-dev/87wmjp3wig.fsf@mail.lhotse
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20240920093520.67997-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 391f505352007..e9849d70aee4a 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -282,6 +282,7 @@ int __init opal_event_init(void)
 				 name, NULL);
 		if (rc) {
 			pr_warn("Error %d requesting OPAL irq %d\n", rc, (int)r->start);
+			kfree(name);
 			continue;
 		}
 	}
-- 
2.43.0


