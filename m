Return-Path: <stable+bounces-146422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A014AC49D5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E5C3A9701
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5B248F64;
	Tue, 27 May 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLkjcxiD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE11F8723
	for <stable@vger.kernel.org>; Tue, 27 May 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332953; cv=none; b=IgScpnGjzXDk0vBIKoBxOBaIgG2Bj9jVjY2oWqG6HNdL0T1piN6XAyNxjlfs5ZkYid0AmNNlGw9S8r31PDThpNnzgsXGTrpbiflehjQxPykXNyoKSa0PbTP3qhU8Fxn1CwazT2gU6is+xALrxC+OvB7kmxLIM7KZfGdBvD5Kz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332953; c=relaxed/simple;
	bh=EFsqzRCZ8ePp1PM1ihVHdbx19gT/fR4vZ8gVTQC6W1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqtiZLiZThO9iHWqbuTmbfGjL0VZiy9E/ycEbS+Bmw4iC58hV3dU5wH3zeSt+CDqTpVR//IAqLSYgUSgoYx20Fx03a/pwK3m/0vZFSXNq8Z2Gc+kN1vN3BEAaYdjSexZhbFivS48FD+LnGWAWraEivNDmzoBotJqvAwF1F/MApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLkjcxiD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604bec4865dso239548a12.3
        for <stable@vger.kernel.org>; Tue, 27 May 2025 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748332949; x=1748937749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zZdYklQjuqTcptyM6fEwz69fIzQVNbHtd0JSSB/QcCU=;
        b=pLkjcxiDdd3SmdBCmtEn+2KneExCEBtRk/FsBMIDIG0UtTus7SmjbfkywLrQdViLFv
         DimvsKGBJ5JDKNBxG66OR+WOqIUv5B9W0oeKQ2TEFUva8AzY9UNzLAW1g+DV2ZSmA2zL
         NzCzDmXusooyywFx4uG+WnCQN77BLxyL4reLkJg0adyxshvxSRmAf05EBg94Y+6knOta
         9Wso7GLfyu3RIDyoFLoJk5XECxCjH9dKdrRLW/wKdEl/FTCE/U/J8tFP9Gy/hQs4p5TF
         l5IOiBI/6hN5qFjrMMUnaLYcVrIS+N/zZU2XyTECct1EgDBLWYQXgewC5Ggv6GXQf9Hx
         cdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332949; x=1748937749;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZdYklQjuqTcptyM6fEwz69fIzQVNbHtd0JSSB/QcCU=;
        b=ln+dc+rYao07oz1x8yfyX+QKfbZkqLYK66N1wJHBCl5bQ06OC6vcKio6Hpsdhx7R0g
         w59nXyGjQ+CWJWCTJ81egBayJ0VULpJfVhZZhsPr7u5IGIW3eFIEV89LrKcQUHeLGuSU
         W2xKU95GAusVd57ZM4V/WmT1J0CkiuSzMIpvwdFYdZYMmAhslc9EUy8q8OldHXB2Bxln
         yg/84FtjgoIcNdnQLcq/TWGreSRCcoOoxOzbAOnYoXDF1ZdPCEcOOvzCeAMW+5acUene
         dLL0jCShH1XZ/iymppnvXWA3ExAxTvL98rUOo7lR2wAzfYn4QJuDrI7HKHZZDar/DmjU
         Avcw==
X-Forwarded-Encrypted: i=1; AJvYcCUTBIQGjdQqdoNWV8qUF0l2rM6Oe+pmDTGjkRfsPWI4oRZPXxiX846Nrl5kI16DqFCuI1RDWvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRiWQbUIbBwQRUvK/0k1eE8h9HBRujO521Tr1gVu8XRu0lHSc
	807qqm14XO8H84lw7Hu0eKFyPaQpMyD5v96ug8q7N+9OsQ5Z2DD9qIo9cVupyFfP65U=
X-Gm-Gg: ASbGnct7kHMEcX7AiVROnVK6CaOJB+N+v7uOwxIBZjcY0I+d0JDxsYHXGd9Om4ADZWn
	gXDrYMtzT7AeG9JqrQVC7ZPecKigPz8ebGbohXqYgZyeAgw3ARvsQlm2BYaWTwtKIMf5jt8m9Dg
	ublIc+qBziVZo4XPMPjUVSuLgQeRYAdPhLPzq8ubyKK53IDlcrYTvc0LN4DXZNDdaRErPbSWbtn
	mutPJgZcZ7zXGmWqkaY+mqOloitQ7dYnpJh3v3p3rPz0486w3Y+ak82FmLYh3xD9kZrcbu6rjVb
	3Ojnloh1lHCXTBbeFcTcvdkSuPt3ah6pGSw1P32Y+zQ97svURjmDGTAkt9lpwH7BUy4VrBQ=
X-Google-Smtp-Source: AGHT+IFOoikQuzl2sjvQi67mzdQkPUbTkaKcMh95YzCvEYyHDcauQWWOyuVFb9fxSQsI1sfVsZP94Q==
X-Received: by 2002:a50:f69b:0:b0:602:e002:dadd with SMTP id 4fb4d7f45d1cf-602e002dbc5mr3049695a12.10.1748332949273;
        Tue, 27 May 2025 01:02:29 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d27192dsm1807445066b.71.2025.05.27.01.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 01:02:28 -0700 (PDT)
Message-ID: <e200db90-f886-4519-a772-c1e45084a457@linaro.org>
Date: Tue, 27 May 2025 10:02:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_qca: move the SoC type check to the right
 place
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hsin-chen Chuang <chharry@google.com>,
 Balakrishna Godavarthi <bgodavar@qti.qualcomm.com>,
 Jiating Wang <jiatingw@qti.qualcomm.com>,
 Vincent Chuang <vincentch@google.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
References: <20250527074737.21641-1-brgl@bgdev.pl>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250527074737.21641-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2025 09:47, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 3d05fc82237a ("Bluetooth: qca: set power_ctrl_enabled on NULL
> returned by gpiod_get_optional()") accidentally changed the prevous
> behavior where power control would be disabled without the BT_EN GPIO
> only on QCA_WCN6750 and QCA_WCN6855 while also getting the error check
> wrong. We should treat every IS_ERR() return value from
> devm_gpiod_get_optional() as a reason to bail-out while we should only
> set power_ctrl_enabled to false on the two models mentioned above. While
> at it: use dev_err_probe() to save a LOC.

... and to fix spamming kernel logs on deferred probe.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

