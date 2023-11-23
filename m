Return-Path: <stable+bounces-31-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AC7F5CE0
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED0FB20F90
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84621A1D;
	Thu, 23 Nov 2023 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBd1Ynw7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798D81B2
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 02:50:19 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507be298d2aso899985e87.1
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 02:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700736618; x=1701341418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWkmW4NrpVSDSfoG84SGLgZ1/3hG8w7uFZangWvkPCQ=;
        b=yBd1Ynw7VhE6BoscfnqgPUcsyWcSS1MGggztCRSHN4BDt9mtzyE/oJOr9JW8AGGDHb
         26wV1xUDxi5Nkk7Q4fkIVXx0P7FIhiHymPpnXLIQvWQSGi9Pu7R9hpw7Cv+Jz+XCQfDJ
         eIGk8mjFAJ3FTmA1uGOkz/G0xC4gjfTeh0Nz304M/YchTU866VC8n1n4kxpKIFXU1j1z
         Ct+Y1Uc9cUvBkb8vzubL5n03DJJoIrySStIs0wh2lt5gLYl/yZkKfknCUacTSUXBsZCt
         cboxKgmKR1LlOHqIjuOmX2KsIrfHtdx8b+HO94uGopq8ajsAg0JbceCpQcwlTsCX25YK
         eKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736618; x=1701341418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWkmW4NrpVSDSfoG84SGLgZ1/3hG8w7uFZangWvkPCQ=;
        b=J4JjvRWIKv6bRxR4ZaRKYS874jjaw/3x8bMk/1R1WHbaT3DlXTiij3J/LxZiEfczbT
         FvKIz+4FPehW9TO47i4XIbrXe+Kzw58QXCyMLAKaZHLfCs0V5JsfcxjQnPiwJEkeMNiW
         g5XIxAqlfKf5aYB70hkWtQT7vozbxpZnbpIcKdIXhxR5L2Lykvb1tOvG+4n83L5M2MHU
         mbSLmkkAEJEwaXd6KiUnt/fJ5pbXjGd6QqjzlDKSToTIK6ma8nerwqwXnnQZZGeoRBVw
         xWNYw1xRP2mIKzQm8QyuMKb9SIjDChDeWAqRPQzP1c/DzJni60nZGiHRqQziEg+EMbSD
         fDAw==
X-Gm-Message-State: AOJu0Ywvh8FF9oigq36DlYKPjZVBunu7/5Mb4a6dmAABiFR9axzrLpbf
	0SayLb4EHlwJ0E2AhHX0otgoDg==
X-Google-Smtp-Source: AGHT+IHs5fP4IJLm3ak/VIWnkrN0Owt9/emtxBJyhldyhhI3EgXhn0P5nCSx7knmRJy61a6y/XgPFA==
X-Received: by 2002:a19:3814:0:b0:509:8e81:1aa4 with SMTP id f20-20020a193814000000b005098e811aa4mr2882944lfa.39.1700736617662;
        Thu, 23 Nov 2023 02:50:17 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j27-20020a170906255b00b009e5db336137sm619208ejb.196.2023.11.23.02.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 02:50:17 -0800 (PST)
Message-ID: <9c5b1503-4dba-4ac1-8fef-9b28fb8bd4b5@linaro.org>
Date: Thu, 23 Nov 2023 10:50:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] soundwire: introduce controller ID
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
 gregkh@linuxfoundation.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/10/2023 17:09, Pierre-Louis Bossart wrote:
> This patchset is an alternate proposal to the solution suggested in
> [1], which breaks Intel machine drivers.
> 
> The only difference is to use a known controller ID instead of an IDA,
> which wouldn't work with the hard-coded device name.
> 
> This patchset was tested on Intel and AMD platforms, testing on
> Qualcomm platforms is required - hence the RFC status.
> 
> [1] https://lore.kernel.org/alsa-devel/20231004130243.493617-1-krzysztof.kozlowski@linaro.org/

Tested on X13s.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
> 
> Krzysztof Kozlowski (1):
>    soundwire: fix initializing sysfs for same devices on different buses
> 
> Pierre-Louis Bossart (1):
>    soundwire: bus: introduce controller_id
> 
>   drivers/soundwire/amd_manager.c     |  8 ++++++++
>   drivers/soundwire/bus.c             |  4 ++++
>   drivers/soundwire/debugfs.c         |  2 +-
>   drivers/soundwire/intel_auxdevice.c |  3 +++
>   drivers/soundwire/master.c          |  2 +-
>   drivers/soundwire/qcom.c            |  3 +++
>   drivers/soundwire/slave.c           | 12 ++++++------
>   include/linux/soundwire/sdw.h       |  4 +++-
>   sound/soc/intel/boards/sof_sdw.c    |  4 ++--
>   9 files changed, 31 insertions(+), 11 deletions(-)
> 

