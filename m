Return-Path: <stable+bounces-212889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCMOJyvJfGnaOgIAu9opvQ
	(envelope-from <stable+bounces-212889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 16:07:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 168DCBBDE8
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 16:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C44A0302337A
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB587331A6A;
	Fri, 30 Jan 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB/Qy8rR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804F155A5D
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785623; cv=none; b=F09pauZRllKnp+8s3iPtxkBJR7+IBWU1g9okzcidlJC5ZqVhDah4kEJ/P4cxW07iMJjCb4PBqrPKBRwxhh4lwn5DOTa1ZARKVZcRjv8RPAf9ACsDXsel+lzOrOFI/pkUq5NMOJfLnYKqPgXS20WkAse7Zc9u9AE8R71KNQ6EFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785623; c=relaxed/simple;
	bh=8J/ffOpUqzqBEMKpZf6ikhEkgDDSWtVMQo8Xj/m34vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxU8WGuOBrVCKCklSxoZvtu3EgbPMS/hhvG+bfiJBd5sblhjiB1cmam7CSQkiASFM0UEhc8AxcqV+EMatnXZ6jPrtmJ9+F2FdTVKAYBc255r0ox+NK68w44nB8fe+rp+MwD5qT+9A775azXCSFhAT39qJci2r2La99iFGXqLafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB/Qy8rR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so29451215e9.0
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769785620; x=1770390420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zONlo3vJkBl5ujY/5KUHB9vDfxClAt4ztGCRSwPclIk=;
        b=XB/Qy8rR4v/6zQUB5lQjVvnS0pPrQKsUFn7/RuYNrmDwWgZoLhXQL+5Yh9XSQxwsEr
         cSIuqYbYX7Dkb1TL3INOfbhCBPjJSFBppq1y8FTsnryFArQVLq5FbMA+1bB2m7bAjFe/
         Rmp61e4jQmsHT9cBfjanvftUVLQ3OYHv8xi7TLO6QaBsiIPwhS/7sqXuJ/uNha2wigyg
         KUSuXgF7gwQESY8mavO6Amh7J23+fm0xiNcnGs0yTzM3dd4+WkaBlqsCkCEorg/NYsOP
         s7ujYq7t3N9elrq3mp9v7TNwYUtP5kPsDTbWPYLqIR57OwACnwtNVAU7RgCu+R5BhoFf
         Pfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769785620; x=1770390420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zONlo3vJkBl5ujY/5KUHB9vDfxClAt4ztGCRSwPclIk=;
        b=ZXaZZm+UK6ebgDHchJooAQhkBVG2CHEHbwJF4yutsr0TfOYlIUYXvVahSmSKBwmuLk
         nd9kNArsnae2HRi4RPCBURW8fM5q+fhknmGDhhbLMhgpNk14jfTVHcyaD8wMVqu29OFm
         V7ehLcE91FgMmeLMxXHD2EL3Bhuh2K9bkbadaxs2IdLMqsrfUGRSgsnrGiYn5vTe1eJW
         goATtqjNLOqSmGmDyUEr5SjqQVyOnH/4INOJOY2ocobmDjWgYb6m3x3Wd2RKbX8mPEYi
         0HsgsnJR/epg6bdphvNm+bFRawCzy+OAovyUYTCBfPtlFHysmWfQGe/8uANHvt1w+J9t
         E2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUE7JTH8vU6LDrgIiq1nUSWmUiqwEvM2i3i412Ooc22IghgGCrGDCoKKbi27+arYqoqZjAoj1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWZM9M4LzPKSS4W5CZEmo+gCBkyskNdJhx6zdUhdg7jcGl+HQ
	9IpSGwEYSWPZyrdc/hbYcmqesRAzE/QF1UQeJ8pr1Jrh8WfwqFsxE1C9AjJ0vQ==
X-Gm-Gg: AZuq6aIKY0ucAoDWVQrsU/Te8gIOPlXt9KB9ULJteybMFxNA17vbtfg9jL1jix1s/fb
	ZpZeM1e6z2cIIqEvEdyfNPFjPYigTRYtS+lhMD+MF2hGTrswz56HYyJT7zemdJ+SzC2z/p8YSRt
	hNVS3Tb7Yjen2j42Z2vho/Dsv99jITAfWHH0MYvd/qptjsr6gDhkPcrdV7TZPQR0sicV29giMWu
	WEgOK3VlEv2EUVwPB8glHoc8OXTx8OdZmNN0ZASMXZivM8SNzJz0Um/A+6kusFDPYYQjKw5sm9I
	wd5GoO4iA982jYRdBtAytb6KpNXYOwd59jNeuKh45DAGbzvaQ2Aqhsdg1uBEnYpY/hemCORw014
	z/2Kw6N47o5GhbjkOUZ4930LwdfV4AssMdxGA1lVY38KHA1kMwGLdPkY9DAlsI8HvLvDzF4dtCA
	QI53ly/+/LuLj7c0mb4OfxSLDwbhDyuCILLsm6Wh39azeNtBNw5T8c
X-Received: by 2002:a05:600c:4443:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-482db4a0fb8mr41870345e9.30.1769785619829;
        Fri, 30 Jan 2026 07:06:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm22183847f8f.6.2026.01.30.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:06:59 -0800 (PST)
Date: Fri, 30 Jan 2026 15:06:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Boqun
 Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Bart Van
 Assche <bvanassche@acm.org>, llvm@lists.linux.dev, Catalin Marinas
 <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Boqun Feng <boqun@kernel.org>
Subject: Re: [PATCH v3 1/3] arm64: Fix non-atomic __READ_ONCE() with
 CONFIG_LTO=y
Message-ID: <20260130150658.617b65ad@pumpkin>
In-Reply-To: <20260130132951.2714396-2-elver@google.com>
References: <20260130132951.2714396-1-elver@google.com>
	<20260130132951.2714396-2-elver@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212889-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,linutronix.de,gmail.com,redhat.com,acm.org,lists.linux.dev,arm.com,arndb.de,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 168DCBBDE8
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 14:28:24 +0100
Marco Elver <elver@google.com> wrote:

> The implementation of __READ_ONCE() under CONFIG_LTO=y incorrectly
> qualified the fallback "once" access for types larger than 8 bytes,
> which are not atomic but should still happen "once" and suppress common
> compiler optimizations.
> 
> The cast `volatile typeof(__x)` applied the volatile qualifier to the
> pointer type itself rather than the pointee. This created a volatile
> pointer to a non-volatile type, which violated __READ_ONCE() semantics.
> 
> Fix this by casting to `volatile typeof(*__x) *`.
> 
> With a defconfig + LTO + debug options build, we see the following
> functions to be affected:
> 
> 	xen_manage_runstate_time (884 -> 944 bytes)
> 	xen_steal_clock (248 -> 340 bytes)
> 	  ^-- use __READ_ONCE() to load vcpu_runstate_info structs
> 
> Fixes: e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Boqun Feng <boqun@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>

I found this in some testing (on godbolt), so:

Tested-by: David Laight <david.laight.linux@gmail.com>

> ---
>  arch/arm64/include/asm/rwonce.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> index 78beceec10cd..fc0fb42b0b64 100644
> --- a/arch/arm64/include/asm/rwonce.h
> +++ b/arch/arm64/include/asm/rwonce.h
> @@ -58,7 +58,7 @@
>  	default:							\
>  		atomic = 0;						\
>  	}								\
> -	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
> +	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(*__x) *)__x);\
>  })
>  
>  #endif	/* !BUILD_VDSO */


