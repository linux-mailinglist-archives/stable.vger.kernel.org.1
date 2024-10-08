Return-Path: <stable+bounces-82397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E171D994CA6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EA8B230E5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7F1DEFF7;
	Tue,  8 Oct 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwN1bSrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0351DE3A3;
	Tue,  8 Oct 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392123; cv=none; b=ccXFl67+zZe4Bjf/6oxP3saVHU+IV5mKzs+de07UL00V7kNeSdFI9wkA/O+mgDnIQfybRswUq8WU72vUFdsMZqvYMw2EHGfKR+UgVVZovi6LLDowwKOgS0bffpRcgoerlhZeEqHzAV9/vpJi3RiECqEkRb0q5dlWx9JoM52DTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392123; c=relaxed/simple;
	bh=i3ooIweCqAREXpTONO5GxJs4+z7qy6HbQWAgioSQVso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4WGQ/KIUS0x+KRMAY3Nyh2yMs0hKAok/Lhj+aECMnzeNPV6JMbKMs64LIM9+lEjIg48bU6cJ/W+2IYwc0rMsZOWus/IZ9oA0xraKC4raiX0h9/XX9VKNl4jRX6i4TCEx8Kl/4dJwttp0XEgmaL0lgX1TI4e1eVWiQATzq10r20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vwN1bSrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1642C4CEC7;
	Tue,  8 Oct 2024 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392123;
	bh=i3ooIweCqAREXpTONO5GxJs4+z7qy6HbQWAgioSQVso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vwN1bSrKeLaMiDB3GPSVsyOAswCAFSm20/gNsK5OfiIDVMrfsJNChXVKvpHNVCETb
	 AhWft6P5HJNHRWrgi5GdhG9AD7eXbnhoABu9JmGNc33AWX/6/hS1znyGTecEJfBzl4
	 4/37kb/PEh0soXlMONiwvLkGDbiUWQFdAdqgFXwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 323/558] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Date: Tue,  8 Oct 2024 14:05:53 +0200
Message-ID: <20241008115715.017416742@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0880f669436028c5499901e5acd8f4b4ea0e0c6a ]

Add missing MODULE_DEVICE_TABLE definition for automatic loading of the
driver when it is built as a module.

Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20240731072955.224125-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rpc-if.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index d3f07fd719bdb..b468a95972bf7 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -198,9 +198,16 @@ static int __maybe_unused rpcif_spi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
 
+static const struct platform_device_id rpc_if_spi_id_table[] = {
+	{ .name = "rpc-if-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, rpc_if_spi_id_table);
+
 static struct platform_driver rpcif_spi_driver = {
 	.probe	= rpcif_spi_probe,
 	.remove_new = rpcif_spi_remove,
+	.id_table = rpc_if_spi_id_table,
 	.driver = {
 		.name	= "rpc-if-spi",
 #ifdef CONFIG_PM_SLEEP
-- 
2.43.0




