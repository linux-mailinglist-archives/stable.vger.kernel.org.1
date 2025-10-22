Return-Path: <stable+bounces-188896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BBDBFA202
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A509219A4CE1
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5B224893;
	Wed, 22 Oct 2025 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QYBXjZ9O"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBBBE5E
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112378; cv=none; b=lEC2ZRwd/ASrV2vzkh8FgGrMTcB6/RaBZ9vxIiiWmiZyHqqMZx7cxbrvIZgk0cDkyjXYzwLV1SZuFBYWV7+R9H4pR9lmE6muJ+SNiyW4BtKcRZ5MaeCs0LHmEONwTRxMoD03Hpof/fBDNwFx/PTAVCNZ1XU0MbN3HSRALANSCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112378; c=relaxed/simple;
	bh=H0UxILmUFmJTxC9VGfLHOqB2YBpAU/rL8cCN4AvkYDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoTfYXj2DHvi2Q2mTCAfOi4IwlDokWkK+yRan+DxANyba70cCvOuBaYDd5zQ4BT/ovQ91BsmXBhUBQB6lvMsjT4HK0tloMoW31aVzToHE5Xrpvj/rWtGlT7IzGR3BqVeV20OSdPyV38zljVSzubUdItFfS4EuN4AZWcq63S6svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QYBXjZ9O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso324385f8f.1
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761112375; x=1761717175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qTaxXHc0odr/JWFQILy/0jeEMddwplEQInrG8Kvvg8=;
        b=QYBXjZ9OxXwuux8SFUep5A23OjWDXHdZlD9TG1krowYLgtCz8Ju4aiWmbNCrLImq5X
         jg5ULA7AX2CPzbAS6GLQCk4xKy0FcVXNg23QjXJK2dvSYHbg+yo2p1jIASb3GOx4o+E/
         AeGr0hzPv8o+Fq+yO2R7tfGLnHvKpJqF+4z5EcX/z1AfThG+mz053XBsJpHyy/nnDzJb
         BssFsaP6nqRfd1j9xYCtuP+lIBiDkCfk9n16U3QrvqGY3+D8xqqUdTJD8V2f+3kqU9Sr
         EYqbySu/hd/glkqm3o/TiUB2eMHCl33g6MOpX8W9azkDQTDgKiUOrQsUTI6VXN1m7NDN
         lxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112375; x=1761717175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qTaxXHc0odr/JWFQILy/0jeEMddwplEQInrG8Kvvg8=;
        b=GC6C7jCSUrKmp9jXcK7BbIjC5b3ABeBfI+FAhGsVF7CCb+cDx1ZIXOJ6G8el5ge6N1
         MgBigf26tuCwhzj9KDqw0bLFeHKYrP7c/3KeKu8EsAivpK8cXUN0K+8hnDpGwnALG6kp
         M0p/pXGQGc06MhvrtSGtWFpKXUYpVRyAxNoVrd23b5+RKEtuiWk04ylJtljxTy6pAARv
         3EYHaos7Pf6GlSKz5WRoDMVlQdVIZnzqR7pAfXrSV5DBF5G1OIWsQZ7whVFX/SuzsT2l
         HZ2Foc3S9N+Z3Ca3fLcSyIiX8mff7sZXm770AoQq6v/XdKwP733TuJb91r30BxcUQP7X
         uqtQ==
X-Gm-Message-State: AOJu0YwZWNLiIA5QnDOC05xerDp0kht7TJeE9gX4tQ0fBxvfUCEVaaus
	hUwKHiVZFnYNJlnZZ7dTzuIwsLUT01hqDhxZa5C3F6MHMIruBFGZi54=
X-Gm-Gg: ASbGncvNmIkeT0HVKzekOvmvFW1nvAOMq0IoJh+Y0oyDXKrJd5PixXpL/iGzxZU5BtZ
	7LR2hFsMETgBEpJh89uuvNRvTANnw5SKIhQSYeqUSzNjBEakKQ1A4n3MuAfH9N3NtscYhJ+auHY
	g9tOV/kD4ShsEeHGvIXvUekyvUEX+GY2WQAUi9xJvsb0fhF2f3OZ4TyE2o85tA0UPAu4DlxM5Rn
	qiL6C2giCRjrkDXllf8LKDdV1GQjSnD347Dy0JxJbHOOjyVF3jz7ua2LPcntldhQ+mCpZfHT27i
	HGkH6UhnQpB7HmSe24LeNqo3Pgu1YKkmwxb/3AXv3yO75AElRPQEYW5XzLPgbleyosoNy6wy0cZ
	cc55ExYShCKtZbpINjrGs0fItMvCHMEBgrL0Vt1B5ywiaEuhOWKJpHgCjDKzOx5eRpJLNMBu4ZR
	rNWuOsVGYDFIBiwpFahKyb8VSIv7B/fnnkLdPkdMW/vajCQjI76nVi5k1N3VFs3w==
X-Google-Smtp-Source: AGHT+IGaXuonT12yrC1omcvmYN8cKYZBhHbfpNOj1J7o5Hhyd3k15v1KQ0NH5QOy4oOd+nt52eeBHg==
X-Received: by 2002:a5d:5847:0:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-42853264c37mr1533870f8f.16.1761112374479;
        Tue, 21 Oct 2025 22:52:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3f5esm23079194f8f.20.2025.10.21.22.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 22:52:54 -0700 (PDT)
Message-ID: <af5633f4-f339-49a5-9047-2b0682e50584@googlemail.com>
Date: Wed, 22 Oct 2025 07:52:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 040/159] drm/ast: Blank with VGACR17 sync enable,
 always clear VGACRB6 sync off
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, Nick Bowler <nbowler@draconx.ca>,
 Douglas Anderson <dianders@chromium.org>, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org
References: <20251021195043.182511864@linuxfoundation.org>
 <20251021195044.163217433@linuxfoundation.org>
 <499eb508-5f24-4ef4-a2a3-f3d76d89db66@leemhuis.info>
 <2025102235-pediatric-sandlot-f2de@gregkh>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <2025102235-pediatric-sandlot-f2de@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,


Am 22.10.2025 um 07:28 schrieb Greg Kroah-Hartman:
> On Wed, Oct 22, 2025 at 06:49:21AM +0200, Thorsten Leemhuis wrote:
>> On 10/21/25 21:50, Greg Kroah-Hartman wrote:
>>> 6.17-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Thomas Zimmermann <tzimmermann@suse.de>
>>>
>>> commit 6f719373b943a955fee6fc2012aed207b65e2854 upstream.
>>>
>>> Blank the display by disabling sync pulses with VGACR17<7>. Unblank
>>> by reenabling them. This VGA setting should be supported by all Aspeed
>>> hardware.
>>
>> TWIMC, a regression report about 6.18-rc2 that was bisected to this
>> commit just came in:
>>
>> https://lore.kernel.org/all/a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com/
>>
>> To quote:
>>
>> """
>> I have encountered a serious (for me) regression with 6.18-rc2 on my
>> 2-socket Ivy Bridge Xeon E5-2697 v2 server. After
>> booting, my console screen goes blank and stays blank. 6.18-rc1 was
>> still fine.
>>
>> [...]
>>
>> When I revert this from 6.18-rc2, the issue goes away and my console
>> screen works again.
>> """
> 
> Thanks, I'll go drop this patch from the stable queues for now.
> 
> greg k-h


So Thorsten (thanks!) was 20 minutes quicker ;-) But I just tested this with 6.12.55-rc1 and 6.17.5-rc1, too, and can 
confirm that this offending patch breaks VGA on my machine, and that reverting just this patch against either RC makes 
the issue go away.

I'll retest -rc2 too when it's out.

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

