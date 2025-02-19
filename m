Return-Path: <stable+bounces-117412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46FA3B668
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D733BB2BE
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C31E1C1F;
	Wed, 19 Feb 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aJ1V74hm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D141E1C26;
	Wed, 19 Feb 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955204; cv=none; b=oIpuhlrIQr3stDPoVUCZnzvBut9eO/Y9twbbKtfyHcgqIfbaF2LjlgHXCrzo4bUfhcexWcdQ8iPXW94JoHq6iTN7t9prevO6n7oiieKfpkSQ8x4B4OMXWVu1IUsJitm3jYlJipqw37KD5HwAv7nLUAuHR0ZlIQu+UhOaCaEcI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955204; c=relaxed/simple;
	bh=Xxq6idH8dhSBd+9VXL9U9CZNHJkBQ6iSPLicat8eS64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwswk21p6kXGp5wnn2eCZgyM+mw1EA4QsZLPcmEf5hmz8SagzJ0tTrwZ1ziOi6gHCBPhfazxFYWhnGG1fSKBDmB7FrYhleFi0FYakIxiLywJutw/F9NBpg3IpTORhxaTLf6DntyuVyfNtP1W9lEa29tHtXpIScI9pF//4ABR42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aJ1V74hm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3ECC4CEE6;
	Wed, 19 Feb 2025 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955203;
	bh=Xxq6idH8dhSBd+9VXL9U9CZNHJkBQ6iSPLicat8eS64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJ1V74hmAXt3w7UfobkQPEsruoAkLKiVcGVZsLDVYu0lW0TotxWrd+ndY/KHvGOjl
	 SKGDQKbL33OfgBNJS5neMIaIoqVMxz8u9ujIV/duProbvGJQwEYrQzNQfgltETsGZi
	 LjzASfitCylTGTYtXJEWuILtJ6+RWmpxQ5adAGNA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 131/230] can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero
Date: Wed, 19 Feb 2025 09:27:28 +0100
Message-ID: <20250219082606.810822059@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Alexander Hölzl <alexander.hoelzl@gmx.net>

commit 44de577e61ed239db09f0da9d436866bef9b77dd upstream.

The J1939 standard requires the transmission of messages of length 0.

For example proprietary messages are specified with a data length of 0
to 1785. The transmission of such messages is not possible. Sending
results in no error being returned but no corresponding can frame
being generated.

Enable the transmission of zero length J1939 messages. In order to
facilitate this two changes are necessary:

1) If the transmission of a new message is requested from user space
the message is segmented in j1939_sk_send_loop(). Let the segmentation
take into account zero length messages, do not terminate immediately,
queue the corresponding skb.

2) j1939_session_skb_get_by_offset() selects the next skb to transmit
for a session. Take into account that there might be zero length skbs
in the queue.

Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20250205174651.103238-1-alexander.hoelzl@gmx.net
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
[mkl: commit message rephrased]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/j1939/socket.c    |    4 ++--
 net/can/j1939/transport.c |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1132,7 +1132,7 @@ static int j1939_sk_send_loop(struct j19
 
 	todo_size = size;
 
-	while (todo_size) {
+	do {
 		struct j1939_sk_buff_cb *skcb;
 
 		segment_size = min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
@@ -1177,7 +1177,7 @@ static int j1939_sk_send_loop(struct j19
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
-	}
+	} while (todo_size);
 
 	switch (ret) {
 	case 0: /* OK */
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -382,8 +382,9 @@ sk_buff *j1939_session_skb_get_by_offset
 	skb_queue_walk(&session->skb_queue, do_skb) {
 		do_skcb = j1939_skb_to_cb(do_skb);
 
-		if (offset_start >= do_skcb->offset &&
-		    offset_start < (do_skcb->offset + do_skb->len)) {
+		if ((offset_start >= do_skcb->offset &&
+		     offset_start < (do_skcb->offset + do_skb->len)) ||
+		     (offset_start == 0 && do_skcb->offset == 0 && do_skb->len == 0)) {
 			skb = do_skb;
 		}
 	}



