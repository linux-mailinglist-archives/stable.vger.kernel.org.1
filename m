Return-Path: <stable+bounces-104728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34499F52B6
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A95172771
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98361F869D;
	Tue, 17 Dec 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLcRBJkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF91F37BE;
	Tue, 17 Dec 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455921; cv=none; b=ZiWoHS39e48UVaiiWd/nzL5L0rRHZQ8I9WUSFNfiefilgjFHOBgS41UHzgs44c38RsLl8izmZbErnvkT+VisbzThjiBLIby/Mrb/y0GLohPZj4Ur0goQGoyuGYbYI2TbekURuJm0wupSILfTqmLMVSDm32FcDfRqLdprjGT7cak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455921; c=relaxed/simple;
	bh=n3OL7BDUDmJVb4cDJF+hruyKd/Iq3v5Phi5eKH8iqhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdWrVo+C3Rn6qj61VOFximtOy8K1Qp42GUyzqB+8hXGjRGAFWErTJN+zLfz2Ug7GqYnpDtFiR1WfvDej9U6N0NcPwU35Mj6lGeyoPPl/5eMcJWt8+vH8VRIQ5Pc0eLZecwXJAklgFZQLS18KOHG7qqpq+iyjvrD2QScAPyCYqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLcRBJkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E74C4CED3;
	Tue, 17 Dec 2024 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455921;
	bh=n3OL7BDUDmJVb4cDJF+hruyKd/Iq3v5Phi5eKH8iqhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLcRBJkhN04132oFBoDQtsfFfS2h+fJKUQRRDFZvhZ5L/OdD/9CI2nPg63T0GLxoV
	 owHCxHoU/sTrRX67KtCWYYJULOetJ9cztq6ikrN5/1RqcVo4i3qdNG9qx+YoYt0Qzi
	 /lwclnoijTh7PCa4zBhOzxrRkgyvpjM7dvGM3KoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 51/76] net: sparx5: fix the maximum frame length register
Date: Tue, 17 Dec 2024 18:07:31 +0100
Message-ID: <20241217170528.386409093@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
References: <20241217170526.232803729@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Machon <daniel.machon@microchip.com>

[ Upstream commit ddd7ba006078a2bef5971b2dc5f8383d47f96207 ]

On port initialization, we configure the maximum frame length accepted
by the receive module associated with the port. This value is currently
written to the MAX_LEN field of the DEV10G_MAC_ENA_CFG register, when in
fact, it should be written to the DEV10G_MAC_MAXLEN_CFG register. Fix
this.

Fixes: 946e7fd5053a ("net: sparx5: add port module support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 212bf6f4ed72..e1df6bc86949 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -1113,7 +1113,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	spx5_inst_rmw(DEV10G_MAC_MAXLEN_CFG_MAX_LEN_SET(ETH_MAXLEN),
 		      DEV10G_MAC_MAXLEN_CFG_MAX_LEN,
 		      devinst,
-		      DEV10G_MAC_ENA_CFG(0));
+		      DEV10G_MAC_MAXLEN_CFG(0));
 
 	/* Handle Signal Detect in 10G PCS */
 	spx5_inst_wr(PCS10G_BR_PCS_SD_CFG_SD_POL_SET(sd_pol) |
-- 
2.39.5




