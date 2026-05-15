Return-Path: <stable+bounces-247564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBa3GK/cBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:43:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A93B754B9B8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04A8B30F6BD2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FE407562;
	Fri, 15 May 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/IwOzJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB858406286
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834022; cv=none; b=TkYKKIqY5+j82w62moDLgNU7zMfHgaX6dic97UkaUKY2Q8VGbWnqCxDXghWwm8S5go7ul319WoxomfCLPlMbgaFsfBppLITHqnDBFO7KmhQO4FebmgkLE3J+arDlmE3WnyuRzjBWwSIL7sZ/u8i5ktpcE5f48bUjem5EmX/L0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834022; c=relaxed/simple;
	bh=johYWN0eIhdo8k941Btk/NKr3PvLvizqnT+KqJXDzF8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dvEkJxEMwmkIwM/QHl2hhKm4krfP3xrmqdVf2WqWpjeZJHD/X3duYE0k2JqdchET7EYMAffgBFD5tnWLAITbYP2sGIuLWp4Nmr6bsvO6fvAS8H+HokxFecspMUlKu2EnwihxGeUcT0uogH/dN6sTe9TPlLg0Mywa/YWfQgYLbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/IwOzJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DFEC2BCF7;
	Fri, 15 May 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834022;
	bh=johYWN0eIhdo8k941Btk/NKr3PvLvizqnT+KqJXDzF8=;
	h=Subject:To:Cc:From:Date:From;
	b=l/IwOzJ2oeylFr0DaL9AbkJeJJNbgV0/WUO5IbOsH6Nj5PnERH/pYpp0F23+OJ7+7
	 O3P00R2+NNH602u8rkYBQfnljkYHinWMo6uI43EkOcnldiaJyB7MQhO0rn+Hh+L8sw
	 v/qpOvdnKxqbuF2yU/sORpHGapnqhfzNhlMt+up8=
Subject: FAILED: patch "[PATCH] spi: cadence: fix clock imbalance on probe failure" failed to apply to 6.12-stable tree
To: johan@kernel.org,broonie@kernel.org,shubhrajyoti.datta@xilinx.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:33:40 +0200
Message-ID: <2026051540-protegee-gothic-ff46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A93B754B9B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247564-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,xilinx.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ecea4f0e9db2fb6ab4a68a59c5aba0d8f59a9566
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051540-protegee-gothic-ff46@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ecea4f0e9db2fb6ab4a68a59c5aba0d8f59a9566 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 14:36:13 +0200
Subject: [PATCH] spi: cadence: fix clock imbalance on probe failure

Make sure that the controller is active before disabling clocks on probe
failure to avoid unbalanced clock disable.

Also drop the usage count before returning (so that the controller can
be suspended after a probe deferral) and restore the autosuspend
setting.

Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
Cc: stable@vger.kernel.org	# 4.7
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421123615.1533617-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index bf4a7cf6b142..891e2ba36958 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -741,7 +741,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		/* Set to default valid value */
 		ctlr->max_speed_hz = xspi->clk_rate / 4;
 		xspi->speed_hz = ctlr->max_speed_hz;
-		pm_runtime_put_autosuspend(&pdev->dev);
 	} else {
 		ctlr->mode_bits |= SPI_NO_CS;
 		ctlr->target_abort = cdns_target_abort;
@@ -752,12 +751,17 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	if (!spi_controller_is_target(ctlr))
+		pm_runtime_put_autosuspend(&pdev->dev);
+
 	return ret;
 
 clk_dis_all:
 	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 remove_ctlr:
 	spi_controller_put(ctlr);


