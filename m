Return-Path: <stable+bounces-50484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F9E90697C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832991F2425B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38C140E2B;
	Thu, 13 Jun 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxgJGF0U"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BA13E036
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272676; cv=none; b=DhsLTiPO4KgzKP0EMdslGvZRPn5icvOS7vz+1z1GJRbF/9gHHzNwaVSbZVW0oHkHR15YdaO/sKIPqIJGQWAKXvFQ1YaW7aCl4p88eZMHkie43qpQPa1fP6ciIhl9LoNoHNAOgEADWQOhLvP2s7R2g/I7f0oFhFEfxCBoS4NljKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272676; c=relaxed/simple;
	bh=KqwMyBd1dqBsHTMrepbMUs5rTSpEgf/1qKcFMkboj1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNp7Cx7ZnKX6ESpY7uWOoFseRbnCNjxKZXOVLbdkArTWWfBdTbEGrFo27jh896fwmqANgabno7yqjvZfbaW8v0lnBlxHNMeXtfeeSam2kYWAKo+0KQMPY5P0xe+6eCWXZzCr8QON4YB8bDvSmnoXkPr531nB0Xxdw0+Slp9ZvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxgJGF0U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718272673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFPOJ2hSIaSgoYB7lOp5T4CRdabG9WpRLVhiydu9eE4=;
	b=FxgJGF0UHN+B4bduS6v1amRlaCMVBsJGOABo+bF6ktb3JgwpKBFqTWPBbDCz4ccBik8X5f
	UYIFipKfFhLXpS3KGTI3D/9kI0zpXNjZZIOMdKB0kONCUWvbSaolM3rlEarg6u8CxKBv5u
	Cr+ewweuI+VLiK39nRpmRV8ENrfNqsk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-_Co0-eB-PbOexHNeAGTwSQ-1; Thu, 13 Jun 2024 05:57:52 -0400
X-MC-Unique: _Co0-eB-PbOexHNeAGTwSQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4229bde57easo5078425e9.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 02:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718272671; x=1718877471;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFPOJ2hSIaSgoYB7lOp5T4CRdabG9WpRLVhiydu9eE4=;
        b=mqy0AYM14201mMjZ5TiE1ky1KNvvNVgDRN9m5mc0B38oq0Wwi7Obpdkp6Fvyh9gvfT
         W3StyHYRVOLqqNGpvPVGzEPNR1Vjhz0Ga5vS+ff5hGaLt3WIby+KAJqBXoTn54KwbaAo
         l7eussnVOJHqqPIGftQzbKPyZeRa88c/SDhNyKLOOTiDxVku4tYCAr5MXPEeJ4P1aa2p
         Vw209EgBYxvG7Qqdtj7hzRF/M39uGD0hPL/XQKz21fewMNKDj388Rrl06j1zl9nHZ97H
         kTLiKneD6ncyrrwmNApbJ1ixacY66CPyu9nVA81Y8XqmW5lu/K76uBPA+AusBbBqurvB
         Hdig==
X-Forwarded-Encrypted: i=1; AJvYcCUyMcO0fMdwzjqFmvU6MNQ5vGHDGZ1wPMtkk1BYVnyNRWRhYTM+gYP2KVTdJdMa4kCADf7ie/PkAEFDRe8ac3hepIcjI32h
X-Gm-Message-State: AOJu0YzmtwCiwJ09MC1usbcJSG+2cc8bYwGpg+CSVscO5SNqMZbTHQgH
	yfK4sIN8KKvAVTZLqY/VPl6oTD0U5Y3nYnER2NKIS66F+S/RJSS2tO/k8nVAro52PcjBWq6VhPq
	IiqruotIq/65dfst+q+xD5PFA7GlmgdPKu0eKw4OXosIex96P91pPSw==
X-Received: by 2002:a05:600c:310f:b0:41e:db33:9a4e with SMTP id 5b1f17b1804b1-422866bc34amr32585705e9.39.1718272671172;
        Thu, 13 Jun 2024 02:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKxVqO3gRC4n1Hu5nh47Iqq6X484SlcFsPRKwYBuNanSOIuIw53eNqx/vh1p3V4X7kDpg3Sw==
X-Received: by 2002:a05:600c:310f:b0:41e:db33:9a4e with SMTP id 5b1f17b1804b1-422866bc34amr32585495e9.39.1718272670623;
        Thu, 13 Jun 2024 02:57:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935ecsm1229362f8f.3.2024.06.13.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:57:50 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 sam@ravnborg.org, hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: vesafb: Detect VGA compatibility from screen
 info's VESA attributes
In-Reply-To: <eea40059-2692-4b1e-a92e-006908220f34@suse.de>
References: <20240613090240.7107-1-tzimmermann@suse.de>
 <87zfrpqj5y.fsf@minerva.mail-host-address-is-not-set>
 <eea40059-2692-4b1e-a92e-006908220f34@suse.de>
Date: Thu, 13 Jun 2024 11:57:49 +0200
Message-ID: <87wmmtqi5e.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 13.06.24 um 11:35 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> Test the vesa_attributes field in struct screen_info for compatibility
>>> with VGA hardware. Vesafb currently tests bit 1 in screen_info's
>>> capabilities field, It sets the framebuffer address size and is
>>> unrelated to VGA.
>>>
>>> Section 4.4 of the Vesa VBE 2.0 specifications defines that bit 5 in
>>> the mode's attributes field signals VGA compatibility. The mode is
>>> compatible with VGA hardware if the bit is clear. In that case, the
>>> driver can access VGA state of the VBE's underlying hardware. The
>>> vesafb driver uses this feature to program the color LUT in palette
>>> modes. Without, colors might be incorrect.
>>>
>>> The problem got introduced in commit 89ec4c238e7a ("[PATCH] vesafb: Fix
>>> incorrect logo colors in x86_64"). It incorrectly stores the mode
>>> attributes in the screen_info's capabilities field and updates vesafb
>>> accordingly. Later, commit 5e8ddcbe8692 ("Video mode probing support for
>>> the new x86 setup code") fixed the screen_info, but did not update vesafb.
>>> Color output still tends to work, because bit 1 in capabilities is
>>> usually 0.
>>>
>> How did you find this ?
>
> I was reading through vesafb and found that [1] and [2] look 
> surprisingly similar, which makes no sense. So I started looking where 
> bit 1 came from. The flag signals a 64-bit framebuffer address for EFI 
> (see VIDEO_CAPABILITY_64BIT_BASE 
> <https://elixir.bootlin.com/linux/latest/C/ident/VIDEO_CAPABILITY_64BIT_BASE>). 
> But old VESA framebuffers are usually located within the first 32-bit 
> range. So the bit is mostly 0 and vesafb works as expected.
>
> [1] 
> https://elixir.bootlin.com/linux/latest/source/drivers/video/fbdev/vesafb.c#L274
> [2] 
> https://elixir.bootlin.com/linux/latest/source/include/linux/screen_info.h#L26
>

I see. Thanks a lot for the explanation and references.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


