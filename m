Return-Path: <stable+bounces-247170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIoHJJK2BWpZaAIAu9opvQ
	(envelope-from <stable+bounces-247170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:48:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A20541358
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C01305814E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E943393DDA;
	Thu, 14 May 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuoJplq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B237756C
	for <stable@vger.kernel.org>; Thu, 14 May 2026 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759142; cv=none; b=YPQZDywGXVQKRIidflGLsMd/sizKpsQtIBBksZigddysyQDOlDCf/zna/lhr/Q7mO4MV9dEgwSyrmnHAgDs7MqQbF790v0xitg4hFGFO62V/45YlJ2a9qEUTLCrK9zTgGwodhe59T32L7uUXq/5PE8GQl8gqBCEJs+QZUEHX+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759142; c=relaxed/simple;
	bh=rBPMvVR2Fg9jVOFFFBICj5h2yCUvxq/G3LOVBFpNynk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzJpLng2HJzuSonjuXZ1sJNJTcWFi2PWbdUtXVlTW/KkN86w+ZhMnvA8H618VDAk7kJkqgfCMbpBJlaZ664m5vELvawQyootwsV5OTu3IRoSnCE0h5WSTX9a/sDpsN6x49iAnFJZi+iNbwgdXK4xtLGF9GBbCYYnVoKMMKsr62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuoJplq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58B2C2BCB8;
	Thu, 14 May 2026 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759142;
	bh=rBPMvVR2Fg9jVOFFFBICj5h2yCUvxq/G3LOVBFpNynk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuoJplq9Br9BvJJ2wV9E9an21+gpOlIBGILI9//4zjAYEO2CGZ1Po3df3hkXBO1gQ
	 CsOwuygoNQPg5Dy0Dpii91vUaGOP+U+Y8BYnInwj07REprFJWQyCDLdNGnbIajDNkG
	 OR0LduOvHPX39NINSXSr0Ysdzx6ygxyyuxt9HBdmSB3RCM7an8BCeHH1VrVfYHhE8Y
	 EZY7cR8mstnVBurakLhAySdpaszTchA/VH4MXWFNZrjBsAlWk2roslq/3lJgQcTNjV
	 JPNAnttCt7IcaqiqFfKbIsxmpZzMcigstPq+/orJUhbjBc7qhVzWgox11PPChopPkr
	 rpYbomLMF9QHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zeng Heng <zengheng4@huawei.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mtd: spi-nor: core: fix implicit declaration warning
Date: Thu, 14 May 2026 07:45:39 -0400
Message-ID: <20260514114540.178942-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051244-bonelike-likewise-bea8@gregkh>
References: <2026051244-bonelike-likewise-bea8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5A20541358
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247170-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Action: no action

From: Zeng Heng <zengheng4@huawei.com>

[ Upstream commit 25e3f30601a368642678744fc8a9b1dce183c7bc ]

spi-nor/core.c needs to include linux/delay.h,
or it would raise below compile warning:

drivers/mtd/spi-nor/core.c: In function ‘spi_nor_soft_reset’:
drivers/mtd/spi-nor/core.c:2779:2: error: implicit declaration of function ‘usleep_range’ [-Werror=implicit-function-declaration]
 2779 |  usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
      |  ^~~~~~~~~~~~

Fixes: d73ee7534cc5 ("mtd: spi-nor: core: perform a Soft Reset on shutdown")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20220923031457.56103-1-zengheng4@huawei.com
Stable-dep-of: e47029b977e7 ("mtd: spi-nor: debugfs: fix out-of-bounds read in spi_nor_params_show()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 91622d9c9b032..ea8d0e2cb64da 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -16,6 +16,7 @@
 #include <linux/math64.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/of_platform.h>
-- 
2.53.0


