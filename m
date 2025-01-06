Return-Path: <stable+bounces-107770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A8A03324
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 00:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7B81885C45
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCABF1E1022;
	Mon,  6 Jan 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNAok+rn"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB41DE2DA
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736204735; cv=none; b=WezNPrs+ROVYGw5q5BOCgQpznONhaNy++LjNOM8OBE1cydRJnww5vHzQMJvVK2xYQLbYjFmxIPaDJTvLz+izaEOcB046NuktOIcVoM5HC1RH3LYgjsmHSuhHxvEtu2FBKGPPW+UPpdo5J4SkHRAVW7n8o08nCBFP7NL6TX6d6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736204735; c=relaxed/simple;
	bh=ER5Yz9kOS4M3qneRwV1W+hbll4azflGc7w+oKnUTlGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km+3QqYNW7rGDq62BBdrRhZ+FKoZtafAcixeXsJE9I1GGoRXmDorGK0NcLAXt7GzUezkkj0QJeQXxZdDmZWpcnH7CD6KNIsZPRCuWfZ+8V+j8opPZcXcoFGqhSiexYli0xHrj2qFBDLC6LfqGbsKOLocVSr2bI9MRTlvWXLyyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNAok+rn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so115231915ab.2
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 15:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736204732; x=1736809532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO8rgVVnKrlIP7QnNtiMdBIDZhjxV64FAnnGDxLCHec=;
        b=UNAok+rncTTt2h39oB9YYZNhWoweOhaR2N3xNr+sl2m4G5skjeGJ5LkxtNhHRTzZAT
         ud+DHVxafa6e20FY2ID5J8G7XqBIeRz5mdD+Wa5XYmZt6KP5d4yvd85I/NPtQseZi2y6
         RbZlwfvc0GrHDD/t008gQhe0M2iCuFmxrEabo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736204732; x=1736809532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WO8rgVVnKrlIP7QnNtiMdBIDZhjxV64FAnnGDxLCHec=;
        b=TH7NidiHAVzK/rugCvK54zw5UcStI0Yyboi1MkChTRwxSZeE3Joystuhi8FlPA1Obo
         oKzetC8RG4XFd/qe8eds/o06G7tM24u49dgzUGXj6JbS12Yx0eR+EVUMpCq53eX/8pId
         mhjsHpbL/BgC2dIxaz4KGIl5NoVxnXkyJiQeDhuXKeZ/TbW5YOAz0LKHWVqCgBkX3Hl3
         W++iObICQ+gpN0MxEyUvMAVJlm4HZSdfksxoSROd+pyDyxC/RteER0xDHjBAYQmrSzlg
         1GdaQcqQ1wmIXqk7z9XZS6t/d7/Xje6WfcJWgBK78kehp8VScgY/xArSMGj2Qail0xPj
         YqCA==
X-Forwarded-Encrypted: i=1; AJvYcCXWHnq7JFsvQB8HFU1iDkKpz5dbO9YL59w1NIfjAIcYsHeTAck6jUtZeSGSpxq0fMO1S0lXZJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjI8N3hclZKl+bV+2DhufQdVP0GaCGxRkvgEd+GeWQkpuhUYWG
	0QK00Ewz7QSsH6pzvy/Dhoid4VDFYd7R3crgLwFqvzsRlyYQFfo/SUK6hOHUm/M=
X-Gm-Gg: ASbGncs1jKq885kYj1gnkZtWcr0HCR56OvLjxNbCXfLsDTWs9wZlTerYLosaxNDIaqw
	T6w6tFMADYEMFPBzR7FsGHt3iVXkYhT2OQ219aIqimHdMnvVp73DYf3cQqIrZviA7I56pk8hgWk
	9PRpv1fnIfkpEqTl8s93zQ5x0h9MW16JP1Ob/4FPM2qtJYysLiW4PanTjh4GNQ9rr1UqbqsvTAm
	hknWg3hsr+H2sykRmUeel1+c34Vnljre3EOSbh+63Ea6gCrfqu6+hBwxrh/xVEnevLp
X-Google-Smtp-Source: AGHT+IE1ug/ECMGbNrZ04hdqCJXBEemo+rZ1EKtJhngCH2J1PkN1z+o+R3HTuRNgGuKy8C5cyCciog==
X-Received: by 2002:a05:6e02:52f:b0:3cd:d6a7:dbd1 with SMTP id e9e14a558f8ab-3cdd6a7e190mr63730045ab.13.1736204731905;
        Mon, 06 Jan 2025 15:05:31 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf7ed01sm9645635173.66.2025.01.06.15.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:05:31 -0800 (PST)
Message-ID: <d0e2b7d8-cde9-48f7-a931-ba204deb3a47@linuxfoundation.org>
Date: Mon, 6 Jan 2025 16:05:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/168] 5.15.176-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/6/25 08:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.176 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Build failed on my test system with this commit:

	999976126ca826e40fd85007a1b325d83e102164

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.15.y&id=999976126ca826e40fd85007a1b325d83e102164

Worked when I removed this commit.

Errors:
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: In function ‘dcn20_split_stream_for_odm’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1945:40: error: ‘const struct opp_funcs’ has no member named ‘opp_get_left_edge_extra_pixel_count’; did you mean ‘opp_program_left_edge_extra_pixel’?
  1945 |                 if (opp && opp->funcs->opp_get_left_edge_extra_pixel_count
       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                        opp_program_left_edge_extra_pixel
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1946:48: error: ‘const struct opp_funcs’ has no member named ‘opp_get_left_edge_extra_pixel_count’; did you mean ‘opp_program_left_edge_extra_pixel’?
  1946 |                                 && opp->funcs->opp_get_left_edge_extra_pixel_count(
       |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |                                                opp_program_left_edge_extra_pixel
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1948:41: error: implicit declaration of function ‘resource_is_pipe_type’; did you mean ‘resource_list_first_type’? [-Werror=implicit-function-declaration]
  1948 |                                         resource_is_pipe_type(next_odm_pipe, OTG_MASTER)) == 1) {
       |                                         ^~~~~~~~~~~~~~~~~~~~~
       |                                         resource_list_first_type
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:1948:78: error: ‘OTG_MASTER’ undeclared (first use in this function); did you mean ‘IFF_MASTER’?
  1948 |                                         resource_is_pipe_type(next_odm_pipe, OTG_MASTER)) == 1) {
       |                                                                              ^~~~~~~~~~
       |

thanks,
-- Shuah

