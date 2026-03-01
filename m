Return-Path: <stable+bounces-222141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAosGxOeo2l2IQUAu9opvQ
	(envelope-from <stable+bounces-222141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 854261CCA8D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFE90301B84D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4242FD1BF;
	Sun,  1 Mar 2026 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3iEXUv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7992EC083;
	Sun,  1 Mar 2026 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330003; cv=none; b=s1vXcHZtBX2M/TLbyDvwqiGaLaC3HTwVJpxIkEVFqKA9Gk3vzmUgSMLC5EUvKKVd3ImuVwwZkFRTgWs+b1ikqgqvdgL1Sgu0Eofoaxpanmwl9nDHXsv1heMoj3wyuib3iQJG2FfeaR99+3dz/ikJTuy9w6B3ONA93C02gib62Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330003; c=relaxed/simple;
	bh=Gtw8uFGVxUnO81TZRr6VyieEz03KfvIksKiE+ks+pmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMT6DRj41mVvofDBMtMZ7eyiyG2OKPQftpVOa+jAcDaoA9zQMbcvgd/RtpoqCLyCzvSPwt1rJrPlmv1Waj3A913VViQCF3Mu7Wst6iQMrHw53oDCnEqOpRlfAQMwmeLLPFHLPDIr278cVrDGe9GxiPf7td5rch1z3CbmzFBi+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3iEXUv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0CCC19421;
	Sun,  1 Mar 2026 01:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330003;
	bh=Gtw8uFGVxUnO81TZRr6VyieEz03KfvIksKiE+ks+pmk=;
	h=From:To:Cc:Subject:Date:From;
	b=n3iEXUv0qlXJLiOVmLF317pdNW9Yg3ReREW+QNdRdMFiJcezrzHxlxEtmcBJLUFxC
	 e/8yZ61KMQHuExEIfGfdwpdqCjfpfSYnvuQnjwR5UknFFW7Vk3EH01Q98S3LoqzN6O
	 PjhpBynoipMpZcYL1AVxy0sJFFgrgxluhZc2+bIBmEGG717QgZQBPjFb6WsheMvG4h
	 6MOoPvORzqXyS/ALT1RlfntJJCeoC8eMGiIE+S3dbfinA2uL4PQlMZXb/zZJWD1vFU
	 yvA7UGmx4lSvTpfVVUOg2DbW1gAtWFBrsJACTK1kmmpvmKMvPrtXogtpEHiQyHiHoi
	 nr5Wv+EQ/zn1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	peng.fan@nxp.com
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "remoteproc: imx_rproc: Fix invalid loaded resource table detection" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:20 -0500
Message-ID: <20260301015321.1720088-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222141-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 854261CCA8D
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 26aa5295010ffaebcf8f1991c53fa7cf2ee1b20d Mon Sep 17 00:00:00 2001
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 29 Jan 2026 09:44:48 +0800
Subject: [PATCH] remoteproc: imx_rproc: Fix invalid loaded resource table
 detection

imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
resource table even when the current firmware does not provide one.

When the device tree contains a "rsc-table" entry, priv->rsc_table is
non-NULL and denotes where a resource table would be located if one is
present in memory. However, when the current firmware has no resource
table, rproc->table_ptr is NULL. The function still returns
priv->rsc_table, and the remoteproc core interprets this as a valid loaded
resource table.

Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
there is no resource table for the current firmware (i.e. when
rproc->table_ptr is NULL). This aligns the function's semantics with the
remoteproc core: a loaded resource table is only reported when a valid
table_ptr exists.

With this change, starting firmware without a resource table no longer
triggers a crash.

Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/imx_rproc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 375de79168a1c..f5f916d679051 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
 {
 	struct imx_rproc *priv = rproc->priv;
 
+	/* No resource table in the firmware */
+	if (!rproc->table_ptr)
+		return NULL;
+
 	if (priv->rsc_table)
 		return (struct resource_table *)priv->rsc_table;
 
-- 
2.51.0





