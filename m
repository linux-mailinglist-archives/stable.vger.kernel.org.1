Return-Path: <stable+bounces-247543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDxtHHTcBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:42:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA354B96C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDC030E779B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9013EB816;
	Fri, 15 May 2026 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vPmsFv72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5011625
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833906; cv=none; b=qTcnkOw+U663xNK1xmpXBTPTYRSsO+Pmpe47aq0NDp1p790GYhwhlp7EBvFpDOyr0hVe/DIft9+9hc8i4ugE08TvV09eBoA6V5/QnXbmB2amKJVMI30uZN1KnTVhfOziUoISJkOyUz9v+YNXqIXaYWFslwo/V3IW1eGk0cxQrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833906; c=relaxed/simple;
	bh=biVb22EYyik6dSJNL6wW+Ynk6LTY+k0z0nhcSvydzsU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cj3YZe/xkiGifQMycAK++ayvXVLhZjAhT4wODQo+U7CBw5TTnqjbBbou3onRR4i7Azy4HBIailE8WZ/V1I4kmEXDCKNBegX+6dubz1QXtG3xaAPQ8ohYu0mtmKw0mfUIzCnBC1H/qIED9/Ei7LXjxa7lUyx2PGc0nPTC8ejcbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vPmsFv72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4386BC2BCB0;
	Fri, 15 May 2026 08:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833906;
	bh=biVb22EYyik6dSJNL6wW+Ynk6LTY+k0z0nhcSvydzsU=;
	h=Subject:To:Cc:From:Date:From;
	b=vPmsFv72ET7t0u6cDoENV7JlhbS79/y6F0CQXvS6UJOGiDMLhjaY1AaSjcNP1al3Q
	 AbfdObjdA9mnXzyMYzuRBdfMkXzAlFveqrJJ8GQBcg9KVzMi2AFSFjv6rT9I6ELbFp
	 9623tcc1TfyrBa+YVm/z8ABReStbV3FiOlunTDdY=
Subject: FAILED: patch "[PATCH] spi: orion: fix runtime pm leak on unbind" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,rmk+kernel@arm.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:31:39 +0200
Message-ID: <2026051538-passivism-outdoors-9aa4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2EA354B96C
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
	TAGGED_FROM(0.00)[bounces-247543-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linux.org.uk:email,sashiko.dev:url]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 97b17dd8266d2e26d9ee3c75a0fa34ecde6944f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051538-passivism-outdoors-9aa4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


