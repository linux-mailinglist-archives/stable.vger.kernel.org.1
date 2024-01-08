Return-Path: <stable+bounces-10224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 978018273CB
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D2DB227BB
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A5524A8;
	Mon,  8 Jan 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1CEuSf13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104251C5C;
	Mon,  8 Jan 2024 15:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A19BC43395;
	Mon,  8 Jan 2024 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728377;
	bh=3daXzXOKqVf6Vn04Hw6DcGcVzAYTtPqsEEUh/WeWw34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1CEuSf13G1JnjyMPvCVDtakgiLMjW9Hg1L9uF2QyTu11paopLt96KhFn1xEPN1SPh
	 Lfa5XmxDRQ2WBjLPsm8Ru1ZWnmJ/oS663kfopestDNMO2nfainlh8WejuZlggVa3ux
	 3e1bhUnBI8QDQz3pTJJ2Bf2aJJ20vdsA6j6XAxGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/150] r8169: Fix PCI error on system resume
Date: Mon,  8 Jan 2024 16:34:40 +0100
Message-ID: <20240108153512.602436904@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 9c476269bff2908a20930c58085bf0b05ebd569a ]

Some r8168 NICs stop working upon system resume:

[  688.051096] r8169 0000:02:00.1 enp2s0f1: rtl_ep_ocp_read_cond == 0 (loop: 10, delay: 10000).
[  688.175131] r8169 0000:02:00.1 enp2s0f1: Link is Down
...
[  691.534611] r8169 0000:02:00.1 enp2s0f1: PCI error (cmd = 0x0407, status_errs = 0x0000)

Not sure if it's related, but those NICs have a BMC device at function
0:
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Realtek RealManage BMC [10ec:816e] (rev 1a)

Trial and error shows that increase the loop wait on
rtl_ep_ocp_read_cond to 30 can eliminate the issue, so let
rtl8168ep_driver_start() to wait a bit longer.

Fixes: e6d6ca6e1204 ("r8169: Add support for another RTL8168FP")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d22457f2cf9cf..06663c11ca96d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1145,7 +1145,7 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
 {
 	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
 	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
-	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 10);
+	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
 }
 
 static void rtl8168_driver_start(struct rtl8169_private *tp)
-- 
2.43.0




