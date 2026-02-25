Return-Path: <stable+bounces-219281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO1tNzudnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:56:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0619293D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EEDC3024297
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07F4C81;
	Wed, 25 Feb 2026 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtFZCsTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FF2D6E74;
	Wed, 25 Feb 2026 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002613; cv=none; b=fA+MM5mvOyGfhe2PjLE9dz69N9R6GnZm/7L+96BP4yrGwJpVD2Xz+UlAWIs1BwgQOQShF7d9Ue+WWnh6ZLLpAXwYb75ySYqMkgIc1CboMCljkxDfXqHdcC1tI65zQw5q2KWew5FI19O7KOWo5GSngZNPqagi1Lcv5ZX6XUK33YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002613; c=relaxed/simple;
	bh=z9/tr1LfYETC0IuBkzM4ybcp2i4jHNM+ebpae90bzhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbTVHaswTG/mpGziE9JbrQsGinKuTjgWxHZkSbllzpOs/cKtVAKgmKvErrIFAw9mUI4esyCQg6Chltr59grz0VcKpAvHovJQ+PCLUNbNGruVERQoXLTlp3Bv7GcNR1ynxYsqPbwRngdaPu4rHUmpitR/r1PY6LyVsWKTOetYoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtFZCsTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779EBC116D0;
	Wed, 25 Feb 2026 06:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002613;
	bh=z9/tr1LfYETC0IuBkzM4ybcp2i4jHNM+ebpae90bzhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtFZCsTBCWIcMcNO/2Ww2nR2BFrWT3gqSYmCNLzWKOjydQ7PnXG40rHctpUOT9mIj
	 4wv6HIMy6cf1l8CpW8mB2aKDyCvQS6CJRcEB5HBrBjikFoXcIjHut+kMFMYzP7tjZL
	 kHVTn/4CWnJzb4Sw2DWcNLf/tRCGK9YMW7mvVQOQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>,
	Jani Partanen <jiipee@sotapeli.fi>,
	Lucas De Marchi <demarchi@kernel.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 365/641] mtd: intel-dg: Fix accessing regions before setting nregions
Date: Tue, 24 Feb 2026 17:21:31 -0800
Message-ID: <20260225012357.454578763@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219281-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 13C0619293D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit 779c59274d03cc5c07237a2c845dfb71cff77705 ]

The regions array is counted by nregions, but it's set only after
accessing it:

[] UBSAN: array-index-out-of-bounds in drivers/mtd/devices/mtd_intel_dg.c:750:15
[] index 0 is out of range for type '<unknown> [*]'

Fix it by also fixing an undesired behavior: the loop silently ignores
ENOMEM and continues setting the other entries.

CC: Gustavo A. R. Silva <gustavoars@kernel.org>
CC: Raag Jadav <raag.jadav@intel.com>
Reported-by: Jani Partanen <jiipee@sotapeli.fi>
Closes: https://lore.kernel.org/all/caca6c67-4f1d-49f1-948f-e63b6b937b29@sotapeli.fi
Fixes: ceb5ab3cb646 ("mtd: add driver for intel graphics non-volatile memory device")
Signed-off-by: Lucas De Marchi <demarchi@kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/mtd_intel_dg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index b438ee5aacc34..114e69135b8d9 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -738,6 +738,7 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
 	kref_init(&nvm->refcnt);
 	mutex_init(&nvm->lock);
+	nvm->nregions = nregions;
 
 	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
 		if (!invm->regions[i].name)
@@ -745,13 +746,15 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
 		char *name = kasprintf(GFP_KERNEL, "%s.%s",
 				       dev_name(&aux_dev->dev), invm->regions[i].name);
-		if (!name)
-			continue;
+		if (!name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		nvm->regions[n].name = name;
 		nvm->regions[n].id = i;
 		n++;
 	}
-	nvm->nregions = n; /* in case where kasprintf fail */
 
 	nvm->base = devm_ioremap_resource(device, &invm->bar);
 	if (IS_ERR(nvm->base)) {
-- 
2.51.0




