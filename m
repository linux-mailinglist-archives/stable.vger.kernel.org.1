Return-Path: <stable+bounces-177089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D193B4033F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB825426DC
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A526056D;
	Tue,  2 Sep 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HcFyrgdP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EC3054E0;
	Tue,  2 Sep 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819541; cv=none; b=g3VGv4CgKlNHd36Z25RGf74V0kYmWb365zP0DuCNBxT1/+224iIEJu+VZO0eb3XJagVbtDvXrwlmIWQXg5k49FOIzUbO6YfBkdSGfkZ9+AUi5y8SzEjvSGFj/kDcMEynxtBffRQOBG7DAR0nusU+Cc1jPCD+p68OFo9G88Sx478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819541; c=relaxed/simple;
	bh=WtZhv3zHZk0SoY/5G/3qjjReeSBX8rN1q+Z0+EelwI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8O0LiKdrNXCwZEWOnJDqH7hk6zFuV8zepJa9o9+4oG5Vbfkdop2xvfXhAId3EDu5EmV5N9EzycpOYm9Bvs2FMBkzp6DVw844FHOE2d/FZ86ZU4zkpgWuTegL5TPS8vzOVNeLd/jkUkzvDDHoGWD/ZjaimFwcnMu44yvKgbPlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HcFyrgdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5092C4CEED;
	Tue,  2 Sep 2025 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819541;
	bh=WtZhv3zHZk0SoY/5G/3qjjReeSBX8rN1q+Z0+EelwI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcFyrgdPxzuNAdkF1gUQ0QYSRtWezRoby1ULL6c/Vz5B1Cut6d96S5R/IrFLgi4zs
	 eplqtYpOyuJrTXTxZ3Xkfc72a9Ha7pC/hIZmFkezlZyv0ux9Ccb4ZeHmoTJwgy0Arf
	 pxlai5F9g+YuSgRm147Lyqmz5WmJQj8fNa6ZK3H8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 033/142] HID: intel-thc-hid: Intel-quicki2c: Enhance driver re-install flow
Date: Tue,  2 Sep 2025 15:18:55 +0200
Message-ID: <20250902131949.413183424@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Even Xu <even.xu@intel.com>

[ Upstream commit afa17a09c699410113199dc15256c6ea2b4133f7 ]

After driver module is removed and during re-install stage, if there
is continueous user touching on the screen, it is a risk impacting
THC hardware initialization which causes driver installation failure.

This patch enhances this flow by quiescing the external touch
interrupt after driver is removed which keeps THC hardware
ignore external interrupt during this remove and re-install stage.

Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Fixes: 66b59bfce6d9 ("HID: intel-thc-hid: intel-quicki2c: Complete THC QuickI2C driver")
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 8a8c4a46f9270..142e5c40192ea 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -406,6 +406,7 @@ static struct quicki2c_device *quicki2c_dev_init(struct pci_dev *pdev, void __io
  */
 static void quicki2c_dev_deinit(struct quicki2c_device *qcdev)
 {
+	thc_interrupt_quiesce(qcdev->thc_hw, true);
 	thc_interrupt_enable(qcdev->thc_hw, false);
 	thc_ltr_unconfig(qcdev->thc_hw);
 
-- 
2.50.1




