Return-Path: <stable+bounces-45417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB28C9387
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4341F21282
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3189A10940;
	Sun, 19 May 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="eIVo+al9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C1FC0E
	for <stable@vger.kernel.org>; Sun, 19 May 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716097920; cv=none; b=RzZdhh8abX9Utl8s7Ih4uf8eqpB1N85xtgn1AFVyRCY91C4DgnJyHNdzS2CB6ruYSUMAm4rc7sURI/h3qvRlA+OisF1JgBnulCMI/YZAO4GIvf3A1QFR6nsjE1Uw+yIMgb32g/ssmwiBpqYJQSuHKIX1wYDF6NAlFmj1MjA3wJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716097920; c=relaxed/simple;
	bh=iiThBqGg+z+wiT+1+OMKOP35xrELiR5JRc4emeMv/44=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=trbfiYJSIwxrWLXVcGnmfsuJSsIGpcAPiumUzDFWzngpMDbSx/nBX2SaMiIjKy0M8RbwX7F10zBdeaE5VTDrbW6jqm4q9YPQK/sX9frtQkC+0MEd70fihszfEd+kOgT/BI62M7DBXXNGfCOOxIHw/ysshIdHFTcyU4/fXd+uuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=eIVo+al9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ed72194f0aso4639245ad.1
        for <stable@vger.kernel.org>; Sat, 18 May 2024 22:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1716097918; x=1716702718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iiThBqGg+z+wiT+1+OMKOP35xrELiR5JRc4emeMv/44=;
        b=eIVo+al9wM/MOahLQrd6POnvtOAMTGyusp4dW2GyhH5OqTFXlIV2QODLO49poiyw2q
         SOIqf1uxS2CzdNDDae+0rzz/6irHatSBxa+zOEfvH3lLHRUC06XlXTig7GboLYG+c2gs
         dVYnhzoL/66AA1ki/ZRE8tUr2p/14oVz+igPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716097918; x=1716702718;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiThBqGg+z+wiT+1+OMKOP35xrELiR5JRc4emeMv/44=;
        b=rJXCpTMpHH3WZQGIFCKgafFNzsNxB8DDUJBIF5qM8VWFkP50VjHIalX09EY1LmE1Z8
         YBChxD6ihOuL45dqsv4eva/EagHM3586fMGngVy1Als8/VLRhZY5F3cznMn77XUAVq4l
         sFJTTvYEMRw3NwRlJJh/DwGscCtQ7MXERhRv93RjVUFfKFEXXMUVFELf+yFKgkuJntsM
         2NLotGH59MDslqE8KWweHfCJ7vRjye23WKk3Ea8oPim0IVz/8noGulmNlqaSI7gQGgBP
         fNJ8COdAA5lCZl/eBdoAJkCyVzPX8rtyQJuytcND+NiZ9gB1IQd61w8j00UMHhe/QvKs
         8mZA==
X-Forwarded-Encrypted: i=1; AJvYcCVazo+Xjh4i6XpgnNFEWquXCc/8qFV6AEOWiCr+BjVNO8f0HuRrDjgGVWFEz7PwcitmNmKMPi4hcVjFZO+NHAhDyyWrRpow
X-Gm-Message-State: AOJu0YzElrhD1MnbaruP3IJgT7kcc3kCMPElmTw1OSpYjH9aHvv/puX/
	H93MyAe7ZIiWlNY+QQ3uCmUWXX1NoI4fysKDNssAXGgBfE0zIveCH2KXtb96YNo=
X-Google-Smtp-Source: AGHT+IFmzx1wmxCx24pjSLNJLMmnh2tsb4Lr0ISETKX8mWSBIrpJFbyjvpIXM/SELRjXRsUtOXDyzQ==
X-Received: by 2002:a17:90b:2389:b0:2b1:99fd:4eea with SMTP id 98e67ed59e1d1-2b6ccd7d042mr25891545a91.2.1716097916702;
        Sat, 18 May 2024 22:51:56 -0700 (PDT)
Received: from [192.168.1.33] ([50.37.206.39])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bd5f76e0a7sm1217785a91.0.2024.05.18.22.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 22:51:56 -0700 (PDT)
Message-ID: <f7744e88-8123-4ab9-8542-209b10b09321@schmorgal.com>
Date: Sat, 18 May 2024 22:51:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: core: only stop transmit when HW fifo is empty
From: Doug Brown <doug@schmorgal.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, stable@vger.kernel.org
References: <20240303150807.68117-1-jonas.gorski@gmail.com>
 <77b71bd9-42be-40e8-8b96-196e214c8afb@schmorgal.com>
Content-Language: en-US
In-Reply-To: <77b71bd9-42be-40e8-8b96-196e214c8afb@schmorgal.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

On 5/16/2024 9:22 PM, Doug Brown wrote:

> I'm hoping there is some kind of simple fix that can be made to the pxa
> driver to work around it with this new behavior. Can anyone think of a
> reason that this driver would not like this change? It seems
> counterintuitive to me -- the patch makes perfect sense.

After further experimentation, I've come to the conclusion that this is
a bug in the pxa uart driver, and this patch simply exposed the bug.
I'll submit a patch to fix the issue in the pxa driver.

If anyone's interested in the details: basically, the pxa driver in its
current state doesn't work correctly if it receives a TX interrupt when
the circular buffer is empty. It handles it, but then gets stuck waiting
for the next TX IRQ that will never happen because no characters were
transmitted. The way stop_tx() was previously being called before the
transmitter was empty, it prevented that situation from happening
because toggling the TX interrupt enable flag off (with stop_tx) and
back on (with the next start_tx) causes a new TX interrupt to fire and
kickstarts the transmit process again.

The 8250 driver, for example, isn't affected by this problem because it
effectively does stop_tx() on its own if it detects an empty circular
buffer in the TX interrupt handler. Adding similar logic to the pxa
driver fixes it.

Doug

