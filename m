Return-Path: <stable+bounces-41709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170148B5903
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0628B265F8
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8015338D;
	Mon, 29 Apr 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="acchTnQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE1C15D
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394766; cv=none; b=TyyeWCpTwX/PpOmundYYTOzkOY5md98yOZZLGlE475ByWZhYeXHpG65KVEeoyl6gm6y9/7qYuuXqQi8EDryEZWvonjXtTcOBfpJDLSlMrclHdfipyldm37Vq2UlwaAi1E96UEdUS7xoJWXcd5FOOhnp3G4OOvjtj5EeX8cjacow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394766; c=relaxed/simple;
	bh=gWTUTGV23GnmACCyOn2YV0YxAvwB0i2K/6+5zEmnTDI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M/P8MuTacnz7KVMVNM1uJjaEzihw2JBwTEgES8zRyLON8JvOrDVt7kSlBXsjwUdaiIlPkNux9HSH/NCs2FK3C4e6OuHXF2rRMoAU0wd62nZzyI5j2Tq3evvxMakUn37iQgbNdFlIJKbpdyOyKCc+uuHK7mpv79yDcgCQvYaWf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=acchTnQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D76C113CD;
	Mon, 29 Apr 2024 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714394766;
	bh=gWTUTGV23GnmACCyOn2YV0YxAvwB0i2K/6+5zEmnTDI=;
	h=Subject:To:Cc:From:Date:From;
	b=acchTnQ/qB2HhWK3IFbZxOXxGuh+8XFdkR9SNn0TbnHSSBuvA+vMJAMACG/0o/EUV
	 5HX0q7A63iUmp0noIoLrZMOIHYlpTpTEEshON1N5ssxhw+1dqhFnAaHyXWAjNnNnul
	 x8T6XGgCNYmUHgpJMA+pwbOZyQCj0C9VIw01FR1g=
Subject: FAILED: patch "[PATCH] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff" failed to apply to 6.6-stable tree
To: rrameshbabu@nvidia.com,bpoirier@nvidia.com,cratiu@nvidia.com,kuba@kernel.org,sd@queasysnail.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 14:46:03 +0200
Message-ID: <2024042903-compel-crushing-17a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 39d26a8f2efcb8b5665fe7d54a7dba306a8f1dff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042903-compel-crushing-17a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

39d26a8f2efc ("net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39d26a8f2efcb8b5665fe7d54a7dba306a8f1dff Mon Sep 17 00:00:00 2001
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Date: Tue, 23 Apr 2024 11:13:05 -0700
Subject: [PATCH] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff
 md_dst for MACsec

mlx5 Rx flow steering and CQE handling enable the driver to be able to
update an skb's md_dst attribute as MACsec when MACsec traffic arrives when
a device is configured for offloading. Advertise this to the core stack to
take advantage of this capability.

Cc: stable@vger.kernel.org
Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-5-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index b2cabd6ab86c..cc9bcc420032 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1640,6 +1640,7 @@ static const struct macsec_ops macsec_offload_ops = {
 	.mdo_add_secy = mlx5e_macsec_add_secy,
 	.mdo_upd_secy = mlx5e_macsec_upd_secy,
 	.mdo_del_secy = mlx5e_macsec_del_secy,
+	.rx_uses_md_dst = true,
 };
 
 bool mlx5e_macsec_handle_tx_skb(struct mlx5e_macsec *macsec, struct sk_buff *skb)


