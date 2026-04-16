Return-Path: <stable+bounces-238299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLq4DNm44GmIlAAAu9opvQ
	(envelope-from <stable+bounces-238299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:24:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C340CDFB
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 246EE3053CCA
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332C39EF2C;
	Thu, 16 Apr 2026 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoiQNNSf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26ED38F628
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334927; cv=pass; b=oWJL6lmn0ZtfKbuFBdpgNFTRvfCBhLG9ZSDxI2SQ9NZhV+9XtfYfPeXGuwGB8YTkz2bV5/qw2Od2wxZMoPatWyjRUkkrJ5s/fvD0zmo1YDAvV0H0/s2F0VJmS2Xvrza1qriFhR5qbaMJydBHlvL2EV+rGGnRXLSKCliNZnEzmM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334927; c=relaxed/simple;
	bh=K5mvVCNzCDCJ9t+YBPnYGHqEKpm38PDyLCEyxp+JIzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY7z5D1pdusedSSL9z81DUTF9+LMJ54C2jEW4OvH0ej6Kodf50ssycigyoGmr6rimWjKxCpvQSKE5KvXoTKvH6GCKWgQ4xIZN/c9PD8WBamxYUPOlYjkWNKHh59F0Ni4V3uDc1C+85X8lYuGDO7gcFoTWWst3KgNCJp3QimaoZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoiQNNSf; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64eaf8aa893so6559952d50.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 03:22:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776334924; cv=none;
        d=google.com; s=arc-20240605;
        b=b0eTEwWxJGHBFnssRao7Kf/XoHQhA5tmpsEK5NRazzsZSzkIjyb8GqCIhwilTZcqnd
         55v0ojxmEFYEPhndIYJsQxLJ1pfIRcFOgdpfOvJARBwCaruPWewzF0gSOFtGd2Qcu8Wz
         cilomlL5mC0or8YXNlQEavueFvqYdCN2bOU4mg64NQZ8tD67gjQaKAKs858fNiOwmnbS
         t5fVqPL5XUU5CVT5mE36GACoTEmCQxJikUrSImM0IeBM4sZ7pN6AuZG0SpSP2cT/ZkU0
         tHAe51tjsRct6ehHGoV83KNSY5uey7PiaSQk8K8XG7GeowSPvDqeUHt4LuvEo12McayK
         PY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K5mvVCNzCDCJ9t+YBPnYGHqEKpm38PDyLCEyxp+JIzM=;
        fh=Jj6v4eU+T9phR3rtRE/h0cen16S1MrMYVTJO+7lWeHk=;
        b=ETLFdBrAzNITFm0duozsSO2rWPkQVsIoDnOFN7ME7cHUVD6VWiUMbfGBAzzLqUIqzY
         95fNQ2CGVYdsvOJMLt/Wk3GgBaoF4FudVdxemE3FCl5LlshD/4MasrUmnCvBCjMbWLBn
         LOeq2p/1ecE9tcOH9Of80onCXSO+pSp75LGoNxgxxdXdjpq17kkhHcU5N6MOZrU6cL2o
         uAZ5PyF2EEK2AbdSoOd8PeU2hJhlUB3IgmG1ToyfaChUCThQszQSZ6PX86FNBVKSqb6k
         aWR4Dm2ERRc5T2Yx6yq9qTZDZdEa30rswfKn/YMNkHOSC1MWMeW+HwnyabsVX7BTghvx
         rE4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776334924; x=1776939724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K5mvVCNzCDCJ9t+YBPnYGHqEKpm38PDyLCEyxp+JIzM=;
        b=GoiQNNSfPDu0r2C+mc/kqiePtCZMm20vJusQXbB0zgd6C3UreIfD1WpLqNgBzxxAgT
         qoofQiNbdqLQ2LDaHaKNXhP0hyabHYA+VS9rRED+eSIR9lysO7FuhqiceN2Jo9Sg12C9
         mxXFXEnu6djnoNrqu3SsEgj88Q6TrIrGOudBUljDUoTdks0eBsZpjFoMQN+umZv9X8gk
         +OvfAMHNtYYfY0GWXp2OqqkyKgx246wdzyVyNP/4r5i5sriN+iffdLrLE9VNeJa2QrQA
         4a4ZMzrW+BBwqZNVhHG8bnq8wk3AXIkGmcO1DTmXa2TB/67jKROegn7GBqq4tz8gb0E+
         feIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776334924; x=1776939724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5mvVCNzCDCJ9t+YBPnYGHqEKpm38PDyLCEyxp+JIzM=;
        b=jV4TYlcMfCAaJuxIUoIqXc7tKDOZ3+xc7tB3/dEooUKY/IN6Eh/Y+g0EkaiE20TJF3
         zJ9qrwZFsyZT3t+EhHbq7hsXmoPVA83ALbxfYM1sefvQY+QZX2Jy5g26iJRT/nrDkq32
         5IYfPFJGrJ85nKKiWZItxfeegfWI8WQcRv8QVR4k6YeLp4JlI5+wJw1oR86tKP+17vPi
         bkw+Nej4o8CDdJHz2MsDvbZT7g/UDZFdyAi58Ln9uRwtAQ85ttOOYCoASAfRQzTHdsgL
         BK5318zhM0H+wAHuHi2EOP06e70KrD/ReKtr5JRvoU8DaiHd72Mo06IEkY2EU13/D69d
         He9w==
X-Forwarded-Encrypted: i=1; AFNElJ/XPAVtwSG4nJGZjO0DzrFoG92P8Z6MRKYp+xK9/fYoLBTxTlRvgtt8Le9YNKL7gvrB3yE8hKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UGU9hTaS0Z4QifJOTpv3KAoKUk4aRO2o8oFIlJgJeTa+cnZV
	2D4pl/jhK+KXrsi+Vobug+h+kZqiH4nFY3pl9CIPE+YF0qINt0UOM/8HyjfTyOoRkoa8gF7uAaB
	G1jqM5tg17sfX5AEBuSC2Z78e5cUiFKShSfwOEKt2+XtE
X-Gm-Gg: AeBDiesTuHFuUuulZPbrEM0omfImon/L5RJyoh0nw6exRhOy19tcRj+DWyJWMCjAETW
	VuHK0uzjKeFb9xD/2fjxbzNOfKpCbPDF6ymfq5X1ZwT1iTjBntEzp6pYcKA37+oTZAC1wNgimYA
	6Heh6v/wcq1GTCJE2WKFAh/MujEze3AcaG6Mbl5SihL5mIrrDjuIiy5ZuuJVd9g/6dLybjFuOy5
	e+eLkDCzIdGB93Yr2wmcrSLuNxbr9P/mjIeqgNCmnHgLQ80/iIguQTTysEjqMaPOrVAzeTKElNr
	eGpYtJYPvbGCavvLVbZR
X-Received: by 2002:a05:690e:4801:b0:650:3bbf:6a60 with SMTP id
 956f58d0204a3-65198b48573mr16551396d50.37.1776334923950; Thu, 16 Apr 2026
 03:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415175038.3633384-1-lgs201920130244@gmail.com>
 <CAOesGMghHi5bEcec9L6d1YUec0Cn5uEs8MrjdoT-zHSr-FJ8pQ@mail.gmail.com> <CANUHTR-XcTO4jy_TNe7tHcPPpVh_o_+-hgJtLBxN5MWupcvQ3A@mail.gmail.com>
In-Reply-To: <CANUHTR-XcTO4jy_TNe7tHcPPpVh_o_+-hgJtLBxN5MWupcvQ3A@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 18:21:50 +0800
X-Gm-Features: AQROBzAYeNSoPmZB5XF19vrfhLSjNH_Tgqu7gUhZJFmf8hV0D4dYm_BdoKYs0EA
Message-ID: <CANUHTR-U+DDaWCKNUcNE2yScPkk6vVfnZ=GXpGtRt6SFYph_Ew@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix reference leak on failed device registration
To: Olof Johansson <olof@lixom.net>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238299-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchew.org:url,mail.gmail.com:mid,lixom.net:email]
X-Rspamd-Queue-Id: 836C340CDFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Olof,

Thanks.

On Thu, 16 Apr 2026 at 17:26, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> Hi Olof,
>
> Thanks for the review.
>
> On Thu, 16 Apr 2026 at 05:47, Olof Johansson <olof@lixom.net> wrote:
> >
> >
> > This looks like slop to me. It doesn't even compile (there's no local
> > 'ret' variable in the function already).
>
> You're right, I missed declaring the local ret variable in this
> version, so it does not compile. Sorry for that mistake.
>
> > This is also a no-value fix, the chromeos_ramoops structure is static
> > data and not dynamically allocated. Please don't burden maintainers
> > with these kinds of "fixes".
> >
> >
> > -Olof
>
> My reasoning was based on the implementation of
> platform_device_register(): it calls device_initialize(), but if
> platform_device_add() fails, platform_device_register() returns the
> error directly without dropping the device reference initialized there.
> Based on that, I thought the caller might need to release that
> reference.
>
> That said, I understand your point that for this statically defined
> chromeos_ramoops device this is not a useful fix.
>
> Thanks,
> Guangshuo

We are also discussing in another similar patch whether the
better fix, if any, should be in the API/core code rather than in
individual callers:

https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/

Thanks,
Guangshuo

