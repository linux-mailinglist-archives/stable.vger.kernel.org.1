Return-Path: <stable+bounces-163944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A046B0DC57
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34830188CC49
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1222CBE9;
	Tue, 22 Jul 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ts8M6tV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BE7263D;
	Tue, 22 Jul 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192728; cv=none; b=ZxYDMQ4KcWb+3Ed5vs4Me9rKsepJ+PTSo4pVGJvtHyZp7QMO36Jeg2CLbt5JiwB5BP1/sOOQyTnpUOkShlu4qZYStjbagHeZwRHWRoOvvn71XnSZfb9yuXMFiy3WxGMmz+PN4DD7iK45aWoz+AviPl2v0i9R1N+A1CQqUVz53T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192728; c=relaxed/simple;
	bh=X6LT+s37632v6JCaycceN7Sl/8AO3rqhlSVvEqDveUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo76kZxicezj5GmoShgbR62FukHFRFz7b5c13/YzFLxsHqtyB9kXSkehRdulPZK8NH8e7a7TFdYQzRos//U0pgUXpkvyqxzHhnJM/Rn7ovzI5x+AdiC+fGbmD1lsXySpl/SK3U6ykW65hg6Zv0i1e03fb7eCwjFupoIxMOSV7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ts8M6tV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0C6C4CEEB;
	Tue, 22 Jul 2025 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192728;
	bh=X6LT+s37632v6JCaycceN7Sl/8AO3rqhlSVvEqDveUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ts8M6tV1XdoJj/vph3f94Z6dyjWRsDfa0Sve96znvnnyAD2VzsNUojiBYvKIITNNy
	 Aauy/eshj32ER9ZzKdDr5PkQeE/mkA5OTdYSs/cAvXwJWq1aOIWbqsgLKCQXMoBLZ3
	 kwguari/M8nG6s/D5kjmawZ6MaHmrQ0cGIPaKpY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 040/158] net/mlx5: Update the list of the PCI supported devices
Date: Tue, 22 Jul 2025 15:43:44 +0200
Message-ID: <20250722134342.237782692@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maor Gottlieb <maorg@nvidia.com>

commit ad4f6df4f384905bc85f9fbfc1c0c198fb563286 upstream.

Add the upcoming ConnectX-10 device ID to the table of supported
PCI device IDs.

Cc: stable@vger.kernel.org
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/1752650969-148501-1-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2241,6 +2241,7 @@ static const struct pci_device_id mlx5_c
 	{ PCI_VDEVICE(MELLANOX, 0x1021) },			/* ConnectX-7 */
 	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
 	{ PCI_VDEVICE(MELLANOX, 0x1025) },			/* ConnectX-9 */
+	{ PCI_VDEVICE(MELLANOX, 0x1027) },			/* ConnectX-10 */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */



