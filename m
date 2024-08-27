Return-Path: <stable+bounces-70515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF308960E85
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4271C22F6F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1D91C4EE6;
	Tue, 27 Aug 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvSKSbbr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A69DDC1;
	Tue, 27 Aug 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770164; cv=none; b=UzX2jv5cKL8CJv7J/+VwDk2hysSs38x6CGOhhKxX5DukX3U68bBbS0gVUkUioLpds3o2VogIL0gTFFeETPcgKxTCRbuh9uWHcCZcQnjmEe3BjxrvPkXTR9U+0+k29DF+3QkPKoR36qwuD+/JFVyGNtjdGuZSqbXqUYEME/C6K9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770164; c=relaxed/simple;
	bh=NouojukfAE/D3q4gkTDorjSZkj5YA4klKFhvUgKczpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGcYjq8GioIutYbVjS4U+PM1ibyPSKl9Jlt8O9pePWQHBNIgWKMzGbOXrK5CsH99bXqzpKsAuI3uGh8g3/Oj42MkAuA+jCCllq/qNQa5k0eTFBltVVdBtD8R/+ebXDlm9hGT7W3Em1L2x06XGrKMs9/5zgzklsPt5zLbCWjRIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvSKSbbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D4AC4AF18;
	Tue, 27 Aug 2024 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770164;
	bh=NouojukfAE/D3q4gkTDorjSZkj5YA4klKFhvUgKczpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvSKSbbrEPzycNa8zoG3ShfYclja3K0Q0r9Ws6FzuJkMoBZRDeLg1Qp2lLFJKK/Tc
	 EapHe8dc+oLA0W7L/g6rV+ir9lu8AglZEStT1iGGD06gFWHwq2BmYV/SyQPACMOvsa
	 ysrTZW/YAIK8iltfQEX2YqLBCWZgPYHSI+MZCFOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 146/341] ionic: prevent pci disable of already disabled device
Date: Tue, 27 Aug 2024 16:36:17 +0200
Message-ID: <20240827143848.976968549@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 13943d6c82730a2a4e40e05d6deaca26a8de0a4d ]

If a reset fails, the PCI device is left in a disabled
state, so don't try to disable it again on driver remove.
This prevents a scary looking WARN trace in the kernel log.

    ionic 0000:2b:00.0: disabling already-disabled device

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index fa4237c27e061..f0a7fde8f7fff 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -217,7 +217,9 @@ static void ionic_clear_pci(struct ionic *ionic)
 {
 	ionic_unmap_bars(ionic);
 	pci_release_regions(ionic->pdev);
-	pci_disable_device(ionic->pdev);
+
+	if (atomic_read(&ionic->pdev->enable_cnt) > 0)
+		pci_disable_device(ionic->pdev);
 }
 
 static int ionic_setup_one(struct ionic *ionic)
-- 
2.43.0




