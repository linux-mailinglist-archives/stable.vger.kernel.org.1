Return-Path: <stable+bounces-110067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32349A1864D
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BACB3A82B1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2971F7903;
	Tue, 21 Jan 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bXtPrfgA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA81F78E1;
	Tue, 21 Jan 2025 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737493080; cv=none; b=G7Dwxcc0MNzB3LsxT5p+42z1FKBSRIBVo1AbtlrYrdKNYSwrnU1yatAs+I0gW2mr//u2l2JbmW0h16bhQCkAJoyFT4kmvbSDuaAThXUpu+z3UraUBNol+pfa/6GlB+igNBGZkAddlB2FxYSf0HJFuk/7w+e2PFbjGwedtUgzbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737493080; c=relaxed/simple;
	bh=SH/w0jOyRPpsaM8zNIAVDam3A+/lLDTDWd2AYPXaqgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGK9bTOxqZSaRwBrVk+J+g1HOS4IaKJx1B1+RUI+EhuLN/PMecLWYaDAOrThTRKMBuFYIecYMdfIFxVTwwzgR44XTGd2PlLF4ZAMgLSAgSuyLX2o1WmXXJSo3h5YMXuEAYa63O1o2xYbNTtvCBCuBkhVu1Blkz+ocHKrfeRwuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bXtPrfgA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d161947so3324115f8f.3;
        Tue, 21 Jan 2025 12:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1737493077; x=1738097877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DPeCcR/7ArujyerM9ik1ffW0lRE5V+zebUQdO2wq7U=;
        b=bXtPrfgA1xo7LnwIrgvkfDIcKzVkMM8xZBfVmdfzccsgbLIkv9xHypWsMjK/v31KBG
         X/KEOZCuD+/u/XRTIjiEld083uas1t2bz4Sg0Uhk5WsumzY3xTM8CYX+sC1+0TgaCSoT
         8mEp8qlDSv12yhLB5A3kps+VJyo2A2ua27kzDvlnu7b7SLXUcyqEV3AccsVbveqkZuhf
         tBTnt48/8SDw35WTn2fUXO8lOKGFJ2vK75n6uTcqdyfjjgdbZH2il3MmLySYxZ4myovf
         V8OUxK0zGKAQ7rKtBhwpaz1m8aqyxTnsaaDPlIadVwcJ1GNXvm+hLkGtkdJUBzJ9rPxF
         Kq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737493077; x=1738097877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DPeCcR/7ArujyerM9ik1ffW0lRE5V+zebUQdO2wq7U=;
        b=V90olGYVploPutZIFPE6m39NH8R8pfpEUdv+ahZ4HggJqM8A5ik9OvXToFAjohSwMY
         xYkvt0S30QJW+U7ADJXJnMvMjOTn13oqKOlMfd/9tRAUs9MSax4yeVbd4QTCQRwWMpZS
         nirFUDCg9mlzOgyaoSLkoXHqIYXF55TNzmsHFtkfUuuepLSGo2qv00CjsI6ELB4bNWvI
         QvwkhYcDARh5QawMQmHPuzal0f17E68vnvDiJcUMN0CHBuk9GE6x//ANf9f+D1g8lKoK
         zfCLsdrcKNU1RWR0JYKh/1pIhApRB8vt9CQvLPEDw8VouViCb1Xz5MLFJMKGQYh2yCln
         EuDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUauGbxzRupsO0kZqXjOPgolaUxna67LJGGgVts0WMHLASGywywgHTzHPnGHusEVOgyszidUMAopEaoAXE=@vger.kernel.org, AJvYcCWd1w/RKDgdKN96bzxlyr5jTEjKyLcoVP7534PNSy/cfIDoucWdpDhD778dPWhITbqZ0OooF9tA@vger.kernel.org
X-Gm-Message-State: AOJu0YzxV9c2YlanLT1NEdtI/PYOux9UXoZGfggHJXfELdvA+rEIZrXK
	9bE3MwEAYuWslQfhLiMPa/kyWNRMQ/PJ1nnuJd4YQjPzXsQk+5c=
X-Gm-Gg: ASbGncvFfh4iItQn2mPDw2DCUz7zTUC/VH/LQZSS77/2wCJIJjofoGitVsUCqfVgMpc
	jY8Co9p+TKWY0PfM8oJNxPf26eEbuewM8vLNZvd4uaR9sx55w7yQr+9XwP9JC0sK/cqzroW96C/
	Knyea9xPT9Dud/yfR5Pb1Egr58qH4l7BwU5tC0YKuTJ8xhweiDx9sZ0WahyT70pgV+KgPOGwglb
	lvb0a6fE7luPi/U50tlQCKvcX5wy9vAVYnRvg7qb9SesiHCZ+qZeC9u/E/9pVgloONUrUF28dyk
	wmejfEO7jO85go/Slg5DfgDQBFwMmpVXDhY1kcVPDywpuDE=
X-Google-Smtp-Source: AGHT+IFFi7Ca+tEzLoWs9MyM0STBlK5ZFJnqyvw/1itpkl7SgZc0PRXiUBycONOCl1uSI20zaWDc6w==
X-Received: by 2002:a05:6000:1a85:b0:38b:ef22:d8c3 with SMTP id ffacd0b85a97d-38bf57a69b4mr18330242f8f.35.1737493076753;
        Tue, 21 Jan 2025 12:57:56 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac60b.dip0.t-ipconnect.de. [91.42.198.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322aab8sm14565637f8f.57.2025.01.21.12.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 12:57:55 -0800 (PST)
Message-ID: <7b50102b-64de-49e0-9b00-bb3bba613a21@googlemail.com>
Date: Tue, 21 Jan 2025 21:57:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250121174532.991109301@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.01.2025 um 18:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 122 patches in this series, all will be posted as a response
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

