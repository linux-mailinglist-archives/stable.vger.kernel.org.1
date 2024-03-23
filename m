Return-Path: <stable+bounces-28659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A53E8879D0
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 18:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591491C20B92
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94B535A6;
	Sat, 23 Mar 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIFtlk4m"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584311EEF8
	for <stable@vger.kernel.org>; Sat, 23 Mar 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711216197; cv=none; b=S7cSRg77+sRfKj87NKlFkU1Ex3S/r8zoI/xmkvRpflqybqi/gx10YFr+WPudS7vVX0bmZqdBv7bjb0LHmDZ/7v+HZ0S+SkKJLZV2BPu3vLunAq93N+JDpjckEZZFwlo/0Qg2A79wm40kGxD/ujG/bx/6SjPxxlsd6pLuXhQ4TDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711216197; c=relaxed/simple;
	bh=XXcYh3g1PoFWVmk6OQsHSvCqzvu5bJ/43aZzu0g0Gyk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DJEiJXg83DpIBksPIV3BeDLUd6hAW1Ev9lqsTARS26hRhjySCIk2RcPt4WT5NDX33L9RSTKcZ+LLC+MLDUUkROKjW4slkTVEmTbkwx6GuRQBWxhdRRQJKT5ZfWIMYJTK8RG9/RQybFkyIEJ2uGSgh0GYP9KZegk/t5A2QltoDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIFtlk4m; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-222ba2a19bdso1854364fac.1
        for <stable@vger.kernel.org>; Sat, 23 Mar 2024 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711216194; x=1711820994; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+Ub+4RUktPVGDechh3+AsinqjcVtytPxzuJI7uSOzY=;
        b=mIFtlk4mvOBHRnOFeovZ8s698mJ5WpSxdov4U5GggOlG5ea1wSTZAjUkofdG9buat5
         +PAhs6xQl93LP+Z7QRBKIScUkmpjHtPtqIvccFhY6i48sn78lBHu165hVGxMOk9LwYjh
         +J91P5EKV/J7SnZriaOSV3c4ilkWBUqPo0tAMAriV2xQ/+J9KWcseh1bcS1ZqWbyGxfE
         SuI+1iP2kjsksR52hMZAOnoby3Yo3RHqdtKNDIzLAKhsmXjOIuTLstcIdvFj6PuBj6UY
         IadC6mgAN/78XjYr5GfIPp6O4898xdJi9bA2k1kSABtbw+KFw52q6pOh2+/43FHQLZ2j
         sZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711216194; x=1711820994;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m+Ub+4RUktPVGDechh3+AsinqjcVtytPxzuJI7uSOzY=;
        b=J1gSFZs5+a/J5x+RnAcZEkOc1seezmSqI1IbtS0souvJ6CJVD2xoeZ0oZocoUwBXHg
         6boj9GLetbKoW34EAE2nZg8ZBNN7yTbfsoHVdeduG76uUU6OlwjDTHjrot30VrKGjmSK
         TjZsJqlBlUdMXY8NsCegHJ8MoR2VBO3jWF9q+tqokgT7hJWOoKEG49ECziR8kdOlPHym
         1GgCl99EtZ6334+K62zHyCOZGe6aNtvi3rPdZoY7NiIEfyVRJRz4uDROs0oJEGFT4oIX
         9KJJZHfuU+SOjPgwKYINNlktujf6uR3dENIDPO0W/AmcUALixZBU8hkbk4Y6o9u8Npsw
         RIyw==
X-Gm-Message-State: AOJu0YwvoAqUwNDExFwyMaFbhtWrBorydSCH2JNDapFnSbWcbZwUSPmE
	tLdix18t+dXfkhpy48Z7s5uWMGWNm1I4ngKC99BFylNGBnOX+vxWfSlKwJRA
X-Google-Smtp-Source: AGHT+IHKKto21wwHRD8k6bkUNWl+o6M1BjNJNxMo/fYEx7NhH0kN44JfvA/g1PGMxqQKMHlBQN5gaA==
X-Received: by 2002:a05:6871:107:b0:229:e636:921f with SMTP id y7-20020a056871010700b00229e636921fmr3319606oab.49.1711216194438;
        Sat, 23 Mar 2024 10:49:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id op9-20020a0568702dc900b00220a82352c9sm580320oab.17.2024.03.23.10.49.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:49:54 -0700 (PDT)
Message-ID: <c5e3c677-0687-4417-a8af-b5000295309b@gmail.com>
Date: Sat, 23 Mar 2024 12:49:53 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Mario Limonciello <superm1@gmail.com>
Subject: VRR on Framework 16
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Framework 16 supports variable refresh rates in it's panel but only 
advertises it in the DisplayID block not the EDID.  As Plasma 6 and 
GNOME 46 support VRR this problem is exposed to more people.

This is fixed by:

2f14c0c8cae8 ("drm/amd/display: Use freesync when 
`DRM_EDID_FEATURE_CONTINUOUS_FREQ` found")

Can you please bring this back to 6.6.y+?

Thanks,

