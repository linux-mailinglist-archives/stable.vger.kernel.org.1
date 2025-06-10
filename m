Return-Path: <stable+bounces-152265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89726AD3239
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E3E1895F24
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810328B3FF;
	Tue, 10 Jun 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LnyEJVNV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C128B3EB
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548105; cv=none; b=FamXuX7LHxCwL7LkKqMkOKyH8KluCAZVWM0wLERuK94fF/7hb3TKcWgROtSff93FsfshemPDPZ8YPgdKJtH63GR/YjIi+H+v+kUA8cnjY/mUX1sV1Ax5RTQlqfIu0JM7gJ4nnJxm0qdOJoG1iPQAv1v3rSegZwfC3Pa04aeRztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548105; c=relaxed/simple;
	bh=gfqKQUVdNgoYrhOlRomcpoZ1JXJ0s03ZyueH+1jSrss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrfUcPz2qETfOs7IrjaYJhaKuerCNtMzOrB8cx9c6t+zOa+lT0gPKN+5uUMsoDlz3DtbbVbjNIC9OPzh0BKucr8c7KFSAinZTlqZCyxbLrMqeuIprJCJCZPV3ezJrL8q+a01yxqpSSgMD/irVGnA6o2NI3LaqiitSf3WLgGbxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LnyEJVNV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d54214adso42699395e9.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749548102; x=1750152902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIhuZjiGLVmHW6LJ5dLscM6HtnslwSWXdO/lCThNQUU=;
        b=LnyEJVNVUfE3Iit6gYrV9KAcQZD6EFASLeExJ2LDLa4m1/CShpBpP39X834FG3qneD
         R5dkWR0Yl3sFMFnA/C834Lu7yx1D5yUqt6KWQpdqcmdwvucxjQvO1tOB1/MFYaDbkIyb
         I5Ri+kShQNUItceO5kUzwFqoqnHhVP/952LRx1oMu0I3buCKVoAizb9/ixV5AtUFzVEz
         CtHMWU06c5qGdh6Oi8ejOOKvr8jTEwGqKWBbUgdjCJRmw6lZAYMtuFnEpWgZQDDh6goS
         b99as/uOSEgjap+4Y/aKhtsTfgx1GIToBoha1EKeh/w5uUONMOEXEFS1g6V/v6zH4FQr
         OZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749548102; x=1750152902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIhuZjiGLVmHW6LJ5dLscM6HtnslwSWXdO/lCThNQUU=;
        b=p+pjyKxOm/kQEKxGMGkhkmU19yxlVoMzKCli+/iZeuw5Gh+k+cGPjJNKH40TGhX/pd
         FUATvriDsNxfKeOgDHIXOrBx3Exu+fmD5/HpcQgwpSrxtLnKqu4dqfUY/5v5vlaoQ9wk
         G489SMngMITqro0JJI5cBJf2uprLqwFsT9rbz+7NZi03xbOhJP+KacXzPkE44XtEYpTH
         oaQVaaqJvY9haswraMxHIlGdz6J9L5XjFpSzuxBJK0AEYESCBZTLVNSfmpbjgmBCxQ+l
         AeoNNHXgRfIH97KRe0WHKSS/l2NruSIm6bdJn1uryvHEQs8s6YnCUID/FdzANN17Cbxu
         kyag==
X-Forwarded-Encrypted: i=1; AJvYcCXuo4YdkXPSx+9YH7RYzAVlqSYV01UIsZUWcpoivLy/+bQKGYKjiqPy7K0ZvVB3G4fptzx5QwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjzbt3/HHByHf2loYgiTy3BtssPVAqswSqa+XDIU5N7HK2z+m0
	nVQ5QIW+OuwUurzb9qWYuQUhczkPQiffu884g4wvxsBLvf+OndyQDyg5kKJbTTyJXj8=
X-Gm-Gg: ASbGncs3w/h+7j28S3JNqSaUYgRf/OV8PKuuZDgpSd1Ngx/4UV3mntdpAoySTANcIhq
	YB2aBv1soVkIVAXbnSZFnVxfznrubfvOTbRYkGe63lhNsbe8FcfsM8Z9jNKQvFz3HUVO1e4Bi6Z
	Q3Cvud7S+zJsZrvHsXhCy4K1vdSN7xHCB7CGjVuln/iV3LnrkNx9LteAaJmXz7ZOlIyJ1v64IZv
	AEbGK7/Jx1DYU9Vrw12yDG6g07kYbGlPmcNVZCqkxcFvAc/b/AiRaUpU4CNyiE7dm5Fz2E6aUvV
	ZlwglcjoE5KKq7Z5Wy0c/xznfnCzRKhXt8K6md7qyCuikBCtVbinEEdc4USQXkVfhBWOTXW8/+C
	HLG4LqE5kZ6lZXYPr4joe1TSLQyg3
X-Google-Smtp-Source: AGHT+IEQlTZRXW7vkWedsbdHpf3XBXkYI9eNMwOqbYhqA/9V85XZoxKjQX3auljn/RMev2+m8IS0fQ==
X-Received: by 2002:a05:6000:1ac6:b0:3a5:1c0f:146d with SMTP id ffacd0b85a97d-3a55229bc30mr1501109f8f.33.1749548102024;
        Tue, 10 Jun 2025 02:35:02 -0700 (PDT)
Received: from ?IPV6:2001:a61:1316:3301:be75:b4b4:7520:e2e4? ([2001:a61:1316:3301:be75:b4b4:7520:e2e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532436863sm12004174f8f.52.2025.06.10.02.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 02:35:01 -0700 (PDT)
Message-ID: <66b3847a-a3b8-43fa-b448-570f60b775be@suse.com>
Date: Tue, 10 Jun 2025 11:34:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: hub: fix detection of high tier USB3 devices behind
 suspended hubs
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 stable@vger.kernel.org
References: <20250609122047.1945539-1-mathias.nyman@linux.intel.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250609122047.1945539-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.06.25 14:20, Mathias Nyman wrote:

> 
> Cc: stable@vger.kernel.org
> Fixes: 596d789a211d ("USB: set hub's default autosuspend delay as 0")

Is that the correct breaker commit? It seems to me that it marks
only the commit which turned the problem into the default. It
was always possible.

	Regards
		Oliver


