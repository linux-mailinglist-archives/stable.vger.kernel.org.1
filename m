Return-Path: <stable+bounces-35160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B045A8942AC
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73377282F90
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242FB40876;
	Mon,  1 Apr 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMFojyqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CC63E;
	Mon,  1 Apr 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990498; cv=none; b=JDpafd4bIvxW/7RPOs0rLXk/GtTI5whEykAH6jTjjTfMDoLHQOvfiHEkLmAuNSh53j04KguAw4PKA5cgeBcOxMx6o1Wct0YZ0SK27mUyPTnR+RYY+j3ExN9y5TCOLgu+mUQDbBBIKdXV49SQRgJE5+SrRo3ifW2kIHjL+F2OdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990498; c=relaxed/simple;
	bh=4U95SnD6PeveJQiXPr/QakOVw44MXL1NCzxgVhRfMBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYzHhxITStw39JaCuJlmjn5KBIeUYdA9/+E/IhqE/JN0nJ1PLV26g4HKKPgodSgK82vDUmKYP049x8yieWqt27ZBzU6wnGNpRPFKMeeQsjwGg5jtEoZCwuIabOe23UPkrUS4REcA2TbnHWHMimbpRmvmAigI+8c8kvsF2fE+AH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMFojyqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E55BC433F1;
	Mon,  1 Apr 2024 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990498;
	bh=4U95SnD6PeveJQiXPr/QakOVw44MXL1NCzxgVhRfMBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMFojyqLX3iUPuCDjmYhTiE6V1CvA1NA2N182t+VxjCLQW5anpwEIqXo7fnjUrTRG
	 6SCJ/8OfqrP7rYnSVe4rVI6eUoDRPZ8KOmFwXlDB0ijnEdl6I6Rd+s+cVC5MXqUEBa
	 /WOqnobMz+y0Jr5vhZu6QLe4I/qM44OeoqdRWo/8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 333/396] mmc: core: Avoid negative index with array access
Date: Mon,  1 Apr 2024 17:46:22 +0200
Message-ID: <20240401152557.842030185@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -488,7 +488,7 @@ static int __mmc_blk_ioctl_cmd(struct mm
 	if (idata->flags & MMC_BLK_IOC_DROP)
 		return 0;
 
-	if (idata->flags & MMC_BLK_IOC_SBC)
+	if (idata->flags & MMC_BLK_IOC_SBC && i > 0)
 		prev_idata = idatas[i - 1];
 
 	/*



