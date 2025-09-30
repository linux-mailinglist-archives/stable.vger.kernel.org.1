Return-Path: <stable+bounces-182093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C5BAD44C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A57E1638EC
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DE2FB622;
	Tue, 30 Sep 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uCAl9K0w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADA265CCD;
	Tue, 30 Sep 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243809; cv=none; b=JW9Vo2yxU4t9TGz4DQQESoeyKYkQNfuLrhTudLssdKmdDvd6poEYAgHAbhqfXJLYMxnCsFxmqmEm87xBjD4P2S44nEPGTbNwA/ScU6RFNdudDxJGPzEJZW41vHbck3ueb8y4DeFx8OKhblNVKdv3jjanyqkyfKb+dzg1LZlOHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243809; c=relaxed/simple;
	bh=9yVzvrcCblygAI2G3yySxkqNPiVFH13tST2w/4LgbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COEO3hqMYXjB9s2r2ko/RoL6iMd+W7YF1jDktZpiLenMytdJ39l3scmwYcrUAQHZ8rG1RLh2l4VZlbA0PcFF1RkiNiSSFliKzb+KaR+b9XFfUYrest5V1nIcaOO1zfVMzl3O6yeuYK5MmJDm5RwbhHC8yoqsngmgxTOIhPNPGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uCAl9K0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF8C4CEF0;
	Tue, 30 Sep 2025 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759243808;
	bh=9yVzvrcCblygAI2G3yySxkqNPiVFH13tST2w/4LgbDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCAl9K0wWsh9seXlJKAKtb2HNzH/AYmxIZVaabBvPH03e9D11uQ/ZWl6rs+GO9ajA
	 mdusAou3WwuR1kmdDdGc8VnBIzvjXF3+OD1YzShgPuGCgbrm4lrx//eioAQC/gEvGl
	 G0XoTpLvgxOezINImLOLvwaq6ufBNvz4jpfxcqgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 5.4 23/81] i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path
Date: Tue, 30 Sep 2025 16:46:25 +0200
Message-ID: <20250930143820.636524005@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 915470e1b44e71d1dd07ee067276f003c3521ee3 ]

If request_irq() in i40e_vsi_request_irq_msix() fails in an iteration
later than the first, the error path wants to free the IRQs requested
so far. However, it uses the wrong dev_id argument for free_irq(), so
it does not free the IRQs correctly and instead triggers the warning:

 Trying to free already-free IRQ 173
 WARNING: CPU: 25 PID: 1091 at kernel/irq/manage.c:1829 __free_irq+0x192/0x2c0
 Modules linked in: i40e(+) [...]
 CPU: 25 UID: 0 PID: 1091 Comm: NetworkManager Not tainted 6.17.0-rc1+ #1 PREEMPT(lazy)
 Hardware name: [...]
 RIP: 0010:__free_irq+0x192/0x2c0
 [...]
 Call Trace:
  <TASK>
  free_irq+0x32/0x70
  i40e_vsi_request_irq_msix.cold+0x63/0x8b [i40e]
  i40e_vsi_request_irq+0x79/0x80 [i40e]
  i40e_vsi_open+0x21f/0x2f0 [i40e]
  i40e_open+0x63/0x130 [i40e]
  __dev_open+0xfc/0x210
  __dev_change_flags+0x1fc/0x240
  netif_change_flags+0x27/0x70
  do_setlink.isra.0+0x341/0xc70
  rtnl_newlink+0x468/0x860
  rtnetlink_rcv_msg+0x375/0x450
  netlink_rcv_skb+0x5c/0x110
  netlink_unicast+0x288/0x3c0
  netlink_sendmsg+0x20d/0x430
  ____sys_sendmsg+0x3a2/0x3d0
  ___sys_sendmsg+0x99/0xe0
  __sys_sendmsg+0x8a/0xf0
  do_syscall_64+0x82/0x2c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [...]
  </TASK>
 ---[ end trace 0000000000000000 ]---

Use the same dev_id for free_irq() as for request_irq().

I tested this with inserting code to fail intentionally.

Fixes: 493fb30011b3 ("i40e: Move q_vectors from pointer to array to array of pointers")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 13d92c378957f..e37e8a31b35d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3897,7 +3897,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		irq_num = pf->msix_entries[base + vector].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
 		irq_update_affinity_hint(irq_num, NULL);
-		free_irq(irq_num, &vsi->q_vectors[vector]);
+		free_irq(irq_num, vsi->q_vectors[vector]);
 	}
 	return err;
 }
-- 
2.51.0




