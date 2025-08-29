Return-Path: <stable+bounces-176727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A1AB3C29D
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4941CC0B82
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC07D1D8A10;
	Fri, 29 Aug 2025 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIGcUb3q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C672264AB
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493113; cv=none; b=VxuKskmbISW9F/8S71lGMNQg9oaAbM2H/dWalDOX9SG0au+Zu4g7eXLhITAIFB2WoHq75jpVZSejnQoDTUZhnTJFjvaqFpXignKqDHGD6pc6b10hsApbcffsTfczBhipSzLP8A6UQIU8BcwR/VoM9YFhuRlAAkzadB0RvtCMQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493113; c=relaxed/simple;
	bh=xEvRLLfH/foepODqYA/OEpUhffr/WMvOd5S8RWyHX9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIjIMHIyj/Q9Wx58JeH2Hxnj2B3/ir6mt9KBP6IbIjHYq6nFB6fP9Ior2raGyGMxLBaw27/L1cfseXb6jGpg4pQ205Uf2IHH+6/ZuaRvczeFyIumJtnVT/cwZMYy0nJVn5aFYgvMREissSu85jDw3oBxsDYgndsQ/F79UvCLlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIGcUb3q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b82a21eeeso7195665e9.2
        for <stable@vger.kernel.org>; Fri, 29 Aug 2025 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756493110; x=1757097910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Jqiw4F1GMFYEK9KL6UFV1DAE9WLXJroi3QhlZip9iI=;
        b=eIGcUb3qOLxxGKks0s0ZE2rd5kY3UMnHnyscQe4KhahpKM/LvBVnfgRj0j7JZmHQZ3
         2+o5Ve9/16vQXn4NvDuhSdLPVPa+b4VcOQqNV1pXvpZYnOUQXuyijQSbAO/ZmQbDAU02
         gy1yx8ngPzYculNO9BGvKJ5xDQBdf8Y9qt3YkWQioN0JsEuzxtaw8ncIqE45qex/TuOs
         BSO2XazgE/l2GSNp5QNwUd3tSritqRuwklFa3f5NntR9S6rMMgDqLG3cTtknUujOvULp
         fKrTCb/UUqQeb6eqfjQQMlaockoL6Je9MSpqs/BRhjsx4shPBrrVbWVO9fReSXYKxxZo
         YimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756493110; x=1757097910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jqiw4F1GMFYEK9KL6UFV1DAE9WLXJroi3QhlZip9iI=;
        b=ZykrhS4ckwOost5GjlughmB3qRunBs8B6f7WW/940oPRYdiWPHgi3BupwDIA9uY1uv
         bX7fivSa46T5Bf8BrpmKCLGCHYdJ97JUsWXI+3bSYZimXcYDj6Ck+9fMZFJENc+wc/QF
         ZUpjnda/q9M/xn6hCTvmd0SCJRcBbROa925pujkw94sK6IvVmcvD7MxIMLksivxQIK/i
         IDqxBFOB1+gPjBYWVoikiwswuoM9i8YafppZ2LARsvmelFHTJRAxuc2T1UyxgXsNoQT/
         q5qbl1PEsG5S+F88JQdtGZoyn9jGpPJE7GBh2D3eKRrFB1t13Nu1MddYBS+UwT3iHu3V
         cCkw==
X-Forwarded-Encrypted: i=1; AJvYcCWgaZI7KT447MDoP+vmfukVfdbrvAoCArIVQwKKT3tbJiwkPcSd5af5qUfBxMOuh27VqFyhijI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFYtcCSBQ3LBq8DJl8ZZhAxnvDo6mqmC0x0yE5V/FIYGBjkPQK
	VOzCiBt3iPsk8FKipFOwsKfZutlyPy2xWwjTwoDRxRwsFw/H9XHqCF9I
X-Gm-Gg: ASbGncuLZQgSAEelD1Zwn89Zj85QtCRNncCffOSrevd7IRQxfYPEVI+MaGhWZTm3qRB
	XrR/ZKhk9M220yGSpOwGi09KMb1/yj1popOYJGH+XwUQIoxymN3n9HTik5awWRkTYDIdBwXuVUl
	DuP1d9zUydm98HT8LMD4wco2W5cW1zSIZHuIW++fDj2viocqSu+rJ+p8Ci2bc2tQ5/Vc7JhOlYa
	uZIvjr/BN+z4N2bFNH6ZaPTFOdPbz03RNWe27dsvjd9++gdHSsP4lr2MYVcxuCkEsZK9dc3YZpP
	woRWzRQgJPR7SmgxHy0X2DLPgUtzBJ3KTPkNmjq7zxcnHX19mpedlFlAzp9SdSS73eCurEJUlbz
	j14k9H3mlg0NwLpZLnN5zbbjnV4o6jevpHJnfeRimW0sUAkUrORn0d6F6qELlIDhn1wLiuoEunA
	vJ
X-Google-Smtp-Source: AGHT+IF2laezUhSSIz3LnDqsDc5C/F+1kydT++C3rW0CetETDbvZK3tOkqCnneqBJcOwtDaM48b0FQ==
X-Received: by 2002:a05:600c:4caa:b0:45b:7185:9f0 with SMTP id 5b1f17b1804b1-45b71850b69mr72639285e9.31.1756493109734;
        Fri, 29 Aug 2025 11:45:09 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e887fdcsm49218795e9.13.2025.08.29.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:45:08 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id A78BCBE2DE0; Fri, 29 Aug 2025 20:45:07 +0200 (CEST)
Date: Fri, 29 Aug 2025 20:45:07 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Oscar Maes <oscmaes92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [stable-6.16|lts-6.12] net: ipv4: fix regression in
 local-broadcast routes
Message-ID: <aLH1M-F001Nfzs7m@eldamar.lan>
References: <CA+icZUWXiz1kqR6omufFwByQ9dD9m=-UYY9JghVQnbGD2NMy1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWXiz1kqR6omufFwByQ9dD9m=-UYY9JghVQnbGD2NMy1w@mail.gmail.com>

On Fri, Aug 29, 2025 at 06:56:52PM +0200, Sedat Dilek wrote:
> Hi Sasha and Greg,
> 
> Salvatore Bonaccorso <carnil@debian.org> from Debian Kernel Team
> included this regression-fix already.
> 
> Upstream commit 5189446ba995556eaa3755a6e875bc06675b88bd
> "net: ipv4: fix regression in local-broadcast routes"
> 
> As far as I have seen this should be included in stable-6.16 and
> LTS-6.12 (for other stable branches I simply have no interest - please
> double-check).
> 
> I am sure Sasha's new kernel-patch-AI tool has catched this - just
> kindly inform you.

As 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
has been backported to all stable series in  v5.4.297, v5.10.241,
v5.15.190, v6.1.149, v6.6.103, v6.12.43, v6.15.11 and v6.16.2 the fix
fixiing commit 5189446ba995 ("net: ipv4: fix regression in
local-broadcast routes") would need to go as well to all of those
series IMHO.

Regards,
Salvatore

