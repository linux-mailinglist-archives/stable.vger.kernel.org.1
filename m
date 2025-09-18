Return-Path: <stable+bounces-175443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED01EB3681F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC741C24DD1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F3B34166C;
	Tue, 26 Aug 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwwZRqTi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635CE35207B;
	Tue, 26 Aug 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217057; cv=none; b=HWhz9Ko2KNfIhSZTQYOwLr0rx7nBHqXjO2B4fgkcVrK6qP4jEwQ7XBZ56UkXUHAacyStZ/LWOi6oHZdKI0UeYAW0yiHsfASFaKkdfcnezcTHuDU6ylAEhQJNwBblUx2fQWnW69x+LWkYKp84f+B9uJD22FN/nRi7grKHG6NzEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217057; c=relaxed/simple;
	bh=2r5VulRMlhWKBXOgKfJkfq/lPIhz1J5O0TAPKsUJKS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UznP9TQUGI3+FtCcBG43qqlzuRNX1ySLxyzQEb+cAW1euFyoS1eGX9xYT5js0NYHKK9MH3Wxqa4fM0ySeZBHZ6P60GkiW/1Yng/2Oyxg4t9+g24PPt/8emzR7bB4g34r18lkImz4pdzoDBIqFApQL7j/jd58mC3ae/8e6aSmL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwwZRqTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED72C4CEF1;
	Tue, 26 Aug 2025 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217057;
	bh=2r5VulRMlhWKBXOgKfJkfq/lPIhz1J5O0TAPKsUJKS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwwZRqTi+YlAC5G0vm6LtFxJZya72XxCQ2/KxQFLI3UPUjIou4F42ppoXhoNGqML4
	 PO11fkJKc5g1S0dN54Sj64lF07mYGiE89r9eHLtZNVMsXJCRPhfQ6zifPRMl+MfPT8
	 0K/4mAqRp5/hNKiHgmgvzQV85xmlf5wmqeAIK8Ys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Xing <kernelxing@tencent.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Priya Singh <priyax.singh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 635/644] ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc
Date: Tue, 26 Aug 2025 13:12:06 +0200
Message-ID: <20250826111002.296047492@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 4d4d9ef9dfee877d494e5418f68a1016ef08cad6 ]

Resolve the budget negative overflow which leads to returning true in
ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.

Before this patch, when the budget is decreased to zero and finishes
sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
and enter into the while() statement to see if it should keep processing
packets, but in the meantime it unexpectedly decreases the value again to
'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
true, showing 'we complete cleaning the budget'. That also means
'clean_complete = true' in ixgbe_poll.

The true theory behind this is if that budget number of descs are consumed,
it implies that we might have more descs to be done. So we should return
false in ixgbe_xmit_zc to tell napi poll to find another chance to start
polling to handle the rest of descs. On the contrary, returning true here
means job done and we know we finish all the possible descs this time and
we don't intend to start a new napi poll.

It is apparently against our expectations. Please also see how
ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
to make sure the budget can be decreased to zero at most and the negative
overflow never happens.

The patch adds 'likely' because we rarely would not hit the loop condition
since the standard budget is 256.

Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Priya Singh <priyax.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20250819222000.3504873-4-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index b399b9c14717..9a789a419166 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -392,7 +392,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (budget-- > 0) {
+	while (likely(budget)) {
 		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
@@ -427,6 +427,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
 			xdp_ring->next_to_use = 0;
+
+		budget--;
 	}
 
 	if (tx_desc) {
-- 
2.50.1




