Return-Path: <stable+bounces-210635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFDAJ1MucGniWwAAu9opvQ
	(envelope-from <stable+bounces-210635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:39:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1614F31F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A08B90FB71
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A33090EE;
	Wed, 21 Jan 2026 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbM3q6mf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB72777F3
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959540; cv=none; b=VuBqfvf8zdp+KMeN9KdnGkJQ+e/YyW5/nZBwYU551RxFuUy3vSqki6XXoruw+gEVS6I3+TgUmZlwQ6tSQv+jj5QOJEEdoKm28p9D4A1B5TjUWSSxfA30rQbxeqR1x/3rAuxW+dgiFeyO0ndthW6qSBsQyqo3wU0cRjsjOKBXyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959540; c=relaxed/simple;
	bh=y0ZiPG3MjWV44T3YHMqO3nCXNMuRIXXv0g1XuXE6VDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixwCT24U2uje8KbQESslhzyDy3szb0jSP2L1DU3e3Q5CG/cEiVpLavCOWKaPf5nmmo/q29M/x+D2gsfh4E0L+quKhwXdxrOKuLPU0527KQKuXWkuX1AB+BNkDyacWz9Xgudjpasd6gz++IlhHUCmWtrYFjB4ZX5GdXgAvar5bUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbM3q6mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FC5C2BC86;
	Wed, 21 Jan 2026 01:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768959539;
	bh=y0ZiPG3MjWV44T3YHMqO3nCXNMuRIXXv0g1XuXE6VDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbM3q6mfeEoHsVI7SQDxrSCDolqqV5ynEd5zxiX5hJjzMWws24WEsVea6dKi0/9qv
	 eYU8WdCLr90o9pbSh3DfDIXwpZDTAvxGe4sWjhlgfD066L//TOHvh+oOS4yKBT2+qY
	 dcYcLI121nxfAxtktd1+pIB6NLQSBX41k8fRyivrn3cXyxl8k/oi761UkJvRYoq7eI
	 BqM+ahWIxrLc/6PYgi1UEBDdvgaPYoihYIxP/l2wYfjdHKxTCCV8zGzKLkb3CBYabX
	 Dd/nNo6EgGMCN/x2uXdoW9svghLzqRcF+1ELmVIRN1cV4VVeB8LyZZtgcwoY2U2jIJ
	 l3cmDFNrmsCCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()
Date: Tue, 20 Jan 2026 20:38:56 -0500
Message-ID: <20260121013856.1104103-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121013856.1104103-1-sashal@kernel.org>
References: <2026012036-dress-salvaging-8848@gregkh>
 <20260121013856.1104103-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-210635-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,iscas.ac.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: 0C1614F31F
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
index 78a6dccba07a3..79b2199cff86e 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1469,7 +1469,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						rphy);
 		if (ret) {
 			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
-			goto put_child;
+			return ret;
 		}
 	}
 
-- 
2.51.0


