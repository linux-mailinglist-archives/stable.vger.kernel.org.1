Return-Path: <stable+bounces-255394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJHeH0OiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:14:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E208D5F828C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEC63266F16
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137E32ABC0;
	Thu, 28 May 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eoq9DSyR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB542F691F;
	Thu, 28 May 2026 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998787; cv=none; b=IuBKxP+cQULdHOFkMJUVV/0ahJooFHirswIFoIiaPBpcAW0tEsDDX7oAmQZQu7WTyrYUUH13W2CyAugyL5Oiivf/IorZmf0ZAhSoGY7LWt7mFoUrGgQTZbxI6oNXe8G82LbbnyHw/y0hhZUzgVdlJ/xAlopnv0jnzXPgdUTNwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998787; c=relaxed/simple;
	bh=wvU2z8GjfFO2z/sehMin5Y3wMWsA8UviIYrhTExNSH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ud1vhqW0Ham5wbO3NcMmV2B3iX+rV99/K9JKQolLdeiC2PNgOCLwqmHFAA4V5sQ4OdUA5yOEqMDeNsq/M9PhuWX5OxiKgzr9AJIhqEUyyEsHl9iA8WONB0qnoKpIv8SUDISXjrmkxUHFssY3ZDHH4bNf2GTeClV74p0ev/LdxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eoq9DSyR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841531F000E9;
	Thu, 28 May 2026 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998786;
	bh=Z3lrefzaQxafsB56Y1kHCF1LvU3GK64OHtijSyhvK6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eoq9DSyRTJSOwQ4y1xSQLke6FzkxNfBHpzxRwd4Latt1PuBl9f521IT23jiVugx3+
	 zpLPA2b99CuBhz142Te0darIPk4QJ4sBZvURgbNDOYRGmUJf1lAbz2wBaxIwtGWk5I
	 aamq5syg7xszuTMgk1dVMuTV6ivCyqYlItG5ecGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	John.Harrison@Igalia.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 297/461] drm/msm/dpu: dont mix devm and drmm functions
Date: Thu, 28 May 2026 21:47:06 +0200
Message-ID: <20260528194655.817968094@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wanadoo.fr,oss.qualcomm.com,Igalia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255394-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:email,qualcomm.com:email,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: E208D5F828C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit c0c70a11365cba7fba25a77463582bcec0f7846e ]

Mixing devm and drmm functions will result in a use-after-free on msm
driver teardown if userspace keeps a reference on the drm device:
The WB connector data will be destroyed because of the use of
devm_kzalloc()), while the usersoace still can try interacting with the
WB connector (which uses drmm_ functions).

Change dpu_writeback_init() to use drmm_.

Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: John.Harrison@Igalia.com
Patchwork: https://patchwork.freedesktop.org/patch/722656/
Link: https://lore.kernel.org/r/20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 7545c0293efbd..6f2370c9dd988 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_edid.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 
 #include "dpu_writeback.h"
 
@@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
 	struct dpu_wb_connector *dpu_wb_conn;
 	int rc = 0;
 
-	dpu_wb_conn = devm_kzalloc(dev->dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
+	dpu_wb_conn = drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KERNEL);
 	if (!dpu_wb_conn)
 		return -ENOMEM;
 
-- 
2.53.0




