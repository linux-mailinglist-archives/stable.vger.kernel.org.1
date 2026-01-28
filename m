Return-Path: <stable+bounces-212517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NlFAZkyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:00:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E3A4E7E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE3AA3013DBA
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50D1D6AA;
	Wed, 28 Jan 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJuPFCMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E318027;
	Wed, 28 Jan 2026 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615783; cv=none; b=iNtmGEKIJ0Byk5UL7HEb30GI8zXBN3LtXgBHPcmhZoqIt06dkJsICw6S9RF1ibL/9rHYEkMY7mxw2bH20S1ev/KOz9U065yOcmfAyJ6TtxFuCfet84BF/5zNvX+fHXYIWpdhdtAYrVX8enz2FYREMEM7pr0/aocFQDNNBDM5PeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615783; c=relaxed/simple;
	bh=jmFEt0qEt6/LiQyMcvmpWZaPgKDIz25AE+ht5ezpTNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMzf0Xt7yuTMH3VDTa8hCKRUOkhImHeVVtwaU3TxaX+Rkdi1RDrkdYjXP2DkITXcSG8REan0YhFA9hHG839Tvpkqu1hFp8eeomvkFP+ETYHRgML8yNoVRP2zY67mD8TU4owKLbMOAJ+fZe4/JSlxEXsCaWV+nwAn/+3Cj5GC5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJuPFCMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E6AC4CEF1;
	Wed, 28 Jan 2026 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615782;
	bh=jmFEt0qEt6/LiQyMcvmpWZaPgKDIz25AE+ht5ezpTNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJuPFCMYV4oX7v+XNQiruawm8EH2M6rOG9/651bJXyGfJ2Qs5rBmp9tRFfmlBN3JP
	 mus+nREF8w1C1Xj/jKOBEEyQ7zcq6N8J7H5WzS932fL44Qckh9C297LyqmNL3KVDYE
	 5hIT7oVbtyI8kIGkopFl0FnNMT6N+oI+DaKUQHfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 113/227] net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue
Date: Wed, 28 Jan 2026 16:22:38 +0100
Message-ID: <20260128145348.532362509@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212517-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B89E3A4E7E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit f87e034d16e43af984380a95c32c25201b7759a7 ]

Use next_input_key instead of counter_id to set HCLGE_FD_AD_NXT_KEY.

Fixes: 117328680288 ("net: hns3: Add input key and action config support for flow director")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260119132840.410513-3-shaojijie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1b103d1154da9..5cc5ee9dcd982 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5690,7 +5690,7 @@ static int hclge_fd_ad_config(struct hclge_dev *hdev, u8 stage, int loc,
 			HCLGE_FD_AD_COUNTER_NUM_S, action->counter_id);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_NXT_STEP_B, action->use_next_stage);
 	hnae3_set_field(ad_data, HCLGE_FD_AD_NXT_KEY_M, HCLGE_FD_AD_NXT_KEY_S,
-			action->counter_id);
+			action->next_input_key);
 
 	req->ad_data = cpu_to_le64(ad_data);
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-- 
2.51.0




