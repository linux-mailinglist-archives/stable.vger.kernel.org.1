Return-Path: <stable+bounces-22646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B285DD0C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E421C2275D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C737BB1B;
	Wed, 21 Feb 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YqRpksc6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAB78B7C;
	Wed, 21 Feb 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524035; cv=none; b=jAXjFKjlE+6bEtVhaSIAJU13pry2WdgpXcEgA0m11W7YV/4hgZ9qSy5Lc/z4sWPpIzU83Er9hL44DpjR6Gfy6MPGAUflI1a2xq6it90VH04Z9h5TWcbNojyhBZFc7lq4qy47/FAXZQjsarWm4BpRo5a/fpxRS83QDPsF5OqA858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524035; c=relaxed/simple;
	bh=a609K5upoLcs+ZqWFJeN068anj/8nS1IXaNqGi/kQbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcrqRXPcUb7RfUwlO0Dcej/M4YCr2jOmVjiwCM4uWGaTba9iIxJlw3dCEOWV11DFN+LgEzRHbamLXOA1S8Sk5B5g2P/X9K15t9jIfoHftWTuytCedNMcrXoXf+mKpV6c/o3Cvz+FGfhDBni2JGnSpdGFbfjp1NSpknvRymB/INc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YqRpksc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1786C433C7;
	Wed, 21 Feb 2024 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524035;
	bh=a609K5upoLcs+ZqWFJeN068anj/8nS1IXaNqGi/kQbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqRpksc6Qcj36QlI5j0Fhc8HI0vM8S2tuiSA/aA+9FrkgHEzEibdyxkQGIhMz7prC
	 IE5ilFYqWzgLzhmzloZGyvFrytLYYYW4YJz0TYN3+DC+LT6KLQsT0qKA6GJHN8vC81
	 dpP+dagWaORbEC+okqQTSk//MJTGEUJp5dTv+K58=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 097/379] spi: bcm-qspi: fix SFDP BFPT read by usig mspi read
Date: Wed, 21 Feb 2024 14:04:36 +0100
Message-ID: <20240221125957.792424067@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 2c734ea0784b..898658ab1dcd 100644
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
@@ -1048,7 +1048,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 
 	/* non-aligned and very short transfers are handled by MSPI */
 	if (!IS_ALIGNED((uintptr_t)addr, 4) || !IS_ALIGNED((uintptr_t)buf, 4) ||
-	    len < 4)
+	    len < 4 || op->cmd.opcode == SPINOR_OP_RDSFDP)
 		mspi_read = true;
 
 	if (!has_bspi(qspi) || mspi_read)
-- 
2.43.0




