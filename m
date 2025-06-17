Return-Path: <stable+bounces-153609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E8FADD572
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBB318990F8
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB272ECEA2;
	Tue, 17 Jun 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZcQ9+Usn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BB2ECD1F;
	Tue, 17 Jun 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176515; cv=none; b=gjXepTf1zGPphdK0O8mO+vie7vfGrdd28OPv0z+J/NRyOTlgNo7mOdkGTV3NfDLi/ssElMEhPf/oCDytP48+Md2DyUh8aCv+OB7dbFDoXIyOtx9m55zkAiVIlZtxTAFfXBJDouosfJUIMgITBCsxaXL33JZ8HMAOi4sTwZqZw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176515; c=relaxed/simple;
	bh=2NSBx9a3+blILm4gkFNNJFQ0Ah1fIGJGM9l/gD9mcI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm/mp8ponKIaPevfZDXEdw1QsLzXlZVMPMTgUFnwZiE/BG+cTkOIOGUltZdp5dX7BiZQnP+cwCbwK+R+C5/oFbLQoNJhJAW3oDG9pMUfm6QeL3TH/FbrMItD9YzfybNYFDqdQ4ehtwaCq5sZn60gZUZiek9FAe/gzSdrb2azwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZcQ9+Usn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CAEC4CEE3;
	Tue, 17 Jun 2025 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176515;
	bh=2NSBx9a3+blILm4gkFNNJFQ0Ah1fIGJGM9l/gD9mcI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcQ9+UsnLmVXyHGdKxokgtjuoez6Kx+WgrnUTFT1k35iGg7FuinPJyQppPdNnNluM
	 ZzNrIDIeCCcbR7WJXHVDN1A/jYTG6qkXkT4329+Msh4m6aH09g1UbzpKUJOESNaQ+z
	 NEPyqUDNrwNTi6pwZbPEiWQPNhzq5ZDuD2M+jgkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 178/780] wifi: ath12k: Fix WMI tag for EHT rate in peer assoc
Date: Tue, 17 Jun 2025 17:18:06 +0200
Message-ID: <20250617152458.723336821@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

[ Upstream commit 1a0e65750b55d2cf5de4a9bf7d6d55718784bdb7 ]

Incorrect WMI tag is used for EHT rate update from host to firmware
while encoding peer assoc WMI.

Correct the WMI tag used for EHT rate update from WMI_TAG_HE_RATE_SET
to the proper tag. This ensures firmware does not mistakenly update HE rate during parsing.

Found during code review. Compile tested only.

Fixes: 5b70ec6036c1 ("wifi: ath12k: add WMI support for EHT peer")
Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Link: https://patch.msgid.link/20250409152341.944628-1-ramya.gnanasekar@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 6d1ea5f3a791b..6374e86f89f3d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2351,7 +2351,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 
 	for (i = 0; i < arg->peer_eht_mcs_count; i++) {
 		eht_mcs = ptr;
-		eht_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
+		eht_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_EHT_RATE_SET,
 							     sizeof(*eht_mcs));
 
 		eht_mcs->rx_mcs_set = cpu_to_le32(arg->peer_eht_rx_mcs_set[i]);
-- 
2.39.5




