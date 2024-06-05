Return-Path: <stable+bounces-47982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094F8FC740
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B721F23665
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3E18F2F7;
	Wed,  5 Jun 2024 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="OKi2oKjX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36B18F2D6
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578575; cv=none; b=HL69d2e/d3yauj8pIvoqp7pdU+eOZo83Hiz4N28iD9fw0bXESLpHl68NfXQJyQLUIL0T5WRDBTOTt/m4mta1LMY2OgHGwij3WqzvwIltgHJAPcx9VCJ/G2kZrSyxllEetoKAy74+XSoeefSE8z4qtt2L+W+dlf1wiwunxJVjrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578575; c=relaxed/simple;
	bh=H/xOWZ5L4n5xAiHYw2Q4KfjoBz5ywAXTZXlV5booVn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leGuhfJ2N98p61DUKWS1kh1sL21ujCVz4qhZ4gb5Kgcilu1mhcglvJs3Gmww+xHr0fuK26ppRspK6KLI3aR3p2XDghFIStKqRC/3WDPnsD1y6VQuiJpCaUaPkjyNo1ObbMXbSDrJf1siIDkbSeZkc1k1dLxXJkUMdaA6EycyXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=OKi2oKjX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35e5604abdcso406374f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1717578572; x=1718183372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+UmpGA+ZeMi4kfohJdgrNuGbikeEYkKaVXbYI+HeV3g=;
        b=OKi2oKjXLSiCEhQQMwK0i7lhWxpjwASPfPZgW7c4YOqDsBzmmYXOG7z/j9M5DMloir
         9iYZRfgkWdh3umQWcUCD9K1R1cu8Si56viYGGqueGGsrYf71OfOOa01ZSb661WZohyZE
         omGrhlLyufgkwA0SP0zK0t3SP7YFP4ACq67ZMvSOln3xoV1YqCw9TDGh4CZKbSrboACR
         +AsTJBx8i+4WidyJxyqTEAPNBNEadkV5bDXMYrEvE99EkqYru+JcBtxOlmKaDw+07kxG
         VyFlHmWVpoDWOXoqv9G8CMiRzacPPX+46HhPIQBx/vi6p1CayiQhCoajpVbHo9g+UOnw
         8tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578572; x=1718183372;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UmpGA+ZeMi4kfohJdgrNuGbikeEYkKaVXbYI+HeV3g=;
        b=HXfiS9uZi7vnJzBv1BKInxvSWiX0AwsZP/1SkA5/kfgGoPNsk1eqoNfovwGHgTEBeL
         IqLUN8Z4oFQ6R8HXwvZuyA2uXZAfdIviyL7v2rIRVA5gsE0M70zyN7mRWJNICjRhB+JT
         2tKWTNHcbJ1fJPXpHQVyFyRv09aWf76gkE3ofnu4hbpA3opdaBA7TJcaSv7JoqmMyoBC
         ayhL/UH8qEuGFz810iHqxcsdw67a3RC1xGh/oTmtOd0bP0JVzh/8c71HLADeeRrLPyFR
         J555fJSzX7pA9pCB6g7WeQ3LHg+EwBX3YVnhDo/BLKQQv+11cCHkZQiKfqjgvfNPZd4X
         JpGA==
X-Forwarded-Encrypted: i=1; AJvYcCVXQcUNUisSGOkiG4gnfdHKX1DicdhIzYlCOvJGDgnfe26jl2X1av3agI2J3c3mxftPsKc2sZ90nCUejmEJOTordlKlR/LQ
X-Gm-Message-State: AOJu0Yx/PTtOCq4Xi8uwP3If5gaGwBhubaMFxdO7s3HVAb+jSgsM0EEo
	BPvdq9iWtfJ+m19ijBgt3vi2iETnBmjUuc6G4nm0ms8zfcXagoMZ4L6knC6XxY4=
X-Google-Smtp-Source: AGHT+IGigeZlMKJ5xlsed0h4vjvUJM8+w/gb50iEjVMBFpz47EWxxpTlL+2yqiHfs06YqiZSo8wp3w==
X-Received: by 2002:a5d:460e:0:b0:354:dfd4:4f62 with SMTP id ffacd0b85a97d-35e8395b176mr1559128f8f.5.1717578572641;
        Wed, 05 Jun 2024 02:09:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:a705:b9f1:ebc:16a5? ([2a01:e0a:b41:c160:a705:b9f1:ebc:16a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca434sm13841259f8f.30.2024.06.05.02.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 02:09:31 -0700 (PDT)
Message-ID: <c527582b-05dd-45bf-a9b1-2499b01280ee@6wind.com>
Date: Wed, 5 Jun 2024 11:09:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH nf] netfilter: restore default behavior for
 nf_conntrack_events
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, stable@vger.kernel.org
References: <20240604135438.2613064-1-nicolas.dichtel@6wind.com>
 <ZmAn7VcLHsdAI8Xg@strlen.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZmAn7VcLHsdAI8Xg@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/06/2024 à 10:55, Florian Westphal a écrit :
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>> Since the below commit, there are regressions for legacy setups:
>> 1/ conntracks are created while there are no listener
>> 2/ a listener starts and dumps all conntracks to get the current state
>> 3/ conntracks deleted before the listener has started are not advertised
>>
>> This is problematic in containers, where conntracks could be created early.
>> This sysctl is part of unsafe sysctl and could not be changed easily in
>> some environments.
>>
>> Let's switch back to the legacy behavior.
> 
> :-(
> 
> Would it be possible to resolve this for containers by setting
> the container default to 1 if init_net had it changed to 1 at netns
> creation time?

When we have access to the host, it is possible to allow the configuration of
this (unsafe) sysctl for the pod. But there are cases where we don't have access
to the host.

https://docs.openshift.com/container-platform/4.9/nodes/containers/nodes-containers-sysctls.html#nodes-containers-sysctls-unsafe_nodes-containers-using


Regards,
Nicolas

