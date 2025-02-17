Return-Path: <stable+bounces-115383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E8A3437D
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD093AEE0B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BC245027;
	Thu, 13 Feb 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mAOLNshZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADE245022;
	Thu, 13 Feb 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457862; cv=none; b=PpX4oq46HKnFP61BeUEHpU9Y6Rt8QqzhMJgYa3/NGob7CxdipwtFEXtDWFx8Idfz6qPGbTtriQDaJWRHkQVPH1pFsXuadOOkK8LtzmVZO9dMcuv6f8fyE5DQtYOCc3IGgH8ZAARUsmU6kUbXHVle8eF3EnCVyL/k59KuEq0Vy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457862; c=relaxed/simple;
	bh=lKxnZaKD0Z710uAW4v5Bpk2EO5DcCr0F5DIkCDpHsF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHILBqxQPSt2dTKj4fLiMiibiKHzZ/PkqAqvv8LrezILokSSnclFudAlkk1JbAJCuoFniNn4brs81BbaOE0ASyx2GDUABOmcJHW2JwAv+0ZT69DCZG49es+6g912zAMS2zXGy36DG6xhwJqSEd0bkB+0kFgrvY5w4L4b6YjkzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mAOLNshZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43216C4CEE4;
	Thu, 13 Feb 2025 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457862;
	bh=lKxnZaKD0Z710uAW4v5Bpk2EO5DcCr0F5DIkCDpHsF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAOLNshZl4GtJCGIhO3pyC71Znc4xhdHeUeVw92fbRZ1WAHcRKkVpEZiSd1+DRmnG
	 R31+MKMsNSUL9+7Mj/0xjCeVgtWVFLXyArawMJKBkYVj9EccVsx9mndZ8HqkG81OR2
	 qnPJ1iuwynw4cd01WYhg4l72A+dRfKOINWSxrva0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.12 202/422] wifi: rtlwifi: rtl8821ae: Fix media status report
Date: Thu, 13 Feb 2025 15:25:51 +0100
Message-ID: <20250213142444.338979820@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

commit 66ef0289ac99e155d206ddaa0fdfad09ae3cd007 upstream.

RTL8821AE is stuck transmitting at the lowest rate allowed by the rate
mask. This is because the firmware doesn't know the device is connected
to a network.

Fix the macros SET_H2CCMD_MSRRPT_PARM_OPMODE and
SET_H2CCMD_MSRRPT_PARM_MACID_IND to work on the first byte of __cmd,
not the second. Now the firmware is correctly notified when the device
is connected to a network and it activates the rate control.

Before (MCS3):

[  5]   0.00-1.00   sec  12.5 MBytes   105 Mbits/sec    0    339 KBytes
[  5]   1.00-2.00   sec  10.6 MBytes  89.1 Mbits/sec    0    339 KBytes
[  5]   2.00-3.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
[  5]   3.00-4.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
[  5]   4.00-5.00   sec  10.2 MBytes  86.0 Mbits/sec    0    427 KBytes

After (MCS9):

[  5]   0.00-1.00   sec  33.9 MBytes   284 Mbits/sec    0    771 KBytes
[  5]   1.00-2.00   sec  31.6 MBytes   265 Mbits/sec    0    865 KBytes
[  5]   2.00-3.00   sec  29.9 MBytes   251 Mbits/sec    0    963 KBytes
[  5]   3.00-4.00   sec  28.2 MBytes   237 Mbits/sec    0    963 KBytes
[  5]   4.00-5.00   sec  26.8 MBytes   224 Mbits/sec    0    963 KBytes

Fixes: 39f40710d0b5 ("rtlwifi: rtl88821ae: Remove usage of private bit manipulation macros")
Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/754785b3-8a78-4554-b80d-de5f603b410b@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
@@ -197,9 +197,9 @@ enum rtl8821a_h2c_cmd {
 
 /* _MEDIA_STATUS_RPT_PARM_CMD1 */
 #define SET_H2CCMD_MSRRPT_PARM_OPMODE(__cmd, __value)	\
-	u8p_replace_bits(__cmd + 1, __value, BIT(0))
+	u8p_replace_bits(__cmd, __value, BIT(0))
 #define SET_H2CCMD_MSRRPT_PARM_MACID_IND(__cmd, __value)	\
-	u8p_replace_bits(__cmd + 1, __value, BIT(1))
+	u8p_replace_bits(__cmd, __value, BIT(1))
 
 /* AP_OFFLOAD */
 #define SET_H2CCMD_AP_OFFLOAD_ON(__cmd, __value)	\



