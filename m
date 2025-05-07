Return-Path: <stable+bounces-142572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DCAAEB31
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326AF7BF9A8
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1328DF5A;
	Wed,  7 May 2025 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+pBvvFW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BD28DF2A;
	Wed,  7 May 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644669; cv=none; b=tDmOXGo4hOdS44Mm7zlQKKZxVYRDHV1kiWQFHOKe73IIwcKQ1o77BwmIEKe0Wl7Zml92qLvWggHs+RtWyPvOTrukgp51PMA7asuz2hf4k9hhAJ9y1f41rvr/mhu8fd5ZCRiVlan3rFeaxyxQm0QliEdeN7ANusucQWE/FacpNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644669; c=relaxed/simple;
	bh=34beBP9m68sHVjO0ymGoIhjKTOaNxG9SUt9IycYCHEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHQXkor0W5y5b/qL/lg5ba0m8Z2fHvbQjyyudHn6qqGx6Z+NEoJT6Q7EZQXzBTxvEvtmggJBMRrvktO+zoSfAYOyFD4mCx4XFGSbt7CeB/MOuD/lyx4EOXO4IU5lKhvIVFQQQiP87TVLtHfmj/6/j+Sfn2eqLGuUlsf1OOXVaXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+pBvvFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C149C4CEE2;
	Wed,  7 May 2025 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644668;
	bh=34beBP9m68sHVjO0ymGoIhjKTOaNxG9SUt9IycYCHEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+pBvvFWZ8qEMxIijOWXgNDAdy94J61c7ZK/3uxJoxErJFwlExn3EBFBUvl6aMVf0
	 zWfAQERlWTIymdkAAmhZwJESDJ6U5IT88p2Ad16/Lba7ywoRjxP0Q6LyGAQJBVeE2Y
	 iThm2QqRMDpOL801OB1TFXG+dpeCsN2PbeAuGyz0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shannon Nelson <shannon.nelson@amd.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 090/164] pds_core: remove write-after-free of client_id
Date: Wed,  7 May 2025 20:39:35 +0200
Message-ID: <20250507183824.608082913@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit dfd76010f8e821b66116dec3c7d90dd2403d1396 ]

A use-after-free error popped up in stress testing:

[Mon Apr 21 21:21:33 2025] BUG: KFENCE: use-after-free write in pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
[Mon Apr 21 21:21:33 2025] Use-after-free write at 0x000000007013ecd1 (in kfence-#47):
[Mon Apr 21 21:21:33 2025]  pdsc_auxbus_dev_del+0xef/0x160 [pds_core]
[Mon Apr 21 21:21:33 2025]  pdsc_remove+0xc0/0x1b0 [pds_core]
[Mon Apr 21 21:21:33 2025]  pci_device_remove+0x24/0x70
[Mon Apr 21 21:21:33 2025]  device_release_driver_internal+0x11f/0x180
[Mon Apr 21 21:21:33 2025]  driver_detach+0x45/0x80
[Mon Apr 21 21:21:33 2025]  bus_remove_driver+0x83/0xe0
[Mon Apr 21 21:21:33 2025]  pci_unregister_driver+0x1a/0x80

The actual device uninit usually happens on a separate thread
scheduled after this code runs, but there is no guarantee of order
of thread execution, so this could be a problem.  There's no
actual need to clear the client_id at this point, so simply
remove the offending code.

Fixes: 10659034c622 ("pds_core: add the aux client API")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250425203857.71547-1-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 4d3387bebe6a4..889a18962270a 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -186,7 +186,6 @@ void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
 	pds_client_unregister(pf, padev->client_id);
 	auxiliary_device_delete(&padev->aux_dev);
 	auxiliary_device_uninit(&padev->aux_dev);
-	padev->client_id = 0;
 	*pd_ptr = NULL;
 
 	mutex_unlock(&pf->config_lock);
-- 
2.39.5




