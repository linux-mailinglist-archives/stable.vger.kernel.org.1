Return-Path: <stable+bounces-206413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2035D066A9
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 23:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E05C3301470E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFAC2D63F6;
	Thu,  8 Jan 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S//qes+3"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E98218AAB
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910802; cv=none; b=kAwf4si1X8OR8kDnAEisX46eaerX4BS3nesvohrB9/cshyPaqECHrEvUmAfzAOpKTf7U/jOqGv5AM+VtyJxl5sVgOaKmKslyoX5s/1/oCQguKyDXAMonmvm5inIFKby4DU4N3LV1DdSDWerQi8/KijkxDqxvtaulSCRlHMkiBrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910802; c=relaxed/simple;
	bh=5ITqXKWePSx2bg8bCdYwfMtYEz/2moH35vHlKOk6Vzo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDX+hEqe4yXkqo7PDZyL3OSOqRElUeUWXK5QKlAqpVvTpBMLhra41iYXXkuGdI4Mz3ZciHFZbHAIGss6C3SabWKjndSrGd+o+pGn2Vw/cvuaC+JtosYtl8r1tYe8c68Tcei6RX3bY2PvGTRkRqVM1OXiWpPzKxxOqRGVuaMccNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S//qes+3; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12175e560b3so4528905c88.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 14:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767910800; x=1768515600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxjSRacv3w5er0RWgoAClaciiig1BHRL5ZKZktfUSLc=;
        b=S//qes+3izWIiy7mVyFI1Q4CFPpihaZyLVxzi6DWWOFcTjKKckZ53wVNhw6bTx3XaU
         dag2EoZn8Z8PC1ew92hKrPPFHPCCqtzECk3QRx5z2N4ODWEx9fE/3IZ3jfotkt4ISMph
         jGwKqv6kFYxg/TG1XPTlcC+jBqcx6eCikGu35uTL6yaKJuVt0vN/dvVkItYpVgfZaCDf
         x1hUo1CHp02mj6N7HkT8nv5o4HlUoo3wW18vnYa7aEFANf57USN3SKAow5zEX8xrnPNs
         t11Nx70oZr862pNPaHp4uSsbOQNti5aOzSLGTiH8tCKMwtVShH44b/5YgIypxuhlnBMq
         A5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767910800; x=1768515600;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxjSRacv3w5er0RWgoAClaciiig1BHRL5ZKZktfUSLc=;
        b=LQhu0ScYMZu4LHMzTc0A2fPtXnC/o2MGYTyi0TJGX2tAOUH+ovlQCDxfY7KdhVosBr
         f4SOmKnycBmHnqXmUxf0q+THlzn+TLf2U+UufT9AfNpEeJGUSfVAbugP7Zmt4RErtQrd
         uX7/eOat4lHGXf91yjBKtkwe/rnujaHFgBX2wGhMEa2zfT6F6cyQOI5uLtx0zuM1ysfZ
         BsSQPK/19ETRtuvS4lDZodYISHY2xNAUquYrvzgW8fVohqCnYFuNOj77k3yxZ8kCREgf
         lr+73af4Wa16CnNvhIjT/v3ytuuoVsiRjPcdP2qqJ0hl8QQEsjApZBGY9+RKQ8sIjiAP
         NWYw==
X-Forwarded-Encrypted: i=1; AJvYcCWsnjBeV3zPNswqZ6LRLT8X1E8Fe8ORLgnrNY4dhmP/lwJrPuv6Lmjwu9jfqoS3rrctNdhzsGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0rBLFWz5hTUcp09fKsFsmZPx/OBRmqCYEjLvc/uSe0s6T/aE1
	gUBDlwIvAmTocpCQnZHesj6mAt+G5hIRszOW6OyXG1m+GMNqBpCSIYdmyg9J2SMf35nUdy4QUNG
	7vbarjTWKJw==
X-Google-Smtp-Source: AGHT+IF+v6/uWmIJwB0eceVf/qyBol3H7EALTIc3xqb2VHJl1Wpvfq7u2x1fIR/JLxi6HhB/9rju4EBWYyGJ
X-Received: from dlbuy4.prod.google.com ([2002:a05:7022:1e04:b0:11f:3f33:f0a5])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2385:b0:11b:c2fd:3960
 with SMTP id a92af1059eb24-121f8b46199mr6271092c88.28.1767910800083; Thu, 08
 Jan 2026 14:20:00 -0800 (PST)
Date: Thu, 08 Jan 2026 14:19:58 -0800
In-Reply-To: <20260108120348.GH302752@google.com> (Lee Jones's message of
 "Thu, 8 Jan 2026 12:03:48 +0000")
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251231004510.1732543-2-ynaffit@google.com> <aVe7_7Jf_FWkBhqH@smile.fi.intel.com>
 <20260108120348.GH302752@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Message-ID: <dbx8344flpbl.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH 5.10,5.15,6.1,6.6 RESEND] leds: spi-byte: Initialize
 device node before access
From: Tiffany Yang <ynaffit@google.com>
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org, 
	pchelkin@ispras.ru, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Lee Jones <lee@kernel.org> writes:

> On Fri, 02 Jan 2026, Andy Shevchenko wrote:

>> On Tue, Dec 30, 2025 at 04:45:11PM -0800, Tiffany Yang wrote:
>> > Commit 7f9ab862e05c ("leds: spi-byte: Call of_node_put() on error  
>> path")
>> > was merged in 6.11 and then backported to stable trees through 5.10. It
>> > relocates the line that initializes the variable 'child' to a later
>> > point in spi_byte_probe().
>> >
>> > Versions < 6.9 do not have commit ccc35ff2fd29 ("leds: spi-byte: Use
>> > devm_led_classdev_register_ext()"), which removes a line that reads a
>> > property from 'child' before its new initialization point.  
>> Consequently,
>> > spi_byte_probe() reads from an uninitialized device node in stable
>> > kernels 6.6-5.10.

>> I'm wondering if in long term the easier maintenance will be with that  
>> patch
>> also being backported rather than this being applied.

> Works for me.

Makes sense to me too! Thanks everyone for taking a look, and thanks to
Fedor for originally suggesting this :)

-- 
Tiffany Y. Yang

