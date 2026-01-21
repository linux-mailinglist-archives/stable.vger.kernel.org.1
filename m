Return-Path: <stable+bounces-210640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ASgJbUwcGkSXAAAu9opvQ
	(envelope-from <stable+bounces-210640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:49:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317B4F574
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B691972DC6C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358AA314B7C;
	Wed, 21 Jan 2026 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOOhxnX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB283101AD
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960155; cv=none; b=CUVNc0jpqI9gNCM8uE+VhoJPB+qoWxEFWh0bhbVMG2cT3YNVX4CYzCmuhMgjvu7SilBAjm//j3fNY6WeDWFb2YTFBwXcXhASRFGcCFzoCTniqcMaZqXDUl9N0XuTpaqH62xnKvUT3qPWVOmWKHGjKQX1RzpKe3dskQquk2KD6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960155; c=relaxed/simple;
	bh=U+QlZ60byuLmMeiLasZsjA83A795FGornhsXvucQr/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb07mUafHZWgNgvD/mvOi08r7n3m27WYKU+0q52JYjNiPqJ+2i/hpzV8Zzkza6N8ikvmOR7fo0bZY76sCZcRPqyHdhsaDBfLvphTpjASjRJ65gCZX1S/Oo5qLOxQ4r4IqNzKOw3QuD0Y0lOY3HewjT/X8Fsa1OzX8mdQ+TktYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOOhxnX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEDDC19424;
	Wed, 21 Jan 2026 01:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768960154;
	bh=U+QlZ60byuLmMeiLasZsjA83A795FGornhsXvucQr/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOOhxnX1EbdvPe0wlsn9bgRbsB8NoiZ6hpnD4l/X1waxZGMmOU9ZeD1UoVHF1g9jG
	 0p95dVk+RrRREmaDoQl1cQEywzPS1XErwXdKjG0evfv96nVbJRVjUoZ5Yd2seX9FRX
	 4xqrUjPltrWUuNx2aIQJ3FWENji+j1GGih/4Cx6wX+8RknrpUzMeT57ZROoHvqZNbv
	 78NwhcnU2d0gLp5YKvZteWAsqCc8x9rOENqD9i7QB1VFt0pW7FBLTBP+ZiupQPYCO8
	 Os308KOL3ypv8DvukYt0QLTCOv4tvPSCXf/p2zsKvjxByDpLzYU3DUKgcYRopwEsex
	 k4jEzjR46g7IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()
Date: Tue, 20 Jan 2026 20:49:11 -0500
Message-ID: <20260121014911.1112178-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121014911.1112178-1-sashal@kernel.org>
References: <2026012036-stock-spout-b6b1@gregkh>
 <20260121014911.1112178-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210640-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,iscas.ac.cn:email,linaro.org:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0317B4F574
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit e07dea3de508cd6950c937cec42de7603190e1ca ]

The for_each_available_child_of_node() calls of_node_put() to
release child_np in each success loop. After breaking from the
loop with the child_np has been released, the code will jump to
the put_child label and will call the of_node_put() again if the
devm_request_threaded_irq() fails. These cause a double free bug.

Fix by returning directly to avoid the duplicate of_node_put().

Fixes: ed2b5a8e6b98 ("phy: phy-rockchip-inno-usb2: support muxed interrupts")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260109154626.2452034-1-vulab@iscas.ac.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index afc6459926090..83b5e4407ae45 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1448,7 +1448,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						rphy);
 		if (ret) {
 			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
-			goto put_child;
+			return ret;
 		}
 	}
 
-- 
2.51.0


