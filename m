Return-Path: <stable+bounces-69771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE7C9593A1
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 06:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8699F284577
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 04:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E77602D;
	Wed, 21 Aug 2024 04:24:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE715C139
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724214256; cv=none; b=rDnRXgdHA5QlzV12l7Z265QrmDHPLHm+8oHGwX05eZpcjJY84k61tLPYrHQExGLPM+RU4uwPjgZMFDfKEQxGAk9SiCynhjYIhZCe60pGSe0enz3v8N5QpYLDVMJDbXphpwcA40tv5JCite/YjLyWfrvSle4Ww2NJ/FFeZ8azqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724214256; c=relaxed/simple;
	bh=/pr3s3RdAs0hPYMn3hOCA2l5+jovt2rZKQxOHBHFnus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dh1kIjyfvx9Lhx6j83X5EZfJV442Nv09KdvcrmLLlO0bO91QNVcSk1I5w7QsxWCe5wtgrVcTXc7ehooJU2CsjOIyKisMeV3kHk8m1Hdv9k8S02CwQQ/t3BwI1sGfIh8rv3abtJtOL1cSDOhGVTcx0l+80/rCBLzUR+yV4rPFr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428101fa30aso50253875e9.3
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 21:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724214253; x=1724819053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYK0IAITUp8WsqX/ffNf+bAopyUMqgIs4u3+pK1SGYU=;
        b=cJZBA0xiahfCqVa0uwkECO+GqqUAYCnYEDtegWX3DRko9AmEcCLDOVU+Wbn6XjP7s7
         9O/ez5ffX5+FsaMtJSYjILd00jut1DG7OPCURhnmpFoH/5LRsusOdiG6wdhC0XCR64GX
         dlvsROpDMUeewMhucLpBPQytnTkMoeemZ84ZzdIbq7C4AHUbTuwIqLXMoGjD/2jS2GkX
         YZSewdcQCUMD8QjGMWc3H5HS7t/pJpe2pQ8/w19/bvya9rPIJNN/u9TOIWqoz8t+Fghj
         ENmSTFHlqh1juBLI3iHT1DJWTtIxuvCVrOS3akqfhx+3We+h5Z4cu44iQAdJ8OBpOIYG
         0iXw==
X-Forwarded-Encrypted: i=1; AJvYcCULfGJQz8Njh+5eOenKfbgB1Bhtjr1l9gfpq14pmYzuRSwHPt9pyYQi99WPst+WYg/9heU26OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZeFk53WyIDgptB7h6avfmgwX+U7SRRuqMZctA6WY5uRpN3+C
	yakwgpn/Ts3ZYtxVgb/oOjcqLWh64gs6jxYHISJiVmYNmrnP0fia
X-Google-Smtp-Source: AGHT+IGHeSHVfzIXTgULN/DUbxTBiC6WvS1wgjXJh0nSFZxu6WLwKF0uyrkaQ1A9ewLZFvJLonNi9A==
X-Received: by 2002:a05:600c:4504:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-42abd21f620mr8700285e9.21.1724214253143;
        Tue, 20 Aug 2024 21:24:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef9bd78sm10206945e9.28.2024.08.20.21.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 21:24:12 -0700 (PDT)
Message-ID: <a3473c2d-8ffc-434c-8536-933eaf1f508e@kernel.org>
Date: Wed, 21 Aug 2024 06:24:11 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
 <20240815224525.3077505-13-Roman.Li@amd.com>
 <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
 <360cabdc-3ba7-47a0-8e4f-f0ed8cea54bc@kernel.org>
 <CY8PR12MB819387431D6D6E754929ECB9898C2@CY8PR12MB8193.namprd12.prod.outlook.com>
 <0d12eb50-c51b-496e-a931-9ce8fb6a1455@kernel.org>
 <IA1PR12MB906330068545FC761DB98FCCE58D2@IA1PR12MB9063.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <IA1PR12MB906330068545FC761DB98FCCE58D2@IA1PR12MB9063.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20. 08. 24, 20:28, Zuo, Jerry wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Jiri:
> 
>       Please kindly let me know the kernel branch you are using to validate the fix. I'll provide with two additional patches on top of ("drm/amd/display: Fix MST BW calculation Regression")

Hi,

whatever you prefer. E.g. even drm-next is fine here. Currently I run 
6.10-stable plus the patch.

thanks,
-- 
js


