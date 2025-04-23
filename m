Return-Path: <stable+bounces-135380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16543A98DEF
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DB1444CC6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B2280A22;
	Wed, 23 Apr 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/8wqblE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CE281352;
	Wed, 23 Apr 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419771; cv=none; b=kfqLjt2f/7l5Lj55NOp5fVMKZ/cKvmPRi2bnwva7IbxpOxopu+AZJCt/NNMjkQSas4akx/DWF9M1l+3yAPBH1T3+dh/bdc6imZj3k+fq3nlovxT5BhCRcM+89t1iLpsZRNFLBB7kR2GeVMPwuUoY8auCc4nzTyA6g0gLyG0XgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419771; c=relaxed/simple;
	bh=sNgj27d/QjENJDM+g2y7WRDGgMStaDRN7GhqvMkCPps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIPbybzK0Hxw50pIGp1cX0j/zvfrAM6O+xXDzXyGogJu9hnaOxXncC8oBfGBuNeJBKpsfMV2+n4EFox5QenyC0OmQZ0aY5uNdXF4nFM6ydf0bQWDfWcD9FOhKu8K5heFI+ZaCbLHz5vuQBzjAavfdUGz6/2e6X1O5VjOJFCtLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/8wqblE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214DAC4CEE2;
	Wed, 23 Apr 2025 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419771;
	bh=sNgj27d/QjENJDM+g2y7WRDGgMStaDRN7GhqvMkCPps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/8wqblEDRAJP4vjkfVUzmZ4J54g09GPSOFAwRcUGVCxZ4afZ3wM5caU/Br0MplkX
	 rV5gDr8IZfPjjfBNo6UJyDRmhHiqOUM+xsu2GxvmEzhBQEixi0Flndo/Fvy63kfQqK
	 7N49CbIbyXV/BTdpqUnGmZt6x/49jEo+9WKoxRWM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 024/241] Bluetooth: btrtl: Prevent potential NULL dereference
Date: Wed, 23 Apr 2025 16:41:28 +0200
Message-ID: <20250423142621.508588042@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 324dddea321078a6eeb535c2bff5257be74c9799 ]

The btrtl_initialize() function checks that rtl_load_file() either
had an error or it loaded a zero length file.  However, if it loaded
a zero length file then the error code is not set correctly.  It
results in an error pointer vs NULL bug, followed by a NULL pointer
dereference.  This was detected by Smatch:

drivers/bluetooth/btrtl.c:592 btrtl_initialize() warn: passing zero to 'ERR_PTR'

Fixes: 26503ad25de8 ("Bluetooth: btrtl: split the device initialization into smaller parts")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btrtl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d3eba0d4a57d3..7838c89e529e0 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1215,6 +1215,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			rtl_dev_err(hdev, "mandatory config file %s not found",
 				    btrtl_dev->ic_info->cfg_name);
 			ret = btrtl_dev->cfg_len;
+			if (!ret)
+				ret = -EINVAL;
 			goto err_free;
 		}
 	}
-- 
2.39.5




