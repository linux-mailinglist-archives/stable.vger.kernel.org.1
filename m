Return-Path: <stable+bounces-247524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BThHB3cBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F554B8E5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 926CC30A5C90
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AEE3DEAC5;
	Fri, 15 May 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKZPSAXV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B53932EE
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833852; cv=none; b=W4yIvgrqvKugeivKXU0Pyt2HvigF3BON03tMvhir1NEiBGu6hOupk4ZC2Q4cQ6t0JG3v1Cvlwl1OpexTAuxzbePXdHTq0jxgzQMlMQN9rUyfPOYmq8pV+wnk/eeGnJmtukto0CP4mfN6Tlot4LTs8mr59Kxhufe10NQxdNMrqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833852; c=relaxed/simple;
	bh=QdFqdS0Aq1+xQJ/vp003pQhIOuTbdOjymaeInjXQWy4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KfY8yXsNYk0ky45wgn+3VbFJhd67vtp9+KLy3MSaM9J+wuaK+JEL16R7yzhGDoW4JvFqjGHVrNSi/XFBqOlqimeSCiPfDGdFr61SMRp3CsqViPzwhCY6sKUf/IyuZRZR4L/N6uPykwhD4Q5ZnolrNK0q1T4C7iCzJvS+eLtzr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKZPSAXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F944C2BCB0;
	Fri, 15 May 2026 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833851;
	bh=QdFqdS0Aq1+xQJ/vp003pQhIOuTbdOjymaeInjXQWy4=;
	h=Subject:To:Cc:From:Date:From;
	b=RKZPSAXVdBKKQfWjH+jJoSqnLFLQVWm82/eZWs8gblaCXgVUUuYWtpZ1ey+lkk6fr
	 umCJvF7LxTu2POfQVb71YPhgCIVwLLepd3YmadGA4OiUoBwEsWFz0wq1E2Bl8k6A5p
	 aPVyJc8Z5ow2dQOQDRJW/d0yPRqSFxEMoAtNYU6s=
Subject: FAILED: patch "[PATCH] spi: mpfs: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,conor.dooley@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:30:26 +0200
Message-ID: <2026051526-hula-backfire-e720@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E70F554B8E5
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
	TAGGED_FROM(0.00)[bounces-247524-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 573c7db8fce91a1b07dd64a260bb44b9e6d05943
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051526-hula-backfire-e720@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 573c7db8fce91a1b07dd64a260bb44b9e6d05943 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:19 +0200
Subject: [PATCH] spi: mpfs: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Cc: stable@vger.kernel.org	# 6.0
Cc: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260409120419.388546-21-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-mpfs.c b/drivers/spi/spi-mpfs.c
index 64d15a6188ac..989a379b0700 100644
--- a/drivers/spi/spi-mpfs.c
+++ b/drivers/spi/spi-mpfs.c
@@ -574,7 +574,7 @@ static int mpfs_spi_probe(struct platform_device *pdev)
 
 	mpfs_spi_init(host, spi);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		mpfs_spi_disable_ints(spi);
 		mpfs_spi_disable(spi);
@@ -592,6 +592,8 @@ static void mpfs_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host  = platform_get_drvdata(pdev);
 	struct mpfs_spi *spi = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	mpfs_spi_disable_ints(spi);
 	mpfs_spi_disable(spi);
 }


