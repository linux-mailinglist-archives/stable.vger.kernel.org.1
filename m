Return-Path: <stable+bounces-250394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC0BFgXyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E335943CE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11FF73034AB4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07FD3BA246;
	Wed, 20 May 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xI10r99D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFE38F945;
	Wed, 20 May 2026 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295299; cv=none; b=VCVHyzGpySFCNuFcos/g5QrwEOtWCNM/+1fwKvNfNXkTnrscaMYIkpOf/HhYuS7HqTLPyTei6ZPIIsIHCQL3escctqeZCadaTPSUW6LYLj2ANdBiduKUYwEgKhBmmAUDxCF02MGqSucLmp8hg4R2tEHD3rwQbxhJvNSaJBxQNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295299; c=relaxed/simple;
	bh=KlM0Jh5L7K0ijra5P9IedM2hZcOfVRYU0HVMfDXBsg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnK5nSyL+JFn52O+E1Izx3HTZ5REf9mud0DjiXzN4E+D3T8WUa7deocYhjRvMcuP2C4SMKeDSEWsvI4TdjL9X3Afqba9wCD0NcrYSuOvWM6FyZUw6NnGk0yYzc8TzfJbNiBxogjXY3To0d3rkDfcqnrsqYG9AXBYP8KBUddCACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xI10r99D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD86B1F000E9;
	Wed, 20 May 2026 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295298;
	bh=77x4mLKG+AlFyPqk9LwppzlMLHooT2qOf+Nw9Ob0PFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xI10r99DlasCvJD5v5EQas/etHIskBlkW9PRw8rj0GkLB+R/DyJL3GBehrhFvezD6
	 fPtHd/RY5bB0fj2sGqqWXN1P7R183sEE6yT+hRD/0fOE26qNCJkwX+1I+irzqQPB62
	 OMm1CXA4C9L/pGqqEHPbJ+P6SwQn32XSKL1Ydg/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0366/1146] pmdomain: imx: scu-pd: Fix device_node reference leak during ->probe()
Date: Wed, 20 May 2026 18:10:16 +0200
Message-ID: <20260520162156.483082153@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250394-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nxp.com,linaro.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Queue-Id: A8E335943CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit c8e9b6a55702be6c6d034e973d519c52c3848415 ]

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In imx_sc_pd_get_console_rsrc(), it does not release the reference.

Fixes: 893cfb99734f ("firmware: imx: scu-pd: do not power off console domain")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 01d465d88f60d..3ec33667a308c 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -326,6 +326,7 @@ static void imx_sc_pd_get_console_rsrc(void)
 		return;
 
 	imx_con_rsrc = specs.args[0];
+	of_node_put(specs.np);
 }
 
 static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
-- 
2.53.0




