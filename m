Return-Path: <stable+bounces-210270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E5D39F3B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AADC130028A6
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFE2652B6;
	Mon, 19 Jan 2026 07:01:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36291D5178;
	Mon, 19 Jan 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806095; cv=none; b=XwbhKGAHwPbAM9W+eDc9HW+Xf7jqV8RQ3Z8YZaMNlqctr7xVd3g8KcNwusgdyC2mm521cRM0lzDPD7rs7M1WnFCfzlliku0XD6yZXHmxa2CaSP9v8MjiVx9XqdNoIbUHFaXhHMgMRtdl/B7qn5YXS9e+NCsb+vkhJigtlDEpeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806095; c=relaxed/simple;
	bh=p++eGDU18qNaDHKlm+MfGwZRNnRdFvBnX9YwVUnfVVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1C24HLuURLEuFV2mo4iCqOCHwoauMzNOnBOg9H2ykrngTZFQ1oAZ/xildfIa0vZ1bAwMq2fOZDXespQ+RBSCkTsh7dIPnXYIFsslFUkxLQaod4I2VcHfMkLe8BwTNm3sNZx2HJ4+pJXYegZHW4rXAmZOPHOrr7DVvFaRonpieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1768806008t6c87112f
X-QQ-Originating-IP: mIAif3bZUK1yQVuig9ts5P1vjtF3dD+EPNao51SynRk=
Received: from w-MS-7E16.trustnetic.com ( [125.120.182.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 Jan 2026 15:00:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12972063070728144324
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: txgbe: remove the redundant data return in SW-FW mailbox
Date: Mon, 19 Jan 2026 14:59:35 +0800
Message-ID: <2914AB0BC6158DDA+20260119065935.6015-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MgQMqdBY7dCn8xClDGMHEXA/3EE0/rkYRG7jmCLIKclwILTm86POhslo
	9IfDlnCb1kHvHkH586egi/ZLFL+WTFRFi2T3PN3Akmyt43RqaLvZ70D0IQuY3xr6F3k8TGb
	XsqJBJWbWa4ALDWXvLKwL05AH1hldANs8MwGHwbR49JGDeYiMowpRGnMdacKeRg4DDUKpl+
	ogeFRVT93olJBbhuVq3pD0BOvrhVWKU+PF3aIqUMPRIgHTdNfpWYjg1n3A2PiuYLMwfYmXT
	SbpYMGTSHYdXCNbwK5PskMSi0+680YQcZqTGV3rW+paG1Xou2tY5hGZsZqaiNjXfX47k8JV
	fXdSwulvphJtkkEiYmC5/ChyRD/0V1/0qS/bazHlv6uXKDZmI9bZZlEUNUwIihuFpqO77cW
	QGo/2xIPNTzdxSa2BhF/am+ZXQLgIGcCSHKv9kVMLq5fXXYzU8Obph68bQYDgNxF1ZOEPIW
	6wzRBVOKd1/R/8rUGU7ElXDi6RmBNNwGuKhogDVCZbPbhbPzXwSL7DIrsoHB71/xBO7ZB6Z
	wVkctOlB6P9v9PIO8LEjUng5SBIxq1syZdmK0YUqWxRiHEivg+3RC2hcdMVTUd8v7ffWEvn
	uf5AN9dGqKBE8OLiUSmJ/z0897s/7yVXwmhXXMBgbhKeMOHWeBLY7iM7c1Dgi7X1YGxOIAz
	cyTeIiJWbeBu/SzQ7PO5QYFv5SLPRu6wa1YZT0Yab4JLbOlxwzKuWnvjwhq4mRwEGvhmISx
	2/J3SgkIhOkSLblG2WzXnyHdseg/Ib0dWy/141bzW8cOfpSCL1Jayz9vDcZI5ikiyUds8R4
	55ry+S1yZbQYlDUcVAtI3/uINwxrNQxsBr9ZL9pYl59bXyLlljaoQNcqY5u04pPYBXzSvRB
	rou1s05YdvGrah+9OF4uOPiMmYC09G71AoPu+LHcPDuy/DnOcKKUVvlRXNtMv2NZl0qlgn1
	wJ0bnlrfYXp0uLrjUkBQLf7CjsH+NBCSE5YcwRCGzmnAtD/cuNutVkQMCFsBPY1wrc4TWyK
	xZPWt3osoPiA1q01VN1hHexaGMu4QB7qJKSbRcf+qLhUIlmX1p79WHPnAQyE9R4gwW08Pa5
	ZMSpBcX83NU7aGGd++mZMeoNafrA5NL/ar+4rwErGH6
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

For these two firmware mailbox commands, in txgbe_test_hostif() and
txgbe_set_phy_link_hostif(), there is no need to read data from the
buffer.

Under the current setting, OEM firmware will cause the driver to fail to
probe. Because OEM firmware returns more link information, with a larger
OEM structure txgbe_hic_ephy_getlink. However, the current driver does
not support the OEM function. So just fix it in the way that does not
involve reading the returned data.

Fixes: d84a3ff9aae8 ("net: txgbe: Restrict the use of mismatched FW versions")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 62d7f47d4f8d..f0514251d4f3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -70,7 +70,7 @@ int txgbe_test_hostif(struct wx *wx)
 	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
 
 	return wx_host_interface_command(wx, (u32 *)&buffer, sizeof(buffer),
-					WX_HI_COMMAND_TIMEOUT, true);
+					 WX_HI_COMMAND_TIMEOUT, false);
 }
 
 int txgbe_read_eeprom_hostif(struct wx *wx,
@@ -148,7 +148,7 @@ static int txgbe_set_phy_link_hostif(struct wx *wx, int speed, int autoneg, int
 	buffer.duplex = duplex;
 
 	return wx_host_interface_command(wx, (u32 *)&buffer, sizeof(buffer),
-					 WX_HI_COMMAND_TIMEOUT, true);
+					 WX_HI_COMMAND_TIMEOUT, false);
 }
 
 static void txgbe_get_link_capabilities(struct wx *wx, int *speed,
-- 
2.48.1


