Return-Path: <stable+bounces-247510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJjZLdHaBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:35:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3208554B66B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D614306469D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101113F0AA0;
	Fri, 15 May 2026 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvhwfnD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829B401A2D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833811; cv=none; b=mbXxhaZ1oz1CnhKxjxIEAQ4kn4zpm0WiXfgEi+NoYxGGy9dDNbzaH+3VAr9uyvCREuyEKnn8/Js8lZJG6oOfaCwdrHltcocK5HI9YR31DOoYwsYKN3eFpUJKE8ZmOv+PsPRMJJ7CzdViN0grpMAPQPSE8xGbDxza/kB39qQHRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833811; c=relaxed/simple;
	bh=uOJF7My0tJTlHUBJhb6bIUjZkAn2eLKpN4XVhowzKnQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nYYIAFh40+RJ2WzpoaUxj0EuDdakCOCK3qx/xLyIdkCHA2gWR/wfbw/7b4ZMbFyjdkMvFyePP9g1x3U67D/9WuylUd5/EMy9HTzZahTweZQAOP/wJdGWqLemFjvs1SXywLIB8c08E1qxF0vV1vexB6XWNcPqxlBOPk5ciX9K+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvhwfnD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5417CC2BCC7;
	Fri, 15 May 2026 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833811;
	bh=uOJF7My0tJTlHUBJhb6bIUjZkAn2eLKpN4XVhowzKnQ=;
	h=Subject:To:Cc:From:Date:From;
	b=dvhwfnD56DKmzwFqle7J+EwGWfhloJa6yYIsIqkAvcDx2mpwndrkJ2fI4UkkN6uiZ
	 lUVEYvLFBgKo3drdf63lo8708ZzQt4IrJVL6IpUI1Zk3GSk4R8whzyW28qTnvwpA8M
	 TiDce+rGdeIHC7NN5Emzlka+4hQ2uzFeN4OsoW5I=
Subject: FAILED: patch "[PATCH] spi: rspi: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,jg1.han@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:29:45 +0200
Message-ID: <2026051545-favoring-overload-808e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3208554B66B
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
	TAGGED_FROM(0.00)[bounces-247510-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9944fa6726afb1e6eb7e2212764e7da0c97f2dcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051545-favoring-overload-808e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9944fa6726afb1e6eb7e2212764e7da0c97f2dcc Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:40 +0200
Subject: [PATCH] spi: rspi: fix controller deregistration

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 9e03d05eee4c ("spi: rcar: Use devm_spi_register_master()")
Cc: stable@vger.kernel.org	# 3.14
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-11-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c739c1998b4c..a8180dece716 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1171,8 +1171,14 @@ static void rspi_remove(struct platform_device *pdev)
 {
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
+	spi_controller_get(rspi->ctlr);
+
+	spi_unregister_controller(rspi->ctlr);
+
 	rspi_release_dma(rspi->ctlr);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(rspi->ctlr);
 }
 
 static const struct spi_ops rspi_ops = {
@@ -1376,9 +1382,9 @@ static int rspi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error3;
 	}
 


