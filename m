Return-Path: <stable+bounces-95294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD199D74FC
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5F6165693
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9471024A95A;
	Sun, 24 Nov 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRg8mkZ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485461E9080;
	Sun, 24 Nov 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456608; cv=none; b=FjQHin0JaTclKRXZqzdDBTsvSKPlS0Q0ZV+W4B73HxWBIQq9QRNtu3FrpeiawiMOEQKQC3GtBFKy/lf+ZwJDNTnaa6WSVqAxKaAL2gfzid9gxN/J0I2DSw3o9X08VxOBEBAjQflKWMIy3oGjgFdCchwdpqhMbkFu2xPEn05zzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456608; c=relaxed/simple;
	bh=RN5+bYzXHaA243Bl5fdWpJsPsbjG7LHHc8OvMuC4qH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmrbQb5UqONIwgKPAhhWcnEt7VwgnJFMOVcFMfquPSzyMImA0GUFVLbMCw8KFe3RGMvC27NFlGDaKGTxVfns/yWMb715cgwkycPceZwTlNNuDzi2CoHUCdJcEYuXQg1Hg5aBjyrSPduSb7zn44b1LEEvx6KMFV2LtJj6SBqK3mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRg8mkZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA0EC4CECC;
	Sun, 24 Nov 2024 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456607;
	bh=RN5+bYzXHaA243Bl5fdWpJsPsbjG7LHHc8OvMuC4qH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRg8mkZ/26CDG2JpnYfGUXveSuNUd+Wv8U1LtHKY/eOsOwgO//PJ955dGOpj5k2Uk
	 6DSUF/a9qQqk6svp5/eEiAOXAM96HtgdW1x4RcuGcMBtVEZloxM0iMa96sMmeISSNH
	 gt0uZvhDPQmgznRGFtjRXiPhfsRxX4jnWe85o1FzP5Xh4BAaQciFos9ootOSbSGzuG
	 oaIJ9sNKkRAOcRFIfVEnvfe75HiM7mpC66lanY+lmwSurSRsVh4Hf6MU27L4ESdVvk
	 4Bx6KTkahniqCBVIjKgQRqTXLPQEqkbFruu44dD/5wmQ+f/IsPv7Vonx8XZnTOXNej
	 JJmlg09ZLtqlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 26/28] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:55:26 -0500
Message-ID: <20241124135549.3350700-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit e64285ff41bb7a934bd815bd38f31119be62ac37 ]

Since '1 << rocker_port->pport' may be undefined for port >= 32,
cast the left operand to 'unsigned long long' like it's done in
'rocker_port_set_enable()' above. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20241114151946.519047-1-dmantipov@yandex.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/rocker/rocker_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 5abb3f9684ffd..6bee5055559fe 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2542,7 +2542,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.43.0


