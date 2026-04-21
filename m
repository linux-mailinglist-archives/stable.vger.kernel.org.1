Return-Path: <stable+bounces-240161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOO6MwJ752mZ9QEAu9opvQ
	(envelope-from <stable+bounces-240161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:26:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D106143B505
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D663300FECE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215403D75C0;
	Tue, 21 Apr 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="Sj8RV/tE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE43D6CCA
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777955; cv=none; b=MdAUTr0cA8mU2edJo0CTjAUUffr0dkesfsndio5U3Naar4k9OFHhKYIHcV1csw+T1znVLcZWgRl963S51ePSPtEq1eKWpc/Bc2JDeSO6VTZWZV1UFTCEQdoUI30vqpCOdfubq9tjY2c6femA+N78Vvspw3FOcs+0WEuSz+QBLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777955; c=relaxed/simple;
	bh=eQD26XzpLoSwe75J+uS061hjUdY3yx0RdEz2pW3zXbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMeqr5fg3QWmI25Y22/WOvuSYbO5AITVp3/ekvXVs04E1/vqdg3Twx4yBfPWfdGx0nQO8NejwRkrRwGosmQhUUlVLkvo3vi/idZwn0GovWzea6ZdDV7Y7c83w8qxqa6k13W2AsQpUmbtszDe3UUetFzuou1dzcswe/pXmdo7kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=Sj8RV/tE; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcd8ef572aso379980a34.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1776777953; x=1777382753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v32D4Ihg8m4TlUZ9/Ylii2aIdih85JiynNfKmLVnqEM=;
        b=Sj8RV/tEMQqWtNv1z5lpZ7j5b6pJoLAnZof/vkHsPmnjJhlHCZZsDmO0csDOhFJVmk
         13p5yCJU+0gdv5XfTW7oYUeiGndaJGNR0ZJYrfnOV7lz7/EqicucqZAyCZjmo+e+3PS4
         fwvogSCheEZ2nelg1s5UBSrxpSF8ZfgqbvUfPsUvyCY6B8XdzHsoT3J2RljZeqRhk6oZ
         t0CzruYnYuycQmY1KBX32KokBu26uYQaYNjU2cZ2QYduvzlmIA9sIZemKAf3p+vLX4OR
         fd1guFaAZt2wZH9kBJyuKKL5J1OVn0RrJDaE/XnggjEtcQ/qBfcg/Bka1NDG/TclFIbC
         y57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776777953; x=1777382753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v32D4Ihg8m4TlUZ9/Ylii2aIdih85JiynNfKmLVnqEM=;
        b=k/Mdh1ZvXMLUT4UVG1FegGkH2qfWP1MjzB6zsFTmAwMJVfhkSO2hgGRk0Nny38tQW/
         d2CtWc0GQD8JCorZNypd3D4yH/OzxQ9o1bmW+dLp8gCFDVh0ak7h3H6LdM6mCEMod1uX
         ZDBY/MQd1HR/u9QfiBfaTl3zykMuyrnDcy6casqEdO0D1g4nPSux5YOVbsYgamWss/RB
         qOlSQ6zYWn+VqdaKpKG9mCZvNW97lESuka1mjbvNlG/7vLhU96JWt/nMvwldOjNdyY8j
         4RyHK94JNXlcy7Zgdn0+5jS4LWgAhtVczh5MjiJbjbM1U9NLszCXvlsiNREHkvTEzYje
         qeNA==
X-Forwarded-Encrypted: i=1; AFNElJ/TLkB/ikBmqgNfw0Mkbq3aEFjH+dVGXPXM93UK1btMlRN9oZvAD6opkbq+RhHGUBAmIUG4P1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTaKUbop4GGh+hJOqW3FRy8TdQZFa4rmJ0a2KNxQrcH8w7FyV
	Dhx1HZPTQZbAlqf4qBgE+6oF2xAdMk7Hjy14A/z0Cp6k7OUtmrQnJZrQD3k9QHTODac=
X-Gm-Gg: AeBDievkR+0tqcDsd466UeDttVWWXQANoRU7bGOYED89RHeGuhLyPUw0agn2Dp10fOS
	SZodqa7SKGoYUb6QIVIGsj5IfQxSgmeeGCexEiwSnk2w61kNQXlUbXV2GTGw0fZqz72ZlttRoMN
	7/9XvS/pvR35sJFSTdbAH1H21TZ0SpxlBslt5vFL1t/1rL4zX5+HR3XfxPDdCFx0b1wxxlRsV2j
	cKD+9NHovxSnIJgo6p0fovx0Gx1o5CpB2UDP++6YL2j7cqXqoTtOi5MjVR65C32GZkF26J5Jv3Y
	dsSSB0PAdxGl7+FBR16f1UUa6e5h0t7baZdulN3ivWTA3mp0RgSeUP5wFXwph8lXP9u+ZuxbAYC
	QB4OKhwwogmZ9mLB9+oOHk7pFVBiwX/R6ld+SGnSYBbWSnJswaM/eWAaFGUkQaFliC7B7KKJ1Nm
	6T/9Noy/HweziTZ0sqgthIN5MngyXqLty0joypQBPlylqhI5elm9Q5Ces8i8l4n9Ov5w10JsAm5
	Yvnqbr3KdTeSlCF
X-Received: by 2002:a05:6830:82ae:b0:7dc:cbaa:d730 with SMTP id 46e09a7af769-7dccbaaf733mr4263878a34.8.1776777953394;
        Tue, 21 Apr 2026 06:25:53 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:376f:c507:59cb:4749])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7dcd9a0847esm1641699a34.17.2026.04.21.06.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 06:25:52 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	Tony Camuso <tcamuso@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Corey Minyard <corey@minyard.net>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ipmi: Add limits to event and receive message requests
Date: Tue, 21 Apr 2026 07:42:44 -0500
Message-ID: <20260421132544.2666174-3-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421132544.2666174-1-corey@minyard.net>
References: <20260421132544.2666174-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240161-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[minyard.net:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:email,minyard.net:email,minyard.net:dkim,minyard.net:mid]
X-Rspamd-Queue-Id: D106143B505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver would just fetch events and receive messages until the
BMC said it was done.  To avoid issues with BMCs that never say they are
done, add a limit of 10 fetches at a time.

This is a more general fix than the previous fix for the specific bad
BMC, but should fix the more general issue of a BMC that won't stop
saying it has data.

This has been there from the beginning of the driver.

Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/lkml/20260415115930.3428942-1-matt@readmodwrite.com/
Fixes: <1da177e4c3f4> ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_si_intf.c | 15 +++++++++++++++
 drivers/char/ipmi/ipmi_ssif.c    | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 08c208cc64c5..a705aae29867 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -168,6 +168,9 @@ struct smi_info {
 			     OEM2_DATA_AVAIL)
 	unsigned char       msg_flags;
 
+	/* When requesting events and messages, don't do it forever. */
+	unsigned int        num_requests_in_a_row;
+
 	/* Does the BMC have an event buffer? */
 	bool		    has_event_buffer;
 
@@ -410,6 +413,7 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
+	smi_info->num_requests_in_a_row = 0;
 	smi_info->si_state = SI_GETTING_MESSAGES;
 }
 
@@ -421,6 +425,7 @@ static void start_getting_events(struct smi_info *smi_info)
 
 	start_new_msg(smi_info, smi_info->curr_msg->data,
 		      smi_info->curr_msg->data_size);
+	smi_info->num_requests_in_a_row = 0;
 	smi_info->si_state = SI_GETTING_EVENTS;
 }
 
@@ -646,6 +651,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
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
@@ -684,6 +694,11 @@ static void handle_transaction_done(struct smi_info *smi_info)
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
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index b49500a1bd36..547447f304ba 100644
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
@@ -413,6 +416,7 @@ static void start_event_fetch(struct ssif_info *ssif_info, unsigned long *flags)
 	}
 
 	ssif_info->curr_msg = msg;
+	ssif_info->num_requests_in_a_row = 0;
 	ssif_info->ssif_state = SSIF_GETTING_EVENTS;
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
@@ -436,6 +440,7 @@ static void start_recv_msg_fetch(struct ssif_info *ssif_info,
 	}
 
 	ssif_info->curr_msg = msg;
+	ssif_info->num_requests_in_a_row = 0;
 	ssif_info->ssif_state = SSIF_GETTING_MESSAGES;
 	ipmi_ssif_unlock_cond(ssif_info, flags);
 
@@ -843,6 +848,11 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
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
@@ -876,6 +886,11 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
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


