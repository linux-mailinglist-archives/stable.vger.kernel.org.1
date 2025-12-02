Return-Path: <stable+bounces-198138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB41C9CBFD
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 20:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B13A89AD
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3662DC337;
	Tue,  2 Dec 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyAWOQ4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFDE2DAFAE
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703270; cv=none; b=GK5ZPedR/a3jn2dcP6V3ZUq218ZmKzDOnMvM3nuwW/IwfPIRQ93QYbclK7Zolns0ajvPJCUB7iyOgtZfSIQa45SdgeVsLeZ6cNkCpH//BWmnqxPSWjr2+HbUNQ0lqtR9wf95GokppbZE2WIXunjW/PpETA8F6pDYZ1vO6on9N/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703270; c=relaxed/simple;
	bh=dp4aqm1HsiklVdqxjUoXrudGl/0PsDz/jsplzv0cJMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyM08TdL40RYoTD/3JhQNe1zcHWtsRYSzKoN8v3oFM901SCniveN5AA6zOY+ZGXECP5ip7VIJsNhUrompEje0dwFIiTEtfqyPOKrWpFI3K8V1K/1A84KgVPMv7NFPqWX1IviI9wyVba0qgJofV2pxODpsAddyEHETjrwEZInJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyAWOQ4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCB0C116D0;
	Tue,  2 Dec 2025 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764703270;
	bh=dp4aqm1HsiklVdqxjUoXrudGl/0PsDz/jsplzv0cJMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyAWOQ4nTFmBOTCQx72FzglUIon47Hz1T9usmUv/ieZZjPQASiOheEeLGhvNBZiDZ
	 H/n4/n8KAAqvh0ZfiGW6vxG7kPljTkmusNwWFGQDuj13daY4xYZXo2tYWtNyD/HHw4
	 XXt+3Sq3ZPxu9oXf0X4EtOCABOuNZ+AS4tUQ4C/1/FggfW1P0ENxBLiQlYWWnVcOEU
	 cTp06pvyzbq83JAWb1GkwNZ+PFVRw+FJkyIQ7H7X1vq1VFli3apOE0DiTuoFqPqe3U
	 T3ywN5hRj5FbusGbf7LKosgT5/xBGOOcnrOlwCIl0TbFaJ5RzLtvFQtrIhUc5rTIi2
	 bDsNlPWjDPIfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] net: dsa: microchip: Don't free uninitialized ksz_irq
Date: Tue,  2 Dec 2025 14:20:59 -0500
Message-ID: <20251202192100.2403411-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202192100.2403411-1-sashal@kernel.org>
References: <2025120246-talcum-rectangle-f99d@gregkh>
 <20251202192100.2403411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>

[ Upstream commit 25b62cc5b22c45face094ae3e8717258e46d1d19 ]

If something goes wrong at setup, ksz_irq_free() can be called on
uninitialized ksz_irq (for example when ksz_ptp_irq_setup() fails). It
leads to freeing uninitialized IRQ numbers and/or domains.

Use dsa_switch_for_each_user_port_continue_reverse() in the error path
to iterate only over the fully initialized ports.

Cc: stable@vger.kernel.org
Fixes: cc13ab18b201 ("net: dsa: microchip: ptp: enable interrupt for timestamping")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Link: https://patch.msgid.link/20251120-ksz-fix-v6-3-891f80ae7f8f@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 0f80e21bf622 ("net: dsa: microchip: Free previously initialized ports on init failures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 664e3114a5bd0..4a7cb9dca3243 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2608,7 +2608,7 @@ static int ksz_setup(struct dsa_switch *ds)
 			ksz_ptp_irq_free(ds, dp->index);
 out_pirq:
 	if (dev->irq > 0)
-		dsa_switch_for_each_user_port(dp, dev->ds)
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds)
 			ksz_irq_free(&dev->ports[dp->index].pirq);
 out_girq:
 	if (dev->irq > 0)
-- 
2.51.0


