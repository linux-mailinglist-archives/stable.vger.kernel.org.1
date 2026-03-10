Return-Path: <stable+bounces-223896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M/IDAL9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:14:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2224A2EF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0D630BBF9E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ED7386C39;
	Tue, 10 Mar 2026 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHVGjsv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04743384245;
	Tue, 10 Mar 2026 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140796; cv=none; b=AdTpr2iFzNFF7uSEoKDn4oRwpM7uLH51vRM+mZfGGhqYcfeJu2yM5Jky9g8Z+UDrZxsOIRaSleF8xE0UIGKL4c0YBuXQnDR95bmQQ2s+FCe3hptT9iswqzWXDLUEhAqFqG77QLZtEVUxyPTPZOyjoymMR2fAABw42waOeUM3zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140796; c=relaxed/simple;
	bh=+I80rRBulzhNXibLcg680DDZALu3yvks/YQSnmsQdVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQ8ZUkNFqW5q+bbvY3oA9DR3fJO7yiBiewP9/EVtEiz+voW+z12cY0M9nbbDIbn5koMfP1xBwjtSNOqlxE/Ne1h+EcDPIgoFX+6GSQXLVbjWWXearQ/AtjaQwh0DwaPvo8TC45cJXVqZaRe9tEth4UrspU2jENpTBGkV9NHqiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHVGjsv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174B5C19423;
	Tue, 10 Mar 2026 11:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140795;
	bh=+I80rRBulzhNXibLcg680DDZALu3yvks/YQSnmsQdVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHVGjsv6X67i0bOWuYFV9OyR3wxhRY3cSVEgXWtj9CzLjHEJUkaWoxWgOSa8UZMfo
	 RwA6g40dwIA5i7P86B0xjnYoOoyHtTXzPVWoHAcpv7kgzj7KJ+DoBYl7zhPE2eJAzc
	 dLaHyJj4ydb8AuUMXy4gILTuwpM/2fIpPIabiqti6GVz7kf7YkZ9VFfJkTTsNnronf
	 gC1dW75ay1B/nzVGBpvlBdEo7Jnn1aHsmkjx96pnI0HC9uO6xKfBa9RUV4q3e0yG4d
	 E1CHmJq73+sUjbIV/OMZvthYSXwx3mUW1pGU0xtB8xuCHp8scqBD+rT/+e3gFNi+5I
	 RstCDHqPpl8mA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 032/311] accel/amdxdna: Remove buffer size check when creating command BO
Date: Tue, 10 Mar 2026 07:01:19 -0400
Message-ID: <44d727e0e643fdf3cc8bd3eed416d80765240711.1773140655.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: E5C2224A2EF
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-223896-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 08fe1b5166fdc81b010d7bf39cd6440620e7931e ]

Large command buffers may be used, and they do not always need to be
mapped or accessed by the driver. Performing a size check at command BO
creation time unnecessarily rejects valid use cases.

Remove the buffer size check from command BO creation, and defer vmap
and size validation to the paths where the driver actually needs to map
and access the command buffer.

Fixes: ac49797c1815 ("accel/amdxdna: Add GEM buffer object management")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260206060237.4050492-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 38 ++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index dfa916eeb2d9c..56341b7668b10 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -21,8 +21,6 @@
 #include "amdxdna_pci_drv.h"
 #include "amdxdna_ubuf.h"
 
-#define XDNA_MAX_CMD_BO_SIZE	SZ_32K
-
 MODULE_IMPORT_NS("DMA_BUF");
 
 static int
@@ -746,12 +744,6 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(dev);
 	struct amdxdna_gem_obj *abo;
-	int ret;
-
-	if (args->size > XDNA_MAX_CMD_BO_SIZE) {
-		XDNA_ERR(xdna, "Command bo size 0x%llx too large", args->size);
-		return ERR_PTR(-EINVAL);
-	}
 
 	if (args->size < sizeof(struct amdxdna_cmd)) {
 		XDNA_DBG(xdna, "Command BO size 0x%llx too small", args->size);
@@ -765,17 +757,7 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
 	abo->type = AMDXDNA_BO_CMD;
 	abo->client = filp->driver_priv;
 
-	ret = amdxdna_gem_obj_vmap(abo, &abo->mem.kva);
-	if (ret) {
-		XDNA_ERR(xdna, "Vmap cmd bo failed, ret %d", ret);
-		goto release_obj;
-	}
-
 	return abo;
-
-release_obj:
-	drm_gem_object_put(to_gobj(abo));
-	return ERR_PTR(ret);
 }
 
 int amdxdna_drm_create_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
@@ -872,6 +854,7 @@ struct amdxdna_gem_obj *amdxdna_gem_get_obj(struct amdxdna_client *client,
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_gem_obj *abo;
 	struct drm_gem_object *gobj;
+	int ret;
 
 	gobj = drm_gem_object_lookup(client->filp, bo_hdl);
 	if (!gobj) {
@@ -880,9 +863,26 @@ struct amdxdna_gem_obj *amdxdna_gem_get_obj(struct amdxdna_client *client,
 	}
 
 	abo = to_xdna_obj(gobj);
-	if (bo_type == AMDXDNA_BO_INVALID || abo->type == bo_type)
+	if (bo_type != AMDXDNA_BO_INVALID && abo->type != bo_type)
+		goto put_obj;
+
+	if (bo_type != AMDXDNA_BO_CMD || abo->mem.kva)
 		return abo;
 
+	if (abo->mem.size > SZ_32K) {
+		XDNA_ERR(xdna, "Cmd bo is too big %ld", abo->mem.size);
+		goto put_obj;
+	}
+
+	ret = amdxdna_gem_obj_vmap(abo, &abo->mem.kva);
+	if (ret) {
+		XDNA_ERR(xdna, "Vmap cmd bo failed, ret %d", ret);
+		goto put_obj;
+	}
+
+	return abo;
+
+put_obj:
 	drm_gem_object_put(gobj);
 	return NULL;
 }
-- 
2.51.0


