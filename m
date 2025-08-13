Return-Path: <stable+bounces-169312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CCBB23F1D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 05:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AEC7A3CEE
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 03:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24B1DF725;
	Wed, 13 Aug 2025 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h6ZM7L95"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38188462;
	Wed, 13 Aug 2025 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755056941; cv=none; b=c9Cp4pm3zWlEBONcEELYW2esgg2M2fEH11LQPbsRBepo6A7DjEYGxFKbv6qFGdeGk7qsetYfV5KdEa+45DuD8D1jXvA8bb30E3uzih+2gFpvfSllXyxQfVv68IXUNsqVgfSLtjUyQ6FPM8AZ9CFZ/CBwUi6pXNeHa4ZtTZPEZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755056941; c=relaxed/simple;
	bh=Bg9avpoQxIbrFvqx8zsIIQZpntrHIw9bRtBm1TxgJOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riQQrK/PH8O/TDXd3igrWbHSdGh/yemgmbn1YwMjXkBfSIJ3lTdZsQ2gSrijQOi4bZlv808LR/zl9S03AasUmxERGhCV0V+FRJR03zTRmBgN5+77yJtR1g/ka8Bt2XeKPQOGtbc8B77PAiqrRKMihFDR6Xat4I/eZb3jDrGezS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=h6ZM7L95; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so41195175e9.1;
        Tue, 12 Aug 2025 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755056938; x=1755661738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxMNsL+4yACXSz5SuyJHQH2P16mnqVfCD9Cumtuwkks=;
        b=h6ZM7L95sFj8sPM0st+PfHb+0pDS8SI++JFpoYXlNRlQfVmx+ltjQNzbYKXxz8GuzT
         KPkTgMxhQmKBpatflaXl0V1KfwNMuExw2j5iVR7i1YjPfWcvEilAesuiTxFB5sYTjAak
         bWaWbeBo3+woR5KCOp1papZJgdTERa5O+OsYkjyJd6L1+FUBoouL5/APNrQyRqho/3N8
         ywaCsoJXL7xFLgSH0qzGxRd6aCN8CNyk0lzsGAwDCMNaly5tr/fY0ICeMsjMb3JruKAJ
         M3szd/YrRBv/b4h/tLffMEP/QDGFaxoxo9XwhtvvqJVMP0gAF9xykfLdxE0JdfW6IeeH
         hPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755056938; x=1755661738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxMNsL+4yACXSz5SuyJHQH2P16mnqVfCD9Cumtuwkks=;
        b=SwyQ+PVsAZLmoqBYg+lsoPLAfhaY//frsB/Ekdf/zGzGrVdTuh4S8XVQ9up/rYCLiD
         xyP1hgBmGs2fynTkZDAq/o3xfQxe//oAxa/lR8P2EkW4O452ccY3kS40IR/S7agYhSbZ
         fTmuYq0PkQDyfPULDEFtFHu3/qtq44FR127vpvs0u2LUWjOKHGZlc6hQ/lQZijFuqh62
         wOe31lk08yYSBTEr+Jixhd/+lQEJNVmkeuWWYVzT6CuVcDIazf1f62L8GXDW94oGRSej
         MkfbIkPK5AMdrOqhvMXODztVQ/injdR971yOOz98AOitrO3Vvh5HqLjZ0ZEzoasEXQYe
         M69A==
X-Forwarded-Encrypted: i=1; AJvYcCWOvGir+XIoqkK5NogCLFHL/UOI/9CPvWnhgF3RNOQcLbWKuDtdZK39Sp30Eh7sBqY+VDA/30Je@vger.kernel.org, AJvYcCWa4lbNLGc5vGacfKkE8hXgdDazsD0AH8wJMQ8GefBRDa4TFGDy1qbzCvNig0pF8LCadcpXmc5DTq+BOQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8ENyRL5UVdBpwsSUtpDn2N3K0mb634XzsuIisBN3oXtPj6T8
	XM0ZKSVK7aR8RM2JJ4Eog9tIydVtqHBSH9Wm4Fv7QYzSHi4H/bcQJFU=
X-Gm-Gg: ASbGncumxsz3MfhmsPpwJ+QHl29NZ5ZLjQToIMsWD/BcQNuMnPM7GjqgvA2AekYR/X0
	LiNnZW+kqFcYcY58hkvjmInfi84ogFJRNJEHRKk8dxh3URFCrLBAjFs1O/yItnXB8a1K1jVd0sa
	XCqPFAw6VZt4Q3u5kVtSKteEY2wA/TdUL7f93a799wjqQU9AL9up5a5JL/CUWe2nX3Y2tk79MpN
	9L3510wXIAfNJCWuAt+TpypE7lz/++3Nl43pcKJUfXOf4LHGKY0S6V91SMF0sB3fKwH9M8WqY0b
	J41mKytsr7EG/fJqHXWe1CEkpFXliaClMiTiwJAFSyfxehmUx+uoxhEK+GPUuqnU7WgYk+P8oHQ
	olpA86wYVrgtLRKqEj5ba1OR3L/l2uNLCo3JGlpw3JRGUcnjumPiurUxDig2VvsMKZ9l0VmDBz/
	g=
X-Google-Smtp-Source: AGHT+IGMLnjEf9oNYKSS5e4bSrDnCy4R7EK9c5gk3ITwqZPReSbGC51U8AXCNFUeS6wUDL4GuW9YTQ==
X-Received: by 2002:a05:6000:4020:b0:3b6:17b5:413c with SMTP id ffacd0b85a97d-3b917eb3cbdmr598204f8f.39.1755056937812;
        Tue, 12 Aug 2025 20:48:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b48db.dip0.t-ipconnect.de. [91.43.72.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95desm45481257f8f.20.2025.08.12.20.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:48:56 -0700 (PDT)
Message-ID: <c4abe49a-c65f-4a67-8280-8e616bbd4b2f@googlemail.com>
Date: Wed, 13 Aug 2025 05:48:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250812174357.281828096@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.08.2025 um 19:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. Built with GCC 14.2 on Debian Trixie.
No dmesg oddities or regressions found. I did not see any of the Python warning messages here which I did see in the 
6.1.148-rc1 build.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

