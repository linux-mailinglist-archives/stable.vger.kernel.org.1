Return-Path: <stable+bounces-222306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGzIF6Ofo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:08:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C541CD106
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 313313026898
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF02FC881;
	Sun,  1 Mar 2026 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFFZv+Wd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A352673AA
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330553; cv=none; b=fCiaSLYMA/uViPR/jGaYoCiH7Zx+S3NcJx0dNAbBtTW2zzMyjppuC0CJL3z1+Cajrc0oiMmkAbhEJHMRzIyZkqwR+4ob4pXV/x3zBALKjzZjSiGIkqkv2zDdyLEugBlpdOY77in89dAray30IRGVXa50MkStkIwGmxjXFhiipoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330553; c=relaxed/simple;
	bh=R4wgXi7m9MAehuW90Ukk0wrh5/GcAEwQj4ow3aXRmtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iF6ecMyzJLCVNI0uScyNe6rT3T1pXtf2QoFEebn4ZNjoCanmaZ01ZBIMVKjpF4/gIWKVs7wDyMo2NK0Lyw0r0pfYCUU5cQavxxJvDmvkSQxdHYkY3ePdgti+4HR9sgaSMemGThPEoRE2w3DqVY45sPSH3kPRC1pzJ0NHqq/HDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFFZv+Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8F5C19421;
	Sun,  1 Mar 2026 02:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330553;
	bh=R4wgXi7m9MAehuW90Ukk0wrh5/GcAEwQj4ow3aXRmtU=;
	h=From:To:Cc:Subject:Date:From;
	b=QFFZv+WdA0VA7eUl40NBJ88vQAWA0cFiuIO+NktVQZAU0t+Yu5cN+CBQEqxJi0Wme
	 1q2wlxnNiHsWjbTh/9TnAM2hm8F+clGd/I8fEy2JrjEYlpkeQ8K8saAb0b/B3dw8Nj
	 mATGmv29UDSSP3ASobMvv4yCI5W5ORkPpQJ+Fx7cmWNDwl6dM2oisDV1XMxOgoZmuD
	 JqqrT8Rm/nlw/16szdZY6l9r+Nx4dv+gIVc+5DsLgiyZq9Zf2yC8ZjrC5XJWTCjxqs
	 s7PBD0LEncFkkUCyTxC+Rl7QGwJzvDN5aSnQUmRSvfnXkMl5ICOW0WS2t+Vg4OIuZR
	 0gd1Ekar/td5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "bus: fsl-mc: fix an error handling in fsl_mc_device_add()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:02:30 -0500
Message-ID: <20260301020231.1730299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222306-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nfschina.com:email,nxp.com:email,iscas.ac.cn:email,linaro.org:email]
X-Rspamd-Queue-Id: C1C541CD106
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 52f527d0916bcdd7621a0c9e7e599b133294d495 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Sat, 24 Jan 2026 18:20:54 +0800
Subject: [PATCH] bus: fsl-mc: fix an error handling in fsl_mc_device_add()

In fsl_mc_device_add(), device_initialize() is called first.
put_device() should be called to drop the reference if error
occurs. And other resources would be released via put_device
-> fsl_mc_device_release. So remove redundant kfree() in
error handling path.

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain/
Signed-off-by: Su Hui <suhui@nfschina.com>
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 08b99b0b342f3..007223549887d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -896,11 +896,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	return 0;
 
 error_cleanup_dev:
-	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	put_device(&mc_dev->dev);
 
 	return error;
 }
-- 
2.51.0





