Return-Path: <stable+bounces-247541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB6RLJTbBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:38:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3154B7D3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E84FB305D00B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE6B3EB816;
	Fri, 15 May 2026 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jzvL4KMS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3015625
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833901; cv=none; b=iulGY0qyqYDFomR0D/3OBwPBhM/CwFnPzHz9ok9NH6F95pUQGIvOD7EHfueiEikMUQzxRYNJyR/+L1CO1H+lcFfBrTHI5jCiYL9t+lQRq2MRcPmzuRIiXfRzbjUxAvwBfeBeLgat/OKYDSYdFuYLAC6Mnv8r0Cm/I2JE9+ndRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833901; c=relaxed/simple;
	bh=BC39xAqDf+wtQz3gXLZIaDddesaYvgKXTR2sO4j+FcY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SnxtsZKK572eJClelIaDrtk9YMVfLkfYEM9mObHuM8rl+Fmn9rk3pZdw+z/LWkpUz+ijDGh6NleYTCneFBkQhmwaPH9u/fOFnmp0pdHqPcWFSKk6sPcN++jEv5dLDWveGf7phVGx4wFNpBRb/dWEL4Kk08p7Fz73XC33kNdPlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jzvL4KMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB6BC2BCB0;
	Fri, 15 May 2026 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833900;
	bh=BC39xAqDf+wtQz3gXLZIaDddesaYvgKXTR2sO4j+FcY=;
	h=Subject:To:Cc:From:Date:From;
	b=jzvL4KMSfhe4IkJnpWlVV/Wci0NRTUTghZrTmXqgIpOx3x1xuqiip0n1Nja30D1Rs
	 oxpyeUJ9gPg3rUOHq3VSqtAil7Lnowt2sf6IUOtTfY3b1s8dO4RCN+2+TUHCz0GAnC
	 LWU28lzBKT+vYvA0mg4NC/9mncVFj00CoVM2JY7c=
Subject: FAILED: patch "[PATCH] spi: orion: fix runtime pm leak on unbind" failed to apply to 6.1-stable tree
To: johan@kernel.org,broonie@kernel.org,rmk+kernel@arm.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:31:38 +0200
Message-ID: <2026051538-ladybug-edge-0db7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31E3154B7D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247541-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,linux.org.uk:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 97b17dd8266d2e26d9ee3c75a0fa34ecde6944f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051538-ladybug-edge-0db7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 97b17dd8266d2e26d9ee3c75a0fa34ecde6944f0 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 15:02:09 +0200
Subject: [PATCH] spi: orion: fix runtime pm leak on unbind

Make sure to balance the runtime PM usage count on driver unbind so that
the controller can be suspended when a driver is rebound.

Also restore the autosuspend setting.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 5c6786945b4e ("spi: spi-orion: add runtime PM support")
Cc: stable@vger.kernel.org	# 3.17
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=6
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421130211.1537628-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c54cd4ef09bd..c61ebfd1d18d 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -811,6 +811,9 @@ static void orion_spi_remove(struct platform_device *pdev)
 	spi_controller_put(host);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);


