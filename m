Return-Path: <stable+bounces-253558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL4GBY4LD2omEgYAu9opvQ
	(envelope-from <stable+bounces-253558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:41:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B587F5A61AB
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 802C230C0B7E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB93D6CA3;
	Thu, 21 May 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpUMZloA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7kYKOCJ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FA202F70
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369377; cv=none; b=O+euRJ34Aozr6ux7CQwfGUJnO/36hA1ryVlx6hQUsrbheCVcWzW3jtY03I23y6tBO4l2g/cYKWKgsJ3htpyR099p7FbpOJPolahdaI0VJCy8UzBB4rqc+96fsRjEuQCK8wzyptadz/TYwXKc9cYFSmaY3TyamcS8indds4uSOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369377; c=relaxed/simple;
	bh=C/yq6jnVx6xy0u3cZDQECiEbThOLiWr86BOsSowwW1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a29qN7TS3H4AYdFe9j3Pn5FBWXUpzSxkPRJljTR7FzRm5Wbq9RI6NoSNQae/Zu9M4a2uIXAIVqBKnqFSDL5g8eR3FWHu64kshymJp1Hmrv5cz5NTsERv8vEGmfqmvKdImrcd3GNcTxXHcYtTHEfuk5JVHQW8f0ZeTdlEkniE5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpUMZloA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7kYKOCJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779369375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dh4jGIyaM+m+wkuHxmldgBlU9wnieEbvJbfFxAyJXTU=;
	b=KpUMZloAqh+DHxe8EtzA7AYxLtLJYKIsxCLKgrT9Tbx+HF4FLBMGWqCnOTSKpkD/s97w84
	bCAHnSD2QpCpVxcF2mhsOUeKvA9/rz62K4iWR94+TIu+SG/N4xXEeKGYd5YTXCeXOn1i6L
	OBaUXo7/cj1TnmoCEfFx6XHdvTOIUSU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-KAHwNrzjOBKGUTW3aQ7saA-1; Thu, 21 May 2026 09:16:02 -0400
X-MC-Unique: KAHwNrzjOBKGUTW3aQ7saA-1
X-Mimecast-MFC-AGG-ID: KAHwNrzjOBKGUTW3aQ7saA_1779369361
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48eb0da933fso44012895e9.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779369361; x=1779974161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dh4jGIyaM+m+wkuHxmldgBlU9wnieEbvJbfFxAyJXTU=;
        b=G7kYKOCJq8razAq7Ng7e0V0xC6PlYw0y1ojaALhiwBsjTa08gy8goqYHMBmrdZqLbu
         8FGXkiq4ORoj91W7+McCJkbC0EfBA9QA0tr9h+AHbuTlXLFZEu89D4fEi2F/Qt/qnAax
         PjOjDWV3GINBZj0FjKESbrn29gldCmjrS0zypCU0pDcSm4uHcp+2/jPzG7pb60Jv3y5W
         iTNWcMNVBltkgJg/8wbvM+srDKGfGW5I5WZmQbeGnoblPwTjJSkdZGZEJR6YvwzPSCrU
         OMsJFQD6PhhycUH7j25Nl3xP3+jP3yVtAUhc6Fdk9eVvwk66RiD66pRM8YQ7zOePqGdn
         C1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369361; x=1779974161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh4jGIyaM+m+wkuHxmldgBlU9wnieEbvJbfFxAyJXTU=;
        b=T13Gs9WJyPiksXeUckQBtB2crFfnPefR10iRu74GCJ8BqHiYfNCCuFp1jzQARUnbjb
         gaOO+oO8CcMxCDTQfP47dVU6z++x0P13fTXJE5X28RuOch9YnM+Xp/w3nAK5sx+T4zqU
         R5JeE5Yk3tBjl2aLzm1OgBty8VPQvwXOF0qVKYE4ig1hdGOZLEUt5dU7m8UMlWDXOwH/
         4a6m/fNmp1vxUhVCa4w9izCIwyPfbmPMb5z3sbciU6rhsog4dNr3tR/6QY/ptzRTnT0H
         MYZ3+7oaELOOgFv7asVoCmjphgr4OOhnjgQ9TpbYisBFmAossc84phin/uWaVJArBrDt
         TvVg==
X-Forwarded-Encrypted: i=1; AFNElJ9E3xBUo3dyLIjJu3V1lMD/CXRFKsMI8kjBw0rc40jGs5a4P6cKzcGypDYGL6LekE7rRNclsfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeUJbJHptfno1qY0amK1tYR/tv16BZFKTi2H6ptPGOczNoL8v
	ZePJ6Th1LihocuJgyuVvKWYFdpIoSmYAl6oeA/pWb6bfzz3DFXYzFCnwVUj22GoQkHMIF7/RGkT
	BI8Xx+HjV9I0aW5FyWwwKUBkVfiRjRxaz2yuqEDWbyPI3vA2bXKAq3vRP5g==
X-Gm-Gg: Acq92OHN3Vf1gRTtKZbsBULc4/2WkKjnmwmgxrAnQfNC7asM8s2httnlHIicvDlXbAH
	6JXNg0bFhYZ/rDI6EaqM2snLkDwyCaZ33j7EBDGVUOSO3UYukV2CvZuXqR5QOaPYIIRia9pHsGD
	41VfrhbCoRntOQ2lv3oYUXoOFrbQ/rGvE8eRvTEsoYq6YHxbLvJdoUJhg/Ejagt/6XBeR7GgTx6
	K6AsA9oA9Uu4j+4hpXiTG/tBheqSUf9ODE7ajmzJHLfJo4sCKQQ9L3BhOZTfsB+tgPjc8oN4XLO
	VUMcU3nRht7sJBEdsYUMKi1tOpgqthwm2B3NmzcqnqKin9KzmXaScRuu50bIPye/6/22OVltyNw
	okLTlyD8BWTOLrRO8XPhULEha5RjwDzKLFO5qMJjvlP5HTWFN1jhPofh1TH82tfmfgzLLbIv0tA
	==
X-Received: by 2002:a05:600d:2:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-4903606b108mr33413575e9.12.1779369361145;
        Thu, 21 May 2026 06:16:01 -0700 (PDT)
X-Received: by 2002:a05:600d:2:b0:48e:8741:fd42 with SMTP id 5b1f17b1804b1-4903606b108mr33413015e9.12.1779369360634;
        Thu, 21 May 2026 06:16:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903c9b004csm16148155e9.6.2026.05.21.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:15:59 -0700 (PDT)
Date: Thu, 21 May 2026 15:15:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, AVKrasnov@sberdevices.ru, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <ag8EvTp29B-Q3nCq@sgarzare-redhat>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253558-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B587F5A61AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
>> > What's the status of that fix?
>>
>> Stefano posted v3 and is working on v4.
>>
>> >  Should it be reverted elsewhere?
>>
>> Donnu. With the change we have no DoS but the socket gets silently
>> broken.  Eric felt given the brokenness is upstream already it's better
>> to work on a fix on top, not revert.
>
>Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
>follow-up once it lands upstream.

FYI v4 is now merged in the net tree, so I guess they will land upstream 
soon. I CCed stable on both patches:

a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve 
full buf_alloc")

Both are related, but the second is the main fix of this patch.

Thanks,
Stefano


