Return-Path: <stable+bounces-17488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753D843887
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 09:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14621F28F25
	for <lists+stable@lfdr.de>; Wed, 31 Jan 2024 08:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD845BAD1;
	Wed, 31 Jan 2024 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bG0fXmC4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94F5810C
	for <stable@vger.kernel.org>; Wed, 31 Jan 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688518; cv=none; b=eTdRVmkn08Uxm5Zmbwzoz6e3lwtxy7SfCG/w69JALHHdZMlTjcUKBlMTGbmfpsHarGcOiwt62LtXVHStVcot/3Nr7OxQgfkWCAA5CQyJY4kTMZ5qJWO54vLjoaNCIbF8Z0pnojJD6uLXyVMaQyVbOjnSHYJAIvKAdZwimZmms1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688518; c=relaxed/simple;
	bh=lx4FD9Ff2keMEQ0jbaHwSc5jk9qWZ2oAmEPHSTeAEL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsGsxaldZ88PRbJbO9xMIpOnBXjECnsP3e0WJlx4ahijuS7mC82vlvn9RoWYr985UFZMAzutO9KvfAFASrXkMkKmuIoPdD79ep08GeOdeTgqn8pMvCEsmu85d9suB6gX1PNeZyfRqmBZzxrE0WRs3khyUbeYGUEQnJJ+AnhosrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bG0fXmC4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ae3154cf8so2523479f8f.3
        for <stable@vger.kernel.org>; Wed, 31 Jan 2024 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706688515; x=1707293315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoLOhMfUIiPj96gmfLJQxWR6opE2jRYSksRV3iTYsaI=;
        b=bG0fXmC46TBAqQzPVQzUNYJLvpERNm7xkVKyNrf3FPK1oYbd9AhpxO/i4TJm8fLYXh
         yJktbycb3OJqWLXkOjH9tEAEBTB3g6MUpFo2ehXW05mbhw6tUWreGEertp1S4+85L08V
         1OcOPbng11aD8vA3A+zzKy7vsH2y7oi9SY0VioIYofwNhI+xD9fEVZlfd9jGIh/k6GFs
         RqpZL0vh8Qy704G1Qz1JVdmaGU1IvbOkHiXoZijoF3HzpwWWE0KvUbtn2Ey6Q6wHkwCF
         oMz3RfoT5DZgHhjYRbyFrkInYGbu2XnHdxl7FB+If6NfUzjc0zMRLrc+6qEReXRQwgGd
         tpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706688515; x=1707293315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoLOhMfUIiPj96gmfLJQxWR6opE2jRYSksRV3iTYsaI=;
        b=wUuyJiH4eRVQVDgeIt/oE5wN2nCkKXOs0cih+ZkX060twVWfMdQWjCnES4ClhcbY+/
         lt3ZAU7fXr6+o/WELfk6EnoyOwP5ugww+RafULrBHGQMtrElNyTmnIJnUPohG+W3/gru
         QTnSTn088Q4Ec6TZI/gYTODY61NoLoFV4I3DHTLUBtQobgKoPfJkvqTZR3LiZLhfVFjv
         0x3KI4vhmhkSabDFtf2q0AMMrIFCA0vQR7HWgUDWgFFOgWkbP6hyptX00hzsIOeJuyFI
         sYZcvaubOi7XPny2JDWU9eI9aYVLPurEU1mQQ5whg2O9avCZ07nMUfE9Y0FyU4VEsRcv
         GA/g==
X-Gm-Message-State: AOJu0YymjcNBxn6DzFFdAGTHPD5+2So43XZwGx1GmLw6pjJA6KV+Qa6x
	IQU5dYT9tyEiXRK8AfOYkGp+Apl3HrLscxaof6kogpb86XZ7ZPLYjQl5eWAu3Bc=
X-Google-Smtp-Source: AGHT+IEQSijfWrnfE1x/IhmGOIujlR21eS/1lucETA1cYhPCNsT1emGpr4CSNSjix7aPPjNS9CpWsA==
X-Received: by 2002:a05:6000:1143:b0:33a:fe54:4367 with SMTP id d3-20020a056000114300b0033afe544367mr541995wrx.33.1706688515023;
        Wed, 31 Jan 2024 00:08:35 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bv11-20020a0560001f0b00b0033b0558c5f0sm660263wrb.95.2024.01.31.00.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:08:34 -0800 (PST)
Message-ID: <73bb55f6-4753-4bfb-99f4-75d06d1f772c@linaro.org>
Date: Wed, 31 Jan 2024 09:08:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek: Fix control buffer enablement
 on MT7896
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: Frank Wunderlich <linux@fw-web.de>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Amit Kucheria <amitk@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20230907112018.52811-1-linux@fw-web.de>
 <20230913083529.3bgjl6rvfmixgjnd@blmsp> <ZbnX2vfcalNL3yRV@makrotopia.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZbnX2vfcalNL3yRV@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 06:17, Daniel Golle wrote:
> Hi everyone!
> 
> On Wed, Sep 13, 2023 at 10:35:29AM +0200, Markus Schneider-Pargmann wrote:
>> On Thu, Sep 07, 2023 at 01:20:18PM +0200, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Reading thermal sensor on mt7986 devices returns invalid temperature:
>>>
>>> bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
>>>   -274000
>>>
>>> Fix this by adding missing members in mtk_thermal_data struct which were
>>> used in mtk_thermal_turn_on_buffer after commit 33140e668b10.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> 
> Kind ping to thermal and mediatek maintainers, please merge this patch.

Applied with master pong

Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


