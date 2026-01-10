Return-Path: <stable+bounces-207957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCF3D0D4E1
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 11:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B96130222EC
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 10:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB66B24EF8C;
	Sat, 10 Jan 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="TP+PCo6o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD252FD694
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768041933; cv=none; b=lyvqOFMJmsHzVimofRTIOTaOclpNzE3Ermp77uFdqadtIrQ1bpISR9R6XsHXrnZk3pUOefprMyTDenmk1/eR3r27HCW3IeRZGVP7926W9IAJbaqZIFBrhZCnxNW8HDXDAB458jY87gsW573huUTm+FR71ZsWSAW0ETdSkEPGMIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768041933; c=relaxed/simple;
	bh=RFZldikQMkCTqEZH8vKg7TSQIx5FlJQ4I/ZwY9mN/Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+jX2r5Y2g3gjuDhNwp5GW24tfMl/AWo3s0jry5YVITdeLOwCeo7yOwQsrJGpzT24VydwuVcrJcN5SsCpiepGa0FKXQz0n69zMaHWe9tkojzSomTkn+2P2R/0zLfh315eFHVnuNOFWEvr4BpmpL7yWxDPpPPdfl73Hl6OiffsRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=TP+PCo6o; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7cee045187so676291166b.0
        for <stable@vger.kernel.org>; Sat, 10 Jan 2026 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768041930; x=1768646730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mDD4gInLjVnOwXV5aynlTcIEFIM8N7gEUkgZcKzfgZY=;
        b=TP+PCo6ojExCD+IdECKBXjruan+Bu6+SpFPa2otBIuTj6/n91oRcuihoVU0bovzlZW
         H6GcVi1KVKBLG0Z2ceBjxDHCHvzZT5VsbQ2wqJmBMCnyVFCBntDuE3WUyRaokGYpFX0t
         9SR9EtPmR+WNprcIRmJOdG7aH87SEapwoc9yU31kOax0Ebdb0PYvJ2x7oArloa+FhDzZ
         OC1J4YSeS6WT1K3i1KvwHuPu0+0GGOXHPfB9sHuXYLHmlSg3YG5TxqaebWSrjcPS8+Ws
         XR83HjvxVDG9a6PRkH5AZBYocoqvld+xj+Hj6NzO14aMsNQ00vi2JZGQ6wSnVcHLWfQP
         V6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768041930; x=1768646730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDD4gInLjVnOwXV5aynlTcIEFIM8N7gEUkgZcKzfgZY=;
        b=EsqZ+OaUwxKeQ5IsIA8ridp4pwzz5CRZm2oNde63xEh8rLpXw8CF1Nyp43RFxNAE94
         g440ZHxXXAqRsuHBKUP5LTdx0rawZjq5aRS1BdlaCFcPvUcLUOegfxgct0tIVh2rolLj
         njdbU1Bl5OytQI4zotz5fKoI7DT7PZCaJkWy5HZw+0WBfe1yas9LboG9AmJa7Y1zsnGu
         /AEXeFDOiwLXHLDwByu09DdNaOuWZf1US+3KWo3GgEIRm4z9PlA6HDH1OTV+Vvgb6Jxb
         saosEJGBFAJBL/S6kHkHu+/0Usyz4Fw3I11NboUTaMR2yy35QfNMrxD05p1+inPXYTz6
         RJdA==
X-Gm-Message-State: AOJu0YxiL6BSBGPZmGGPafbXAdNFEA4O6fXO1nCjjCu73GY6BjgsEj1f
	dyamki5i1LelQRlnnMCbLJwtNzxeToCTT+pWGNl4TMvTViS68KXnE+O9xvOXvz8danRBmGWNxxe
	AkgoCAOHC1opoXYh85CMcgiQ9z0WJiQEISqROgUjcvg==
X-Gm-Gg: AY/fxX40MJhf5yETbgo2PfggnGBVV0B0LbAmMfRukEu7qTqr81bn8VhealVUKAQMOzG
	3wDMNkN5EDNqX6QiwoxKItk9z/mix7eYxcfnjEf5TcmvZivTiR7tm2ml9zyb23LqmtltL6MQRua
	jTmjuxnshNuT8/JWS5btE9QZ1WNyd3OvsOZmpx2W296yGAm3+UfkZHlokdmAD9XRNKiGFZBowL9
	mhLz0GzpTFnKT0cz6AkeazqEjDIcahqe6/kxLmcXBEMvfSFr0MMmC+rEsb2zMEHOWgJh87W
X-Google-Smtp-Source: AGHT+IGgoZhDVkixtpshz7HlFqMh1nze3xpKd/rBpJcn+L28SpykEQ1pjsm1fGxrjnpSL/PpcoFuRMP3p1Aw/CRQAA0=
X-Received: by 2002:a17:906:aa43:b0:b73:6695:cae6 with SMTP id
 a640c23a62f3a-b84298aad06mr1171129066b.10.1768041930516; Sat, 10 Jan 2026
 02:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109112133.973195406@linuxfoundation.org>
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 10 Jan 2026 16:14:53 +0530
X-Gm-Features: AZwV_QhPeLVHL3GJoCDdXgIj-NTxjYMequNQwxjnr36FlDT43eApc9fXJptXTiM
Message-ID: <CAG=yYwm0bXD7pCnNTuKJvBvWN88CqrftHykWD_-0_XY+sT+GUw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/737] 6.6.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

hello

Compiled and booted  6.6.120-rc1+

No  typical new regressions   from dmesg.

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

