Return-Path: <stable+bounces-126787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35061A71E67
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6247189AB97
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951F253F1F;
	Wed, 26 Mar 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMxHxT8A"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71478253349
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013623; cv=none; b=MHNXVqdGfozhcjb/11ZrVv1N4HFHNiSzZ3USNWp3yihB8GQlwdmCSNvad/NBuBV334ado3/c4Sz4g2Rl54TcB7yw8+s9a2dhyvx7L9XmDcscj0A6Q3pyv8OtyHP2GhsDnNN40tDZcc2e2nLZqGopluzY0IHmhUJPM980P+2x06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013623; c=relaxed/simple;
	bh=rjqzotPitDbSi6AMoocqz7K3keGzhX35QvWXCskJ6fI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OuF8cIqrikJUcdml1YHwOOLKJs3vl5sQl9rSonp74qDV3aSnshng7zAmdXSRY0A23I+jBs1FfJ2ODwxl/xKz+ZO2fuXz7Sje4uLwITtZlDl7unOUh9i7zoMpJS57Rx0Il3uIuCNwTxQr6rdmkge38kLpiXVuVUdp/TTriJ4zfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMxHxT8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743013620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RD1tduM0JJrmq9tfzMhxIULme7KP22Adkm/XMP1vPHo=;
	b=BMxHxT8ACDAgw1dotUkgzfnx5Hhw8y+lsHjv14ELazVTQDS2YRp6tUo0eF+rJ6D2bvIc/c
	1lTik50rAxG/5HwwHn5P3fFinGLNruoFjj0soswzKc1ogDhIAMqkgik8TTQrNCxnmSe0gr
	GeGMnB5Jzmqnp5PTpmQ3b1GE9+sL8Ck=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-gEQCXuqUNEWhwVYCD8toSg-1; Wed, 26 Mar 2025 14:26:56 -0400
X-MC-Unique: gEQCXuqUNEWhwVYCD8toSg-1
X-Mimecast-MFC-AGG-ID: gEQCXuqUNEWhwVYCD8toSg_1743013616
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85da19887ebso40936439f.0
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 11:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013616; x=1743618416;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RD1tduM0JJrmq9tfzMhxIULme7KP22Adkm/XMP1vPHo=;
        b=lIi+kaJWXvwgUGfF3WS99oCECq/xwo6wFqVUyLICvZrk1lkZu4HzaNvqccFhc6dN7z
         0nkw0LJW1vXyGGIzQFqWqBGLA9MJcaBRay6wid+5kdUW35FCcQ7GqWC4FOoF6cAh1Nr5
         8ddfDG9nxh9t3X5fcQqCzs+dUk87LQT+xRWYDAS8uTdp+Er9xveaOmEGeToGVFZ5pa2g
         O/lGSD79GJ7FtvNHLfhGECLxyX+kW8Wnvy3TPEH6hVc00Mj9KZqXl+Rbi2rzCgSr69mc
         1rJL3A3ZpNVu1w0qFEZHXwKvgj8nAvFiyk2Fwuzn7mBY2p1nGliHM8Y75xEIx1Vk/tKF
         gGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkEzsvN7VKs8LWWYx8mGULqi3g72mPBYZucz+K3mrJngKjwc6wVbYhRzLjBoH1rlpAQ9Pels8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBF59+JkSlYvuLknT1r8Gw1phUTvY3JehQOs/QlKNeKhdUMzS
	ztKf4oRK2EavNARvlv6aLJLSVRcfKpqCVbzTOTeWOaUL1XoV7EKEBRlnP+Yc+2IgDWyBztc8a4I
	n+ncyPIiN9bN7lcohdvb7S8RIt8rrbxIiIm3xaAeSL3vNq7aBHIp7TA==
X-Gm-Gg: ASbGnculw1QxZS1cWnvkRwsoVYtVUI4uIBSn+3IImCmgTCjvTvS4mSBFjXdu1VkF8G7
	Nx5yslNbnH4dn/jsO0VZhzBuoLUeJc2gCs4ebTt8uKcM/sCLIMg5XxwkwxE2YS9CiH7UVXvmPEY
	vdc/gBtbBiO0n9fTzTGdUCEw9hbJkmc+RbOxh8HHYGuZh/cLWFNNUguZK/NsJpmHdmoYb4l1rH+
	kEto1rYhKY9n669u+qYUhDjc55WvxIcI+LhWSJ0oNHwe79gB8UVMSE728U9azfeooeJPWtRwVd+
	ytSzcDfOcwuB7gp2qs27AODQzUAI2TamG24HZOZdiFBliWz40UW1ad1fdDv92g==
X-Received: by 2002:a05:6602:3f08:b0:85d:a5d3:618c with SMTP id ca18e2360f4ac-85e821415d9mr99696939f.11.1743013615978;
        Wed, 26 Mar 2025 11:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7giVwJxWHhd8d6z4Js/FPx25T/j6DcERtcIBtPbM3be5/ybdDEVBhZBGciMSfyOBbMrCpQ==
X-Received: by 2002:a05:6602:3f08:b0:85d:a5d3:618c with SMTP id ca18e2360f4ac-85e821415d9mr99694639f.11.1743013615549;
        Wed, 26 Mar 2025 11:26:55 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb3b79sm2938719173.1.2025.03.26.11.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 11:26:55 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5f02cf04-74bf-46e5-8104-a62d4aca2bfd@redhat.com>
Date: Wed, 26 Mar 2025 14:26:53 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking: lockdep: Decrease nr_unused_locks if lock unused
 in zap_class()
To: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <20250326180831.510348-1-boqun.feng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250326180831.510348-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/26/25 2:08 PM, Boqun Feng wrote:
> Currently, when a lock class is allocated, nr_unused_locks will be
> increased by 1, until it gets used: nr_unused_locks will be decreased by
> 1 in mark_lock(). However, one scenario is missed: a lock class may be
> zapped without even being used once. This could result into a situation
> that nr_unused_locks != 0 but no unused lock class is active in the
> system, and when `cat /proc/lockdep_stats`, a WARN_ON() will
> be triggered in a CONFIG_DEBUG_LOCKDEP=y kernel:
>
> [...] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
> [...] WARNING: CPU: 41 PID: 1121 at kernel/locking/lockdep_proc.c:283 lockdep_stats_show+0xba9/0xbd0
>
> And as a result, lockdep will be disabled after this.
>
> Therefore, nr_unused_locks needs to be accounted correctly at
> zap_class() time.
>
> Cc: stable@vger.kernel.org
> Signee-off-by: Boqun Feng <boqun.feng@gmail.com>

Typo: "Signee-off-by"?

Other than that, LGTM

Reviewed-by: Waiman Long <longman@redhat.com>

> ---
>   kernel/locking/lockdep.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index b15757e63626..686546d52337 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6264,6 +6264,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
>   		hlist_del_rcu(&class->hash_entry);
>   		WRITE_ONCE(class->key, NULL);
>   		WRITE_ONCE(class->name, NULL);
> +		/* class allocated but not used, -1 in nr_unused_locks */
> +		if (class->usage_mask == 0)
> +			debug_atomic_dec(nr_unused_locks);
>   		nr_lock_classes--;
>   		__clear_bit(class - lock_classes, lock_classes_in_use);
>   		if (class - lock_classes == max_lock_class_idx)


