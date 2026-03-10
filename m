Return-Path: <stable+bounces-224207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFdGJtgAsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:30:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA224ADCC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54FE231C8251
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD24387583;
	Tue, 10 Mar 2026 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYbjz4Kc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D1386C02;
	Tue, 10 Mar 2026 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141661; cv=none; b=os0xpc9929KqIErQ/791yWZuLY/jH/Xd9VqCgk+UTEF0Ewp8bE1KucWpSm1/ypqF3M7jIr0aAcIkW01rMeg7TV3Y/p6uXQYDRt7X2qYarXwSxxeiAQqGp2X9gHjU36+r9NgfEaeAfyCAliKp9H6bojj0JALzIEQ2lNQ801NprI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141661; c=relaxed/simple;
	bh=QlPwQHWNJtDuBekB0n/MYW1pGlOcSVTNbaOx5BJCkCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVuV1wDfreHIdJUD02M5/8pNovfRMHq5n2ArB2dD9SSaiLvIr7zTqOFkRxwjVKy9njcJzWIYbRWEYDdCtzVPA/ax4J+EAZ/Bc8rXUBK7vJZjVIwIn2LPqgbaaA4hAhfAL/L4TEU9HEv2WhxN4690xdIphkQWAlZfZm6ijcbDthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYbjz4Kc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEF4C2BC86;
	Tue, 10 Mar 2026 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141661;
	bh=QlPwQHWNJtDuBekB0n/MYW1pGlOcSVTNbaOx5BJCkCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYbjz4Kc4On5eM9+gNSSrw87fbysCARe+gO8YrBCyOMTYBs4PBdmjyumi/aMw/LJ1
	 0DqTgVsH5kHbL8D0OP8hLUVgxE8An4Pm42CB42v+5p3WXFtZWDefozBet52jCRn1Dw
	 8jjcAXvYzoWLTzWWlXN3dWQ1XraNbKATG5cXigKqNuOTrNr+hL1/5ktZ0gTaKMCqLO
	 omWtC+ZBN/VswFdsLR6O6aD3Yksp9hmXh9hjiaNeoRgCn1RHnrXYEOSu7frm6/r8dS
	 gLGb+nRt6SjDttff9KVppjT549/1nPaWoZsaCo9+mtCypUrEFNW21Zy+cp8fb/EhHO
	 N9bEXZBFU4JPw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 028/314] accel/amdxdna: Remove buffer size check when creating command BO
Date: Tue, 10 Mar 2026 07:14:47 -0400
Message-ID: <ffe30b30950fcf2848a64b04f82642cdf4cb008d.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34FA224ADCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224207-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
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
index 7f91863c3f24c..a1c9cc4a2b9d8 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -20,8 +20,6 @@
 #include "amdxdna_pci_drv.h"
 #include "amdxdna_ubuf.h"
 
-#define XDNA_MAX_CMD_BO_SIZE	SZ_32K
-
 MODULE_IMPORT_NS("DMA_BUF");
 
 static int
@@ -745,12 +743,6 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
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
@@ -764,17 +756,7 @@ amdxdna_drm_create_cmd_bo(struct drm_device *dev,
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
@@ -871,6 +853,7 @@ struct amdxdna_gem_obj *amdxdna_gem_get_obj(struct amdxdna_client *client,
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_gem_obj *abo;
 	struct drm_gem_object *gobj;
+	int ret;
 
 	gobj = drm_gem_object_lookup(client->filp, bo_hdl);
 	if (!gobj) {
@@ -879,9 +862,26 @@ struct amdxdna_gem_obj *amdxdna_gem_get_obj(struct amdxdna_client *client,
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


