Return-Path: <stable+bounces-241660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK0MOJnH8GkqYgEAu9opvQ
	(envelope-from <stable+bounces-241660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:43:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B48487343
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8ED4730236E1
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F83AF65C;
	Tue, 28 Apr 2026 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="cjzfuVW/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA13B27CD
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381608; cv=none; b=U8MXxO2xV+cZoIViOP6sxwlMPzK/UB0kJSqUEwcQ302Kk8VrS8C3LxxfER7+7+m8OqS1KZoAf90U1wzhoMY6oO0iV0CpunYTnTJfHrmwzYScW2ItfVD/sadNolOMuSzpRgCEqaHLKGr5EyyQsUwt7mjxip1EYYxqDc0Olb2QjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381608; c=relaxed/simple;
	bh=ORFcg6Ls6kv7lhN6d3CaFlr88gghIN/aXrL+pZEkSK4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZIm4KEcb9X1VY2Zuz8IoQhjCBXqhnGDju+EYWwIkYt3vTqJnjszfnoBpoxogtOtB02FIR2GZ60NtdfnHmVpQ2S/2ZRUQOBwaijOeBjwhUhsLX473Xuy3vruev2Z1/Htm6AAaJMuXaR/WWLBiaZqW1kcP0rw8/toldp7ZV+E7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=cjzfuVW/; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651cfaa21e6so9866035d50.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777381605; x=1777986405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tsU5INn4bJgwh3/96W1961MQFOx5hK1YCsF02Kefwg=;
        b=cjzfuVW/jmSrG/W/YmV42xU5MZqlKYV2sl4EIfGJ7Khuh/iqikrjsz5ptiATBh/vhv
         n4M2sz2y1OrGdhdcAklYO8uTHpzncTfQnxPYopE61v/mDPFNjZwhC9PNfxMfx+enSm9s
         1H4gCAEz+zXCyX7OZUI4bZ5nYBFJLiByR9bsyCuhlP3F3Bdx7Zm487782jvmLKD4sb7o
         baHVCcrCR4LmSAHAl1sWnfZmBaa6ggYc/s6T4dVlk2qVYFKSpTWeouN3ZSfB4EjahKtt
         T23NcO8qAPRnS9SBRo6Fid/PNx8HXq+CslHDeIqJhnudHbjCrq9b37oPfcb6B3J7IpVj
         BT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381605; x=1777986405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tsU5INn4bJgwh3/96W1961MQFOx5hK1YCsF02Kefwg=;
        b=SMzRotMjDNgm/KklI6Ww1zTOarAEg3+u5FzlUCk4zmo14t37t4+3ufHUFVm25dKE1x
         eFS1VKEk6D2oslAHk1+i/bZ6yttlkJpx1wMvmP3k7ZdGE/ZRcuRMS9YbV403vYOegLkH
         DRAMZEXLE7JydYoLD8QHLKlUemje9uW0G/2nhIyfKdcEcelD9A62y5q1DcnbsymVtJS6
         YwVwtcPwYK3DM8MG2FyefzrAwh75TwUnRPZtE1S3rlfokRotSshHRe7mdxVpoMFAVT5a
         1AVilKEPMsIicus46iQmyFuWOUEMOV1mJykiuWs8fFaUdc+MQCKBB+7llXQCnNSWJRnV
         0AcA==
X-Forwarded-Encrypted: i=1; AFNElJ8pDJUewQZBqnFj5Q0Agcxg2DBDSyQeU7BKObf39+JRPx3gfDwACqM8k4vhnPO0SUkNPXY01Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6+t6dYRS3LYX8w9wkLkm/kwqQeXgw3IaotJmdR6F9OUAiDt5
	7mWOqz/DBHMk13+rORf5zoHdZ8DgZdIqv8+4e4Cv8WH+keXTA6bDvB3z3MLRIXW+QCI=
X-Gm-Gg: AeBDieusyhQK2/ku5/R79jyC7niJJ9QqgZ6w0X+jwnP2ogvIYCVd2MHrH0M84e4eAUk
	quibNPFhKylZtD0WRcD3AIaY4MJtdOM50KXygrt2PBhAiE85IxBVK7jALQuwmiXOIP3p9n3y50O
	ElrY3sl+yWqqLW0sDUmlKdK7sUlVPYa/Q5NyDg364wYk3+PXda3PwOULa9gAhoui66khszuAtQk
	ZWwCKJWqnxQztyE2nSVfSk3LKCdhoaRsqdjHwdmUI0FxrT93MyvUeGHLl86U28aWmH307EWs7hj
	Tjbz7o21BGkvJSRW39xWoNdoNiesTpjPwYNMZkx0biqlqrhoUenn7xTAtr1UyKwMeYtlVViwTpY
	4GOIu9ura6WzH50ZaRG8XijThQ0FvXukrY7dDoBJwdDWWER5m7y9zexkoQFMxfGiMZyeCOSzyBK
	Nd8BS+3RGGKatx1PSgTA9CkpktLDjabgSnu54Es+qDOGfiouy3Lz7BE8CpNHMFXI3hukuUpax+Y
	dfBlr5Le+ey0M9MG8rxfecjxA==
X-Received: by 2002:a05:690e:140f:b0:651:c221:9649 with SMTP id 956f58d0204a3-65bee79ad34mr2152879d50.19.1777381604398;
        Tue, 28 Apr 2026 06:06:44 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:7bc4:3841:9e4c:e2ac])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bee29f1b4sm1645074d50.5.2026.04.28.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:06:43 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:06:39 -0500
From: Corey Minyard <corey@minyard.net>
To: Matt Fleming <matt@readmodwrite.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	openipmi-developer@lists.sourceforge.net,
	Tony Camuso <tcamuso@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ipmi: Add limits to event and receive message
 requests
Message-ID: <afCw3_yXBBbRVrgA@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260421132544.2666174-1-corey@minyard.net>
 <20260421132544.2666174-3-corey@minyard.net>
 <aeyJ0fClAWI2lBwL@matt-Precision-5490>
 <ae1VOEhdR0H0rf0a@mail.minyard.net>
 <afCHrNN-PuXh1WzG@matt-Precision-5490>
 <afCdy0Nu8glFCzqk@mail.minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afCdy0Nu8glFCzqk@mail.minyard.net>
X-Rspamd-Queue-Id: 32B48487343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241660-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[corey@minyard.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:dkim,minyard.net:replyto,mail.minyard.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 06:45:15AM -0500, Corey Minyard wrote:
> On Tue, Apr 28, 2026 at 11:15:46AM +0100, Matt Fleming wrote:
> > On Sat, Apr 25, 2026 at 06:58:48PM -0500, Corey Minyard wrote:
> > > 
> > > Oh, yeah.
> > > 
> > > Moving it to handle_transaction_done() is not ideal, though.  If
> > > something was spewing receive messages, it would never get to events,
> > > which is why I did it like I did.
> > > 
> > > The following should fix this.  You could also have different limits for
> > > receive messages and events, but I think the following is more clear.
> > > 
> > > diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> > > index 2a739123270c..e46f4150ceb5 100644
> > > --- a/drivers/char/ipmi/ipmi_si_intf.c
> > > +++ b/drivers/char/ipmi/ipmi_si_intf.c
> > > @@ -413,8 +413,10 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
> > > 
> > >  	start_new_msg(smi_info, smi_info->curr_msg->data,
> > >  		      smi_info->curr_msg->data_size);
> > > -	smi_info->num_requests_in_a_row = 0;
> > > -	smi_info->si_state = SI_GETTING_MESSAGES;
> > > +	if (smi_info->si_state != SI_GETTING_MESSAGES) {
> > > +	    smi_info->num_requests_in_a_row = 0;
> > > +	    smi_info->si_state = SI_GETTING_MESSAGES;
> > > +	}
> > >  }
> > > 
> > >  static void start_getting_events(struct smi_info *smi_info)
> > > @@ -425,8 +427,10 @@ static void start_getting_events(struct smi_info *smi_info)
> > > 
> > >  	start_new_msg(smi_info, smi_info->curr_msg->data,
> > >  		      smi_info->curr_msg->data_size);
> > > -	smi_info->num_requests_in_a_row = 0;
> > > -	smi_info->si_state = SI_GETTING_EVENTS;
> > > +	if (smi_info->si_state != SI_GETTING_EVENTS) {
> > > +	    smi_info->num_requests_in_a_row = 0;
> > > +	    smi_info->si_state = SI_GETTING_EVENTS;
> > > +	}
> > 
> > Thanks. Does this correctly handle a stream of mixed receive+event
> > flags, though? If we bounce between MESSAGES and EVENTS, won't we keep
> > resetting the counter on each state transition and never hit the limit?
> 
> It should.  Once the limit is reached it clears the bit in msg_flags.
> That should prevent the messages or events from being re-requested
> until the next flags fetch.  So if a continuous stream of messages
> and events was coming in, it should fetch 10 messages, clear the bit,
> then fetch 10 events, then clear that bit, then go back to normal
> operation.
> 
> Of course, the next flag fetch will start the process over.

Actually, probing deeper, this probably won't work.  And I'm not sure
there is much I can do to fix it.  It will be much harder.  But it
depends on how the BMC handles this.

If there is something in the event queue or receive message queue, the
BMC is supposed to set an attention bit (ATTN) on the interface  If
ATTN is set, the driver is supposed to fetch flags to know what it
needs to do.

I haven't tried, but in the qemu changes below, I'm fairly sure the ATTN
bit will never get cleared, thus when it goes through all this the
KCS state machine will return SI_SM_ATTN at the end and the flag fetch
will start again.  You are still wedged.

The qemu version also runs with interrupts by default, which only
magnifies the problem.  In that case, when ATTN is set and you aren't
running transactions, the interrupt is enabled.  On KCS there is no way
in the KCS interface to disable the interrupt at the interface, you have
to send it a message or disable it with disable_irq().

But the actual failing BMC may not work this way.  It may or may not
clear the Event Message Buffer Full flag.  It may or may not do anything
with ATTN.

A driver can only do so much to account for broken hardware.  The driver
is already too complex, a lot of it due to having to handle broken
hardware.  Fixing this adds more complexity and penalizes hardware
that works properly.

Anyway, I'm going to need to get this failing in simulation and figure
out how to handle this.  Yet more issues may come up, especially with
interrupts.

Is there any way you can just get the hardware fixed?  It's never going
to work very well as it is.  I'd be inclined to just denylist it.

-corey

> 
> > 
> > I was able to cook up a simple repro in Qemu for this class of bug.
> 
> I was thinking about how to do an automated test for this.  I use an
> external simulated BMC for the automated tests I have.  So I'll work in
> that direction.
> 
> But thanks, this should help me develop that test.
> 
> -corey
> 
> > 
> > ---->8----
> > 
> > diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > index fd875491f5..127db30c03 100644
> > --- a/hw/ipmi/ipmi_bmc_sim.c
> > +++ b/hw/ipmi/ipmi_bmc_sim.c
> > @@ -249,6 +249,21 @@ struct IPMIBmcSim {
> >      uint8_t evtbuf[16];
> >  
> >      QTAILQ_HEAD(, IPMIRcvBufEntry) rcvbufs;
> > +
> > +    /*
> > +     * Fault injection: sticky EVENT_MSG_BUFFER_FULL.
> > +     *
> > +     * Simulates a BMC that continuously generates events (e.g. after a
> > +     * cold reset causes sensor state changes).  Once armed, every
> > +     * READ_EVENT_MSG_BUFFER returns success but never clears the
> > +     * EVT_BUF_FULL flag, starving waiting_msg in the SI layer's
> > +     * handle_flags() loop.  Reproduces the 517m277 / KRN-1233 wedge.
> > +     */
> > +    bool     fi_sticky_events;   /* enable via property */
> > +    uint32_t fi_evt_arm_after;   /* arm after N completed responses */
> > +    uint32_t fi_evt_rsp_count;   /* responses completed so far */
> > +    bool     fi_evt_armed;       /* fault is active */
> > +    uint32_t fi_evt_read_count;  /* READ_EVENT_MSG_BUFFER calls served */
> >  };
> >  
> >  #define IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK        (1 << 3)
> > @@ -494,7 +509,7 @@ static int sel_add_event(IPMIBmcSim *ibs, uint8_t *event)
> >  static int attn_set(IPMIBmcSim *ibs)
> >  {
> >      return IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(ibs)
> > -        || IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs)
> > +        || (!ibs->fi_evt_armed && IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs))
> >          || IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK_SET(ibs);
> >  }
> >  
> > @@ -750,6 +765,48 @@ static void ipmi_sim_handle_command(IPMIBmc *b,
> >   out:
> >      k->handle_rsp(s, msg_id, rsp.buffer, rsp.len);
> >  
> > +    /*
> > +     * Fault injection: count completed responses and arm sticky
> > +     * EVENT_MSG_BUFFER_FULL after the configured threshold.
> > +     */
> > +    if (ibs->fi_sticky_events && !ibs->fi_evt_armed) {
> > +        ibs->fi_evt_rsp_count++;
> > +        if (ibs->fi_evt_rsp_count >= ibs->fi_evt_arm_after) {
> > +            ibs->fi_evt_armed = true;
> > +            ibs->fi_evt_read_count = 0;
> > +
> > +            /*
> > +             * Seed the event buffer with a synthetic sensor event
> > +             * (sensor type 0x01 = Temperature, event type 0x01 =
> > +             * threshold, evd1 = upper critical going high).
> > +             * This matches what real BMCs generate after a cold reset.
> > +             */
> > +            memset(ibs->evtbuf, 0, 16);
> > +            ibs->evtbuf[2]  = 0x02; /* System event record */
> > +            ibs->evtbuf[7]  = ibs->parent.slave_addr;
> > +            ibs->evtbuf[9]  = 0x04; /* Format version */
> > +            ibs->evtbuf[10] = 0x01; /* Sensor type: Temperature */
> > +            ibs->evtbuf[11] = 0x01; /* Sensor number */
> > +            ibs->evtbuf[12] = 0x01; /* Event type: threshold */
> > +            ibs->evtbuf[13] = 0x09; /* Upper critical going high */
> > +            ibs->evtbuf[14] = 0x57; /* Threshold value */
> > +            ibs->evtbuf[15] = 0x00; /* Sequence (incremented on reads) */
> > +
> > +            ibs->msg_flags |= IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> > +
> > +            /* Ensure event message buffer is enabled in global enables
> > +             * so the kernel sees it.  Also enable event logging.
> > +             */
> > +            ibs->bmc_global_enables |= (1 << IPMI_BMC_EVENT_MSG_BUF_BIT)
> > +                                     | (1 << IPMI_BMC_EVENT_LOG_BIT);
> > +
> > +            k->set_atn(s, 1, attn_irq_enabled(ibs));
> > +
> > +            fprintf(stderr, "[FI] sticky-events armed after %u responses\n",
> > +                    ibs->fi_evt_rsp_count);
> > +        }
> > +    }
> > +
> >      next_timeout(ibs);
> >  }
> >  
> > @@ -1013,8 +1070,14 @@ static void clr_msg_flags(IPMIBmcSim *ibs,
> >  {
> >      IPMIInterface *s = ibs->parent.intf;
> >      IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
> > +    uint8_t clear_mask = cmd[2];
> > +
> > +    if (ibs->fi_evt_armed) {
> > +        /* Don't allow clearing EVT_BUF_FULL when sticky events active */
> > +        clear_mask &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> > +    }
> >  
> > -    ibs->msg_flags &= ~cmd[2];
> > +    ibs->msg_flags &= ~clear_mask;
> >      k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
> >  }
> >  
> > @@ -1040,7 +1103,19 @@ static void read_evt_msg_buf(IPMIBmcSim *ibs,
> >      for (i = 0; i < 16; i++) {
> >          rsp_buffer_push(rsp, ibs->evtbuf[i]);
> >      }
> > -    ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> > +
> > +    if (ibs->fi_evt_armed) {
> > +        /*
> > +         * Sticky mode: return success but keep EVT_BUF_FULL set.
> > +         * Vary the event data slightly so the kernel doesn't
> > +         * de-duplicate (increment evd3 as a sequence number).
> > +         */
> > +        ibs->fi_evt_read_count++;
> > +        ibs->evtbuf[15] = (uint8_t)(ibs->fi_evt_read_count & 0xff);
> > +        /* Don't clear the flag — starvation continues */
> > +    } else {
> > +        ibs->msg_flags &= ~IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
> > +    }
> >      k->set_atn(s, attn_set(ibs), attn_irq_enabled(ibs));
> >  }
> >  
> > @@ -2670,6 +2745,8 @@ static const Property ipmi_sim_properties[] = {
> >      DEFINE_PROP_STRING("lan.netmask", IPMIBmcSim, lan.arg_netmask),
> >      DEFINE_PROP_STRING("lan.defgw_ipaddr", IPMIBmcSim, lan.arg_defgw_ipaddr),
> >      DEFINE_PROP_MACADDR("lan.defgw_macaddr", IPMIBmcSim, lan.defgw_macaddr),
> > +    DEFINE_PROP_BOOL("fi_sticky_events", IPMIBmcSim, fi_sticky_events, false),
> > +    DEFINE_PROP_UINT32("fi_evt_arm_after", IPMIBmcSim, fi_evt_arm_after, 40),
> >  };
> >  
> >  static void ipmi_sim_class_init(ObjectClass *oc, const void *data)

