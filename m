Return-Path: <stable+bounces-230258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAigGBQ8w2mTpQQAu9opvQ
	(envelope-from <stable+bounces-230258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:36:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D41A931E530
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0FF304995B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 01:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0653721A459;
	Wed, 25 Mar 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssrh8N94"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FDD221F1F
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402575; cv=pass; b=l4f7driKNvISHN80F6qfZfBLBGJZKcrya8BrPZh0Ye44n0PVe/2vF0PzOOYOV0Dzfsav5HyVHXzkxbSFcIRmxvz88vx6cs5/HTiLc+InBJO1QR2D5/C2yiEYSiW6lPZQYNgMqnr0nTXtJ7qLDYuB2c6qsA9rSTPnVOSYeOf51t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402575; c=relaxed/simple;
	bh=0okK9xoYyd+Y7Hl9zukJB+XkCExB+thImigrJn9O0Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7Y9+wjO1ZxysrK49hZeMz5UaOoYg78Q4IGhlMv8lO/2y6GxjSdIz7Ses84boUaDv0ROopTfheI4Yvtal4fxxZ8lFlNOBJriKrYq7lqRas4dC4pr4gYcXYwFJsr+yFA5wNM3T3h7siswDcjYzMOlS9awPp95f/rd3XoS3271GVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssrh8N94; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1277863a912so549758c88.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 18:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774402574; cv=none;
        d=google.com; s=arc-20240605;
        b=XfUHdXk4ONTz3ipLwwnfYqUCDB0RaV2gSMIgzvI8fru+NCuVp3qIeF9+Q2ifBHRTPp
         yYuCCBkozPn4mKiA8pFcfobQU/AA91+WxcTafi4/BmzHyp6o2ewRvqppg7wWPo/aoREe
         kDHwG66yzEyk6XFNt86faWKQKNiRwp8REyqWr0yG8MN8mT8SfpCcAZfdDZJ4Kzj8xFgC
         ckM3WrkXnHXF+ZV9QzfR7G7T6MdHSFOvvF7+Dd9RKzIunEkwd89mTjN2id4YDh3AoCF9
         sjBC+LJM8bQK2rafZVbFmrfxZCGFzOE1xonjjdrLH1RTZkCxjT7YGzP5w18qVXVodHkT
         l9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0okK9xoYyd+Y7Hl9zukJB+XkCExB+thImigrJn9O0Hc=;
        fh=RTG3WUzEQuzyjmmzbkOd63Pv/+swumReAdxrAGgQlBg=;
        b=MLsk3GD258L4B3xcIVfoia0p6dB1r3/i7avtfHx7AY31P9QwBAQ/spi0xKrjtDgTeA
         4ti8bjnTF8vR7/o+k4C7Qh+49mC2IF4M1lwRUurAN34MCICE5Ouw/NvYI4p1Z/3clxT4
         wyJO8DMNj0QnQfzbUxSKVHsyDhMJgUceHNI/borIwJZ4It6rXuBQ6+C3GKOM6K4Kxrpo
         63zsQa8NdX6LEZo39A6NQN/o2ImbP/phocDJ2jU5tGuQZxYDAxenmlUtdOe8wau+lnQ9
         eDw7vHcgXr//2KGBnOG6WnkkgYcWlcgwuAXdvecMfrfBKLjYlvhxbKAFk6jG/utGpe5i
         xKBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774402574; x=1775007374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0okK9xoYyd+Y7Hl9zukJB+XkCExB+thImigrJn9O0Hc=;
        b=Ssrh8N946wZojgU839yx9auMsTGxmDY7NaJ6srQTZme1oWJGnD0TWDn74xGXcOIGh6
         H+w9yixBfEh9ZmTJ10oeh3igJXOC8Mf9mRo+UB6Rog4gUZn6BypqhHfRhDEYydcsOwv9
         L1IOZd9zVYoMgEljeMuYhFle+V3AJahDl5ZbZVul8O+mXqOO8miB+rplqUedQi4Up8J3
         1rgut45u8dZQjsVWm7trg8D4cy25j0sAyEIgvpUxB9aqe2T8AFG5wk/Qif3coi38xoUE
         KureEU3Es+y7NgXmaO+57gbalb4nfegBsk31cgS38OnvrsaJH0CJhFsst/gS8G2mNIg2
         uWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774402574; x=1775007374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0okK9xoYyd+Y7Hl9zukJB+XkCExB+thImigrJn9O0Hc=;
        b=VvfOhk3VOpOBj06MuhQxo7Clgco1IhixJgwnypOb5gDTib9NmklvIKGqpyGJ7XmKmt
         x+mGWRB6fiba7Gkyn89Vr1ZuADKdidkyFbYhY3h+apTrpAGc1zvEVORxiBsH3PvCVvEn
         xHZbNFakIcYZKDViAklWK0hxIOGrVrkUN8ULS9j795VfVe4PDCeXLHViGzjOPXsbKzo9
         zvLMQDuE00h8KLWNF4nEEl1OvBlchZ0ICFaG8I0Hsq3fbtHLcQoicBT08UiXvUo+r358
         csvt+D+u4oPA/lOjZnyv+Wxj9s/LUPE9hSCyeQV60ug2hgi+8dM+A8vffAj6FISAzBpA
         RjcA==
X-Forwarded-Encrypted: i=1; AJvYcCWB60+nYyY5VN3eDu8+FXXL6PnyZEggeizGJgpqibFck7Ml9rEC0sjYEQggmwtX6l9iG2az17M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz377ef1eY7PJvYgV+L2RUGPMk8l/2L/4zjU/Gr3kkyI/jtd7SD
	M9YNVwwAMGEj5LePYrv/2GsnuI0ok9b//VpSR1hZndx3yJ6VnLIvuV7axju1MWS+HfLSWVc+1lu
	HLQRqTo+khrmRfIdekjpMcoWwf2XEej41vDKpen8=
X-Gm-Gg: ATEYQzyZx+7ReXSSRBluEtz/L7D3knoEdGbVW2guBhNV7KEok2xOx4+pfymt9OO32wx
	0Gqy0D+e5W/t6hwTq6yV0DUfFim7Sm4pjPLoZP8LI22Q8qXoFIbHOP2wusNVeXnU2Ydd9W3Dw//
	iuXq9qI5nd4RZt1ySbR6fWBoBrEGl8bzHn7CCwpSLJX6K/30W5+Bck7FF7wunoXB6eS4K0B6sbL
	KIcZf/MpSjd4dgVzRunzD5Db1Aeh5C/jHadq9v1IDRYkxSos3bUxzrL1r1PKaSiD5UtGmesZs1O
	f+rVmeTaS5hLn4f8YBwFTnsY2hhvJ32acL8R74DuIFUC3JYIXD+85eW+7y34QytaFSRFf+SCcRU
	CDRG9UnmzPeZ15CBQ6+Be970=
X-Received: by 2002:a05:7301:4e0b:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2c15d4125d7mr343033eec.7.1774402573473; Tue, 24 Mar 2026
 18:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323134504.575022936@linuxfoundation.org> <20260325013447.66771-1-ojeda@kernel.org>
In-Reply-To: <20260325013447.66771-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Mar 2026 02:36:00 +0100
X-Gm-Features: AQROBzCWO5qPV_1hDuoqGflZm9Y9d8dfbSYWlGNb2lHRGldE_-fw23LWI6Wqy8o
Message-ID: <CANiq72kdozG-2_VBaJyg1SZ1W9s25-=3+ER_qkYAX72avDJ9rA@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, Gary Guo <gary@garyguo.net>, 
	Tim Kovalenko <tim.kovalenko@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, nouveau@lists.freedesktop.org, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230258-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[linuxfoundation.org,achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,garyguo.net,proton.me,lists.freedesktop.org,xen0n.name];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D41A931E530
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 2:35=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> But 1) this is just for loongarch64, 2) Nova is still being developed
> and 3) it is just for 6.19.y, so that is probably there was no Cc:
> stable@. Anyway, Cc'ing here.

And 4) it would need backporting more bits or a custom backport.

Cheers,
Miguel

