Return-Path: <stable+bounces-214661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI/nHmnuhWnSIQQAu9opvQ
	(envelope-from <stable+bounces-214661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:36:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB6FE39A
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9863064530
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165A3A1E73;
	Fri,  6 Feb 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="NxJBuljm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128C3DA7E2
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384866; cv=pass; b=Kiqof2A1zFzJIgVhQ1bGmMpYrxwquTd9ain/tIf4hk0Az3NVRuuGdR+LIz/S+lyJJ3Il8/QwIdYgZ6IXU9iphFr9QByyLPe+puvRf6yqLQPzOUKpreTfG7lcJPqYMmk98GgK5RjlPPduKdDwpGH4mSIVHatr3uK82QSUPmNb7u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384866; c=relaxed/simple;
	bh=l7dC/Cdx5LXD4uXdt40TEZn1Frr+MwEVwXAggRPqJ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKWVyhcGChkqlvh0PxJKkvy9NXTqB2mUkEhuuB1TfS6znFMWlJLAH8lmCE8j73j8+C46K0KFjt1uIAlHRRcrKxm1YJ7LMv3NDfPJM+Q18Tfw97z6YR8beoyyaUUaXGnPKeqKatVFecBE3oTpjcU93Bo8lvga54xjb69Fnxaq9v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=NxJBuljm; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so274073666b.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 05:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770384864; cv=none;
        d=google.com; s=arc-20240605;
        b=RUdOXDvaW5mVuUZ0moTejIwp9fLfLcKWMGM/GZuKQJVF2++EUhDtU3fwOv/Hq22aGp
         5CFR3qgFlcgUAvxmrdUnWupCoDugQH0p6xrWEjY9hWQ6nDvB3QXn87m/zHAR2DjpdpwH
         7hKdoSnwwM2mAaGCrBZI183NocBUkJxd7NpFiBGdkWZwXO/ktG6WoRCEISm32ZKZWmOL
         QfMusYez3m44s4D585KyNB3kxeFgTf1jEGWJzB/kymaLecI4QEU8j25pzBbKOXjHqO2l
         WSDWGJ/UMDmWZz0jboWZ2hCtRGJ256n0HfuQpKzfBkEYYOrywZufqsE4aArRsVM5t2Rt
         ZYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tN5Q1rb74JGxqPEaMraAIeSQS8Pn+Rcaf55IL0Ede0A=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=gAX1orNZUn+8kQXuWls2DjbzSHL3NCsYArbAVg7v+OVo/v5RthhOliEcFOwISi5d2G
         pzYIudZRMBNsku5oo8OT5GPqvh4roJ6yZ6rDl+NKWDCQm5Wb1u3uRudfOEI2ilwRcFc/
         0hsNZ5KZ6t6GyOXt+tzwsENE/wCyxNVHlKSyEfAkIYAxJPiGdS8+Cjx72xjGSXuNiJs1
         rW4BaxlQaYjYTvpbk3Pw81cSlwbIHI4WyM9ndRQFIvMecjmYY6TSnakDeTvv8MEX16nc
         oWy4It0FOgASI9dLYtjhYYhUQRof1o+ftBtOdq/fauMrk/V4Qeeec74ikbzujPJQQBIy
         sElw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770384864; x=1770989664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tN5Q1rb74JGxqPEaMraAIeSQS8Pn+Rcaf55IL0Ede0A=;
        b=NxJBuljmV4jlxHmRiQWH9K7v0Qzid7C7ZoMziZgKi0qOWjnqO07gk00xoWKK7yxWOA
         4X2ufPdIXm/HibgjhNeVl43tUH9znreojbUkmHAUnye83+HrnhiKbqfYaiS6PUL4SMXK
         dB/YtU6pG543ZhSgYz27ImnDsGWzD15tx9oKcK6u3yOP73uNVfmokz3Hxa1RgxQHz35I
         Q70iMhTDxZUHiH/DJBEhkLEt9sIqy+jhs+IjMidmd88E8NEEVlv95ty6AnofCJlu0lbS
         DXX7TIno9xaG35NSKGlPQJI+EwtwacDD223g8dJwSkAqz6h0i6LjzpJ6VDz2BRzzRjhn
         1btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384864; x=1770989664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN5Q1rb74JGxqPEaMraAIeSQS8Pn+Rcaf55IL0Ede0A=;
        b=mhmuO0DGRGbdVDJYIDXD2L3wDBEKBA4YQvucm0oLjIFO9q9+11TYkluzlE2RPdvOKb
         IrBgOMIaNjGfwVhKlmF/QKW6n4H4Nw7d3ov3STYAiZtOgjLySo8TMUdVwAtcddzaX+pQ
         SH5ClrX1eQkQXcnWd9sENF07/RYbx7G64ShT/y0Ar+Tqj5FhoE+VkRHw/FMqEflOKPIQ
         rbHhSewwg9dqhIJIbzW/pFG2S0dddQrXh/+7HJOQ9kC56jH3RcH/s1K1XhUB2sF9CC8p
         JvFZK4C7whzeeh+XiipemXrN3pyViJ1xzdY52PQPYCi6qH8KFig/2S4Yc5PzxVGIthGX
         EWuw==
X-Gm-Message-State: AOJu0Yx8ZutgLCK555QjYK7E4VF0GPo3NA6T26FbYPGYF1znRqbPLTjc
	CA/bc0uCMY2aBwy4bDwERBkdPcuK9pK+58t4EUKEz2PU2kbwdFkpvYgm0r/akR0iymK/4H1/2BP
	/5DQ6kxMgnAl/Md04lUeJPazBK0SynAOfqoa7w5g/+FbkY+BxgpadM7W/OZIi
X-Gm-Gg: AZuq6aIR9VXaFwhx4esTTOGSJrUJNn5hVA173OqYdf5hEhSA88GSPHNVRB52x7smjF5
	3M9L2g4Z5bM+KwX9GXi+WOEB5dZAczTvslA3w20bHNRlRHRRejeg2Da5k9TRBla7Tuhi7UDKI4Z
	wFp8jVouJvf+nG4LnjjEjNQqKF/qaIxStSi2v/kYpQJaeZRovZXhtLGgQxigMgFxis6XLh9+rDk
	NL0VX5HMVHjDqfnGQieYL9/NRSgKkOMxid5SGgfbEWMfX2L03a2vi/N9H+bFrD5Qcit9ZfS
X-Received: by 2002:a17:907:9451:b0:b83:1327:920d with SMTP id
 a640c23a62f3a-b8eded474b9mr137535166b.0.1770384864142; Fri, 06 Feb 2026
 05:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205143450.492803005@linuxfoundation.org>
In-Reply-To: <20260205143450.492803005@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 6 Feb 2026 19:03:46 +0530
X-Gm-Features: AZwV_QjgAt7gGa0mQctHiV4Enbff4TAbrSGzEat7SXsGZhk2g61R9nmXHK6dSRA
Message-ID: <CAG=yYwnKCZ1UTn7a5jtgQfgoXUsG6+OTGe30pdfcw4O3YtZ0bQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/276] 6.1.162-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214661-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rajagiritech.edu.in:email]
X-Rspamd-Queue-Id: D3EB6FE39A
X-Rspamd-Action: no action

 No typical dmesg  regressions.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

