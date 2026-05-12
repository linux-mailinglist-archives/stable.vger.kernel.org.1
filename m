Return-Path: <stable+bounces-245521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKp/Iv4vA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:49:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFAE521A2D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C7133CA1D1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0B399D13;
	Tue, 12 May 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZjN1GVQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4937DAB9
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590054; cv=none; b=UBjom/GxzSeKMfWZgtvPeyAHkE4xUSVbIoeOYF9GBDz5IMjAOaMoMAPiRCxVFm4DncWDUokcBl7j8U6ADuHe2FKbLAOynN8a6sKnHkxlMkQABYhUtA5S1MDvvnYwsviej7Z5DDeovo6BykyGPXcBMnKre2qeWORkvhZypglOwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590054; c=relaxed/simple;
	bh=Qm1pkZ1LPf1FeIHPqjqeWBL3OEbtPFgoO1eOFoYHyCg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pU2E8aP+LsOF4TqV6qXmKWb3ll+9KHR7NlFHabKr4BZFBOhXW6D72+pWWslWRy4i8tr9MPPref4psA6ovAMSKbSg7NqAN6HOTXeIVxME87tj4C5Wt/fPqy8MOFLxQkSvqLaJHvKqihmGTjTzQECltvXngOalC2UdwDrAY0kXPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZjN1GVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED83CC2BCB0;
	Tue, 12 May 2026 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778590053;
	bh=Qm1pkZ1LPf1FeIHPqjqeWBL3OEbtPFgoO1eOFoYHyCg=;
	h=Subject:To:Cc:From:Date:From;
	b=NZjN1GVQ5qbFrIu6/o7fmvtbOR81HCpEVxwh+Gev07ug7tSPqfcm+BXjK7X/Eta30
	 mU9OAdOXF2B6IwctpOFjSdLNymKMpzWK564ElVLVlpxpRQTNAKjoJtXwkmNxi3/dsG
	 FSKlS6JiMy46ir2T7o400FtMJEQpMG3rdsJ7wQ0Y=
Subject: FAILED: patch "[PATCH] spi: zynq-qspi: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,naga.sureshkumar.relli@xilinx.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:46:04 +0200
Message-ID: <2026051204-hacksaw-unopposed-238a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DFAE521A2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245521-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c9c012706c9fa8ca6d129a9161caf92ab625a3fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051204-hacksaw-unopposed-238a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9c012706c9fa8ca6d129a9161caf92ab625a3fd Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:56 +0200
Subject: [PATCH] spi: zynq-qspi: fix controller deregistration

Make sure to deregister the controller before disabling it during driver
unbind.

Note that clocks were also disabled before the recent commit
1f8fd9490e31 ("spi: zynq-qspi: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Cc: stable@vger.kernel.org	# 5.2: 8eb2fd00f65a
Cc: stable@vger.kernel.org	# 5.2
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-27-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index af252500195c..406fd9d5337e 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -643,7 +643,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	xqspi = spi_controller_get_devdata(ctlr);
 	xqspi->dev = dev;
-	platform_set_drvdata(pdev, xqspi);
+	platform_set_drvdata(pdev, ctlr);
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xqspi->regs)) {
 		ret = PTR_ERR(xqspi->regs);
@@ -702,9 +702,9 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	/* QSPI controller initializations */
 	zynq_qspi_init_hw(xqspi, ctlr->num_chipselect);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
-		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto remove_ctlr;
 	}
 
@@ -728,9 +728,16 @@ static int zynq_qspi_probe(struct platform_device *pdev)
  */
 static void zynq_qspi_remove(struct platform_device *pdev)
 {
-	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
+
+	spi_controller_put(ctlr);
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {


