Return-Path: <stable+bounces-166704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF686B1C7A8
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8865E3BF800
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4FE28BAAB;
	Wed,  6 Aug 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC5Iu8gx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123672AE74
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490913; cv=none; b=tBtaAYXijxNESl0URB7VNmz1/5RYhpu18wX6QfL8T4KemSJ83iEDSXSK3oHR3x5fNytxc8EFHLKxbzQVRYuViTqFAWOk2OcCWvhY1mZ8JfMIuv2T2eWmN+7Sdd2CWvdxN3VkvneX1c6DFqLIYbk18Q9jp3uG5Nidm3tScOcUbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490913; c=relaxed/simple;
	bh=Gdg2q0nO1eUnubIvR9x26EdENHNoUnaK4hFB9EMutvc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ofFpuNYwFbvSNVHcwVY2mNqZdTpfZI0QNiHKwOPNytkIT6+cspT1ymod//mB+gd5rtvPf77um3w+sVK+ked1G4pVayp4QXw0rp4ps4HvfX8Q2ZVJxUAbqkmxo5IvQY5n3poR62WpkYv40q890f+7t/d20UsZt3dn6G4UUMZ2OJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hC5Iu8gx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b792b0b829so5555091f8f.3
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754490910; x=1755095710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJzc1Ie8ZeRZJLHRDEZNI9VK1kwQWGby17uL65M37Dc=;
        b=hC5Iu8gxttB+BuPyFgYCyEKyrWctUBPWBZDTApPMmgJBNp19H0I1BT1wZ+tX1Cd18S
         nNzY4IPOwj5fMHJUX0J/H+wvHOw02N8t8N99yaBu5/oK3aKW9o3jU76Y3ZdGbW2dUtu6
         BXWqe7i2bU2XnsKwetmVIP8OH0ALpDUDsVS5p3xVRhYQ6vMKRnZBM733Z6FJM371myHt
         23p6rkduRb0z2ToQ79QyIRXkseL58de8njvavnJNgpuJ73nMH9bGqHc6AGrHwXbOkkZC
         VXpCOD76GVVDjGMN/JZv5JEBoHIYIt+dX+fnmQqgKUtHOta0YUMpIAcL10dSzZIid7j/
         D25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490910; x=1755095710;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJzc1Ie8ZeRZJLHRDEZNI9VK1kwQWGby17uL65M37Dc=;
        b=Xneu/wkjGgZ6mGnn0o1/5VIDSDgxJqqNRNYob4lIb6CAgY30ZyArFmLHdMSulY9JzC
         i6vg1WVDB7ribYyPipCmcDxPVZ6Sc3Ut9lLQB79ckftP1gx0p8LtOdKpZKFzTI8pXzYo
         B5nk19YPo0aWka9vNJb6JW4IPIrkXDU50GSbKe2cZf5R8ZKEXWOhHoY4jWDQV3t3j15C
         nAnvzegrkFa0VXR4g3uyJuJIYqoJQwfbUL8/DDHEFQJkxboJ6zg77EDD9+ro31qxw946
         CvHCWYHQTglIWsCbbqWD1m1+HPBObFt40UBwxuZCCPgYgNkdkDyPpHQ7AARQBtfe9GFj
         Qq1A==
X-Forwarded-Encrypted: i=1; AJvYcCXcezK5NjHO+1DkAKuNJvACEfI/oAwqJ8aVoIPFbrbDYYOxn4RFyM1wIf8ERvqzx4epAk3GKn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJbtniDfmltdi1FEpwFuxd1TOMp97LxEwSMPvy8EEKxoc9L7q
	jGwweeHjLziywTQHJFbdkhMRzXDGE3ZkyHgG4OzvkXH84ut3mJtleN9xH4QspR7BRX0=
X-Gm-Gg: ASbGnctLCT7OVmKVZEjE/SlbIH7RsVmfA6e/og3cPWf0YZF0XexEtKvDwlEERM0vHMj
	GwFYye8R+0V66lBSC78DvZ3Bl0EJ273QGLxsXPVESbcUxG0XX5zM0aDPvnQZKPRNrlcbcvkn+Dd
	V5GYCFzXab0U30sM4LShd4+gQXSsPlPGeDaoip8vxroHJ6oqkwX7Vyx+VExdx4Cy881Kpib9h70
	xpMt79VBDGrJQ3thzQ/S4Gktaeu8yqyCVkliAnevnnZuee/KCFga+8I0RXYYWpbe+J4lcnDBuga
	93HLg1voopkhi/EAzfynJxguedpL1e7evW1hlqKIJPzpUuUY9y2I1S/lcT+QtwhpYOvOKiRonX8
	17GEKXm1iUn/PoM9PJbUAu4wr5i2B0ynV9n0J4hA74lZYHxrlyM5JxlsJVqHUjO1VgvIdCuJXtX
	P+o710Gkd47g==
X-Google-Smtp-Source: AGHT+IEAXyxlI41OWv3pHMxNrEhn7RvnN6KDG2HHhhaewkU7OtAxqdP/oKZJiYzIeHj2LhKOZvR3QQ==
X-Received: by 2002:a05:6000:144b:b0:3b7:78c8:9380 with SMTP id ffacd0b85a97d-3b8f492ff2cmr2300715f8f.59.1754490910337;
        Wed, 06 Aug 2025 07:35:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm126681535e9.27.2025.08.06.07.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:35:09 -0700 (PDT)
Message-ID: <92042af6-e498-460e-be88-8c1f1b4d74f9@linaro.org>
Date: Wed, 6 Aug 2025 16:35:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] phy: tegra: xusb: fix device and OF node leak at
 probe
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-phy@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250724131206.2211-1-johan@kernel.org>
 <20250724131206.2211-2-johan@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250724131206.2211-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 15:12, Johan Hovold wrote:
> Make sure to drop the references taken to the PMC OF node and device by
> of_parse_phandle() and of_find_device_by_node() during probe.
> 
> Note the holding a reference to the PMC device does not prevent the
> PMC regmap from going away (e.g. if the PMC driver is unbound) so there
> is no need to keep the reference.
> 
> Fixes: 2d1021487273 ("phy: tegra: xusb: Add wake/sleepwalk for Tegra210")
> Cc: stable@vger.kernel.org	# 5.14
> Cc: JC Kuo <jckuo@nvidia.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/phy/tegra/xusb-tegra210.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

