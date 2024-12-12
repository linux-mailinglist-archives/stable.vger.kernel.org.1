Return-Path: <stable+bounces-103153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82629EF625
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4A1188D7F1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9B216E14;
	Thu, 12 Dec 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O57nKSeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65622330D;
	Thu, 12 Dec 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023704; cv=none; b=cPKNsrRrpZlwGJgWRnlU03hbf8B3vO7H9T190JQkIq2caI6kl+gMuruDeTL9sEI+3ceKUeix7R4O+KQ+Ofy+YHNHZowQV49GnXeFPPNzNF9yr8meCu0MhyXxt/Cycr9bszAhKrhTjBF6tiU/uOMXFRLOaUb+ClJtTx9/KmvP3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023704; c=relaxed/simple;
	bh=Sy5w069IoTpGhW7NA9GM+eTqO3RXpvC5QMPwkhF5sSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpo43Spiq0YZeGht1HwLT3j6fQM56NKOg7z9k53CY3qglWeulCFtizieJVg1cR9iT/PF+1rwYqlmx2ZaMe42zYDDqsDhZYCyjVKtwxSTtjMnQw80IDUlv+fTJU5pAg3WYTHbjc/VwM83KPDxV5A3MnbskoyhHwJNQ7sFFbbC0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O57nKSeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F88AC4CECE;
	Thu, 12 Dec 2024 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023704;
	bh=Sy5w069IoTpGhW7NA9GM+eTqO3RXpvC5QMPwkhF5sSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O57nKSegsu8O11LilWyYK4+zzMc7Iub6AiyJIRehr5GACmQvQ4N9UWMpWhmXInw66
	 TSneqaOw0UqgKHq05yP4WvOaYs8UBdt1YHawFxFZqlI/Fhm1Bi71AGGjP3w/jA7G92
	 46h7p3rNnFyf5PPS0HbYNtHe6UXjCMykrlf9lcK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Yingliang <yangyingliang@huawei.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 024/459] mmc: core: fix return value check in devm_mmc_alloc_host()
Date: Thu, 12 Dec 2024 15:56:02 +0100
Message-ID: <20241212144254.480026240@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

commit 71d04535e853305a76853b28a01512a62006351d upstream.

mmc_alloc_host() returns NULL pointer not PTR_ERR(), if it
fails, so replace the IS_ERR() check with NULL pointer check.

In commit 418f7c2de133 ("mmc: meson-gx: use devm_mmc_alloc_host"),
it checks NULL pointer not PTR_ERR, if devm_mmc_alloc_host() fails,
so make it to return NULL pointer to keep same with mmc_alloc_host(),
the drivers don't need to change the error handle when switch to
use devm_mmc_alloc_host().

Fixes: 80df83c2c57e ("mmc: core: add devm_mmc_alloc_host")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/20230217024333.4018279-1-yangyingliang@huawei.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/host.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -523,12 +523,12 @@ struct mmc_host *devm_mmc_alloc_host(str
 
 	dr = devres_alloc(devm_mmc_host_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	host = mmc_alloc_host(extra, dev);
-	if (IS_ERR(host)) {
+	if (!host) {
 		devres_free(dr);
-		return host;
+		return NULL;
 	}
 
 	*dr = host;



