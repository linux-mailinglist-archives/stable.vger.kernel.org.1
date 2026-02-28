Return-Path: <stable+bounces-220444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK0LCCE3o2lh+gQAu9opvQ
	(envelope-from <stable+bounces-220444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A781D1C629C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D42325E145
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EEA3B6CA7;
	Sat, 28 Feb 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl8WVQsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EC3B6CA0;
	Sat, 28 Feb 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300333; cv=none; b=Mujs7U52z2C24oXg7lXzYULBladwcrmS2JDySbTRPOh4P5IERew7zVYvwiIL/WuZvWpgjuCkgS2nVdLBELcRx49anLFwYRjMIjs6ehbHU2BvBU94Wu5rmsQdc/rwrENCsYv8zeulTCqsUNT3QEsm4AgYp8gLy/B3waZXvRuwrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300333; c=relaxed/simple;
	bh=dUjo4k5J/KvXhmTqVg7UMWfUV5hSPL6zhpvc9ge/hx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9ZfZ3n+AO5AMeax07DBJn6V7s0Fl2KYJsCyKvLI7Jl/w0JepZQtpAwmdWWJklUlMD/iM+Fc6Y4mqdJEjVMgkhc1fCo2PWpMs67VAuzswNRcmx1HiFlUYBn0e9Ai5154+EOz48tFtjGMHktxaN1zvXYESllR1wA1dnJVX5nM9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl8WVQsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3137DC116D0;
	Sat, 28 Feb 2026 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300332;
	bh=dUjo4k5J/KvXhmTqVg7UMWfUV5hSPL6zhpvc9ge/hx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cl8WVQsXNdEEvR0wasKmmwKJVImFwKdANh6tvOGSiXaFwn5J+qklCyK2heOJ6+1cY
	 phhZacxj2sf5CPX/mEMaY4r5a3pC6bCXfY4DaK88M1jgezhokbUm/gwYdP0z8By6VS
	 S5rC7Lizo4l+ONi2sp+KUFGQH21JQSQnqRqvUVxE7zHGA7NjQ9XeRnhzDHVyc9fCDk
	 VfORP6vZKLOUVycfLUH7XBIeZRnjRUERjHWogePROPajVbG95jArObMNWuaAcZAsSP
	 yitqA+sAjBjHg4OL18gvvgAlg6TRM/vZ1L+r4c3hRTccuBInKVFzCJa/tlTkGKFGIc
	 fQas/O/Dp6DDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 365/844] dmaengine: stm32-dma3: use module_platform_driver
Date: Sat, 28 Feb 2026 12:24:38 -0500
Message-ID: <20260228173244.1509663-366-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220444-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A781D1C629C
X-Rspamd-Action: no action

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

[ Upstream commit 0d41ed4ea496fabbb4dc21171e32d9a924c2a661 ]

Without module_platform_driver(), stm32-dma3 doesn't have a
module_exit procedure. Once stm32-dma3 module is inserted, it
can't be removed, marked busy.
Use module_platform_driver() instead of subsys_initcall() to register
(insmod) and unregister (rmmod) stm32-dma3 driver.

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://patch.msgid.link/20251121-dma3_improv-v2-1-76a207b13ea6@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/stm32/stm32-dma3.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 50e7106c5cb73..9500164c8f688 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1914,12 +1914,7 @@ static struct platform_driver stm32_dma3_driver = {
 	},
 };
 
-static int __init stm32_dma3_init(void)
-{
-	return platform_driver_register(&stm32_dma3_driver);
-}
-
-subsys_initcall(stm32_dma3_init);
+module_platform_driver(stm32_dma3_driver);
 
 MODULE_DESCRIPTION("STM32 DMA3 controller driver");
 MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@foss.st.com>");
-- 
2.51.0


