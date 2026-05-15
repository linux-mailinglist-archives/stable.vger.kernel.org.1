Return-Path: <stable+bounces-247438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LQcmBG3NBmpjoAIAu9opvQ
	(envelope-from <stable+bounces-247438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:38:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3754AB08
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B364F3014759
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40F3EFD1A;
	Fri, 15 May 2026 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vrb/Shlo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74033EF667
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830683; cv=none; b=jMDynpJPgMQ329oG9XSTwcW4CO7J+HPKU8n/SYBHtrB+ukE8hJs81KmQ0cA/kAU1JS/D248d16PVM82f6aS0a7AikJTZFUfnri16JK/XZRGADiJzsf/AD/rRtr5FMRR/F8TlfloqqGBooQNLL3sV+Fq2+rcXeQBQ2IWTf9XXDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830683; c=relaxed/simple;
	bh=MGq5AoOrG3ohnc5vGS9bUCuiI8BnH67+4pN2R2o+f2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qAvzf7g9e3QVpq5AhKVMsyEixkzmQwlC18F7h1PM+YnU4gpQJwUHd/RHCdxDozreXUrW64jXy8vFIjwRcHZp/+Fm5ocn7lB1gDzF9GgYkJJipZmjQJD/eAjy05owG8oPTFyuIkVuYpaeBRU2D9Fkm7+4ZLU2bDAIE6LE3o1hwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vrb/Shlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37301C2BCB0;
	Fri, 15 May 2026 07:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778830683;
	bh=MGq5AoOrG3ohnc5vGS9bUCuiI8BnH67+4pN2R2o+f2c=;
	h=Subject:To:Cc:From:Date:From;
	b=Vrb/Shlo/mdNj5fW8jPtJJqwLmkBrR8EZ/LOqpxoVH1WiK0fHW52PQAqYcUdlNzpC
	 uMbhJNYbM35w7Sd5uD6aiZCbmRSk1I+axRmmw3BiptLEB1gGGvCw0y4fCcpJoGm9rR
	 y/Up6KCO5e2fPkOlE1XfkPpkhxKXAEmBrWF1c6FE=
Subject: FAILED: patch "[PATCH] spi: mt65xx: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,leilk.liu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:37:51 +0200
Message-ID: <2026051551-arguably-spiny-d700@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95A3754AB08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247438-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,mediatek.com:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2ad30599cccc572ba2fc11010670eb6e01ea6bfc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051551-arguably-spiny-d700@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ad30599cccc572ba2fc11010670eb6e01ea6bfc Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:31 +0200
Subject: [PATCH] spi: mt65xx: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: a568231f4632 ("spi: mediatek: Add spi bus for Mediatek MT8173")
Cc: stable@vger.kernel.org	# 4.3: ace145802350
Cc: stable@vger.kernel.org	# 4.3
Cc: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0368a26bca9a..96f8555be983 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1325,7 +1325,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		pm_runtime_disable(dev);
 		return dev_err_probe(dev, ret, "failed to register host\n");
@@ -1340,6 +1340,8 @@ static void mtk_spi_remove(struct platform_device *pdev)
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 	int ret;
 
+	spi_unregister_controller(host);
+
 	cpu_latency_qos_remove_request(&mdata->qos_request);
 	if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
 		complete(&mdata->spimem_done);


