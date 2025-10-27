Return-Path: <stable+bounces-191067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78CC11021
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88CE5809EA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C251B3233F5;
	Mon, 27 Oct 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N88Z+hJT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3230CD92;
	Mon, 27 Oct 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592927; cv=none; b=FAw5msC08XQFqfnQAY3eBxsY7x+wjuJEraxXIqOsgkcVC62/zUZdsId5kwx40UDvFk7MbOam/uEY5tLxrsxzrwzmGOCRxefCNPbyyK6gN3pktMOnNrDfI+AzkpVNW7tRJZUBbkieWKIKg8W72+RTptJTkhq2OV3Zs4hJAN5mzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592927; c=relaxed/simple;
	bh=t79sqMtxmBB2gSupgicOSnMs/YY8lqlRBMI3Lg089Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHzNJt8RjqJ8LhrQIlZozwtW7bDw5S+fd16YNnP37NHFMFeglDWn/O0HN3dQ4XNKWKxNbYpae65+/KE3DyJi1QUQD/jO/yoNIW6DADNdJBmSp0i0T+i8z2e1xWrBJD8WSHzkenGbwt02aYfoqYd4jPTtIUs6/t3iPg+YK5SrgMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N88Z+hJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C518C4CEF1;
	Mon, 27 Oct 2025 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592926;
	bh=t79sqMtxmBB2gSupgicOSnMs/YY8lqlRBMI3Lg089Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N88Z+hJTqY6XyaxZUIvFx+rmNK9X9InhRB4/E3UOTL5rDJAd+oJpfxhZvUqQ9ZYYp
	 Gc5ENAYS8HobHdiPhvaj0uKtYarOWs1YmFaxB4mKxim7+EfXept+HMJaH9BNBUHQ36
	 ssY2CymOS+wfhiOc3YvyD6f70fYVBk3WgCWioJLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 064/117] net: ravb: Ensure memory write completes before ringing TX doorbell
Date: Mon, 27 Oct 2025 19:36:30 +0100
Message-ID: <20251027183455.742115831@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 706136c5723626fcde8dd8f598a4dcd251e24927 upstream.

Add a final dma_wmb() barrier before triggering the transmit request
(TCCR_TSRQ) to ensure all descriptor and buffer writes are visible to
the DMA engine.

According to the hardware manual, a read-back operation is required
before writing to the doorbell register to guarantee completion of
previous writes. Instead of performing a dummy read, a dma_wmb() is
used to both enforce the same ordering semantics on the CPU side and
also to ensure completion of writes.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Cc: stable@vger.kernel.org
Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://patch.msgid.link/20251017151830.171062-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/ravb_main.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2224,6 +2224,14 @@ static netdev_tx_t ravb_start_xmit(struc
 		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
+
+	/* Before ringing the doorbell we need to make sure that the latest
+	 * writes have been committed to memory, otherwise it could delay
+	 * things until the doorbell is rang again.
+	 * This is in replacement of the read operation mentioned in the HW
+	 * manuals.
+	 */
+	dma_wmb();
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
 
 	priv->cur_tx[q] += num_tx_desc;



