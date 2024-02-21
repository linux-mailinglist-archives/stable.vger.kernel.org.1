Return-Path: <stable+bounces-22958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC29785DE6D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43E61C23BB1
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE47C0BA;
	Wed, 21 Feb 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbkG1e5A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF67BB1F;
	Wed, 21 Feb 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525086; cv=none; b=gSjumfjqwFyO5lm35JV85bcDD3olBpw+urANxm3UmDLX16TDxnNDcWatzslFDy6VvUd5cuTCwBp9ZbXJibXhUndAbAd8CToArSloMgItZWYIOB7YVeYEDtgMrpECmTxp7o2UVU9YdYje+Gt1LGWYCsEg2H0S1h0qRy2nQ+SMY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525086; c=relaxed/simple;
	bh=wCBwiOPdPJnaevFNVTj0S4GVvPd1rpvgqskgQkTZYD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL1ipn5B9cM/yplv81+kyD2zyCEfj6jKP8IvudwIWJP/rlia0j0oDLTNg1Pm31jQ49u0nssac5MLSmH/+K9dBOeqAbArbkjXM6NisTmPM1Q4RUcmbvTzDH5s2giMqOIQ9xQyfaLMm99JAW/DlUSorW9Ds3ytvNgBylh/QiQYXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbkG1e5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE61C433C7;
	Wed, 21 Feb 2024 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525086;
	bh=wCBwiOPdPJnaevFNVTj0S4GVvPd1rpvgqskgQkTZYD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbkG1e5Aj2ja01+aSh/CXbkdwixXO146loyOZu9SR3xWYuaur3R9+2GwMI9NuJvvB
	 HyASw8sUHonBDHB5YDxDoEN4jJoKqu0n4sGrk9v48BySmV2yXZ7rfRu664qSoQfzJ1
	 vkGkql/mnz4adufbF9k2DnibhsXeO57Lp7brgvC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 057/267] spi: bcm-qspi: fix SFDP BFPT read by usig mspi read
Date: Wed, 21 Feb 2024 14:06:38 +0100
Message-ID: <20240221125941.800856178@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kamal.dasu@broadcom.com>

[ Upstream commit 574bf7bbe83794a902679846770f75a9b7f28176 ]

SFDP read shall use the mspi reads when using the bcm_qspi_exec_mem_op()
call. This fixes SFDP parameter page read failures seen with parts that
now use SFDP protocol to read the basic flash parameter table.

Fixes: 5f195ee7d830 ("spi: bcm-qspi: Implement the spi_mem interface")
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://msgid.link/r/20240109210033.43249-1-kamal.dasu@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 118d9161a788..b4032d1e7c98 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include "spi-bcm-qspi.h"
@@ -976,7 +976,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 
 	/* non-aligned and very short transfers are handled by MSPI */
 	if (!IS_ALIGNED((uintptr_t)addr, 4) || !IS_ALIGNED((uintptr_t)buf, 4) ||
-	    len < 4)
+	    len < 4 || op->cmd.opcode == SPINOR_OP_RDSFDP)
 		mspi_read = true;
 
 	if (!has_bspi(qspi) || mspi_read)
-- 
2.43.0




