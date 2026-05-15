Return-Path: <stable+bounces-248559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO+yCzRXB2p7zAIAu9opvQ
	(envelope-from <stable+bounces-248559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:26:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7203555021
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4C91336CF2B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B83E0098;
	Fri, 15 May 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J3zIhfJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AB3E008C;
	Fri, 15 May 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862041; cv=none; b=kSMGxFYaTTQAE7As+ztKPYrQCZ9QRppDomcMAV9nNrPZo78Kp5vPlrMAJYvqUSQz7cYYYyTtwz6rdy3JkHuNZV6TM8D8EukA1AKDWuALnZSi+UO9nDXtAyFCe7YqViljHJ8DD2P0TiloEt4s+9/g6vEheU4Wr46U0EERGQjmKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862041; c=relaxed/simple;
	bh=qmzqlGhieR9x5smg1Azc5gq6RVHrVVbbipaeEwRzBco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebpcX8bEsuuHveHYMhK41PvDEPJV708nZ87l4rwJV6U9uUj5SvvYtCfrl3VBOnRw0IycIaCPjHug0tJp1Lt4++Neirb/6uOgSWjJYD62yQ2W4powTpfqZrEz991mpB+qzzaXNLDqCCbUk/WC+FI94q9WwOPPjTdO+MYcYch799M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J3zIhfJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35F7C2BCB0;
	Fri, 15 May 2026 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862041;
	bh=qmzqlGhieR9x5smg1Azc5gq6RVHrVVbbipaeEwRzBco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3zIhfJuUmOBKsx3TkVxk98eR6FyX+yLnuhyhkOGYurMFsYdOApX0bkugQIXqnQfa
	 EGa4ICoMlKH8mcB5OcUKs/fCkSsUH1tl2jEzDu07VRsMNpVsogvHbqwDW6+i8oV11D
	 dCxkCl24yzyRNoiCytrDT9FV1h1kS6cKjsGbWHVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 085/188] spi: mpfs: fix controller deregistration
Date: Fri, 15 May 2026 17:48:22 +0200
Message-ID: <20260515154659.168847929@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7203555021
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248559-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 573c7db8fce91a1b07dd64a260bb44b9e6d05943 upstream.

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Cc: stable@vger.kernel.org	# 6.0
Cc: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260409120419.388546-21-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-mpfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-mpfs.c
+++ b/drivers/spi/spi-mpfs.c
@@ -575,7 +575,7 @@ static int mpfs_spi_probe(struct platfor
 
 	mpfs_spi_init(host, spi);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		mpfs_spi_disable_ints(spi);
 		mpfs_spi_disable(spi);
@@ -593,6 +593,8 @@ static void mpfs_spi_remove(struct platf
 	struct spi_controller *host  = platform_get_drvdata(pdev);
 	struct mpfs_spi *spi = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	mpfs_spi_disable_ints(spi);
 	mpfs_spi_disable(spi);
 }



