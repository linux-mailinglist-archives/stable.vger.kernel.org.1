Return-Path: <stable+bounces-96237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA499E1712
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E70C16105B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E21DE4DF;
	Tue,  3 Dec 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nj9tWnOE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD017F4F2
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217580; cv=none; b=OaldDJtjm/azr50QJ2v6zgJ/gpyBIGdeZJ1oin+o3IXnof56GZAOfSjPteougn8P/TawXPDMBvAY5ZdhBhh8Ebi/oqPdPMqhic5R6IpRzS6MGAjuH/qe7VQW0hlqkBSYFH7hIl68+KN8YWo5UD9ePmVrA9p6fAmPnbks4LPOg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217580; c=relaxed/simple;
	bh=qT13oOuH2mdBgPYOI2dLIebYwYCHq0OIPpnDNDkltns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MvKg/CQdNfikaSHGuDM5To2GGCeUa4YOqOrPZZlJ74qGzXwAyiZPAaiLVWmoB6tlqhjg5aXuk4qXBHGP5YgDvE36bRtwlOsZz6c2pHiuLD0mso8QnFpGrBHAUntBmY5cs6mISlcY5eYKeXH/201z288FymccOW+x6zCPqUw/QVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nj9tWnOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310D8C4CED6;
	Tue,  3 Dec 2024 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217579;
	bh=qT13oOuH2mdBgPYOI2dLIebYwYCHq0OIPpnDNDkltns=;
	h=Subject:To:Cc:From:Date:From;
	b=Nj9tWnOEDT0xzfgviJat9T3f/+0KVHebhaStpjDylq43ImL72s8kg6tD3/nf7ZdvP
	 8Tz5XGvhZTQ9aYbCg9hB+PgiQET0/YeCGi/m+QyfyzQYKke2rbDj79vbFSW+1GCVxi
	 F8Kd00Vuj2rfHSVnYQhPQDL9yKtTX8PEeYnqWu1E=
Subject: FAILED: patch "[PATCH] spi: stm32: fix missing device mode capability in stm32mp25" failed to apply to 6.11-stable tree
To: alain.volmat@foss.st.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 10:19:28 +0100
Message-ID: <2024120328-contently-dramatize-24a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 941584e2f3ddde26e4d71941ebc0836ece181594
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120328-contently-dramatize-24a8@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 941584e2f3ddde26e4d71941ebc0836ece181594 Mon Sep 17 00:00:00 2001
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Thu, 10 Oct 2024 15:33:03 +0200
Subject: [PATCH] spi: stm32: fix missing device mode capability in stm32mp25

The STM32MP25 SOC has capability to behave in device mode however
missing .has_device_mode within its stm32mp25_spi_cfg structure leads
to not being able to enable the device mode.

Fixes: f6cd66231aa5 ("spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Link: https://patch.msgid.link/20241010-spi-mp25-device-fix-v2-1-d13920de473d@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index f2dd8ab12df8..da3517d7102d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2044,6 +2044,7 @@ static const struct stm32_spi_cfg stm32mp25_spi_cfg = {
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
 	.has_fifo = true,
 	.prevent_dma_burst = true,
+	.has_device_mode = true,
 };
 
 static const struct of_device_id stm32_spi_of_match[] = {


