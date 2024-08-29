Return-Path: <stable+bounces-71543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A0964C88
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 19:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0085B21F5C
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58B1B653A;
	Thu, 29 Aug 2024 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+3DuIXH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2C1AAE1A;
	Thu, 29 Aug 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950895; cv=none; b=eD4vzRa307fd9iY3H7kfVZ9UlqKb5O4ftN9JLLSGwtxR6RR3O1NYo1MAQDxUw+1iEsp7OBOyDjDMFuJfFWlT94tN/MHVIF0vvW+wvj/cWsMEZMxnSgexLn1S0vLH6HOj7zb7vTzEBeCnpLiDr6R0liLGwz9mVzNJnzJhxIdBzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950895; c=relaxed/simple;
	bh=YehqG4PtaapmXnLiVOq9WpGytyQ7YD42DofQvtnV7HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDQJ9wlkIjKJQfS6Hi1ipTWoXIyJHNE43FnikJ+/n3FeZOZOzFpNiwKnU4joTWS49QHM8sq/pVwpP3aByZRSLyuAO0cgAJFy2LYPAAo+f25s7f4/S5JA/UVLv0nm7Q+UaKFo0rC3wexdol81zVUvKlyfqmR91CkrcN4CZ2rIbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+3DuIXH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb885f97eso3141985e9.0;
        Thu, 29 Aug 2024 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724950892; x=1725555692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YehqG4PtaapmXnLiVOq9WpGytyQ7YD42DofQvtnV7HU=;
        b=X+3DuIXHoo8K9zqnOkOu6lfu+iD15nO//aLM7VQqy53CjmcynFvcvgv4rASa2399Yt
         E5BIwTo/iwKDLJzLDZfo1dV82wTvNYfKgL786TA1vOSxc0oY85RIBc6DG/+DuCeN3XxI
         tGXdpP+OTw6g+LLmNyai2SAen+J1e5NATCRHs/58xDFsY3kjCERHixzfuECEjMBQdd3B
         U0eatbQCVec6pmdU+otdxyxariUTaxN6+H2VJ7qwDoOBmbuq5Ml8GaQoTKvP/07ieeSI
         ULUgRSi+lO+pGf/foKAZBplk1Jp61zPlxdjVgBoNJ8F+EnPp/l8Ol1zZmpvs6My/CjNt
         A01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724950892; x=1725555692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YehqG4PtaapmXnLiVOq9WpGytyQ7YD42DofQvtnV7HU=;
        b=XK4H131FYqzYCwX4EmEQVbLozbL2fCUFH4ETLQ9nC+mpUfQaatAiMh3UG5Lr26W/FC
         9IsrBp6H79l4FP0cRk0BaeeZN2cgl/t0Ol86LnM+RxvgVefudGrOvgKN1/DsH0jhQHLK
         rFZlYTSs3WTlis8IJcY135PdpO8JmxiCuQEKKZFk053tuAUnOabtsHr8kuMoQB8mtmht
         Y1AaC/BpsXrX9wZw5oL4qAxcRZGwxzQQtnSIuZI35oClHvf7LG0tSzryl1gH+FD6L3tv
         MxJ5DR0DgybKBKlYRNgb4xI7FEFrfewHAJDSpCuBYBmklQhc+HKcrAp3BZ5C7VNEh6JF
         oJug==
X-Forwarded-Encrypted: i=1; AJvYcCVHSn50cu2VXr5BkKVgHGZVXWZckLn29NuOWyX8GO4RgXWAKIt26o1pQF8Oz1B8w5efAOifXa1Kl0qHB6c=@vger.kernel.org, AJvYcCWV+V3PWka97re/06juc4PdzGiIfnfkaHvF8Z1DmiFB5IAeOr2l4t3rpFncVq5xutqNJ3duJjZT@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDBRhhIm8Rk5dKBFHDAeYB57N0qkFKw6W8KkRh4MJgbqiFPCZ
	ZuG59rupERnjw/GymLR/3LOv8Z6C3GB0NxK6qK5zZ21MlTXj6QYm
X-Google-Smtp-Source: AGHT+IFosliCC5+a+h4wlp+6u+dlP/pGWWU2L2Rh54ZG82z8dvc2aWVVIoZMBy8f4qkeaRSreWo7yA==
X-Received: by 2002:adf:f302:0:b0:362:23d5:3928 with SMTP id ffacd0b85a97d-3749c1da581mr1781820f8f.17.1724950890602;
        Thu, 29 Aug 2024 10:01:30 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33f5esm22284355e9.39.2024.08.29.10.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 10:01:30 -0700 (PDT)
Message-ID: <cc32d1c4-16de-423d-b125-9301154c950d@gmail.com>
Date: Thu, 29 Aug 2024 19:01:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/sti: avoid potential dereference of error
 pointers
To: Ma Ke <make24@iscas.ac.cn>, alain.volmat@foss.st.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
 akpm@linux-foundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240826052652.2565521-1-make24@iscas.ac.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20240826052652.2565521-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2024 à 07:26, Ma Ke a écrit :
> The return value of drm_atomic_get_crtc_state() needs to be
> checked. To avoid use of error pointer 'crtc_state' in case
> of the failure.
>
> Cc: stable@vger.kernel.org
> Fixes: dec92020671c ("drm: Use the state pointer directly in planes atomic_check")
>
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>
Hi,

Tested-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Regards,
Raphaël

