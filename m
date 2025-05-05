Return-Path: <stable+bounces-140009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FAAAA3AD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D8A464871
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3828AAEC;
	Mon,  5 May 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8qCWqXV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134728AAFC;
	Mon,  5 May 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483908; cv=none; b=FmVSY+Oj6HF0lF54HEsfb8n0ifJJF4K0R24zmlUN5fcPlvHjSpTRBTjxdM1JAmkUC1zWMD5q0kL19vGef++2AwBBxNivtvWVSQYxYQjJINRUBbjTR7qUHehqJ8/63M8fNSoG3cWhAL7o0D5pedDLMVyzBglLV6nAnlBQ1wrw8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483908; c=relaxed/simple;
	bh=hDYhyNuSZwte5f2IAVRvF4DH0+IABIDvZzqWfhUPjvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tql2VVqek55ze5nyVxg7q2CvCSMynnOMuvvj3suHoHMdURF0mMas7zCtEFProLdO/QOP4xy+3ABORVA/KO5VGiyXO5hsLwPZxy6xVwWVieTH4Y/1gEDHhQq/H41CZP09PJcFYCG/hcXb+z6+VwIWt/G+sh4lUUU3WzpLNHqwi0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8qCWqXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AE8C4CEE4;
	Mon,  5 May 2025 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483907;
	bh=hDYhyNuSZwte5f2IAVRvF4DH0+IABIDvZzqWfhUPjvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8qCWqXVK5tzwPUoCW2N1WMIrhICblgFZktn/05BXxQ+gatAaufjjsT4hGpTMfN5c
	 tQ2idW27MkPoM8UPRyarJEoPOvgcbhkXmo+O7tqLdy/78+p1orm1p+Kp/PN8FZQfV5
	 gEm1KADXz1uVi65acZk0XZoOG7mBZ+pfRJQd+FK7jzW6cx7aHUFOW9IWXTotRlW99O
	 +sDLKWillWYP250cmYl2qPIp0gk3QFphBu79k8MnKapap+QO1gDTZSjDplG79FlHse
	 bBCMIkq5r6BCBdniU0dGYbutd8OjZSlCVHACQFdQYawHLVm4Z4FvkSNPg6P5ZMI6bF
	 8U30KIQ2jJNrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lee Trager <lee@trager.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com,
	michal.swiatkowski@linux.intel.com,
	mohsin.bashr@gmail.com,
	suhui@nfschina.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 262/642] eth: fbnic: Prepend TSENE FW fields with FBNIC_FW
Date: Mon,  5 May 2025 18:07:58 -0400
Message-Id: <20250505221419.2672473-262-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lee Trager <lee@trager.us>

[ Upstream commit 56bcc6ecff8fdc06258c637226986ed522027ca5 ]

All other firmware fields are prepended with FBNIC_FW. Update TSENE fields
to follow the same format.

Signed-off-by: Lee Trager <lee@trager.us>
Link: https://patch.msgid.link/20250228191935.3953712-2-lee@trager.us
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 16 ++++++++--------
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index bbc7c1c0c37ef..76a225f017186 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -743,9 +743,9 @@ int fbnic_fw_xmit_tsene_read_msg(struct fbnic_dev *fbd,
 }
 
 static const struct fbnic_tlv_index fbnic_tsene_read_resp_index[] = {
-	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_THERM),
-	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_VOLT),
-	FBNIC_TLV_ATTR_S32(FBNIC_TSENE_ERROR),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_THERM),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_VOLT),
+	FBNIC_TLV_ATTR_S32(FBNIC_FW_TSENE_ERROR),
 	FBNIC_TLV_ATTR_LAST
 };
 
@@ -762,21 +762,21 @@ static int fbnic_fw_parse_tsene_read_resp(void *opaque,
 	if (!cmpl_data)
 		return -EINVAL;
 
-	if (results[FBNIC_TSENE_ERROR]) {
-		err = fbnic_tlv_attr_get_unsigned(results[FBNIC_TSENE_ERROR]);
+	if (results[FBNIC_FW_TSENE_ERROR]) {
+		err = fbnic_tlv_attr_get_unsigned(results[FBNIC_FW_TSENE_ERROR]);
 		if (err)
 			goto exit_complete;
 	}
 
-	if (!results[FBNIC_TSENE_THERM] || !results[FBNIC_TSENE_VOLT]) {
+	if (!results[FBNIC_FW_TSENE_THERM] || !results[FBNIC_FW_TSENE_VOLT]) {
 		err = -EINVAL;
 		goto exit_complete;
 	}
 
 	cmpl_data->u.tsene.millidegrees =
-		fbnic_tlv_attr_get_signed(results[FBNIC_TSENE_THERM]);
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_TSENE_THERM]);
 	cmpl_data->u.tsene.millivolts =
-		fbnic_tlv_attr_get_signed(results[FBNIC_TSENE_VOLT]);
+		fbnic_tlv_attr_get_signed(results[FBNIC_FW_TSENE_VOLT]);
 
 exit_complete:
 	cmpl_data->result = err;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index fe68333d51b18..a3618e7826c25 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -139,10 +139,10 @@ enum {
 };
 
 enum {
-	FBNIC_TSENE_THERM			= 0x0,
-	FBNIC_TSENE_VOLT			= 0x1,
-	FBNIC_TSENE_ERROR			= 0x2,
-	FBNIC_TSENE_MSG_MAX
+	FBNIC_FW_TSENE_THERM			= 0x0,
+	FBNIC_FW_TSENE_VOLT			= 0x1,
+	FBNIC_FW_TSENE_ERROR			= 0x2,
+	FBNIC_FW_TSENE_MSG_MAX
 };
 
 enum {
-- 
2.39.5


