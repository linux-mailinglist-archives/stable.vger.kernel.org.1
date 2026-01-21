Return-Path: <stable+bounces-210649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHVjKXg2cGl9XAAAu9opvQ
	(envelope-from <stable+bounces-210649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:14:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346F4F96D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEF1680FC1D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C8D32252D;
	Wed, 21 Jan 2026 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW2kW4Ue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C731AA8B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961617; cv=none; b=J2TSw7QI/LEBI2HO60xsqMCtUWq4Ezl2OkxV/lGDPS97+WuK8it4hb5/xB+drbW5qaYyQ2hYufx6anaoyRb9p/DUB8Lx/hiT7J+T6qxML3ljpAB3jusEGg557rPdWpNozQmaCQhUeHd2+W/9wwmxWC3ofK4ggE3eqyccsIKFYvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961617; c=relaxed/simple;
	bh=mEU7DIw1PF/HVE62qllBg+4Ww3LZW2RU6UaxpxNIVj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJgBSy7TIFjeokjJ250gxiKcjicuSVdi5dHZbBC+2OhkZqSPIXg+A7B0s7Z9waLpjQYX7AAZZ5ush3D9hqrTKFMtivaX0lvTrI6bLFUMrvt3rj+G4KShKPbYQxSIDCnnlswl7q7VVi9sI8b7YqZcRDfZyPvhCyUGXq1TjZIFHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW2kW4Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFBCC19424;
	Wed, 21 Jan 2026 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768961617;
	bh=mEU7DIw1PF/HVE62qllBg+4Ww3LZW2RU6UaxpxNIVj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nW2kW4UeUvnwX2k4QZY3KmkP1B4WSKmSjDKTlJBfN0wIPrxDn5KGn1Q1jJ6eiR3lI
	 wQb2xSBX/zsF71sb8hvS5FHkZGB8BjLTpR9AIXxJ7kvMqLjR2n1lR3xR+Cn0DKv3VT
	 FdhASNQH5l+Wrz1CQEX+dqtmYa2JmRAiKyc/wK+8awmytvqTvt8ipEaPP/6kbhGK4G
	 UOVc4GVJx2MU9QAuLUCZJD+3gXHPaVRYTBv8T6H0F92e+86gNcEA89l6S+MHJQNrIe
	 9AjNZb55enBG63M6oSXltJCxf7tTK3YIa/yuP204W8JMTmF1YkKr2ZIFqbkhy/jkOK
	 +FUsGIkfABQSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()
Date: Tue, 20 Jan 2026 21:13:33 -0500
Message-ID: <20260121021333.1126769-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121021333.1126769-1-sashal@kernel.org>
References: <2026012042-dealt-crudeness-5250@gregkh>
 <20260121021333.1126769-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-210649-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,linaro.org:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 4346F4F96D
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
index 03a1d1453c311..3a7e825a81b35 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1326,7 +1326,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						rphy);
 		if (ret) {
 			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
-			goto put_child;
+			return ret;
 		}
 	}
 
-- 
2.51.0


