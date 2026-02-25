Return-Path: <stable+bounces-218440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLGcF91Tnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D684F18FA83
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64F1631D56F1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C9243376;
	Wed, 25 Feb 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HfRg95KE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E518B0A;
	Wed, 25 Feb 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983261; cv=none; b=iXHmOj47h3Zhas1yK2x3B2LiI+BTiqBOBrMD1WncMghFnfavjaLL7MWEp1hzTbiJcJC4O4IfJZM9ofZAw3msNaAvekie2FAdkZkPTM8N+c9wC14f4y2CLMuQFVCUUPpVX3vvBG2u5vh38WOJve1XziNY5m06GXzfp47B2sGoy7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983261; c=relaxed/simple;
	bh=M2jzVvPnF3W8ryqc3DgYDwZUeo9bwKpKmYxOJyHBKmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGCiVNID+iaWLPgO9rYZTSyQo+wlssNkfBPpO8KZ8hJe9yFVGAp7g6vhks9TqW6Ho2IIz0yhlk3KJvDhFhREcFAysPWITR5xi42KLssksboHJVKbTUFwFyJsfM4WCK1Zh7XED17ayVqq+5slAvHFAlRKtOZcZxsXUic0Wf3yupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HfRg95KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED16C116D0;
	Wed, 25 Feb 2026 01:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983261;
	bh=M2jzVvPnF3W8ryqc3DgYDwZUeo9bwKpKmYxOJyHBKmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfRg95KEU38bebrjf6cJXqJ2WEmDdANneteOoQU69XIpNull9Gyej0KA69n5OLHuW
	 vh5cxoNVLEL5UJhJzatV4VAcp+BgFQUFgCpryGqP7iG1bQ5rOgf8gbxZ1mfpPr3U1W
	 3hhwmvVD1kRgWpR1W9OERGarU+svTYFPjB9gTQ+s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anshumali Gaur <agaur@marvell.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 403/781] octeontx2-af: Fix PF driver crash with kexec kernel booting
Date: Tue, 24 Feb 2026 17:18:32 -0800
Message-ID: <20260225012409.589609411@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218440-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,marvell.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D684F18FA83
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anshumali Gaur <agaur@marvell.com>

[ Upstream commit 2d2d574309e3ae84ee794869a5da8b4c38753a94 ]

During a kexec reboot the hardware is not power-cycled, so AF state from
the old kernel can persist into the new kernel. When AF and PF drivers
are built as modules, the PF driver may probe before AF reinitializes
the hardware.

The PF driver treats the RVUM block revision as an indication that AF
initialization is complete. If this value is left uncleared at shutdown,
PF may incorrectly assume AF is ready and access stale hardware state,
leading to a crash.

Clear the RVUM block revision during AF shutdown to avoid PF
mis-detecting AF readiness after kexec.

Fixes: 54494aa5d1e6 ("octeontx2-af: Add Marvell OcteonTX2 RVU AF driver")
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260203050701.2616685-1-agaur@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 747fbdf2a908f..8530df8b3fdaf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3632,11 +3632,22 @@ static void rvu_remove(struct pci_dev *pdev)
 	devm_kfree(&pdev->dev, rvu);
 }
 
+static void rvu_shutdown(struct pci_dev *pdev)
+{
+	struct rvu *rvu = pci_get_drvdata(pdev);
+
+	if (!rvu)
+		return;
+
+	rvu_clear_rvum_blk_revid(rvu);
+}
+
 static struct pci_driver rvu_driver = {
 	.name = DRV_NAME,
 	.id_table = rvu_id_table,
 	.probe = rvu_probe,
 	.remove = rvu_remove,
+	.shutdown = rvu_shutdown,
 };
 
 static int __init rvu_init_module(void)
-- 
2.51.0




