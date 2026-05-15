Return-Path: <stable+bounces-247537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIMnMEzcBmphogIAu9opvQ
	(envelope-from <stable+bounces-247537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB154B93D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D2230E2E7D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04443F20F1;
	Fri, 15 May 2026 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sjnd4jIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845983DEAC5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833889; cv=none; b=KS42n2ewhknbeSoZmhcRXRUA7GrYgCDgrKMZkotiQitUg4Jb+5o6hX50h9RLvs2y6vIb4qMxHSMDazEdliMJiDM1qiaz0AWD0n/OVWVH61Ur6rvsxRs1H4O7RC+bzu/3/H1dRZ1iS04vzXpQFY0ukNK5UeJHqgVKysVPyTo88kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833889; c=relaxed/simple;
	bh=HilcV48HIiVsG10LRoPbNeurX85JwRPu0odrfWSPpck=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SR2vbbVJLt5yMJY0FN91Y5rK7jTgmDm4dC7jdT2sdid3dgK8zRE1Gdg7XGcGLWLNDN1WyeblnwVVq5ZF6UsOiEEuPIeDBji+zC5r1r1B6HWMNw5F/AaksVKFoR+lzNUreGnU3OzjD2FJk0JZ+l/mbkICYvg5rgTpK9inqvKVC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sjnd4jIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB323C2BCB8;
	Fri, 15 May 2026 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833889;
	bh=HilcV48HIiVsG10LRoPbNeurX85JwRPu0odrfWSPpck=;
	h=Subject:To:Cc:From:Date:From;
	b=Sjnd4jIZewu1xtpThk9a+HkQFLncWc9dJK4qZgly/MXLrrAUXJ+jMTDtNtcqOcwms
	 A4CRg6dJLfQo7aBDUHYSq1AXagR8GdRW/kJALC2j2Ux/zLtXYvkLd2XyVRE3Vk9SD5
	 I3030/sgXHm1XLdh7GzCl/p3Exy8Nen/FCbU/Y84=
Subject: FAILED: patch "[PATCH] spi: orion: fix controller deregistration" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:31:23 +0200
Message-ID: <2026051523-earmuff-lather-1588@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33FB154B93D
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
	TAGGED_FROM(0.00)[bounces-247537-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 220f4f11104a7f83b71543ef0e48dde1da2bc5d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051523-earmuff-lather-1588@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 220f4f11104a7f83b71543ef0e48dde1da2bc5d3 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 14 Apr 2026 15:43:17 +0200
Subject: [PATCH] spi: orion: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: 60cadec9da7b ("spi: new orion_spi driver")
Cc: stable@vger.kernel.org	# 2.6.27
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-7-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 7a2186b51b4c..c54cd4ef09bd 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -801,10 +801,15 @@ static void orion_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct orion_spi *spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spi->axi_clk);
 
-	spi_unregister_controller(host);
+	spi_controller_put(host);
+
 	pm_runtime_disable(&pdev->dev);
 }
 


