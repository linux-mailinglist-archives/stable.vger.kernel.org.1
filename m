Return-Path: <stable+bounces-212145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMS2E+0semnd3gEAu9opvQ
	(envelope-from <stable+bounces-212145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:36:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C089BA40D7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01B1B30164A7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED82D6E63;
	Wed, 28 Jan 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZqRSVjt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9B2D0C62;
	Wed, 28 Jan 2026 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614542; cv=none; b=TghqKszeUM5Z3RwnT11B/qmV/7ZWr3tDiKyJk+JQiO6roqYD5lZf9gOAThUDTy7bvgFoQlQ6bTIQB7la6MF/I21RF2at4zjOEsSHfYBfPE64zhvbwTSBRzO//KoZZ4GwNlEoc0J32TdJk4O9ohpZ6TbgN+uqgFl2HXBu0ewRQtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614542; c=relaxed/simple;
	bh=3jJc+ByqzsTicWlKTgvpkoF1mBJrx4umyOgY0nOlKnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S94hfuqOLC9WC8dtGpZhHZODBxaeYRbHPsprsPlaJGwpa38PdZLQ5EwTJLF5SUvlkFW5dG+XuN5ooIiR60tOSuNir3xH+IFefG8V0ytvEU4TsfFSxl1LYWcN2Wa1tgFnvNOoVl3hGKdunrw1chHBDt4bwtBENyFZb+hL0O6fkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZqRSVjt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EA4C4CEF1;
	Wed, 28 Jan 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614542;
	bh=3jJc+ByqzsTicWlKTgvpkoF1mBJrx4umyOgY0nOlKnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqRSVjt6FixR1Mxh1fPVfZTkaIFRD0sUtHOTYUuMoG1wzfktZBWFUyE8J1ksJCP7O
	 4L4W3sRgrpA4WSXXKCh/ncZJUtfsQjf62QAaqfWU4wvDEDqegBBw5CzDOI4n8QQchW
	 cq+IKDPz1gZsGiZpHUqxD1xIhC1Iy4DY7bLidrJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 167/254] net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue
Date: Wed, 28 Jan 2026 16:22:23 +0100
Message-ID: <20260128145350.817734591@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212145-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: C089BA40D7
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 2df0c6305b908..72a5df4e3a329 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5617,7 +5617,7 @@ static int hclge_fd_ad_config(struct hclge_dev *hdev, u8 stage, int loc,
 			HCLGE_FD_AD_COUNTER_NUM_S, action->counter_id);
 	hnae3_set_bit(ad_data, HCLGE_FD_AD_NXT_STEP_B, action->use_next_stage);
 	hnae3_set_field(ad_data, HCLGE_FD_AD_NXT_KEY_M, HCLGE_FD_AD_NXT_KEY_S,
-			action->counter_id);
+			action->next_input_key);
 
 	req->ad_data = cpu_to_le64(ad_data);
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
-- 
2.51.0




