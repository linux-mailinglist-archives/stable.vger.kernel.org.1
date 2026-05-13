Return-Path: <stable+bounces-246839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBXDMzpwBGprIQIAu9opvQ
	(envelope-from <stable+bounces-246839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:36:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407F5331AF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D6C930EA279
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549A7413256;
	Wed, 13 May 2026 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtVqRHLL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQul7vk7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576C40DFD9
	for <stable@vger.kernel.org>; Wed, 13 May 2026 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675654; cv=none; b=u7sHB8Ehn4PqglKFnbGMqRZuQ5tx+BTfeTX9lWPoBO/TQCPhBdKuIQdbCAdi9Nv72pPwZatLuRAcwAC3dxEZyTwPRHLUkCn9Ywdskt41cNi4o+FLlN5XAoaZwBUtotew4N1qwJksPg0+NKGrBz/BgAAePhMPnOLpBBKILYc1EQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675654; c=relaxed/simple;
	bh=NL+0hN7dcmk6reTk4fWsx9HcPciA4cyloazqc/q7UAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZwZxw7wSzXa9ZX+wOtvLAX2fIW6doD2ZBJpdPOhO+5JMVn/cbKhv6ERISf6FMB38u1qBTdmsrlhW9a6csuzlbm0g5fac0yxldfuWO9AESTnZSVqopX/8poQ5bWaEUZuBqgvxAW9uUsQ8bTIEGcD5phZiQcF2QKykMb+D83PPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtVqRHLL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQul7vk7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778675651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TQYbXlymtDPWPBG8UfeNdlqdxdWRntP15VStFgg3bs=;
	b=ZtVqRHLLLMv2lTz4+00wowQOafMkNeUr1hRUbXjgWfaww4krp8zDPRtzrGKI/2u9QkyAGk
	DZRdIMnl4TO5XjKqCM6HOnzWBFC34hfPPMo4qOSo7s+JbnxtRxXoSdTOQenFmOY8QdbSVv
	kbq0d+1rpVS+pHDaJ6yZFcMgX8o7PDU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-5sBK9rWoOd6nF2bMjb0qPg-1; Wed, 13 May 2026 08:34:10 -0400
X-MC-Unique: 5sBK9rWoOd6nF2bMjb0qPg-1
X-Mimecast-MFC-AGG-ID: 5sBK9rWoOd6nF2bMjb0qPg_1778675649
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-441243ba35fso5323869f8f.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778675649; x=1779280449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TQYbXlymtDPWPBG8UfeNdlqdxdWRntP15VStFgg3bs=;
        b=KQul7vk7gnprAc7o8Q3+gzsCrfnHiqDNRSnTvHRCxMlPZub5CGxM25awlN884eTyV9
         JlcQo4PrCgQ2LGPZcmReJoTLXgWZdMYaVAS44c1/wFP5/ZxqLmbsFK7RMNOEx21LjTC1
         7MGLOq5JY2X0ASViZkTs8t6rNRDN54uLkzBcH2q3enIuxMRrXw65yoJMk9waj7lvm4Y0
         7naULKpLKW0m7ZLb1wXEYJXldzGi+wf4UhP1tu5g1PTkrMw8xcF1PzD+RKHQJWlYjjvr
         PEOF635ZJ8Y13JUE8Z2Jc6Lc76Pph/XC+QgGwPue3NM5s54pIynqfpvtnovWCqOPlo5a
         FBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675649; x=1779280449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TQYbXlymtDPWPBG8UfeNdlqdxdWRntP15VStFgg3bs=;
        b=LLUp4vJNnhWOMuBreU4O+WEThSrVp0zfHQp31eLDdIMQksSt9MYzef0UVvIeUYI1SE
         qVQ3FVJ5lmghIAcA9oGJBoGl7QGBIdzU9M6gD5anfngfEZN3GvQpJ2jST7UJJ5LmcunG
         sVo83u4hO6+7Vq0N8vtWj5pPgiOh99Y7LoWU+MgLWA/ZMKxNAqy8Bq5o0ElVLLnq98h8
         gF7SywhIl8OIi3ujNKVOD5cvYY2hR7NNEEYrA3AUcOMzwNpZOX5RxddRNAA93JzNlLOC
         ylun2GDWfL6Rtvm/eprWEFgF+ows4Hd5f77Y0eNmf7/eQss3NeyihqFC2hcH9mIa5kQw
         8ChQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ApDR/MRMYiRr6qtOPkdn7j+7n5EY953xJ3kODPM3yLeOVGlJEzxZ0vr2Yuiz30y+QtWldMXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKimqOOSdpO66JZ7n8c3Cw/S5FtOdWEDt7u0TW5JZr39uABv3A
	VsV+4Bxy17JTjHIrE5u4m/b8xTgDTUkjcZwmGU9zFNMY9PhIZsZ4/dNxY+vXeI/Mw870nRs/9pk
	pba1/sf9BjWI6AgF1/RfPMs3aPXyZxPHKPkiqtPFekTautl26DYHH/NY8AA==
X-Gm-Gg: Acq92OGNUdvdW0KebVGW9Vrb9eRrtFiyYTA8Ou+NGQcmq5cmLTQ8boJKh30aMzPpWmp
	2UF8xHzBUDMkGC7nD/m8cWK6zD1klSP86PZF4wBcHP/q6eLGp31XmhB1iAhbezuLYRAXKgYRazK
	7nE44DYNodP36AZaE6DHXPXxVgI9g9DS+FI9Vh4kjjhYsQIklPaJvPfiu7DAZb3zBdqGA+GfK06
	AjVkotVu/iI6Q2lLASeLD6Wq/JiXXoLQpep2Cnx4cw1cDKbIgvgbTbwq7NlEaec5bbo/2XBTBXQ
	0th/6dTYsHZc/rt1PknrecyNaS3Te+2gcD48dfN6Llw4ANrlkOZXPfOf1B54D47yw7+nYvZwqFb
	slCC8KiKbQTY+EvsBeI4ibcQUNfBWsuzXgjY3roJV
X-Received: by 2002:a5d:5d87:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-45c59cce4demr5115647f8f.37.1778675649236;
        Wed, 13 May 2026 05:34:09 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-45c59cce4demr5115580f8f.37.1778675648751;
        Wed, 13 May 2026 05:34:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c221sm41530491f8f.13.2026.05.13.05.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:34:08 -0700 (PDT)
Date: Wed, 13 May 2026 08:34:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
Message-ID: <20260513083332-mutt-send-email-mst@kernel.org>
References: <20260413101759.6323fb68@pumpkin>
 <20260413122244.534-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413122244.534-1-guojinhui.liam@bytedance.com>
X-Rspamd-Queue-Id: 6407F5331AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,resnulli.us,linux.alibaba.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-246839-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, Apr 13, 2026 at 08:22:44PM +0800, Jinhui Guo wrote:
> On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> > Or do the allocate before acquiring the lock (and free it not used
> > in the error path).
> 
> Hi David,
> 
> Thanks for the suggestion.
> 
> Pre-allocating the memory outside the lock is indeed a good practice,
> but unfortunately it doesn't work in this specific virtqueue context.
> 
> The kmalloc() in question is not happening at the virtqueue_exec_admin_cmd()
> level. Instead, it is deeply embedded inside virtqueue_add_sgs()
> (specifically, in functions like alloc_indirect_split() or
> virtqueue_add_indirect_packed()) to allocate indirect descriptors when
> multiple SG elements are provided.
> 
> As a caller, we have no mechanism to pre-allocate this indirect descriptor
> memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_add_sgs()
> needs to atomically check the queue's num_free status, allocate the indirect
> table if necessary, and update the queue pointers. All these operations
> must be protected by admin_vq->lock to prevent concurrent admin command
> submissions from corrupting the virtqueue state.
> 
> Therefore, allocating before acquiring the lock isn't feasible here, and
> replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
> failure) seems to be the more viable fix.
> 
> Does this make sense?
> 
> Thanks,
> Jinhui

it might be quite ok. what is missing is the analysis of whether we
can actually get this error and what happens then.


