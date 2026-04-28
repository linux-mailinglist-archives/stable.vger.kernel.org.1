Return-Path: <stable+bounces-241535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCNCB9SL8GkRUwEAu9opvQ
	(envelope-from <stable+bounces-241535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:28:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 214274829AF
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 351F930232A3
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFEE3E5595;
	Tue, 28 Apr 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="YPLnRlik"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAD3E4C67
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371352; cv=none; b=NUdRC0gi5rowBk4AJ2iFxYK0x0c/Vq6X1xO7coSpw5GJumQxqA7hjknL9gXKJQPpdhYLf9OyZVze1LoloP0DMwFPFr3TERF0KApl1QwcZp6rCYTtyDJT4w1bg3a7oCri/EjwlUx4FDlcAKHtJvK5i86d1ZCbySPv54H4+heFKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371352; c=relaxed/simple;
	bh=zydmw6DUZrNYzeh+JTKW2C9SdtEgri3M2H/IsXluHsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi5klbS6pf1AWjEbqQjaVvgii8sSNf+9NMgQL21qi5zcuFbTaeIiCKeRoYpHtPui7ZEHnphdyS+qVXrl4ob3lO+9Z20PGl7euMWmszaR1upeAc9yGIsuLnXQFH35IvKc6/YsByIUbQUqAx7Z+0cX7iHiIbSCRt2wJZB7It81180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=YPLnRlik; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d75312379so8003741f8f.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1777371349; x=1777976149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z7RTu/SVjmIpKmqqy5JfYwWyiAqxOUNJf6elqbre8rs=;
        b=YPLnRlikJ+xQSppq/b/+11r0mso4vBRJmxp8HFVJ46GiCcPZSH0aZA+yTdB70koRSM
         3rwhERJOuCbJraFLwVnVlvwC/zudH4ACF1QJ+aBdORqg+D6XB4IqkNPw8D3O21ZxvmN2
         XHTECoriw3dBDJQEGt+tQ7XO3IU5pkGUm9TD72+Fzi71NCkwGcxl4EQJY5SgppeyR2PV
         dt7O46sy9knXeHvUyq2HeyZpUpoIe4kPCoxybeiJtH2V6SrgDnxwdZdz3nxSkynC9da3
         gklvUhdbDra2w//6TvounFnyn1qy/dpATx7+HudTY2GzqJP7IcX6F2MQ54ljEQVmzRs3
         gjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777371349; x=1777976149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7RTu/SVjmIpKmqqy5JfYwWyiAqxOUNJf6elqbre8rs=;
        b=dhg2wJ3Mju7Jos+khsY9x0Y7pLlxW3xcwy2NqOE35qQ+MvIkQxEuhjW8IubSmAuhVU
         5YHhmNCRpmJbV327S7iDgTtR997ySvTEOdc4fnr6Dhf2db2bkIF+1vZmrfzAhvH0Sw6U
         TrcsjHDsDViM4W4cO+tEf65VAQIpWFXa5DG9LiAxZSpOzRJE3s9hsWp7tC1TjSZQjsHJ
         ZosCvxhzABjgs28glRLIB8pdpNX3RYUhOs9fqVR9rz2iipyS22rJj5vIPdSpjM73sqI5
         Oic3Qr1wPggLEu3LIyqcfeqyjtvGqvQ1JAuitvTf9g5/du4Uh2Dy4GgZEMoBDL/vvcAA
         hrbg==
X-Forwarded-Encrypted: i=1; AFNElJ+1xG2RBlUTLvBup3BFIlgFjSCDlJFTBUsPG/a9veTbBeb5T7k3Z6ShF//RjPGUnkXmq7xZjaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq1P/6xdkUYaJ69t2+I70k/Tazo5CFMn7uCHOXmMjuuDv87HT
	l7VJrKDRzY+bU5CGPo7zPS1e6XDfFXHK2BZiaE84WlYSvulz1O6JVWLuv/nq46gk4tQ=
X-Gm-Gg: AeBDievRydiDW80LLEXAgoINj+Pre38TTFALF20hWKBGxdGJhlvj+y6iFQqABB3sMjq
	eYHTWbP/ofQoPyM6BbsdSFksqJkfc/ER7w3v0ZZvWo7KeJHnAd4LRXzN5hZekG1thgBncUuSP3X
	wgHxGin7jTN4T/POdQdSlEbxyUmkkerOyXacYX/E0P2ysZLvk4fR9nTBzxO3x72itJlExRXpAKh
	YL3GsxnGefxLR79OYeP77WjefEImjC/bCiR+p98WjsRpJ+X8XB+5DeyJVISPRrZOtTdtzmjoPkC
	dJehj/uE/fk+uVg+VlQgDhhFb6EMDHuw1Co9vWKQc+QS1wBSW7bOxwL85LtaYLHmDpOKzIY5hdV
	iXkz7uwOG356GU22O/yD3rf48CmRuZW0UE7r+rt3HnQLrMMajP/j84sgxLRWE4p4SMlUHBfFMQj
	8mvX8Jj7VqLxmaRY8zKwTx
X-Received: by 2002:a05:600c:3ba6:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-48a78a43734mr29828535e9.11.1777371348572;
        Tue, 28 Apr 2026 03:15:48 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:ebe::178:1c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773b9b5dsm50309915e9.7.2026.04.28.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 03:15:47 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:15:46 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Corey Minyard <corey@minyard.net>
Cc: Matt Fleming <mfleming@cloudflare.com>, 
	openipmi-developer@lists.sourceforge.net, Tony Camuso <tcamuso@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ipmi: Add limits to event and receive message
 requests
Message-ID: <afCHrNN-PuXh1WzG@matt-Precision-5490>
References: <20260421132544.2666174-1-corey@minyard.net>
 <20260421132544.2666174-3-corey@minyard.net>
 <aeyJ0fClAWI2lBwL@matt-Precision-5490>
 <ae1VOEhdR0H0rf0a@mail.minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae1VOEhdR0H0rf0a@mail.minyard.net>
X-Rspamd-Queue-Id: 214274829AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241535-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,readmodwrite-com.20251104.gappssmtp.com:dkim]

On Sat, Apr 25, 2026 at 06:58:48PM -0500, Corey Minyard wrote:
> 
> Oh, yeah.
> 
> Moving it to handle_transaction_done() is not ideal, though.  If
> something was spewing receive messages, it would never get to events,
> which is why I did it like I did.
> 
> The following should fix this.  You could also have different limits for
> receive messages and events, but I think the following is more clear.
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 2a739123270c..e46f4150ceb5 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -413,8 +413,10 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
> 
>  	start_new_msg(smi_info, smi_info->curr_msg->data,
>  		      smi_info->curr_msg->data_size);
> -	smi_info->num_requests_in_a_row = 0;
> -	smi_info->si_state = SI_GETTING_MESSAGES;
> +	if (smi_info->si_state != SI_GETTING_MESSAGES) {
> +	    smi_info->num_requests_in_a_row = 0;
> +	    smi_info->si_state = SI_GETTING_MESSAGES;
> +	}
>  }
> 
>  static void start_getting_events(struct smi_info *smi_info)
> @@ -425,8 +427,10 @@ static void start_getting_events(struct smi_info *smi_info)
> 
>  	start_new_msg(smi_info, smi_info->curr_msg->data,
>  		      smi_info->curr_msg->data_size);
> -	smi_info->num_requests_in_a_row = 0;
> -	smi_info->si_state = SI_GETTING_EVENTS;
> +	if (smi_info->si_state != SI_GETTING_EVENTS) {
> +	    smi_info->num_requests_in_a_row = 0;
> +	    smi_info->si_state = SI_GETTING_EVENTS;
> +	}

Thanks. Does this correctly handle a stream of mixed receive+event
flags, though? If we bounce between MESSAGES and EVENTS, won't we keep
resetting the counter on each state transition and never hit the limit?

I was able to cook up a simple repro in Qemu for this class of bug.

---->8----

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index fd875491f5..127db30c03 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -249,6 +249,21 @@ struct IPMIBmcSim {
     uint8_t evtbuf[16];
 
     QTAILQ_HEAD(, IPMIRcvBufEntry) rcvbufs;
+
+    /*
+     * Fault injection: sticky EVENT_MSG_BUFFER_FULL.
+     *
+     * Simulates a BMC that continuously generates events (e.g. after a
+     * cold reset causes sensor state changes).  Once armed, every
+     * READ_EVENT_MSG_BUFFER returns success but never clears the
+     * EVT_BUF_FULL flag, starving waiting_msg in the SI layer's
+     * handle_flags() loop.  Reproduces the 517m277 / KRN-1233 wedge.
+     */
+    bool     fi_sticky_events;   /* enable via property */
+    uint32_t fi_evt_arm_after;   /* arm after N completed responses */
+    uint32_t fi_evt_rsp_count;   /* responses completed so far */
+    bool     fi_evt_armed;       /* fault is active */
+    uint32_t fi_evt_read_count;  /* READ_EVENT_MSG_BUFFER calls served */
 };
 
 #define IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK        (1 << 3)
@@ -494,7 +509,7 @@ static int sel_add_event(IPMIBmcSim *ibs, uint8_t *event)
 static int attn_set(IPMIBmcSim *ibs)
 {
     return IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(ibs)
-        || IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs)
+        || (!ibs->fi_evt_armed && IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs))
         || IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK_SET(ibs);
 }
 
@@ -750,6 +765,48 @@ static void ipmi_sim_handle_command(IPMIBmc *b,
  out:
     k->handle_rsp(s, msg_id, rsp.buffer, rsp.len);
 
+    /*
+     * Fault injection: count completed responses and arm sticky
+     * EVENT_MSG_BUFFER_FULL after the configured threshold.
+     */
+    if (ibs->fi_sticky_events && !ibs->fi_evt_armed) {
+        ibs->fi_evt_rsp_count++;
+        if (ibs->fi_evt_rsp_count >= ibs->fi_evt_arm_after) {
+            ibs->fi_evt_armed = true;
+            ibs->fi_evt_read_count = 0;
+
+            /*
+             * Seed the event buffer with a synthetic sensor event
+             * (sensor type 0x01 = Temperature, event type 0x01 =
+             * threshold, evd1 = upper critical going high).
+             * This matches what real BMCs generate after a cold reset.
+             */
+            memset(ibs->evtbuf, 0, 16);
+            ibs->evtbuf[2]  = 0x02; /* System event record */
+            ibs->evtbuf[7]  = ibs->parent.slave_addr;
+            ibs->evtbuf[9]  = 0x04; /* Format version */
+            ibs->evtbuf[10] = 0x01; /* Sensor type: Temperature */
+            ibs->evtbuf[11] = 0x01; /* Sensor number */
+            ibs->evtbuf[12] = 0x01; /* Event type: threshold */
+            ibs->evtbuf[13] = 0x09; /* Upper critical going high */
+            ibs->evtbuf[14] = 0x57; /* Threshold value */
+            ibs->evtbuf[15] = 0x00; /* Sequence (incremented on reads) */
+
+            ibs->msg_flags |= IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
+
+            /* Ensure event message buffer is enabled in global enables
+             * so the kernel sees it.  Also enable event logging.
+             */
+            ibs->bmc_global_enables |= (1 << IPMI_BMC_EVENT_MSG_BUF_BIT)
+                                     | (1 << IPMI_BMC_EVENT_LOG_BIT);
+
+            k->set_atn(s, 1, attn_irq_enabled(ibs));
+
+            fprintf(stderr, "[FI] sticky-events armed after %u responses\n",
+                    ibs->fi_evt_rsp_count);
+        }
+    }
+
     next_timeout(ibs);
 }
 
@@ -1013,8 +1070,14 @@ static void clr_msg_flags(IPMIBmcSim *ibs,
 {
     IPMIInterface *s = ibs->parent.intf;
     IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    uint8_t clear_mask = cmd[2];
+
+    if (ibs->fi_evt_armed) {
+        /* Don't allow clearing EVT_BUF_FULL when sticky events active */
+        clear_mask &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
+    }
 
-    ibs->msg_flags &= ~cmd[2];
+    ibs->msg_flags &= ~clear_mask;
     k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
 }
 
@@ -1040,7 +1103,19 @@ static void read_evt_msg_buf(IPMIBmcSim *ibs,
     for (i = 0; i < 16; i++) {
         rsp_buffer_push(rsp, ibs->evtbuf[i]);
     }
-    ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
+
+    if (ibs->fi_evt_armed) {
+        /*
+         * Sticky mode: return success but keep EVT_BUF_FULL set.
+         * Vary the event data slightly so the kernel doesn't
+         * de-duplicate (increment evd3 as a sequence number).
+         */
+        ibs->fi_evt_read_count++;
+        ibs->evtbuf[15] = (uint8_t)(ibs->fi_evt_read_count & 0xff);
+        /* Don't clear the flag — starvation continues */
+    } else {
+        ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
+    }
     k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
 }
 
@@ -2670,6 +2745,8 @@ static const Property ipmi_sim_properties[] = {
     DEFINE_PROP_STRING("lan.netmask", IPMIBmcSim, lan.arg_netmask),
     DEFINE_PROP_STRING("lan.defgw_ipaddr", IPMIBmcSim, lan.arg_defgw_ipaddr),
     DEFINE_PROP_MACADDR("lan.defgw_macaddr", IPMIBmcSim, lan.defgw_macaddr),
+    DEFINE_PROP_BOOL("fi_sticky_events", IPMIBmcSim, fi_sticky_events, false),
+    DEFINE_PROP_UINT32("fi_evt_arm_after", IPMIBmcSim, fi_evt_arm_after, 40),
 };
 
 static void ipmi_sim_class_init(ObjectClass *oc, const void *data)

