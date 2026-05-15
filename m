Return-Path: <stable+bounces-248158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFGUN1hMB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:39:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B9553B0A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C3B230E4746
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A13E7BC7;
	Fri, 15 May 2026 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mabhpS5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DB3B6354;
	Fri, 15 May 2026 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861019; cv=none; b=H6sJZNGy4o7yUWyHnumjK2Jg1v3TY0qzY7UFxro55V3nRrXju1gBsbqmMvbqEk5AzpoGzQ3J78TGXr5Zp2A1kw1doZ8Xu9vD3DenE9m7bv7rMAIJ/An/Kh865ieDKotgdJAH84Ox1af0u2RfXkYeJv++VCRRuElkB+jD6cYZoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861019; c=relaxed/simple;
	bh=/5VYXpVf2pk357x3AFG3jgNDX6EXD+FviH+k/Ui07Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgxM34XaMBj0JWmjyWpQVtOoaktFAETBeseqEX1tRPXb/019hZ1Is9j7ZoIYq769iwtiXJSVBglyKqP7iSKHLd/TSW3Rd6wey/E3IExlKugNGqQ6DmM+DXayQuT8AdUVQRXOtmNpKGJvNHTJPDK6Uu9ea1T+1XddjqelB9qM5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mabhpS5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6755BC2BCB0;
	Fri, 15 May 2026 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861019;
	bh=/5VYXpVf2pk357x3AFG3jgNDX6EXD+FviH+k/Ui07Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mabhpS5ph8T7GKFwg0qCf9IUtmYgZ5s7ZYGDRbJFaLbpZnmyLJuS6z07knQD3dsUB
	 R1iZSHNUH6ImRLVeHgoPnlbPvtA8U9vGd3FFotb/0iJkmS/2gcdhkONUCKYo0xlIPM
	 QpiZnkBYI8Edtj8II4XcM3f0YGZ3ufzOxlNrGSuo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wenshan Lan <jetlan9@163.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 169/474] dmaengine: idxd: Fix leaking event log memory
Date: Fri, 15 May 2026 17:44:38 +0200
Message-ID: <20260515154718.679963685@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A40B9553B0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-248158-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit ee66bc29578391c9b48523dc9119af67bd5c7c0f ]

During the device remove process, the device is reset, causing the
configuration registers to go back to their default state, which is
zero. As the driver is checking if the event log support was enabled
before deallocating, it will fail if a reset happened before.

Do not check if the support was enabled, the check for 'idxd->evl'
being valid (only allocated if the HW capability is available) is
enough.

Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-10-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index e769e1f0d28b2..13af4ef2f43f0 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -813,10 +813,6 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	if (!evl)
 		return;
 
-	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
-	if (!gencfg.evl_en)
-		return;
-
 	mutex_lock(&evl->lock);
 	gencfg.evl_en = 0;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
-- 
2.53.0




