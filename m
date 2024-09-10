Return-Path: <stable+bounces-74153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45941972DC8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783A01C24469
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97467189F58;
	Tue, 10 Sep 2024 09:36:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C676188A17;
	Tue, 10 Sep 2024 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960969; cv=none; b=iOQCHHc0fhslowEOI2qj0HAQC62RYo8x3Tdp8nlxlLEIFdd/bFtLREtCaHFwkGf69quIFRlYemEV3m/qXliNVjRPoyn4EAjdk3wjmcv/ypRuM3C/jCinobqIV+Fl1TouQtNfIKRXgadQPIES76hJ6yxqZk7GF/GYx/v9zKP4Zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960969; c=relaxed/simple;
	bh=FdMFe9gtlF1aJDA4V5LkJ3j5qmcefux4a6b3cQcdVFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lXYNn9hdeOUz21RtYxpnvQTx1chG2cNYQwXHxdeDCXe+1Dlf4X2ouPVNemfw5YZf471POkzWDvzYGvcjKfCr1cr7N8xKVEZtT7V1xCpyWUrdgVdLBNCOSZspOEf8WFLEN4xdPkDb0wuPyvw0+4IhZLigHC7ba7AbA8yI8IoUia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp81t1725960874t5ihnisl
X-QQ-Originating-IP: i3lOYmmirCwzFAmPF2VtF42FLL2djkCP3+pquglGj7o=
Received: from wxdbg.localdomain.com ( [125.118.31.67])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Sep 2024 17:34:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1915074489264835750
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: libwx: fix number of Rx and Tx descriptors
Date: Tue, 10 Sep 2024 17:56:29 +0800
Message-Id: <20240910095629.570674-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The number of transmit and receive descriptors must be a multiple of 128
due to the hardware limitation. If it is set to a multiple of 8 instead of
a multiple 128, the queues will easily be hung.

Cc: stable@vger.kernel.org
Fixes: 883b5984a5d2 ("net: wangxun: add ethtool_ops for ring parameters")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 1d57b047817b..b54bffda027b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -426,9 +426,9 @@ enum WX_MSCA_CMD_value {
 #define WX_MIN_RXD                   128
 #define WX_MIN_TXD                   128
 
-/* Number of Transmit and Receive Descriptors must be a multiple of 8 */
-#define WX_REQ_RX_DESCRIPTOR_MULTIPLE   8
-#define WX_REQ_TX_DESCRIPTOR_MULTIPLE   8
+/* Number of Transmit and Receive Descriptors must be a multiple of 128 */
+#define WX_REQ_RX_DESCRIPTOR_MULTIPLE   128
+#define WX_REQ_TX_DESCRIPTOR_MULTIPLE   128
 
 #define WX_MAX_JUMBO_FRAME_SIZE      9432 /* max payload 9414 */
 #define VMDQ_P(p)                    p
-- 
2.27.0


