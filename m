Return-Path: <stable+bounces-176442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF1B37529
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 01:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0686D360B87
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A92BDC2C;
	Tue, 26 Aug 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R6Az0ARi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522220296A;
	Tue, 26 Aug 2025 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249523; cv=none; b=aIRCnlDoLkiEIeaDaV8gl+/7u/gz4/htlQPLLP0x0MvPfxm9YJlQdb0T2PuiMCyKEyB9LY9uRDCARWbc2fvL1ugFLIpqJIjwHN3CeVcApdNqXfgO3Bjezp9JKlXl6Dw5zCNMpqMmcAESI1otO8mru36hi5plJ4gqLKQVBD7VUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249523; c=relaxed/simple;
	bh=Ntf1uv8iqeTVzpcpfPCUovUSPoRWsWezcHFAuAaDnQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slq3aKoxO37Nf3Yds6Y5mXAdHIFbgsEu7YeKc4l2+UVmjKj9VAYQfsdHPUfz8+sUYKp7pOSnLhCb9xyvcMJAdObzRjfx97dZhvW+EpIaYtWnQok77OL16lyGA/pIz/4nbMNga1ehcnzDm/h8VmcjiUq0tPsWw5ObCJ5YvwB5pAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=R6Az0ARi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3cb9268511bso599565f8f.0;
        Tue, 26 Aug 2025 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756249520; x=1756854320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZfSjh7i/ntcVqacdlAKOPl4pOi7bpW4S9RgH4BiaRA=;
        b=R6Az0ARi34nNxrMXyyvyLz+sSFld4z8n9Ml1aCKxY3Bqc22D4jh+UpE7TrdKiLTk4M
         tSEL1RcC5SGyGg0H/2E1Rmtr/pj6/PMVjKjbMcXTBlbGcztk+b8J8BVUGW14Oj+UYqZK
         px16gDjHlmEZkWs8Vn7cl6JCrBQ67bJk3SdICedUEx1KXbutX2F41vvdMHfpEgmQhLzE
         jaoPu69xIkqRBXOABFxRHLP8cnzUvbhIQl6MdvnhU5owek2nR6kI9Z3o5gm+7IhtS2cD
         mLM5Zr1R0t81FJYmObZKEe3gP5dgXZjZl7EYCtTeCQIOot0nykRcOYKVn9/RJW9GPVOU
         DenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756249520; x=1756854320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZfSjh7i/ntcVqacdlAKOPl4pOi7bpW4S9RgH4BiaRA=;
        b=Z9gWiZtHcWutcJPRLkmOseubxKxHao9IAKHeZ9XWUE3VaV5dH3+FkJDqiUAENzGNsE
         nNVH40Lyf4Y6lWFt8V3VilWykkrwnccg2x88150qs5ROajlvOwd6rnzfae4W4J9W4F3U
         jXSEcnr1s+vH61QFUF2Na3QuP/Nm25yjLI1GkwwmdSowLPRZtf290OycL7Q3O1QEJKfy
         piRT5ACtYmnm9t00125YpnKBbaN1W/WIA3FW5wdW0GCL+JnwbwOOUYsHJE7TyPqWGqin
         Y+7jnDpMwJxuhd1bs7Ejmd6udCXYkTcHJLep+BMpSzU4DDCDqPLK1J9Og1iVGLk3ZSwS
         ggJA==
X-Forwarded-Encrypted: i=1; AJvYcCW+tleVbYN8I6MbCY4NWrnpHgf1XCbYnxf44KasA9qg7SE4uvO46fhd5PovwRlPGrZTxRubtDlW@vger.kernel.org, AJvYcCXewezCUERTWKxylEXlijAdQ8iYtGnxDV9i69bT+6bK+Mm02bbg5yj2TVY90RODBpJaiZP0eqqlccHifno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtadXK+3RCYg0Riv9OOMVl+kSRrDOnlPp3hQ+0iF5jvSzuk9T
	WCRx6IBsdMLy9KqoTCzr8mJJXnDtzjtN9Y5ZWvhgpsJg4aAYsi531aY=
X-Gm-Gg: ASbGnctAzs6IkSXfsKFJWJ6ks/8CusSiV6ruiol0V6PRiaSa9nxp+wmefx3c5C5qWu+
	ApI4CQqqKQ0o8Ghfppc8vhQhUXQKS0E7ZWPrBycxtyIi/xtxmxtglvT+fO8skN/fd3o+zqtq0ot
	o/lTv1Wwm7wSVj7NOTI6v+BWNNwxRUEFRPS5eDaMoGAlXBQoLkwECn2ZfMJARCRrM27K3e/wD1i
	f0DKSc5c9MIYcm3FpTEo6qqVozLS8DKxUTpOto5AXn0qrtQzOvMYo59jOdpta0m13iTI+VZNLpW
	EjEJUcTDWg8ruyltfEzyVD1qonHn+qqc5D43xdzbhA8TiDPSIGAL6CbH4gbm8vPs2RFUhDvd2yt
	JhEcb+vGCKQRKUIVQqEUk6RLDQNlHQMlbijRa2kkDvgrZPe5msnAddjk/RG4z7PBqomimVHEGUg
	==
X-Google-Smtp-Source: AGHT+IHlfoH3zm/dopGG45e2eJiSTjBOdFRANpue/GnxzPD0rcQZdRsEs1ifItNI1iZFFELob93y4Q==
X-Received: by 2002:a05:6000:3105:b0:3b9:10c5:bd7d with SMTP id ffacd0b85a97d-3c5da83a6b8mr13874103f8f.10.1756249520171;
        Tue, 26 Aug 2025 16:05:20 -0700 (PDT)
Received: from [192.168.1.3] (p5b057219.dip0.t-ipconnect.de. [91.5.114.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba078sm19710659f8f.4.2025.08.26.16.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 16:05:19 -0700 (PDT)
Message-ID: <7f7b9d4b-ff17-4efc-bc93-699bb417c925@googlemail.com>
Date: Wed, 27 Aug 2025 01:05:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110937.289866482@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.08.2025 um 13:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
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

