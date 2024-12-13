Return-Path: <stable+bounces-103950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E69F01F5
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 02:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2B228854C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 01:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363617BA1;
	Fri, 13 Dec 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D4z+SeKC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49C28F4;
	Fri, 13 Dec 2024 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052739; cv=none; b=LpT5r2fB9bHHJ/5QeoRZCSgKZ/TPop3jYAow7bFuNeqv/JzStfOzfulSsmBmVUDtkuoCUQ0y4Hr4/mgmRSea7pHKLv/URXEcWYdf1nKsjzpI2Xx+3hbVs7m/xBdaNO1dyPIR8w4baZ0RCnkitM5Xq1/4YU2vpE8vbPI9E2qFgnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052739; c=relaxed/simple;
	bh=JVK5FMSjTCy5oRqZLMw+jAYr1ftFHTaBjudtWgLX1FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nV7v38qf0nycnMtyX0l+1rmnfSYJn6lHoor5i8BryZENcXgCZQS+yjZaWElDrk4I+KYS564fFDUA/Ddsc1JsocB83jJt9dzmtxlF27HqOSxezZh/7WRt8k91wXoBysnnTwaH2sZsiQ66uX4VcnxILtQADQn+FM7GD82WSVddr18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=D4z+SeKC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-432d86a3085so8402125e9.2;
        Thu, 12 Dec 2024 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1734052736; x=1734657536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7VRpAcuLb7JLTjhyIVTFHhqJQdgp/x8OBWtVl0xAi8=;
        b=D4z+SeKCrWZea/91Vun80tOwRFmNq0TEl0lDct3C4qOjvAS0VAXNBkjl2m6Tmnryww
         uicwmn2PXumFvbVsaEfshD7G0zebxpIt8m2Rv83B30s6fzjGfvEBTqziLa1uBdbgHrEo
         QKyK6DsDVFDG/9Im9r+8+s1+D3d+NPdiv3Ef2xxR3hZgspkC0c/Gvdls7qzMbYByO8+D
         KFkJhabG7J9R7gWSntC54by3uZOdKC/r1u8SSA1reUkqNoZe7GZ6pEpnNnmuhuVoqkUR
         ksecdSaHO2wApcTar3zf4hDB5lbvzpjVMyb+53nJTtqSJP1fzo+MlqyreNoZi9Cx8SeT
         qCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734052736; x=1734657536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7VRpAcuLb7JLTjhyIVTFHhqJQdgp/x8OBWtVl0xAi8=;
        b=fKJoem8IIp8cATblP5VBlQJInfS0PWhJ+j621J+ZQSD4tf80hoWeTr9SwnuQkhJb5O
         Nv3jVe3Fzi65mHq75xO8kVuo2QqvUZ59sqkqiofYRJUyUId+pBTguW6CxrVhfY/UioIc
         r/KiqWqptEVoX+ApwE7hDgUIqTs9IbHUEHaj7H8OCH6J9EcWcKv7GztIfVUXeV6QY6I8
         MdQ4ldlcagkOaxE5LkIZcm6PKl77Xdrt98HRqbvneMnQWlOpcrIlf9U78vS83araLisp
         nEVsVAwMlEHaqxiWMWKb7vWRaAdrirAle+jsuKkcA0M9oD4eKiVdPgXTXPa/5pApmE7P
         eMCw==
X-Forwarded-Encrypted: i=1; AJvYcCUM6klrwAMPbu/80xwhLWNYqNZHpSVSGkzHX9lfp/eP7bkaaLFycGv+4K7Wkirdg2IWKEXXNJOmr+0YLcc=@vger.kernel.org, AJvYcCXDUCcDx0VKpoeA9HqqnHy9DLIdNmRXaZ+zh3jvTb5zRP7MIqi2xa6GaCXNTOpy1VqUgr8XhyRK@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJ4fiKP6h8pz824Najb7Pi5tYUF710aUSIhN2q1zewjRVwnnL
	ODZ2779kpKHI4+1bPiAOGqPYmRVfaWFdjRinuBjXfPPdZYRQs2g=
X-Gm-Gg: ASbGnct38KpeSnAI7QrfF8TBkKNr2Y+qaecU5aqUaKChtamSF1mxsBUckU/2zHm02Mo
	OGiU+IbDsDD5OZWmF6WKnFSNOXfxzDXqCsmhQy4y84gfQ2w58tzC7ErdiFDlK1xtfifpK9cahXw
	z0TEBTGTxymEV2WwlzJCbEOKm0H8WiyRI6n3JPIRGb8e9tfFKVjB86CrD2Z7ApDntkpPbO6TmL9
	XsZDfxGZfhQ2NWqO6mfzvVGkNJ30yFeCOlujviDmOf7wiuvq4FrHKm2kTa8y4OJG6Zm8XIaxPbS
	z3aTlg2fNTa/wX7X+J8hYCfdiZPnygoQ
X-Google-Smtp-Source: AGHT+IENeznE6CJTR2fLBNOy6RH6tHtIphE3osuf7i44j/5yafZFKJ3qKvbBIkmyV2dxqEdNJUT1Cg==
X-Received: by 2002:a05:6000:184f:b0:385:ef97:78c with SMTP id ffacd0b85a97d-38880abfce5mr369370f8f.6.1734052735590;
        Thu, 12 Dec 2024 17:18:55 -0800 (PST)
Received: from [192.168.1.3] (p5b057a27.dip0.t-ipconnect.de. [91.5.122.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514e54sm5580671f8f.85.2024.12.12.17.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 17:18:53 -0800 (PST)
Message-ID: <399251c5-7e6c-4e9b-9203-a417074cd04e@googlemail.com>
Date: Fri, 13 Dec 2024 02:18:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144306.641051666@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.12.2024 um 15:52 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 466 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

