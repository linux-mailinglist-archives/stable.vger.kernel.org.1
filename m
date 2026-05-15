Return-Path: <stable+bounces-248853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DoACaVLB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D4455395F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A467302F9E2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92603C0607;
	Fri, 15 May 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mERAYznm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1743FF1D8;
	Fri, 15 May 2026 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862797; cv=none; b=fgfnpQNz2IdpNsWcvicvGNhbVmWsVLy96J3azN/WuOCeLItoOe3dgGOEUJXf6BSdaR9msvtTqzXn11AyGBte6wkkTDyGxQ+bQfZbEO8p6ihPqSgFKM33hUZWDbhcPIAtxnGhyFQ989TtRN5KSG9ikMswJEz+YMfvVTkesZS/uBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862797; c=relaxed/simple;
	bh=ys5sD+ApKZgy8pGsWG/LvcrLPujr9nt4TG047F6mS5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVIzvYjWvKNxgx8k9/BBhyv16u2QfXN0H9r7gW/49mAD+gkQXt5dAF6teJgLsVSj/Mt3y6wJOzEsi3SJZgOcuGTaUrMa4kfI0SH+JAQSVrANrofhSS9U/oXtcgKxdgfnbjcK166ka6okE024L+1nxpElUzjwyA3z0Lq42Kbgk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mERAYznm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB54C2BCC9;
	Fri, 15 May 2026 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862797;
	bh=ys5sD+ApKZgy8pGsWG/LvcrLPujr9nt4TG047F6mS5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mERAYznmI66St1ZbmTJR7FhWxr+0sl/2Hs7Zv+iLG9zeBSkPp1E636n+qBbdu+tKw
	 0Ih4EiA6YLC88pfBAJXfJhC1JIZwwQmh6ufx2XPQiNSTHYMuvr1yFjcH1rG4DP20wu
	 ERkwfxva2q9TgMr8JN4d2DleeMrHy8lbV/AmjIKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 187/201] EDAC/versalnet: Fix device name memory leak
Date: Fri, 15 May 2026 17:50:05 +0200
Message-ID: <20260515154702.630675456@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 22D4455395F
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248853-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,alien8.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

[ Upstream commit 8cf5dd235eff6008cb04c3d8064d2acfa90616f1 ]

The device name allocated via kzalloc() in init_one_mc() is assigned to
dev->init_name but never freed on the normal removal path.  device_register()
copies init_name and then sets dev->init_name to NULL, so the name pointer
becomes unreachable from the device. Thus leaking memory.

Use a stack-local char array instead of using kzalloc() for name.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260401111856.2342975-1-ptsm@linux.microsoft.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/versalnet_edac.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -777,9 +777,9 @@ static int init_one_mc(struct mc_priv *p
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
+	char name[MC_NAME_LEN];
 	struct device *dev;
 	enum dev_type dt;
-	char *name;
 	int rc;
 
 	config = priv->adec[CONF + i * ADEC_NUM];
@@ -813,13 +813,9 @@ static int init_one_mc(struct mc_priv *p
 	layers[1].is_virt_csrow = false;
 
 	rc = -ENOMEM;
-	name = kzalloc(MC_NAME_LEN, GFP_KERNEL);
-	if (!name)
-		return rc;
-
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		goto err_name_free;
+		return rc;
 
 	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
 	if (!mci) {
@@ -858,8 +854,6 @@ err_mc_free:
 	edac_mc_free(mci);
 err_dev_free:
 	kfree(dev);
-err_name_free:
-	kfree(name);
 
 	return rc;
 }



