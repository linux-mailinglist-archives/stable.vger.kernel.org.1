Return-Path: <stable+bounces-254334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAbEJnyWFWp9WgcAu9opvQ
	(envelope-from <stable+bounces-254334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:47:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1655D5BFF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA88F3009830
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E261FF5E3;
	Tue, 26 May 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqPHbZWp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hli0c0lI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EA1ACED5
	for <stable@vger.kernel.org>; Tue, 26 May 2026 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799670; cv=none; b=eB/QtzoncCygjO0q+xAe75oRUlRDUFRuSWcMpw4ItT9nZNWqSa+Qi0AjJ++MItOGjTtdwsZLZ+chyjuHRAClLxwq3wQxArhW729mpSJhDQ1DLgUG/QUeGOQlkNgMq1A9l8Qhm0JKpVY0YBHvDmlH4JqRIksHihs/oYUcO0jIPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799670; c=relaxed/simple;
	bh=qdAHZY/R6V7jBr84z92m0h1ql/ogeK6NNj6mvqYpaHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJJ6Q7hP8sE83hQuiFzYg+14DY9oa7cJAhmLHn7as8/TTOuHMgDKd3uibAKdvQH2LxbkKet+Rjf/GhS3eJwUr8YtIE8vsiwtju146IeaX1HA6PgNDkcMu7im6Tb8dHnGA0tm1l4HL25ZTijOOOzrzePGOLTv2xndghO1Eb2F2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqPHbZWp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hli0c0lI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779799668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kwiZ88aMCCOMgCKv+ZUerR8iXVNCA9hIs6rASmQTCk=;
	b=LqPHbZWp3BAQftfqI91wcoKp5iuwUg0kCxRipZS1iNrKTdB/x1JECNfLjPpsxb5m/sksgl
	R7jpnE8YpD8fOI3K7+j7ifqHrPOsBi6Kt3wyBx9ljwM7jhwee5o0cvG8/Vo9ZLiwDlfOTn
	fTvGIQ+uXN0+wGEXPHRC9DqdjvpVtzI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-eHQErmZXMDW0t3xhudj12w-1; Tue, 26 May 2026 08:47:46 -0400
X-MC-Unique: eHQErmZXMDW0t3xhudj12w-1
X-Mimecast-MFC-AGG-ID: eHQErmZXMDW0t3xhudj12w_1779799665
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a71109b94so7198862f8f.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779799665; x=1780404465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kwiZ88aMCCOMgCKv+ZUerR8iXVNCA9hIs6rASmQTCk=;
        b=hli0c0lI4eQDLqoeO7rJdbE4h854DhQhYKGW+V6BWsyG1uB9rt5DqjaYC8gocGgde/
         G1V0nkGLEUk+ERD2uheTbLBI67k6cxMXix0zFG2YOCz2NiT10JFILIrjdk4w188Fp8nL
         OTUkTstP9SptMjcGqlqSTl4E/z/RysAcbD0JNEwAGq/fb6dNtTSNPsDKH9qtuOUJ2yuF
         JHp3Hu5F77ETnn6EzvQAoKJttGtm5QtWZOo3cPOzAX3J+gyfzOXmN/1it/h+sAIAhgBf
         OrNGakdKLKd5bTRepQf3DCR1XTYm6sWbx44WA61JW0SE7QWUpEVDq+xr4EC1e062N+LH
         63hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799665; x=1780404465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kwiZ88aMCCOMgCKv+ZUerR8iXVNCA9hIs6rASmQTCk=;
        b=Gd1KqfUxspLvp3bnyIEgtZB4dwSxDSBTSxNgZXosYNI9b6hqr7lQP8jDVIQGIeBeoK
         RKBmCdNHurrB73y9uxw4CdLPPcr+3WwuMd1XYr0D2oldV3sFC5HofbVfvN57lnp9JTDO
         Scc+OFAYV5ipb1qXAlpRRWRGz8FtCEPHQoifj5C5fEZK4Csv6lxnUaBBOzcyKxCBvxhw
         4c+Nq55TY8LXkB8bgUYXgQyvrVly7XtnSVyc32L73i3ddDcEbxa7oh9pXgasavX7wNaW
         +l8s2nMZjw45sr1/5Ohv60MqMDi9RwguAk4Whfsg+5Le+TpNHsIEjstEjY7OeqxubL5P
         TFPw==
X-Gm-Message-State: AOJu0YypbToOZsM2O1B0uMa8G492pK02QIRsJ2A2nYW2XZNTKzFueTOP
	tHBuOpZ1rQWs4xjpVWceCMOnqYbLvEaSYc6Zu/hLieQnJrRYOUlul23b9n/pfZYAwTInUb6JtV9
	3QYM0PhLNI8jdawMtQTWJIKZiNVpwFA/tYVhY4NhdOuL/A3j92D6s68mmARRxgi3xLA==
X-Gm-Gg: Acq92OGd6Tk1LE9SFXR/6V9EkvzIv8DFSFyWPi4krhp+eZangsWG7F+ii693VbwpaPY
	3ojifaeeGlxd6iDhYYfuCPgcM8V8xeGPWCvqbXamxJg+fDjbqhAx1ysC+RpEJlZU615SKfPLHG8
	RELxKtbffBNUTzN58SqsncZof10lUCBuULigkNWxTZ00oTehjs3j9Iem+2crPZdWEM0ZMG594ZA
	7gZgUZcNEPGLYSU3h/NJg/RZdusCn/9kdjf9sVK0kvb1r9Ha/dH3bHCRmMMin4dyTN9/5asv/ub
	Np2WFCzRED1rilhGwZ6CIwXhJmhf7l+wQ2cYtXkx/wn0ZyDqu6MyDimaOHFMNUO2itkFe3A1j6W
	xCIY0APDI
X-Received: by 2002:a05:6000:1a85:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-45eb367fb35mr31041318f8f.17.1779799665237;
        Tue, 26 May 2026 05:47:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-45eb367fb35mr31041262f8f.17.1779799664691;
        Tue, 26 May 2026 05:47:44 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f6ffsm35518540f8f.1.2026.05.26.05.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 05:47:43 -0700 (PDT)
Message-ID: <e1ce1387-ae6b-4b43-b5d8-a1141c4a4f1c@redhat.com>
Date: Tue, 26 May 2026 14:47:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v3] ice: fix packet corruption due
 to extraneous page flip
To: Jacob Keller <jacob.e.keller@intel.com>,
 David Laight <david.laight.linux@gmail.com>,
 John Ousterhout <ouster@cs.stanford.edu>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org
References: <20260512181953.1689-1-ouster@cs.stanford.edu>
 <20260513100732.499e3f49@pumpkin>
 <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
 <20260513214927.17a8dd45@pumpkin>
 <CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
 <20260514110112.12bdf5ff@pumpkin>
 <30dc284c-8cc0-4bae-b7b0-99d6d71a66e3@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <30dc284c-8cc0-4bae-b7b0-99d6d71a66e3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com,cs.stanford.edu];
	TAGGED_FROM(0.00)[bounces-254334-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE1655D5BFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/14/26 18:43, Jacob Keller wrote:
> On 5/14/2026 3:01 AM, David Laight wrote:
>> On Wed, 13 May 2026 21:47:11 -0700
>> John Ousterhout <ouster@cs.stanford.edu> wrote:
>>
>>> On Wed, May 13, 2026 at 1:49 PM David Laight
>>> <david.laight.linux@gmail.com> wrote:
>>>> On Wed, 13 May 2026 09:28:40 -0700
>>>> John Ousterhout <ouster@cs.stanford.edu> wrote:
>>>>   
>>>>> On Wed, May 13, 2026 at 2:07 AM David Laight
>>>>> <david.laight.linux@gmail.com> wrote:
>>>>>> On Tue, 12 May 2026 11:19:53 -0700
>>>>>> John Ousterhout <ouster@cs.stanford.edu> wrote:
>>>>>>   
>>>>>>> Consider the following sequence of events:
>>>>>>> * The bottom half of a buffer page is filled with data from
>>>>>>>    packet A. The page has a net reference count (reference count
>>>>>>>    - bias) of 1. The page is returned to the NIC, flipped to
>>>>>>>    use the top half.
>>>>>>> * Before the reference on the page is released, the NIC returns
>>>>>>>    the page with no data in it ('size' is zero in ice_clean_rx_irq).
>>>>>>>    In this case the bias does not get decremented. The page still
>>>>>>>    has a net reference count of 1, so it gets returned to the NIC.
>>>>>>>    However, ice_put_rx_mbuf flipped the page so that the bottom
>>>>>>>    half is active.
>>>>>>> * If the NIC stores another packet in the page before packet A
>>>>>>>    has released its reference, the data in packet A will be
>>>>>>>    overwritten with data from the new packet.
>>>>>>> * Unfortunately zero-length buffers occur frequently: they seem
>>>>>>>    to occur whenever a packet uses every available byte in a
>>>>>>>    buffer, ending precisely at the end of the buffer. When this
>>>>>>>    happens the NIC seems to generate an extra zero-length
>>>>>>>    buffer.
>>>>>>> The fix is for ice_put_rx_mbuf not to flip pages that have a
>>>>>>> size of 0.
>>>>>> How is this different from packet B (in the top half) being
>>>>>> freed before packet A (in the bottom half)?
>>>>> I'm not sure exactly what you're referring to here. Are you asking
>>>>> about a situation where both halves of the page get filled with packet
>>>>> data and then the second half to be filled is the first to be freed? I
>>>>> believe that the ICE driver abandons a page if both halves are ever
>>>>> occupied simultaneously; the page will be returned to the system once
>>>>> both halves have dropped their references. Thus it doesn't matter
>>>>> which half is freed first.
>>>> That is what I was thinking, seems like the logic is over complicated.
>>>>
>>>> If you need to put 4k pages into some kind of iommu rather than 2k buffers
>>>> (to contain 1536 byte ethernet packets) then I'd have thought you'd
>>>> initially put both halves into adjacent tx ring entries.
>>>> If a rx buffer is discarded (eg a zero length fragment or a CRC error,
>>>> or even 'copy break' for short packets) then, as an optimisation,
>>>> you could reuse the buffer for another receive.
>>>> The same could be done if the page is freed by an application.
>>>>
>>>> However it sounds like it doesn't use the 2nd half until the first
>>>> completes - otherwise you'd never 'flip' to make the other half
>>>> active.
>>>>
>>>> Thinks...
>>>> By only putting half of each 4k 'page' into the rx ring the code
>>>> will usually save (expensive) iommu setup in the (probably) normal
>>>> case where the buffers are freed 'reasonably quickly'.
>>>> But that really requires a 'free/with_nic/busy' state for each half
>>>> rather then trying to guess from a reference count.
>>>>
>>>> But if the low-level code is recycling the rx buffer (for any reason)
>>>> it wants to use the same buffer.
>>>>
>>>> The ethernet driver I wrote (a long time ago, early 90s) allocated
>>>> 64k as 128 512byte buffers and did an aligned word-sized copy of
>>>> every receive frame - most frames were in contiguous memory.
>>>> The simplicity of it made up for the cost of the copy, especially
>>>> since that was an iommu system.
>>> I'm not here to defend the logic (and it has been replaced with
>>> something that is probably simpler and more efficient); I'm just
>>> suggesting a bug fix for the stable releases that still have this
>>> logic.
> Right. We definitely want a fix for the possible data corruption in
> stable. Ideally one as simple as possible.
>
>> You've forced me to look at all of the function :-)
>> I've noticed a few things:
>> - If ice_add_xdp_frag() fails (because there are too many fragments)
>>    then the rest of the fragments are left in the tx ring (instead
>>    of being discarded) - so are likely to be treated as a full packet
>>    later on.
>> - Frames with status errors (crc, framing etc) are discarded after
>>    the skb is built - surely that should happen before the xdp 'program'
>>    is called.
>> - If the remote system send a very very long frame (traditionally the PHY's
>>    'jabber detect' didn't always work) you can end up with all of the rx
>>    ring being full of a single partial packet.
>>
>> I think you need to avoid calling ice_add_xdp_frag() when 'size == 0'.
>> Then in ice_put_rx_mbuf() unconditionally call ice_put_rx_buf() for
>> zero length fragments.
>> The comment would be 'zero length fragments can always be reused'.
>>
> That seems correct.
>
>> The zero length fragments almost certainly exist because the mac hardware
>> advances the the new buffer expecting more data - but only gets the
>> 4 byte CRC. So the zero length buffer contains the receive status.
>>
> That matches my understanding.
Hi John,

I have been looking at the same area in the pre-page-pool ice code and
I want to ask whether you observed memory growth during your Homa runs
that exposed the corruption, because in my testing the same bias mismatch
also produces a slow page leak that your v3 does not close.

Short version of the leak path, in the PASS (!CONSUMED) branch:

   1. ice_get_rx_buf(size=0) does pagecnt_bias-- unconditionally
      (added by commit ef68094cb09e ("ice: Fix kernel panic due to page
      refcount underflow") as the fix for the matching panic).
   2. ice_add_xdp_frag() then returns 0 for size==0, so that page is
      never attached to the xdp_buff/SKB. Nobody downstream will ever
      call put_page() to balance the pagecnt_bias-- from step 1.
   3. Your v3 in ice_put_rx_mbuf() correctly skips the page flip for
      size==0, which closes the corruption window. But it does not
      restore pagecnt_bias for that zero size buffer, so the page is
      handed back to ice_reuse_rx_page() with a permanent deficit of 1.
   4. On the next reuse of that page with size > 0, pagecnt_bias drops
      again. ice_can_reuse_rx_page() now sees pgcnt - bias == 2 and
      drains via __page_frag_cache_drain(page, pagecnt_bias). Because
      pagecnt_bias is one too low, the drain undershoots by 1: page
      refcount stays at 2 instead of 1.
   5. The SKB eventually releases its reference (refcount -> 1), but
      nothing ever brings it to 0. The page is leaked.
      ice_alloc_rx_bufs() just allocates a fresh page to fill the slot.

At the zero size frequency you mentioned (thousands per second), this
adds up to roughly MB/s of leaked page cache, which Jaroslav Pulchart
originally reported against 6.13.y on NUMA nodes and which motivated
the libeth/page_pool conversion in mainline. So in stable trees the
leak side of this bug is still live.

Two questions:

   - Did you monitor RSS / page allocator stats over the duration of
     your Homa runs? If you did and did not see growth, I would like
     to understand what is different about your setup, because by my
     reading of the code the leak should fire whenever both halves of
     a page end up in SKBs simultaneously and one of them carried a
     zero size descriptor along the way.

   - If your focus was specifically the corruption, would you be open
     to extending v3 (or replacing it) with a fix that also restores
     pagecnt_bias for the size==0 case? The minimal extension is one
     extra branch in ice_put_rx_mbuf:

         if (verdict != ICE_XDP_CONSUMED && size != 0)
                 ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
         else
                 buf->pagecnt_bias++;

     which restores bias on every path where the page is not actually
     going out to an SKB. (I have a slightly different variant that
     tracks has_data in struct ice_rx_buf to also handle the broken
     positional 'i <= xdp_frags' counter in the CONSUMED path, where
     zero size descriptors in the middle of a frame steal bias++ slots
     from real fragments. Happy to share it if useful.)

Regards,
Petr


