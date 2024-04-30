Return-Path: <stable+bounces-42457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6298B7320
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11521C2320C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACA12E1C9;
	Tue, 30 Apr 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2f4r6I5j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89512D76F;
	Tue, 30 Apr 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475727; cv=none; b=pziYzRKX6udhCbVWJQHgxpHoCD4SRXSPb3OFEUYzccb3p15tHf0jaRFc9b5BC9ZAFqQ61r48NLP0f3ohlipPy03HbMB3CDvDgF8LmWXK7XcqiyWoBZH/Z8zVrbaYmcepB+xhRgt56ombutsUiaAkWzrkUorSJOorFI74aemTYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475727; c=relaxed/simple;
	bh=TKx4ABt9G5wDsi2jpP0ZgHBwGlf/9LotGEHr2w19N1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXbST3k9sjPUipR+WbQsNxys1urorh6OcaifQmAsHwljVSvQ7Pbz/Sh+XlwlfExL9EOwilupnlQRH3aUqRJOe/I8sneprEZHWt9cPteZ7IRdj6IKZRzewv3pKcj9XOamqO1lS3dk01jpmdaaZ0k/Go4mL7wV5k0C4JtyR++g8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2f4r6I5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F94C2BBFC;
	Tue, 30 Apr 2024 11:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475727;
	bh=TKx4ABt9G5wDsi2jpP0ZgHBwGlf/9LotGEHr2w19N1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2f4r6I5j7L5Nce2B3XPCoa5h+jVZlJcCesu5YpSw4xg8YFlnXDs8xNVd8b5R2wrLw
	 9eRG6F13qsjWutWYVlzhimRShp6KxAwHt61/cLZQgNlx97fD2u6WxcWMklg/OXE90M
	 kcn0HWiIOIbawcV9qD0cxCTj1G4ho9aS83w4H9Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 185/186] net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec
Date: Tue, 30 Apr 2024 12:40:37 +0200
Message-ID: <20240430103103.402032645@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

commit 39d26a8f2efcb8b5665fe7d54a7dba306a8f1dff upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1640,6 +1640,7 @@ static const struct macsec_ops macsec_of
 	.mdo_add_secy = mlx5e_macsec_add_secy,
 	.mdo_upd_secy = mlx5e_macsec_upd_secy,
 	.mdo_del_secy = mlx5e_macsec_del_secy,
+	.rx_uses_md_dst = true,
 };
 
 bool mlx5e_macsec_handle_tx_skb(struct mlx5e_macsec *macsec, struct sk_buff *skb)



