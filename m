Return-Path: <stable+bounces-214293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHAjCz9ug2lNmwMAu9opvQ
	(envelope-from <stable+bounces-214293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:05:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ABCE9D9C
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC1E30A28F8
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319E2D8798;
	Wed,  4 Feb 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rUwdOlFK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8382D5C91;
	Wed,  4 Feb 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219205; cv=none; b=CbIT+K6xJDbGDrgd2uILrryziO2TfPTzx0H5cu558kRWjMfDUf5tbbjfRtdjYII317/Ih+iL7nsKQSrCBq2ibYvQUhTGjMPDm14dJWi3ybXh9H/RcgQFeiJHMxvW6Tmsl7E1sOwWbDBciVUXWz9EszJoo0+ZG/g2xsNIYJQ5zSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219205; c=relaxed/simple;
	bh=uPH6gZKj1UDBPPhtb9OscwXOinPwtzD2trN53FeRPCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cn0FLrUpVbKDMKRo8Mmb4cqxH1zwEqUoxW/6srMASgnZ2GM5+61Fehr7CWC1DgSg5CMRvtmJOwFkc605l3y55vkuIz1dXw5FYMKh85K5+mBTmdtgJHrvDfRfAsDCWrl1cXY1fQysC7jz/b3kHWsxmFfm5DT1dlN3qdebW22AvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rUwdOlFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EE7C4CEF7;
	Wed,  4 Feb 2026 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219205;
	bh=uPH6gZKj1UDBPPhtb9OscwXOinPwtzD2trN53FeRPCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUwdOlFKx3KjeBecHH/s5kTOAy1DnXiHbEDbcqlFNEkHCyUdK5UocEA0FQGnHW/UU
	 yeYCob2PR9gIvnujBeYgu5TBYwtAMz2IcK1XoHHEaCMYBCXAXyE5AlJ36ADi+Klmsx
	 vQqDVx6sTgRcWDdhJWnP/i1pf4+BFPMGravc8r/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Persson <andreasp56@outlook.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6.18 064/122] firewire: core: fix race condition against transaction list
Date: Wed,  4 Feb 2026 15:40:46 +0100
Message-ID: <20260204143854.158912069@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214293-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,sakamocchi.jp];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 90ABCE9D9C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 20e01bba2ae4898ce65cdcacd1bd6bec5111abd9 upstream.

The list of transaction is enumerated without acquiring card lock when
processing AR response event. This causes a race condition bug when
processing AT request completion event concurrently.

This commit fixes the bug by put timer start for split transaction
expiration into the scope of lock. The value of jiffies in card structure
is referred before acquiring the lock.

Cc: stable@vger.kernel.org # v6.18
Fixes: b5725cfa4120 ("firewire: core: use spin lock specific to timer for split transaction")
Reported-by: Andreas Persson <andreasp56@outlook.com>
Closes: https://github.com/alsa-project/snd-firewire-ctl-services/issues/209
Tested-by: Andreas Persson <andreasp56@outlook.com>
Link: https://lore.kernel.org/r/20260127223413.22265-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firewire/core-transaction.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -134,20 +134,14 @@ static void split_transaction_timeout_ca
 	}
 }
 
-static void start_split_transaction_timeout(struct fw_transaction *t,
-					    struct fw_card *card)
+// card->transactions.lock should be acquired in advance for the linked list.
+static void start_split_transaction_timeout(struct fw_transaction *t, unsigned int delta)
 {
-	unsigned long delta;
-
 	if (list_empty(&t->link) || WARN_ON(t->is_split_transaction))
 		return;
 
 	t->is_split_transaction = true;
 
-	// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
-	// local destination never runs in any type of IRQ context.
-	scoped_guard(spinlock_irqsave, &card->split_timeout.lock)
-		delta = card->split_timeout.jiffies;
 	mod_timer(&t->split_timeout_timer, jiffies + delta);
 }
 
@@ -168,13 +162,20 @@ static void transmit_complete_callback(s
 		break;
 	case ACK_PENDING:
 	{
+		unsigned int delta;
+
 		// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
 		// local destination never runs in any type of IRQ context.
 		scoped_guard(spinlock_irqsave, &card->split_timeout.lock) {
 			t->split_timeout_cycle =
 				compute_split_timeout_timestamp(card, packet->timestamp) & 0xffff;
+			delta = card->split_timeout.jiffies;
 		}
-		start_split_transaction_timeout(t, card);
+
+		// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
+		// local destination never runs in any type of IRQ context.
+		scoped_guard(spinlock_irqsave, &card->transactions.lock)
+			start_split_transaction_timeout(t, delta);
 		break;
 	}
 	case ACK_BUSY_X:



