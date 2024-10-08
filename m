Return-Path: <stable+bounces-82060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F19994ADA
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80631281258
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D221DE890;
	Tue,  8 Oct 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXY3A3rC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4591D27B3;
	Tue,  8 Oct 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391034; cv=none; b=LvJwnkmSYWVwf3mIiphK8Q4BO+aKgPI+L0XOTSJsEQergLl5q1aMjhlu4GX5v6sl6PaUMpD3d0YJwmwN/VP1zioYSoPCfOtZXoBHM0TtMor9Mm3nl+9+KnOiV2rpwcsQHkwnMeRa4TkdDfdcxw8BtlNUm+seyCUoXjhGftQYwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391034; c=relaxed/simple;
	bh=QwMg0mFjOhLGhKCztMeYLRN9v/MzOxMpLKzj3VpWu8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiZqQ2KsvPhDsKftL4kAGMb3Bn8oqtkdxYxuh5f2UA3ovF8jJf8QjixS8PUIRyjcaRnrKOvuiLrAAcOF+8KFA8XalNsybN/HEU8TLMN0DTPzBHxy70EgCCgh3IuC+eYxNm9y6MbUVEXRP7ZFyM6UJR7gE9Ks92PMnc5RrFhJhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PXY3A3rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73032C4CEC7;
	Tue,  8 Oct 2024 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391033;
	bh=QwMg0mFjOhLGhKCztMeYLRN9v/MzOxMpLKzj3VpWu8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXY3A3rCubp+BeaLIz/nfJzUMRGf2lcY3Gi5MVolnxwNWL6ndF5Khzf2NMkF4caBd
	 T2cVKp48YsOaXwXQPg4OtY+di7kCM2DurSQkNOLLP06EL0QFUoNVvihhJILYxGxf3Y
	 Ub0f7u1TP7LJL/3CqOPeyOj3jMm8U7Q1uAhK1xeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 470/482] r8169: add tally counter fields added with RTL8125
Date: Tue,  8 Oct 2024 14:08:53 +0200
Message-ID: <20241008115707.009222098@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit ced8e8b8f40accfcce4a2bbd8b150aa76d5eff9a ]

RTL8125 added fields to the tally counter, what may result in the chip
dma'ing these new fields to unallocated memory. Therefore make sure
that the allocated memory area is big enough to hold all of the
tally counter values, even if we use only parts of it.

Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/741d26a9-2b2b-485d-91d9-ecb302e345b5@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index aa6a73882f914..f5396aafe9ab6 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -577,6 +577,33 @@ struct rtl8169_counters {
 	__le32	rx_multicast;
 	__le16	tx_aborted;
 	__le16	tx_underrun;
+	/* new since RTL8125 */
+	__le64 tx_octets;
+	__le64 rx_octets;
+	__le64 rx_multicast64;
+	__le64 tx_unicast64;
+	__le64 tx_broadcast64;
+	__le64 tx_multicast64;
+	__le32 tx_pause_on;
+	__le32 tx_pause_off;
+	__le32 tx_pause_all;
+	__le32 tx_deferred;
+	__le32 tx_late_collision;
+	__le32 tx_all_collision;
+	__le32 tx_aborted32;
+	__le32 align_errors32;
+	__le32 rx_frame_too_long;
+	__le32 rx_runt;
+	__le32 rx_pause_on;
+	__le32 rx_pause_off;
+	__le32 rx_pause_all;
+	__le32 rx_unknown_opcode;
+	__le32 rx_mac_error;
+	__le32 tx_underrun32;
+	__le32 rx_mac_missed;
+	__le32 rx_tcam_dropped;
+	__le32 tdu;
+	__le32 rdu;
 };
 
 struct rtl8169_tc_offsets {
-- 
2.43.0




