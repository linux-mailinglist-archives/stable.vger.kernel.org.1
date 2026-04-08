Return-Path: <stable+bounces-234419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG0cBQ2i1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:44:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF13C1662
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C660830C369D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A47D3ACF11;
	Wed,  8 Apr 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+wZ8bIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41A3ACEFB;
	Wed,  8 Apr 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672809; cv=none; b=lZ3T9hn7wcfgU3is7Wa07WTEYzKE7O4SzZCQUsGz56xjzu9/NcAcqPtZ/Vacf9q2vn9SAxw/7nTfh2Bt4uZgbv/cRS+VKHMvisxOuzBmUAMT451AvuQAByZi1XmPRDDdhCLOFUafCipeo9EvpNoxIFWyXEwV02KNROoSUSDu8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672809; c=relaxed/simple;
	bh=XYhH5Vq9aMY9YxO3Z9DIdDjLfNWDb0qemjIpz1rdcyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbJetYu+3NecKEZsaYH8z9hnUv8n94kKuhRhDoMVbgvfatnXrxeJrH+9VPCUG8ACbYyoHJ28qVC/LCewpIfiTYFhNNI1iJv35+GM8YWpI20UXAsYOcJUgKmFEWKE0mPCgOgdzVJntnMiMiouYakU+e9OxjMIh4GeuXpzfW6M6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+wZ8bIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6571C19421;
	Wed,  8 Apr 2026 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672809;
	bh=XYhH5Vq9aMY9YxO3Z9DIdDjLfNWDb0qemjIpz1rdcyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+wZ8bIBoaiiuTRnQzqiue+R6lqRQIekQHZdwzsqfB4Jg285xsQUz+9FTV5xRnQUp
	 +chLGatTIdhXplLX+sYq4oEpLJhzAnX55u/jrB/s6BC3VgJ4FCE16ngB2tpKbkM5T9
	 vzck1Ep6kSjfIpT88UvNoQ2IBi2ugx7UWf0qZHLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <longli@microsoft.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 151/160] net: mana: fix use-after-free in add_adev() error path
Date: Wed,  8 Apr 2026 20:03:58 +0200
Message-ID: <20260408175918.834646757@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,microsoft.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-234419-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 84DF13C1662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2759,6 +2759,7 @@ static int add_adev(struct gdma_dev *gd)
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
 	int ret;
+	int id;
 
 	madev = kzalloc(sizeof(*madev), GFP_KERNEL);
 	if (!madev)
@@ -2768,7 +2769,8 @@ static int add_adev(struct gdma_dev *gd)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = "rdma";
 	adev->dev.parent = gd->gdma_context->dev;
@@ -2792,7 +2794,7 @@ add_fail:
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);



