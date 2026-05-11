Return-Path: <stable+bounces-245214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L9BM7TZAWoDlgEAu9opvQ
	(envelope-from <stable+bounces-245214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:29:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3188250EE9D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3231E3032981
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF4A3E6398;
	Mon, 11 May 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2rc3hWJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64A3E6389
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505728; cv=none; b=MhzQ6Nu1ZmJJSFHH10XHQQY3Lze+HIF8pmmzS3R41h4b8Ci/dWH4ZsQu8nUvehjt2w/IRB8PklV+weB2ql2M5bnKottI0Nf0oZitWB2eWfLnCwLHSkvaMspsjYCLnCWPT4R4TChLexI1g07JiKJIili0T41JqGF6N/ZVKddmA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505728; c=relaxed/simple;
	bh=+JbXbcKDM9tLFcb/oST0T3xjyz8MPd/DooQAyYXusjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL51Q6FuO4viNUiIaZOVdPRjdwGMs6N+n7ZMBWrdZUPkHwCK2jn1XkZ1wVm5puM9sE+Ce4D7xrB+Q5LoKVwtIPSmVCRm56D/RlYW17WA3fxW58SC+JwaaG2C6Bf+wwdD+hhV/RY9ogobSgSFwYqGHU5cabPL1o2J3aB0+rTdYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2rc3hWJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so53929435e9.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778505725; x=1779110525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjVhhqtI7XvHvBXt5ZBrdyL+WZE05jLTGWEJNy/AWV4=;
        b=r2rc3hWJf+9Mf1480OkY+3jCjbiePrcjLgY20xniMmJQIbYzg5AVJ5ZTcX9PpUo7Sk
         JhM5uQMBzhOo7wI/mXk5Zn2j7oZ7NdREQ0V0MYT13Agun1/dKUUOXy8XdDb0Lfz5qJYr
         4pk/iMEIxxoCslhNvPBye1aDa29dwLxpCuKNDqdq2w4N6NPnpuFRcW06cGRL0Z95Uu4S
         z2BR4om/x+wmHvRvcuXV2ZpgffzLoHt4VHZyqU8xC1cHrImvg8AceGlyF7wrZPKcZYSL
         BogrPJbRWNcvvQt9M1ro/kf+Kak8VMfRRZsa4CmKlcefxfQGarHm5TEl1YffWIa+d+Nk
         z/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505725; x=1779110525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjVhhqtI7XvHvBXt5ZBrdyL+WZE05jLTGWEJNy/AWV4=;
        b=RK1FRRX3C1p9NCUWf9RdilccdWWcaUfr/U+5pWlJUOZR0ERTPWYQanUfTAKDLViXZO
         xeayw0jrClkMnNCir8bcNl6dK5k11uUKPNKDsQv31NXqvBFij5hJ1FGL1CQ/xxqeCoAs
         +uq448+W9EllOp0NHGHNM/6syIgn76mmCpm5w3Uzwdv/5ocwb+2vcUy1F9rwO2vhvcxn
         hoILfe6eguNNQUPO/TfqRBuNhb6pPXywuHi3+d+oyCFmNVOZKdIp9lhQ+3/jhEldyPJg
         pdOhPyqfMwd8Lf7hPA4g2bAzhzHVgNSBcjAAynyz+/XhACmLmKbTT9CHbOkRYBM3qZJP
         qG4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9dkjGOCFRf7hCpf9D3h6yySvlhpzgVwzQGoabL7gzp4zCLpWhN4Svun9dN5f/okI0xxS+zEr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzk2Ml+sXa3gHc0q5mw/ohFCbqnprskZofGIoLk3zSz19EKnoW
	GMfGlWS6/UKq0d1ZFqBSoD16jQKSRb5ZUtq3om6VSFCeK7EyqU0C30OK
X-Gm-Gg: Acq92OHTeuRQEKYE1bAszJDP/ObT5i1927cKCYABEJEsGirzpHgZ/XzuUvQaTmnOW3n
	NtRPPnLn1HevSg4tMByrlKW22XgW6UnEnTiEp9PFh4l4ByXQ3oqDWwUHxXNncdirWBUR6QyDPYa
	t47zzRHpW9UriW1Ht39BgcX5xnnX5yXMosBJH5YbnDga+DAuB4hQra425BXfLAhKmTcTetUwIzI
	Z+/P3K2txIdG9CvS1U4mmXUEFRYjRO2NsUFz7131cWqC/s5hK54s3v3rBVq3BwwuCuqlfruvtjj
	fD/yzXs3RJwADV1MRqWMRmT6248tiFV4OZJvlndMgSzvNsTpUL0iTSevq6ez5ZNDFZt6X0xHr9V
	4iRycXlwkkrz9gKXXxv2QJ7BoE2gBe5CTv4o2Av6M7XjiF4r+llVxatTWY9GUzOvl+prD0GhXg8
	CjvRaQGQrieMFCgacFRNxYz7EnPOujFV3Pow6vAkv9JEg+zq7l3KseyZ/hqDkfhPnF/BvYgLcu2
	g==
X-Received: by 2002:a05:600c:2ed3:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48e51f427b3mr251306315e9.15.1778505725311;
        Mon, 11 May 2026 06:22:05 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:34b1:bb7b:f969:515e:9d45? ([2001:871:22a:34b1:bb7b:f969:515e:9d45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fff9ab8sm194958305e9.2.2026.05.11.06.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:22:04 -0700 (PDT)
Message-ID: <c216a62b-1653-43b3-b6a7-dd81af9da626@gmail.com>
Date: Mon, 11 May 2026 15:22:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: Do not select HAVE_RUST when KASAN is enabled
To: Nathan Chancellor <nathan@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org
References: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3188250EE9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245214-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,armlinux.org.uk,garyguo.net,protonmail.com,google.com,umich.edu];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisischrefl@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 10:02 AM, Nathan Chancellor wrote:
> When KASAN is enabled, such as with allmodconfig, the build fails when
> building the Rust code with:
> 
>   error: kernel-address sanitizer is not supported for this target
> 
>   error: aborting due to 1 previous error
> 
>   make[4]: *** [rust/Makefile:654: rust/core.o] Error 1
> 
> The arm-unknown-linux-gnueabi target does not support KASAN, so avoid
> saying Rust is supported when it is enabled.
> 
> Cc: stable@vger.kernel.org
> Fixes: ccb8ce526807 ("ARM: 9441/1: rust: Enable Rust support for ARMv7")
> Link: https://github.com/Rust-for-Linux/linux/issues/1234
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Seems fine to me either like this or as Alice mentioned in another reply. 

Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>

Cheers,
Christian

