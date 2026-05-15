Return-Path: <stable+bounces-247563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEl6DWbaBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:33:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CADEC54B5CE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14095300616F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C183E9F98;
	Fri, 15 May 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OWjKh9av"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD02C3E3DAF
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834019; cv=none; b=eYN1vwCoV8g2IsXP4PBQMZ0sbKXk5Mk+OkOI+CacpW+6lk9wE75kUY5N2mIeQxOWYVTxWdyNgc2jaaeEsgIBXoCZp6rYGa75OCTMN1tyyJBsdcjwfnnuxRZjItOeaabDOFO+3yazHfQJ3Fn+C9kP0U5dPFzAG3VOQHra7GrLttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834019; c=relaxed/simple;
	bh=hPz9+N4kQyAtSEGMeMa3vqql1wtwc6zDcZJ0iPEY2Uw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eKUSmTRF+5NHSlixU1dkntzUl8uXkeiA1xy8THP7va5YPRNFmw6gUykyPsISKofSFwrOYpdmKqyWWD0bNtsxWdvQx9ESzkO829JfbN65BFj0pu4jyN9BWX4x6ZOISge0jL1i002pgi1RjIVW22vziZFtlnXV2Y83EuZcgFRUfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OWjKh9av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69BAC2BCB0;
	Fri, 15 May 2026 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834019;
	bh=hPz9+N4kQyAtSEGMeMa3vqql1wtwc6zDcZJ0iPEY2Uw=;
	h=Subject:To:Cc:From:Date:From;
	b=OWjKh9av7n4nbFQDToMwLOYsZf++WafSReFEeAhnEfi82GSbN/1SxkjvArwf60RmW
	 leQqsBmcVdKwGTTxqfKRgC5seDMJFTFXeX40rH84+QcCGqNZlce37Svb7LZkcAbxO1
	 1wlUv1xOhq1AaGan7Eo+Ho+hfd59ypMcT0CWppD8=
Subject: FAILED: patch "[PATCH] spi: cadence: fix unclocked access on unbind" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,shubhrajyoti.datta@xilinx.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:33:31 +0200
Message-ID: <2026051531-handwrite-wildness-5da3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CADEC54B5CE
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
	TAGGED_FROM(0.00)[bounces-247563-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,msgid.link:url,linuxfoundation.org:dkim,gregkh:email,xilinx.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5b1689a41f02955c5361944f748a4812a6ff9307
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051531-handwrite-wildness-5da3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b1689a41f02955c5361944f748a4812a6ff9307 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 14:36:12 +0200
Subject: [PATCH] spi: cadence: fix unclocked access on unbind

Make sure that the controller is runtime resumed before disabling it
during driver unbind to avoid unclocked register access and unbalanced
clock disable.

Also restore the autosuspend setting.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
Cc: stable@vger.kernel.org	# 4.7
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=1
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421123615.1533617-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 08d7dabe818d..bf4a7cf6b142 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -776,16 +776,23 @@ static void cdns_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
+	int ret = 0;
+
+	if (!spi_controller_is_target(ctlr))
+		ret = pm_runtime_get_sync(&pdev->dev);
 
 	spi_controller_get(ctlr);
 
 	spi_unregister_controller(ctlr);
 
-	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
+	if (ret >= 0)
+		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 
 	spi_controller_put(ctlr);


