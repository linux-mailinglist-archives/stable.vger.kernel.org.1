Return-Path: <stable+bounces-223879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBz0BEP7r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:06:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9DF249FA4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6B9030364FC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1C3859DF;
	Tue, 10 Mar 2026 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8SGqxO3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B3382391;
	Tue, 10 Mar 2026 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140781; cv=none; b=SOm9hYgFTeDk9aULc3rOGjj5Yq1TGKZ+8CFOl+efuT/QJI2Wn/oPvbAziBWhTsaDuDrLoW9GA2ztVM9sMS0kRWgfdJvENSUX/AWFQfILXGexaGiKvZQiCueouaG+HsxWMfIQyEjkMMq4wi00qnyeJRu61BcXXoHaDYxYlbEmMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140781; c=relaxed/simple;
	bh=iKOOBUbpj/DdxMH4Mtb6W9N6qcNaRZuybEPkBhaHqhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdpoQLmkbeu9SbiKiJ/9APFy5mt9lvJTJOV7ItKlgN3YXcb3l1sEObvWmClvHnYVwUedeka1Xm6/XTo5gS8KxO3sqkbG2zm7BEf1HplYJsgDQxA+J1Ebpta3/0wx6zZ6LoSi+JssCZGHRy1VqFed57zW3sCGJCY2x1CU1JI4sRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8SGqxO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50325C19423;
	Tue, 10 Mar 2026 11:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140781;
	bh=iKOOBUbpj/DdxMH4Mtb6W9N6qcNaRZuybEPkBhaHqhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h8SGqxO3/NCGFadvTyZ+aODHdv50MNe2pMECSKUp6dB5AYiK08TROF27FXio2oW2w
	 rRzns5ZRSpf/hp5RqJNTRfwJ0scfuEmypd9SR8N+63KUyGp0v16lVUon8wn1H1k6J3
	 PALpQHwuVFz1pmhjc8fhuZOPy9xNecrD5GWUnjmOWscVzSmMbIKcC+586H9eMFB5Tw
	 J5ToMkdUU51pYlOn++BR8hMAAlcG0n/yh2nhufGHL6U6/uwCjwiYN/Zt1vIaTaDsF0
	 IktWHLgB2qXqt7gtyGlCF8DLWZKcx/Q4bYPzwHnPQ81bq4ReqmgBblv+hNTYnBSenX
	 zwL5A84SjsV/A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Andy Yan <andyshrk@163.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 015/311] drm/bridge: synopsys: dw-dp: Check return value of devm_drm_bridge_add() in dw_dp_bind()
Date: Tue, 10 Mar 2026 07:01:02 -0400
Message-ID: <1ab4254c37742b0b2a334f6a870e2d2d1880e077.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F9DF249FA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,163.com,bootlin.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223879-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,iscas.ac.cn:email]
X-Rspamd-Action: no action

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 496daa2759260374bb9c9b2196a849aa3bc513a8 ]

Return the value of devm_drm_bridge_add() in order to propagate the
error properly, if it fails due to resource allocation failure or bridge
registration failure.

This ensures that the bind function fails safely rather than proceeding
with a potentially incomplete bridge setup.

Fixes: b726970486d8 ("drm/bridge: synopsys: dw-dp: add bridge before attaching")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Andy Yan <andyshrk@163.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20260206040621.4095517-1-nichen@iscas.ac.cn
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 4323424524847..07f7a2e0d9f2a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2049,7 +2049,9 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
 	bridge->ycbcr_420_allowed = true;
 
-	devm_drm_bridge_add(dev, bridge);
+	ret = devm_drm_bridge_add(dev, bridge);
+	if (ret)
+		return ERR_PTR(ret);
 
 	dp->aux.dev = dev;
 	dp->aux.drm_dev = encoder->dev;
-- 
2.51.0


