Return-Path: <stable+bounces-38335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1A8A0E18
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB14283246
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599E4146017;
	Thu, 11 Apr 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tuAnXJZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A6145323;
	Thu, 11 Apr 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830252; cv=none; b=PihHL2hajTOIVo0GdoLpXyti8BunkdebtGD+aVQspYYkBJE8lfDBaziWsCwQYpMDvW6cWJ+A2GZ4IbJJ/tY7WmhU+fwXck/7Jjl0FIgRLP3GXTbNGhRkKjicytW+pEE95sZ1TYPYVpZGu/LrZ8WBLjMRm8u2qonulJjG7/3bqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830252; c=relaxed/simple;
	bh=ePPYjIddpXi2idukUyF+UG4waKOisoi9VAucoQYen5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKnnycNXUoKXLdk+QXA8BDnrvy7dwVcIwxNrH17S0ed/TpggYzBLzdDnp5TyRBZUYQmB93D12Mmk+gS2mHldnoDPlWyZ1J+R4Kh7SUmOUN9i2OQlEkhcYSU06BmtfUCUVN3HLonFMvoGPnFMJQllxuX4oM3VDh4bO7LR3NRX3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tuAnXJZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E098C43390;
	Thu, 11 Apr 2024 10:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830251;
	bh=ePPYjIddpXi2idukUyF+UG4waKOisoi9VAucoQYen5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tuAnXJZz0xXCiceS4iQdouousAbcapJdl+xSEBQaUV6zAZ2gGb0QLA2mm+58coh0a
	 l5TWzGdSmXvvegp6o/Vsi4TMtNVg8SLM++hSAAHWUfFSwMEPSPVr9xa4HM9RM6OMEJ
	 c4vVez6FGENRxxgOHaoXoNFVss7Pt3ghU3eoCMrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 085/143] i2c: designware: Fix RX FIFO depth define on Wangxun 10Gb NIC
Date: Thu, 11 Apr 2024 11:55:53 +0200
Message-ID: <20240411095423.469841402@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit c94612a72ac87b0337a0d85b9263266776ed4190 ]

I believe RX FIFO depth define 0 is incorrect on Wangxun 10Gb NIC. It
must be at least 1 since code is able to read received data from the
DW_IC_DATA_CMD register.

For now this define is irrelevant since the txgbe_i2c_dw_xfer_quirk()
doesn't use the rx_fifo_depth member variable of struct dw_i2c_dev but
is needed when converting code into generic polling mode implementation.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index a7f6f3eafad7d..ae835000fd32a 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -318,7 +318,7 @@ struct dw_i2c_dev {
 #define AMD_UCSI_INTR_EN			0xd
 
 #define TXGBE_TX_FIFO_DEPTH			4
-#define TXGBE_RX_FIFO_DEPTH			0
+#define TXGBE_RX_FIFO_DEPTH			1
 
 struct i2c_dw_semaphore_callbacks {
 	int	(*probe)(struct dw_i2c_dev *dev);
-- 
2.43.0




