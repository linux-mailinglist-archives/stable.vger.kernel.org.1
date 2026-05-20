Return-Path: <stable+bounces-251936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOCdHof2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D34C5950EF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5181C3090076
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1860370D43;
	Wed, 20 May 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pAEBNBDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0EE233933;
	Wed, 20 May 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299317; cv=none; b=YTkq1D17HTkL3hmkj+vO+zcSsuaH+scCbrZCZFj81FU7TmGMz64pp/QEUkc7WTYcgBGEUCgcF74TLlvw+Hcffj8uETOdeWCV8ER9iAp1Cg6G3h3WjKp9FmKvUVKJTms73BJvfV8fk9PkBtxFx9OQ0HnxUqd6JuGxxhLwU0YakSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299317; c=relaxed/simple;
	bh=k/QCwH0sgBiXKc+sLiK3tyUeqCBxA+Ncui7VcQ9LUHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYUsE8L91gPuzaByJQMmSFiGjXAEOsp8T41GG3+wlpZ2xINbnx/hkC3OP1XeIXZEt17X1+GrQrrLvnHUWScosUepp9SicSkaPESjMTCe8lL++Pz9vM6jp1StyLhKulQagJpsWlxTfM1SrfBwDGZUQTyAa5ou2HRxWTDMvrKm5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pAEBNBDR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2791F000E9;
	Wed, 20 May 2026 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299316;
	bh=ZfMi4vjZMicbeVKj7IQwM2um7UhLNYtiAotf0DSOOx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pAEBNBDR8uZf2KkzicplXqozrKIGsrDbg6zCN4w9zzEti9weEa7qQIU3O1V1Nzv2W
	 mAR8q5UVmlY1d5gp2Z3XtzyS1bade+Y9haSwlzkzj/Q6YSpMwvZRCZArbSpOKw23Uz
	 fHeBIs2ifXBEe9HhLpPEPBMUYLUv+n0kTzqwORhM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Taegyu Kim <tmk5904@psu.edu>,
	Yuho Choi <dbgh9129@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 726/957] fbdev: offb: fix PCI device reference leak on probe failure
Date: Wed, 20 May 2026 18:20:09 +0200
Message-ID: <20260520162150.298546658@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,psu.edu,gmx.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-251936-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2D34C5950EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuho Choi <dbgh9129@gmail.com>

[ Upstream commit 869b93ba04088713596e68453c1146f52f713290 ]

offb_init_nodriver() gets a referenced PCI device with pci_get_device().
If pci_enable_device() fails, the function returns without dropping that
reference.

Release the PCI device reference before returning from the
pci_enable_device() failure path.

Fixes: 5bda8f7b5468 ("video: fbdev: offb: Call pci_enable_device() before using the PCI VGA device")
Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/offb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index f85428e13996b..166b2dff36f59 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -640,8 +640,13 @@ static void offb_init_nodriver(struct platform_device *parent, struct device_nod
 			vid = be32_to_cpup(vidp);
 			did = be32_to_cpup(didp);
 			pdev = pci_get_device(vid, did, NULL);
-			if (!pdev || pci_enable_device(pdev))
+			if (!pdev)
 				return;
+
+			if (pci_enable_device(pdev)) {
+				pci_dev_put(pdev);
+				return;
+			}
 		}
 #endif
 		/* kludge for valkyrie */
-- 
2.53.0




