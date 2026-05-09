Return-Path: <stable+bounces-244978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI+4Hwdk/2k86AAAu9opvQ
	(envelope-from <stable+bounces-244978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:42:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8B500879
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E458A300E17E
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD45B2DB7BB;
	Sat,  9 May 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCZ3aqtL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8F25FA29
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778344964; cv=pass; b=XjvyZnkgNgDWv4xVoR2TqsASlIXPAuyv827U83oFH1SGX48r0QZmshgk4ve54STzwQqZEKO0/iYnr+VngZlV6A99bkD8/8xgMFHXgVULE4V0xyocLE9edzL5kavKmpyJszTCBe+t0tIG3sCxZhGpNrA0/jpalnGOKPnp+ZYlygk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778344964; c=relaxed/simple;
	bh=7wSiq2/Zm0HC0kiDhTY7nb7SJGXcV4ocg6c7UgxtaHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m52AxceZmINmTlyuOHr5v14zK0hANK6ZgQ0pnkdPIWjk4g1aGsCpjlKgU6xzUKGbvE1HMVD6FtQuKacIxOAmrXllKmp3C2kQpS3E/HGM8RPTmTVHCOvDydo3apkXYjUGAI3B6TNZFMTnEYCotPnPpA6eEyHEJygd5eIeUs8sD88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCZ3aqtL; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8b4aeddfacaso31205046d6.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 09:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778344962; cv=none;
        d=google.com; s=arc-20240605;
        b=M+RBsCOKqID8hMFB7Uams6hmhOwDBMdAsUy4aUxPsWm6l/HTD1iS0/3NX0vx1kkiP1
         QeR0YIOEEkQ9kZCYVY5hstI58Hd1ST0Zj8CNkp0aw5DNR7dx7elvt/GqhAaHeAa6rHt9
         wSAUUeHBgtIhQarq7yNI7c2twexhfuBl3/iMahKdmZiHXw/gSYjydoPrU6S0ApsY7/ZC
         Ij30fboiQdx+VKLPbukv33XKnp0ACLHzu81WJMXPazawcA0u3kPzr7hhP9YVVlvvYbKZ
         yfkM4jhMnRuTqgiIwhiti0EdhGeMEJGK6F51nQuZ7eaptkPD08q8iywwno/k1aOJOfES
         nSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7wSiq2/Zm0HC0kiDhTY7nb7SJGXcV4ocg6c7UgxtaHs=;
        fh=Jx9KKqgRIegOEHqLfdOR5ScMlFS5QcHHPc2uNoi8UHc=;
        b=EJaYJnjAlQZ5tHaFCtudc/zqE9s8jd8BK5d+lGRiI9ZXIXzZ6mtJFKg0pPgQBjgg8d
         Xxj087OTU6vKku4XVqCSFUSYT5eiXK6gldoquafxw8NbiqVuZIEz5uUCrzDYX242DMSt
         76K7Z3SBUHMESryeLgwnzvmj9PhvR+jVsLWs+WbcpihTc4DEbQDYOd6RE8wtCkdrF12k
         YSEpno+iQfWxDaFPeTC//BizV1hmyNnRTC3BYlOwkJl/NdZpvQfJT/NBqzfzcsaX9MVT
         LPkWMUZE0V4rgdykpzJLcUlyv0ZaxHzUVP32smRHbUejVYbjNdbpqQWTjCpsczn4hCii
         S6oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778344962; x=1778949762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wSiq2/Zm0HC0kiDhTY7nb7SJGXcV4ocg6c7UgxtaHs=;
        b=eCZ3aqtLPbGYLUFUhOT1Gz4mF5NPSi6wvxkjcXejbowMPONa1W6uZZGfSextuXHTkn
         4B0CIfa7SnmymFQ53lvYO8khkZtQ8yat20hXK4UgBsy3RYJ7cDdzKdFtqVVQeRzc/wDk
         /4T7PhIo/+cCnDGlpXR6J+dY3OV6BEb0mFxPD7gTUZEI+ISRpgoy5UDcv+/FJrs6zIhG
         hUUiUGZpvGyZmw3gmMyYKtDm28h/Oejr9fw0lz3OMTOHU9gJ4PxHfOXAipGyJSxIRY0y
         7o6Bcn9kDHcuWhUmSeWRxPdxYhhNT7gj0Wp09adc2EpvGxNcGxf7vXAv5H8GCWRqhLgH
         uJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778344962; x=1778949762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wSiq2/Zm0HC0kiDhTY7nb7SJGXcV4ocg6c7UgxtaHs=;
        b=dMrgWT72aCrHB/8AKz+zclQLkmXdVJVg2DqiQqsHk8f2SdOjVRfMkocjbvJoqreqFh
         WLHjKaFPMuNnppTKkcmYXt5qQVqaoh7zRcFWyGuU8THEa+VByIVYW2rN03SPJmieYfOs
         GDS4/NWGPUwrhWA3DPtWgCQEQhEA7kAiHERRUlCcIKcXPUHCfOqh6PVOLyfD7dcznjR4
         PJWVCq6SYfsE1X7wx+XtuS5QX7XBxmdoIIsQWw2/OGG3c5hW5ZevIxR4Vrx3x4C3MRcQ
         e9zbXN2hRrXkLuR/UGVB1+AF+BW6RRA8fKLZ6teJPduriqjxTez3PysZHkty5P//uXQm
         CwGg==
X-Forwarded-Encrypted: i=1; AFNElJ+s/luqyEQdss2nm67zw5l8acz1aGjVFuYigUBES5NKNczhlUUKHpm3vGNSL7VDKmgv+PiCWX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyodh8dEXROFcMKDUzkmyfHO/mNojNg7nFPJ3f+GjVy5RPYuxcS
	nh409Ww/V+YKmmgQrnoCRAT+78Bm+v4FzQ8nWRMJZhLhEcxmeFY5Vbi5he9EaKyaWNyXG6eUvxv
	E/TDu9dvsErrGNdWjSt44iH5y/qvjC2GGcaEurEW84Q==
X-Gm-Gg: Acq92OERQAiOORyj7H7JDROKEOFRC6dH1SE3U6Cs4inQoH+9gvMZ40TOZcPtFU1lODq
	w7iYektxd841PMP27IQ0ieqr2pgupGW7MGg0uCvTdKfQY7AGoY/ABjVo6Sia06+Ajii7T1tHODq
	WEFdVVQj6pbnAqeIwnQvTDSFvVZd0wZjF9osFwHa+t9SY/aM1PDmRofpSbK/FWXAb0JEKaqOfTh
	8nlP842/ED1VqevI/vMVybFDKt0dSszct3qOpRzJu1O4fCwIXpc9EEakO4/a8kas+xTEH6EcUcO
	AJ92+2UWnlmzXIrAvQydNnBVb4+DhTZGOXMx1pX0PZ93eH7tUOLChrCz9SIhbdf7SMX6
X-Received: by 2002:a05:6214:2301:b0:8bc:6d05:34d4 with SMTP id
 6a1803df08f44-8bc6d05399cmr252564126d6.1.1778344962425; Sat, 09 May 2026
 09:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509021935.36898-1-enelsonmoore@gmail.com>
In-Reply-To: <20260509021935.36898-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 9 May 2026 09:42:29 -0700
X-Gm-Features: AVHnY4J1r1kZXtU33EaBQ-rMZpnPJxJ1LEMcFAPFyRzi-_XHkPw00Xna6Ax4laQ
Message-ID: <CADkSEUjre6bw62NpOw-YnR=DnQznFmj=iPD5Kg5npSFV+cQq6A@mail.gmail.com>
Subject: Re: [PATCH] arm: orion5x: correct machine ID check in mss2_pci_init()
 to use DT
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EAA8B500879
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244978-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,vger.kernel.org,lunn.ch,gmail.com,bootlin.com,free-electrons.com,lakedaemon.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 7:19=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The mss2_pci_init() function contains a check for the ARM machine ID
> via the machine_is_mss2() macro. This check is incorrect because the
> machine concerned now supports only FDT booting, which does not use
> machine IDs, and therefore it will always fail.

I have been informed that this is not correct and the kernel still
considers the machine ID when booting with FDT, though there is still
value in updating the check because it allows removing the machine ID
from mach-types. I will resend this patch with a fixed commit message
after the 24-hour deadline.

