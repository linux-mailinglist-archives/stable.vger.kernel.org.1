Return-Path: <stable+bounces-188945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A8BFB1D5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC811A01894
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB173128A5;
	Wed, 22 Oct 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lzmcFTb1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2A2F83D2
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124622; cv=none; b=RWXidmpj9kd7+xPRTwuilMDoSs41dM50DDNOrrKLcJAYECNcRNnUDO0MTc91cNAKP/CGPmHROWJNfKgJY2680yhrN9BwkQMyXGFNj6Zk9Up8sBYKhqfcLc/TcARFm+CIicJ3LyRa/w/2OJj4gwzNK+Buh+gxnosHYh/a7THTRa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124622; c=relaxed/simple;
	bh=uT0LN1EUMQAZ1v7BvLjcq3iXoGtsuTlf5kkUSCJBu2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5lkOhkd6WFfJJ/UfmxmV9uomo5I3dSX+Ib9HWMqZKPsPdcIsKL80jsQ916AqRhMqp4nph6Ltawys0hTX3FpyHuiFanqt4bXS3sXUApMY4qhgG3We6cOPnGDtAtAvplvD/inDD/4op3t/Wg8oOV/AfVOgl47JxErNQRNfHbtvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lzmcFTb1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426ff4f3ad4so3572815f8f.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761124617; x=1761729417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0d1OtznxSM+pdxcYthlznRVSRSBvTGMBZ9iBozHqpE0=;
        b=lzmcFTb1SODOtoiyQ5JVKp2d3GabR4bWNAXhGO5+FoC7+FroHz8FrRI0k9/Y1N9B6u
         Pl0MPnTexWeyjwE30rIRo2JBSQ/OcumJWSUNhERSloYQy00swhWtLoiXPGMXDVKQgl/8
         zvqMZtnla+/is7pG4tPjV8qa1BamJTwaGePaqrC1aW+R97t7R2QYCtZCcq+V+mXfyz7c
         YXvha9x5Y7+UKFcwM4tK/eoDvZcuEKeLyWhM3F9SHMGKCdp6wHEJKP22orF8j1yCKTzf
         EEH/sxMWZyZjuUPlD4oYktpDQ4spw8SaJXLd9YBA6vUTm9mtMBOokgPWTUnKPqkXvTu0
         nWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124617; x=1761729417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0d1OtznxSM+pdxcYthlznRVSRSBvTGMBZ9iBozHqpE0=;
        b=JQZli4RKXwInixThw2fCx1e358t9JQXTK6FpLrqANTae0X09PEsxFI9Q/Cg2F5Jo2Z
         tIi/W7J3V2jy3iFXlCp5eRIwuyr6cnmhoeHQaJTrsdmIxuUKsVZO6sYddaOJGnnlnCHR
         oQotCpkym2DIBPxIGE7M6rhbBwNCSkNIkMaokUT0N8WH8XzYNSVgxaw2emcM99AjdrXz
         VRlo7oWWhKQ5zkh1Z6WSvMbIlI1BqTzLJ+KcT9diLvC6aI9wdfnlq1+Mj7I96hvbjtmx
         NpVJhZ8pKp8TID515wlSYadSy0/u1EeoBK6w59lnALn3yGd3NZQObaRszWXoYGc1xKzr
         5lWw==
X-Forwarded-Encrypted: i=1; AJvYcCUfOsnuSlX0RLl+lGjS38Nd068W4xFayiBrVcF2NxMN76H+piIhQLIgqJe/yRE0ED7WYLEpItI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYqyqo/aEJvJmE+AEjJXDHP1uXJKfMDzVeexdeS/GRBK7U4uJ8
	IiDXdL7rDeg7R7cTkGlXADGvV5gg409PoONHPwAXhjzlg9ZS0czVC/w=
X-Gm-Gg: ASbGnctafkXnyMOteGY348FzPegw/Ai1bQu+AoHbx61rpSgpru54swCrI66ixANgx6S
	BVEouktxaekOdcQj1TzyznbOowvfVKKQ+fyDGE6Pqx1eP3XaZ2dcVbjxAOVEQm2GVBqyYTAhaPE
	T8I32XGD7/x+MYCVEuD6Gr2mkRTHg/PISv/QEloEa9npA0PP51CaKSsXuAlm4sjjeLlv1Us51MZ
	6S3BSIB+MlMabyUr7dJyZ09fySOIYDKt9yJx8SuFPoB3cj7gIjVtGzGp6JS9Tqv+jkTdrNutzZa
	FJgZ6nAVWzpxZdxQMWgch0FSo0UUW7uXe79Wkw8SL9mzmTafUjPRf7BNYUT774sri+91vM7SrsZ
	hZnSM2tU6CF0gO2EoAUo4od6j2Jg8nfEzfeYflLSuVCJ7coou/8i5mVc2IR8t/B1+Zi5TcKAzUj
	BqXSiEikvO7Gm8u0k3hjqxkwEmlRMukbsrUYC4DiPQMjEiBZgIqywJSAjLMPkL5w==
X-Google-Smtp-Source: AGHT+IHa35nbyTK6Dmlfdg41+HIA1hn/cBaTOnRlZDC5R3mjJeMyTqjZs96LilY2c+rKxD8zCB0KXg==
X-Received: by 2002:a05:6000:26ce:b0:3eb:5e99:cbb9 with SMTP id ffacd0b85a97d-42704d7eaa2mr12913918f8f.10.1761124616882;
        Wed, 22 Oct 2025 02:16:56 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f88sm23394732f8f.7.2025.10.22.02.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:16:56 -0700 (PDT)
Message-ID: <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
Date: Wed, 22 Oct 2025 11:16:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
Content-Language: de-DE
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.10.2025 um 11:11 schrieb Thomas Zimmermann:
> Hi
> 
> Am 22.10.25 um 10:08 schrieb Peter Schneider:
>>
>> Your patch applied cleanly against 6.18-rc2 and the kernel built fine, but unfortunately it did not solve the issue: 
>> my console screen stays blank after booting. This is regardless whether I do a soft reboot, press the reset button or 
>> power cycle and do a cold boot. They are all the same.
> 
> Just to be sure: you do see output at the early boot stages (BIOS, boot loader). It's at some later point during boot, 
> the driver loads and the display blanks out?

Yes, that's correct.

> There's another patch attached. does this make a difference?

Do I have to apply that against base 6.18-rc2 or against 6.18-rc2 + your previous patch?


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

