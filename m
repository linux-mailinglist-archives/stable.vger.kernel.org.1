Return-Path: <stable+bounces-247474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNr3LRTYBmqDoQIAu9opvQ
	(envelope-from <stable+bounces-247474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:23:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6954B382
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6376F30066B4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA140148F;
	Fri, 15 May 2026 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLn8FlSU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1Q807LU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF274014A3
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833425; cv=none; b=lvJJ+jdsAZHLX/XZUlSGg0/cSj8zJluYy3giMv+ei7FXv5L2KPTtl8ccoxR5QrOl97aWo/7jIrRHOsqOVni+7m6mw0Tx7Rdlj43uqOh6xPSHED8dXKA+72zyHihm2tRnlBlkIomvRl3JY+5vO8CesFYuhjfecXbUf2p4iql04Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833425; c=relaxed/simple;
	bh=VYvBo9UQNQ1MK7fT3Te2EmvELk288RwChwVZJzuNh9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB0+HltZAf4y6ch6hbkZ/6JpcDvjyXs/0M627nB/G7yg5s3b+8FdHTv2MJ1QQXTFNd0HbOagvck8OHM/DSp7iT8SKjoLPIR+IUu4qTOWwdQ7IzK0IkzYG7nkvJtYhV+zjvDNq6TeBiEvBZD4N+EY7pLqYXObxosTVHUj0W9bKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLn8FlSU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1Q807LU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778833419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYvBo9UQNQ1MK7fT3Te2EmvELk288RwChwVZJzuNh9o=;
	b=gLn8FlSUyDwvxkt6jlon2z2nvTkht3jZuIGG4knfgf0HWRPnl9GJVRGmAExtxZXYXFZGDf
	R28ZBJkxIwIF4q4Yvlw67uC6LPPuYXAFCqas3vgNkDNrGdsDsOK1iAXGbfk6fr4c+RjEBH
	D73DOsMkympfDpU4a455xLmat7kRnmE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-C_7cWYRBOdevLcwiAyICLQ-1; Fri, 15 May 2026 04:23:37 -0400
X-MC-Unique: C_7cWYRBOdevLcwiAyICLQ-1
X-Mimecast-MFC-AGG-ID: C_7cWYRBOdevLcwiAyICLQ_1778833417
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51494d74d4bso19230581cf.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778833417; x=1779438217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYvBo9UQNQ1MK7fT3Te2EmvELk288RwChwVZJzuNh9o=;
        b=i1Q807LUq/3xA/wlbGkbv3v2mHJC4GI1S5j+1G+5MgD6AdcsgneIqJK6Wf5GQ9/ItL
         GAZTjD8rHv8FG7nHQDvUXyynIoRwnBpv98hi5U+RHQlqo5fnMyM5ZKvlEAUe44TFctL8
         YmUBAxFgyDAaxvrI4D47o1lTtYnhd32gXYo1A46kllMgLpezUtabh2VafClz63ecVVP/
         uSbMww8tBlakvGAGwHeDZKoIJrODZLKy15lKOTmbLgAloDhbsAhDJmG5Q8YzPAJhhinH
         fhj0xRDSLwZU34bMIpcWGN561pt6PuI57oLDaOs8HbSmqbgARkVysfyUCFfibEXd2VdH
         UI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833417; x=1779438217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYvBo9UQNQ1MK7fT3Te2EmvELk288RwChwVZJzuNh9o=;
        b=qcnXraXg9wie78Srwsq/55cAGhXmRtQHoCBvkSH5pvw7CZ8SjWduwTvqDFJkKgbH8D
         isKJFRFf89Ewp/p/d+LTNBMT1FfDB3N3UODG4/9tsb5bhRf1HaUuPO2rbqBUaZFyj5d8
         irUN/HInDeO9InuxeueDkwuw4vvQzGQl6TaY3wK4odX/DS4Nd1UqYB+V7zt4EBrpV2vN
         VqBRa+UtspGk6pOuRM6lLKKFxcLr/Ypx0FLkseX46iEVsbbK15HkSl7dBOznanuyRenT
         cDk8GFG5cEJQBEeT1WbQ+t66g70oKbk8E0Y63AGqmHOEm5YDJSDveqU+EqZGDXzpvFP9
         peaA==
X-Gm-Message-State: AOJu0YxiOPxqtvRJo6dM15lQgowLc0xjuxmPSoP0+IZgSflxVlgTUxVv
	NX22TqLFy31NgJdQqsxm0dhh3tCX/N/5/DhSA132qx9oeAbUVAXXA/SWSV84NMrwlWCCuZmiyyI
	rmgYbFHZ9p28h+DRFhz/n3UiWyOaCsn0YuiSpNKHW66l8b35Wbwg19jo/MBIjJ7njwA==
X-Gm-Gg: Acq92OFSvJgB0fJVyEWdEzC5SVr6OJlQzt90WNQSECwgr5WatrdHkeyds1hCO6AVDox
	8KhMIsvYPDL+KrIkaf6dctnBZEHivKmvR4putt/IWQubxBkepv8PsuET4XC9cPOV7uR+3n8pGq5
	nBeZ/oshgYbKrUVX/0VcBLa/z8GzcxumLkObtRKrz+6dXkGgJ6IQzyvZ3v2VpnlZgjdJNJu74Ue
	VId1q4VSPP7vJ5eoPuDKiOb9NI+w2mHiSih/JTTdOtwifgLJ8/I5UEsNuP8pedXoGOgVVt/gR+Y
	v76MIeHslcnTgYiFs9cxZKhI6UxQZcUwY/1BWEGW4TiJFL1+youixA0ynCyzuaN5vjhYVa0+qqb
	rdKE+vD2crgmMWhlS/AaaL2/2McR+fjLUijmZmDuH8CkFMW+jQiM4NdNoEzg=
X-Received: by 2002:a05:622a:90e:b0:50f:1b95:675a with SMTP id d75a77b69052e-5165969f747mr37235681cf.4.1778833416826;
        Fri, 15 May 2026 01:23:36 -0700 (PDT)
X-Received: by 2002:a05:622a:90e:b0:50f:1b95:675a with SMTP id d75a77b69052e-5165969f747mr37235581cf.4.1778833416407;
        Fri, 15 May 2026 01:23:36 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm39711821cf.18.2026.05.15.01.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:23:36 -0700 (PDT)
Date: Fri, 15 May 2026 10:23:32 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating
 bytes to copy
Message-ID: <agbXyglnfDrtKvAv@leonardi-redhat>
References: <agXKLQjMytKNo3kZ@leonardi-redhat>
 <2026051539-residence-unspoken-abff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026051539-residence-unspoken-abff@gregkh>
X-Rspamd-Queue-Id: 77A6954B382
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247474-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 07:55:57AM +0200, Greg KH wrote:
>On Thu, May 14, 2026 at 03:25:29PM +0200, Luigi Leonardi wrote:
>> Hi stable maintainers,
>>
>> I'd like to ask you to include the following patch to stable:
>>
>> 080f22f5d30233faf3d83be3098f35b8be9b7a00 ("vsock/virtio: fix MSG_PEEK
>> ignoring skb offset when calculating bytes to copy")
>>
>> This fixes a bug in virtio-vsock, that leads to an EFAULT when the user
>> performs a partial recv followed by a peek that requests more bytes than
>> are available.
>>
>> Please apply it to
>> - 6.12.y
>> - 6.18.y
>>
>> 7.0.y already has it.
>
>I don't see it in 7.0.y, what commit id is it in there?
>
>thanks,
>
>greg k-h
>

oops, you are right :)

Thanks,
Luigi


