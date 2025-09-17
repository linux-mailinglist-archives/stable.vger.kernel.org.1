Return-Path: <stable+bounces-180417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CFB80B20
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362EB3BB6B2
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC8314D1A;
	Wed, 17 Sep 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="ZBiiUnVa"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3B2E228D
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123618; cv=none; b=WgfuH2MkW/ilQP2AQoOjOHBCdrV6ccjMSfHJramqbPOg2nlrfG2wYg1veITD71UwKNxSumkruSruExoMWjDLZkuSJnxIV+6hC7Xv1dT3ROGkd7hO46X9VOQMzJ+J6J/7POZBJfAUTHN0JeU5INd6dSxHwAXxpa2tazeuWecinHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123618; c=relaxed/simple;
	bh=W+nAB7mlSdd0jKuQKWnzw6YNuQNulCyIVJxWcBkg+d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffFdkqn8Jmo154ru/6sbYWvMKWLQEPZpZgHPnt0P/D3gfjy4pQt/enMvzbZ5x5e/02KPay06OixiM6UoAV8ZlsGKv/MvDo2+kuQHisfoQa5K3iy+4vSk2qSBXGCRamBMIclUh4aU5zS5l/Ae3HMFkcLAIC3tCElk41RZS/xbLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=ZBiiUnVa; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id BF93A1C127B
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 18:31:22 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1758123081; x=
	1758987082; bh=W+nAB7mlSdd0jKuQKWnzw6YNuQNulCyIVJxWcBkg+d0=; b=Z
	BiiUnVaI6vLZjymUDuFgCXZ3jG+cidW+H0VlpfQWgMME89/Uxx/R3T4xfrf53Nxe
	ON1BkHyPnLzTrwt2rzuIoBCxW91HlHpFLu2T8yJwwbwLaCmfpTV1x++3P/QG1kOB
	uEEBZPrttiy49qHbQFt02q/88Z0meUhY5fU0VKz0/Y=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2XsYiC4QNvIe for <stable@vger.kernel.org>;
	Wed, 17 Sep 2025 18:31:21 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 024D61C0CC1;
	Wed, 17 Sep 2025 18:31:18 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] net: liquidio: fix overflow in octeon_init_instr_queue()
Date: Wed, 17 Sep 2025 15:30:58 +0000
Message-ID: <20250917153105.562563-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expression `(conf->instr_type == 64) << iq_no` can overflow because
`iq_no` may be as high as 64 (`CN23XX_MAX_RINGS_PER_PF`). Casting the
operand to `u64` ensures correct 64-bit arithmetic.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org # v4.2+
Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/net/ethernet/cavium/liquidio/request_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index de8a6ce86ad7..12105ffb5dac 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -126,7 +126,7 @@ int octeon_init_instr_queue(struct octeon_device *oct,
 	oct->io_qmask.iq |= BIT_ULL(iq_no);
 
 	/* Set the 32B/64B mode for each input queue */
-	oct->io_qmask.iq64B |= ((conf->instr_type == 64) << iq_no);
+	oct->io_qmask.iq64B |= ((u64)(conf->instr_type == 64) << iq_no);
 	iq->iqcmd_64B = (conf->instr_type == 64);
 
 	oct->fn_list.setup_iq_regs(oct, iq_no);
-- 
2.43.0


