Return-Path: <stable+bounces-241753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCf4HDv48GkpbgEAu9opvQ
	(envelope-from <stable+bounces-241753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:11:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C855A48A785
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFFE2303E2F9
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A9466B72;
	Tue, 28 Apr 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="mo2BXDrP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBE466B7B
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399584; cv=none; b=B8HJtc/yTUm8z4IM3z7VP6kEVIIYkzeNcKzJr6k4dVv3Nr3W/ewgBWMwQNaFzNiSpe0k8tgLSz8U7jASFIbdkiAguZUPvgDdGhoXEqQwIa1wYax1moATWzsTxhw6njfmkZXYG0rm9ir0xblccF1UGsRPqOh752fww6wEgMswhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399584; c=relaxed/simple;
	bh=yGRPQCL8WqFeuS7EVnEwH+TjdE4/D6RfQ5ewxRCqrvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLgy7rY22XzfcSTrbQdaiV+YVAzTm0z7ua3LEHAzHgRCzNpaqKdM/crurn8aIi/B9MK6myPlSOKOu5tUAXMieJGeLa3fytIAknZzxUt0eEzoGWbL/XLhMK2BtzzfJ83y/vrUXUp4YUXCFnZRvyJ9NXtjG0gdYB1mxKC7mjxJ5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=mo2BXDrP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479ef2b7979so5545703b6e.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777399580; x=1778004380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZbCNADRk3D0+2vwBJopRNuItlsnuhx1YgLD19rJec8=;
        b=mo2BXDrPqIXttDZrl1gdh3YxwlgqkLj5rBxBGIDKNPSKigV5QI+a+WBsEdqoL1pilS
         1jg0DRMVO6VeqO2QnnY4ggBzMR+9lHYNqhFm00jQpZuvjJBED4SgvihYH3OAF3AN3jxE
         RUXZzN/H03bfnLlwxroy8ty5Fqzm6NAjVP1+KKkB7XCn4lgSCXw6dnip9IX5pzCTKXBn
         s9dny1nYHsmF7BJmvTlK6zrnPIb2Pe+mH1C7dZgGez8Qt75X6Q9iovC+aqI1TA1JymuC
         bTTHnL08AVFTnSiJCpLUBK5/4t/3u0rFJJhx6yVWi80qsgsxbicVextrgEF/8MeIB7eL
         iTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399580; x=1778004380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZbCNADRk3D0+2vwBJopRNuItlsnuhx1YgLD19rJec8=;
        b=blPNn7im6u+l2cw/lC9JitAOnjMMnnoj6CBAWBzIGE9rICyHD0vobTmXj2Pg1w14EU
         WdALYLoHxWyVVU/8kzPIaL/Z6sRIVOnhUI/Y7aDU9dA7HJ9uOPNPQb/EPdDTOST8V6kg
         v6KbF1NJCHPgAlvRKMe4UhgH2/jf/h3kT5e4VkH/TmXsWoUPz1G5iqhm+bOjHHxZBYVP
         Tk/dt4RY3+xa0qugMxuAh5RNBLaI9H0KW4X6KYzSVyJEkMlax35fzP1Kw3yPZaT6zJHM
         Byj6Aqt/JQxgPyErUNGMjzMJsBQkzEfIWEJX8C3MlpH0iccfiQNBKD/g1asJlgjlpKgX
         L15A==
X-Forwarded-Encrypted: i=1; AFNElJ/Xjmm9V3SU8ABt5CY9nl/NBe/nV9jj2zZ198Bh0ZdamyOIgm+4+HMrki2dkZiiDgQ0e+L6r1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhfpZhyIDOS8cveu3XDf3DTcbfTr3ReCh1XyEtsaZgkuBPOshV
	iPJxgMqKvNN25efS3gLadfeugYM+YRc0GqwZisj0tVy5xntXBdnOaf6jAPWiBvfIf/8=
X-Gm-Gg: AeBDieu5G625Lg+9ZKfwd6Wr1f30VwOlVevzW2mYMX8juB9FrWSYSzFrwRFMK19clBu
	psObad26/NBd6lw/x0+MJgT83/+DNYSzU7K9hJBBewa0Qm9Jba/E0RYXdt8C+cBavOZolxxMauK
	Ex/NOer4Bkh8p/KglvKgHRUvdxSlUyfeC/jz9nGpLW88f7aBLi1YPBEo3O95BCP78A/91M7fM+D
	xClskxoMHhc4YPwBPeUYo9KUfOCn00pYotlpZ3Ymz4si2ZaGTM4NoEM2eLngPMYRVUbXeNZ478W
	kXSO6djn3v6JVvquoxehfaXdm38LMXAPkp3EapPSdVjGih8SVhjJLgHwjYeJbJqBJq9PLMOaHCB
	v04WFM/vrBry8aiXPMrkDuzGeFdnaEmP1fQz8nlFBaevH5vAuT6D1Hlja3+O7tav4Fv1dEskZEX
	HU+lNN6YaPaL4X/8PMrvt96AsslCvAU1STQUe72orMgZWO5/YFwLssN942lv0Jk+ZJmheXsUbse
	gZkynRAXPkSUtEX
X-Received: by 2002:a05:6808:309a:b0:468:1574:4cc1 with SMTP id 5614622812f47-47c3d8e2531mr355934b6e.3.1777399579925;
        Tue, 28 Apr 2026 11:06:19 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:7bc4:3841:9e4c:e2ac])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-47c291be222sm1866433b6e.14.2026.04.28.11.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 11:06:19 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	Tony Camuso <tcamuso@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Corey Minyard <corey@minyard.net>,
	stable@vger.kernel.org
Subject: [PATCH v3] ipmi: Add limits to event and receive message requests
Date: Tue, 28 Apr 2026 13:00:33 -0500
Message-ID: <20260428180611.500258-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C855A48A785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241753-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,minyard.net:email,minyard.net:dkim,minyard.net:mid]

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
---
I have added this problem as a capability in the openipmi library
simulator so I can reproduce the issue and make sure everything works
properly.

 drivers/char/ipmi/ipmi_si_intf.c | 54 +++++++++++++++++++++++++-------
 drivers/char/ipmi/ipmi_ssif.c    | 23 ++++++++++++--
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 08c208cc64c5..7c3c463e08da 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -168,6 +168,10 @@ struct smi_info {
 			     OEM2_DATA_AVAIL)
 	unsigned char       msg_flags;
 
+	/* When requesting events and messages, don't do it forever. */
+	unsigned int        num_requests_in_a_row;
+	bool		    last_was_flag_fetch;
+
 	/* Does the BMC have an event buffer? */
 	bool		    has_event_buffer;
 
@@ -410,7 +414,10 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->si_state = SI_GETTING_MESSAGES;
+	if (smi_info->si_state != SI_GETTING_MESSAGES) {
+		smi_info->num_requests_in_a_row = 0;
+		smi_info->si_state = SI_GETTING_MESSAGES;
+	}
 }
 
 static void start_getting_events(struct smi_info *smi_info)
@@ -421,7 +428,10 @@ static void start_getting_events(struct smi_info *smi_info)
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
-	smi_info->si_state = SI_GETTING_EVENTS;
+	if (smi_info->si_state != SI_GETTING_EVENTS) {
+		smi_info->num_requests_in_a_row = 0;
+		smi_info->si_state = SI_GETTING_EVENTS;
+	}
 }
 
 /*
@@ -595,6 +605,7 @@ static void handle_transaction_done(struct smi_info *smi_info)
 			smi_info->si_state = SI_NORMAL;
 		} else {
 			smi_info->msg_flags = msg[3];
+			smi_info->last_was_flag_fetch = true;
 			handle_flags(smi_info);
 		}
 		break;
@@ -646,6 +657,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
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
@@ -684,6 +700,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
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
@@ -825,6 +846,26 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
 		goto out;
 	}
 
+	/*
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
 	/*
 	 * We prefer handling attn over new messages.  But don't do
 	 * this if there is not yet an upper layer to handle anything.
@@ -852,15 +893,6 @@ static enum si_sm_result smi_event_handler(struct smi_info *smi_info,
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
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index b49500a1bd36..f3798f4e6a63 100644
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
@@ -413,7 +416,10 @@ static void start_event_fetch(struct ssif_info *ssif_info, unsigned long *flags)
 	}
 
 	ssif_info->curr_msg = msg;
-	ssif_info->ssif_state = SSIF_GETTING_EVENTS;
+	if (ssif_info->ssif_state != SSIF_GETTING_EVENTS) {
+		ssif_info->num_requests_in_a_row = 0;
+		ssif_info->ssif_state = SSIF_GETTING_EVENTS;
+	}
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
 	msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -436,7 +442,10 @@ static void start_recv_msg_fetch(struct ssif_info *ssif_info,
 	}
 
 	ssif_info->curr_msg = msg;
-	ssif_info->ssif_state = SSIF_GETTING_MESSAGES;
+	if (ssif_info->ssif_state != SSIF_GETTING_MESSAGES) {
+		ssif_info->num_requests_in_a_row = 0;
+		ssif_info->ssif_state = SSIF_GETTING_MESSAGES;
+	}
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
 	msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -843,6 +852,11 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
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
@@ -876,6 +890,11 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
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
-- 
2.43.0


