Return-Path: <stable+bounces-204539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B7CF039A
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31153011FBE
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B8D1B4F2C;
	Sat,  3 Jan 2026 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="eYmGe+SW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50688194A6C
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767462484; cv=none; b=q6IFWPU9ZLrGIJgPiisMkFm2t0+4hLlIbu1htc+4QLPKsybOE3CQMym7Fso7CKD2S7C0AF6SLOSvOU0cWKkTblsTqi2eHIIARM2xGPGRsuuBvHlS5yzkj60zU7el/vw5euTdk7VBAEEcmRjMde9uMhhTGLBK9eXnk6kqHpuu0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767462484; c=relaxed/simple;
	bh=8se+KRcuA9rp2d9sYOZlzeTgI+u8Yrj9KucoX0STkjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4YkCZfyrQ/o7/Nle1IqOt6h9MstuahGLep4pFGhVDykFSEdoP2AUcWtdLzl3HGdwYRhOl5DmO8ytkkWsidOS7tg/i5rw5Oa8Yo0PqqEjxul59C01APxeHJRF7Sgh+EiPaexsuP5OWmLaKI5AmXm0cC7mniznS3Qb+beRh3FzIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=eYmGe+SW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c03ea3b9603so497837a12.2
        for <stable@vger.kernel.org>; Sat, 03 Jan 2026 09:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1767462482; x=1768067282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMMVHBbwwK7jtZ0OYDpGeyStVGVJxGzS7aRRfo4f/fk=;
        b=eYmGe+SWMA/X+P6eVV+0KQ+9VUIhO13Kiu87eK93p8HN/+7PnJQfJqxcDYln+0cREK
         0SOU9AGym9iT4J1sMsh1llOBmTodDwsOwxV0uC7FnoD6CBeSddjdtP6HQ2v4xvygFkh/
         TuReOFWBIyvEYsKMS8sHcz8nlJ9PFeyd3YZAi4LTo3+6ssq3U2+GO1FOgZ9/fQlzKdlQ
         sv1KonI+HPDmDv660awXsqFRFB/u/QwOE7+iZzriP6RNXb2yLJfOjKtxO75iyX5DqpyM
         xZutwCx11f9AcY3qiLl6OC/k0+w/RewHXB05vTh25gShtD5oKIO9XMKZxjtFrEkv5Zle
         lCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767462482; x=1768067282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMMVHBbwwK7jtZ0OYDpGeyStVGVJxGzS7aRRfo4f/fk=;
        b=WAs+hV1y4OojeaqLEfiH4wLIHwtjhfE9kLvyVH/wiqrqer0jSWd8GgoIK0xj5EwQvs
         mkmdGGCee7K/R7yel0R5m1kEWUeRh50eMJrAV3+Ay+5Fu68uMYJ5KY1phLgt4s33iXJ3
         ttvhEkLYgoVyXPGlhXLaLXUOO4+DOl1DPoV0L4FqjQ/zGEPFW36OTF7qfpdtEZiO4UcV
         hi321D+Y+30s+dUXwXQnTFACFaQjSX4d4ypI7GJzghjynkKkDygc0JsllqU6HpXWJ9jK
         AbeJJdc8RMu41z21mMwKeL5OuNhN5cAPiWdPwj//fpyIfvxmodFOCtySLv9pKFanyKrX
         DPUw==
X-Forwarded-Encrypted: i=1; AJvYcCXuS7pA+dIBH7offDsqDBkJ+ZfJ2mVffslUYwNXFgF7+x+69G9O7cb1q0U6G8+amg2cl+vA880=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOkrZF0Lkw83jm/jET34qKfxFSuf45WcxVS83p3Nxv5VdL0ijY
	22JOSr8xql9n/5TtO4jHVT7cdc0DYB3zUU3e01zn08Ab4Uxm3npII+OpIwfReMqQEqw=
X-Gm-Gg: AY/fxX4JtL+9VdEOI4lLEiouhuH6cNIuIbtFyogDxmY2ZSwJrm1kGEmw1F/gMZg/pcy
	Ut/oDU1KLBuMt2/0vvkvkv90kIfOz2XaglpT/o0nSOHuVfJimaa8lxnQMltOKhKigQut0w1cUiT
	SXVzud958McZh3pYHXOX/PlwQF5f0NbBDokWvf5NAq/BX0qxA35WIRkfdUFw9HkZXN9pBakq+Db
	unrWkI7coGsFnlz+wNuR393v/5N3WV2cQbz6YaQ6srJ1XlQ/jMf9PK8CuazhegNX0o/QQKUZOOa
	Hs2bNfEyMIGtCKjOwRWAuYiMGBHDiEAs4NGfu14NP0zslqmQLydJGFCFIKGjfYDj9tNSQyKUakm
	5R+PHQxrBGSXJBskjeG0XJRIyRpG7dJDojKEiVPZKo/pf2MwTX0nL07pbB7v7wBA/1xmsSMdmCh
	CJw4XJXBSxTW8c
X-Google-Smtp-Source: AGHT+IHSCX2Wf+wBy6KWMv8C+2VIUsJiFOtnLlLt7RcY6gOr5exQicuGvvlAxBa6mQbcQUrCVjmqHA==
X-Received: by 2002:a05:6a00:17a1:b0:7b8:bab9:5796 with SMTP id d2e1a72fcca58-7ff66f5fe22mr30484716b3a.3.1767462482601;
        Sat, 03 Jan 2026 09:48:02 -0800 (PST)
Received: from [10.0.0.178] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e88cdaesm43266253b3a.63.2026.01.03.09.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jan 2026 09:48:02 -0800 (PST)
Message-ID: <938b5e8e-b849-4d12-8ee2-98312094fc1e@shenghaoyang.info>
Date: Sun, 4 Jan 2026 01:47:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/gud: fix NULL fb and crtc dereferences on USB
 disconnect
To: Ruben Wauters <rubenru09@aol.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251231055039.44266-1-me@shenghaoyang.info>
 <28c39f1979452b24ddde4de97e60ca721334eb49.camel@aol.com>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <28c39f1979452b24ddde4de97e60ca721334eb49.camel@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ruben,

On 4/1/26 01:23, Ruben Wauters wrote:

> With the elimination of these two WARN_ON_ONCEs, it's possible that
> crtc_state may not be assigned below, and therefore may be read/passed
> to functions when it is NULL (e.g. line 488). Either protection for a
> null crtc_state should be added to the rest of the function, or the
> function shouldn't continue if crtc is NULL.
> 
> Ruben
>> -	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>> -
>> -	mode = &crtc_state->mode;
>> +	if (crtc)
>> +		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>>  
>>  	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
>>  						  DRM_PLANE_NO_SCALING,
>> @@ -492,6 +485,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>>  	if (old_plane_state->rotation != new_plane_state->rotation)
>>  		crtc_state->mode_changed = true;
>>  
>> +	mode = &crtc_state->mode;
>> +	format = fb->format;

Yup - in this case I'm relying on drm_atomic_helper_check_plane_state()
bailing out early after seeing that fb is NULL (since a NULL crtc should
imply no fb) and setting plane_state->visible to false.

That would cause an early return in gud_plane_atomic_check() without
dereferencing crtc_state.

Would a more explicit check be preferred?

Thanks,

Shenghao

