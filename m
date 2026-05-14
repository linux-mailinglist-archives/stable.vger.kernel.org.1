Return-Path: <stable+bounces-247230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBnADBXmBWoAdQIAu9opvQ
	(envelope-from <stable+bounces-247230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:11:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A220A543C25
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A9EE3035266
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B14279EE;
	Thu, 14 May 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmdSx00O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D9402BA3
	for <stable@vger.kernel.org>; Thu, 14 May 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771310; cv=none; b=HKLlMhPc0qDe8Rov1qiUYjkaufPPDviY+eYrM+ALku9syiTrv5sVbUtzY/Ddc3DFGxYxOAiyzMoAfUiYeQzAFJa3evQcD4ZOtObZ7dEYvXMLU9DfxjuKndG4MbHYEFZUjygCrHPyZvgN6DLxXhkYHO1lvMSgfG5wEAu5G9X9SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771310; c=relaxed/simple;
	bh=SsN4kC0dDZZdqjSh7aoPCBzgGGNYAs+sblZOblYcpBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDKCLJSK6XyRSIEf7IZ7mfBPf04WHAKzkbcsTsrAPybwyxyua9CUCSWR7LqjEwnYRZkKhtsYJGEap9QIg5vWTJZpMrKlwk3NEE+YboCribk3ZIQzjAC4GlHLhJ+dj9p1AlmgxG4nPmoNK+QqjI7hASOCnBYACqUrWg8tg3blI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmdSx00O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D714C2BCB8;
	Thu, 14 May 2026 15:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771308;
	bh=SsN4kC0dDZZdqjSh7aoPCBzgGGNYAs+sblZOblYcpBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmdSx00OlJo1NxY5sIfR7y+BSXc2vRf+itwe6t3oHlwIRnNYjbj1iwHefaVrLweNu
	 ND/3yLI6GHPVMxpiVpF/5fs6dB1k8nfk/KKNB8isKvWxAy5YeHeHIBIBeHzG4nYipJ
	 +mqjsO35tyo15hluCPh8S6q5PCilaCRSTBdca36pegPhTV7crKDk77XhpZp4XLptZp
	 IanVwxVz2v4HdZIE6fxE4QJrbsmffgNiaIZe4i4BIIi2GKT3TOZ+q1NOhcj2WkE4o0
	 8xqnH64V3pQYRlLZ4X+cePF6qVmp6TwghvbO0BHC8midTXYHJCglIqdsonZ2E3yNBX
	 hMB5C7adq0+Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] EDAC/versalnet: Fix device name memory leak
Date: Thu, 14 May 2026 11:08:25 -0400
Message-ID: <20260514150825.274588-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514150825.274588-1-sashal@kernel.org>
References: <2026051202-poise-recoil-ab09@gregkh>
 <20260514150825.274588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A220A543C25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247230-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

[ Upstream commit 8cf5dd235eff6008cb04c3d8064d2acfa90616f1 ]

The device name allocated via kzalloc() in init_one_mc() is assigned to
dev->init_name but never freed on the normal removal path.  device_register()
copies init_name and then sets dev->init_name to NULL, so the name pointer
becomes unreachable from the device. Thus leaking memory.

Use a stack-local char array instead of using kzalloc() for name.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260401111856.2342975-1-ptsm@linux.microsoft.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/versalnet_edac.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index ec13155824141..97ec05d68bbbc 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -777,9 +777,9 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
+	char name[MC_NAME_LEN];
 	struct device *dev;
 	enum dev_type dt;
-	char *name;
 	int rc;
 
 	config = priv->adec[CONF + i * ADEC_NUM];
@@ -813,13 +813,9 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	layers[1].is_virt_csrow = false;
 
 	rc = -ENOMEM;
-	name = kzalloc(MC_NAME_LEN, GFP_KERNEL);
-	if (!name)
-		return rc;
-
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		goto err_name_free;
+		return rc;
 
 	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
 	if (!mci) {
@@ -858,8 +854,6 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	edac_mc_free(mci);
 err_dev_free:
 	kfree(dev);
-err_name_free:
-	kfree(name);
 
 	return rc;
 }
-- 
2.53.0


