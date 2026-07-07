Return-Path: <stable+bounces-272380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iO2MJiS6TGodowEAu9opvQ
	(envelope-from <stable+bounces-272380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:34:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13C719282
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:34:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="idb/2paq";
	dkim=pass header.d=redhat.com header.s=google header.b=gurIqyH8;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272380-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272380-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8624E302414F
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A3310777;
	Tue,  7 Jul 2026 08:28:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201B30BF6D
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:28:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412899; cv=none; b=idpi6fMj4iWR8DMxz/ncLiOIYilKT1OYrJ9PCVCXTtGEf0CIWSz/ChBQcG8OoLvNq0syGgEAQ6Sfmu9NYCVtFEnrAJNjEnZy2FSigXrRGYzkpd8Eh4IbLkVI1JfhCQHXOOI3EjFE5laF1Kj3l9JieuYPltRTZEvppey1TLmHcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412899; c=relaxed/simple;
	bh=WQKIs64871yUyTjfsDUxssJgvhRqui78lP2WGCaXxAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YevWbPU99m7VG7b64KLRAgucSthVPTOP9NIo7ifbG1RXVd46v5ABABuMvXAuwy1tmu+NOI3Bg43OZz4Tt/HNmjs/UW1uOwx0bhl/m62cRwmxrfbR5aWprSXU+3eZwIQUHu3fCMuT6nqCZRrfj6Oh5+rL+m5GXhs+rkeBhmCZH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idb/2paq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gurIqyH8; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783412897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJTOrChuile1dpJZ5oPmUIH4vsB4RlLW31n2flQo1JE=;
	b=idb/2paq28UWAnFC4B/mY6/V69LYhcbHpcB+txQL9AzVzyCDKq6XDDMLh7Yb7Tjlwl5Bm/
	MgzcLMZfppJNets/K6+vxu4B1OBrHeAwRlgTan1dfTNmya+qi130Be68+l2ln0fE9rkgRm
	faSb9c08BPbRzV6OiFIfdOPPnxS2dDc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-M1XBH5lXOCS_vjAsBTCBAQ-1; Tue, 07 Jul 2026 04:28:16 -0400
X-MC-Unique: M1XBH5lXOCS_vjAsBTCBAQ-1
X-Mimecast-MFC-AGG-ID: M1XBH5lXOCS_vjAsBTCBAQ_1783412895
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so41433745e9.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783412895; x=1784017695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJTOrChuile1dpJZ5oPmUIH4vsB4RlLW31n2flQo1JE=;
        b=gurIqyH8gBQgZm6J7gESgdGn5jPBM2eCc/bqA8JegxUnuCu5y9vMCxe+UTWDgXVxAd
         eV8Tjf4xzn+6dGlzYI2G47UV4txQE3VUqNAZfsDPbQ7Zoy2MnbdjS88PqQz0Ow5HmPX4
         Z16GX27b37bUoq8Boc8LQDl/2BmG6VdmjvSxvuIse8NO8bLQyqztoMdducFlX/J9H5lA
         NQ64RDPPx7Lqk2OwX+Ed0+/6/aoEPSjeUf+Fpsy2OP4fet23Q7P2q32qBw8O+mp/+ezL
         EJX9Eq1LojUxWCsglILyvZYJqbGHpHNTxKEJmrD0k9PoSMa9L865JgTjJG4v8hOyqtLs
         x1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783412895; x=1784017695;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJTOrChuile1dpJZ5oPmUIH4vsB4RlLW31n2flQo1JE=;
        b=gsMHeLIc3kkV6ZyeLgrsLIPlNuD4YxvWFHpuBGgZvIl+T+xZ6JuM2TdIVKcRQ9ijMF
         +TXpAgjQfo1s10SNYtamS2oJRIpV982uP/GDwNZ/2wc/x6HmBmyQoZpV+HjdCCsu4yWf
         heQ3hGYmrRckT0tc+WxzEgIlsevLl5LNyMkAZ0kIxFn0Vc7MR/CODGMNdAFGnv+ync0e
         rUOnGE/tHusKwYV9ec/Ap5jupvit6sdkmmJG211hQ8Uv+kNqc0EtauUEp/6R4zKIs2Xy
         uFMIdoOR9fb1m/tHzbgOTST/pSzYtG65OuNAl17IwKD1YVe0jNaAzZYvznsL56DTpR9D
         wslA==
X-Forwarded-Encrypted: i=1; AHgh+RqEEUWlAOGXzg+XJr3AFIQGladw3LjUReMKxBwNhThu4R+4WORiCh1/ENk2A9EqweiFp/A4PEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgl8jOIhXr3Dt9TGppyaWau7l+/2HmUfrXoTcfN5dydxNi4u1N
	bGNQMfuDsRyiGR91p4IoFrVAY0RxDpIu4WuB7a3QvOfa/XHWmRBAJz4u+pMyuZ+Ct9YfHBgYu5h
	AtLT0Opkzx/UdPCsQZ4TReVKJPo3ZBnH8W3CDxkTpvJMMEnQIJZpgf2epam3fVWRJtg==
X-Gm-Gg: AfdE7cmsqI80JffrftaLBVpomChZul3rrMBxYcuxKLZCRlaAUZfGDRoELZVifrMjD48
	zj5SQmPnjsHdcbWPYc8POxQGabP5scFMgvpctl2y1MA97N8/gGoVzGQv+8sQBCaUO5ctyeYvKYU
	GI68gkyBcqdRl6Rv/YstwaHbPpxy3cIgwwLQADgICYP2pFZprmawU5vpqZ0kLCDh8GL1G4ikmB7
	GOJ+waiyJ1YFsChPs3sTnPbuUTINGMH1QpqI6dILmb71e5C+F8iYatWWN520Gt66yVp1KEGxcN8
	7d2jpEwABs0h6Di9F2uSYgzzNy78qNdYr4TFwsQ7zUbTCjE9jVdME//Lbrez0gzqHDCyr8etqm0
	zoRO8obh0+e/nRZUTufwpvUuUcdTAcbj1+wlcfUQlu1MqeKB/jY63BR4kjBHXwaYA7/28v54v3y
	qCrYr2aWAHsL+y
X-Received: by 2002:a05:600c:3f0a:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-493df0a07e3mr41019425e9.36.1783412895124;
        Tue, 07 Jul 2026 01:28:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-493df0a07e3mr41019005e9.36.1783412894747;
        Tue, 07 Jul 2026 01:28:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm44221735e9.7.2026.07.07.01.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 01:28:14 -0700 (PDT)
Message-ID: <0496c117-0731-4de4-9f5d-7fdacf34bd71@redhat.com>
Date: Tue, 7 Jul 2026 10:28:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] ice: wait for reset completion in ice_resume()
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: Aaron Ma <aaron.ma@canonical.com>, jbrandeb@kernel.org,
 stable@vger.kernel.org, Kohei Enju <kohei@enjuk.jp>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Nowlin <alexander.nowlin@intel.com>
References: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
 <20260630214404.930923-2-anthony.l.nguyen@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630214404.930923-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272380-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:aaron.ma@canonical.com,m:jbrandeb@kernel.org,m:stable@vger.kernel.org,m:kohei@enjuk.jp,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:alexander.nowlin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED13C719282

On 6/30/26 11:43 PM, Tony Nguyen wrote:
> From: Aaron Ma <aaron.ma@canonical.com>
> 
> ice_resume() schedules an asynchronous PF reset and returns
> immediately. The reset runs later in ice_service_task(). If
> userspace tries to bring up the net device before the reset
> finishes, ice_open() fails with -EBUSY:
> 
>   ice_resume()
>     ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>   ...
>   ice_open()
>     ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>   ...
>   ice_service_task()
>     ice_do_reset()
>       ice_rebuild()               # clears ICE_PFR_REQ, too late
> 
> Reproduced on E800 series NICs during suspend/resume with irdma
> enabled, where the aux device probe widens the race window.
> 
>   ice 0000:81:00.0: can't open net device while reset is in progress
> 
> Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
> for the reset to complete before returning from ice_resume(). In
> practice the reset completes in ~300ms.

Would not be better to (eventually) wait in ice_open()? Why? AFAICS that
would be also more consistent with i.e. the current wait in
ice_devlink_info_get().

Otherwise why don't consolidate all the wait at resume time and remove
the other one in ice_devlink_info_get()?

/P


