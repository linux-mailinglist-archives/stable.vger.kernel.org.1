Return-Path: <stable+bounces-221442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMSbH8CVo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:26:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C61CA9AF
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0629D302ECAB
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D528466C;
	Sun,  1 Mar 2026 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBs49Hzp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070732727EB
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328276; cv=none; b=mtH27YbJmGb2Gc9crpdrD030AI8WYInyB+1DXsLeY3Zxb2K/Yzj0zOegGeqY/20Svf2lVp4+iU3sLhBkPFt5W7UlgDhSJXJsPiRVaM0+Xf7qndKhmF5u9cXDiXsbR7vN1l+HPc3iYT5WOB7FPsXH7hGDEirZ+vAH3FLT/I5ErZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328276; c=relaxed/simple;
	bh=WZYvYsbaDrkbZfvWiKNS3s0peY5M15DSV9k5w42HmV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTU85qDXpH6jEXz/QzcYVDfJfRoHT+PX2lXwhWoWKrpY9DJTreeuzHLcXeiHVMXSLbdOBouwOwjcT1sw8AulPPOIrhDJt1Y8MYrh090qAThMWGiPDJgkKVPGsSMsrFLwghHD/yamWvUUlkwHrlczeuub4+rjT8kHcz4U4RhCrGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBs49Hzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA736C19421;
	Sun,  1 Mar 2026 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328275;
	bh=WZYvYsbaDrkbZfvWiKNS3s0peY5M15DSV9k5w42HmV4=;
	h=From:To:Cc:Subject:Date:From;
	b=YBs49HzpxEkVq8XjRg6tNv2rDP6u/A/Zw+izruFxagBlHGThkKXeoZPfjd3jTnk8a
	 X9O/W3gyJw4vQJQCzYyALB/AIv7Ll3KnfavjcyKnGaRY14CJAPo9MOBJZYnvTfxso0
	 iqb3CSy5DfGhzX/SlUF/uX6/1nw7uzCaODS7GDVeoVMbVgn7DVXJD8eW97AkAo50nb
	 TMB5kMOTUBIUPem1xBHDo1WDeyncM2VNbUJHjEz18qhZhM+0B5ItePQ5sAzA1atrCv
	 5/WpnWutqXtXEVtNFG8pohsHb0X96K/6GqHEkSl8nnTdg3Ah/kUb/T+xlOHYZDMm0F
	 9A6Va1dH0FYxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Su Hui <suhui@nfschina.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "bus: fsl-mc: fix an error handling in fsl_mc_device_add()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:33 -0500
Message-ID: <20260301012433.1681444-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221442-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nfschina.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email,linaro.org:email]
X-Rspamd-Queue-Id: 174C61CA9AF
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





