Return-Path: <stable+bounces-220388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF/fEwQ0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0561C5DAA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A99EA330734C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE143A8642;
	Sat, 28 Feb 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akVmLizy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE183A863A;
	Sat, 28 Feb 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300281; cv=none; b=ND45PDY4pFtIoavZFwrYxKFVCHDckYmTvmTepdAVS7Szxv3Ug4I1/I/4DdTxtxZkoJOLa8VSOL3lVvamrud4j6azck8e9Bw4s63pp1I9mlIY8eM/FWBmnXB5n1qwXBL4VwGh+npxUg7FT8IRZhUOtvGQwdDZ5fqZ3zcsZPm+Eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300281; c=relaxed/simple;
	bh=BGncQb5x7RGPy68kLJLDGKM8UoTTb59cykGAb1XIhao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPOr6Nv4V9xVqCnuL4z81DPdrGjtAft6T3hUQvaHFucDn8CBLYYZ/N94ewKFaiYQlfwEY6VlDY2GAus1Ex8TTsMVJt7MRA3UsbAN5P13zzFw2h3O+rUHX+ocN31ipRIVHOoITO127h9Po96ZkFtdqAPVbi/wTMM23LPCO9U4EVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akVmLizy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF93EC116D0;
	Sat, 28 Feb 2026 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300281;
	bh=BGncQb5x7RGPy68kLJLDGKM8UoTTb59cykGAb1XIhao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=akVmLizyMPM1OT6FsIHZ2D55GpQQ2/qMzxIQbSxQNBCwhtWcb1qFvodrwrGK3BFCa
	 AueRygnIR3SVVLOiMgKTaKUJpVpXIp2loDJnggCD+WdAV28Ffbf5cYMXLYebqGrrdE
	 +z4BBy7JR6QEgG198i2Xl1/KEGEavpU8upp3Bvmsoo9ZykYIgamtt+xdWZsNKX1Ukc
	 9TJvATsynPDC6Oz00BRfpvBXn4FKXGj1k1hriCBn3L2vrXQhKdCnGi7xQ5tV/iyU6L
	 aslimDebJTwlGM+XW7YeoP8PsFHiKiTJBmUBoodOsnsGUkj5nidIZaZgnp7uMmOygb
	 LFNfzp82lwLpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jijie Shao <shaojijie@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 309/844] net: hns3: extend HCLGE_FD_AD_QID to 11 bits
Date: Sat, 28 Feb 2026 12:23:42 -0500
Message-ID: <20260228173244.1509663-310-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220388-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CE0561C5DAA
X-Rspamd-Action: no action

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit 878406d4d6ef85c37fab52074771cc916e532c16 ]

Currently, HCLGE_FD_AD_QID has only 10 bits and supports a
maximum of 1023 queues. However, there are actually scenarios
where the queue_id exceeds 1023.

This patch adds an additional bit to HCLGE_FD_AD_QID to ensure
that queue_id greater than 1023 are supported.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260123094756.3718516-2-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 5 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 416e02e7b995f..bc333d8710ac1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -727,8 +727,8 @@ struct hclge_fd_tcam_config_3_cmd {
 
 #define HCLGE_FD_AD_DROP_B		0
 #define HCLGE_FD_AD_DIRECT_QID_B	1
-#define HCLGE_FD_AD_QID_S		2
-#define HCLGE_FD_AD_QID_M		GENMASK(11, 2)
+#define HCLGE_FD_AD_QID_L_S		2
+#define HCLGE_FD_AD_QID_L_M		GENMASK(11, 2)
 #define HCLGE_FD_AD_USE_COUNTER_B	12
 #define HCLGE_FD_AD_COUNTER_NUM_S	13
 #define HCLGE_FD_AD_COUNTER_NUM_M	GENMASK(19, 13)
@@ -741,6 +741,7 @@ struct hclge_fd_tcam_config_3_cmd {
 #define HCLGE_FD_AD_TC_OVRD_B		16
 #define HCLGE_FD_AD_TC_SIZE_S		17
 #define HCLGE_FD_AD_TC_SIZE_M		GENMASK(20, 17)
+#define HCLGE_FD_AD_QID_H_B		21
 
 struct hclge_fd_ad_config_cmd {
 	u8 stage;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b8e2aa19f9e61..a90f1a91f9973 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5679,11 +5679,13 @@ static int hclge_fd_ad_config(struct hclge_dev *hdev, u8 stage, int loc,
 		hnae3_set_field(ad_data, HCLGE_FD_AD_TC_SIZE_M,
 				HCLGE_FD_AD_TC_SIZE_S, (u32)action->tc_size);
 	}
+	hnae3_set_bit(ad_data, HCLGE_FD_AD_QID_H_B,
+		      action->queue_id >= HCLGE_TQP_MAX_SIZE_DEV_V2 ? 1 : 0);
 	ad_data <<= 32;
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_DROP_B, action->drop_packet);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_DIRECT_QID_B,
 		      action->forward_to_direct_queue);
-	hnae3_set_field(ad_data, HCLGE_FD_AD_QID_M, HCLGE_FD_AD_QID_S,
+	hnae3_set_field(ad_data, HCLGE_FD_AD_QID_L_M, HCLGE_FD_AD_QID_L_S,
 			action->queue_id);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_USE_COUNTER_B, action->use_counter);
 	hnae3_set_field(ad_data, HCLGE_FD_AD_COUNTER_NUM_M,
-- 
2.51.0


