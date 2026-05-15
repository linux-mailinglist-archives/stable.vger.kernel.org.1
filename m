Return-Path: <stable+bounces-247373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEjnCCiwBmqnmwIAu9opvQ
	(envelope-from <stable+bounces-247373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:33:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3EA549983
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DC4930571B4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE181313532;
	Fri, 15 May 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FFeESTpv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3A3F4132
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823128; cv=none; b=DVPtaJHsxHnNuZXHUcbhMZzYIqPzB9M84xKOICFyElUctb+0hPMChsAbZMLeV8z49mpR+IVYEPndTDt8CItYZRc8bbR4y643E6Au+c64RgtgEjieYk838UTuLhd92YJOdHXUHsbn4yAWEBi1x3TQrxgrNXJUtfQRvDrFoPPcm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823128; c=relaxed/simple;
	bh=r8u/EkPqijoISEGicQgc6sF5+hdXWNsMxA6TRm4HYho=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CPBI++sQac7SwiYwI+y+MIuW9MfeSXdL4S/dg/hp3Ek01afkvNshm7RcrECws4uhM4L57/SktVqy1wBn4dnsTqYOpOgPy8/5QXS1yN0r/LP+XIeuXYiduznM3+gzjDPe0B1eN42ETT5Sm5A1gRc1QFU5xR6WI38uvl6ynhmYQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FFeESTpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4177C2BCB0;
	Fri, 15 May 2026 05:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823128;
	bh=r8u/EkPqijoISEGicQgc6sF5+hdXWNsMxA6TRm4HYho=;
	h=Subject:To:Cc:From:Date:From;
	b=FFeESTpvzTLDUoZq9s+T2QrAE8fumhWh6arK+N5/eLcYPqGqIGPELC/SbQC4ZpVmL
	 L+cCCO6TR0o1v5t6IL04/JgNbHXFMNj196H5aGNkmywrSxtmAi4UTT0vvFQ5OMGbHK
	 TGEHEkLsjeKGobOv0j3OW/CbiiYubOIovjJBoJEc=
Subject: FAILED: patch "[PATCH] spi: qup: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:32:05 +0200
Message-ID: <2026051505-myth-resolved-fabe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D3EA549983
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
	TAGGED_FROM(0.00)[bounces-247373-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 443e3a0005a4342b218b6dbd4c6387d3c7fed85a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051505-myth-resolved-fabe@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 443e3a0005a4342b218b6dbd4c6387d3c7fed85a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:39 +0200
Subject: [PATCH] spi: qup: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 64ff247a978f ("spi: Add Qualcomm QUP SPI controller support")
Cc: stable@vger.kernel.org	# 3.15
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-10-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 6cbdcd060e8c..45d9b4cb75e4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1193,7 +1193,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -1320,6 +1320,10 @@ static void spi_qup_remove(struct platform_device *pdev)
 	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	ret = pm_runtime_get_sync(&pdev->dev);
 
 	if (ret >= 0) {
@@ -1339,6 +1343,8 @@ static void spi_qup_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id spi_qup_dt_match[] = {


