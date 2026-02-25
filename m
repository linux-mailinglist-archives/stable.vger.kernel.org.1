Return-Path: <stable+bounces-219064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEiJBdtYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-219064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:05:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD2190800
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E90D313657D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6406329ACFC;
	Wed, 25 Feb 2026 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAj2Hqgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283061FE45D;
	Wed, 25 Feb 2026 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983988; cv=none; b=SdNMlAzbSSzhBw0bBgvDs8Ot4/sBAG6psp7Zf7F59pzHck+2vui4jfoz11c4YvV6bL3SWrKvI4foH/h6suGB00KojM2ETo/r9btse0PFZ4PikrMeSZIvZwTB13hWRcw2sVqj6eM3uOseC/oAMm4Wrikc4x5bQEPr1Zuasvb/98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983988; c=relaxed/simple;
	bh=ZyFPzLLecSnmExXec8Bcqmct9ZCCG5VPsrAA1BIuFuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyrLqxlorgu016PAQbEOdFFcFPqSHH2ljxo/pdYkXlzHWGKBQF2s+Ij/+Xp2TgFRlYo6J2knhYi9U+5Lr6XLObnulaNDgK4QQZPc8NtrQXXaYyyNprg4MLub9Rb0IXVy3wUG2O2l/DUdTGeVqMyX1HJbPUFD15fh3qotcE/Ehtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CAj2Hqgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDCAC116D0;
	Wed, 25 Feb 2026 01:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983988;
	bh=ZyFPzLLecSnmExXec8Bcqmct9ZCCG5VPsrAA1BIuFuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAj2HqggE+WSu2keD9LYT1cFNC632FAKyoiCgRgBEdFNom4aaFxVcnnjaH0bxnw8X
	 nuaJFcBqMOOyl4j4FNuSlm0+E/Op5nuj0qgvYaG6B/P7Jl63Bt8kaDJj6OP6AaV2XM
	 sPGGl62nFtVwyfyrYTYfLaSG04Br1D2xyuXwb27s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	David Heidelberg <david@ixit.cz>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 179/641] drm/panel: sw43408: Remove manual invocation of unprepare at remove
Date: Tue, 24 Feb 2026 17:18:25 -0800
Message-ID: <20260225012353.364517140@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219064-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,msgid.link:url,ixit.cz:email,qualcomm.com:email]
X-Rspamd-Queue-Id: 38CD2190800
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Heidelberg <david@ixit.cz>

[ Upstream commit cbc1e99a9e0a6c8b22ddcbb40ca37457066f9493 ]

The drm_panel_remove should take care of disable/unprepare. Remove the
manual call from the sw43408_remove function.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251214-pixel-3-v7-5-b1c0cf6f224d@ixit.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 46a56ea92ad9f..6e307fba658f7 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -294,10 +294,6 @@ static void sw43408_remove(struct mipi_dsi_device *dsi)
 	struct sw43408_panel *ctx = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = sw43408_unprepare(&ctx->base);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", ret);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-- 
2.51.0




