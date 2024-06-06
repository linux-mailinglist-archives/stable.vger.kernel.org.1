Return-Path: <stable+bounces-49112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A08FEBE9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36662B274E0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98911AC237;
	Thu,  6 Jun 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0XuSnOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F371AC242;
	Thu,  6 Jun 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683307; cv=none; b=ii40zGfCslGT2b64b8vxoZ3Aa4U0bfQE+wEC7rg5ol/uS6wNkLr2HYx6INYlEVMXOqXkkjFpL9pp5gZf+6LN3ahHliib2o91p6tvf7qEEUTGDwqqAEEuyYHRL1H5zDCweRHgJ1rD4gZj5y33jxhdxEylk7VysCvJgdzrhu4r9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683307; c=relaxed/simple;
	bh=vlGrCpPvbz5Zx+vqw/v7cUl+Z6abbVLj0MwTdwxs0yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ymi/auacdoR9KLNKrnLfXWvn9GkDjTm1PjxkpnOAJiXnJ8ENMMqNRCiILrl2elT5MOZW086k9m76jwoOOk+fIJ51U+oPxRjoriJNAdJ37bMcizrJqWMPI6FkuCj1fo/oj/BMpr2CQrVTBjlk2il7QN/S2OpYWlcAK0+1ZJFgcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y0XuSnOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CEAC2BD10;
	Thu,  6 Jun 2024 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683307;
	bh=vlGrCpPvbz5Zx+vqw/v7cUl+Z6abbVLj0MwTdwxs0yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0XuSnOGkFDHN9hYpc2k+m4Jj9Ccnsv/KYB/O0roo8v2LKZmYKX/q6pHSOy7uSAMe
	 6Y0JDmFctZqqqafDQ1XKoyqNTn/KiG20faRH70u09IqJyeorBZL6M2LhQgLcX3+0QQ
	 6s+YH2dklOFkcJWlyRhWu58+I/HIoNK3X0gtuOME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 188/473] Bluetooth: qca: Fix error code in qca_read_fw_build_info()
Date: Thu,  6 Jun 2024 16:01:57 +0200
Message-ID: <20240606131706.146119909@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit a189f0ee6685457528db7a36ded3085e5d13ddc3 ]

Return -ENOMEM on allocation failure.  Don't return success.

Fixes: cda0d6a198e2 ("Bluetooth: qca: fix info leak when fetching fw build id")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btqca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index a0fadde993d70..2dda94a0875a6 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -148,8 +148,10 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 	}
 
 	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
-	if (!build_label)
+	if (!build_label) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	hci_set_fw_info(hdev, "%s", build_label);
 
-- 
2.43.0




