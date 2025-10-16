Return-Path: <stable+bounces-186103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E9BE394F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6400508D3F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838AA1C32FF;
	Thu, 16 Oct 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i319MNaJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354431CD1F
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619707; cv=none; b=pckOBA4cj1+oHkXiegXGuVo6sKwNRXI1EdlpXPN9E3hyB6U5+9Qr1RkYcOWY9z5vFOWwPJHt8BksHN2JsSyIggOJALzk94kCT3HO9n1Ow49qOiV8KOCEjlOhyW7HknWWdHvft0lxZ73fcYYNt1taxIA0+LYA6n5Vqvfc5SXJEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619707; c=relaxed/simple;
	bh=p8J3bgFm/JZDPGqWN8scnMKB9Nv93boKWIyapkN9Rjs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dtWiQBNUngiNXLCGkITCKVvSfbqfiOh96y1/8K8GmBffrmdFPnikYuoRTPM8DmVZ0/Cj2gr5tySjBNP2fA1IWqSDnpnlf42aLxjbFwB0NyF6AIYd/sS8QKjyrtGCwW0f3LzBuMyaGya3PhI6sOdgvZIrqH/AhxpHb8e7tvizHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i319MNaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB8DC4CEF1;
	Thu, 16 Oct 2025 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619705;
	bh=p8J3bgFm/JZDPGqWN8scnMKB9Nv93boKWIyapkN9Rjs=;
	h=Subject:To:Cc:From:Date:From;
	b=i319MNaJRTYQcZMON/GLPkTIBFeF0VVZ8U6Hqj5AJ6rTdBOVnQ5UAMdAfh7oqWVoL
	 r2T2lDxhz22fc7gjEGZTwdxB8dDXc7g+h+JhLj6D2MoVbNP/RhmCxzeF90KxjtT2YT
	 lMlrtnsMawS/Bkpv3SUgNMy6uwyvg1rOiRXQePrM=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: Flush posted register writes before DAC" failed to apply to 5.4-stable tree
To: pratyush@kernel.org,broonie@kernel.org,s-k6@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:01:35 +0200
Message-ID: <2025101635-laurel-crawling-2104@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1ad55767e77a853c98752ed1e33b68049a243bd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101635-laurel-crawling-2104@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ad55767e77a853c98752ed1e33b68049a243bd7 Mon Sep 17 00:00:00 2001
From: Pratyush Yadav <pratyush@kernel.org>
Date: Sat, 6 Sep 2025 00:29:56 +0530
Subject: [PATCH] spi: cadence-quadspi: Flush posted register writes before DAC
 access

cqspi_read_setup() and cqspi_write_setup() program the address width as
the last step in the setup. This is likely to be immediately followed by
a DAC region read/write. On TI K3 SoCs the DAC region is on a different
endpoint from the register region. This means that the order of the two
operations is not guaranteed, and they might be reordered at the
interconnect level. It is possible that the DAC read/write goes through
before the address width update goes through. In this situation if the
previous command used a different address width the OSPI command is sent
with the wrong number of address bytes, resulting in an invalid command
and undefined behavior.

Read back the size register to make sure the write gets flushed before
accessing the DAC region.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
CC: stable@vger.kernel.org
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Message-ID: <20250905185958.3575037-3-s-k6@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index eaf9a0f522d5..447a32a08a93 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -719,6 +719,7 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 
@@ -1063,6 +1064,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
 	reg |= (op->addr.nbytes - 1);
 	writel(reg, reg_base + CQSPI_REG_SIZE);
+	readl(reg_base + CQSPI_REG_SIZE); /* Flush posted write. */
 	return 0;
 }
 


