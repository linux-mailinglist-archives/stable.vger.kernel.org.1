Return-Path: <stable+bounces-187781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B74BEC4F2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26083BACA8
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE6212554;
	Sat, 18 Oct 2025 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QkCugHjA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE121F419A
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760753040; cv=none; b=YhzsqD7X32djoQZeT7pa3LeKgdkxkCTaO8iHDbBX7Kgn/KLpkMuxUwAFdE/RangJ2t4exC7X/PmL/QFfRyCETCfBRszhxcKMfBknYSaXlz8p00Ezg7kVXHMwrqORckNNrz9g5c+5DStWGiC1Udg+DYDO66BQREZXE2ik1uZd934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760753040; c=relaxed/simple;
	bh=9QaYv7+eLxmlZymzm9dDED5562G0eINYVtnrbZbU4q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rr6zrnR9CJjsJGdN3ININM7ygAvlOhevqdXc4sum65vSvC+2WLRWVQOo8O9G/D3ZxTtFfTv99qTvZGuwx4VOoOrPZaZvKxRU6HjqiDN05wNwfJsIiHkrxs+zcEq635eg+0l5bCyk2EolHNGPVabE8pB3+7x7cvBcqy8aTojBwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QkCugHjA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ece1102998so1942844f8f.2
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 19:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760753037; x=1761357837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xc59SxJSZGImXKCMLgUW84zLp4qIeFDtzUIiilJXAVs=;
        b=QkCugHjAArQn+oafG3PN6UzBR2iwy+Xj0aWSUqo85w4mCzv6BxEoN+Rs2vmrofs6/j
         T2sXXiirgouSIfBXteF12vfbjnJ3aBrzvYvrcgg9YFgis2zDpPSvJfG58khVNyGNspOd
         l6GluItziSmQkwQSGLcWQQG+aBR+fu/wEt3Y8WuhsdsBXya9PFZsgmu07qM8xzmgABiE
         Am9HkpNvdwOwj6Efs6AyLAosJje42zqWfZopfESrAQGol/dI7FSQPnmA+lToc17Y0WCC
         ZXwLaOjwcooAxOt9xoso9JqHZLYdFFMNZ4/I9NXvFRrxK4HIGQqhd9pVRlwe3UfJ2x26
         PWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760753037; x=1761357837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc59SxJSZGImXKCMLgUW84zLp4qIeFDtzUIiilJXAVs=;
        b=gulR70XtCEojraA7wgqEA1zjHGNDKre0TIAKw056NhVuJuvAby4FoFtT7kxoiGGrdb
         UcsxAcvJjuTXortgChWoE6E/7g4r/2sZ+4fSRDvPhpftYPeo8PjZoqwP7XgIzcvYAkOL
         K3YBmaozFJu9a1Wbqqv73XCgZfZ4C9D4/kyKIkMOJKxVg22MfXYRjIviOQ5QiwtjiHhf
         YL/g4n/WSVIaoh/KoA2L0CtFJlrClrgnU+xEMownRLk8657sHiThsmjJoNNnA48rn9pu
         nPAUFBNA69QTvATl1rs3VhQxgcavvIHSa56Q7lioubMWrMuZQ+48TrLftsTS+WhI4xwA
         Gjlg==
X-Forwarded-Encrypted: i=1; AJvYcCWYOcn1+vZBfcZQk/W3aEQ4NHBZ3+WWTy6ogslVO9srray9HT3kf/r2+mLzQ+hif3GkdmFVetk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTyVJDXIiJfCH6VykfaLOaQgTGdNLHV9GXGid2cVn5pxve/MwQ
	0u0eg+X5BWixCMebOBSwJ+uU1YTSe/9WT5U/CeNBsmw+6VpSTbqtNEE=
X-Gm-Gg: ASbGncumMsPM0Zfgdp3W3U6V7EOJNPWTb2wygb1weqtUfZdIBD8Czb7k7XsFVA9Hz0P
	9fnoAqvcxVSWd6sB6nFH0JAK+rl8jcruqg0L4G+/DTbrcW7fBlEg6sZhMGoBXtbE3DNATec5v+V
	3aEMkCE/c7Ei4D8VdoaQHsQa12ucVaX1RPZ6T9qdzqlv/O/3Ap8yQyJLvUYWQCKv5CJHz3+T2gd
	b/sgxfVxtPz4CijiNUQ+vE3qz83wKTlxs9QkjxrPJhaE15XPS5whfCFeSDycUM5/vk/ax0DP0fZ
	/8wqcZCxCs9x4Wm+75DDLMVyGFbHGLRmid4buOEkaiQwCYkkA1ByWIT4Rsn3IadnpdYbj4MbTzZ
	MfQRI4b6Nah3kkQGUSOCkDFM2vQVWMwI2062BrmGG2td55XkhFGaTLQbCz5muC+vbeFtTKKRc4b
	Hd7g4aAVCb5k49mKJBzrFhJwyuU6xUnQwhLe47IVCNE+LOZGCkDcsoB4skV4AyqT0=
X-Google-Smtp-Source: AGHT+IEdZrPytaqi4hsbKrC4Mclfmgk8aPsP0EiVqGb4uh1/ZCwHou20C/wosOjacHYe/E03wW1x7g==
X-Received: by 2002:a05:600c:3b05:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47117874689mr44730065e9.7.1760753037144;
        Fri, 17 Oct 2025 19:03:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b488a.dip0.t-ipconnect.de. [91.43.72.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152b42911sm20918505e9.8.2025.10.17.19.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 19:03:56 -0700 (PDT)
Message-ID: <a8f56754-ec53-43fa-b4c3-d1db97e68221@googlemail.com>
Date: Sat, 18 Oct 2025 04:03:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/168] 6.1.157-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145129.000176255@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2025 um 16:51 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.157 release.
> There are 168 patches in this series, all will be posted as a response
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

