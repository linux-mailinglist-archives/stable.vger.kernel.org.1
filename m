Return-Path: <stable+bounces-87904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF819ACD1C
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9680FB24FA2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4B212621;
	Wed, 23 Oct 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVLTI632"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBC210C36;
	Wed, 23 Oct 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693949; cv=none; b=E08bFj5tPCEhAoi2YfQWdhuYuzQEbBrYXXqv1SUg7W43uAhvVabgMOWIixV2khl5B4yOVUt9mqLlsiousHoRXKtvcN9/9NsLgWiFnjRk+f0VJwZgS5eSMaXGfb4ZdhoqS30JBGMMUuZ5ZwHvdP/v81tdgr9VIrtRXCJ7fTsyU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693949; c=relaxed/simple;
	bh=01iJzfdSH5shmcZHj4nicWztDj8kW1x4F7WtvsSjWJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYuOFTd5t2uzYHlVqze3XjPx3z9dmMVI12cQDfHSqp7ixgtChIdzIWbabirZsfnIE75qlAN6jgZR6sA6BzpbDIRs+Y64L5juUP/l2x/0VmUdkPdiMtF6vkQClzMIplcpnh4UPZ5KAAG+zJK99q+JvJJdLviFJjQT8+3bToIha1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVLTI632; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A77BC4CEE6;
	Wed, 23 Oct 2024 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693949;
	bh=01iJzfdSH5shmcZHj4nicWztDj8kW1x4F7WtvsSjWJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVLTI632if/8DIQ11g3T60tmQwhJuFLgXi+39uT4ZDLdTMV2lHx1p84xPd996Bv+F
	 nMRLgUA0co5IPsEHagv2OU+CadSGJ9cAFFnmPuyAg4sA78ER6EOxeT7r4yrwFzq6E/
	 ZsiWEMRhpGOsDwzAQ6Eu3InO8VPTqocnTukUc4PvVGq9WFe4F9voTs+Bzre/kPtYEq
	 HslqSVxHQtyTwPsDv8j8eUaP2TQ1zZDaxdCuR2eyHNSueHP5A3TzPFg2InnbS10ymd
	 vhl+ER+z5uSLSRXbCoBZdD3IQRyc6Y/kgHipT38Ze4wGys3YaiBoPH6l4C4ZDLTksU
	 0g1kQkt42FS5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	2639161967 <2639161967@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	chentao@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 16/17] powerpc/powernv: Free name on error in opal_event_init()
Date: Wed, 23 Oct 2024 10:31:55 -0400
Message-ID: <20241023143202.2981992-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
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


