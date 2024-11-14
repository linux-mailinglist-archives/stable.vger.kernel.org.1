Return-Path: <stable+bounces-92994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC19C88CC
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 12:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC3FB363D3
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5D1F9A91;
	Thu, 14 Nov 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acM5i7sw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57701F942F
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582617; cv=none; b=t+Zegmu3e15+n8gNMQdqSvSNRFEEM754+nk48NCx14cZDwvqqEy6vx2U9zP1KdYpS9NOCGD1XdR7IdWrMCPME9wl6a1uhhnihx53TNrdmWGXSmv+25LrQOtwWdqOKQSetcEQXSQnLtbbyxarlDjlfED8tz9DK/ynHf6iInw7cqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582617; c=relaxed/simple;
	bh=+PJN9W5TUF8ROvz+Dk38kDMAFGpGNYq535RDxbaJqkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms7w2LCxPbDmE7lqa8o9tVQy3CFjhrJH4k2YyY5riyMg+hSTsVL+KV+adAJSE4qBqtWlZt3iYgEJYKtE3+xoZC7OIpx/cVlTAfFryXw4tXsWN0c84kYzapKZ7Xw849VIK9gBok5LO5EVQy5kKYVPPQpxbkO+0DhaCnNmOkvAqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acM5i7sw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731582613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQSRWxbj4Jr6bem90b/I0QTuf7y4SyjrrPrHgroR4SM=;
	b=acM5i7swvXnQURnDRv9u3dRcDTDHoHabxtiN8XTB4M9eaDOA7LmeDoX2caDM0rvgZdGyJK
	S/GAf0GWhNVy5a7sQcag/++UotJUAbZ6Ys8XN8zsPns5MbwRsD226kkWFqdfqEurJ2rIdf
	ZKLETosZDjOZAZ0f3vygzs8q40GDZG0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-cq1H2Q0FPZq1Cr907_uPkw-1; Thu, 14 Nov 2024 06:10:10 -0500
X-MC-Unique: cq1H2Q0FPZq1Cr907_uPkw-1
X-Mimecast-MFC-AGG-ID: cq1H2Q0FPZq1Cr907_uPkw
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-460b71eb996so6299481cf.3
        for <stable@vger.kernel.org>; Thu, 14 Nov 2024 03:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582610; x=1732187410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQSRWxbj4Jr6bem90b/I0QTuf7y4SyjrrPrHgroR4SM=;
        b=pZM3G50fQ25zzV1DpcqA4v9FIZUMW9pCyfASZws1kX3uzulquN/JJrhUCY0/tEIA88
         uWgk8rWBUaGTn8KzgImnQA3Zumd6rsIcLkKN0KRjhtyG17AnRc85Gfjy+99TaxCB+dnG
         incXVuy9Pc8lVIO37RtWYbQ3DXVV1lIypgMdtZUPKb2tEXver3x54na39MUUeHpgBggz
         KWQdCSdWjqvtkW6YssSlrVvaOxfS1hjppwnAFAD9y136D0Yw9Km92KP6gwdhn0aB1k4X
         QP1n2GFfdlpMGY0dBnfA9nh9RI2TYTXJ0HGLLVnBjp6EuHUFwrxAnb5ilaQtUB/eAYhh
         6eCA==
X-Forwarded-Encrypted: i=1; AJvYcCWocT/qOX9OrtezYTclA2TqPblU0UDphaSMlwvIdPCilHFfiPC2Z+FhfOw0zAyV4mz0qmM1FoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPEVG90lnZMncN113hJXH66W6Ao2AE6l74VwaXUZhjJf2ZmrP
	pGBHvuC3T5epo7SV3nmyVJcgdP8ybnuVB4UJOG0Le3iS6CGXe/hWao2cz93+Cy5AypGVKDo1pio
	qB2ubilEBVeJh432a9zu/FmmCC/EM5/BS4NjNuuB+AYuSUyGHzPw02g==
X-Received: by 2002:ac8:5dc6:0:b0:458:4129:1135 with SMTP id d75a77b69052e-4630930660fmr341014291cf.9.1731582609949;
        Thu, 14 Nov 2024 03:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7F+M/vbAnAssFq0op9LX2J4MXfyIul3bpH8Mbu3LUHXaUTQtWRodj5XOTZ0rPlg9LI4bX1w==
X-Received: by 2002:ac8:5dc6:0:b0:458:4129:1135 with SMTP id d75a77b69052e-4630930660fmr341014071cf.9.1731582609592;
        Thu, 14 Nov 2024 03:10:09 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9e97f4sm4224781cf.22.2024.11.14.03.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:10:08 -0800 (PST)
Message-ID: <ff1c1622-a57c-471e-b41f-8fb4cb2f233d@redhat.com>
Date: Thu, 14 Nov 2024 12:10:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] netfilter: ipset: add missing range check in
 bitmap_ip_uadt
To: Jeongjun Park <aha310510@gmail.com>, pablo@netfilter.org,
 kadlec@netfilter.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, kaber@trash.net, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com
References: <20241113130209.22376-1-aha310510@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241113130209.22376-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 14:02, Jeongjun Park wrote:
> When tb[IPSET_ATTR_IP_TO] is not present but tb[IPSET_ATTR_CIDR] exists,
> the values of ip and ip_to are slightly swapped. Therefore, the range check
> for ip should be done later, but this part is missing and it seems that the
> vulnerability occurs.
> 
> So we should add missing range checks and remove unnecessary range checks.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com
> Fixes: 72205fc68bd1 ("netfilter: ipset: bitmap:ip set type support")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

@Pablo, @Jozsef: despite the subj prefix, I guess this should go via
your tree. Please LMK if you prefer otherwise.

Cheers,

Paolo


