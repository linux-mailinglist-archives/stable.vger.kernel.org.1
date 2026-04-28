Return-Path: <stable+bounces-241638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RhlVLtuh8GlAWgEAu9opvQ
	(envelope-from <stable+bounces-241638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:02:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E32484793
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FDB30CD5AE
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0A3ACA5B;
	Tue, 28 Apr 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="fWwNc6eQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE23B19B9
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376724; cv=none; b=ENJpsIkVM7TJNqp5KO7oM7D1Btll/OHClxD8QRpBplCPcIxBQjyost0NJqSpfgBIObKC0zme21h30o6DC4rWnhTNaoVTbIf8bT6i5qu58/A2aYCV5/dMWHbcdjSf/zgTj9FxiYVW2nca/R7cbq5SqQalE1nxYoI4RR9nkKvJU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376724; c=relaxed/simple;
	bh=12HhzKjY37nXpEUIlxxcx7/wzC9CcCcO+35cMA792fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs9tr31yoZ2hJgq68oEkmi3r40AzeCrWlyEF/gvwkY9Vyv6C27zHpob0e5/L8Cf/LmqubU1VMRxqS6BE0sH3Xnhz5aN52lWKbBi3XaGiQ+MKtBvAkNIyyOPWX7pt4u0LbPYGJ3lcfR7Xr5oQZQZPt0dPMDKMyWXuh54tP1f4hEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=fWwNc6eQ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dcd17e19b6so4697040a34.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777376721; x=1777981521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGegJh+XMiVUnAu14oQ8XqrjJ1magSoqSyK79ZedG1c=;
        b=fWwNc6eQbTGaYWQ4E4bhKqL/W2ubIpmd4Nl5U6UTg71DuMKIkt9tE1wPCuwRrY0Iau
         ZhfONSKo7Lalr6aRFhmy+ea205LGPFOVpL9Bi94qJHcOuoepAT4zJ+gCsR5r/7qlBeSa
         ZJRKs5g5/nkDQ+3OMRW0ng9VAikRWreoPwOrQ9ZbcDHxQJvXKXZbf5UjHCWz7Xxugp8O
         aTc+ruoCEA+PKFcP+SXGPBmatKE/NSm3YtW11CNC52tPrJkrBOI2Bd+Jhq/DqILNLe8Q
         v/sycHQBYj+FYWbAb+Ee3mWkH3iszyRVBsWcl83dMMheQx3nf7Nu0WkuY8Twtn2p1wL5
         vARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376721; x=1777981521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGegJh+XMiVUnAu14oQ8XqrjJ1magSoqSyK79ZedG1c=;
        b=Rodz2IZlH0jLTWOqgPTKGpaX8lXK9jjKE5xcJuknWE4u75mZkDCR7afbE1SPMkdyGF
         SsnOZ7VJeq4kCd2FMQwnIwuADvrTNdKX4nZoJWlEpt/eaO5qVc48GlYUJ6MAw/p90O4Y
         SDe58VkiUw+6d+qegSzrXhk3Hh8HYKOKbNU9+oQpT1QJZ1C2a9bWKppbCyzpgoIs41c+
         Gz+e/FYRy6xdLRHEUTO+ANw4PES3AwlBuj2DyMHIOXcwqTDlq7YWIY0Z1gfd5TPAVsiq
         86Nyl60Y9/agN3NlP9rItHZL4gGb2PLhh0qn67k8lIhoY18qhyQIRFaDNymW+QA5Yhwg
         NY1w==
X-Forwarded-Encrypted: i=1; AFNElJ8q5lGT8qPqjKFo4/+o8St6OmWNhYE6ObBFCIxk3b7SN+y/CVLFHCc7xXP1ov6QZfoVMD+qZ6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgyWM4rNYAc0Yt3HfP03rPrYbkUcDP43J/Fu24U1dxNGmJFP/
	AE28a6jZB6vuuLMbqw0LygjX7+Oi33dkPvbd90d9TlceLW7g5jJc+qKgCR9q8FrC2aQ=
X-Gm-Gg: AeBDiet3SzwQrlxWVPxVEvA3bKL6Bj0+WVACjuCP9GDkQcGPOaOekp5NbrcQ8EY9FB+
	6LZI5WfDg8htYy0S/UKih+oCxoPGnuXgVnKi3lp37d8M9e+mYa/cLuzSnWj+0D3zLcmE+NI8PfW
	druKTn02GTMJmm5sY5tXPPC3ioVVlmBMs7k4gwtVgwpY30eTUGf7VEXlNdxrbZzEjD6PR/chRsL
	5Y5UDK25vMkgmaDJ1ke6JOx8ZIrVX0t3Tq3Fb70TQy0KaQ+v/1qJFy+XJFl8VD0C0XKoENnUTn5
	ihDM3gLbk6nmtSbihXY9z7HdIvgKyxpiaU085+elN+L/gko62V57DuR/zxATYbL+RmttCExf7Lt
	mBhWsLYZKa/XRlKPMlquWGtcaYm/zrFzAZn0DdLYCDgG4eapb0Eo75feBzV4N5sud4xoq3KMpIk
	If+8ykC6cH9fVSpUE1TJocmohw80nx4A9UgdYDrrBZdqj8PBGTtb51H018J03ryrehrPOGtNCBk
	G0qQJXNwMgufxtAXPZKITeE0g==
X-Received: by 2002:a05:6830:448e:b0:7de:495a:cf80 with SMTP id 46e09a7af769-7de9a0b6c8fmr1619131a34.16.1777376721043;
        Tue, 28 Apr 2026 04:45:21 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:689e:6348:f71f:894a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de984f63casm1682000a34.9.2026.04.28.04.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:45:20 -0700 (PDT)
Date: Tue, 28 Apr 2026 06:45:15 -0500
From: Corey Minyard <corey@minyard.net>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Matt Fleming <mfleming@cloudflare.com>,
	openipmi-developer@lists.sourceforge.net,
	Tony Camuso <tcamuso@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ipmi: Add limits to event and receive message
 requests
Message-ID: <afCdy0Nu8glFCzqk@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260421132544.2666174-1-corey@minyard.net>
 <20260421132544.2666174-3-corey@minyard.net>
 <aeyJ0fClAWI2lBwL@matt-Precision-5490>
 <ae1VOEhdR0H0rf0a@mail.minyard.net>
 <afCHrNN-PuXh1WzG@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afCHrNN-PuXh1WzG@matt-Precision-5490>
X-Rspamd-Queue-Id: 82E32484793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241638-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:server fail];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:dkim,minyard.net:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.minyard.net:mid]

On Tue, Apr 28, 2026 at 11:15:46AM +0100, Matt Fleming wrote:
> On Sat, Apr 25, 2026 at 06:58:48PM -0500, Corey Minyard wrote:
> > 
> > Oh, yeah.
> > 
> > Moving it to handle_transaction_done() is not ideal, though.  If
> > something was spewing receive messages, it would never get to events,
> > which is why I did it like I did.
> > 
> > The following should fix this.  You could also have different limits for
> > receive messages and events, but I think the following is more clear.
> > 
> > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > index 2a739123270c..e46f4150ceb5 100644
> > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > @@ -413,8 +413,10 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
> > 
> >  	start_new_msg(smi_info, smi_info->curr_msg->data,
> >  		      smi_info->curr_msg->data_size);
> > -	smi_info->num_requests_in_a_row = 0;
> > -	smi_info->si_state = SI_GETTING_MESSAGES;
> > +	if (smi_info->si_state != SI_GETTING_MESSAGES) {
> > +	    smi_info->num_requests_in_a_row = 0;
> > +	    smi_info->si_state = SI_GETTING_MESSAGES;
> > +	}
> >  }
> > 
> >  static void start_getting_events(struct smi_info *smi_info)
> > @@ -425,8 +427,10 @@ static void start_getting_events(struct smi_info *smi_info)
> > 
> >  	start_new_msg(smi_info, smi_info->curr_msg->data,
> >  		      smi_info->curr_msg->data_size);
> > -	smi_info->num_requests_in_a_row = 0;
> > -	smi_info->si_state = SI_GETTING_EVENTS;
> > +	if (smi_info->si_state != SI_GETTING_EVENTS) {
> > +	    smi_info->num_requests_in_a_row = 0;
> > +	    smi_info->si_state = SI_GETTING_EVENTS;
> > +	}
> 
> Thanks. Does this correctly handle a stream of mixed receive+event
> flags, though? If we bounce between MESSAGES and EVENTS, won't we keep
> resetting the counter on each state transition and never hit the limit?

It should.  Once the limit is reached it clears the bit in msg_flags.
That should prevent the messages or events from being re-requested
until the next flags fetch.  So if a continuous stream of messages
and events was coming in, it should fetch 10 messages, clear the bit,
then fetch 10 events, then clear that bit, then go back to normal
operation.

Of course, the next flag fetch will start the process over.

> 
> I was able to cook up a simple repro in Qemu for this class of bug.

I was thinking about how to do an automated test for this.  I use an
external simulated BMC for the automated tests I have.  So I'll work in
that direction.

But thanks, this should help me develop that test.

-corey

> 
> ---->8----
> 
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index fd875491f5..127db30c03 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -249,6 +249,21 @@ struct IPMIBmcSim {
>      uint8_t evtbuf[16];
>  
>      QTAILQ_HEAD(, IPMIRcvBufEntry) rcvbufs;
> +
> +    /*
> +     * Fault injection: sticky EVENT_MSG_BUFFER_FULL.
> +     *
> +     * Simulates a BMC that continuously generates events (e.g. after a
> +     * cold reset causes sensor state changes).  Once armed, every
> +     * READ_EVENT_MSG_BUFFER returns success but never clears the
> +     * EVT_BUF_FULL flag, starving waiting_msg in the SI layer's
> +     * handle_flags() loop.  Reproduces the 517m277 / KRN-1233 wedge.
> +     */
> +    bool     fi_sticky_events;   /* enable via property */
> +    uint32_t fi_evt_arm_after;   /* arm after N completed responses */
> +    uint32_t fi_evt_rsp_count;   /* responses completed so far */
> +    bool     fi_evt_armed;       /* fault is active */
> +    uint32_t fi_evt_read_count;  /* READ_EVENT_MSG_BUFFER calls served */
>  };
>  
>  #define IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK        (1 << 3)
> @@ -494,7 +509,7 @@ static int sel_add_event(IPMIBmcSim *ibs, uint8_t *event)
>  static int attn_set(IPMIBmcSim *ibs)
>  {
>      return IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(ibs)
> -        || IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs)
> +        || (!ibs->fi_evt_armed && IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs))
>          || IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK_SET(ibs);
>  }
>  
> @@ -750,6 +765,48 @@ static void ipmi_sim_handle_command(IPMIBmc *b,
>   out:
>      k->handle_rsp(s, msg_id, rsp.buffer, rsp.len);
>  
> +    /*
> +     * Fault injection: count completed responses and arm sticky
> +     * EVENT_MSG_BUFFER_FULL after the configured threshold.
> +     */
> +    if (ibs->fi_sticky_events && !ibs->fi_evt_armed) {
> +        ibs->fi_evt_rsp_count++;
> +        if (ibs->fi_evt_rsp_count >= ibs->fi_evt_arm_after) {
> +            ibs->fi_evt_armed = true;
> +            ibs->fi_evt_read_count = 0;
> +
> +            /*
> +             * Seed the event buffer with a synthetic sensor event
> +             * (sensor type 0x01 = Temperature, event type 0x01 =
> +             * threshold, evd1 = upper critical going high).
> +             * This matches what real BMCs generate after a cold reset.
> +             */
> +            memset(ibs->evtbuf, 0, 16);
> +            ibs->evtbuf[2]  = 0x02; /* System event record */
> +            ibs->evtbuf[7]  = ibs->parent.slave_addr;
> +            ibs->evtbuf[9]  = 0x04; /* Format version */
> +            ibs->evtbuf[10] = 0x01; /* Sensor type: Temperature */
> +            ibs->evtbuf[11] = 0x01; /* Sensor number */
> +            ibs->evtbuf[12] = 0x01; /* Event type: threshold */
> +            ibs->evtbuf[13] = 0x09; /* Upper critical going high */
> +            ibs->evtbuf[14] = 0x57; /* Threshold value */
> +            ibs->evtbuf[15] = 0x00; /* Sequence (incremented on reads) */
> +
> +            ibs->msg_flags |= IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> +
> +            /* Ensure event message buffer is enabled in global enables
> +             * so the kernel sees it.  Also enable event logging.
> +             */
> +            ibs->bmc_global_enables |= (1 << IPMI_BMC_EVENT_MSG_BUF_BIT)
> +                                     | (1 << IPMI_BMC_EVENT_LOG_BIT);
> +
> +            k->set_atn(s, 1, attn_irq_enabled(ibs));
> +
> +            fprintf(stderr, "[FI] sticky-events armed after %u responses\n",
> +                    ibs->fi_evt_rsp_count);
> +        }
> +    }
> +
>      next_timeout(ibs);
>  }
>  
> @@ -1013,8 +1070,14 @@ static void clr_msg_flags(IPMIBmcSim *ibs,
>  {
>      IPMIInterface *s = ibs->parent.intf;
>      IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
> +    uint8_t clear_mask = cmd[2];
> +
> +    if (ibs->fi_evt_armed) {
> +        /* Don't allow clearing EVT_BUF_FULL when sticky events active */
> +        clear_mask &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> +    }
>  
> -    ibs->msg_flags &= ~cmd[2];
> +    ibs->msg_flags &= ~clear_mask;
>      k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
>  }
>  
> @@ -1040,7 +1103,19 @@ static void read_evt_msg_buf(IPMIBmcSim *ibs,
>      for (i = 0; i < 16; i++) {
>          rsp_buffer_push(rsp, ibs->evtbuf[i]);
>      }
> -    ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> +
> +    if (ibs->fi_evt_armed) {
> +        /*
> +         * Sticky mode: return success but keep EVT_BUF_FULL set.
> +         * Vary the event data slightly so the kernel doesn't
> +         * de-duplicate (increment evd3 as a sequence number).
> +         */
> +        ibs->fi_evt_read_count++;
> +        ibs->evtbuf[15] = (uint8_t)(ibs->fi_evt_read_count & 0xff);
> +        /* Don't clear the flag — starvation continues */
> +    } else {
> +        ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> +    }
>      k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
>  }
>  
> @@ -2670,6 +2745,8 @@ static const Property ipmi_sim_properties[] = {
>      DEFINE_PROP_STRING("lan.netmask", IPMIBmcSim, lan.arg_netmask),
>      DEFINE_PROP_STRING("lan.defgw_ipaddr", IPMIBmcSim, lan.arg_defgw_ipaddr),
>      DEFINE_PROP_MACADDR("lan.defgw_macaddr", IPMIBmcSim, lan.defgw_macaddr),
> +    DEFINE_PROP_BOOL("fi_sticky_events", IPMIBmcSim, fi_sticky_events, false),
> +    DEFINE_PROP_UINT32("fi_evt_arm_after", IPMIBmcSim, fi_evt_arm_after, 40),
>  };
>  
>  static void ipmi_sim_class_init(ObjectClass *oc, const void *data)

