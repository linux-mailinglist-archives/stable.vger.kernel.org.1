Return-Path: <stable+bounces-186102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28DBE3914
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F219A2070
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE403002C9;
	Thu, 16 Oct 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xFm5GME1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93A1C32FF
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619698; cv=none; b=bt2cn89Ru4XoXB7W3Q2HooTVpQP1teBLGGqvLkFDOmQbxPhpCMU+JzM3Y95NJQk1ReXjmN1aB2b2FLXeytaKwxyPsPO4vdi5viN9fbWNpebDEYw3YQHMT+GTWe1k/FJBffGGnbkE3YwHH7tpmGAhN7TaX297XHZITUDBa9SXR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619698; c=relaxed/simple;
	bh=lEWbPucVDXa2l54NAxljPPxJX614ploKWIztmOP/vcw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T8yvozfJ1eY7jRMoAJCsVcgPBjMnbgbwixNqb0GmHEbJy7gt00zqu1Asg5J5A+j4eqQfxcycRz2bFAe//fXs71S0ooRxoMoUihizuPm7z3KH9NqyOim8a9xLPacDBswtw8fpgUDPSIxz0LufU7tMw2VlsDmqelrQLqMCAZikyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xFm5GME1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EF6C4CEF1;
	Thu, 16 Oct 2025 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619697;
	bh=lEWbPucVDXa2l54NAxljPPxJX614ploKWIztmOP/vcw=;
	h=Subject:To:Cc:From:Date:From;
	b=xFm5GME1qH9F8hgwf9zZbeivfiEqdSvcQWR6BH1LTPzlBg6t3DqFTvXgL/AnrJ6nW
	 eUNytp2/n9Xi+KllIHD6r4Z7LjAqiM6BHzcG6GxtmJAXjqLrjzoolPTtPfm/dQxshH
	 Eqe9MI8CDzwg4aF47JAs/EWtKAvOgcxuPTosYIA8=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: Flush posted register writes before DAC" failed to apply to 5.10-stable tree
To: pratyush@kernel.org,broonie@kernel.org,s-k6@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:01:34 +0200
Message-ID: <2025101634-glare-unrivaled-70bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1ad55767e77a853c98752ed1e33b68049a243bd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101634-glare-unrivaled-70bf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


