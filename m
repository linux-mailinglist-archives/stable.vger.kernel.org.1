Return-Path: <stable+bounces-224218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG0JJjoCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B822C24B156
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B68243053A1D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D466387368;
	Tue, 10 Mar 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwq689C9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6CB3876A3;
	Tue, 10 Mar 2026 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141916; cv=none; b=JNGx3XZadIgUVmfE8MtllTSwaPW64Zo1/fbCMaGVBSas0wUlJ7Y9VMeqeZiRJQFpH+V7YNhnRPJiuxPv5SfOcQ2/x5YuzmzcGCaBkKEVBP7EdnI/X/Z8FCzG1CFDBzEjuZRRsiuOLklRktzB33OPYnV0/9XLGboVsA1IVSOKlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141916; c=relaxed/simple;
	bh=wnnTIpP2xgT8QfksgPWFF4X5cTl+pBsaGxrye/5acyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVegOGjfBHLilqDEOVuzf3CIBK0v3zH3PDXSUQArc6IYAqK0Z5myLHI4K0svejyF8CAHwRUmX77ySqKMwfFaIWG+EQbHWUw0UJ4Le/u5HXu4k7H+RnglsTrSGWs768qxyK6Q/iwyiBc0y7S8NMl374UAJy1m+IweE+Jq70LAQX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwq689C9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C66C19423;
	Tue, 10 Mar 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141916;
	bh=wnnTIpP2xgT8QfksgPWFF4X5cTl+pBsaGxrye/5acyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwq689C91/eyyWMY6C4hnV8ofelDp4EOST5muhjeHrf9wlqX6F2kUEJ8ygzTX40i3
	 5UtwK7x99EPL13c0F8a/aIJtoJWCB0UL0O3z6LDMAWo+HNNlkAC6S0IzocY6xmF8ph
	 lWogWa6I8PmajQ5pjLQMuo5pIOdbVysDT9oOvdTBH9doUfcgafG2MFZjDWy5MStiTc
	 TFBfhnbJO8BdC8VG8dSJWCrYBHedXF4mx+tlgoDNVoX0ACGjpC/Q163NKD0BrKpNsw
	 9WadDBXPoRLR5kYRt3/qBlpL5o1mr738oeHMoiedcpOkYiginI1x/uD4iTJZrV3c+F
	 EAlHgiMPp6muA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 039/314] drm/client: Do not destroy NULL modes
Date: Tue, 10 Mar 2026 07:14:58 -0400
Message-ID: <c3c672bef2f48c609b5fac7002697bc115210b79.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B822C24B156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224218-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action

From: Jonathan Cavitt <jonathan.cavitt@intel.com>

[ Upstream commit c601fd5414315fc515f746b499110e46272e7243 ]

'modes' in drm_client_modeset_probe may fail to kcalloc.  If this
occurs, we jump to 'out', calling modes_destroy on it, which
dereferences it.  This may result in a NULL pointer dereference in the
error case.  Prevent that.

Fixes: 3039cc0c0653 ("drm/client: Make copies of modes")
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260224221227.69126-2-jonathan.cavitt@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_client_modeset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 9c2c3b0c8c470..eaf71c9ecf136 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -930,7 +930,8 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 	mutex_unlock(&client->modeset_mutex);
 out:
 	kfree(crtcs);
-	modes_destroy(dev, modes, connector_count);
+	if (modes)
+		modes_destroy(dev, modes, connector_count);
 	kfree(modes);
 	kfree(offsets);
 	kfree(enabled);
-- 
2.51.0


