Return-Path: <stable+bounces-257218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKQsD14YG2r2/AgAu9opvQ
	(envelope-from <stable+bounces-257218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B073160ED0A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4C723047BDD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA633FE15;
	Sat, 30 May 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zdNh4I8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AA32D42B;
	Sat, 30 May 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160224; cv=none; b=oElOFEmHRD+zYUlJeh6IAkf1IQx/u5+MDGhnzZnOoxEMyIYhbXfClaQui7qLTcAL6Re+p7dlHlnPJYokTCAs4hF3GB30Zzt3HI74/cViu9arE1cxJIqAjnty6m57BE0OMjMpijYJuU36McckWcDzeCSxnqwWSBKjHT36OUKXNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160224; c=relaxed/simple;
	bh=YOKJXE/8Er5pmd/wzp7y/x8/IINkWWIYfoOFFQRZWz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt6EfC8qiyi0TOUfBFUctZ6MqrLvPPzWNoWJqUCJsHhHn+QVbr1aJWcSej1wTWBx607gyvFCvnqfrH3p2XaSM5+96i9SCIHDkD+XU8iKmwtERvsJKGdY46kCmpGafO4XaFQobPL58ws9jUzNLhFlIxCEThAYGFMZkqLwFSYIuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zdNh4I8V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AAC1F00893;
	Sat, 30 May 2026 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160223;
	bh=XaYu//ZksSsDkT3UYSOlNYnbAsp31p5yWtV3gOBOiz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zdNh4I8VVUFBP65WzUUS/V5ElNE+m+dlNmpss1FiYEYKXgIeD+SktjzgOpuAoaXw2
	 DAkPf03yhqxrPq00x7nCiskAMaLVQlb/ba3SAubQbzOAhh0vMGiFywYyMAbGNvZEMP
	 DoKZn1q+358bPSymMBvsENZiN1UFuaEg1JoPo2Bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Fleming <mfleming@cloudflare.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.1 280/969] ipmi: Add limits to event and receive message requests
Date: Sat, 30 May 2026 17:56:44 +0200
Message-ID: <20260530160308.203451878@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257218-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B073160ED0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit c4cca236968683eb0d59abfb12d5c7e4d8514227 upstream.

The driver would just fetch events and receive messages until the
BMC said it was done.  To avoid issues with BMCs that never say they are
done, add a limit of 10 fetches at a time.

In addition, an si interface has an attn state it can return from the
hardware which is supposed to cause a flag fetch to see if the driver
needs to fetch events or message or a few other things.  If the attn
bit gets stuck, it's a similar problem.  So allow messages in between
flag fetches so the driver itself doesn't get stuck.

This is a more general fix than the previous fix for the specific bad
BMC, but should fix the more general issue of a BMC that won't stop
saying it has data.

This has been there from the beginning of the driver.  It's not a bug
per-se, but it is accounting for bugs in BMCs.

Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/lkml/20260415115930.3428942-1-matt@readmodwrite.com/
Fixes: <1da177e4c3f4> ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |   54 +++++++++++++++++++++++++++++++--------
 drivers/char/ipmi/ipmi_ssif.c    |   23 +++++++++++++++-
 2 files changed, 64 insertions(+), 13 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -162,6 +162,10 @@ struct smi_info {
 			     OEM2_DATA_AVAIL)
 	unsigned char       msg_flags;
 
+	/* When requesting events and messages, don't do it forever. */
+	unsigned int        num_requests_in_a_row;
+	bool		    last_was_flag_fetch;
+
 	/* Does the BMC have an event buffer? */
 	bool		    has_event_buffer;
 
@@ -394,7 +398,10 @@ static void start_getting_msg_queue(stru
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->si_state = SI_GETTING_MESSAGES;
+	if (smi_info->si_state != SI_GETTING_MESSAGES) {
+		smi_info->num_requests_in_a_row = 0;
+		smi_info->si_state = SI_GETTING_MESSAGES;
+	}
 }
 
 static void start_getting_events(struct smi_info *smi_info)
@@ -405,7 +412,10 @@ static void start_getting_events(struct
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->si_state = SI_GETTING_EVENTS;
+	if (smi_info->si_state != SI_GETTING_EVENTS) {
+		smi_info->num_requests_in_a_row = 0;
+		smi_info->si_state = SI_GETTING_EVENTS;
+	}
 }
 
 /*
@@ -579,6 +589,7 @@ static void handle_transaction_done(stru
 			smi_info->si_state = SI_NORMAL;
 		} else {
 			smi_info->msg_flags = msg[3];
+			smi_info->last_was_flag_fetch = true;
 			handle_flags(smi_info);
 		}
 		break;
@@ -624,6 +635,11 @@ static void handle_transaction_done(stru
 		} else {
 			smi_inc_stat(smi_info, events);
 
+			smi_info->num_requests_in_a_row++;
+			if (smi_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				smi_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+
 			/*
 			 * Do this before we deliver the message
 			 * because delivering the message releases the
@@ -662,6 +678,11 @@ static void handle_transaction_done(stru
 		} else {
 			smi_inc_stat(smi_info, incoming_messages);
 
+			smi_info->num_requests_in_a_row++;
+			if (smi_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				smi_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+
 			/*
 			 * Do this before we deliver the message
 			 * because delivering the message releases the
@@ -790,6 +811,26 @@ restart:
 	}
 
 	/*
+	 * If we are currently idle, or if the last thing that was
+	 * done was a flag fetch and there is a message pending, try
+	 * to start the next message.
+	 *
+	 * We do the waiting message check to avoid a stuck flag
+	 * completely wedging the driver.  Let a message through
+	 * in between flag operations if that happens.
+	 */
+	if (si_sm_result == SI_SM_IDLE ||
+	    (si_sm_result == SI_SM_ATTN && smi_info->waiting_msg &&
+	     smi_info->last_was_flag_fetch)) {
+		smi_info->last_was_flag_fetch = false;
+		smi_inc_stat(smi_info, idles);
+
+		si_sm_result = start_next_msg(smi_info);
+		if (si_sm_result != SI_SM_IDLE)
+			goto restart;
+	}
+
+	/*
 	 * We prefer handling attn over new messages.  But don't do
 	 * this if there is not yet an upper layer to handle anything.
 	 */
@@ -822,15 +863,6 @@ restart:
 		}
 	}
 
-	/* If we are currently idle, try to start the next message. */
-	if (si_sm_result == SI_SM_IDLE) {
-		smi_inc_stat(smi_info, idles);
-
-		si_sm_result = start_next_msg(smi_info);
-		if (si_sm_result != SI_SM_IDLE)
-			goto restart;
-	}
-
 	if ((si_sm_result == SI_SM_IDLE)
 	    && (atomic_read(&smi_info->req_events))) {
 		/*
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -225,6 +225,9 @@ struct ssif_info {
 	bool		    has_event_buffer;
 	bool		    supports_alert;
 
+	/* When requesting events and messages, don't do it forever. */
+	unsigned int        num_requests_in_a_row;
+
 	/*
 	 * Used to tell what we should do with alerts.  If we are
 	 * waiting on a response, read the data immediately.
@@ -413,7 +416,10 @@ static void start_event_fetch(struct ssi
 	}
 
 	ssif_info->curr_msg = msg;
-	ssif_info->ssif_state = SSIF_GETTING_EVENTS;
+	if (ssif_info->ssif_state != SSIF_GETTING_EVENTS) {
+		ssif_info->num_requests_in_a_row = 0;
+		ssif_info->ssif_state = SSIF_GETTING_EVENTS;
+	}
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
 	msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -436,7 +442,10 @@ static void start_recv_msg_fetch(struct
 	}
 
 	ssif_info->curr_msg = msg;
-	ssif_info->ssif_state = SSIF_GETTING_MESSAGES;
+	if (ssif_info->ssif_state != SSIF_GETTING_MESSAGES) {
+		ssif_info->num_requests_in_a_row = 0;
+		ssif_info->ssif_state = SSIF_GETTING_MESSAGES;
+	}
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
 	msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -843,6 +852,11 @@ static void msg_done_handler(struct ssif
 			ssif_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
 			handle_flags(ssif_info, flags);
 		} else {
+			ssif_info->num_requests_in_a_row++;
+			if (ssif_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				ssif_info->msg_flags &= ~EVENT_MSG_BUFFER_FULL;
+
 			handle_flags(ssif_info, flags);
 			ssif_inc_stat(ssif_info, events);
 			deliver_recv_msg(ssif_info, msg);
@@ -876,6 +890,11 @@ static void msg_done_handler(struct ssif
 			ssif_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
 			handle_flags(ssif_info, flags);
 		} else {
+			ssif_info->num_requests_in_a_row++;
+			if (ssif_info->num_requests_in_a_row > 10)
+				/* Stop if we do this too many times. */
+				ssif_info->msg_flags &= ~RECEIVE_MSG_AVAIL;
+
 			ssif_inc_stat(ssif_info, incoming_messages);
 			handle_flags(ssif_info, flags);
 			deliver_recv_msg(ssif_info, msg);



