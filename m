Return-Path: <stable+bounces-211144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOGjBMQvcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-211144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:57:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76E5CB0D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40CB6B700DD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8474A421F18;
	Wed, 21 Jan 2026 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ra2H5yfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BC421F17;
	Wed, 21 Jan 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020588; cv=none; b=t9U3w4HMnUnHk4dlJjkmHUbKw4/+BmA4KsHoyFeHzq3L2GTUsqASQjA3D/lCnRRZqcX3aTk3lKOUZpT2/hUfHdSHMkgSzu3dZpLTfIEHzW0jfFz8/hAyV4O2PZ9wZMrO5nWWCsYHepMApLH9s9kkMEFstEtP4vGzjZOwW1mGIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020588; c=relaxed/simple;
	bh=1BwYyTfIaFDfsiHoMaBBy0+iHv6+KImgxHIM4DEQqI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB3cNOgdeY0wFuQN+FUPIcBWNkSqsJIye5Dlji7VhMVSlJn6XjDerJydze6Ztazr5UyyESdvfLUF1HdpmswqSKEHtUo39elzoiojBKoO/J0mziUmjOCxW2sq37S9vwM0zUZLH/9gYofitxDz0XAet4h93ppFdWE/lVJv8OJPqL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ra2H5yfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A25C19422;
	Wed, 21 Jan 2026 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020587;
	bh=1BwYyTfIaFDfsiHoMaBBy0+iHv6+KImgxHIM4DEQqI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra2H5yfo7bjTqxvLvd2yVu6IAxIPAsv+oRUBFdzMK8hHlrkOncUBBY3b8ZOBmUElI
	 6avDAd+zmMbQyCND+/C95UDz2rzIMao529vDwDYXAOkpecu3ZZdhm7+uv7b4aYeNOF
	 f3Ok7WBNwgFUNfb9Qe1TOh+3Y4ma2L2c5YRnffOQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 177/198] dmaengine: sh: rz-dmac: fix device leak on probe failure
Date: Wed, 21 Jan 2026 19:16:45 +0100
Message-ID: <20260121181424.920062887@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211144-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,renesas.com:email]
X-Rspamd-Queue-Id: 6C76E5CB0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 9fb490323997dcb6f749cd2660a17a39854600cd upstream.

Make sure to drop the reference taken when looking up the ICU device
during probe also on probe failures (e.g. probe deferral).

Fixes: 7de873201c44 ("dmaengine: sh: rz-dmac: Add RZ/V2H(P) support")
Cc: stable@vger.kernel.org	# 6.16
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://patch.msgid.link/20251117161258.10679-10-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/sh/rz-dmac.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -854,6 +854,13 @@ static int rz_dmac_chan_probe(struct rz_
 	return 0;
 }
 
+static void rz_dmac_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
 {
 	struct device_node *np = dev->of_node;
@@ -876,6 +883,10 @@ static int rz_dmac_parse_of_icu(struct d
 		return -ENODEV;
 	}
 
+	ret = devm_add_action_or_reset(dev, rz_dmac_put_device, &dmac->icu.pdev->dev);
+	if (ret)
+		return ret;
+
 	dmac_index = args.args[0];
 	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
 		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
@@ -1055,8 +1066,6 @@ static void rz_dmac_remove(struct platfo
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	platform_device_put(dmac->icu.pdev);
 }
 
 static const struct of_device_id of_rz_dmac_match[] = {



