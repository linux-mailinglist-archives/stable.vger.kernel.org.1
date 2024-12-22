Return-Path: <stable+bounces-105560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CF19FA5BF
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546AE7A1A93
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6A818F2DD;
	Sun, 22 Dec 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IO15F9Jm"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CF18A931
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734873245; cv=none; b=k7KJ90kLvi44ZoMb39Q42mqkNGblLeOqw8dxGtOz5uMpHasICCH2hIIOmuPlbcIolkf/OgJarx7TjyTEWwSiSdoVheH6c4EaS5V2Vd41ZE20v52041AbdiJMhj+7hUuLHh/gemj4IkX9Ptp4IZXB11Ayim4fduTUqL7VK5uq0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734873245; c=relaxed/simple;
	bh=kYdP5yeZkzBAq4lBYi0ltwGr+zxdlCaWvTJWPfDhwf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzhBG87FRHx6t8kUoUcwXgSsrFGbHwndVsVXCMRdecX3Q8+2aSrZajBWeYTKJsrBC0Dtzr65KO100QT16UNytzqcDtr5NFFQpJAUPAHwMO5I3stANOI4n7czuPsFIspSiFl8WQASiM5nkfN9zSvsincftHI2r3vcaw+Gim8hbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IO15F9Jm; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e399e3310so3879522e87.1
        for <stable@vger.kernel.org>; Sun, 22 Dec 2024 05:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734873239; x=1735478039; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5G1n789VI+iPhBQH5F4v6UNNOm0uHyaOkYxT8zl1MWs=;
        b=IO15F9JmwFPZOb60k4WaszQc9Ux9nNrigHM05IbcqHKOkrd9VCYqsqCH4ZpiLCOKWI
         gXHunWh8aYcFLMZaSqmKI69H6ckzM7fOfa++0jV8RdqNsgJMD5MivTiMYD3F1FENu+fI
         fliGVCqvFY3crjZvBQuarOHUW32hhH79OlwaWeylzVQKRvsuhuvq0qINSgCpG+/VH45w
         O7aRL1sKGvwcMdLGPf9EB/hTK/+2f7IzFxuB0uuFhGQd7tIb86zHHNoP+oc3UOfqo5vk
         a66MhIyk4gXuLfOtiyEXTMragQH6QAsW9G7Zf3A0EK0EKYTvyEi3e9/JduMGNOSK8dUV
         MyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734873239; x=1735478039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5G1n789VI+iPhBQH5F4v6UNNOm0uHyaOkYxT8zl1MWs=;
        b=G7jb/tzs9gvfM8ohYQPGgsfyMAkS6ugEFtuidQyye0Q9JUSBQBsbq5okKQjZELf9Dn
         fdA5f3W63Sw9rLPTgOa4Q+s+nU8qU0NOIy9uDIPP1mVvDxKBPQJ1m6O5dhNL+CIgfYzI
         3xfkzG95VQddsr1xvmAIHIiO5VtD/j6JiNdngen9PjEt+BxaQLxIA2ih8708l7sXS9vo
         KYKjKFAiKokYaA8yDQ+yez8iVzhFqLe0xJKVJwPMcpYZ5inxbFPWxXl+ymsDwfG69NoJ
         0NFAWnztW+KzihUML7Fxu9gPPL/9q4uQ01lcWwu85/K6C0nCnurWT8irYmJ8wB90mKFp
         SHzA==
X-Forwarded-Encrypted: i=1; AJvYcCUlfntaS0myUZ8XrPo7d2688iSw/wbsi3sBE3Fd8mkHHRs6JbiAf/tRZ0/dujMecR3FHprJANo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5ofxo6FndVqq9OvV9TN/NyAUjl2cbEMMtha+iU8v+t4U/XsY
	m6rNETA67d4vKxX20zbPii8Ei9p1d35gReKvEvwhkxpUyFlS+H1VYCxJduO4GHo=
X-Gm-Gg: ASbGncsS5JB/962V8lDKcrN0ixJz5QTiAxETut1h1NX/DA5OnDSsOV+TBu5minyUIRc
	iQmRSe3GSPS9+X6M3bWXY8vMDLA6exaGfS4gK7vBydyHGN6BXKZejpmMpXscvIIVTc1BEQPTlrv
	V+cVALN9LjUiAzgPhSVQKFI+Q/dueL2Bfb1ktOQPzHlTUL2f/Vt4AJaoLKQNEA/Dye1tld8mJLo
	9OYLtnH91J3xXLL4mgVLx1UH56qFhLRxsZM36AwVQDywuoE3icLWEatayKGp0s5NxjDM6x0YGew
	NC+0/Axg6yGsy4J0/DQ1DSARrGec3t0A4EJ8
X-Google-Smtp-Source: AGHT+IEf5hoYBKrJGH61USlw3q8c948U1qUxhVRDxvwTtjOb9SST31C/wZsizm3j81A53TpLipPuxA==
X-Received: by 2002:a05:6512:2246:b0:542:2e04:edd1 with SMTP id 2adb3069b0e04-5422e04f073mr1389823e87.42.1734873239122;
        Sun, 22 Dec 2024 05:13:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235fecb7sm951614e87.64.2024.12.22.05.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 05:13:57 -0800 (PST)
Date: Sun, 22 Dec 2024 15:13:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: joswang <joswang1221@gmail.com>
Cc: heikki.krogerus@linux.intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rdbabiera@google.com, 
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2, 2/2] usb: typec: tcpm: fix the sender response time
 issue
Message-ID: <exu4kkmysquqfygz4gk26kfzediyqmq3wsxvu5ro454mi4fgyp@gr44ymyyxmng>
References: <20241222105239.2618-1-joswang1221@gmail.com>
 <20241222105239.2618-2-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241222105239.2618-2-joswang1221@gmail.com>

On Sun, Dec 22, 2024 at 06:52:39PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> According to the USB PD3 CTS specification
> (https://usb.org/document-library/
> usb-power-delivery-compliance-test-specification-0/
> USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
> tSenderResponse are different in PD2 and PD3 modes, see
> Table 19 Timing Table & Calculations. For PD2 mode, the
> tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> tSenderResponse min 27ms and max 33ms.
> 
> For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> item, after receiving the Source_Capabilities Message sent by
> the UUT, the tester deliberately does not send a Request Message
> in order to force the SenderResponse timer on the Source UUT to
> timeout. The Tester checks that a Hard Reset is detected between
> tSenderResponse min and max，the delay is between the last bit of
> the GoodCRC Message EOP has been sent and the first bit of Hard
> Reset SOP has been received. The current code does not distinguish
> between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> This will cause this test item and the following tests to fail:
> TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> 
> Considering factors such as SOC performance, i2c rate, and the speed
> of PD chip sending data, "pd2-sender-response-time-ms" and
> "pd3-sender-response-time-ms" DT time properties are added to allow
> users to define platform timing. For values that have not been
> explicitly defined in DT using this property, a default value of 27ms
> for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.

You have several different changes squashed into the same commit:
- Change the timeout from 60 ms to 27-30 ms (I'd recommend using 27 ms
  as it fits both 24-30 ms and 27-33 ms ranges,
- Make timeout depend on the PD version,
- Make timeouts configurable via DT.

Only the first item is a fix per se and only that change should be
considered for backporting. Please unsquash your changes into logical
commits.  Theoretically the second change can be thought about as a part
of the third change (making timeouts configurable) or of the fist change
(fix the timeout to follow the standard), but I'd suggest having three
separate commits.

> 
> Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>
> ---
> v1 -> v2:
> - modify the commit message
> - patch 1/2 and patch 2/2 are placed in the same thread

-- 
With best wishes
Dmitry

