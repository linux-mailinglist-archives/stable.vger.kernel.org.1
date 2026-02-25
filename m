Return-Path: <stable+bounces-218302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCvYM0VSnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FC018F2D2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F0343079893
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C801D5ABA;
	Wed, 25 Feb 2026 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0a5JTyXr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDB2BAF7;
	Wed, 25 Feb 2026 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983104; cv=none; b=j33wpzTnjI0jBZ4ZhqPQg8FDZ0P026qkX/YcTUBIIKLc4CiMZkgFquAq7FhYle4LrUItfjHosk+DB0W+zCIgcI42wKV2QqgTM2FoGx50KXQy9MuVEZLDC8p7yymhTHRJR6vZyQ95KMiaeGKcd+OIV0KQdQ11r7Rku9nR0xal0DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983104; c=relaxed/simple;
	bh=KkB1Ewt5Zc/MrpWgP4Yf9HXP1Y2nV99aDX9PXL2dwpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g//EJBPwlSaEh0os3MzmxLmmTy03JTuxgaNNLpGx7MTcYv78phVPVlQuwSc/H42wG2eAEYvjq5yeqhVJxlF1sCbMwsLIeVsGPEnepwFFd41IzYtRp7LfK09o/xLMFmfvE+JvOgKtyXE4OqlO9NedvdW0kTto9QTrC3PfyuZ73Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0a5JTyXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE54AC116D0;
	Wed, 25 Feb 2026 01:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983103;
	bh=KkB1Ewt5Zc/MrpWgP4Yf9HXP1Y2nV99aDX9PXL2dwpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0a5JTyXrvVFuoQ+G2CpjAd1CyHWfvx1/2f0XO0OrDe5Xm39psJrt5QLlSA/gYrVe+
	 8peEf/cRhVIX4ZeDbnyZ9BfcyGKBue2MPFuaPC2Kh6HcYUrUC80H1vycAwJq/7yp/3
	 T+WUpG9q6UG6dLKS1j/ODUlYzRodeXXWvvACAzUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 265/781] accel/amdxdna: Fix notifier_wq flushing warning
Date: Tue, 24 Feb 2026 17:16:14 -0800
Message-ID: <20260225012406.196100242@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218302-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 13FC018F2D2
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit b36178488d479e9a53bbef2b01280378b5586e60 ]

Create notifier_wq with WQ_MEM_RECLAIM flag to fix the possible warning.

  workqueue: WQ_MEM_RECLAIM amdxdna_js:drm_sched_free_job_work [gpu_sched] is flushing !WQ_MEM_RECLAIM notifier_wq:0x0

Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260113173624.256053-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_pci_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 1973ab67721be..fcc9be23b3de5 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -282,7 +282,7 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		fs_reclaim_release(GFP_KERNEL);
 	}
 
-	xdna->notifier_wq = alloc_ordered_workqueue("notifier_wq", 0);
+	xdna->notifier_wq = alloc_ordered_workqueue("notifier_wq", WQ_MEM_RECLAIM);
 	if (!xdna->notifier_wq)
 		return -ENOMEM;
 
-- 
2.51.0




