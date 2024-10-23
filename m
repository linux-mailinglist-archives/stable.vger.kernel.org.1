Return-Path: <stable+bounces-87885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62B79ACCE7
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0F1F263FD
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6F5205AD7;
	Wed, 23 Oct 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+xX+4jn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAB204F62;
	Wed, 23 Oct 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693910; cv=none; b=bxKLTLgKyBN513Qe3Xbza9sEbm5ez/ZkUVvPdfHypXB/cma+ihj3AmNnwn0uuJJ7FJKyUSGBRxYsaINQfjadnXi6Q1tA4jCKEBGo9Z2MdIVzHvMq2RqCwnA26ABCyCo72iKHqZsExWF2N/L3+E58B8tsEOdKeH1rqfi9xs4ZX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693910; c=relaxed/simple;
	bh=ZDtV8Qyy4tkPd4t6rHAqBBHuwolPefaey8Kua1fEOgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpVArQUKrwdm8sYwPC75YQDGOb26zGwvz7TrNWGEPLDWInEbo8wpc6GBzbqdFeY0bR+/DWO+lhVJH3Oh4M0yUeG7DHKG2QE0S8K2rIMS50jd3aFaRFLfffXUqjP2GsyWFLJzRhDODSuZl2rHOsPa9CvzxKnfFyLxTa8rGFFq0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+xX+4jn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1E0C4CECD;
	Wed, 23 Oct 2024 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693910;
	bh=ZDtV8Qyy4tkPd4t6rHAqBBHuwolPefaey8Kua1fEOgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+xX+4jnRTZRlxSwBDM9Kl+yO35uknbGEiWDAvYfUSGr2AUTlD1HhEkEbYkHLevw8
	 LtLueEznPkiZBwpiLGzi9t+DBzldnobP6ZuUy9TLJR65eMiOhd5gMKN0BWyy0pVDuc
	 tacX05HZMjgciNklFYw1YlMfIB31157bg+BIdT7GfYVcWT/SCteGBjK7dIMlONmTz8
	 CnA4AXXPlcigMURZBx/4edUAgLroYjTNLHdawZ874/pEg+G/83wqd1TIpouOY+9xPw
	 TmaaALeX6evZyRInQ/sB3ctwf+3skBIkRP/bDhlDC0UHAp5QpkfxbYQ5uKUY/Mb48l
	 yuKvPjoF1FERA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	2639161967 <2639161967@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	chentao@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 20/23] powerpc/powernv: Free name on error in opal_event_init()
Date: Wed, 23 Oct 2024 10:31:04 -0400
Message-ID: <20241023143116.2981369-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
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
index 56a1f7ce78d2c..d92759c21fae9 100644
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


