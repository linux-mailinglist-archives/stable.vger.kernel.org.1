Return-Path: <stable+bounces-69895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FD795BB66
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 18:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190CC1F24348
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD521CCEC9;
	Thu, 22 Aug 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub03fLtv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6E1CB300
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342979; cv=none; b=mrcxdaRKgcgrcItri5JK/UTKCQF6bYe7ZcStCKleuwPXr6ElSdUVcQpnvtxvenBqUaG4GoUQNjwLnXDeOdkGLwyCmdhkSyVI+a/xysZ6/4XuZ0DcmITE8Ldb5i3+9PeOpWyvmW9Ko2+QvJ48bZfMnBZfflXjv6ulG9bWe42+XE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342979; c=relaxed/simple;
	bh=N1zMZ+hXVfz11gY2kkBw6IRe1yiWuDqeJ3l7e5bM8Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDJiprewGxxQDYIYqlvPPwdO+IcKmVe+CH9aEf+jOv3vHZW+YXURfTyhaAGNVhNGVgym6UE7p0LusyFe2DZ7n/WGefIQkNTu+wG+hpqrccwVfbhYMT99X2mx9kPoHyPHXSfu4auc/49EtOkEXxiAui1tmGT8FQi+fpwq+j5UFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ub03fLtv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371bb8322b2so502474f8f.0
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724342976; x=1724947776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVHwgiGRwBVRiA1k1Gg1ltpgqyX9aL/hfU0tA2E2xBs=;
        b=Ub03fLtvJPJBUCdiCNr+J76L0yFG82k/Tz0UTY1aE5DvJMhWxd9vhyON/CoYLGAezG
         vOOAldCbqa4Z8sTVmHlJNYDB5NJbcCpVBfZvmgmO7xUGiLwAhY5iv63v1iiLsq1GtySM
         +93OyZ25s1mngsE7TpUbm2AWIi41UO9lZIRzQnbXdR3lzneIeLN4qd1ArGoClh21x9gz
         dsNp8BLO4NMW5EXoVHlu7sB9SFTttjcD3ED6Veikr6ChVwIMi8GQQd6fS7VTI1PoiFa5
         ER1pSCBCam2OFI5viLJhGIS++wETBVficE5kw8wspH71ifPjdOakUCMSwprgD9P37Kg5
         5Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724342976; x=1724947776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVHwgiGRwBVRiA1k1Gg1ltpgqyX9aL/hfU0tA2E2xBs=;
        b=NrRYSz34Zwh9+JI1Rx/4sNYZYiDSgKcdEDdz0qZwazJtiwoEsJIb5fIV227e2cM035
         8pBsyVWWAp5CjSilPbSV4hQOU/hSAPSM40dM34A3S7QgAx9+Zc2aC3tQYFnIMYJbtOdA
         fSc9iY9Nu2zxsVmvTWfCUdnCKtp73mSdrtZcAZhprp39Y/Dn44EMbd9EuTd54BJUBemT
         bebuiX6xhdCo9vUuugjFNQ0fMDxtnEgug+cSQ2kBTNF1blohDIZy8D81i8UwE+FrvKFA
         TsqZSB11FxntzEcid3vm8K/WxbHpQYR/03CQ+j7VmPxVl1lxYs+KkBOcnwHM8CnYhhIB
         MRgg==
X-Gm-Message-State: AOJu0YxHctj8NBYn6p6mRW+pifDkLacmtMW+ZubVUViV+EqMG/guAwao
	fbA/0Sx0yyuK1JoxUiWvsNzG0sOrHV26K7yoID4l1YAlSGNW5Gm2vFnWeRQwJGc=
X-Google-Smtp-Source: AGHT+IF1xtLjO7HbauT10nJjxAFzvO6sbfbstsDOKVLiY/kd6TeqGRF7IYYKtPte/9nFo8s5ewLDcA==
X-Received: by 2002:a5d:6e8b:0:b0:36b:5d86:d885 with SMTP id ffacd0b85a97d-373052b51a8mr2118977f8f.24.1724342975461;
        Thu, 22 Aug 2024 09:09:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abee86df3sm65738805e9.14.2024.08.22.09.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:09:35 -0700 (PDT)
Message-ID: <65d60efb-9512-45a9-9303-4354eec21bd4@linaro.org>
Date: Thu, 22 Aug 2024 18:09:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> Terminating for_each_child_of_node() loop requires dropping OF node
> reference, so bailing out after thermal_of_populate_trip() error misses
> this.  Solve the OF node reference leak with scoped
> for_each_child_of_node_scoped().
> 
> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

