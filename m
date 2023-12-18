Return-Path: <stable+bounces-7179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A829281714C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A82CB20E7E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0C129ED2;
	Mon, 18 Dec 2023 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eKe0EXSu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD2129EF7;
	Mon, 18 Dec 2023 13:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98872C433C8;
	Mon, 18 Dec 2023 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907774;
	bh=nwRcq5S2mAydgmIrDHEZhaB/feyE1QIHYS3KcC6prEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKe0EXSuHLQxkKu9YMLVVdZbEuJuco0YnXbFMzPuKjR++K1A9yIRnf+0dARry+oot
	 vj32BwwV+aGKEKL2IE/9DXXjukF2wRj4FSUORJj4tAcRd0Gk/MU4+VmTPebSPoN+PC
	 oM3xmhiPEyYQyRONXjPUyOb50/SQfoTP7TV1dW3M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Igor Russkikh <irusskikh@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/106] net: atlantic: fix double free in ring reinit logic
Date: Mon, 18 Dec 2023 14:50:56 +0100
Message-ID: <20231218135056.817273171@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Russkikh <irusskikh@marvell.com>

[ Upstream commit 7bb26ea74aa86fdf894b7dbd8c5712c5b4187da7 ]

Driver has a logic leak in ring data allocation/free,
where double free may happen in aq_ring_free if system is under
stress and driver init/deinit is happening.

The probability is higher to get this during suspend/resume cycle.

Verification was done simulating same conditions with

    stress -m 2000 --vm-bytes 20M --vm-hang 10 --backoff 1000
    while true; do sudo ifconfig enp1s0 down; sudo ifconfig enp1s0 up; done

Fixed by explicitly clearing pointers to NULL on deallocation

Fixes: 018423e90bee ("net: ethernet: aquantia: Add ring support code")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/netdev/CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com/
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Link: https://lore.kernel.org/r/20231213094044.22988-1-irusskikh@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index b5a49166fa972..4d9d7d1edb9b3 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -938,11 +938,14 @@ void aq_ring_free(struct aq_ring_s *self)
 		return;
 
 	kfree(self->buff_ring);
+	self->buff_ring = NULL;
 
-	if (self->dx_ring)
+	if (self->dx_ring) {
 		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
 				  self->size * self->dx_size, self->dx_ring,
 				  self->dx_ring_pa);
+		self->dx_ring = NULL;
+	}
 }
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
-- 
2.43.0




