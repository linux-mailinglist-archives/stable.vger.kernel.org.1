Return-Path: <stable+bounces-243384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ht+Oxqr+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F754BF1B7
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 634EE306A482
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A343DC4D5;
	Mon,  4 May 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zrV4+nu5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C540DFD4;
	Mon,  4 May 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903745; cv=none; b=WOvjzvOrWyfwijK3pVXoTyy2Jl5bilIoCvbjIpwGE2WxwD3laP9MsuXNyV8Ku5zje7IC6q9jby+ohoxqAujpvCrjzutKcgKPJGWlualkTInCL6Jwj85RU+3uoVhVTXCdoMPrq8l7EopetUjclnuVqzlnBpMHDd0TCLopgZDTIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903745; c=relaxed/simple;
	bh=n2woXKzLEH6iAKYo2MkY+cT8JABedyIAgH62Gu5pi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mT5CwYTe/F5c7HksM8hMzUxbrPiF8mvSiJwRm8xdpMooD26PZNJ19KK52T+AwLXt7XMUN64UY8uNbv1n3W4WJ3l9EcKwVkyHws4pnXpmH3hNNctStXE6tKVSZHKkY2JMZbaqBWua8TZHnNHWAsVffs4i0Fw6KzHsFbTHofLyMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zrV4+nu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34E3C2BCB8;
	Mon,  4 May 2026 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903745;
	bh=n2woXKzLEH6iAKYo2MkY+cT8JABedyIAgH62Gu5pi3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zrV4+nu5aBO2eXxKshGkeNnkDnnMRqmPfqSt3NLr8XaQq3deTp3Z6Db8LU9yNcwFN
	 TaFZJJx0cYCRmLFHCdh+DdF97SJF5dinNDPK/20Jxgv4HjJKeyFLA9C1FM6TUHY0ZK
	 C48h0HqASDBDhdWurphcnmB8zFmR7+t5lkMxbi0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	stable@kernel.org
Subject: [PATCH 6.18 045/275] EDAC/versalnet: Fix device_node leak in mc_probe()
Date: Mon,  4 May 2026 15:49:45 +0200
Message-ID: <20260504135144.616206928@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 47F754BF1B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-243384-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,alien8.de,amd.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,alien8.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit 5c709b376460ff322580c41600e31c02f7cc0307 upstream.

of_parse_phandle() returns a device_node reference that must be released with
of_node_put(). The original code never freed r5_core_node on any exit path,
causing a memory leak.

Fix this by using the automatic cleanup attribute __free(device_node) which
ensures of_node_put() is called when the variable goes out of scope.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/20260323-versalnet-v1-1-4ab3012635ef@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/versalnet_edac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -868,12 +868,12 @@ static void remove_versalnet(struct mc_p
 
 static int mc_probe(struct platform_device *pdev)
 {
-	struct device_node *r5_core_node;
 	struct mc_priv *priv;
 	struct rproc *rp;
 	int rc;
 
-	r5_core_node = of_parse_phandle(pdev->dev.of_node, "amd,rproc", 0);
+	struct device_node *r5_core_node __free(device_node) =
+		of_parse_phandle(pdev->dev.of_node, "amd,rproc", 0);
 	if (!r5_core_node) {
 		dev_err(&pdev->dev, "amd,rproc: invalid phandle\n");
 		return -EINVAL;



