Return-Path: <stable+bounces-249007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fz4OaaOCGr4uwMAu9opvQ
	(envelope-from <stable+bounces-249007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:35:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7234555C6CA
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FAC83006B7B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B67423ABA7;
	Sat, 16 May 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="W/cmXzpJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A602F7EFA
	for <stable@vger.kernel.org>; Sat, 16 May 2026 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945698; cv=pass; b=Ho2tS3H5rS40yL2dJUgH/uel+whryc7y6XUsh5tnjxC7YVElwE0zrksu4pHKXCL0ynhkLmcwNUV5OnFRtraNtfDxWlFz7UjaqVYFhAT+YZrUAFH02Yogjwsu/21S0auz7uIOLMtwnqtvfmk8mcuucrwdVjc47AX9J9/E3Y6fshA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945698; c=relaxed/simple;
	bh=+cugz3qcHJXf52vovJvqfaEyama6rYc8M5HfmSSwDl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjgWMr0GXut9kUQCWe+MJynfNHnuC3pgP/GSLWl2tIzbMtVCCYfSYGouu2eqWv2xfQQnwCb6uDv3+KctSTgGIsnIGnXVuv1z+PtzzHwMVzfCfe7J2nLE7QQ1h8YGAxcxFZEFxqAv+4cKHK4Zh7VB834IpktFeIkDCLDLCMzbTmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=W/cmXzpJ; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd0209f25c1so152349766b.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 08:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778945695; cv=none;
        d=google.com; s=arc-20240605;
        b=hIcST6kA/fvuQhgQO/oYWQFAtjqgJOHy1stN5BuD7QlGyc8ym9brdlWJp1/SrMI87s
         A+WojfxQMdnHprCwB3AxOvYLqHLcm0/X6nAurZePnIMkbZ95dVtlbqmuVjLmSaFxtcL8
         X+eBig077VstQQxbtNHu6qX8nB5qqT+486WnLAvcts9BfA/BGfQMpqZGxHB57qQJSkcr
         qgziqgpKESPY3BcqHZ4rjR0xhv1BIwZYDi4nbpMWP5FNEhnbwFMR/0K+zfHo4qNITXdS
         kDjylQGHfMG6MUK1fZeI0LKDvtOvEyv5pkJmlCDt/IR88KdpsRo4rize7ybw5iy9kO6V
         cpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UWadtITEJG72qphLj6NIaywE2y89Me6+CuOxpH5iaJE=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=LlcsFNYIQWi8pJuB/psMopylu7opc6dcYGPOPk9hnb5V6Ouvk5F5iyLmRZG79dxEJL
         F+cZN9xPypqzxbmOmztV8RY1V/BKVMHzmuaRtHPt7rYp3upbRuqUHTLYS2aX3ZBsvpkX
         kckcZjF0NIGJ0I1kxonP1Q00Y/1Q9hCpt+6kpMqQTTq11KMi7aS6nd+llweV8Zdp4n70
         R3QHo5poz78Pt0SxChevdw1AuyhFX30X5+yqA/MQVoHm7HMGBMc6zCt1kTUfwfnSVzfu
         T4neSZTkhEBfSuBUVwJguGYe5KpRSwo9CNL/zTxapWkCXSueX+BxRhCtaHRABk6k6/qj
         2imQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1778945695; x=1779550495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UWadtITEJG72qphLj6NIaywE2y89Me6+CuOxpH5iaJE=;
        b=W/cmXzpJLusyD0Z90AWdOq6MANXSA6cvWz760KxXsHARtPq5kIKYKgiXAmTBj2cvxS
         JWP9fhychheIOQVcNrPVbHHYr3jEzRj5ZWfETY+LEYrPkmxQUMUzdVBm4Bx7WLPjNMlR
         l50q21An7h0R7MezIhyD2bf+ad+n8z+s7Gr5i4vyJcPJfk+aJYNSG36diHG7auq0itAG
         q5QGpiZ8NCs/lWuBevobx/pfRYB5BAmjt2P5C9vdAs2GdIsd4Yo67yPzx/Gn9vUZtllE
         c35VquCjBggbEwSn4qKm5MlpqWNxp2SYOoKTzQk5kdCONPs4WGNL++CtpHPUl57wGmW7
         lbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945695; x=1779550495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWadtITEJG72qphLj6NIaywE2y89Me6+CuOxpH5iaJE=;
        b=p8dQLRXEcNxICXcQ9yVQJnlPzyuQfWsS5pglgAZ2kvcSObtKXlw3FFxprJlGxCB0sQ
         S+1FG0uAR6Jm/3FerHU30JtQ4TuDW0bJaQOSE8XLbjoOZcpGJ1RvJN1mgnaBkKefm0jp
         JM/7WPeWfGsumSjIBx7ytbSd8QWRwRVKIylfG12ivIQyNT/ymFlHdHuzIn+0DEUQQSDu
         h/FtWXdSp98sZaFl41NlCrDAtkwpTjek6M6iELEFG61LDH35SVmSkrbrSt/kqOVLuUgI
         LhGMgkUSG8MGfGWTvdyoGhVt6HfLseZajBEFeZOktUCzBYdpbDNaCBk/35nu8+eBj30T
         5zKg==
X-Gm-Message-State: AOJu0Yx6OjKvAYiHly0z19wPK2minQPLgldFpmsjPU3W7icrUD51ZtIT
	05X5TaS14bCTuSVKPwtFYcln11KCdGMHSWjv8/d9dJ6Z6URCEEnQCCWBysK6eHQoWAEy9ovCONa
	HJy1o1myUoWA6turyyrPcUZ1l67aOaA1W50VXULpEIQ==
X-Gm-Gg: Acq92OGxvMuzWntr4g0kDnomKccJ3Kz5KkCHcoGadirESNDYqFhBoVJhXBQf2xXl5a4
	65zxNWPD1RZ8otKrk5ekb+rAzmQMaQceF+URzgWAFnG8p4Iu/L5oL+fhh6E/SqtAts986/VEwQn
	wMBsenVHNAYJfr18WPUdViFfZQySqcrmNRp1POCgGfb6y7hYnpmOpzneUDiAivegZHWRPZp8tVI
	nkINm6Me1t6DnGI2R7mXCAcFyYEpUPpyvNoevgqa+2Kx9Sy2DUgsiCpxoS//ylnJdhe/idwK3xB
	UUmp6wc11CVr0qJgXubxVgLTG+yM8RinhDAH8y6/tTXNHkHLhlvc4qG+f4YoB6hJienF2g==
X-Received: by 2002:a17:907:c291:b0:bd5:ca8:768c with SMTP id
 a640c23a62f3a-bd517964d14mr460137966b.31.1778945695567; Sat, 16 May 2026
 08:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515154658.538039039@linuxfoundation.org>
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 16 May 2026 21:04:18 +0530
X-Gm-Features: AVHnY4LxnAOQvRzxfJokyUUI_OqBa3SgxbMFiyrzHazI8zU1j4uq9ZNPwPn0kP4
Message-ID: <CAG=yYwmKrTrJAFTrP4aFFLov_XS7tJMeU2AoX8Ed6Vw1mnfBXg@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/201] 7.0.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7234555C6CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249007-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,rajagiritech-edu-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

 hello.

 Compiled and booted  7.0.9-rc1+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology

