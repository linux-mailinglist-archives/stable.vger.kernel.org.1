Return-Path: <stable+bounces-200971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257ECBBD47
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E0E3007EFC
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5452D7DF5;
	Sun, 14 Dec 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdHUh9A6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB522DF99
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765728630; cv=none; b=TdvkjPK2g3gvC2AHNpoLnqPfDTkmC2P/PFmlAJp2Ln1blNl6EKZy3eAVeiQAnEiQ591uqpH/iUcq1ltd1+JppzxzuSChJeIN0Iixi2FT/MfWyVlIxbL3dVXGtbcVB+lPhkpf79QLT/vLT+uFxI1+37jzNzLZh4dYYkjJSgH9/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765728630; c=relaxed/simple;
	bh=2P76yn+Z8LI/ZVioihqPrigDTmpFaYI31nbzKmzdNA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3ncrzCj4m7RyJOQnas+mUeBPRpfKLE0+oDNSVfpHxTSHSKCDfY7JcbUpRJAHFpAmKxR/o5jY10SlTweCEZL/DSTSIPHk85kiWHzXvlaf7Mu86NxTDjX+mVHZ8a0k2goxjIITkcf3No8oXBKkkMQioUYIpykrz5tfERLUlwv1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdHUh9A6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b769a872550so41589866b.3
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765728626; x=1766333426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgCqWv5yTAwZgeJA7+vqwON4IRjNzRVmnKX5YmdyP0I=;
        b=QdHUh9A6o7u8t7QAB3ZAFZCjYfeo1dbNv4mTQAnBHHXZstzROD3DZwuRRkgQyK5Ngu
         pNUjv5QQyGDvJVswHoSK8SfzfrDdzpfDeJC28PLARP6Wxnj50TGGVTPq97KIqXZn7sWH
         WLfO5MRTKFCpZLw5olo5TojCJILZtMf/W4+LcX1LKzP/5vIsz+wSBys9PXC3CTv9iUIc
         02Trz5aOVI7JFrjq5olhJXlqHNKxP4F+gsk8jIEdgH2roPclK3YvrLpIu5mrvrNDon07
         Zx/kyfYb2YPXBUksD3t11Cn9XWFXQwAJONDSI6HUXDOB+u2z82GuPt1WC20ht5T4Xgoi
         WcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765728627; x=1766333427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgCqWv5yTAwZgeJA7+vqwON4IRjNzRVmnKX5YmdyP0I=;
        b=SaPlzi4phFwY5Xi8XbAyW2i6JVfArjjU2niRn6FiT5yjewndEhtTH1CagJsZk7vK5I
         AabqLBZb2cdPW5OJDqDwTq4JgXr4CxRISHQNn2cVASFxn6naXihZp6JIa/j6lbcABKb3
         2DEK4UowwgwmLWqxy3BIAFxSFiSOiMEZXI4xlq8UwgfzTSSK4bCUC4RXIzSoqPdX4rNG
         jAuJhHyVMqy2E1sWnFgu+s4TP24zkvuDNtBeH4TknVDC4nQe4WDMAv0FxCbuFV/z8huV
         IAGteWCVQZrl/fs5DRUIYurnUvgKOLuneTIwKSPSx4xdhF1EoenjtPl5sJzY/fMCn75Y
         XC6w==
X-Forwarded-Encrypted: i=1; AJvYcCWxDPj9Eyx+b4dMXu5eRjCBUTvwzywZqBi2i15MaSVEiamDLOuIKrsXc0KUnXgCoE1Ry4m0GPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSnkTE5XrK16skc3nCuxXY09ZuyRzemccd3SCb6QtAsHYJH5i
	kIG1FABNLEGIhZgoVuBQVLUZ9KNEQ9HtunUCE9N0Xkk2mV4HbaDG0tTN
X-Gm-Gg: AY/fxX7arjLWWyfjy7r7UCsPlXpGPjFVdIozvlbRJ3GNZXl+z57cvWQ+u25Q9gMUZfx
	U04CD1RS9F/Zl4Z7BDEvTSj0OdP6wwfGUxDvGKlDWlGtq6YOkIUjeH3iWBZbAz1y1iZHx9DNdBa
	KTtTsAS6cysioQ7EZvWahktohhn2BkQrZpBh5WDuuHyuy8JfKjJQGalHC1XTUrdkvntBkBAMJ30
	gWJ8vzcA6hzrwN7DNyteC/+u5gc53TnlAKGo538so0wZv/VfAoCDav8OLwF2tT/LHVd/mW8uuoO
	KTF4jmGolZXVkF02pQqd2leVggCeH44mEhfPqPf41dDZtAqEgpEaVEJUDRFw+wykZOSQV2QkvC3
	j6QrUgNpFnNFmkrVwEjfTdMeZKKhrtJTNmOSLRlckDdK0m1a+4/mAtSys/fnecdfyxrSse+FbRG
	DClw==
X-Google-Smtp-Source: AGHT+IEEp5YA/CXlF0fGVYT4q2YzKcum9dlHWaMuW0DOnrROURB8FU3NlBiJivnRbJ8xs/4/n0apSw==
X-Received: by 2002:a17:907:7295:b0:b76:2f66:4ddf with SMTP id a640c23a62f3a-b7d238ece38mr491721866b.3.1765728626411;
        Sun, 14 Dec 2025 08:10:26 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:10b6:92bb:682a:9a0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e70c2sm1135704566b.15.2025.12.14.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:10:25 -0800 (PST)
Date: Sun, 14 Dec 2025 18:10:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tobias@waldekranz.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <20251214161023.5qcyyifscu73b47u@skbuf>
References: <20251214131204.4684-1-make24@iscas.ac.cn>
 <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>

Hi Jonas, Ma Ke,

On Sun, Dec 14, 2025 at 05:02:33PM +0100, Jonas Gorski wrote:
> Hi,
> 
> On 12/14/25 14:12, Ma Ke wrote:
> > When of_find_net_device_by_node() successfully acquires a reference to
> 
> Your subject is missing the () of dsa_port_parse_of()
> 
> > a network device but the subsequent call to dsa_port_parse_cpu()
> > fails, dsa_port_parse_of() returns without releasing the reference
> > count on the network device.
> > 
> > of_find_net_device_by_node() increments the reference count of the
> > returned structure, which should be balanced with a corresponding
> > put_device() when the reference is no longer needed.
> > 
> > Found by code review.
> 
> I agree with the reference not being properly released on failure,
> but I don't think this fix is complete.
> 
> I was trying to figure out where the put_device() would happen in
> the success case (or on removal), and I failed to find it.
> 
> Also if the (indirect) top caller of dsa_port_parse_of(),
> dsa_switch_probe(), fails at a later place the reference won't be
> released either.
> 
> The only explicit put_device() that happens is in
> dsa_dev_to_net_device(), which seems to convert a device
> reference to a netdev reference via dev_hold().
> 
> But the only caller of that, dsa_port_parse() immediately
> calls dev_put() on it, essentially dropping all references, and
> then continuing using it.
> 
> dsa_switch_shutdown() talks about dropping references taken via
> netdev_upper_dev_link(), but AFAICT this happens only after
> dsa_port_parse{,_of}() setup the conduit, so it looks like there
> could be a window without any reference held onto the conduit.
> 
> So AFAICT the current state is:
> 
> dsa_port_parse_of() keeps the device reference.
> dsa_port_parse() drops the device reference, and shortly has a
> dev_hold(), but it does not extend beyond the function.
> 
> Therefore if my analysis is correct (which it may very well not
> be), the correct fix(es) here could be:
> 
> dsa_port_parse{,_of}() should keep a reference via e.g. dev_hold()
> on success to the conduit.
> 
> Or maybe they should unconditionally drop if *after* calling
> dsa_port_parse_cpu(), and dsa_port_parse_cpu() should take one
> when assigning dsa_port::conduit.
> 
> Regardless, the end result should be that there is a reference on
> the conduit stored in dsa_port::conduit.
> 
> dsa_switch_release_ports() should drop the references, as this
> seems to be called in all error paths of dsa_port_parse{,of} as
> well by dsa_switch_remove().
> 
> And maybe dsa_switch_shutdown() then also needs to drop the
> reference? Though it may need to then retake the reference on
> resume, and I don't know where that exactly should happen. Maybe
> it should also lookup the conduit(s) again to be correct.
> 
> But here I'm more doing educated guesses then actually knowing
> what's correct.
> 
> The alternative/quick "fix" would be to just drop the
> reference unconditionally, which would align the behaviour
> to that of dsa_port_parse(). Not sure if it should mirror the
> dev_hold() / dev_put() spiel as well.
> 
> Not that I think this would be the correct behaviour though.
> 
> Sorry for the lengthy review/train of thought.
> 
> Best regards,
> Jonas

Thank you for your thoughts on this topic. Indeed there is a problem,
for which I managed to find a few hours today to investigate. I was
going to just submit a patch directly and refer Ma Ke to it directly,
but since you started looking into the situation as well, I just thought
I'd reply "please standby". It's currently undergoing testing.

