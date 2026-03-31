Return-Path: <stable+bounces-232508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFVbK2YBzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-232508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884136E5AC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8153A30C2AA6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE093195F0;
	Tue, 31 Mar 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1w3S9fK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73E310645;
	Tue, 31 Mar 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976929; cv=none; b=O5vroqZhRlg0XkG2PNyKILtOV4d16maYICzNVwOdKEMZRHDzkDYKg4h4NV2CIK7+HI9UxLzMQEwZKRFH9N25XbYAXTeE4u0MmMW2CqbXYLq+FpHBtjx4KQwEIDqO3DdKvHmODnPSAldZm3YpR+POgTmGJyONTwzXw8hb2tliH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976929; c=relaxed/simple;
	bh=0K8xiby8NlOXIAQlshDF67my8XXu9Qx14kww9oIw03o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntKnRJfQ9t61J7bbseSml0gU1KiY770tFz6aVIF8MveoLoxZp9slstF/PPM2cuH7oyVYUdA7iiopMYnBsWiwRCdr62li4TXb5+AxWeMeXlMwwVjT7fZ7vYF5E1ojracC1oN9a5xA66YSZEG0fjH6WO8gLZbnmSyZ4zg2egltxDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1w3S9fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EF2C19423;
	Tue, 31 Mar 2026 17:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976928;
	bh=0K8xiby8NlOXIAQlshDF67my8XXu9Qx14kww9oIw03o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1w3S9fKc/SLtPT9lfozfJkwdyOcvHe3Kh/lmUVtxXMce3PUSVmJYDmLsclzIkW2F
	 QvKLZtDKnrgDsX0YP/uWtdp5O1565TlYOU8VRNMlWQQt9e8lONDN7jLEUkutYhuBea
	 pvwZynTc+RFgVrz3tQAoGq/G8rcR33kxYIjeUyH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 283/309] dmaengine: idxd: Fix crash when the event log is disabled
Date: Tue, 31 Mar 2026 18:23:06 +0200
Message-ID: <20260331161803.986688322@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232508-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 7884136E5AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 52d2edea0d63c935e82631e4b9e4a94eccf97b5b ]

If reporting errors to the event log is not supported by the hardware,
and an error that causes Function Level Reset (FLR) is received, the
driver will try to restore the event log even if it was not allocated.

Also, only try to free the event log if it was properly allocated.

Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-2-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/device.c | 3 +++
 drivers/dma/idxd/init.c   | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5cf419fe6b464..c599a902767ee 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -815,6 +815,9 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_evl *evl = idxd->evl;
 
+	if (!evl)
+		return;
+
 	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
 	if (!gencfg.evl_en)
 		return;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2acc34b3daff8..449424242631d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -962,7 +962,8 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
 
 	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
 
-	idxd->evl->size = saved_evl->size;
+	if (idxd->evl)
+		idxd->evl->size = saved_evl->size;
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *saved_group, *group;
-- 
2.53.0




