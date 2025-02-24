Return-Path: <stable+bounces-119393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B9CA4284B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F4E168CFD
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF9B263C7B;
	Mon, 24 Feb 2025 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="Q7TD/HW8";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="t+YaG54F"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386962627F2
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415893; cv=none; b=U18TuR/AUW59uZoa0h/Gvk/gb7AfoDcY+rimeG8tk2y2FlhmAzKJFcIj68EVGOFxGqCIWH+XHhHFrz3imU20Co1IyzecaNpYB0GYF9q0sUFvqgZ08vX5ajnv/Me8b8HgOjVxpq4o4kUQjBdb8GCQ8863fq1FdkURW2yvWSFzJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415893; c=relaxed/simple;
	bh=K28/z7QwIeobQDU/vrm+DEec3wrz9qnljeycGV8KQZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUiU3LD5LD9Tp3P3ZBh9+lQ/o7Xr6SmVKbl4rW+1jTLU2LX16sUlGg6PAsisZK7B/qoybNoEj56bbIZfD9o9EKaSwDj/ZTvcUiD/XkLGIooJURJ/nX7gc9jDEqW+jzAi2Bd/ruz7rdXzBbLBc5Re8BMwArWBafym3tkvkeW9Yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=Q7TD/HW8; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=t+YaG54F; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=Jyt0wxZCqrJX4sJ0pBWunQCrP16mlcdWeo8PdzECLyE=;
 b=Q7TD/HW8uG4Pk31shNysm4oOEbJyoZ/eHkxNHe0+VavQpzKRIRv78Seb2qKse3HekXUWkm8i3QpAXk9bLDcYvZW5UYbh5D8GLzKbcyjwpXfyp2Y5O0l/5D5yLOFhrM+1RM3+JmEcqS+vi0ipnyvimQHQT+Gt27mRdHZe2AagMzTx6FdqY1Uotyh37ykgP61JHzHFVjXwVFCR3cQGn797CKsA9LAnK4PeKD4pjChXqGb+uXxAzE6VVAAkIWuls5zW8NztZgD3Cuo3sDeY76UVEg6TZmOmuuloBKSHsu3xcYBE36a1ZCqczgi6VSiO7sKtSNnoqXxejDcUo7sSqRUF4A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9CDCE1C01C6
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 16:51:21 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0bc004403so359264685a.1
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740415880; x=1741020680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jyt0wxZCqrJX4sJ0pBWunQCrP16mlcdWeo8PdzECLyE=;
        b=t+YaG54FqTEsNQo4rca0STCmSCAEfvjezbUwMFCj1Wdme5a6P8RkpdtDNpeFV46+XS
         lKJxTjaagQzD9EEiaocqxkmUOeVnRNvoP0Wqs4bEywH1BXFGgjnr212iLgXaOFOoE5Ro
         t/LeusVXFaJ10Y61XDOqcWwwFm9qkc2GP4kInkPe2H/eqyEs4NUDANeeL8N0tCmyQ3Qn
         pCY4mewAADuCa/Z1QqU+AZciU7DxuIc9cJLaSf/7y4nKOHpKthIYcspJWysTSucrocpp
         4bxeIN/4TrxSOKydDDHayMmScfhJT+u+uFMl4V5kMv92cSOdCva2ShYbM1ZmHQmpYAYw
         twjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415880; x=1741020680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jyt0wxZCqrJX4sJ0pBWunQCrP16mlcdWeo8PdzECLyE=;
        b=R2enKb5h3aHSD+tiFvo/4Q/gETtTN/hkJ3qB3XOtKePyA56eF0Qane9XQd6jJc+Y4k
         A2xY7dW9Uv+oPFbID8hOFR1Yb5PU8TMKtz6SxbKLfcNdgV0LrCnGyrO6SNnRBwQdaZ58
         D1s0aSBIdGg5P9n1tGEDjUpADkMYzhaqG9oYK7Jo8PGypIsn/tPvHFyhLbL+yrnnZK9L
         6qlUb9RPT9iGLXGeuGURVLcZ+NT9DnKiWT497Zi1Irdg7d8den2d7wDLG177lWQ2JajO
         5J1rpUG69MH5KPm69x8GEPUZP7V95lEBEbJip6ehzrtS0j7r2xB/LF+91T/yqvK+TiIe
         khWg==
X-Forwarded-Encrypted: i=1; AJvYcCVIDk6OPJ8IkbubtHZmHjLYZjr3EUMP81tdqH3PRQEDK+J8bK9tHkcANIpp3rHbxUmG685a/Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzBLB0vwoE5j/mWx0BReL2/qfSSQs7TWdH2cw37LCDjVNIhQ+
	JofOavWBUK0qhz6BXdAUbBKJ+MkuCf0E97weWF67z+97J6IuAxB5d1z8e5Dp8ddSLFGdMZSlYTS
	bLalPA7yBal+0ixQSqhm9igHkpBG4fOSXfVwhgHwu4vqDHYZcKMtHMgCl5HrDUgmCtxam5Vg1UF
	s=
X-Gm-Gg: ASbGnct0gH8YXQQlHZJbxJtwwkqDfGf97ZGQt+GRld0HYxuHECWBduj1TZJdpAJem9P
	aSPiDO3L4QPfYcCgULEgCOGNtQD1Ko89X2h6tvGdo+C2NpkoEAvjAIEwOgOKyUbBgM2g0IJym2R
	QuRIt7VgQUIEdH18UEh5C5l4VJFcukLRvAxagAq79kKZsw8ju9RCc+hok82RtkvA89fFRkuzOuv
	3fIV83qaUJZ1JHkSQ4aIMaPvu7K5jZEkHGQ3TTC+Yq8+ELWBaUvV7O8txybcanx3WsME4DJxISQ
	TAvZj34ocyZ7ktaVSmKTQWIXzgIbhOg1GJRCO+nw0Y5LP9RSzm3XoYcsNAAF0lWwVrr6Ep9n6VN
	pVZ+V3A1uFcvURulXmWsbVAidk1hTCcJH/7cO
X-Received: by 2002:a05:620a:2985:b0:7c0:b685:1bb0 with SMTP id af79cd13be357-7c0ceef77f4mr1723520185a.17.1740415880335;
        Mon, 24 Feb 2025 08:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+l9174nk3i6VHzzdNLPRKcdildnJV0MBhHekW79kq7PRniYea04k3F6dvly7pRsJDJAeTJQ==
X-Received: by 2002:a05:620a:2985:b0:7c0:b685:1bb0 with SMTP id af79cd13be357-7c0ceef77f4mr1723516885a.17.1740415880028;
        Mon, 24 Feb 2025 08:51:20 -0800 (PST)
Received: from ghostleviathan.computer.sladewatkins.net (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0bde74158sm686422185a.28.2025.02.24.08.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:51:19 -0800 (PST)
Message-ID: <2faa8912-a699-47d9-b9d6-dc2fb22fe7c8@sladewatkins.net>
Date: Mon, 24 Feb 2025 11:51:18 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
To: Wentao Guan <guanwentao@uniontech.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
 Jiri Slaby <jirislaby@kernel.org>, Ferry Toth <ftoth@exalondelft.nl>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
 <tencent_09E5A20410369ED253A21788@qq.com>
 <2025022434-subsiding-esquire-1de2@gregkh>
 <tencent_013690E01596D03C0362D092@qq.com>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <tencent_013690E01596D03C0362D092@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740415882-PMcCL4vrvKhY
X-MDID-O:
 us5;ut7;1740415882;PMcCL4vrvKhY;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/24/2025 8:13 AM, Wentao Guan wrote:
> It is means that 'Fixes xxxxxx' tag point commit will auto be backport 
> to those stable tree with xxxxxx commit without cc stable, correct ?

If you mean that it will be "automatically backported to stable," then 
no. Ask for it to be backported, or submit it as a patch the proper way: 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Otherwise, I have no idea what you're talking about either. :-/

-slade

