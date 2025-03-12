Return-Path: <stable+bounces-124113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339AFA5D3B6
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CB23B371D
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 00:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A56282ED;
	Wed, 12 Mar 2025 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Btob8UYq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B72182D7;
	Wed, 12 Mar 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741739127; cv=none; b=EF8OPiUprrg5XKhfyQcXYQuadL2BMfjsRgrjeTHSg+sQgE1F3Koppa1/hezvHJhwY+dO5O1QZzaKW9cnqZBXfQEwrnVU3vcDKNr4czXwoBYzEVFcCk3VCqjj9znziipARbnkjfYSit6MAS5z0tLJgCcN4U6bx92B/Od5ZT9UFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741739127; c=relaxed/simple;
	bh=UiKXXbItb8ZucoRjpfS0B0zXM0/NLaQWlMZR8g6m81A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptE7lXR5kD2898xKj2ow8i7DbkhFFI+6Y+13xt3vqyH8jCsfYz1btqjJForBw+y9YjB7jaRuMAQBux4GDFIY7cDoUHwegU8SYgsInsBNkkobQhhtUUghi+Gg1Z7EtueFinNwoOS4BiSUsnN6AQUVftoD4+XFbEw46XhLY2qh7y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Btob8UYq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913d45a148so2543649f8f.3;
        Tue, 11 Mar 2025 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741739124; x=1742343924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRO5PYHQhqGm3Ej2KRsU47wjnN58fQqLtAauhVx1rUc=;
        b=Btob8UYqlHars7T7A4EnOYNe9ryGzF3+m1m0rgMhPCPwZgsaqWzp6wo6+mS1WKv83F
         Wj8Z1C7QR5xxASobbnpzWLJXi1GCJlIklSyYoSec7aHn6BuL73b5h9Vmkag2H7Cf8yqn
         ZpXDdRaergGCrs/I8uh0IPb+bov7Z7efKMuG/7h0ISww+HzJYV019zt1YvSPnOynBz4A
         qe9nNrNiaNmQ75DgIpRig0b99qT2qWdVoPinE0vK9khva/vdNNfq7FGoZUXBxu1jl2q+
         oh0gGlmoIxrjQtXwoxXpeUqmWDKUVtLcwCh+xV5Wc/XMRi36twse6uy4SYP6r7OeBElq
         XWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741739124; x=1742343924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRO5PYHQhqGm3Ej2KRsU47wjnN58fQqLtAauhVx1rUc=;
        b=VJNNRTWTxhN8eop6fmUIrBndlsWDwKdF5LQ1/ymmwFgQZUtb6z3b1SCUjsFpsXL/6Z
         Y01D6g3tSPDA93iCXiRkWqZc337IU6y7tkMYM6pVuqC57FzyAMLefQT11cUbrOr12kcP
         Beyp6Y0MW94F8raSH0/x6GEyQfVns4u9jbqYyanKWJuJvsPOTR5n9gATLLRjdmDhOYeE
         g8gHRwHX5Nsu3trSHNwVj8QH1x1QWrk5swyE/ShqwnnrzBHKpNXow1exRRg2jW22UO8d
         bderIWyrBDIiveZFsdBD17a39csfedBFjnFCE3aMDHnyX2Nrsze0+nm3Rl3kGfH3A/B3
         jUvA==
X-Forwarded-Encrypted: i=1; AJvYcCVV11FYxFDlbXTLth9PRLaoaxG99AHKZRzMNTdU3YMDNLQPbhySFF8zV3J1WnxKHFNIHDumXmh5yUlNroE=@vger.kernel.org, AJvYcCWLB710sgNYzZjZ39grC6nKeBv5yLLzwGCXbpjb4bWDBNnXkblhd1/AOeMws55c+J3lpQLeRdl1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw626VOlaGrEjSW/Fu55Hz3LEIWoNth+z5IvFSSODVLwS+Gfke2
	ZQO2fLynb6uEDMWo8zKDBpOHXris51+yJ/7HlxmK5WjkQA3P2KySpdpd
X-Gm-Gg: ASbGnctIVnXsAEfAjUBVsE9/Lm2WVTzqMGF/gBx5kCLGWvcewFxqSaxu09jGOMAU6AO
	SkN4Psn/dK5zaHPV0s8u/abDsXlhNnbOEOy7VI4oe6BFlB1Noa86ci1OnGJEhu5gVyfOUcBHzRQ
	OWFYkc7VaFauR9o2RyemB6pnVY0BY7RlRdYf7b+0A7EW8W2xJ357NFGYrQxfmnAei2EAgQFU1Vu
	XQu01uBGRQyXtUWA7rBdlDwrMn7uZ+96kmlhw1aWkge59tA/Xz53DUvucN2wAytNBqHdKhQcsyL
	ryWymfN5mL9cYg57jQ9YPh4Hz97JvgfRn7O2IBv4y8WowJhCovcglwVzKvdWck2YrGDx+Fq/X+v
	BMLJqHvFZb9FpZMSyThwQzlhD8AN/CQAN
X-Google-Smtp-Source: AGHT+IHS1c7L9ZauVsfcZ8jPR2htutvRPZQItfsPQewiI6FF6kUSgi8bmLezXCGdatLWjLp2g4pESQ==
X-Received: by 2002:a05:6000:402a:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-39132db8f39mr16870733f8f.50.1741739124413;
        Tue, 11 Mar 2025 17:25:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b05767c.dip0.t-ipconnect.de. [91.5.118.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74d51esm4633055e9.16.2025.03.11.17.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 17:25:23 -0700 (PDT)
Message-ID: <e91d9294-8e4b-469e-9fc5-1570b1aefa5b@googlemail.com>
Date: Wed, 12 Mar 2025 01:25:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311144241.070217339@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.03.2025 um 15:48 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 197 patches in this series, all will be posted as a response
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

