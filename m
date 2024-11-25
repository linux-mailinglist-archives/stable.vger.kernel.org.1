Return-Path: <stable+bounces-95402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336659D890F
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7442286572
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C21AF0B6;
	Mon, 25 Nov 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD8GzYpp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647A1946B9
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548049; cv=none; b=uTLzGqHqliHv0BqUB6ELvtjt2fI9qoP2GFGvN/jriyXXaq5Ijis3445Ov75s4rGytWi4LnG/XFuXFN/yPbm2rrEO7UihGLmmnMwTlcd32SMKCTG1i9OhVvxIWHuHM0ll7yUTofT8gGOF/3D/kyoaRyXEQBU3lroOZH3rJpspAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548049; c=relaxed/simple;
	bh=yj8V1wofobpUVKQcWuhe+GkE3mI1UkmtFdlEorXvlPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hq5SOL3egRhtsxTkrRtIH2KgdUBMkV7RP4RGvMn75LrCy9R94d81z23cuB91coAUkf7TBWbCvTrO0Bt5qYTtZWD1fhEyUncLH3Ri6+vqhvXbX7giLZfIa2pNq+hRoMhBZe2JhMfH899UYA5q3GAW5JsP2Kzyu3THOTmpKoF7w9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD8GzYpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F9C4CECE;
	Mon, 25 Nov 2024 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548049;
	bh=yj8V1wofobpUVKQcWuhe+GkE3mI1UkmtFdlEorXvlPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dD8GzYppNWa+UHL6LoL3PHG/qMhKyRoKM6tnVcldvAskfc0pzkTqSwPNcHtPjdgyV
	 xVfiYNhHVUNj7mmZtgvy42PEnrKUXr9qKTqbpq8G8RFFd11mWndjhhD/fJqLjJZT9y
	 LO+a8FE2PbKup4QrRxVXDDSfuAT3M3df+2rpm8us/pqR1j3o3vTMHwvAIxsJ5CkBrY
	 hBgkT+xSMTC5BxIlQyugs16pF0JQARxbtuM4Js4E/Rfeqtgqnv/aVQDxt5n/UnkT/l
	 2Lq74w9OyjsYs69myWjIJxQYt3eRFOjS2DAHRFtyym347v5G/vp0l8UeRjyVWbZ1fq
	 qCRo4iiU8yHpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
Date: Mon, 25 Nov 2024 10:20:47 -0500
Message-ID: <20241125100249-1c012e0994360c86@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125-mcp251xfd-fix-length-calculation-v1-1-974445b5f893@pengutronix.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 3c1c18551e6ac1b988d0a05c5650e3f6c95a1b8a


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:44:04.236185172 -0500
+++ /tmp/tmp.NB9ip9De6Z	2024-11-25 09:44:04.228767153 -0500
@@ -1,55 +1,93 @@
-Commit b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround
-broken TEF FIFO tail index erratum") introduced
-mcp251xfd_get_tef_len() to get the number of unhandled transmit events
-from the Transmit Event FIFO (TEF).
-
-As the TEF has no head pointer, the driver uses the TX FIFO's tail
-pointer instead, assuming that send frames are completed. However the
-check for the TEF being full was not correct. This leads to the driver
-stop working if the TEF is full.
-
-Fix the TEF full check by assuming that if, from the driver's point of
-view, there are no free TX buffers in the chip and the TX FIFO is
-empty, all messages must have been sent and the TEF must therefore be
-full.
+As the TEF has no head index, the driver uses the TX-FIFO's tail index
+instead, assuming that send frames are completed.
 
-Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>
-Closes: https://patch.msgid.link/FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
+When calculating the number of unhandled TEF events, that commit
+didn't take mcp2518fd erratum DS80000789E 6. into account. According
+to that erratum, the FIFOCI bits of a FIFOSTA register, here the
+TX-FIFO tail index might be corrupted.
+
+However here it seems the bit indicating that the TX-FIFO is
+empty (MCP251XFD_REG_FIFOSTA_TFERFFIF) is not correct while the
+TX-FIFO tail index is.
+
+Assume that the TX-FIFO is indeed empty if:
+- Chip's head and tail index are equal (len == 0).
+- The TX-FIFO is less than half full.
+  (The TX-FIFO empty case has already been checked at the
+   beginning of this function.)
+- No free buffers in the TX ring.
+
+If the TX-FIFO is assumed to be empty, assume that the TEF is full and
+return the number of elements in the TX-FIFO (which equals the number
+of TEF elements).
+
+If these assumptions are false, the driver might read to many objects
+from the TEF. mcp251xfd_handle_tefif_one() checks the sequence numbers
+and will refuse to process old events.
+
+Reported-by: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
+Closes: https://patch.msgid.link/CAJ7t6HgaeQ3a_OtfszezU=zB-FqiZXqrnATJ3UujNoQJJf7GgA@mail.gmail.com
 Fixes: b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum")
-Tested-by: Sven Schuchmann <schuchmann@schleissheimer.de>
-Cc: stable@vger.kernel.org
-Link: https://patch.msgid.link/20241104-mcp251xfd-fix-length-calculation-v3-1-608b6e7e2197@pengutronix.de
+Not-yet-Cc: stable@vger.kernel.org
 Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
 ---
- drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 10 +++++++---
- 1 file changed, 7 insertions(+), 3 deletions(-)
+ drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 29 ++++++++++++++++++++++++++-
+ 1 file changed, 28 insertions(+), 1 deletion(-)
 
 diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
-index f732556d233a7..d3ac865933fdf 100644
+index d3ac865933fdf6c4ecdd80ad4d7accbff51eb0f8..e94321849fd7e69ed045eaeac3efec52fe077d96 100644
 --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
 +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
-@@ -16,9 +16,9 @@
- 
- #include "mcp251xfd.h"
- 
--static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)
-+static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)
- {
--	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
-+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
+@@ -21,6 +21,11 @@ static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)
+ 	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
  }
  
++static inline bool mcp251xfd_tx_fifo_sta_less_than_half_full(u32 fifo_sta)
++{
++	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFHRFHIF;
++}
++
  static inline int
-@@ -122,7 +122,11 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
- 	if (err)
- 		return err;
+ mcp251xfd_tef_tail_get_from_chip(const struct mcp251xfd_priv *priv,
+ 				 u8 *tef_tail)
+@@ -147,7 +152,29 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
+ 	BUILD_BUG_ON(sizeof(tx_ring->obj_num) != sizeof(len));
  
--	if (mcp251xfd_tx_fifo_sta_full(fifo_sta)) {
-+	/* If the chip says the TX-FIFO is empty, but there are no TX
-+	 * buffers free in the ring, we assume all have been sent.
+ 	len = (chip_tx_tail << shift) - (tail << shift);
+-	*len_p = len >> shift;
++	len >>= shift;
++
++	/* According to mcp2518fd erratum DS80000789E 6. the FIFOCI
++	 * bits of a FIFOSTA register, here the TX-FIFO tail index
++	 * might be corrupted.
++	 *
++	 * However here it seems the bit indicating that the TX-FIFO
++	 * is empty (MCP251XFD_REG_FIFOSTA_TFERFFIF) is not correct
++	 * while the TX-FIFO tail index is.
++	 *
++	 * We assume the TX-FIFO is empty, i.e. all pending CAN frames
++	 * haven been send, if:
++	 * - Chip's head and tail index are equal (len == 0).
++	 * - The TX-FIFO is less than half full.
++	 *   (The TX-FIFO empty case has already been checked at the
++	 *    beginning of this function.)
++	 * - No free buffers in the TX ring.
 +	 */
-+	if (mcp251xfd_tx_fifo_sta_empty(fifo_sta) &&
-+	    mcp251xfd_get_tx_free(tx_ring) == 0) {
- 		*len_p = tx_ring->obj_num;
- 		return 0;
- 	}
++	if (len == 0 && mcp251xfd_tx_fifo_sta_less_than_half_full(fifo_sta) &&
++	    mcp251xfd_get_tx_free(tx_ring) == 0)
++		len = tx_ring->obj_num;
++
++	*len_p = len;
+ 
+ 	return 0;
+ }
+
+---
+base-commit: fcc79e1714e8c2b8e216dc3149812edd37884eef
+change-id: 20241115-mcp251xfd-fix-length-calculation-96d4a0ed11fe
+
+Best regards,
+-- 
+Marc Kleine-Budde <mkl@pengutronix.de>
+
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.11.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

