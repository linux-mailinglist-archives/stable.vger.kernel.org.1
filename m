Return-Path: <stable+bounces-247846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP8NI6NCB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 992FF552869
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DC58306269A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D43FF1D8;
	Fri, 15 May 2026 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7EvjLg7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMZaYNYi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC863FF1AF
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860087; cv=none; b=Fhttfuh96/gqJjJJjmibfrmb1h2sTVF41SDtPzrMLmn6SGfQk4q9vAyNy/wUld7I5fYBCmYDAfhyMkuM7YqCn5+UL5yRi/X8CjdhX9VkyBdDToqFSBgymfYaDNUuSnIL2fWpahelvjyXXTC9JJqSNHqLoiOvq/wNEQVBmy7PcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860087; c=relaxed/simple;
	bh=WX8Na5O46N/1mGmAO8R44Mtob2oRjMv7bEtc29QSnOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKXM8K5WlmBImwtBgSA8Edv8j39w/hdM9ziQL5AdvCXIELGEhptKPSL+5esFcdkPFPsKbuL64WI7v7XWDEXL4Lni4R1hJUadgJ4sTzjlsqQO5dzLGAYaYDMAmKDp6BpUC9SimKNdxz9pQ8FiDEJ6fHHTBaGeclYlCd2drEZ4qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7EvjLg7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMZaYNYi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778860085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sx+eoO0CgxcgeUymE9wAWQQJ/R1ryTtZZ9xEd2rEqc=;
	b=Z7EvjLg7qhJzyublgyzXQBVJf7O6+XuWLh/CGbwwKqhZZ3AObsK1tAZrdeIwbOoGHfBA2u
	j7LbQOPUSOHtVCdSkmgoDd8+SlncFq2bLK2DJMLokX4+rGIL9d5YTcEFqjTZx77U8ZtVwx
	A/wJUt5Crz8o/d2jCz8D58oUndC1AmM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-FBQSPOPMMZChd_byao2xxw-1; Fri, 15 May 2026 11:48:03 -0400
X-MC-Unique: FBQSPOPMMZChd_byao2xxw-1
X-Mimecast-MFC-AGG-ID: FBQSPOPMMZChd_byao2xxw_1778860082
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e79219704so41364445e9.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778860082; x=1779464882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Sx+eoO0CgxcgeUymE9wAWQQJ/R1ryTtZZ9xEd2rEqc=;
        b=UMZaYNYi3Pcyj8uC7pKEut3bYVanRk/NUbXyI3Wi8z3vUl4o3gSqgZVOoifPPJwTYr
         X/hLsV3UhKjhq7kI6aqfni7YJZWq73meLBdbTAqD6iotVONMfSgl6IMYfeCapxDx8MKi
         ZIrpcUpdZ/r03RFFlOeKId5BlXo9M6OwQHum9zeJkwYm1OjWDo7OdOzkPk4+FnBQFpTK
         Y3BWFFjFTbcnnLUX0xZ13/ImCiB8j9eht1ZsSoW68DilTlP6wMq8z8jTAJR3AJ7sqPcv
         Tyw7dXIf0qLU8UQTRm07UZwuKJf2lfwMl2AHIQ0CFu6MGar+ZciAQgZpOrPsDdd+IgSf
         uqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860082; x=1779464882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Sx+eoO0CgxcgeUymE9wAWQQJ/R1ryTtZZ9xEd2rEqc=;
        b=Gb1N8ELDZQPNIQfxbCpD9z/fpP8HaDnJkVt6WAh29stQZP1T2Sb9EZceMPRxw0D+gc
         DqRbsPBinPEZ0eiXf32h9txuPajIK1BF1zR+NsAfy2ol6jGsYyvfn74OQMYEn3YcT4Ho
         BD8kp/dcsXUzrR8eU1y2U11AwjEhUultOIiUAC/4CLcjO6UtKKKPqXzWF1Oh+iXSafU1
         BcxLOiEtvU8TStopJaqLFQiPAWQc+AucZ69jSeKkGBu3OSysj7RZLOvFBdQWV5Gt+Guh
         3mMcBRptBnUf3Q/Y4PDPsJ9eUSkkD/OTo8l2vYf9eh2e1NcuM4W1B+/Uo2r/oCwfKjdv
         32fA==
X-Forwarded-Encrypted: i=1; AFNElJ9W75gpQC3NCVY2YbRJwTDZ1o8o/84iQAstzRlaluh3QwALEd9zgPeqmkBvdHkRawcF+6/hVlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUXYrDEUarHEru3n03Y+WA98PPu1PM1v5DjV8ZSllaycZbS7L
	S5ysz9AES7/hCjODtMWRew6GO799TsNfmz3B0oW1BovstHBVv1rBlR9fE6MfYBsDb/zxnim5H2K
	QeYbAb0n8bG6M5B8RI4NYMNGAXlqR2XWZ//oNdrNwl3jgyDRC2ooxTasoZw==
X-Gm-Gg: Acq92OFW2fZvWLlFA2u8XfFHa6B4dImX8Z8A01Z6nYXxrSfNs0ohEvtE0R81CORMutX
	PCCA2FP6LKrt1gg2TcxVK9lPBhNR2nXxexzif6+trL653MgPA7MJpAMBgS1DYGplxENpeJQKg1c
	hSjEVGKzW0rCMA2smBjY+9Hml4U3+Vo6DkT6PMHLC0I2RWsiKuQc0+cU6Rdb/glimfV1qifmzDz
	E/Te+DWI6+yomsx8AMxJjAUO/zmy/VtefPDAaimEcFXEf9ivHqKX9y/2ViQjkZ24sxunSigRT4H
	0Y8kqH3ukEh5RzFaNVRfPEeigWEbC0SQ5ufovVBLYNSHOzIiWyz5KVgkvs+HT82h0Uwnihmi1qd
	3dqUo4TA1NERbxE+CoNug7mcYTJsozqLn+nK9y5KQ
X-Received: by 2002:a05:600c:1389:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48fe60e5271mr62980125e9.7.1778860082213;
        Fri, 15 May 2026 08:48:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1389:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48fe60e5271mr62979655e9.7.1778860081693;
        Fri, 15 May 2026 08:48:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm21181015e9.9.2026.05.15.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:48:01 -0700 (PDT)
Date: Fri, 15 May 2026 11:47:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com,
	jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <20260515114521-mutt-send-email-mst@kernel.org>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026051526-banish-strife-6dba@gregkh>
X-Rspamd-Queue-Id: 992FF552869
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247846-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 05:41:48PM +0200, Greg KH wrote:
> On Fri, May 15, 2026 at 11:36:12AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 15, 2026 at 05:21:53PM +0200, gregkh@linuxfoundation.org wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     vsock/virtio: fix potential unbounded skb queue
> > > 
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      vsock-virtio-fix-potential-unbounded-skb-queue.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > 
> > Yea I have some doubts. It fixes the DoS at the cost of losing
> > messages. We are trying to fix that upstream now, maybe wait
> > for that?
> 
> being bug compatible is good!  :(

Well you are the maintainer. Up to you.

> What's the status of that fix?
> 
> thanks,
> 
> greg k-h


Stefano posted v3 and is working on v4.

>  Should it be reverted elsewhere?

Donnu. With the change we have no DoS but the socket gets silently
broken.  Eric felt given the brokenness is  upstream already it's better
to work on a fix on top, not revert.

-- 
MST


