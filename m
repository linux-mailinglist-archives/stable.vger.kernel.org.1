Return-Path: <stable+bounces-25963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE19870929
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 19:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9311F25AF2
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B784161694;
	Mon,  4 Mar 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsAxXzqp"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CE26293
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575865; cv=none; b=MjAGf6W2mnyMfe4vjZakn/J9cKBjk6UihNAcrwUWjXfVXJK/dGQM9927F/KB/Ph97TeGUhbPHXVVOrGEFpVSRZve2OsJGSQP7EIdch0Y89JFUVR3PCgTgHd7ofaM7TJU6H/E39UNf0WFvOlo1wrykqNQ9sXkSD33Cav6rFVpweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575865; c=relaxed/simple;
	bh=QDfjMQLsmoQV9whVS6EtT0rI0dUCVR3c8WPsksawmjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkRXUcazE4BZBmkqHB4q/4mbXwiKkaNSiJMVYGKcjI73dFnXQ9iJ/tLukWpfqF6mBD2nxPwAN8fL2oDq+XGOjbVICLYOgoaHYlCIcMRuhvJ8+MUBHRX8Szi6sUSWkX1NQUI3kJz0HicUYRo0gQDnbOsY4LCV7kIYVLdBjeA7JsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsAxXzqp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709575862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBjepeaDd7+e3s7rKO9VR+CPderTVwZuDQuLnzWRm24=;
	b=CsAxXzqpvOa9T3bTwzIdITDQIkx9jtaskw0q9oFhI5hqnRTwuvHvjKH5/2HPZ3oZDxGnxN
	NJEr8hc35OOuXefkqm2qpCahlloooQHW+tbimr3HNdSO1m8D2byQR+UaTU288hV3/ehEhb
	X80AqNZ9ngXhl6JOvO7/tIfeNpk+yjs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-tgOZhJ-lPTyMCVyUN2gS3Q-1; Mon, 04 Mar 2024 13:11:00 -0500
X-MC-Unique: tgOZhJ-lPTyMCVyUN2gS3Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-566ae32611eso4380895a12.1
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 10:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575858; x=1710180658;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBjepeaDd7+e3s7rKO9VR+CPderTVwZuDQuLnzWRm24=;
        b=Tck95yzO+ZF1GJkDs0H3J5HFN9s5qVg+JLYXySzluRDxEcjlvNwshBFh/ULuyk6BT6
         w0AjocQCgKMbqEe+DkcoyLaUUuF7ZdYIxkrJsfikrRyVJnTAR4vVsPwJ6Btl3gOq6avj
         S9HRfuwOqO3hFiWIa4keAQMAzVdhnPPmW7s5+t3lCyQvuRJP/VZApShs1Es97OgaD7XU
         rvBxjO08d/kwJYcJJ74KZa4LhKFp0tNWuSvYxbw14rVk4AEvT/+lQRsHrelFgOcg3WMj
         H8hGerMM+jhQBY0N/ulB4F5yMxtU/NVF6Bo/CPmeN4GXwIViYTQRJDalXv3T00PThrI9
         HQVg==
X-Gm-Message-State: AOJu0YzwNP1JlST6eqT5odmvscrT1vmW7LcC2kfV8RNHSIxGTIUrsI24
	X6YZxtjIuWTFSn7r2NdeT78lr6ZnEfSqAxWECvYRfBO79zZUK0UAIY2H06GmL46qkpYHL3DAH6w
	wzdeOhsFWdZyXtb9zAt/qUt9dhbwgbKNcaR5zR/Ra4+K8g1f0YYCt2q358PNPNg==
X-Received: by 2002:a05:6402:12d6:b0:565:4b37:4578 with SMTP id k22-20020a05640212d600b005654b374578mr248027edx.14.1709575858256;
        Mon, 04 Mar 2024 10:10:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3t2S0aWyhJ/v1zCmDqncy36MkHWOfwiyAhlwadf3nqgax2jvehgYnODUkmNZDIdWTKSsqoQ==
X-Received: by 2002:a05:6402:12d6:b0:565:4b37:4578 with SMTP id k22-20020a05640212d600b005654b374578mr248007edx.14.1709575857934;
        Mon, 04 Mar 2024 10:10:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7d34d000000b0056486eaa669sm4910231edr.50.2024.03.04.10.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 10:10:57 -0800 (PST)
Message-ID: <4a3dc556-d7f4-4741-ae5b-6722bd2ce1c1@redhat.com>
Date: Mon, 4 Mar 2024 19:10:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable v6.7] drm/nouveau: don't fini scheduler before
 entity flush
Content-Language: en-US
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>
References: <20240304170158.4206-1-dakr@redhat.com>
 <2024030448-basin-grit-b550@gregkh>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <2024030448-basin-grit-b550@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 18:55, Greg KH wrote:
> On Mon, Mar 04, 2024 at 06:01:46PM +0100, Danilo Krummrich wrote:
>> Cc: <stable@vger.kernel.org> # v6.7 only
> You say 6.7 only, but this commit is in 6.6, so why not 6.6 also?

Good catch, I was sure I originally merged this for 6.7. This fix should indeed
be applied to 6.6 as well. Should have double checked that, my bad.

- Danilo

> 
> thanks,
> 
> greg k-h
> 


