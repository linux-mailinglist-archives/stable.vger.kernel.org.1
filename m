Return-Path: <stable+bounces-70587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72534960EEC
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADC21F24ADD
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E041C6F52;
	Tue, 27 Aug 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CPxi+FNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC801C68B9;
	Tue, 27 Aug 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770403; cv=none; b=CdRJSU4JSbE1F8gns8dg8WXzrZGr0r+xJRFYLsWWk0iCeNYeFpDAEYVCM4/A2V+A+/ycE3aAPWXl9nkovsBiUTWDi+m9U+aOC6H2OkMQfHl8MEhCOhHDQqIe82K12VALvRs8gdpPPYPC+FMWGPUUJ7LO6rvPfWisw4MBq3B4nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770403; c=relaxed/simple;
	bh=1inr30y1vMcQIZHQEhNxtGpNoO6NUvvjmUWKTlxIG/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ail9u5BOSPcYsG/oaYtH55+nl9w/CvCCrqlVCsTdNj+XyUdhvyoF4LsjS7RVvd+u0jckSeYa56ICy5o+L4i+toLpjYKx9irh1ME06vW8XKc/yora1jQe5EwA8vP33YRsxyMWyJTQ/k58j7KrvoP4vdT1N+ubG6uFbhzChRHvcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPxi+FNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A897C61050;
	Tue, 27 Aug 2024 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770402;
	bh=1inr30y1vMcQIZHQEhNxtGpNoO6NUvvjmUWKTlxIG/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPxi+FNU64bYk2lZZWD2EWAkdCW/fV6gCuJ0jY5r5CVifPWaJ2cHuqzUYX73jS032
	 6Rw38ED9eKIJBAAKuAA8/AoTrN7/zhfsqKq/M/KmHNFKXAYWii0CKm8VE2eBWpWGWb
	 oq4MBjS+Pj5wud3vmfjZKyTrvoT/0b5cOMqhyFgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brett Creeley <brett.creeley@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 217/341] ionic: use pci_is_enabled not open code
Date: Tue, 27 Aug 2024 16:37:28 +0200
Message-ID: <20240827143851.669381437@linuxfoundation.org>
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

[ Upstream commit 121e4dcba3700b30e63f25203d09ddfccbab4a09 ]

Since there is a utility available for this, use
the API rather than open code.

Fixes: 13943d6c8273 ("ionic: prevent pci disable of already disabled device")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index a5fa49fd21390..35099ad5eccc8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -223,7 +223,7 @@ static void ionic_clear_pci(struct ionic *ionic)
 	ionic_unmap_bars(ionic);
 	pci_release_regions(ionic->pdev);
 
-	if (atomic_read(&ionic->pdev->enable_cnt) > 0)
+	if (pci_is_enabled(ionic->pdev))
 		pci_disable_device(ionic->pdev);
 }
 
-- 
2.43.0




