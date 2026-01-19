Return-Path: <stable+bounces-210364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42375D3ACBB
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E2E30C020C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435E35BDA2;
	Mon, 19 Jan 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0zD3sAL"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439D19CCF5
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833842; cv=none; b=SiWiqgSemIKYqzmP+WWsHSGZywNVyig3EOSzgXv9MrWuC9kR/mSlJkFvWyoqOSkNUpKP53f5DCjfkLY3RSRnX9JcM+2TDnjUR6RmDM/dsoZ75Sx97eJx/xdffTRlTXMCQ6SRWCnbrH7WhOIOYWveG0fRHsxmg85Yc9AYtGqseyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833842; c=relaxed/simple;
	bh=dtj1A8eUfZ/xb7svK+I33mpWY7sLUFcIA2x81DomNdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyC1yeB6cxRmDcq9j3/DJ7zObEqg9F6hkadhRDjznyiIEVtnRXyOzsvo8xSmWK8nrlsKnAvdx8geggSDQPVwe7zZJP8jnuimmubT86eO0RdKnvlvL4eGEgvY3Cri94K5hAtCr+d25KKemlDGzGmkwkSJ4fmwRFnxTbNMuX3cbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0zD3sAL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59b75f0b8ecso475908e87.3
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768833839; x=1769438639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hw8g4FncQCT0qG+FJkoHCdORpG7mMrMlB+H9ZegPebQ=;
        b=f0zD3sALxsbBPb8f+a7zJeRhH91ZNkc2pIhX82Uf7Jatdf6NAH6wKHOLXtVnXUWino
         /CgdqqcZpg90Hx87Nq+5thWEjXG1dmGnqhtkp9OL1bx2Cq8QMFpZLQb16GkXBqV7pXga
         CfKEvnQdHq03l7Arydo26WofbMDpchcx8a/4bXwIdk+HKr9FXniOxnJUoCnbx+u5NPN6
         hj/fVzVIXe5hcDkRQ6gE/T0hfRN+VSHJ+RdBbPcz5BeU3Yxt/5kjNkuW6euipNp8hDLa
         bLY4A23TyA7568uHx7ekXWkdMiNMP0X+feJWJYwOF/yftgFizLZh9jc7pNoAJUFkP7QJ
         2IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833839; x=1769438639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hw8g4FncQCT0qG+FJkoHCdORpG7mMrMlB+H9ZegPebQ=;
        b=vUvbaLZq/d23ZIOPDwC0rUwBBudDyjLbUfJwgN766TFAv+lWVat66Ws4KdiEgNo31e
         o8rO4cGCqJnj09bRHbpeuwvhTvXbkg9MpUaPZk/t7RajuJp2HTAF1Btweul05mAxmBW9
         rGCJ9eZ/8Yx85DStOY3eXFeWdAV+W0gfNFt0NzMaBJ7mKvwiV2noxaPn3lmrDuFXn2z2
         6ZcYdoih/cXwEFk0bq0Jom46XHb+WWmaBUDYKrkYLes8YlyzicR2G2S95IK7BlvviWjl
         or+iN9FaXC+x6wLOvUo7ML0JcTaw2m+YNO0xLCEZmVYqkrUPpDA6mAmOCMZPmgfl7/hv
         gehA==
X-Forwarded-Encrypted: i=1; AJvYcCWwUTUmqI1k82W9GNZltp2JJpTFCmafE+z+CaXQDoAvX7hpaTmIijDhmpTwG+pgQFjZImJ7Znk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXC8ZqzLmEHzJszUZn1jBs4HfaicG0qieS6uNe6HcwGbpFnJZ
	Ls9ry7FRFVCPmLbzcBHqaJnEDWk4iLyyNuoMSeTttz0Hg8sRsWVKhUqt
X-Gm-Gg: AY/fxX41KiW7gww0AWLC2P5Xa6OC38b68VXhDg4gekdlq7MAONpmkMNoJjCAsUsPjAV
	Sc//n6NvcVNsz8khVxOgLoJovKmHiRfTPzTElc6KmLXNj0mfkbMHFeU4meuvrlihFiDZ6c7Tf+V
	UCAg/zROemxp+NrbEFREuIcC4oXty8dS6YBB2eLI5CFj1zO8tVRzIcfMyPscRhrD1uwDM8QX166
	ZjSZupd54c6PjocEIb0i1WngKPVaYw8JB7+T5K/yQOfuURJGKkQSv7wqFAsOdgs4Jyfpe4vvpKI
	q4vToho4QfOK7gZFsdgpjhfp2h6iPSmCLnw8wk9PmGBbd+WcKgDjE4Jy2OSAHofcOq4TQiys0KP
	qqy9dQ7x639+9YiAZwCz1UCSbjJ11UgGoOwEl5f50xotOmQ6gYgnNYpitFpIRxTJwq/ooecEM2o
	Virdw4oZmmiKvIqU6GXuy+eZ+R13yT
X-Received: by 2002:ac2:4f14:0:b0:597:d7a1:aa9c with SMTP id 2adb3069b0e04-59baeefe804mr2049768e87.3.1768833839215;
        Mon, 19 Jan 2026 06:43:59 -0800 (PST)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf3a1746sm3435146e87.91.2026.01.19.06.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:43:58 -0800 (PST)
Message-ID: <38bcbe9c-5bc6-4bfa-b4ed-e187e048d600@gmail.com>
Date: Mon, 19 Jan 2026 15:43:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/kasan: Fix KASAN poisoning in vrealloc()
To: Andrew Morton <akpm@linux-foundation.org>,
 Andrey Konovalov <andreyknvl@gmail.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com,
 Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, joonki.min@samsung-slsi.corp-partner.google.com,
 stable@vger.kernel.org
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
 <20260113191516.31015-1-ryabinin.a.a@gmail.com>
 <CA+fCnZe0RQOv8gppvs7PoH2r4QazWs+PJTpw+S-Krj6cx22qbA@mail.gmail.com>
 <10812bb1-58c3-45c9-bae4-428ce2d8effd@gmail.com>
 <CA+fCnZeDaNG+hXq1kP2uEX1V4ZY=PNg_M8Ljfwoi9i+4qGSm6A@mail.gmail.com>
 <CA+fCnZcFcpbME+a34L49pk2Z-WLbT_L25bSzZFixUiNFevJXzA@mail.gmail.com>
 <20260118164812.411f8f4f76e3a8aeec5d4704@linux-foundation.org>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20260118164812.411f8f4f76e3a8aeec5d4704@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/19/26 1:48 AM, Andrew Morton wrote:
> On Sat, 17 Jan 2026 18:08:36 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:
> 
>> On Sat, Jan 17, 2026 at 2:16 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>>>
>>> On Fri, Jan 16, 2026 at 2:26 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>>>
>>>> So something like bellow I guess.
>>>
>>> Yeah, looks good.
>>>
>>>> I think this would actually have the opposite effect and make the code harder to follow.
>>>> Introducing an extra wrapper adds another layer of indirection and more boilerplate, which
>>>> makes the control flow less obvious and the code harder to navigate and grep.
>>>>
>>>> And what's the benefit here? I don't clearly see it.
>>>
>>> One functional benefit is when HW_TAGS mode enabled in .config but
>>> disabled via command-line, we avoid a function call into KASAN
>>> runtime.
>>
>> Ah, and I just realized than kasan_vrealloc should go into common.c -
>> we also need it for HW_TAGS.
> 
> I think I'll send this cc:stable bugfix upstream as-is.
> 

Please, include follow-up fix before sending. We have to move kasan_vrealloc()
to common.c as shadow.c is not compiled for CONFIG_KASAN_HW_TAGS=y.
So without the fixup, CONFIG_KASAN_HW_TAGS=y will become broken.

