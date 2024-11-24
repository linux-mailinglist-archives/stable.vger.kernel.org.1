Return-Path: <stable+bounces-95316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C82FA9D76A1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D95BE851A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF324F883;
	Sun, 24 Nov 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/BPhpIv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCF24F87B;
	Sun, 24 Nov 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456674; cv=none; b=OLDrtrjuHvA33pGtMcfsj+mOeXL0mOH6HhAQmjkE3ERy6xVkquRRY2p30/u1hDbQs92qqSWduEYZA6bSAaVbjxL9oQ6v/DWFACRV3lldhNlXOkENIHIKvyhN+FE955p2EH5hB2HbW421evw3YPNZIbbgwAo2C+VVfz8ekfEEvs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456674; c=relaxed/simple;
	bh=eMmAEwOzJ8pHIRIblxWdgDRhwBgDYr7wuDKZ33L19Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbVsJoS8OU9ehFIfUslpGiLSGdOmSdmVlJsiauBJ0QZyxPh2jtoIJrlQoDPszTt+G+LlMMs/ujZXgq3aDaWe39nBzM9ymnDVZp3RvHkhboczkSlxdKzg0wwB6WvtT0MO1165Le55ipU7yv2RkOBzuspstQLgXzsxFmRGLaC+3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/BPhpIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2987DC4CED1;
	Sun, 24 Nov 2024 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456674;
	bh=eMmAEwOzJ8pHIRIblxWdgDRhwBgDYr7wuDKZ33L19Cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/BPhpIvgNUv+9OQ+mCwnzUEcrW0v2YPa7yLbQHf3qwroaeYwkAdekuzXeKKyASiW
	 RsWsyiAEqNGICZNY9SMe1UPSIeD/gqgZjOeoL/SBxoBiVP5J/zdhEvfDUvm8ebQqPY
	 ln1hRsYFcqsb/5PjWsLc+KSC5ggolXVrw3AbAV/jHrBtM/Zq581k7BSI5UWf3oFH/b
	 R1NgJ2LxEAjHlbkVNne8t1Y5PM5DeRTNu58W7He5l2ULX2SGsXz5imrEaeWJXjbzIh
	 rnvJRN73JZesViSh5uR5seuCg6aS8MOEvmH9rzzyNI7UMrsfoe+SC1PKOrFJb+lPN/
	 ANsJSX97vxZQA==
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
Subject: [PATCH AUTOSEL 4.19 20/21] rocker: fix link status detection in rocker_carrier_init()
Date: Sun, 24 Nov 2024 08:56:53 -0500
Message-ID: <20241124135709.3351371-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index 7d81de57b6f4c..184aceaf34e73 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2535,7 +2535,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.43.0


