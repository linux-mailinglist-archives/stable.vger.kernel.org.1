Return-Path: <stable+bounces-239403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEVOJ35X5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6B42FE0E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2490D33A90A4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D632E696;
	Mon, 20 Apr 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtTzLQp0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E83385B2;
	Mon, 20 Apr 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700157; cv=none; b=mmi2ihoFiogPnLxyPJgNaKNlu2rziR/OT0HWUu2MdovuWEJ5iL8a/Qb/Q6qfyCrAY+wVAomMYgqsdTd+iG/TyrJV/wtbtL3sqRUpzzsvg+4eiUcYdPLypEO7i9cI7AI7QPKUOTcvYkXt2XHjYqZwA18AyBuoTyoYhsVsU2ZQWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700157; c=relaxed/simple;
	bh=YWhfHmZBeJSAVSHPLHeDtOR5ufelwEQ99arUOMy2ZLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRfF0XepYO6BQh+l1T2uaOS/1ybx+8uVreicOdwa1Zvfpr4eLZonudaZxIagb+276l7GHieg5oizUNsCfOS6RmPPX5pJ9Vbr8C91+D33ZypK0d9A4TyJdUz6vxhfUhmaH+bGQr83EGXD9Qqo/ritC3P/6/S0k552MjkU3bRsg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtTzLQp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35433C19425;
	Mon, 20 Apr 2026 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700157;
	bh=YWhfHmZBeJSAVSHPLHeDtOR5ufelwEQ99arUOMy2ZLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtTzLQp0VtfHNv+OjLm8nI3eAvfqj9Lvfh2reYQTR2k8S2Bm2w9Rx0RK1A1YBCZu5
	 cJqkV4F48IurBUFc/1+b94WBy3IVGFSvSU04XA+HaJFxkmG4M41TvtYW/4xEryDxlS
	 KRG0bdRiRAOAQe7CZv81Arp6wruRO5CZ1CXRPoxc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 063/220] soc: microchip: mpfs-mss-top-sysreg: Fix resource leak on driver unbind
Date: Mon, 20 Apr 2026 17:40:04 +0200
Message-ID: <20260420153936.309995526@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-239403-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,microchip.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 16B6B42FE0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 3bfc213d4675736567a4e263c51c25144d565949 ]

Use devm_mfd_add_devices() instead of mfd_add_devices() to ensure
child devices are properly removed when the driver unbinds.

Fixes: 4aac11c9a6e7 ("soc: microchip: add mfd drivers for two syscon regions on PolarFire SoC")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/microchip/mpfs-mss-top-sysreg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-mss-top-sysreg.c b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
index b2244e44ff0fa..b0f42b8dd3ed6 100644
--- a/drivers/soc/microchip/mpfs-mss-top-sysreg.c
+++ b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
@@ -16,8 +16,10 @@ static int mpfs_mss_top_sysreg_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_mss_top_sysreg_devs,
-			      ARRAY_SIZE(mpfs_mss_top_sysreg_devs) , NULL, 0, NULL);
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   mpfs_mss_top_sysreg_devs,
+				   ARRAY_SIZE(mpfs_mss_top_sysreg_devs), NULL,
+				   0, NULL);
 	if (ret)
 		return ret;
 
-- 
2.53.0




