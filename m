Return-Path: <stable+bounces-245520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMK5DuMkA2oF1AEAu9opvQ
	(envelope-from <stable+bounces-245520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:02:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21F55209CC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B85730AB71A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B4A399D08;
	Tue, 12 May 2026 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIR1bqsI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966938D41F
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590049; cv=none; b=UceZLxHiy69leFYuTEWO7Jt+B7MVjs9Cwt6iWpPp463p9daapxCGsF1e3B1c9DgZaL3Ig8u7VgqVgTLzbVDT2b/P9pydmQnLgEV+x0U4jZBhEfsxEgk8bb8uhnuj2rUBOGb+k3HEOBdoHCzLh2xaE4C2nNVkdmrk9yK6xB7Rym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590049; c=relaxed/simple;
	bh=FLB4HcQd7OE/tAV5tftUqijm7/xqLfaM32Uo5eZgG8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aDL5X1UctpC4Dr0zkBmtn1bYwAvos/+9W/2Bqz1aV1sAdp7T8S7+xzqR0bqzBnkjL0QljZyP48bQLURC3ZE58jHpH5yZPAIEwg7MIpao4HBfCTvlB02CL4lnQ97ebg5fDmlw+a10A+YIThg68/Y9BHVNlHl9jsWAxRrJfql9Sy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zIR1bqsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A82EC2BCB0;
	Tue, 12 May 2026 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778590049;
	bh=FLB4HcQd7OE/tAV5tftUqijm7/xqLfaM32Uo5eZgG8A=;
	h=Subject:To:Cc:From:Date:From;
	b=zIR1bqsIp6M1vwW2bu5faZ1UtZKwCyxQUem+Te3HJ3zkVo2KGFmrJE+wxE9Ab5wNu
	 YEQ6cGWCJ6NeevpjY2YA1x744W9orCoiQWbHm6TRI+5AaHBrTsOcfUgwH9Eb/4Tdy2
	 g2lL7X4ziHDeZYPjfcXOnUgxvxC4F1FEwtP8/75A=
Subject: FAILED: patch "[PATCH] spi: zynq-qspi: fix controller deregistration" failed to apply to 6.12-stable tree
To: johan@kernel.org,broonie@kernel.org,naga.sureshkumar.relli@xilinx.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:46:03 +0200
Message-ID: <2026051203-stonework-judgingly-0a7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A21F55209CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245520-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,gregkh:email,linuxfoundation.org:dkim,xilinx.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c9c012706c9fa8ca6d129a9161caf92ab625a3fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051203-stonework-judgingly-0a7d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


