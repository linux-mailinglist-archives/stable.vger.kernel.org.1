Return-Path: <stable+bounces-225029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIyWEXMfs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81158278BD3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42A693028F43
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1642BEFFD;
	Thu, 12 Mar 2026 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0tD3aDnE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069E1F9F70;
	Thu, 12 Mar 2026 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346671; cv=none; b=kwUzNr5iQwxM0OMWJruwP3Xkh5LREYcLqmJ5zxl0rXb49obXuoLkWkUTdmFyorCmAKllwz81zM16O5viEriqBWmBW2L4YH50NvAcjHZHxQ0A7Bq3ynmyvhl8FvymH+BC/L3sDxYk0o9nInFsyGik/ub8fRgKIE2b5RqvwYaiaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346671; c=relaxed/simple;
	bh=1aEZl7AapbW7MZgpqFBYBMVZjy1CSNeFL15QOslqSYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5zdMvJQryDBtQhUEzaqoB4Z8CD3CY+8bFXls54uwimzcE7j6ueQYJobxCyUEqMTw4mbD9WAh78lbv1iB74ayWXm91k503a/WNRnJMq/mqCNgKWFgWS/9r3vrOo9ySisMCmyKJyLkqCcjqZjg2xu4yMN/WhtCpwwGYv8yJuYMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0tD3aDnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D78CC4CEF7;
	Thu, 12 Mar 2026 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346671;
	bh=1aEZl7AapbW7MZgpqFBYBMVZjy1CSNeFL15QOslqSYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0tD3aDnEBOhYG2jVCqiD5abPCCpy3E3M9+dzASZnnS2acaydarvuJrGEnKDHiplcb
	 v0HHzVh8bPqLgfRdm9cQI5JQO6hOb0wPLqChuCddPx7KMnMoX85YaQ7XrHIjmUhfuQ
	 2MU7Et9Un+ZYe2FrwlwK1uUNzROI8wDLAE4EIyjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 096/265] drm/exynos/vidi: Remove redundant error handling in vidi_get_modes()
Date: Thu, 12 Mar 2026 21:08:03 +0100
Message-ID: <20260312201021.696757409@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225029-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 81158278BD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 0253dadc772e83aaa67aea8bf24a71e7ffe13cb0 ]

In the vidi_get_modes() function, if either drm_edid_dup() or
drm_edid_alloc() fails, the function will immediately return 0,
indicating that no display modes can be retrieved. However, in
the event of failure in these two functions, it is still necessary
to call the subsequent drm_edid_connector_update() function with
a NULL drm_edid as an argument. This ensures that operations such
as connector settings are performed in its callee function,
_drm_edid_connector_property_update. To maintain the integrity of
the operation, redundant error handling needs to be removed.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Stable-dep-of: 52b330799e2d ("drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 007fd8dad3559..4c0d536cb57d4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -326,9 +326,6 @@ static int vidi_get_modes(struct drm_connector *connector)
 	else
 		drm_edid = drm_edid_alloc(fake_edid_info, sizeof(fake_edid_info));
 
-	if (!drm_edid)
-		return 0;
-
 	drm_edid_connector_update(connector, drm_edid);
 
 	count = drm_edid_connector_add_modes(connector);
-- 
2.51.0




