Return-Path: <stable+bounces-215096-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIy6NSzyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215096-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CCA110B7A
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 207043064518
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253622C2360;
	Mon,  9 Feb 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKmj4Z2d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AA1AF0AF;
	Mon,  9 Feb 2026 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647661; cv=none; b=KEw9aWSP8EnpalMBnTbPYhWOR7UFG44oRoUyCe5XcvCVZeEj3lx7LKL9NDvK5OBKsOtCJG1fU1TWZdzHmP4O4Gpyv7r2tE/wQ/zdb328fRAiDyLdXlPOKMdhYE2PQ5LTxtlbjxPvzugKHdI8UL3xp1KzrQizGr65Q6wPBrPWtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647661; c=relaxed/simple;
	bh=InDME7NMCaKRiVIDo+77XkZgybEdtAAKXKbnoWrPG3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDbS+uUTgfhL5itNNFUa9DwYdmaFDOhFeOUc5ZUU7VuLPMYdPqbnHrL1OwhWOHo46aZHMy5yef9fMg8Q7jKeQ2oAzLeBzY+yMsc5gqG18K129PZFH4uuCLpuOwozpEkOIfof2HhBHv2kZLxFmJspkrJYvbbKxlnUWRMVBZz2kJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKmj4Z2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE8C116C6;
	Mon,  9 Feb 2026 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647661;
	bh=InDME7NMCaKRiVIDo+77XkZgybEdtAAKXKbnoWrPG3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKmj4Z2dNuwAEyLW3R7dUaHwRv9TJfhAA1p6ZlifBFgozjIRyWgywwujMuyDAiwRJ
	 NOQ1SfMgYEYvb5R9QV4Q+nit0gojcu0r7iEm3W0Cbwylr/PoabC4WPgOL/u/XQngYM
	 7ytrMSv3SPSPXn5E129NaKE+wVLhUWMr3KgFUK0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Zilin Guan <zilin@seu.edu.cn>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 123/175] net: liquidio: Fix off-by-one error in PF setup_nic_devices() cleanup
Date: Mon,  9 Feb 2026 15:23:16 +0100
Message-ID: <20260209142324.833776889@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215096-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: 74CCA110B7A
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 8558aef4e8a1a83049ab906d21d391093cfa7e7f ]

In setup_nic_devices(), the initialization loop jumps to the label
setup_nic_dev_free on failure. The current cleanup loop while(i--)
skip the failing index i, causing a memory leak.

Fix this by changing the loop to iterate from the current index i
down to 0.

Also, decrement i in the devlink_alloc failure path to point to the
last successfully allocated index.

Compile tested only. Issue found using code review.

Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/20260128154440.278369-3-zilin@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 925512c077a0c..eb620e8544cf1 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3760,6 +3760,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 	if (!devlink) {
 		device_unlock(&octeon_dev->pci_dev->dev);
 		dev_err(&octeon_dev->pci_dev->dev, "devlink alloc failed\n");
+		i--;
 		goto setup_nic_dev_free;
 	}
 
@@ -3775,11 +3776,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 setup_nic_dev_free:
 
-	while (i--) {
+	do {
 		dev_err(&octeon_dev->pci_dev->dev,
 			"NIC ifidx:%d Setup failed\n", i);
 		liquidio_destroy_nic_device(octeon_dev, i);
-	}
+	} while (i--);
 
 setup_nic_dev_done:
 
-- 
2.51.0




