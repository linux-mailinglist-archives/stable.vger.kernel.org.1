Return-Path: <stable+bounces-147730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F9AC58EF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C701B9E0143
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189E27FD76;
	Tue, 27 May 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dxnzOxGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95C27BF8D;
	Tue, 27 May 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368253; cv=none; b=PJxLR+dvAWUCVPaoLOJob6XB2cPvHZcBXqmff9Mqawo1f6cZbdLUt15LBAo4xe9GX+VmXCqVeG8xwIY2CvjvKo0HA9JktElkM4tVLQujCSVkzV6ddlRcfMBmmW9BGcGbVYQXYx4tiLv6YPzewAkKDvS1YZnDboV2iduAoTdgIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368253; c=relaxed/simple;
	bh=dlSlDWt3tmqXaI1H2ccJejpgK5Jb7ITi98+JgqApt0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUNAIOg7gB6p0x4E8yhf16vUwoSLxsROUWjwk5TWda8b0fldtVb6PkdIUs9ANHdXdlwuE4RKXUDIYEhrRi5dKdKfWWwNznrgzx/cn6xJ1gP/R3dcAgBEMQfJUFFcISQoD1cRQd5pOaXrQlWHE691q+StS2X4KrI0lNfedfDOuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dxnzOxGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E59AC4CEE9;
	Tue, 27 May 2025 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368253;
	bh=dlSlDWt3tmqXaI1H2ccJejpgK5Jb7ITi98+JgqApt0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxnzOxGHT2b+Qx42YQnDihPucXjvlxr8KFnbmU7jObBVe83eUdcW64mzNCjda6N4N
	 /0/I7nQmvD+MpvIzLH2SeTN/g1cSn2Vv4l+oTWhrSC54aSRMwzqQ0xKybqEa7K/DRa
	 V1PrZ7oGsaXq41Fr2YzTWVWcugvM2HG2iA2SHYqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaradhana Sahu <quic_aarasahu@quicinc.com>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 607/783] wifi: ath12k: Fetch regdb.bin file from board-2.bin
Date: Tue, 27 May 2025 18:26:44 +0200
Message-ID: <20250527162537.872553755@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

From: Aaradhana Sahu <quic_aarasahu@quicinc.com>

[ Upstream commit 24f587572acf7509127dbdfcbf1b681ef84eeba0 ]

Currently, ath12k_core_fetch_regdb() finds regdb.bin file through
board id's but in board-2.bin file regdb.bin file is present with
default board id because of which regdb.bin is not fetched.

Add support to fetch regdb.bin file from board-2.bin through
default board id.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Link: https://patch.msgid.link/20250116032835.118397-1-quic_aarasahu@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ffd173ff7b08c..d0aed4c56050d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL(ath12k_core_resume);
 
 static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					   size_t name_len, bool with_variant,
-					   bool bus_type_mode)
+					   bool bus_type_mode, bool with_default)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH12K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -204,7 +204,9 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 			  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
 			  ath12k_bus_str(ab->hif.bus),
 			  ab->qmi.target.chip_id,
-			  ab->qmi.target.board_id, variant);
+			  with_default ?
+			  ATH12K_BOARD_ID_DEFAULT : ab->qmi.target.board_id,
+			  variant);
 		break;
 	}
 
@@ -216,19 +218,19 @@ static int __ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 static int ath12k_core_create_board_name(struct ath12k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, true, false);
+	return __ath12k_core_create_board_name(ab, name, name_len, true, false, false);
 }
 
 static int ath12k_core_create_fallback_board_name(struct ath12k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, false, false);
+	return __ath12k_core_create_board_name(ab, name, name_len, false, false, true);
 }
 
 static int ath12k_core_create_bus_type_board_name(struct ath12k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath12k_core_create_board_name(ab, name, name_len, false, true);
+	return __ath12k_core_create_board_name(ab, name, name_len, false, true, true);
 }
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
-- 
2.39.5




