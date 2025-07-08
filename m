Return-Path: <stable+bounces-160712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3079AFD181
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9082541C81
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341D2E54BD;
	Tue,  8 Jul 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdfcLVLU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB220766C;
	Tue,  8 Jul 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992472; cv=none; b=ePt8ft3fOAphx3INnfFvxIgxlqEcEV892x9XU5UWUWZnIs0Jo4BMWV/PSOlw/JoBjF/Z47L2ioLSH9ta0IAS4O7tKvo/7R6GFZ2qZkl8XH3KBcla0clAAAye1mhaFJfARAfBv4z/E81rkTvDMv7U6RSIkvbSDKmBKtbXcE06xIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992472; c=relaxed/simple;
	bh=NE5XQyzBabE/KcL82HPVESIOrG/cFNdzfhgA0OchW+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slSfQRznN3UVeCYBvhNfhVTvjnsrl50nxOE5Hdu9vfii6Nr1zwTGwqdmoqgpo9X7Jh3QLIYTuSKOpu6NEkv9C38toG0byh7cKNvEWHdr8yiW2rV6oIWziN9Je5jffPKW6OabcuaccAjh1qrGVY3m5XyU8kW5d1psbiw2BM06qCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdfcLVLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F4C4CEED;
	Tue,  8 Jul 2025 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992471;
	bh=NE5XQyzBabE/KcL82HPVESIOrG/cFNdzfhgA0OchW+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdfcLVLUhIyHWYnpj/6T4+gRjp4yj8MpBBiD4X2GFY+JrJOV30RJMuCLLmj/llOq5
	 LnkNtieIe31u9bOT4IJ/1KUnPA181O0vDnpV6sgZIcu1ojJL3vpGhiViLR9TaHe5jr
	 lwLXHCZdnnQG+P/kBEwpXVRcbtBsY6WasaibS/LQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 102/132] platform/x86: hp-bioscfg: Fix class device unregistration
Date: Tue,  8 Jul 2025 18:23:33 +0200
Message-ID: <20250708162233.590999685@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kurt Borja <kuurtb@gmail.com>

[ Upstream commit 11cba4793b95df3bc192149a6eb044f69aa0b99e ]

Devices under the firmware_attributes_class do not have unique a dev_t.
Therefore, device_unregister() should be used instead of
device_destroy(), since the latter may match any device with a given
dev_t.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250625-dest-fix-v1-1-3a0f342312bb@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 049851e469f60..b62b158cffd85 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -1039,7 +1039,7 @@ static int __init hp_init(void)
 	release_attributes_data();
 
 err_destroy_classdev:
-	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
+	device_unregister(bioscfg_drv.class_dev);
 
 err_unregister_class:
 	hp_exit_attr_set_interface();
@@ -1050,7 +1050,7 @@ static int __init hp_init(void)
 static void __exit hp_exit(void)
 {
 	release_attributes_data();
-	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
+	device_unregister(bioscfg_drv.class_dev);
 
 	hp_exit_attr_set_interface();
 }
-- 
2.39.5




