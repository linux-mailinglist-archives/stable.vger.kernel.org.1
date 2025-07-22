Return-Path: <stable+bounces-163830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC87B0DBEA
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727653A5983
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3C2EAB71;
	Tue, 22 Jul 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y16dfSB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C6E2EA16A;
	Tue, 22 Jul 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192348; cv=none; b=NXj7EOsjcHFjGc/Icsuw3/VCUe3FDpwpxxdH+xqmyvS2AlOkRF7Bq02YzO9WAykiOXtuRTpR7u7zpcmRRJMsBvDA9hlue6WjZRGgsJFBMzgWO0Ds0ABA20+WQMDAmHfCviEiF/61jHfMioEBCX5cjK84ahXksbuHXWzeZYSLrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192348; c=relaxed/simple;
	bh=0fo1TnrZrhHq2338lwMoyWuXELZPcx7vt5iUbpYYf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFu/wnxMdB81zJ0MRw18v83R19H9b6TGxbIvp+pzEL2bbgEHxSUGdfoM1Wn2P4N3/bgB2bHj2/+DhqIJHYgs0x/jc8aUEmCNr/iBJ488fukLqD8NdtpONa1wY9oYJx6ipAZtgDqKDo6jSD2Zr+BLpsavFpzTyvrAY6IrLoPVieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y16dfSB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8E2C4CEEB;
	Tue, 22 Jul 2025 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192348;
	bh=0fo1TnrZrhHq2338lwMoyWuXELZPcx7vt5iUbpYYf8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y16dfSB04q+FvXOX8fuWGpsHMniAG3kVUwfV23OCTMEJNaSKP+9s7VGLz7DiCEDMc
	 xqu+ujrqc7JCOJ9zFysDsC8FDiWU4bZUBJEuP5BkYm2Dc75SyObv8obh8cqIn4Ro3Q
	 zq85dBFP6iqlmzccJvq4XdjRYHaAnwumLbYf1cKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	LongJun Tang <tanglongjun@kylinos.cn>,
	Yun Lu <luyun@kylinos.cn>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.6 032/111] af_packet: fix soft lockup issue caused by tpacket_snd()
Date: Tue, 22 Jul 2025 15:44:07 +0200
Message-ID: <20250722134334.602295080@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
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

From: Yun Lu <luyun@kylinos.cn>

commit 55f0bfc0370539213202f4ce1a07615327ac4713 upstream.

When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
pending_refcnt to decrement to zero before returning. The pending_refcnt
is decremented by 1 when the skb->destructor function is called,
indicating that the skb has been successfully sent and needs to be
destroyed.

If an error occurs during this process, the tpacket_snd() function will
exit and return error, but pending_refcnt may not yet have decremented to
zero. Assuming the next send operation is executed immediately, but there
are no available frames to be sent in tx_ring (i.e., packet_current_frame
returns NULL), and skb is also NULL, the function will not execute
wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
will enter a do-while loop, waiting for pending_refcnt to be zero. Even
if the previous skb has completed transmission, the skb->destructor
function can only be invoked in the ksoftirqd thread (assuming NAPI
threading is enabled). When both the ksoftirqd thread and the tpacket_snd
operation happen to run on the same CPU, and the CPU trapped in the
do-while loop without yielding, the ksoftirqd thread will not get
scheduled to run. As a result, pending_refcnt will never be reduced to
zero, and the do-while loop cannot exit, eventually leading to a CPU soft
lockup issue.

In fact, skb is true for all but the first iterations of that loop, and
as long as pending_refcnt is not zero, even if incremented by a previous
call, wait_for_completion_interruptible_timeout() should be executed to
yield the CPU, allowing the ksoftirqd thread to be scheduled. Therefore,
the execution condition of this function should be modified to check if
pending_refcnt is not zero, instead of check skb.

-	if (need_wait && skb) {
+	if (need_wait && packet_read_pending(&po->tx_ring)) {

As a result, the judgment conditions are duplicated with the end code of
the while loop, and packet_read_pending() is a very expensive function.
Actually, this loop can only exit when ph is NULL, so the loop condition
can be changed to while (1), and in the "ph = NULL" branch, if the
subsequent condition of if is not met,  the loop can break directly. Now,
the loop logic remains the same as origin but is clearer and more obvious.

Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
Cc: stable@kernel.org
Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2852,15 +2852,21 @@ static int tpacket_snd(struct packet_soc
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
-			if (need_wait && skb) {
+			/* Note: packet_read_pending() might be slow if we
+			 * have to call it as it's per_cpu variable, but in
+			 * fast-path we don't have to call it, only when ph
+			 * is NULL, we need to check the pending_refcnt.
+			 */
+			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
 					goto out_put;
 				}
-			}
-			/* check for additional frames */
-			continue;
+				/* check for additional frames */
+				continue;
+			} else
+				break;
 		}
 
 		skb = NULL;
@@ -2949,14 +2955,7 @@ tpacket_error:
 		}
 		packet_increment_head(&po->tx_ring);
 		len_sum += tp_len;
-	} while (likely((ph != NULL) ||
-		/* Note: packet_read_pending() might be slow if we have
-		 * to call it as it's per_cpu variable, but in fast-path
-		 * we already short-circuit the loop with the first
-		 * condition, and luckily don't have to go that path
-		 * anyway.
-		 */
-		 (need_wait && packet_read_pending(&po->tx_ring))));
+	} while (1);
 
 	err = len_sum;
 	goto out_put;



