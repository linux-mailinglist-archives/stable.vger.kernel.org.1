Return-Path: <stable+bounces-232527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDIiA8cCzGmGNQYAu9opvQ
	(envelope-from <stable+bounces-232527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:22:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6636E90D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79B8E315FC29
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA1530CD85;
	Tue, 31 Mar 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1+meR2F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414131717C
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976976; cv=none; b=AKaO4lBmIiXgQR0F+9w0jc6Nu4imbtZqxAOoHXHXr+7dvPJkHP4f8A93DaV0F6ljUyXzljZDuhHzcTUlWjAPPT3A+ZxwHaBWoYR67vzHpxad0QVSXiEcEhnXd0+Rxr0bXjOHO/RdpMoqB/79ibg9tYdciBl8AZ+HyMUn12kJRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976976; c=relaxed/simple;
	bh=y9XwLzUvZnA53pCHgraQGpDA2SXZ/9R64IdB1HzVpKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVf8lEqS2Rf809Rj4YdwWssqATKvurYbPOhIjs2EApij1zf85m4F0C3JYhQqltmd8pCaKuDaPl2oXX0mkSMNXRqm97upLMOAaZQ3fHAlmj41dxHA/vn/0mEGJSJwpG/5lfMtPVg3gr30mZ0idWYMudCbbc4UexfEop5uih2SWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1+meR2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E83DC2BCB1;
	Tue, 31 Mar 2026 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774976976;
	bh=y9XwLzUvZnA53pCHgraQGpDA2SXZ/9R64IdB1HzVpKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G1+meR2Fa4rbTiS7/zjZ2ua0DB49LqtiYDiWCARVuh+hdQpeje54QGLfuIj3UrHGu
	 ZcIu+rS2eZ88Izaf/ROcNitmQ7ZQCJGuASTN1h83bTXjMGoeO6l+ZVgj3N6ESGUH81
	 uSooo0JVTlR6Virjm5AW9ZdlU0wIVNRBzAi/TosHO6rNBc2AyJvNUSHpWxY+okA73J
	 rNL7SJndgiD6R/P2ubTZz0xHVFIsBLNeHpu2W8wQULsh6cH+gxc0MFVU9U4PJFmH3V
	 jnezF2L4vVhMXUSEbxS96yjA8nEWGiX4vpyvTVSF9oxgHy4q+pkuU/R6Zl4mYkm5z/
	 MBYzW2NYTrJkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Long Li <longli@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: mana: fix use-after-free in add_adev() error path
Date: Tue, 31 Mar 2026 13:09:32 -0400
Message-ID: <20260331170932.2813528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033041-unkind-wifi-8aa8@gregkh>
References: <2026033041-unkind-wifi-8aa8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232527-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 2DB6636E90D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f ]

If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
auxiliary_device_uninit(adev).

The auxiliary device has its release callback set to adev_release(),
which frees the containing struct mana_adev. Since adev is embedded in
struct mana_adev, the subsequent fall-through to init_fail and access
to adev->id may result in a use-after-free.

Fix this by saving the allocated auxiliary device id in a local
variable before calling auxiliary_device_add(), and use that saved id
in the cleanup path after auxiliary_device_uninit().

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Cc: stable@vger.kernel.org
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260323165730.945365-1-lgs201920130244@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d953d6084269c..969dd44303569 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2823,6 +2823,7 @@ static int add_adev(struct gdma_dev *gd)
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
 	int ret;
+	int id;
 
 	madev = kzalloc(sizeof(*madev), GFP_KERNEL);
 	if (!madev)
@@ -2832,7 +2833,8 @@ static int add_adev(struct gdma_dev *gd)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = "rdma";
 	adev->dev.parent = gd->gdma_context->dev;
@@ -2856,7 +2858,7 @@ static int add_adev(struct gdma_dev *gd)
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);
-- 
2.53.0


