Return-Path: <stable+bounces-56887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4AD924757
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 20:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2F31C23F2A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA91C8FCA;
	Tue,  2 Jul 2024 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXT7bUgk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601051C8FB2;
	Tue,  2 Jul 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945381; cv=none; b=NhWAEUeS0dL/w7t4XGED6AHCaWuzFzzw3lXUm97MgBhDQkGrmA4371Z6vJcgGK+/+bVnWdESnqLuOGZDlxtXEoHUHsp3/UyEE/fc6jz/4Z4qEaImHZzncZwq6EWPAKk9sTOKbVf2I5BfZbYecbsD1G53ejeq6tGSHs51trIuLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945381; c=relaxed/simple;
	bh=SqcTNNDd9nRTolrKc+mWijvYG8+PTjzzc6fe1Z9Xxpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsQ8ct7K1vpMlSJ9r4yGguw0rVQRsD2TmeAd9pVhDTAeClKORjQYzbYkUaQTXzLbQDQA7XjHfc/v7WG4wKl2NrpzUkE6iDEiTUsJEVXQUWaju2g8CENRchSH6VCnTtEACIcxPQct+HmyW8SkDk8iwCZ9rZJn7m5xCcIMEp3wZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXT7bUgk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7066a3229f4so2974804b3a.2;
        Tue, 02 Jul 2024 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719945379; x=1720550179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jp1wG1J0v7C+G8VHJE3Gda9lKbvY8xYDX/vh4sVeNrc=;
        b=XXT7bUgkdfvBU0X0JKmCzLQ9lgsRLRae7522L2UAxOgHh7HGgAld8gudTAVc+gg0AV
         2eM0hoTyRNAjOUwSXW1GDX2TCTcC2jf6I/PH2ZWefIXITZKNasRLq1H3Z8//+akjRwvo
         k6d2NCgVkej8vzuoFhRINYY+PiINiGKNr4FQ04SRSeCvAMOktJ+wzqTztdZs3WKzj1rb
         no2DhnpP+k9anbZ35bTu86VosPlC1nT9R69RfXNP0/UgwNncXdJSY6g+87bxCypHDcmo
         KHQ2QACJxJGXdfhhTrc4bTpCFHGS3u4zAcI29JAV1iJVIP1Uid0fTaexnk8LOX1fjGUO
         XSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945379; x=1720550179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp1wG1J0v7C+G8VHJE3Gda9lKbvY8xYDX/vh4sVeNrc=;
        b=UPV+sC881R/bWr8vMKuDiT72qrzn7poCNU7TkQURYdc2ZGpF7z7AvO1sOggs/bTFlu
         XuKmK8w5Z59c/3h1tqVNVTPaJwAGy5npk3+vQZZSmTyTZmKSoXnUPyLidNJws+36IUWi
         g/LEx5T1pdzx7aFmDfND8c2Mhn928DfULMyjYpeFCkAbTRwgDsQ5pVaZamAVuiy+HNlz
         Z/ckFuBGeiFNQSrVZH8dzLKgeh1EAa8vBabjzyeY/UXy3qCOGi6fDyA6sQ7eYuayzizN
         WikoOcO1baBC+R812zuTgIqzxZnBuIgqRRnRlAHNh0TIrroWByOgIR3hatoRtJ9wDN8S
         ZPPw==
X-Forwarded-Encrypted: i=1; AJvYcCWgssAspXvYjeHdkAeALcbfSIci204sqpu1310ZmKWmttFt8vWQVNUHaoZ75VuITYJix23UGetyNOmTUlpPRXfOpLOhYn4XJcCZPCYn1sm2Uo8NopXiRsNX86bSDoN6
X-Gm-Message-State: AOJu0YwV28c+WtaQZo+yxcW6d4CGaYX5TzkaQahmR2fCZZ8c14g2808U
	Yzy9mZ7ieeyXMlmYx9bqXMzoofPXsBsXrYp99eIjfOtTfBSYWSkKx1+Ihg==
X-Google-Smtp-Source: AGHT+IFcsLam/MSeG0HUGJeRLfaeAlDZB4KQmP+fPaINRxq8KBKS4Xz/en3aYlsjh5UmV0OJImHHxA==
X-Received: by 2002:a05:6a20:258f:b0:1be:ca6c:d93 with SMTP id adf61e73a8af0-1bf041bd923mr6925335637.52.1719945378544;
        Tue, 02 Jul 2024 11:36:18 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3be561sm9175494a91.43.2024.07.02.11.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 11:36:18 -0700 (PDT)
Message-ID: <4bc8b342-1390-4247-86e1-9a6d55f8ff93@gmail.com>
Date: Wed, 3 Jul 2024 03:36:13 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 035/128] tracing/net_sched: NULL pointer dereference
 in perf_trace_qdisc_reset()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, netdev@vger.kernel.org,
 Yeoreum Yun <yeoreum.yun@arm.com>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Levin <sashal@kernel.org>
References: <20240702170226.231899085@linuxfoundation.org>
 <20240702170227.560603901@linuxfoundation.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240702170227.560603901@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

On 7/3/24 2:03 오전, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Yunseong Kim <yskelg@gmail.com>
> 
> [ Upstream commit bab4923132feb3e439ae45962979c5d9d5c7c1f1 ]
> 
> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string")
> Link: https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.home/t/
> Cc: netdev@vger.kernel.org
> Tested-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Link: https://lore.kernel.org/r/20240624173320.24945-4-yskelg@gmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/trace/events/qdisc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index 1f4258308b967..69453b8de29e6 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
>  	TP_ARGS(q),
>  
>  	TP_STRUCT__entry(
> -		__string(	dev,		qdisc_dev(q)->name	)
> +		__string(	dev,		qdisc_dev(q) ? qdisc_dev(q)->name : "(null)"	)
>  		__string(	kind,		q->ops->id		)
>  		__field(	u32,		parent			)
>  		__field(	u32,		handle			)


Since that code changed in 6.10 and the stable is in an intermediate
state, I had to fix some other things as well.

So, I submit another patch. Please check out.
Link:
https://lore.kernel.org/stable/20240702180146.5126-2-yskelg@gmail.com/T/#u


Warm regards,

Yunseong Kim

