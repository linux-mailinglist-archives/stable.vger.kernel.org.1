Return-Path: <stable+bounces-118234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D71A3BB09
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2A73A350B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4B1C7013;
	Wed, 19 Feb 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAnF+0bO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36231CAA9E
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958864; cv=none; b=usjP4Jtdd0SNd2XiLZwkz+lxi2qWls1UT6rXkNuB4FsjJ1G9D16hNTrQ8Y5S/y2Oc4By9NwkR6PtGfJqz/L9P7gmjA+JrGaVMQ3J6phpMqkJF32A7qmYM8/GCbCXfeXQxDKHaXLrOgGtn+0uXzSyZ5WdC+x9/nOYk1TX0cbVWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958864; c=relaxed/simple;
	bh=FfvqskgKTPSFoGOkrm9Aj6YyyR2dEeyLXz1vwGuyTu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyE5I8Z3cQHR+uQSqJAmlMGVln8JcVOQe0oiq4+VLs86WbtIPOY47VAQaKo8DWzn6k0rhi71BBW4+37SV1NmYUzR6KaXGUzHgSKin4xBm68WXSl3z8Bs50GTDcJMxa6Srgdyf0jw0X4/ZNXXQkPr/6G+spJJ6bvD3Pkwesfn7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAnF+0bO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb7f539c35so808236566b.1
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739958861; x=1740563661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzWk2OL1SOHfTidLq0uZH1erG+Z4ao2Q35XKqTe/yeQ=;
        b=kAnF+0bOo3xdWqoiPTLxB+O1MNua/OEo3n2XFVQbai/ccqVPOTWTGJfHzdFAfl8vhV
         6tl6Aqkl9QL8dNSaD+vnyS2cj9fEsgdvm7haYlNzSTqXwTmMyMbf1d8/YhWzFlW/oHR7
         POEM1NvuUqNEBemFAtRvkTBS8d9x1Fi4JQEROVKisF48+YblozjYIcbn20B/b7VFlix2
         KWUUIyulj/G07bpMEFT5wNzj7fgbamAZP5JkYV/9oELo1u4EXkBOmTgO0gEOvyzLbHYh
         Zl0ZIuXs2uvgQ07B8NDjg+ZZsrmiCeLEeXi+UJZxy7nR1H7Ft01lfhBHgbm/Kzi3RiPZ
         L3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739958861; x=1740563661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzWk2OL1SOHfTidLq0uZH1erG+Z4ao2Q35XKqTe/yeQ=;
        b=chDdhks76XhlIKTlfFUVmthVgidkyg5btlcC+X/5dXyM9Awk9jn79sCQmfUPBhzcm1
         HRKQeCoUFwLuq7Z91Iqd9oVinw5hmQrGDDqH125jJgLcjR6SNLpBOqN2JTWOISRG3Uts
         T6XWN7/Z/kyhE4jGXkc8Hy9aJv2hu0pYNtGGQ6SNKPvI1ESIxz8Wizo+HYXk4t+FMOfp
         FmY27JPb3efTOSlZfYXrBxligOfYngMWgX1yy/qN/DGpB7EB3PEuMQaHvrUzDONlx9Y9
         93QEyMf9dlztW8+iVgTrsZ0q/guh57HfQ4E4qkU2FmAAy31NlgIMIQnF271TejmcOJRn
         2Z+g==
X-Gm-Message-State: AOJu0YxqArpIFD3UrU4U38OgnDa5ghyimPQdY8B1kuXg6XHD/lztQBA7
	Q8MLa0EVz2tUOhFQyWP5xI0+v9aoxtIL0lwm7MP3csUMOtDIFSCy
X-Gm-Gg: ASbGncukK90bNLIyiAmyUYBhIFmdTNeKZCywcA98SRUBM5ENroxASQof/LHZe3QkYdg
	X/V3ScHm45aiIY+UdIKz4pH2cAifQkXJ9uWHc7MKvytyyA/45UiDhV+Lk0tYaFTLT0qRC5NjSdt
	3bCtBnx+EQB9ayv2uj6kpG4m5vRMDroIHeCdit6v7u4RDAwxv9gks2dHnc+E6kUYWn0FsEFugil
	Bz1dfg97BpxBqTTz2RWrJ87yquTwg7y5Ljuy0+vCVeTJGgg/aURZwY7XBiLz0NS9SIDgZx7hXyg
	qFO8BRo+mgKLoeg4HCj9vEqbTr2I1InQifPVJJTwS4noO4E+OwH1UO2/bQ==
X-Google-Smtp-Source: AGHT+IFUXdifchAYRC2XVoOKv+l1G2LwyFmvENSZSxzDWHXbNHiK06f8CYAM43WM0AmfoIIoJt2Nzg==
X-Received: by 2002:a17:906:395b:b0:abb:b12b:e103 with SMTP id a640c23a62f3a-abbb12be1fbmr762017166b.34.1739958860993;
        Wed, 19 Feb 2025 01:54:20 -0800 (PST)
Received: from [192.168.0.9] (pc-201-96-67-156-static.strong-pc.com. [156.67.96.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337673dsm1226050966b.89.2025.02.19.01.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 01:54:20 -0800 (PST)
Message-ID: <7083ab36-715e-47b8-be46-591b5fedf8a7@gmail.com>
Date: Wed, 19 Feb 2025 10:54:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 116/274] drm/amdgpu/gfx9: manually control gfxoff for
 CS on RV
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Lijo Lazar <lijo.lazar@amd.com>,
 Sergey Kovalenko <seryoga.engineering@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250219082609.533585153@linuxfoundation.org>
 <20250219082614.161530240@linuxfoundation.org>
 <96738386-9155-4eea-b91d-8590ef3b4562@gmail.com>
 <2025021944-imaginary-demote-31d1@gregkh>
Content-Language: en-US, pl-PL
From: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>
In-Reply-To: <2025021944-imaginary-demote-31d1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It builds because in 6.13 and older this function has 'void *' argument 
which is casted to 'amdgpu_device *'.

On 2/19/25 10:08, Greg Kroah-Hartman wrote:
> On Wed, Feb 19, 2025 at 09:59:05AM +0100, Błażej Szczygieł wrote:
>> This patch has to be changed for 6.13 - "gfx_v9_0_set_powergating_state" has
>> 'amdgpu_device' argument instead of 'amdgpu_ip_block' argument there.
> 
> Why does it build then?
> 
> Anyway, can you send a working version?  I'll go drop this from the
> queues for now.
> 
> thanks,
> 
> greg k-h


