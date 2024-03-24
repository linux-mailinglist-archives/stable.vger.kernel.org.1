Return-Path: <stable+bounces-30855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B81E8892F1
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4581F31071
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378A0287031;
	Mon, 25 Mar 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1R1HNzC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF92888F5;
	Sun, 24 Mar 2024 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324029; cv=none; b=F2nBSOrXE1/IYs+n9XQnj/rd/IBcSBwdZD/dXXpXTHijXxbXOWnPM91klTUf6WCxIj/EX6V80Ht5sv0jRKQdflro9vX2BuNO6rTfzUGt1IhwKyKnE46lm5WULXbTqQxlOalhxcwi/LbyLGBTEvamMJUclhHRG+3KxcyGmzzLhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324029; c=relaxed/simple;
	bh=/VL63NEbWikFES4mHo/PX6luf7WkfDLqQ69lE8hGFFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAENjPdzx3IaJPmbpyROEwTL+/wRIe4FVQwdVrUB3RWs8cVnfSUjvIbSf3bbSL9ks6AAXRf4hlJFX584F7ng3STkF9Zi/472PBDhyMEHpkquMfLGVifxYecAfZ8vQUtX1mK5qmYV1lBsWDpf8mGqvJdqEs888ermXvWgPAHN3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1R1HNzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22D7C433C7;
	Sun, 24 Mar 2024 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324028;
	bh=/VL63NEbWikFES4mHo/PX6luf7WkfDLqQ69lE8hGFFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1R1HNzCtkhbzMg0IYJEuiDrVs9/ClO8pCCM0+sD3jZBPkFxzpj9mXe5wUt/sKZlu
	 PjU8QQWTkGObIKeohos4gt/W+BSu58GAST26E8WyJkFqdFuBEcS6C3lZhQ1VPaNl4d
	 nS4jbVHCQ1SjiFy3Td+jvbnSgdb3sr0GMGfdYpypMy88t7009N7E97gAtmsp633AbQ
	 hRdK2CvNlhGgm6NZS6daMMm8rwpU8/aBWCVy2Xv8/ABOeTBWRBIG6S41h+j31g9sb1
	 D6m3WLSMtlEA3k19kqLmMP3GWjdyGrgKkbEF2/FDpT9Cdq32mmFooMH0MDts4ZlljG
	 yDkx6CXgk1J4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 029/183] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 19:44:02 -0400
Message-ID: <20240324234638.1355609-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xingyuan Mo <hdthky0@gmail.com>

[ Upstream commit ad25ee36f00172f7d53242dc77c69fff7ced0755 ]

We should check whether the WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT tlv is
present before accessing it, otherwise a null pointer deference error will
occur.

Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20231208043433.271449-1-hdthky0@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 315d20f5c8eb1..ee1c86bb5078b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -707,6 +707,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
 	}
 
 	ev = tb[WMI_TLV_TAG_STRUCT_MGMT_TX_COMPL_EVENT];
+	if (!ev) {
+		kfree(tb);
+		return -EPROTO;
+	}
 
 	arg->desc_id = ev->desc_id;
 	arg->status = ev->status;
-- 
2.43.0


