Return-Path: <stable+bounces-69897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A395BB6C
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2661C20750
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333E1CCEC7;
	Thu, 22 Aug 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGr/Vlk8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063C13A86C
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343124; cv=none; b=baV3Z1zBARLN9yuT9ajq8GcMy1MFgWzD9IK5FsWCRJZVPJbc6YOLafBI+a9IHDJhOzlrqbuVfDATHjJwik1G22+BuSHYbCWyrn3iAnNcX+csHTDKKq15S6CoiiZRpXyGy7/21NDHzrNwV/Z0XpmqItG/NwDzBkDZNv5ZBAMPtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343124; c=relaxed/simple;
	bh=DUFIzbM49ayGk8TDuaa+D9IjNb2QVa5H15QNOTPC7ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouLrpVMREhcjpjn00vv5TrnMe1VPEgLTPluZPmX+yP6ixri7UaUYNAJU5O7y+2By+YjtsIfl0vj6XlfGnQ4ZS9qIT3kql43JkctXh5rL2mL0XYBjoDqOQ3pwJAGuWQ4Hc6WL4WmehL9vZ41iSTxS9a5ayQBv4dT7PSsOrUZE3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGr/Vlk8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42809d6e719so7389425e9.3
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724343121; x=1724947921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSDYqJH1si4MkbMiG6MIY0frUysj56sL53IfastzRmk=;
        b=SGr/Vlk8Vb1hoCOEQAF5TYL9pcf45giAf3G5SZCYq72aVs2Zjeh4aazVQu8WZrnGmo
         /fn1L7s6jpR8+ZRIoSzMqjzTPqhlK8bwWW1jO4/2Mj3YDxhDP0g99+EE7dQ1XtYNTzLn
         xQp6AfjkeFTGToQys2TvIEg+tHkCdeUAnAVrc6VkveRc25omM7aD5ch+91C/2QKZkRQM
         FfEQCIOXDBc+/aVhinO4ZgMnBclVaBKsKbICE9NDbnr/Do+J43hGcbfRW7WSfjhPlZFy
         7/gI64zPm96I89dIBwZWE8L5mau6pzlp9KBrcyYEgk7zXONb2Guiyk1kviNs6xcdRV4L
         GXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724343121; x=1724947921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSDYqJH1si4MkbMiG6MIY0frUysj56sL53IfastzRmk=;
        b=mpGqtjIkkvKTDiU0+CNZW1A/CE3PUFvGs4eXb8hftYNYnciqOkEp6oilgKKSdWUBMh
         P2TcT64WGqcwY2Ym9PBMAFJ92Wviy2qdPat4zyvhn625QMtifPE/NIsXfprPR2XQXZEQ
         MejTCDa/yrq482mdwLGhvOdBWlg9bPpU1b73+xIdppxNtyiLBWIMMgRFxseZKWscejth
         R8Gw8JjceScqamnpDIb2juDuNketqYaSiIvF1ImAZtEKOq+rKaWVHS45HIoO3MTkCK47
         mktE8U2Bhv4ZdBfQDNJOIv4SvFPPQgq4clC7z1QLPjSbvRFulhPBAWLjgmtsHrVM+9Rf
         vqLA==
X-Gm-Message-State: AOJu0Yy3a08FXm7031HBgObwx5gbUuv2AJBQt7RgX08Pi8arI96n3XzK
	eIzoQef87a6MmRFZy25xbGfFutTTGIA4fJp/7lzLh8tje/gIcjC1puJmn6riKw3Pk3CW9y2Z5pf
	3
X-Google-Smtp-Source: AGHT+IFZqDsp1CF3lOTkEOu7V8psQXqYpLsfhY0Xkrzat3bAfnpj+viOdmLGRiF/xSCPjrHM9qzCAQ==
X-Received: by 2002:a05:600c:5114:b0:426:60bc:8f4e with SMTP id 5b1f17b1804b1-42abd21f5e8mr42160345e9.5.1724343120777;
        Thu, 22 Aug 2024 09:12:00 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42ac5159555sm28976255e9.18.2024.08.22.09.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:12:00 -0700 (PDT)
Message-ID: <fcee1000-9f8d-40c6-8974-06e3c1722645@linaro.org>
Date: Thu, 22 Aug 2024 18:11:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] thermal: of: Fix OF node leak in
 of_thermal_zone_find() error paths
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <20240814195823.437597-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240814195823.437597-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> Terminating for_each_available_child_of_node() loop requires dropping OF
> node reference, so bailing out on errors misses this.  Solve the OF node
> reference leak with scoped for_each_available_child_of_node_scoped().
> 
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

