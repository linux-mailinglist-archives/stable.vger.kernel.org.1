Return-Path: <stable+bounces-183386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A25CBB920B
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 23:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618DD4E4300
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00542459C6;
	Sat,  4 Oct 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fpMn+OeV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A218A6A5
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759612798; cv=none; b=undBs3AlF+yVjKs9lcPSExlAIuPM5MbhV9zV4vC7QWPEpuHs9M9xC5eDyJw+raRtYaApUc7uhvwWgYPX65sOucC1zzKpBgIWbuI/qqUKLEcbE9F2nuFQ2+BTJ8f7DHckxYOn4ZnkJaz6W/drweZyeOYqjcdy34zvdpTWS76Xvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759612798; c=relaxed/simple;
	bh=eUHZflnSr2TEkpe2XPDQWxvjho7jjLPMAhUmxpQiU80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kralobUY9gOV91EfeDyA0biIFUi5OcZeNObmQQqPfTYwtvB3cvKRyhE7/u6ULnalsBmJRZmOklouyF9V2b0csL6PhZrbz/fzqPw7XmtBcKGTOCrzDQmlva0nNxbTZkNik1fA7J44av0o3b0OYo4+VRJHnE9zKY6v/QQ7oM6V/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fpMn+OeV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so27401625e9.1
        for <stable@vger.kernel.org>; Sat, 04 Oct 2025 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759612795; x=1760217595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hW7OEaTade5JEeRbSzzr5KXw6Vaivv6pg6suXCwYkOs=;
        b=fpMn+OeVvMkYRFLdi9eGJYfn+stTJ+hdoKuApilDpB5StY3AU6E4Gg794NL8Is1SZq
         MdhFjw2M2ow7x4B5RQRVN+AofXMCsCp05mFCFVk8f+yQVILTtBgDa14dqU9H+TDx8vYE
         G/0Wyiic6F9YA8pbJxJGUT7kI5nU0wDuZg7wwRMDKqNTEhkKaMdlTN88Xzj4gtJV2W1e
         gYpVS1WRDqm9c5JNtU6QMVD3DUusj/K3yyGl9kvJxIWGgM/EPpJ7u6n4a1KZfqjXuhgU
         xurqQQs5XO5egdhAb2Lk313lVcfR6ykgPCGd7Sao55/CEB2v2684M0LDPUGmeeR9k/VJ
         rfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759612795; x=1760217595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hW7OEaTade5JEeRbSzzr5KXw6Vaivv6pg6suXCwYkOs=;
        b=CrIThRXsmc3ArsBbpHe1ngAj1GurEKZdjq9VRxayuqLr7eYts375cVq72WbQOcyBbS
         TJOYWsyeZU3tasMglSMwb7UPmdl12sNS3Mz4V3WZ+7WXAsUlo9qAGP3HRwJ2rR549XSi
         z1nhtT7NyYdi4F3IoRPRDvMySYE22FZPLid+A58MxgzEvM6LHnAuROF0cGUWoXmrqy8j
         mn8macqL70+oNZ6t36hesaKknrQTFLXPpFbE8dxyc8JyO9l9YGBQc7xIAx6yGksI6Xrt
         VU+K+98LhTYWAC0iEGM/fsR9DRdoJB5tTeOmU0r4Bxu94ZrD28OXj3TyabskkHvrw7x5
         m05g==
X-Forwarded-Encrypted: i=1; AJvYcCU3vQiygtNVIq7Hgcuz+yi/xkZza1cwJsstnOs+nEsEcERfvFEluBk5qcYjI2JIMA3TQyf70OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwluEKiqDt+cCSk5FoYO2PNkFhof8C4+HTg9MNdkI0gpbSQ0Txp
	y0X7l6em7qBZFJMfbCm8dCbsxPmU6dGxlBI8uNk83NMy8XXW6WqQX2Q=
X-Gm-Gg: ASbGncu0oe0e93waf6oSwtXB27C8ZQSfqQTnEnao4vDc3nTByvHrdwxS4aRXHypih++
	/woHtDVzu+6rr5H6cqLlXapCgHRdQWfaaj8wnoUsEJaAEkY9oH5wedAvMGEaTHziWcmFP/reeXk
	xqDXmCw9cub3g5v82abJ0UpRn3rWp1tkGDne5iKR7p59zfc0+vuD6NOhRb/Ud9cfZSzELLQgvgQ
	cNbE262glopEvvAEODAGn6s8/wK5VYG0Jdiq/vhWWHe+ZsH4js9lzktd6AJKVgmk3FGjFo6SENZ
	eiKolXJ2cyohN9oGG1ixqfp8ngKr7BBQ9NKRxC0eBp+FQoG0d5FAkUdKaCgSLUT9ZszKJiGsSNw
	IQwC8qIPDRjag4VWmnAcLu5xwK/GDTv3nF5ddLPxYJPsCp/rg0gWie6zbuVL3q7Z+ZzpTLIuFa6
	rN/3wqpYiB1AMJ5dVGvMpavoc=
X-Google-Smtp-Source: AGHT+IHfyPEEeoKKPfnxCwwTH4snrR1lqeeMT6o3OP7h3Ocjh70aKmFMr9qutwQp2ziuyduhO8+ugA==
X-Received: by 2002:a05:600c:8b38:b0:46e:6d12:ee4a with SMTP id 5b1f17b1804b1-46e71140cc4mr44684345e9.20.1759612794837;
        Sat, 04 Oct 2025 14:19:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd24.dip0.t-ipconnect.de. [91.42.205.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723614c9sm86798675e9.14.2025.10.04.14.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 14:19:54 -0700 (PDT)
Message-ID: <a5750ce1-a441-4dd5-b9f6-5bc5e88d9723@googlemail.com>
Date: Sat, 4 Oct 2025 23:19:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160338.463688162@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.10.2025 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

