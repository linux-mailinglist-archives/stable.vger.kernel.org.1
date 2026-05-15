Return-Path: <stable+bounces-247464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P8VNO7NBmpjoAIAu9opvQ
	(envelope-from <stable+bounces-247464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:40:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE854ABAC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D05C03014146
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23039656D;
	Fri, 15 May 2026 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zid0lhQt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365137DAB9
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830829; cv=none; b=JE2GuQmxO4kG87mRtME5axAumgmUQvS6X91780NotSHzS8TxpUGPryVEyYc0e7nTLzTC8f8ZpLacK6ph9abFMdEn+5HVu4rlfCAQG3MkuP//dHItMtTLYX76jdShOO6LRmqolaj82M/BjfxIGb+1+sH54qqacaHR5CGZNM2zgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830829; c=relaxed/simple;
	bh=jY7iz5KTUHjCWmfDyaCBlRd/CgoaAxWR3aleOFBwCX4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aPp1Z9h+uJK42cy4CsrI2pBEv+1Dm/XBaXitNm5aFwkYhlB9r2+HdmMeZH/Bpcq1sAH7afoTi+Dx946sbbAmjiDRJuU/ig7ankh9isT1A7lTbe7OhbPPWlqZGgtspfWXNtq6zXTIDiJc6rXkck2RmpnP11oRlP5smWwOsLk8zRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zid0lhQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC90C2BCB0;
	Fri, 15 May 2026 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778830828;
	bh=jY7iz5KTUHjCWmfDyaCBlRd/CgoaAxWR3aleOFBwCX4=;
	h=Subject:To:Cc:From:Date:From;
	b=zid0lhQt2DBUQeBelYqa/vUbz8szfNzo8gn8JzgXb4j9D+9XfoRrwpn1hc8hSlXEQ
	 6yk2mCjZcJB2GVZ27HnBxWFnNyJTugqvTWmhaKtCysn/cbLNkH/4Py7kp8mPHHolfM
	 V8Z4MgTUW/TS3vcx5NL5I2DoV0eUZFFGITNRGwJo=
Subject: FAILED: patch "[PATCH] spi: pl022: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:40:29 +0200
Message-ID: <2026051529-woven-tradition-4188@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 94AE854ABAC
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
	TAGGED_FROM(0.00)[bounces-247464-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 994b33366be9148240690e3e94bffe17c4d89458
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051529-woven-tradition-4188@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 994b33366be9148240690e3e94bffe17c4d89458 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:38 +0200
Subject: [PATCH] spi: pl022: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: b43d65f7e818 ("[ARM] 5546/1: ARM PL022 SSP/SPI driver v3")
Cc: stable@vger.kernel.org	# 2.6.31
Cc: Linus Walleij <linusw@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-9-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index bd1d28caa51e..9c0211f94fd0 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1956,7 +1956,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Register with the SPI framework */
 	amba_set_drvdata(adev, pl022);
-	status = devm_spi_register_controller(&adev->dev, host);
+	status = spi_register_controller(host);
 	if (status != 0) {
 		dev_err_probe(&adev->dev, status,
 			      "problem registering spi host\n");
@@ -1997,6 +1997,10 @@ pl022_remove(struct amba_device *adev)
 	if (!pl022)
 		return;
 
+	spi_controller_get(pl022->host);
+
+	spi_unregister_controller(pl022->host);
+
 	/*
 	 * undo pm_runtime_put() in probe.  I assume that we're not
 	 * accessing the primecell here.
@@ -2008,6 +2012,8 @@ pl022_remove(struct amba_device *adev)
 		pl022_dma_remove(pl022);
 
 	amba_release_regions(adev);
+
+	spi_controller_put(pl022->host);
 }
 
 #ifdef CONFIG_PM_SLEEP


