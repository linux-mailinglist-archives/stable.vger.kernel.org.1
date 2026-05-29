Return-Path: <stable+bounces-256640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ6DDy6dGWq7xwgAu9opvQ
	(envelope-from <stable+bounces-256640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:05:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A7603416
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA113311D217
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4643DEAD7;
	Fri, 29 May 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5CbpKTK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E63BB13F
	for <stable@vger.kernel.org>; Fri, 29 May 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063190; cv=none; b=ILNljcjcwcGGy0+qI4SZ0v1vD2xYx1kN6BqB398ddsBX+K4T1bTpMNe03qitL2lOecro1zgPw7eP/tLmNfVHzU9A6XOLHN1bGUmGROjGLoiBxS2DoVV+kOTWovUzU4NHE/JoBKq9NYYagnJPNusOXWifV3jdlqQilohQPtf/9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063190; c=relaxed/simple;
	bh=KYVlRd1aquTP3bMRf1yqpg8Q8zkl/MFBUrtYhsbb0b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uq9jHpMbir1nzbt7YexWNaGgm1JRZkODao1GRWgUbnxf7dMXSUa5bVOv/JB71WGMa42Mi6nzv6/+Ugv5tg3abQ04FzFOLT3c6WTb9pKq/Nk0U86FrO4GnXt2DPLNKRylYdYdBGoOgHkuijJFV6xWyegyrb98Ki8UQf0cq3Sdv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5CbpKTK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490227b682cso7168215e9.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780063186; x=1780667986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5MBJ+x5az2tq5WcU9vWA3tYOf7P2ieIA9xjXOxXWIs=;
        b=S5CbpKTKucfo8HNm5fURinWau6BF7wBsryw7Hc4eXGO4cDX5ZYYRqvGMo6yM1UdYSN
         yGWv9dZ37cpre8Xo+xvTr3IfLMGCOw4Z8ZvL0fL4S+fj9re8EogSqBjnkKReV6IpCUtM
         G+snvZz8HCpGrfqzL9Q1QYptrJPb+5XBzM9UonTuRnUfn8P9biR/ayP7FWcHZsW0WxIO
         XRQCGVvK1EedoynXe/lK9p7JnUI0Y/dSAra9R4MQhBX+wEMvS3kw/VTWsy+FYQzs7E89
         jeM6SVey1P+8WcYf2kAX2kAjh2J67SXkbVSka35C4aku1qRd94VCzjLinlnS94Ujar35
         78/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063186; x=1780667986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5MBJ+x5az2tq5WcU9vWA3tYOf7P2ieIA9xjXOxXWIs=;
        b=H47WYiyQOAVH6WCg40phV636QwH6Pjk7VPr6xpsHr+PifJ6bPHYs8HUTsBW60iG2/E
         wzmRj3grScptkE7dnwOTOWNn+wf40TAvvPISb5il4cL/OSdV3dJMk+QNPjAO8CwWRGuW
         kVk7PTPfgsbTIidB5XDt2ENa02U4i1FPwd6+F1gmkUtTRW7fMlxBrZO9ptY4IJ9rhifm
         V0rKlvSlTd6LA2d/pOETGlJMwQD5yqrFYw/WdGxk0XEugrXN8GLPJjj0FXi07/Gat4cR
         biTauUSjJqA2VXDteETB/IbVSSF38mgrjLTQZF7Hadr6dxH9F5rgBUA8cVFy1zGjUDJP
         7foQ==
X-Forwarded-Encrypted: i=1; AFNElJ9T3bTy9QR8Xi6dzL90t/HobThwhzBuZZO3zsRNN5DvGNe3shLFzCOI1Fhze4ubnKizTQkzrCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNv+WLae6mB+kP6n0AUzkhP4wRUOhqsuxOuM2TuU8Sch3KjEhA
	hxRwQ5pLsSSsgzqyb0/5Aw7TSFd3QpC+vglUaITWgZUa33QRAJ5lPZWm
X-Gm-Gg: Acq92OEJLdYNJkjnohSChF0haw+ESjHeO80FBZXhpO1ReGa8lVOcWU76KVnF2sXDDVA
	B2kn+SfLzH9Dh3Sd0MyNJw6DwVn53FTwMffcPxP+H848lI5DO/dirlWujp+mHs3e6iwRpCR2PZR
	mk8lSHqSDqRGpvWujQB/gl7FcQGsGparLtpohs2j6JkPwyyTt4266FbxOTpxwd2/Hi3SDSqP5O4
	g9QTvnLI/Nmnstc8809pT84VyGRnTL92oY9AM700SbzzTu8XDt3LcJMFqAiMx8pl2p/luMC3kBJ
	aLQ+vpxNXV+EVvLPxyer226f/rpDaWn/4oCU90pKJaV2Un7WKNTd8kuztC708OdlNk99DeUi6mq
	QGmRFVIlodOolCdyJN2yTtkpTg202iXkjyTCwoxVMufhm1acV77KBfcCRmek6VaETfE1P8i9nDj
	UYDLELtd75sjS55DdvmO9NFM37270GQkcTq/D+xO4JFD/axbo2xVKpYxZirW07n2mn2xXWwUVZX
	BkKSAXXL1FsSMxkLSpNTD65m+U9suIbPg==
X-Received: by 2002:a05:600c:4f53:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-4909c0845ccmr21882065e9.2.1780063185440;
        Fri, 29 May 2026 06:59:45 -0700 (PDT)
Received: from ?IPV6:2a02:aa16:1105:8100:157a:cab0:dc27:cd03? ([2a02:aa16:1105:8100:157a:cab0:dc27:cd03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0c39b0sm25645315e9.2.2026.05.29.06.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 06:59:45 -0700 (PDT)
Message-ID: <a1cf0b32-1ad1-4297-a371-3807bf49160f@gmail.com>
Date: Fri, 29 May 2026 15:59:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: fib: fix use-after-free of FIB data via
 debugfs
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260526160910.1614609-1-yzjaurora@gmail.com>
 <20260527083214.GA444725@shredder>
Content-Language: en-US
From: Zijing yin <yzjaurora@gmail.com>
In-Reply-To: <20260527083214.GA444725@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256640-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D6A7603416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks so much for the feedback!
I have sent the revised patch accordingly:
https://lore.kernel.org/netdev/20260529135718.1804031-1-yzjaurora@gmail.com/T/#u
Hope you have a nice weekend!

On 27.05.2026 10:32, Ido Schimmel wrote:
> On Tue, May 26, 2026 at 09:09:08AM -0700, Zijing Yin wrote:
>> @@ -1600,6 +1597,16 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>>  		goto err_nexthop_nb_unregister;
>>  	}
>>  
>> +	/* Publish the debugfs interface only after every data structure it
>> +	 * operates on has been initialized. The files reference this
>> +	 * nsim_fib_data (e.g. "nexthop_bucket_activity" looks up
>> +	 * data->nexthop_ht), so a concurrent debugfs access must never be able
>> +	 * to observe a half-constructed instance.
>> +	 */
>> +	err = nsim_fib_debugfs_init(data, nsim_dev);
>> +	if (err)
>> +		goto err_fib_notifier_unregister;
>> +
>>  	devl_resource_occ_get_register(devlink,
>>  				       NSIM_RESOURCE_IPV4_FIB,
>>  				       nsim_fib_ipv4_resource_occ_get,
>> @@ -1622,6 +1629,8 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>>  				       data);
>>  	return data;
>>  
>> +err_fib_notifier_unregister:
>> +	unregister_fib_notifier(devlink_net(devlink), &data->fib_nb);
>>  err_nexthop_nb_unregister:
>>  	unregister_nexthop_notifier(devlink_net(devlink), &data->nexthop_nb);
>>  err_rhashtable_fib_destroy:
>> @@ -1633,16 +1642,23 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
>>  	rhashtable_free_and_destroy(&data->nexthop_ht, nsim_nexthop_free,
>>  				    data);
>>  	mutex_destroy(&data->fib_lock);
>> -err_debugfs_exit:
>> +err_nh_lock_destroy:
>>  	mutex_destroy(&data->nh_lock);
>> -	nsim_fib_debugfs_exit(data);
>> -err_data_free:
>>  	kfree(data);
>>  	return ERR_PTR(err);
>>  }
>>  
>>  void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
>>  {
>> +	/* Tear down the debugfs files before freeing the data structures they
>> +	 * operate on. debugfs_remove_recursive() waits for any in-flight file
>> +	 * operation (e.g. a write to "fib/nexthop_bucket_activity", which looks
>> +	 * up data->nexthop_ht) to finish and prevents new ones from starting,
>> +	 * so the rhashtables are not freed while a concurrent accessor still
>> +	 * dereferences them.
>> +	 */
>> +	nsim_fib_debugfs_exit(data);
> 
> Thanks for the patch. Let's try to keep both functions symmetric:
> 
> Call nsim_fib_debugfs_exit() just before unregister_fib_notifier().
> 
> Also, I would drop the comments.
> 
>> +
>>  	devl_resource_occ_get_unregister(devlink,
>>  					 NSIM_RESOURCE_NEXTHOPS);
>>  	devl_resource_occ_get_unregister(devlink,
>> @@ -1665,6 +1681,5 @@ void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
>>  	WARN_ON_ONCE(!list_empty(&data->fib_rt_list));
>>  	mutex_destroy(&data->fib_lock);
>>  	mutex_destroy(&data->nh_lock);
>> -	nsim_fib_debugfs_exit(data);
>>  	kfree(data);
>>  }
>> -- 
>> 2.43.0
>>


