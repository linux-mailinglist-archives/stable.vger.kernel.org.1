Return-Path: <stable+bounces-38508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3EA8A0EF7
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C99B21939
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43271146582;
	Thu, 11 Apr 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJLR73Ec"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01998140E3D;
	Thu, 11 Apr 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830780; cv=none; b=oq/7lQ6w5JkXV0tnaW3YlISRFAeXClK+KbTzFM/oNCKYzBDuSzNaiI5tOuKK03cATUJTtBfVOONkfhxGtbjXrYCwMWyYYMbn81SQP1VNltci9/a7iUeleJdyi0fBRXS8pGM7QZJkYoXvcx0aZ05K0//v6zU/j8oHTxSE96n55dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830780; c=relaxed/simple;
	bh=IBcSfhkTqOFLtxfH8MBVMYAB/AYVPTbEAF+XSzDXb9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyI2HtBm7V/bhkxyhy6ugHiTUxqGZ29zbshpyoKmxhehEwQ9Tk+Sg7kQg3G4TQIWKUfkhYdbXZzMpi8SkBMhYV+ZBChRzNYVPNTeisEbkKl2MTs9cxjhuCf2oaFNmEV5Ne1T0RLmdAlU5xMlveFmHmZfdaWQ2M35uWMsnXdq5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJLR73Ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFE8C433C7;
	Thu, 11 Apr 2024 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830779;
	bh=IBcSfhkTqOFLtxfH8MBVMYAB/AYVPTbEAF+XSzDXb9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJLR73EcKFAb9GB2Kk8amfMes2zufvKvTr6aON2YMKkJJ1h2hMVX987LB6Udk2jtY
	 qFiwK7n0O6S4+d0zWbofe/5fDeXhyIr6M+OwbZHGasjFxV5tFKkVly5Pe/3nr8iXYN
	 nKJnDTcKKDjO6yb1vSD4lnL6RjxJJc+dlkpcQ3LQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 116/215] mmc: core: Avoid negative index with array access
Date: Thu, 11 Apr 2024 11:55:25 +0200
Message-ID: <20240411095428.391528815@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

From: Mikko Rapeli <mikko.rapeli@linaro.org>

commit cf55a7acd1ed38afe43bba1c8a0935b51d1dc014 upstream.

Commit 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu") assigns
prev_idata = idatas[i - 1], but doesn't check that the iterator i is
greater than zero. Let's fix this by adding a check.

Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
Cc: stable@vger.kernel.org
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://lore.kernel.org/r/20240313133744.2405325-2-mikko.rapeli@linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -511,7 +511,7 @@ static int __mmc_blk_ioctl_cmd(struct mm
 	if (idata->flags & MMC_BLK_IOC_DROP)
 		return 0;
 
-	if (idata->flags & MMC_BLK_IOC_SBC)
+	if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
 		prev_idata = idatas[i - 1];
 
 	/*



