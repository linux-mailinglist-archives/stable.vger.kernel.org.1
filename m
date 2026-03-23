Return-Path: <stable+bounces-228309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG+TNmtOwWm7SAQAu9opvQ
	(envelope-from <stable+bounces-228309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441312F49E1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FA5C3116E35
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919B3AE6EE;
	Mon, 23 Mar 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1f26hI7f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087A3B0AEF;
	Mon, 23 Mar 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274764; cv=none; b=lb72BvHsvsMfTps5E0lofduR7l7eQ3BcKKUjms0vqXDJf1u7Im9/dpJjflW8PnvnzthshrbnDQY/JUA2643l24Dz927Pqbui41JXhLTSSjt5kKvoozvt2z5ZZoBBfBF+i75d0tmZzVJpyuZs6yPkM8v/lWhbV5SPCaaU5XSYs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274764; c=relaxed/simple;
	bh=ulRYeF8D0S7FgEZEq5OVD35MrIBMnfzqFsw8ShIBqP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebSEIXEIHYZ9NLtiC2jC/nEKJzcoEqFZoVIu4w5SJuQdhf/q47X0IUdI2RVrcaW1f6fdgRkaxV8n9OkhGgSJOWzELmThxQN0tf+L6KEQBby23WZLbtLKI68XAaX0NdO9x7a8UZJokt7wuZwi6QhsG6TjzRih+kMr1l2W7KMSTeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1f26hI7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0127AC4CEF7;
	Mon, 23 Mar 2026 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274764;
	bh=ulRYeF8D0S7FgEZEq5OVD35MrIBMnfzqFsw8ShIBqP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1f26hI7fZCTutryhLRF1yyaocRknrrxoUy10YfW30Yp9iKZ5KSaLi+QA/zSeJ+9wp
	 AmjQjgBcmtblN4NRHZpuWQftjOOhoeTjjX2i0jXkTXH20RuU8YgdsU6syRePTpIaHe
	 7+dpwx0L+zPUo4MOtzWWywZw3utULAyadFRzdbWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 101/212] soc: microchip: mpfs: Fix memory leak in mpfs_sys_controller_probe()
Date: Mon, 23 Mar 2026 14:45:22 +0100
Message-ID: <20260323134506.971995416@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228309-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 441312F49E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 5a741f8cc6fe62542f955cd8d24933a1b6589cbd ]

In mpfs_sys_controller_probe(), if of_get_mtd_device_by_node() fails,
the function returns immediately without freeing the allocated memory
for sys_controller, leading to a memory leak.

Fix this by jumping to the out_free label to ensure the memory is
properly freed.

Also, consolidate the error handling for the mbox_request_channel()
failure case to use the same label.

Fixes: 742aa6c563d2 ("soc: microchip: mpfs: enable access to the system controller's flash")
Co-developed-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 30bc45d17d343..81636cfecd37e 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -142,8 +142,10 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 
 	sys_controller->flash = of_get_mtd_device_by_node(np);
 	of_node_put(np);
-	if (IS_ERR(sys_controller->flash))
-		return dev_err_probe(dev, PTR_ERR(sys_controller->flash), "Failed to get flash\n");
+	if (IS_ERR(sys_controller->flash)) {
+		ret = dev_err_probe(dev, PTR_ERR(sys_controller->flash), "Failed to get flash\n");
+		goto out_free;
+	}
 
 no_flash:
 	sys_controller->client.dev = dev;
@@ -155,8 +157,7 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 	if (IS_ERR(sys_controller->chan)) {
 		ret = dev_err_probe(dev, PTR_ERR(sys_controller->chan),
 				    "Failed to get mbox channel\n");
-		kfree(sys_controller);
-		return ret;
+		goto out_free;
 	}
 
 	init_completion(&sys_controller->c);
@@ -174,6 +175,10 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Registered MPFS system controller\n");
 
 	return 0;
+
+out_free:
+	kfree(sys_controller);
+	return ret;
 }
 
 static void mpfs_sys_controller_remove(struct platform_device *pdev)
-- 
2.51.0




