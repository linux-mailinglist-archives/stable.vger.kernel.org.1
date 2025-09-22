Return-Path: <stable+bounces-181093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2672B92D94
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8AF446C23
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E432F39DE;
	Mon, 22 Sep 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLfmQqbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2742F28F6;
	Mon, 22 Sep 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569671; cv=none; b=Z+RCUO3fsQvYXRUkLO0LCDtEZctMuefZf4/ZTNFhEzG/uMTtTegSgknNHUbQebpUz3T+9Z3SFIkRPox5KSmxkbP5N0dewbDFRLe3or121shnTLkDJA44/keh9oQKvYoNPccLPLaXydDOARnsidkSeVFh7z6XuzKGOLqk5XGU8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569671; c=relaxed/simple;
	bh=WeBZYku2iNTgGSXimXmVAkSjeqaaADCKt5Lt0CBgA+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJF1dKAVE6fkhiMaQpv7AK+Csad3CwOWxbJfH/D7tKkK94Y1CckMzGfgdu4KGnTs/ipxZb9dF0pEcfM6EmBJQYPBPC0fW65eO5LkquvRV94eK/L1cf79aacb7P7NzBuQB6OVY/TzI9jz77AdISWmdPoCYGiVvrFHQxg+ZFC8M+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLfmQqbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1C4C4CEF0;
	Mon, 22 Sep 2025 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569671;
	bh=WeBZYku2iNTgGSXimXmVAkSjeqaaADCKt5Lt0CBgA+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLfmQqbPgxH0qxceKfb8/ytMiGeFGf9jLXdqKNoXAQnUJF08UA490wYQTc6SSKLaV
	 wNWal+KLoV3Gj4mewBeJ1HqQ8VDBMf+3vKYv9/bKtXFYLVcqtFW6zDfgRvkhJnEWbK
	 yj/mwMI4EEkhkS+aOF8j7RtnjoEBw8x2V2JsbXqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Nepomnyashih <sdl@nppct.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 23/70] net: liquidio: fix overflow in octeon_init_instr_queue()
Date: Mon, 22 Sep 2025 21:29:23 +0200
Message-ID: <20250922192405.185035417@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Nepomnyashih <sdl@nppct.ru>

[ Upstream commit cca7b1cfd7b8a0eff2a3510c5e0f10efe8fa3758 ]

The expression `(conf->instr_type == 64) << iq_no` can overflow because
`iq_no` may be as high as 64 (`CN23XX_MAX_RINGS_PER_PF`). Casting the
operand to `u64` ensures correct 64-bit arithmetic.

Fixes: f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/liquidio/request_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index de8a6ce86ad7e..12105ffb5dac6 100644
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
2.51.0




