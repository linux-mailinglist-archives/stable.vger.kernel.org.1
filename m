Return-Path: <stable+bounces-117120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC2A3B490
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429877A6A49
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21B1E9901;
	Wed, 19 Feb 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AZUxnbpT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E31CAA7D;
	Wed, 19 Feb 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954269; cv=none; b=ukjD37IGnH2WAlFtRyfipZZlnQinKn4XK8jszoC2Jgjugt97PA/QwoH6TWtu9jHi15t9I+IDDr7rE35GltlUNw8B/VDgcnuunT2jMpKZFipGfWWMttel8vR3ViQsd0fEFzm1UPdQ3JODmGwwL+DoLdOGBZn7mbzsTceibhJWmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954269; c=relaxed/simple;
	bh=yiLXbXxymNpwEgPw5Xi8gyTJVs65o7QxJCUgzYl4Mg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPBYPoRzgLpsP6VolkRYkn31d5XGkRh/DVrd0/tu4qkTVjGTr2Zx0z0zuvDw134169ovkPiW/Ze7TZRO/8rWYKTvW5mqQzqDz+knMdgpfgYnfUkqdK7ZEYd0C6F2/aZtqguUGk8HfFnTJE8f6EpgaSv26aKefsIrdssMAP1AYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AZUxnbpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4608C4CEEC;
	Wed, 19 Feb 2025 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954269;
	bh=yiLXbXxymNpwEgPw5Xi8gyTJVs65o7QxJCUgzYl4Mg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZUxnbpTB3ycVVzsDccHoG5mwt97NiSsGwdiPmDE6hmSqWxxiNuamYwMWhTQKcz82
	 awYN9fF4cfx/x6hTjFxgApbbew/XIw4yKaKvWQWeEkC0fT6AXwm6i39ZAEqJLvHtNd
	 UPYXys+EQ13EzpwCHnq1SNNpsszu6rC2J23dUqFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.13 151/274] can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero
Date: Wed, 19 Feb 2025 09:26:45 +0100
Message-ID: <20250219082615.508975833@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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



