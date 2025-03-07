Return-Path: <stable+bounces-121378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF693A5685A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47083B2468
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729EA219A8B;
	Fri,  7 Mar 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOjG9Bc/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FA215760;
	Fri,  7 Mar 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352305; cv=none; b=UzlIwLUT9nTt5Lv+zjvVhCcYqTqJz/EfmNq2nsGnRlneA11qqRbWwuRZPnroCt+d87aJUjKNowpA4fBI/Raw/ygos29Nefsiwl18IytjC2Hb8TSbeABrjWt5Esqxk66SQ0rCUwGt86S2lC2GhbVEGcrOaELf8Pg8/IKs5jIepjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352305; c=relaxed/simple;
	bh=m/auXCDofkYE2fnxWAv+1WSX5E3g2xIMSNEOGatdYws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGaxQ46IqaoM2DbfKH3RsJm4y5/ahU1x35GZG6K3mLQ/0u1KAR9mwU83sSjU65Ja9BucMY/f7fU1rUV3mn+f6n7X+AgCv91j2CoprFcpDr6cE0p+vfqTpSPvIx2t9Bx8gIueCOD8TtE8wqjUV6MqL/6wnC+SQXtLzUM8Jhv48D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOjG9Bc/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25520a289so122614166b.3;
        Fri, 07 Mar 2025 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741352302; x=1741957102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/auXCDofkYE2fnxWAv+1WSX5E3g2xIMSNEOGatdYws=;
        b=DOjG9Bc/QriI+fKp/xD6n7S24UVcx3cBcTs7XU0LFRzU2H8vzwmS8y+JjyYxP2aonD
         A+GqtVWM4eiMZFX3ZB9AC5NTDy9yy1IMUjflOLdZP7N8V2dnsj/u4uVJLnD1HfWoNdk6
         w7Uwkt6ljwfyM2VAU28Wug/a72nGnKQBrKq78M4+f+fSHcThRFaXM+4WRkmTdi+uaQJO
         6+jxqP58MHnrHjq6jzav1TKgkgF9clHo4HiYyhdZXY8zg7ng6KFyBDYhF82NFMPN8Pa/
         QWW90q0Q0oa86dY7D+2jS89pafq3+dX4Jmue1Cr1mU92L84WFT2a9xf1Aq0MfhkBLLPA
         TLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741352302; x=1741957102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/auXCDofkYE2fnxWAv+1WSX5E3g2xIMSNEOGatdYws=;
        b=PgbhZGgo+738OJiqhhQ0mxpREvl/iEkRPx8Cb+2IX4ieNR1vE54RmdvBv2tdNqcYQJ
         5cIXuQvq3lMQK+WHONnW29Ln5aHgZi39BNdqzhiLZxUtHnXvJX3O/gH0wCKum1V99tTi
         ptFzz4kZQpM+Y6bjiweDfIY5rTxgUohNDkGVZB94Sn2ChmDR7HMO1y8+DxYE+RnelBn3
         /0IavsxFYTZIsoNyll2MO2cW0fks0Yk2Dvlig9m8S0643nFLdP0jjQ7lu+p3fwy07vQE
         4VHSV+TKsr4II7VchMrKRzMLLdn+zGjVLtJfZW/2nSwUWdKjxIfmgbnqPVC3m4pS/fY9
         nPGg==
X-Forwarded-Encrypted: i=1; AJvYcCWtf87ogwrK8haJHuv3nBuq+JL65levRyYJg+/KZ0qGiYLkcZPhr4uEuof/W5Xm1fKvkKuWeVixltFn+h0=@vger.kernel.org, AJvYcCXWpdYNi0gJHBowcm4brakw8y6wDtf6FNklobZphQ5xjp1PTLcgTINeMH1GRE+13UUmDvuexir2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ePA07ulUpvrdENbKxAICLOUMubQ3GSk+k5YBzMBcD/Eqbne5
	YXb5CZ4pwSIwCqWyK/QJkyXHreSR8uo1RNQMOuqJ7dviC5G2cpX7PzL2Uu71kR7IWZEv0UOPRbj
	1dunFQkbg5mBR7yWYruk8R/e+EowTn/dY5TNITeTN2jE=
X-Gm-Gg: ASbGncs0MEeOhsiX58l27RsYv/tn8WvHOS6MOA+KPnNM0jrYskTI64S0VqQLk68gvNO
	Bi0ThIR7Itd25wpBiFrNgQRu997WjiASI6wlP8FZDXLtnAP/ehz3K//z3EqeRCJNRsVmt4pSEAQ
	m5DmAydU7kaHGO9PqS4p1o3bDJ
X-Google-Smtp-Source: AGHT+IE8oyHIzhSNVi8QTlcKV5tKJD/5qayWxJTZy96ZNvPJRPDzcivpMxNekZW4IxHB1lECfsHmXcvntjNB3+y5r4U=
X-Received: by 2002:a17:907:7e81:b0:abf:4708:8644 with SMTP id
 a640c23a62f3a-ac252fa0d03mr311432266b.43.1741352301547; Fri, 07 Mar 2025
 04:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>
 <2025030559-radiated-reviver-eebb@gregkh> <CAMpRfLMQ=rWBpYCaco5X4Sh1ecHuiqa91TwsBo6m2MA_UMKM+g@mail.gmail.com>
In-Reply-To: <CAMpRfLMQ=rWBpYCaco5X4Sh1ecHuiqa91TwsBo6m2MA_UMKM+g@mail.gmail.com>
From: =?UTF-8?Q?Se=C3=AFfane_Idouchach?= <seifane53@gmail.com>
Date: Fri, 7 Mar 2025 20:58:04 +0800
X-Gm-Features: AQ5f1JpoCfaxtq2-EaR_wPAspVpLWiZcfCV5Kt_4iQsyOusnJqgKaeK-i9--rX8
Message-ID: <CAMpRfLMakzeazr91DBVyZQnin7y6L9RB+sPFb59U1QZvY3+KBQ@mail.gmail.com>
Subject: Re: [REGRESSION] Long boot times due to USB enumeration
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dirk.behme@de.bosch.com, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear all,

I continued bisecting and while applying Dan's fix (15fffc6a5624) along the way.
While the patch solves the problem for some commits it seems I am
hitting another commit that exhibits the error again
(25f51b76f90f10f9bf2fbc05fc51cf685da7ccad).

I tested on top of v6.14-rc5 (7eb172143d5508) which has the issue,
applying the fix and reverting the bad commit (25f51b76f90f10) fixes
it.
Both the applying fix and the revert are needed to resolve the issue.

Let me know your thoughts on this.

