Return-Path: <stable+bounces-31631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0188897DE
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6530A29CD42
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87A261CBF;
	Mon, 25 Mar 2024 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYqD9Lgo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF5145B11;
	Sun, 24 Mar 2024 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322011; cv=none; b=dB1IEA/NA6tjWJpSTH6LHaV64YJjN8ez97idHQtJQIHQVy8Ap5GboaeX2kAib9cuVjhDJ9OnaK+TCgPnzjABqG18KqUmWIZba5BCw2MoyWSKYF52os/LU2ix+3gPRl7Oqo+RefGSR9vxrbz77qctYzurbGXR26VenNgMs1zxdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322011; c=relaxed/simple;
	bh=S9eicRX5Oris5bmASqtF2I7Mldq+1S/Uwwv/mu4+hCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lfl9tlVu+k4PcctrFe36AVd7FSj9j8PfnFinxThY3lJrHfWkO5skUXjYg9h+aiLL3dVkF5M8H5VjJNrbGmNyg+cUPqG6VvwGa8zrJVem5ZEJezfZ0UeEYH/oOo6mFPi91mULrO2HHc5eQC3WvMfbU9DZJI4z2aDBZ6VqWVMDf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYqD9Lgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF48BC433F1;
	Sun, 24 Mar 2024 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322011;
	bh=S9eicRX5Oris5bmASqtF2I7Mldq+1S/Uwwv/mu4+hCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYqD9LgoJRoOrqkl9w1zQO7Z9MRj4IP8iQ3cvqnhsDan1GTvUoANiD8IIQtmzRbzp
	 P9w8NzNUaCxFQ1rONVdSwdPEMl4TBoCTiJLlw5fgPNd8UO9k7ALc7RYb/iWDJ2EJk+
	 nHw/9KrzmiN41ihFflACP4kCacxT+hFhZCCMgklOfsF2X8HJfU2aNqgXi4TWIbt7JC
	 GCnhotyVFymvO0y2/ENqUQDqQeEqCCJ9h8eKO+XeGirbuqagH8+DUhB1H/i+Gs6ej3
	 Vl2lqGJozV9fZ9eYwwImUWmrYG/by1m3pk/nn5lfq+kyDxbzQrFZNHCuCWk7nnJ/Vx
	 BSSZLx7S3cAbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xingyuan Mo <hdthky0@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 083/451] wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()
Date: Sun, 24 Mar 2024 19:05:59 -0400
Message-ID: <20240324231207.1351418-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 876410a47d1d2..4d5009604eee7 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -844,6 +844,10 @@ ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev(struct ath10k *ar, struct sk_buff *skb,
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


