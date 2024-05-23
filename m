Return-Path: <stable+bounces-45773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C50C8CD3CD
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C62283D2B
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631714B07E;
	Thu, 23 May 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ogelknpd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9D2AE94;
	Thu, 23 May 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470320; cv=none; b=jI1tTzHQ3slbzBwlUxpX4aOWIJ0eRwDxegcVgzniGI7vR8XD/epeISXOpbAVmnFzGWxcItF5nKyh1uWOHDDBEDciqTA+s8VjT9lXgAZVm9SFHx2rjgY1JnjvWelKWXqXsDI/9Iw9VGJSc1oHvpNA+uqd+WG1L7V4rgrvEuQtqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470320; c=relaxed/simple;
	bh=Bb0q5r0EHV5ZzUgbgx+WXjBy5kmAWRWx15cns605iNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhmsFGlmwG9cOgCJkkMkh9IARBWgFtoyl5a21IXR8H6gvYGFZaX2ESe9HR0R7YgjERq742NuGXBPQ4k+oST4P6ke/GgE6NFtBphIhKnGALR9zndijf3y0WjbDjziH1jZu/Ez7GizV9nzZCajyWN71L/IzNkSy2oXPQHGyDK2Bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ogelknpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30ABC2BD10;
	Thu, 23 May 2024 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470320;
	bh=Bb0q5r0EHV5ZzUgbgx+WXjBy5kmAWRWx15cns605iNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgelknpdXkJzDqpVZXEpSwa5ugyI0+iroOlnBUsNRVMdjOchr8h3Mroa8Q8nExanX
	 NIFqZUhmWJsqF3RgEbvjV6WZX6eMm31HVDsTLr6B5jzn3FgGxi9LsihZdt/ng+rEqa
	 J+O2Ooqhvc+WTyUKHSBm8LGRoaFdAixQqfg+Od08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 06/23] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Thu, 23 May 2024 15:13:02 +0200
Message-ID: <20240523130328.196694486@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130327.956341021@linuxfoundation.org>
References: <20240523130327.956341021@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

commit d85cf67a339685beae1d0aee27b7f61da95455be upstream.

The EXT_RGMII_OOB_CTRL register can be written from different
contexts. It is predominantly written from the adjust_link
handler which is synchronized by the phydev->lock, but can
also be written from a different context when configuring the
mii in bcmgenet_mii_config().

The chances of contention are quite low, but it is conceivable
that adjust_link could occur during resume when WoL is enabled
so use the phydev->lock synchronizer in bcmgenet_mii_config()
to be sure.

Fixes: afe3f907d20f ("net: bcmgenet: power on MII block for all MII modes")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -264,6 +264,7 @@ int bcmgenet_mii_config(struct net_devic
 	 * block for the interface to work
 	 */
 	if (priv->ext_phy) {
+		mutex_lock(&phydev->lock);
 		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 		reg &= ~ID_MODE_DIS;
 		reg |= id_mode_dis;
@@ -272,6 +273,7 @@ int bcmgenet_mii_config(struct net_devic
 		else
 			reg |= RGMII_MODE_EN;
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+		mutex_unlock(&phydev->lock);
 	}
 
 	if (init)



